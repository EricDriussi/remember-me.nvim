# remember-me

If within a project:

> On open, remember what I was doing.
>
> On close, memorize what I'm doing.

If outside a project:

> Don't bother me

## Usage

This plugin has a *set it and forget it* approach to session handling.

Aucmds are already set up to handle its behavior when opening and closing nvim.

You should pretty much just set the config as you see fit and carry on your merry way.

If that's not enough and/or you wish to extend the behavior, `Memorize` and `Recall` user commands are available to manually save and load sessions.

You can also call these functions directly from you `lua` config.

```lua
require("remember_me").save()
require("remember_me").load()
```

## Install

Vim-plug: `Plug 'EricDriussi/remember-me.nvim'`

Packer: `use { 'EricDriussi/remember-me.nvim' }`

## Setup

As usual, `require("remember_me").setup()` needs to be in your config to use with default behavior.

You can pass a table to `setup()` with your desired config, as explained below.

### Default config

```lua
{
  ignore_ft = { "man", "gitignore", "gitcommit" },
  session_store = "~/.cache/remember-me/",
  project_roots = { ".git", ".svn" },
  full_name = false,
}
```

Full config table can be found [here](https://github.com/EricDriussi/remember-me.nvim/blob/93e93c02f6378b584bc5cf17f02d6e63bef00b13/lua/remember_me.lua#L7).

### Options

Please keep in mind that the config variables you specify will **override** the default ones.

So to **add** a `filetype` to ignore, use `ignore_ft = { "man", "gitignore", "gitcommit", "something_else" }`

- **ignore_ft**

File types for which nothing will happen, even if within a project.
No saving nor loading sessions.

This is **not** defined at the `aucmd` level, so it is taken into account even if calling the user commands or the `lua` functions directly.

- **session_store**

Where to store and look for sessions. Only affects the sessions managed by this plugin.

<!--TODO. update-->

It takes both full and relative paths, although relative paths are expanded from wherever nvim was launched.

- **project_roots**

What defines a project.

The plugin will search up the directory tree until it finds one of these markers and consider the directory in which it found it as the project's root.

Can take files or directories, but can't handle globs or patterns.

- **full_name**

Whether to use the full path of the project as it's session name.

By default, it saves the session with the project's root directory as the session name.

This is probably fine, but it will break if you have a bunch of projects with the same name under different paths, i.e. `/here/project/` and `/there/project/` will both point to the same session.

Set this to `true` if that's your case.

## Use Case

I use nvim in a couple of distinct ways.
I'm either working on a project, taking notes/writing or messing with dotfiles/system config.

Sessions only make sense to me when working in a project.

- Default (n)vim session management is cumbersome.

- Session management [plugins](https://github.com/natecraddock/sessions.nvim#related) are overkill since I just want part of that functionality and only when inside a project.

- Project management plugins are overkill since I don't really need to manage my projects, I usually navigate to them using [z.lua](https://github.com/skywind3000/z.lua).

Since nothing felt right, I started writing stuff in my config to fit my needs:

- I just want sessions when inside a project.
- Even inside a project, I don't want sessions if I'm explicitly opening a file, editing a commit or reading a `man` page.
- I don't want any overhead. Set the thing up and forget about it.

And *voilà*! A plugin was born.
