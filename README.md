Tool usage
=========

vim TIL
---

A very small list of useful vim commands. Assumes basic vim proficiency.

* `jumplist`: `CTRL-o` (older), `CTRL-i`/`<Tab>` (newer)
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
* `reg(ister)`
    * `reg` to access registers. If you yank and then yank again, your previous register is still stored!
    * `"kyy` to store a line in `k`, then `"kp` to paste. `<ctrl-r>k
    * Register `:` holds the last command, `/` the last search. .e.g. `":p` to
    paste the last command, `"/p` the last search.`
* `marks`
* `q:`, `q\`
    * `q:` (or `:CTRL-F`) for command line w/ history, `q\` (or `\CTRL-F`) for searches.
* `CTRL-R CTRL-W`, `CTRL-R CTRL-0`
    * Inserts the current word under the cursor and the most recent item yanked, respectively
* `gqip`
* `:bd` removes buffer from open buffers
* `ctrl-x`, `ctrl-l`
    * whole line completion
* `changelist`: `g;` (older), `g,` (newer)
    * vim tracks locations of changes, allowing jumps to those locations
* `ctrl-r-w`, `ctrl-r-<register>`
    * [paste contents](http://vim.wikia.com/wiki/Pasting_registers) of current
      highlighted word / current register in insert and command-line modes
* `H`, `M`, `L`, `zt`, `zz`, `zb`
    * first three move cursor in current view, last three keep cursor but shift screen
    * also remember there is more than `ctrl-u/d` (`ctrl-b/f/e/y`)
* Reminder to use marks to copy/paste arbitrary chunks of code / across the screen (`ma`, ``d`a``)


vim todo
--------

* Don't use `,` as leader!!! (probably space)
* Investigate `:help changes`
* Investigate `vimux`?
* Consider `vim-sleuth`
* Give `vim-sneak` another try (or `vim-seek`, commands like yrwp look
  interesting, so does `clever-f`, possibly)
* look up multilvel undo
* look up undofile


vim links I liked
----------------
* [Productive shortcuts](https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118)
    * Good primer of `ex` command set
* [Good intro](http://www.viemu.com/a-why-vi-vim.html)
    * e.g. good vim users more likely to use things like `H`, `M`, `L`, `%`,
      `f`, `/`, `]]` than `h`, `j`, `k`, `l`, etc.


git
---

Basic git.

* `clean`: Remove untracked items. `-f` for files, `-d` for directories. Obliterates uncommitted unstages changes.
* `reset --hard`: Reset staging and working directory to match the most recent commit. Obliterates uncommitted staged changes.
* `reset`: Unstages files. Safe.
* `reset <commit>`: "Undo" commit, only to be used for local commits.
* `reset <file>`: Unstage file. Safe.
* `revert <commit>`: Generate new commit that undoes the changes introduced in `<commit>`, then apply it to the current branch.
* `checkout <commit> <file>`: Check out a previous version of a file. This turns the `<file>` that resides in the working directory into an exact copy of the one from <commit> and adds it to the staging area.
* `checkout <commit>`: Update all files in the working directory to match the specified commit.

Sources:
* [Undoing git changes](https://www.atlassian.com/git/tutorials/undoing-changes)

fish
----

Things I forgot:

* `ctrl-f` accepts autosuggestion (in addition to `→` but easier to type!)
* `alt-→` accepts single word of autosuggestion
* [Fish basics](https://fishshell.com/docs/current/tutorial.html)
