# my dotfiles
```sh
./install_software.sh
./install_symlinks.sh
```

## ./install_software.sh
this will install:
* with apt
    * build-essential
    * ninja-build
    * cmake
    * zsh
    * neofetch
    * tmux
    * direnv
    * python3-pip
    * python3-venv
    * python3-argcomplete
* other
    * miniforge3
        * ~conda~, **mamba**
    * fzf
        * amazing
        * https://github.com/junegunn/fzf
    * cargo (rust)
        * https://rust-lang.org/tools/install/
        * https://doc.rust-lang.org/book/ch01-01-installation.html
    * zoxide
        * also amazing
        * https://github.com/ajeetdsouza/zoxide
        * **you dont need to use zsh to use zoxide!!!!!**
    * oh-my-zsh
        * we've talked about this

## ./install_symlinks.sh
this creates symlinks between all the files in this repo and their correct
locations in the home directory.

when adding files, you must manually add then to this script. im sorry in
advance.
