# Huy's Neo/vim Config

Credit goes to Rafi and his Vim Configuration. Please check out his Github here https://github.com/rafi/vim-config.

In addition to Rafi's configs, this Vim config have been modified to my needs with Markdown, Go, Python, C and C++.

## Features

In addition to Rafi's configuration, there are features that I have also implemented to help with my Vim experience.
- Theme sync with Tmux and persist background/theme changes for all running Vim session
- Rsync to remote projects for remote editing/execution with SSH
- Added Gtags for easier code navigation

## Custom Key-mappings

Note that,

* Leader key is set as <kbd>Space</kbd>
* Local-leader is set as <kbd>;</kbd> and used for Denite & NERDTree

| Key                   |      Mode     | Action                                                          |
|-----------------------|:-------------:|-----------------------------------------------------------------|
| `Space`               |     _All_     | **Leader**                                                      |
| `;`                   |     _All_     | **Local Leader**                                                |
| `F2`                  |     Normal    | Reload vim configuration                                        |
| Arrows                |     Normal    | Resize splits (* Enable `g:elite_mode` in `.vault.vim`)         |
| `Backspace`           |     Normal    | Match bracket (%)                                               |
| `K`                   |     Normal    | Open Zeal or Dash on some file types (except Python+Vim script) |
| `Y`                   |     Normal    | Yank to the end of line (y$)                                    |
| `<Return>`            |     Normal    | Toggle fold (za)                                                |
| `S`+`<Return>`        |     Normal    | Focus the current fold by closing all others (zMza)             |
| `S`+`<Return>`        |     Insert    | Start new line from any cursor position (\<C-o>o)               |
| `hjkl`                |     Normal    | Smart cursor movements (g/hjkl)                                 |
| `Ctrl`+`f`            |     Normal    | Smart page forward (C-f/C-d)                                    |
| `Ctrl`+`b`            |     Normal    | Smart page backwards (C-b/C-u)                                  |
| `Ctrl`+`e`            |     Normal    | Smart scroll down (3C-e/j)                                      |
| `Ctrl`+`y`            |     Normal    | Smart scroll up (3C-y/k)                                        |
| `Ctrl`+`q`            |     Normal    | Remap to `Ctrl`+`w`                                             |
| `Ctrl`+`x`            |     Normal    | Rotate window placement                                         |
| `!`                   |     Normal    | Shortcut for `:!`                                               |
| `}`                   |     Normal    | After paragraph motion go to first non-blank char (}^)          |
| `<`                   | Visual/Normal | Indent to left and re-select                                    |
| `>`                   | Visual/Normal | Indent to right and re-select                                   |
| `Tab`                 |     Visual    | Indent to right and re-select                                   |
| `Shift`+`Tab`         |     Visual    | Indent to left and re-select                                    |
| `gh`                  |     Normal    | Show highlight group that matches current cursor                |
| `gp`                  |     Normal    | Select last paste                                               |
| `Q`                   |     Normal    | Start/stop macro recording                                      |
| `gQ`                  |     Normal    | Play macro 'q'                                                  |
| `mj`/`mk`             | Normal/Visual | Move lines down/up                                              |
| `cn`/`cN`             | Normal/Visual | Change current word in a repeatable manner                      |
| `cp`                  |     Normal    | Duplicate paragraph                                             |
| `s`                   |     Visual    | Replace within selected area                                    |
| `Ctrl`+`a`            |    Command    | Navigation in command line                                      |
| `Ctrl`+`b`            |    Command    | Move cursor backward in command line                            |
| `Ctrl`+`f`            |    Command    | Move cursor forward in command line                             |
| `Ctrl`+`r`            |     Visual    | Replace selection with step-by-step confirmation                |
| `,`+`Space`           |     Normal    | Remove all spaces at EOL                                        |
| `<leader>`+`<leader>` |     Normal    | Enter visual line-mode                                          |
| `<leader>`+`a`        |     Normal    | Align paragraph                                                 |
| `<leader>`+`os`       |     Normal    | Load last session                                               |
| `<leader>`+`se`       |     Normal    | Save current workspace as last session                          |
| `<leader>`+`d`        | Normal/Visual | Duplicate line or selection                                     |
| `<leader>`+`S`        | Normal/Visual | Source selection                                                |
| `<leader>`+`ml`       |     Normal    | Append modeline                                                 |

### File Operations

