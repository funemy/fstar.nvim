# fstar.nvim

*fstar.nvim* is a [neovim] plugin for [F*], an ML-like language with a type system for program verification.

This is an actively maintained fork of [VimFStar]

## Features

- Syntax highlighting
- Language server support
- Interactive verification of code

## Installation

If you're using [vim-plug], for example, perform the following steps to install *fstar.nvim*:

1. Edit your .vimrc and add a `Plug` declaration for VimFStar.

	```vim
	call plug#begin()
	" ...
	Plug 'neovim/nvim-lspconfig'
	Plug 'funemy/fstar.nvim'
	" ...
	call plug#end()
	```
2. Add the setup code for the F* plugin to your vimrc:
    ```vim
    lua require'fstar'.setup{}
    ```
3. Restart neovim
4. `:PlugInstall` to install the plugin.

If you're using [lazy.nvim]:

```lua
  {
    "funemy/fstar.nvim",
    ft = "fstar",
    config = function()
      require("fstar").setup()
    end,
  }
```

## Use of the interactive verification

Make sure that `fstar.exe` and `z3` are in your path.  The first time you open an F* file, fstar.nvim will download the LSP server.  It will make use of the same `.fst.config.json` files as the official VS Code extension.

To test your code and it to the environment up to the current position of the cursor, call `:FStarVerifyToPoint` (default binding: `<LocalLeader>l`).

You can restart F* with `:FStarRestart` (default binding: `<LocalLeader>r`)

## Keybindings

The following keybindings are set by default (in normal mode):

| Key              | Command                  | Description                                        |
| ---------------- | ------------------------ | -------------------------------------------------- |
| `<LocalLeader>l` | `:FStarVerifyToPoint`    | Verify the file up to the current cursor position  |
| `<LocalLeader>[` | `:FStarLaxVerifyToPoint` | Lax-verify the file up to the current cursor position |
| `<LocalLeader>r` | `:FStarRestart`          | Restart the F* language server                     |
| `<LocalLeader>s` | `:FStarRestartSolver`    | Restart the Z3 solver                              |
| `<LocalLeader>k` | `:FStarKillAll`          | Kill all F* processes                              |

Two additional commands have no default binding:

| Command                   | Description                    |
| ------------------------- | ------------------------------ |
| `:FStarVerifyWholeFile`    | Verify the whole file          |
| `:FStarLaxVerifyWholeFile` | Lax-verify the whole file      |

You can disable the default keybindings by passing `mappings = false` to the `setup` function.

## License

The syntax highlighting file is distributed under the same license as Vim itself. See [LICENSE.VIM] for more details.

The rest of the plugin is licensed under the Apache license.  Large parts of the plugin are adapted from lean.nvim, which is MIT-licensed.  See [LICENSE] for more details.

[VimFStar]: https://github.com/gebner/VimFStar
[ML]: https://en.wikipedia.org/wiki/ML_(programming_language)
[neovim]: https://neovim.org
[F*]: https://fstar-lang.org
[vim-plug]: https://github.com/junegunn/vim-plug
[lazy.nvim]: https://github.com/folke/lazy.nvim
[pathogen]: https://github.com/tpope/vim-pathogen
[LICENSE.VIM]: http://github.com/FStarLang/VimFStar/blob/master/LICENSE.VIM
[LICENSE]: http://github.com/FStarLang/VimFStar/blob/master/LICENSE
