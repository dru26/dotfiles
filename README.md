# dotfiles
 
We first install git, download the install file, and install:

```sudo pacman -S git -y | https://github.com/dru26/dotfiles.git | bash install.sh | rm install.sh```

Then install this repo with [submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

```git clone --recurse-submodules https://github.com/dru26/dotfiles.git```