+++
title = "Programs I Use"
description = '''A collection of all the programs I use daily'''
+++

## Philosophy

I choose software based on the following criteria:

- **Local-first:** If a tool has remote syncing, all data should be still available locally, instead of blocked by an internet connection.
- **Ownership and Availability:** I must have access to all my data, no matter what.
- **Interchangeable:** If I decide to switch tools, they must allow me to export my data.
- **Extensible:** I should be able to tinker with the tools, to shape them to fit my needs best.
- **Simplicity:** The usage must be clean and simple.
- **Open-source:** 90% of the software I choose has it's source open, often free to change and fork.
- **CLI:** Most tools does not have an interface, which turns them scriptable in some way.

### Proprietary Software

I'm okay with having one or two proprietary software, but I do not accept myself relying on them.

## Programs I Use

For a full list of all the programs I use, you can either check on [aocoronel/mirror-config](https://github.com/aocoronel/mirror-config) or my [NixOS](https://github.com/aocoronel/nix) repository.

### GUIs

**Web Browser**

- **Zen Browser** took my attention since its beta version, and it's fairly a great option, for some use cases. I use it with no insane modifications. I currently use these extensions:

- uBlock Origin.
- Privacy Badger.
- Canvas Blocker with random number generator set to `nonpersistant`.
- Decentraleyes.
- Surfingkeys. This one is an absolute must have. It's vim in the browser.
- Dark Reader. I often leave it disabled.
- NoScript. I actually, leave it globally disabled.
- Firefox Multi-Account Container. Feature killer for my Firefox experience. It allows me to open containers automatically for configured websites. For example, when I click in a GitHub link I'm sent to a container which has my account logged in.

For Zen Browser native plugins, I do only have one: Tab Numbers. This is essential, since I leave my sidebar always collapsed.

**Audio Editor**

**Tenacity** is the only option, I currently know, that is great.

**Video Editor**

Whenever I have to make video edits I do use **shotcut**, for no particular reason. It's just this one I happen to know how to use.

**Image Editor**

I never used PhotoShop, but everything I always wanted to do with images I managed to do it with **GIMP**. The number one image editor you'll face while using Linux.

**YouTube Frontend**

I host an **Invidious** instance using **Podman**, and I access it using **FreeTube** for a better interface, nice searchable history and great playlist management.

**Office**

**LibreOffice** brings you all the features you want, to beautifully take you out from Microsoft Office piracy.

**PDF Viewer**

**Zathura** allows you to navigate PDF and EPUB (probably other formats are supported) with vim motions. Absolute clean interface.

**Window Swithcer**

**Rofi** is one of the most useful GUI programs I ever used. This program by itself is useful to open other programs. However, it can be infinitely extended to interface with anything you'd require to fuzzy search something.

**Terminal Emulator**

I tried all the terminals. **Alacritty** is the one that brings all the features I need, without the ones I don't.

### TUIs

**Display Manager**

I use the cleanest display manager: **ly**. This simple TUI gives you everything you need to quickly reboot, poweroff, switch Window Managers, change users and change wallpapers, as a great alternative to GUI tools like **sddm**. It's probably one of the few programs I use, that are written in Zig.

**Email Client**

**neomutt** rocks when you have a IMAP or POP3 email server. The same interface for multiple emails with no fuzz and bloat.

**Media Player**

**mpv** is the simplest media player I ever seen. Works headless in the terminal or decodes videos in a clean interface with many features available from bindings. This can be extended with **yt-dlp** to watch YouTube videos directly in it.

**RSS Feeds**

Fetch several feeds asynchronously, read all the titles in a blink, read the actual articles you want and clean everything you don't care. **newsboat** is the best option, when you have several feeds and you loose to much time to organize the ones you've read.

**Text Editor**

Hands down. **neovim** brings the best vim experience barebones. With plugins it becomes almost anything. I currently use it for all small file edits or to write code. Unfortunately, the tool that can become everything is **Emacs**, and I don't use it.

**File Management**

**ranger** for everything, and **yazi**, when I feel it's slow.

### CLIs

**Static Site Generator**

I use **zola** with the radion theme. Once I was using **pandoc** for this purpose, but when I found about **zola**, I found a much better way and optimized solution with less amateur features and inconsistencies.

**Password Manager**

I use the legendary **pass** (PasswordStore) to store my OTP secrets. You read it right. I do not store passwords, instead I do generate them using **lesspass**.

**File Encryption**

I used to use **gocryptfs** for cloud syncing, but I do just use **tomb** now, whenever I have encryption necessities.

**Backup**

I use **restic** to create backup snapshots that are encrypted and synced with a remote server. Absolutely replaced my need to online services like **Filen** or **MEGA**.

**Task Management**

**Taskwarrior** is a task management tool I found as an alternative to **Todoist** to quickly show me what to do next, and control over my data. With few strokes I know what to do, and when to do anything. Disclaimer, I do use the `2.6.2` version, when the database was backed by JSON files, and not SQLite as from `3.x.x`. This means I can use git.

**Music Player**

**cmus** is a simple music player with daemon capabilities, which allows me to control it through scripts, or even remotely. I do not inherently use it's playlist feature, because my music files are always stored as playlist albums.

**Media Converter**

Is it audio or video, I'll use **FFmpeg**.

**File Syncing**

I often use **ssh** and **rsync** together to sync some files between my devices, avoiding **Syncthing** altogether. The advantage is I have more control of what files are synced, and I don't have to mess with the graphical interface for that.

**Dotfiles Organizer**

I use the **GNU stow** in my [dotfiles](https://github.com/aocoronel/dotfiles) repository to organize my dotfiles. For anything else I need to do with a symlink, I use [neostow](https://github.com/aocoronel/neostow-sh) instead.

**Terminal Multiplexer**

I use **tmux** not for the reason you think. I use it whenever I need a long process to keep running. That way I can close my terminal and I still have it running. For a real multiplexing experience I do rely on Window Managers. To further take my tmux experience to the next level, I use **tmuxp** to define custom sessions with a specific layout or programs.

### Window Manager

I use **Qtile** for a Xorg WM experience, with almost all features I currently have in my Wayland one. It's a simple and highly extensible Python WM.

For Wayland I have **Hyprland**, initially for the visuals, but I stayed, because of `hyprctl`. This CLI tool allows me to script some actions in Hyprland, so I can list all currently open windows, select it and move to it. If I have a terminal with a tmux running, I can quickly select which session to go, and it switches to the terminal and switches the session.

### Shell

I use **zsh** for the joy of using a terminal emulator. It's not impressive by default, but with a few modifications it makes my terminal experience unbeatable.

My prompt is simple. Just the current directory at left, and the git branch at the right. With transient prompt my terminal is always clean.

### Linux

I've used Linux Mint, Arch Linux, Alpine Linux and NixOS in the past. Currently I'm on Arch, btw.

Arch Linux gives you a great experience on building your system the way you want. Some great alternatives line Gentoo, which takes it to the extreme are not that friendly, by introducing some important trade-offs. While most program in the official Arch repository may be enough, the AUR may help you get some other tools installed as well.

If I had more than two devices, I would certainly use NixOS instead.

**AUR Helper**

I use **paru** as my AUR Helper, with no particular reason. Not because it's written in Rust. Since I use a very select few AUR packages, I may implement my own way to install AUR packages in the future.
