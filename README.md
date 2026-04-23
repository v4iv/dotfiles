# My Dotfiles

> A consolidated collection of all my shell and application configuration files for a consistent and portable developer experience.

## Instructions

- Install `brew`
  - ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
  - to uninstall
    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    ```
  - install formulas

    ```
    brew install bat btop cmatrix eza fd fzf gcc luarocks make neovim nmap \
    nvm openjdk bun reattach-to-user-namespace \
    ripgrep sl stow tmux tree tree-sitter-cli wget zoxide
    ```

  - and casks

    ```
    brew install --cask font-jetbrains-mono-nerd-font
    ```

- Install `metasploit`
  - ```
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
     chmod 755 msfinstall && \
     ./msfinstall
    ```
  - to update
    ```
    sudo msfupdate
    ```
  - To uninstall
    ```
    sudo msfremove
    ```
- Clone `tmux-plugin-manager`
  - ```
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```
- Install `oh my zsh`
  - ```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```
  - or `sh -c "$(curl -fsSL https://install.ohmyz.sh/)"`
  - to uninstall
    `uninstall_oh_my_zsh`
- Clone `powerlevel10k`
  - ```
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git " ${ZSH_CUSTOM:-$ HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    ```
  - to update
    ```
    git -C " ${ZSH_CUSTOM:-$ HOME/.oh-my-zsh/custom}/themes/powerlevel10k" pull
    ```
  - to uninstall
    - Remove all references to "p10k" from `~/.zshrc`. You might have this snippet at the top:
      ```
      if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
      fi
      ```
      And this at the bottom:
      ```
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      ```
    - Remove all references to "powerlevel10k" from `~/.zshrc`, `~/.zpreztorc` and `~/.zimrc`
    - Verify that all references to "p10k" and "powerlevel10k" are gone from `~/.zshrc`, `~/.zpreztorc` and `~/.zimrc`.
      ```
      grep -E 'p10k|powerlevel10k' ~/.zshrc ~/.zpreztorc ~/.zimrc 2>/dev/null
      ```
      If this command produces output, there are still references to "p10k" or "powerlevel10k". You need to remove them.
    - Delete Powerlevel10k configuration file.
      ```
      rm -f ~/.p10k.zsh
      ```
    - Delete Powerlevel10k source files.
      - `rm -rf -- " ${ZSH_CUSTOM:-$ HOME/.oh-my-zsh/custom}/themes/powerlevel10k"`
    - Restart Zsh. [Do not use `source ~/.zshrc`](https://github.com/romkatv/powerlevel10k#weird-things-happen-after-typing-source-zshrc).
    - Delete Powerlevel10k cache files.
      ```
      rm -rf -- "${XDG_CACHE_HOME:-$HOME/.cache}"/p10k-*(N) "${XDG_CACHE_HOME:-$HOME/.cache}"/gitstatus
      ```
- Clone `dotfiles` repository in your `$HOME`
  - ```
    git clone https://github.com/v4iv/dotfiles.git
    ```
  - make sure to have a `.stow-global-ignore` file in `$HOME`
    ```
    \.DS_Store
    \.gitignore
    README.md
    ```
  - cd/z into dotfiles directory
    ```
    z ~/dotfiles
    ```
  - run
    ```
    stow .
    ```
  - rebuild `bat` cache
    ```
    bat cache --build
    ```

  - reload tmux from `$HOME`
    ```
    tmux source ~/.tmux.conf
    ```
  - reload `.zshrc`
    ```
    source ~/.zshrc
    ```

## Other CLI tools to consider

- TheFuck
- Yazi
- Yabai
