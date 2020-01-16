# Centaur Emacs

[![Build Status](https://travis-ci.org/seagle0128/.emacs.d.svg?branch=master)](https://travis-ci.org/seagle0128/.emacs.d)
[![Release Tag](https://img.shields.io/github/tag/seagle0128/.emacs.d.svg?label=release)](https://github.com/seagle0128/.emacs.d/releases/latest)
[![License](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)

![Centaur Emacs](logo.png)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Centaur Emacs](#centaur-emacs)
    - [Features](#features)
    - [Prerequisite](#prerequisite)
        - [OS](#os)
        - [GNU Emacs](#gnu-emacs)
        - [Dotfiles](#dotfiles)
    - [Quick Start](#quick-start)
        - [Install](#install)
        - [Update](#update)
        - [Docker](#docker)
    - [Customization](#customization)
        - [Customize-group](#customize-group)
        - [Manual](#manual)
    - [Screenshots](#screenshots)
    - [FAQ](#faq)

<!-- markdown-toc end -->

This is an Emacs distribution that aims to enhance the default
Emacs experience. It alters a lot of the default settings,
bundles a plethora of additional packages and adds its own core
library to the mix. The final product offers an easy to use Emacs
configuration for Emacs newcomers and lots of additional power for
Emacs power users.

It's able to run on Windows, GNU Linux and macOS. It is compatible **ONLY with
GNU Emacs 25.1 and above**. In general you're advised to always run with the
latest stable release - currently **26.2**.

## Features

- Out of box.
- Clean and Fast.
- Quick fuzzy search.
- Better Org/Markdown support.
- Support multiple programming languages
    - C/C++/Object-C/C#/Java
    - Python/Ruby/Perl/PHP/Shell/Powershell/Bat
    - Javascript/Typescript/JSON/YAML
    - HTML/CSS/XML
    - Golang/Swift/Rust/Dart/Elixir
    - ...
- Auto completion.
- Fly syntax check.
- Fly spell check.
- Git integration.
- Project/Workspace integration.
- Pomodor integration.
- Support docker.
- Better Chinese support:
    - Chinese calendar
    - Youdao dictionary
    - Pinyin search

## Prerequisite

### OS

- GNU Linux
- macOS
- Windows (Cygwin/MSYS)

### GNU Emacs

Please refer to [Installing Emacs](http://wikemacs.org/index.php/Installing_Emacs).

### Dotfiles

Recommend to use [Centaur Dotfiles](https://github.com/seagle0128/dotfiles).

## Quick Start

### Install

``` shell
mv ~/.emacs.d ~/.emacs.d.bak
git clone --depth 1 https://github.com/seagle0128/.emacs.d.git ~/.emacs.d
```

or download the [zip package](https://github.com/seagle0128/.emacs.d/archive/master.zip) directly and extract to `~/.emacs.d`.

Then start Emacs. Wait for a while to install packages at the first startup. Enjoy! :smile:

### Update

``` emacs-lisp
# Update Centaur Emacs (then restart), including configurations and packages
M-x centaur-update
M-x centaur-update-and-restart

# Update Emacs configurations only
M-x centaur-update-config

# Update ~/.dotfiles if it exists
M-x centaur-update-dotfiles

# Update packages only (then restart)
M-x centaur-update-packages
M-x centaur-update-packages-and-restart

# Update all including configurations, packages and dotfiles
M-x centaur-update-all
```

### Docker

``` shell
cd ~/.emacs.d/Dockerfile
docker build -t centaur/emacs .
docker run -it centaur/emacs bash
```

## Customization

### Customize Group

`M-x customize-group` and select `centaur`. Set and save the configurations, then restart Emacs.

### Manual

Copy `custom-template.el` to `custom.el` and change the configurations, then restart Emacs.

For Example:

``` emacs-lisp
(setq centaur-logo nil)                        ; Logo file or nil (official logo)
(setq centaur-full-name "user name")           ; User full name
(setq centaur-mail-address "user@email.com")   ; Email address
(setq centaur-proxy "127.0.0.1:1080")          ; Network proxy
(setq centaur-package-archives 'emacs-china)   ; Package repo: melpa, melpa-mirror, emacs-china, netease or tuna
(setq centaur-theme classic)                   ; Color theme: default, classic, dark, light or daylight
(setq centaur-dashboard nil)                   ; Use dashboard at startup or not: t or nil
(setq centaur-lsp 'eglot)                      ; Set LSP client: lsp-mode, eglot or nil
(setq centaur-chinese-calendar nil)            ; Use Chinese calendar or not: t or nil
(setq centaur-benchmark t)                     ; Enable initialization benchmark or not: t or nil
```

The default package archives is `melpa`. You can change it in `custom.el`, or switch manually via `M-x switch-package-archives` anytime.

For the personal configurations, you could put to `~/.emacs.d/custom-post.el`.

## Screenshots

![Dashboard](https://user-images.githubusercontent.com/140797/56488858-4e5c4f80-6512-11e9-9637-b9395c46400f.png
"Dashboard (default theme)")

![color_icons](https://user-images.githubusercontent.com/140797/56474931-8bddc000-64b3-11e9-93d8-0204c3752790.png
"Main (color icons)")

![markdown_magit](https://user-images.githubusercontent.com/140797/56489193-7f894f80-6513-11e9-9c95-ea1ef41efb1f.png
"Markdown and Magit")

![org_classic](https://user-images.githubusercontent.com/140797/56489410-2837af00-6514-11e9-9e04-a1663ac479e8.png
"Org (classic theme)")

![main_light](https://user-images.githubusercontent.com/140797/56489516-85cbfb80-6514-11e9-9dd4-8602bf8a4ec7.png
"Main (light theme)")

## FAQ

1. How to display icons correctly in `Centaur Emacs`?

    `all-the-icons` are necessary. Run `M-x all-the-icons-install-fonts` to
    install the resource fonts. On Windows, the fonts should be installed manually.
    `all-the-icons` only support GUI. If you don't like color icons,
    `(setq all-the-icons-color-icons nil)` to disable. Please refer to
    [all-the-icons.el](https://github.com/domtronn/all-the-icons.el) for details.

1. The packages cannot be installed, what should I do?

   Generally it's due to connection issue. Please refer to
   [#98](https://github.com/seagle0128/.emacs.d/issues/98).
   - `M-x package-refresh-contents` and try again.
   - `(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")`.
   - Use other mirror of elpa.
   - Change another network to retry.

1. How to search Chinese via pinyin?

    In Emacs, `C-s !`. If you just want to search `!`, use `C-s \!`.

1. How to use the Centaur Dashboard?

    If `centaur-dashboard` is non-nil the Centaur Dashboard will be opened at
    startup automatically. After startup, you could use `F2` to reopen it
    anytime. In the dashboard, please press `?` or `h` to get the help. You can
    easily jump to the sections or buttons with keybindings, e.g. Homepage(`H`),
    Session(`R`, `L`), Settings(`S`), Update(`U`), Recent Files (`r`),
    Bookmarks(`m`) and Projects(`p`).

1. Does Centaur Emacs support Language Server Protocol (LSP)?

    The LSP feature is supported and enabled by default in Centaur Emacs.
    `lsp-mode` is the default client, and `eglot` is another choice. Use `(setq
    centaur-lsp nil)` to disable LSP if you don't like it.

    Before use it you should install language servers. Refer to [lsp-mode:
    supported-languages](https://github.com/emacs-lsp/lsp-mode#supported-languages)
    or [eglot: Connecting to a
    server](https://github.com/joaotavora/eglot#connecting-to-a-server) for
    details.

1. How to enable `plantuml` in `org-mode`?

    Put `(setq org-plantuml-jar-path "<path of plantumx.x.x.jar>")` in `custom.el`.

1. Why the Emacs environment variables and `exec-path` are different between GUI
   and terminal?

    Please refer to #33. You should instead set environment variables in startup
    files like .profile, .bash_profile or .zshenv, then `Centaur Emacs` is able
    to recognize and import the environment variables.

## Donate

If you think it's helpful for you, please consider pay a cup of coffee for me. Thank you! :smile:

<img
src="https://user-images.githubusercontent.com/140797/65818854-44204900-e248-11e9-9cc5-3e6339587cd8.png"
alt="Alipay" width="150"/>
&nbsp;&nbsp;
<img
src="https://user-images.githubusercontent.com/140797/65818844-366ac380-e248-11e9-931c-4bd872d0566b.png"
alt="Wechat" width="150"/>