| Key                             |      Mode     | Action                                                |
|---------------------------------|:-------------:|-------------------------------------------------------|
| `<leader>`+`cd`                 |     Normal    | Switch to the directory of opened buffer (:lcd %:p:h) |
| `<leader>`+`w`                  | Normal/visual | Write (:w)                                            |
| `<leader>`+`y` / `<leader>`+`Y` |     Normal    | Copy (relative / absolute) file-path to clipboard     |
| `Ctrl`+`s`                      |     _All_     | Write (:w)                                            |
| `W!!`                           |    Command    | Write as root                                         |

### Editor UI

| Key              |  Mode  | Action                                          |
|------------------|:------:|-------------------------------------------------|
| `<leader>`+`toi` | Normal | Toggle indentation lines                        |
| `<leader>`+`tos` | Normal | Toggle spell-checker (:setlocal spell!)         |
| `<leader>`+`ton` | Normal | Toggle line numbers (:setlocal nonumber!)       |
| `<leader>`+`tol` | Normal | Toggle hidden characters (:setlocal nolist!)    |
| `<leader>`+`toh` | Normal | Toggle highlighted search (:set hlsearch!)      |
| `<leader>`+`tow` | Normal | Toggle wrap (:setlocal wrap! breakindent!)      |
| `g0`             | Normal | Go to first tab (:tabfirst)                     |
| `g$`             | Normal | Go to last tab (:tablast)                       |
| `gr`             | Normal | Go to previous tab (:tabprevious)               |
| `Shift-h`        | Normal | Go to previous tab (:tabprevious)               |
| `Shift-l`        | Normal | Go to next tab (:tabnext)                       |
| `Ctrl`+`j`       | Normal | Move to split below (\<C-w>j)                   |
| `Ctrl`+`k`       | Normal | Move to upper split (\<C-w>k)                   |
| `Ctrl`+`h`       | Normal | Move to left split (\<C-w>h)                    |
| `Ctrl`+`l`       | Normal | Move to right split (\<C-w>l)                   |
| `*`              | Visual | Search selection forwards                       |
| `#`              | Visual | Search selection backwards                      |
| `<leader>`+`j`   | Normal | Next on location list                           |
| `<leader>`+`k`   | Normal | Previous on location list                       |
| `<leader>`+`bg`  | Normal | Toggle colorscheme background dark/light        |
| `s`+`-`          | Normal | Lower colorscheme contrast (Support solarized8) |
| `s`+`=`          | Normal | Raise colorscheme contrast (Support solarized8) |
| `Alt-h`          | Insert | Move cursor one character to the left           |
| `alt-l`          | insert | move cursor one character to the right          |


### Window Management

| Key                  |  Mode  | Action                                                 |
|----------------------|:------:|--------------------------------------------------------|
| `q`                  | Normal | Quit window (and Vim, if last window)                  |
| `Ctrl + q`           | Normal | Save session, save all buffers, quit all and close Vim |
| `Tab`                | Normal | Next window in tab                                     |
| `Shift`+`Tab`        | Normal | Previous window in tab                                 |
| `Ctrl`+`Tab`         | Normal | Next tab                                               |
| `Ctrl`+`Shift`+`Tab` | Normal | Previous tab                                           |
| `\`+`\`              | Normal | Jump to last tab                                       |
| `s`+`v`              | Normal | Horizontal split (:split)                              |
| `s`+`g`              | Normal | Vertical split (:vsplit)                               |
| `s`+`t`              | Normal | Open new tab (:tabnew)                                 |
| `s`+`o`              | Normal | Close other windows (:only)                            |
| `s`+`x`              | Normal | Remove buffer, leave blank window                      |
| `s`+`q`              | Normal | Closes current buffer (:close)                         |
| `s`+`Q`              | Normal | Removes current buffer (:bdelete)                      |
| `<leader>`+`s-`      | Normal | Split with previous buffer                             |
| `<leader>`+`s\\`     | Normal | Vertical split with previous buffer                    |

### Plugin: Denite

| Key             |      Mode     | Action                     |
|-----------------|:-------------:|----------------------------|
| `;`+`r`         |     Normal    | Resumes last Denite window |
| `;`+`f`         |     Normal    | File search                |
| `;`+`b`         |     Normal    | Buffers and MRU            |
| `;`+`d`         |     Normal    | Directories                |
| `;`+`l`         |     Normal    | Location list              |
| `;`+`q`         |     Normal    | Quick fix                  |
| `;`+`n`         |     Normal    | Dein plugin list           |
| `;`+`g`         |     Normal    | Grep search                |
| `;`+`j`         |     Normal    | Jump points                |
| `;`+`o`         |     Normal    | Outline tags               |
| `;`+`s`         |     Normal    | Sessions                   |
| `;`+`t`         |     Normal    | Tag under cursor           |
| `;`+`p`         |     Normal    | Jump to previous position  |
| `;`+`h`         |     Normal    | Help                       |
| `;`+`v`         | Normal/Visual | Register                   |
| `;`+`z`         |     Normal    | Z (jump around)            |
| `;`+`;`         |     Normal    | Command history            |
| `;`+`/`         |     Normal    | Buffer lines               |
| `;`+`*`         |     Normal    | Match line                 |
| `<leader>`+`gl` |     Normal    | Git log (all)              |
| `<leader>`+`gs` |     Normal    | Git status                 |
| `<leader>`+`gc` |     Normal    | Git branches               |
| `<leader>`+`gf` |     Normal    | Grep word under cursor     |
| `<leader>`+`gg` | Normal/Visual | Grep word under cursor     |

**Within _Denite_ mode**
| Key        |      Mode     | Action                        |
|------------|:-------------:|-------------------------------|
| `Escape`   | Normal/Insert | Toggle modes                  |
| `jk`       |     Insert    | Leave Insert mode             |
| `Ctrl`+`y` |     Insert    | Redraw                        |
| `r`        |     Normal    | Redraw                        |
| `st`       |     Normal    | Open in a new tab             |
| `sv`       |     Normal    | Open in a vertical split      |
| `sg`       |     Normal    | Open in a split               |
| `'`        |     Normal    | Toggle mark current candidate |

