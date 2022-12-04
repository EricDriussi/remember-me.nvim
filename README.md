# A Neovim Plugin Template

A template repository for Neovim plugins.

## Features and structure

- CI to run tests and format code.
- Sample dummy logic and tests to go with it.
- Standard plugin and tests dir structure.
- Makefile with test recipes for both single file and dir testing (plus watch mode).
- Tests suite with [busted](https://olivinelabs.com/busted/) + [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- Luarrc and Stylua config

### Dir structure

```sh
.
├── lua
│   ├── plugin_name
│   │   ├── module.lua
│   └── plugin_name.lua
├── plugin
│   └── plugin_name.lua
└── tests
   ├── lua
   │   ├── plugin_name
   │   │   └── module_spec.lua
   │   └── plugin_name_spec.lua
   ├── plugin
   │   └── command_spec.lua
   ├── helper.lua
   └── minimal_init.lua
```
