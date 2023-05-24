#!/bin/bash

# update the system
sudo pacman -Syu

# add some stuff to path, since we are trying to use .bin
export PATH=~/.bin:$PATH
export PATH=~/.bin/.local:$PATH
export PATH=~/.bin/.local/bin:$PATH

# make sure some needed packages is installed
sudo pacman --noconfirm --needed -S base-devel git

# clone the git repo
git clone --recurse-submodules https://github.com/dru26/dotfiles.git ~/dotfiles

# install aura
git clone https://aur.archlinux.org/aura-bin.git ~/.bin/aura-bin
(cd ~/.bin/aura-bin && makepkg)
aurapkg=$(ls ~/.bin/aura-bin | grep "aura-bin") 
(cd ~/.bin/aura-bin && sudo pacman --noconfirm -U $aurapkg)

# make the font dir
[ -d /usr/local/share/fonts ] && echo "directory /usr/.../fonts already exists!" || sudo mkdir -p /usr/local/share/fonts
[ -d /usr/local/share/fonts/otf ] && echo "directory /usr/.../fonts/otf already exists!" || sudo mkdir -p /usr/local/share/fonts/otf
[ -d /usr/local/share/fonts/ttf ] && echo "directory /usr/.../fonts/ttf already exists!" || sudo mkdir -p /usr/local/share/fonts/ttf

# read the toml config and execute its instructions
line=""
mode=0
while IFS= read -r line; do
	# ignore comments and blank lines
	if [[ "${line}" == \#* ]] || [[ "${line}" == "" ]]; then continue; fi

	# remove any leading/trailing whitespace and comments
	line="$(echo "${line}" | awk '{sub(/#.*$/,"")}1')"
	line="$(echo "${line}" | awk '{$1=$1};1')"
	
	# check what mode we are in
	if [[ "${line}" == \[* ]]; then
		if [[ "${line}" == "[dotfiles.submodules]" ]]; then mode=1; fi
		if [[ "${line}" == "[environment]" ]]; then mode=2; fi
		if [[ "${line}" == "[sys.packages]" ]]; then mode=3; fi
		if [[ "${line}" == "[sys.aur]" ]]; then mode=4; fi
		if [[ "${line}" == "[git]" ]]; then mode=5; fi
		if [[ "${line}" == "[install.sh]" ]]; then mode=6; fi
		if [[ "${line}" == "[sys.dir]" ]]; then mode=7; fi
		if [[ "${line}" == "[sys.fonts]" ]]; then mode=8; fi
		if [[ "${line}" == "[commands]" ]]; then mode=9; fi
		continue
	fi
	
	# copy the submodules into the proper spot for later
	if [ $mode == 1 ]; then
		dir="${HOME}/dotfiles/${line}/."
		echo "moved '${dir}' to '~/dotfiles/.dotfiles/'"
		continue
		
		cp -a $dir '${HOME}/dofiles/.dotfiles/'
		rm dotfiles/*.md
		rm dotfiles/.git*
	fi
	# add some env variables
	if [ $mode == 2 ]; then
		cmd="export ${line}"
		eval $cmd
		echo $cmd
	fi
	# install the normal pacman packages
	if [ $mode == 3 ]; then
		old_home=$HOME
		export HOME="${HOME}/.bin"
		sudo aura --noconfirm --needed -Sq $line
		export HOME="${old_home}"
		#echo $line
	fi
	# install the AUR packages
	if [ $mode == 4 ]; then
		old_home=$HOME
		export HOME="${HOME}/.bin"
		sudo aura --noconfirm --needed -Aq $line
		export HOME="${old_home}"
		#echo $line
	fi
	# clone git repos
	if [ $mode == 5 ]; then
		url=$(echo $line | awk '{print $1}')
		dir=$(echo $line | awk '{print $2}')
		(cd ~/.bin && git clone "https://github.com/${url}" $dir)
	fi
	# run *.sh files from the internet (change the home dir so they install in .bin)
	if [ $mode == 6 ]; then
		cmd=$(echo $line | awk '{print $1}')
		url=$(echo $line | awk '{print $2}')
		old_home=$HOME
		export HOME="${HOME}/.bin"
		if  [[ "${cmd}" == "sh" ]]; then
			(cd ~ && sh -c "$(curl -fsSL https://raw.github.com/${url})")
		fi
		if  [[ "${cmd}" == "bash" ]]; then
			(cd ~ && bash -c "$(curl -fsSL https://raw.github.com/${url})")
		fi
		export HOME="${old_home}"
	fi
	# make the directories 
	if [ $mode == 7 ]; then
		dir="${HOME}/${line}"
		[ -d $dir ] && echo "directory ${dir} already exists!" || mkdir -p $dir
	fi
	# install fonts
	if [ $mode == 8 ]; then
		url=$(echo $line | awk '{print $1}')
		name=$(echo $line | awk '{print $2}')
		fmt=$(echo ${url} | grep -o "...$")
		dir="/usr/local/share/fonts/${fmt}/${name}"
		[ -d $dir ] && echo "directory ${dir} already exists!" || sudo mkdir -p $dir
		echo "installed font '${name}'"
	fi
	# run some extra commands as is
	if [ $mode == 9 ]; then
		eval $line
	fi
done < ~/dotfiles/config.toml


# copy the dotfiles to ~/
cp -rp $HOME/dotfiles/.dotfiles/ $HOME

# resource bashrc
source ~/.bashrc