### Plugin: NERDTree

| Key     |  Mode  | Action                               |
|---------|:------:|--------------------------------------|
| `;`+`e` | Normal | Toggle file explorer                 |
| `;`+`a` | Normal | Toggle file explorer on current file |

**Within _NERDTree_ buffers**
| Key       |  Mode  | Action                                 |
|-----------|:------:|----------------------------------------|
| `h/j/k/l` | Normal | Movement + collapse/expand + file open |
| `w`       | Normal | Toggle window size                     |
| `N`       | Normal | Create new file or directory           |
| `yy`      | Normal | Yank selected item to clipboard        |
| `st`      | Normal | Open file in new tab                   |
| `s-`      | Normal | Open file in a horizontal split        |
| `s\\`     | Normal | Open file in a vertical split          |
| `&`       | Normal | Jump to project root                   |
| `gh`      | Normal | Jump to user's home directory          |
| `gd`      | Normal | Open split diff on selected file       |
| `gf`      | Normal | Search in selected directory for files |
| `gr`      | Normal | Grep in selected directory             |

### Plugin: Deoplete / Emmet / Neocomplete

  | Key                  |      Mode     | Action                              |
  |----------------------|:-------------:|-------------------------------------|
  | `enter`              |     insert    | select completion or expand snippet |
  | `Tab`                | Insert/select | Smart tab movement or completion    |
  | `Ctrl`+`j/k/f/b/d/u` |     Insert    | Movement in completion pop-up       |
  | `Ctrl`+`<Return>`    |     Insert    | Expand Emmet sequence               |
  | `Ctrl`+`o`           |     Insert    | Expand snippet                      |
  | `Ctrl`+`g`           |     Insert    | Refresh candidates                  |
  | `Ctrl`+`l`           |     Insert    | Complete common string              |
  | `Ctrl`+`e`           |     Insert    | Cancel selection and close pop-up   |
  | `Ctrl`+`y`           |     Insert    | Close pop-up                        |

### Plugin: Commentary

| Key            | Mode          | Action                      |
|----------------|:-------------:|-----------------------------|
| `<leader>`+`v` | Normal/visual | Toggle single-line comments |

### Plugin: Unit-Test

| Key             |  Mode  | Action                     |
|-----------------|:------:|----------------------------|
| `<leader>`+`tn` | Normal | Test nearest to the cursor |
| `<leader>`+`tl` | Normal | Test the last ran item     |
| `<leader>`+`ta` | Normal | Test suite                 |
| `<leader>`+`tf` | Normal | Test current file          |

### Plugin: Edge Motion

| Key     |      Mode     | Action                 |
|---------|:-------------:|------------------------|
| `g`+`j` | Normal/Visual | Jump to edge downwards |
| `g`+`k` | Normal/Visual | Jump to edge upwards   |

