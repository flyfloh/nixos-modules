{ config, pkgs, ... }:

{
  manual.manpages.enable = false;
  home.stateVersion = "20.09";

  programs.zsh = {
    enable = true;
    initExtra = ''
      . $HOME/.nix-profile/etc/profile.d/nix.sh
      eval "$(direnv hook zsh)"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "man" "common-aliases" "sudo" "fancy-ctrl-z" ];
      theme = "agnoster";
    };
    shellAliases = {
      gis = "git status --short";
      m = "make -j";
      m1 = "make";
      mc = "make clean";
      mpwd = "pwgen -sy -N1 32";
      od = "objdump -lSd -Mintel";
      zshrc = "vim ~/.config/nixpkgs/home.nix";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    aliases = {
      aa = "add .";
      au = "add -u";
      cb = "checkout -b";
      cm = "commit -m";
      co = "checkout";
      cp = "cherry-pick";
      ct = "checkout --track";
      fo = "fetch origin";
      fu = "fetch upstream";
      ldiff = "log -p --pretty=fuller --abbrev-commit --stat";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an> %Creset' --abbrev-commit";
      puh = "push -u origin HEAD";
      psuh = "push";
      rco = "reset HEAD~1";
      rebasi = "rebase -i";
      rem = "rebase -i --autosquash upstream/master";
      up = "pull --rebase";
    };
    extraConfig = { core = { editor = "vim"; }; };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "screen-256color";
    historyLimit = 10000;
    extraConfig = ''
      # unbind default prefix and set it to ctrl-a
      #unbind C-b
      #set -g prefix C-a
      #bind C-a send-prefix

      # make delay shorter
      set -sg escape-time 0

      #### key bindings ####

      # reload config file
      bind r source-file ~/.tmux.conf \; display ".tmux.conf reloaded!"

      # quickly open a new window
      bind N new-window

      # synchronize all panes in a window
      bind y setw synchronize-panes

      # pane movement shortcuts (same as vim)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # use | and _ for splits
      unbind %
      bind | split-pane -h
      unbind \"
      bind _ split-pane

      # resize shortcuts
      bind C-h resize-pane -L 10
      bind C-l resize-pane -R 10

      # enable mouse support for switching panes/windows
      # set -g mouse-utf8 on
      set -g mouse on

      #### copy mode : vim ####
      # set vi mode for copy mode
      setw -g mode-keys vi

      # copy mode using 'Esc'
      unbind [
      bind Escape copy-mode

      # start selection with 'space' and copy using 'y'
      # bind -t vi-copy 'y' copy-selection

      # paste using 'p'
      unbind p
      bind p paste-buffer
    '';
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
                ack-vim
                command-t
                fugitive
                fzfWrapper
                fzf-vim
                snipmate
                The_NERD_tree
                vim-airline
                vim-coffee-script
                vim-colors-solarized
                vim-elixir
                vim-gitgutter
                vim-markdown
                vim-nix
                vim-orgmode
                vim-snippets
                vim-tmux-navigator
                vim-trailing-whitespace
                YouCompleteMe
              ];
                # "funcoo.vim"
                # "greper.vim"
                # "minibufexpl.vim"
                # "vim-git"

    settings = {
      background = "light";
      history = 1000;
      ignorecase = true;
      number = true;
      smartcase = true;
    };
    extraConfig = ''
      set nocompatible               " Be iMproved
      set encoding=utf-8
      set rtp+=/usr/local/opt/fzf

      " Make sure all markdown files have the correct filetype set
      au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
      au BufRead,BufNewFile *.{rs} setf rust
      au BufRead,BufNewFile *.nix setf nix

      set t_Co=256 " 256 colors in terminal

      set nobackup noswapfile
      set updatetime=250

      " Handle Tab correctly(tm)
      set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
      autocmd filetype c,cpp,asm,markdown,python,rust setlocal shiftwidth=4 tabstop=4 softtabstop=4
      autocmd FileType make setlocal noexpandtab

      set autochdir

      noremap <Down> <NOP>
      noremap <Up> <NOP>
      noremap <Left> <NOP>
      noremap <Right> <NOP>

      inoremap hh <ESC>
      set pastetoggle=<F2>

      noremap Q <NOP>

      set incsearch
      set showmatch
      set hlsearch

      nnoremap <leader><space> :noh<cr>
      nnoremap <leader>w :FixWhitespace<cr>
      nnoremap <leader>jd :YcmCompleter GoTo<CR>
      nnoremap <leader>m :!make<cr>
      nnoremap <leader>j Xi<cr><ESC>

      " Format paragarphs
      nnoremap <leader>fo gqip<cr>

      nmap <leader>b :Buffers<cr>
      nmap <leader>f :GFiles<cr>
      nmap <leader>F :Files<cr>
      nmap <leader>/ :Rg<Space>

      " Reload our .vimrc
      nmap <leader>~ :source ~/.vimrc<CR>:redraw!<CR>:AirlineRefresh<CR>:echo "~/.vimrc reloaded!"<CR>

      " Quick C++ filetype
      nmap <leader>c :set ft=cpp<cr>

      " Fugitive mappings
      nmap <leader>gs :Gstatus<cr>
      nmap <leader>gc :Gcommit<cr>
      nmap <leader>gd :Gdiff<cr>
      nmap <leader>gp :Git push<cr>

      " enable spell checking on certain files
      autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell

      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      nnoremap ; :

      nnoremap Y y$

      let &colorcolumn='80,120'
      highlight ColorColumn ctermbg=146 guibg=#2c2d27

      set scrolloff=8
      set cursorline

      set laststatus=2
      set statusline=
      set statusline+=%<                       " cut at start
      set statusline+=%2*[%n%H%M%R%W]%*        " buffer number, and flags
      set statusline+=%-40f                    " relative path
      set statusline+=%{fugitive#statusline()}
      set statusline+=%=                        " seperate between right- and left-aligned
      set statusline+=%1*%y%*%*                " file type
      set statusline+=%10((%l,%c/%L)%)            " line and column
      set statusline+=%P                        " percentage of file

      " MiniBufExpl Colors
      hi MBEVisibleActive guifg=#A6DB29 guibg=fg
      hi MBEVisibleChangedActive guifg=#F1266F guibg=fg
      hi MBEVisibleChanged guifg=#F1266F guibg=fg
      hi MBEVisibleNormal guifg=#5DC2D6 guibg=fg
      hi MBEChanged guifg=#CD5907 guibg=fg
      hi MBENormal guifg=#808080 guibg=fg

      " use vim as hexeditor
      map <Leader>hon :%!xxd<CR>
      map <Leader>hof :%!xxd -r<CR>

      " nice man pages
      runtime ftplugin/man.vim
      nnoremap <silent>K :<C-U>exe "Man" v:count "<cword>"<CR>

      " solarized
      syntax enable
      colorscheme solarized

      "NerdTree
      map <C-n> :NERDTreeToggle<CR>
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
