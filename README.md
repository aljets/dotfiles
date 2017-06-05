vim
===

A very small list of useful vim commands. Assumes basic vim proficiency.

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
* `:earlier` and `:later`
    * `:earlier 30m`, `:later 3h 22m`
* `gf`
    * go to file. Works for local paths for python, javascript, etc.
* `:Le(xplore)`
    * `Netrw` explorer window with changes made to window to (right pane)
* `register`
    * `"kyy` to store a line in `k`, then `"kp` to paste. `<ctrl-r>k
    * Register `:` holds the last command, `/` the last search. .e.g. `":p` to paste the last command, `"/p` the last search.`
* `marks`
* `q:`, `q\`
    * `q:` (or `:CTRL-F`) for command line w/ history, `q\` (or `\CTRL-F`) for searches.
* `CTRL-R CTRL-W`, `CTRL-R CTRL-0`
    * Inserts the current word under the cursor and the most recent item yanked, respectively
* `gqip`


vim todo
--------
Investigate `:help changes`