### Plugin: QuickHL


| Key            |      Mode     | Action                         |
|----------------|:-------------:|--------------------------------|
| `<leader>`+\`  | Normal/Visual | Toggle highlighted word        |
| `<leader>`+',' | Normal/Visual | Toggle highlight for selection |

### Plugin: Expand-Region

| Key |      Mode     | Action           |
|-----|:-------------:|------------------|
| `v` | Visual/select | Expand selection |
| `V` | Visual/select | Reduce selection |

### Plugin: Easymotion

| Key     |       Mode      | Action                            |
|---------|:---------------:|-----------------------------------|
| `s`+`s` |      Normal     | Jump to two characters from input |
| `s`+`d` |      Normal     | Jump to a character from input    |
| `s`+`f` |      Normal     | Jump over-windows                 |
| `s`+`h` |      Normal     | Jump backwards in-line            |
| `s`+`l` |      Normal     | Jump forwards in-line             |
| `s`+`j` |      Normal     | Jump downwards                    |
| `s`+`k` |      Normal     | Jump upwards                      |
| `s`+`/` | Normal/operator | Jump to free-search               |
| `s`+`n` |      Normal     | Smart next occurrence             |
| `s`+`p` |      Normal     | Smart previous occurrence         |

### Plugin: ChooseWin

| Key            |  Mode  | Action                              |
|----------------|:------:|-------------------------------------|
| `-`            | Normal | Choose a window to edit             |
| `<leader>`+`-` | Normal | Switch editing window with selected |

### Plugin: Bookmarks

| Key                |  Mode  | Action                          |
|--------------------|:------:|---------------------------------|
| `<leader>`+`m`+`a` | Normal | Show list of all bookmarks      |
| `<leader>`+`m`+`m` | Normal | Toggle bookmark in current line |
| `<leader>`+`m`+`n` | Normal | Jump to next bookmark           |
| `<leader>`+`m`+`p` | Normal | Jump to previous bookmark       |
| `<leader>`+`m`+`i` | Normal | Annotate bookmark               |

### Plugin: Easygit

| Key | Mode | Action |
|-----|:----:|--------|
|`<leader>`+`ga` | Normal | Git add current file|
|`<leader>`+`gS` | Normal | Git status|
|`<leader>`+`gd` | Normal | Git diff|
|`<leader>`+`gD` | Normal | Close diff|
|`<leader>`+`gc` | Normal | Git commit|
|`<leader>`+`gb` | Normal | Git blame|
|`<leader>`+`gB` | Normal | Open in browser|
|`<leader>`+`gp` | Normal | Git push|

### Plugin: GitGutter

| Key             |  Mode  | Action                |
|-----------------|:------:|-----------------------|
| `<leader>`+`hj` | Normal | Jump to next hunk     |
| `<leader>`+`hk` | Normal | Jump to previous hunk |
| `<leader>`+`hs` | Normal | Stage hunk            |
| `<leader>`+`hr` | Normal | Revert hunk           |
| `<leader>`+`hp` | Normal | Preview hunk          |

### Plugin: Linediff

| Key |  Mode  | Action |
|-----|:------:|--------|------------------------------------------------|
| `   | `+`df` | Visual | Mark lines and open diff if 2nd region         |
| `   | `+`da` | Visual | Mark lines for diff                            |
| `   | `+`ds` | Normal | Shows the diff between all the marked areas    |
| `   | `+`dr` | Normal | Removes the signs denoting the diff'ed regions |

### Misc Plugins

| Key             |  Mode  | Action                          |
|-----------------|:------:|---------------------------------|
| `m`+`g`         | Normal | Open Magit                      |
| `<leader>`+`l`  | Normal | Open sidemenu                   |
| `<leader>`+`o`  | Normal | Open tag-bar                    |
| `<leader>`+`G`  | Normal | Toggle distraction-free writing |
| `<leader>`+`gu` | Normal | Open undo tree                  |
| `<leader>`+`W`  | Normal | Wiki                            |
| `<leader>`+`K`  | Normal | Thesaurus                       |
| `<leader>`+`?`  | Normal | Dictionary (macOS only)         |

## Credits & Contribution

Big thanks to the dark knight [Shougo].

[Shougo]: https://github.com/Shougo
[lazy-loaded]: ./config/plugins.yaml#L21
[yaml2json]: https://github.com/koraa/large-yaml2json-json2yaml
