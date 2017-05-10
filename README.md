vim
===
Hopefully my `.vimrc` documents custom mappings and plugins useful enough. But there are a number
of very useful vim commands that I've found over the years. A tiny smattering:

* `jumplist`: `CTRL-O` (older), `CTRL-I`/`<Tab>` (newer)
    * vim tracks jumps within windows, allowing navigation to and from previous files and positions
* `CTRL-^`
    * Edits the alternate file (usually the previously edited file). Useful as a toggle between two files.
* `ZZ`, `ZQ`
    * `ZZ`: `:x`; `ZQ`: `:q!`
* `!`, `.!`
    * `!`: shell from vim; `.!`: shell and forward output
* `K`
    * runs `man` for keyword under cursor
* `#`, `*`
    * `#` searches for keyword under cursor backward, `*` searches forward
* `g`
    * [some cool examples](http://vim.wikia.com/wiki/Power_of_g)
* `earlier` and `later`
    * `:earlier 30m`, `:later 3h 22m`
* `gf`
    * go to file. Works for local paths for python, javascript, etc.
* `Le(xplore)`
    * `Netrw` explorer window with changes made to window to (right pane)
* `register`
    * Beyond useful. .e.g. `"kyy` to store a line in `k`, then `"kp` to paste. `<ctrl-r>k` to paste in commands and search.
* `marks`
* `q:`
    * command line w/ history


vim todo
--------
Investigate `:help changes`
