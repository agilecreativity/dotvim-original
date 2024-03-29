" file: ~/.vim/autocmds.vim {{{
if has("autocmd")
  " JSON file {{{
  aug filetype_json
    au!
    au BufRead,BufNewFile *.json set filetype=json
  aug END
  " }}}

  " Haskell file {{{
  aug filetype_haskell
    au!
    au BufRead,BufNewFile *.hs set filetype=haskell
  aug END
  " }}}

  " CoffeeScript file {{{
  aug filetype_coffee
    au!
    au BufRead,BufNewFile *.coffee set filetype=coffee
  aug END
  " }}}

  " Apple's Swift file {{{
  aug filetype_swift
    au!
    au BufRead,BufNewFile *.swift set filetype=swift
  aug END
  " }}}

  " Go file {{{
  aug filetype_go
    au!
    au BufWritePre *.go :GoImports
    au BufRead,BufNewFile *.go set filetype=go
    au FileType go setl ts=4 sw=4 sts=4 et
  aug END
  " }}}

  " vimscript file {{{
  aug filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
  aug END
  " }}}

  " text file {{{
  aug filetype_txt
    au!
    " When loading text files, wrap them and don't split up words
    au BufNewFile,BufRead *.txt setlocal wrap
    au BufNewFile,BufRead *.txt setlocal lbr
    au BufNewFile,BufRead *.txt setlocal nolist
    au FileType text            setlocal textwidth=78
  aug END
  " }}}

  " markdown file {{{
  aug filetype_markdown
    au!
    au BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown
    " No wrap when I insert long [link](http://some-long-link-url/.../)
    au Bufread,BufNewFile *.md,*.mkd,*.markdown set wrap
    au BufRead,BufNewFile *.md,*.mkd,*.markdown set ai formatoptions=tcroqn2 comments=n:>
  aug END
  " }}}

  " ruby file {{{
  aug filetype_ruby
    au!
    au BufRead,BufNewFile *.pp           set filetype=ruby
    au BufRead,BufNewFile *.ru,*.thor    set filetype=ruby
    au BufRead,BufNewFile [vV]agrantfile set filetype=ruby
    au BufRead,BufNewFile Gemfile        set filetype=ruby
    au BufRead,BufNewFile Rakefile       set filetype=ruby
    au BufRead,BufNewFile Puppetfile     set filetype=ruby
    au BufRead,BufNewFile Guardfile      set filetype=ruby
  aug END
  " }}}

  " Erlang and Elixir file {{{
  aug filetype_erlang
    au!
    au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
    au FileType elixir setl sw=2 sts=2 et iskeyword+=!,?
  aug END
  " }}}

  " Lua related file {{{
  aug filetype_lua
    au!
    au BufRead,BufNewFile *.moon set filetype=moon
    au FileType moon setl sw=2 sts=2 et iskeyword+=!,?
  aug END

  " }}}

  " Auto-clean fugitive buffers {{{
  " See: http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
  aug figutive
    au!
    au BufReadPost fugitive://* set bufhidden=delete
  aug END
  " }}}

  " shared settings {{{
  aug shared_settings
    au!
    au FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
    au FileType python set sw=4 sts=4 et

    au! BufRead,BufNewFile *.sass setfiletype sass
    au BufNewFile,BufRead  *.css  set fdm=marker fmr={,}

    " Leave the return key alone when in command line windows, since it's used to run commands there.
    au! CmdwinEnter * :unmap <cr>
    au! CmdwinLeave * :call MapCR()

    " Resize splits when the window is resized
    au VimResized * :wincmd =
  aug END
  " }}}

  " Jump to the last cursor position unless it is invalid or in an event handler {{{
  aug jump_to_last_position
    au!
    au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  aug END
  " }}}

  " Whitespace cleanup {{{
  aug clean_white_space
    au!
    " Automatically remove all trailing whitespace before saving.
    au BufWritePre * :%s/\s\+$//e

    " Automatically delete trailing Dos-returns,whitespace
    au BufRead * silent! %s/[\r \t]\+$//
  aug END
  " }}}

  " Only show cursorline in the current window and in normal mode {{
  aug cursorline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
  aug END
  " }}}

  " Only shown trailing whitespace when not in insert mode {{{
  aug trailing_display
    au!
    au InsertEnter * :set listchars-=trail:⌴
  aug END
  " }}}

  " close last NERDTree window {{{
  aug close_nerdtree
    au!
    au WinEnter * call s:CloseLastNerdTree()
    " Close all open buffers on entering a window if the only
    " buffer that's left is the NERDTree buffer
    function! s:CloseLastNerdTree()
      if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
          if winnr("$") == 1
            q
          endif
        endif
      endif
    endfunction
  aug END
  " }}}
endif
" }}}
