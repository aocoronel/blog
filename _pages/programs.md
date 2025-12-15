---
title: Programs I Use
description: A collection of all the programs I use daily
---

## Philosophy

I choose software based on the following criteria:

- If a tool has remote syncing, all data should be still available locally, instead of blocked by an internet connection.
- I must have access to all my data, no matter what.
- If I decide to switch tools, they must allow me to export my data.
- I should be able to tinker with the tools, to shape them to fit my needs best.
- The usage must be clean and simple.
- 90% of the software I choose has its source open, often free to change and fork.
- Most tools I use does not have an interface, which turns them scriptable in many ways.
- I prefer lightweight solutions.

### Proprietary Software

I'm okay with having one or two proprietary software, but I do not accept myself relying on them, for essential things.

## Programs I Use

For a full list of all the programs I use, you can either check on [aocoronel/pacmirror-config](https://git.disroot.org/aocoronel/pacmirror-config) or my [NixOS](https://github.com/aocoronel/nix) repository.

### GUIs

This list is tiny, because my whole daily usage in my desktop is 50% on the browser and the other 50% at the terminal.

**Web Browser**

Firefox forks: Librewolf, Zen Browser...

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

I'm currently using **foot** in Wayland for its simple design, good collection of features and for its server feature.

### TUIs

**Display Manager**

I don't use any at all.

**Email Client**

**neomutt** rocks when you have a IMAP or POP3 email server. The same interface for multiple emails with no fuzz and bloat.

**Media Player**

**mpv** is the simplest media player I ever seen. Works headless in the terminal or decodes videos in a clean interface with many features available from bindings. This can be extended with **yt-dlp** to watch YouTube videos directly in it.

**RSS Feeds**

Fetch several feeds asynchronously, read all the titles in a blink, read the actual articles you want and clean everything you don't care. **newsboat** is the best option, when you have several feeds and you loose to much time to organize the ones you've read.

**Text Editor**

Hands down. **neovim** brings the best vim experience barebones. With plugins it becomes almost anything. I currently use it for all small file edits or to write code.

My thoughts on Emacs? I don't want to run an OS in my OS.

**File Management**

**ranger** for everything, and **yazi**, when I feel it's slow.

Or maybe, I'm too lazy to run `cd`, `rm` and `mv` around.

### CLIs

**Password Manager**

I use the legendary **pass** (PasswordStore) to store my OTP secrets. You read it right. I do not store passwords, instead I do generate them using **lesspass**.

**File Encryption**

I used to use **gocryptfs** for cloud syncing, but I do just use **tomb** now, whenever I have encryption necessities. And to be fair, I do barely use any of these.

**Backup**

I use **restic** to create backup snapshots that are encrypted and synced with a remote server. Absolutely replaced my need to online services like **Filen** or **MEGA**.

**Task Management**

Plain-text.

**Music Player**

**cmus** is a simple music player with daemon capabilities, which allows me to control it through scripts, or even remotely. I do not inherently use it's playlist feature, because my music files are always stored as playlist albums.

**Media Converter**

Is it audio or video, I'll use **FFmpeg**.

**File Syncing**

I often use **ssh** and **rsync** together to sync some files between my devices, avoiding **Syncthing** altogether. The advantage is I have more control of what files are synced, and I don't have to mess with the graphical interface for that.

**Dotfiles Organizer**

I use the **GNU stow** in my [dotfiles](https://git.disroot.org/aocoronel/dotfiles) repository to organize my dotfiles. For anything else I need to do with a symlink, I use [neostow](https://codeberg.org/aocoronel/neostow-sh) instead.

**Terminal Multiplexer**

I use **tmux** not for the reason you think. I use it whenever I need a long process to keep running. That way I can close my terminal and I still have it running. For a real multiplexing experience I do rely on Window Managers.

### Window Manager

On Wayland I use **Hyprland**, initially for the visuals, but I stayed, because of `hyprctl`. This CLI tool allows me to script some actions in Hyprland, so I can list all currently open windows, select it and move to it. If I have a terminal with a tmux running, I can quickly select which session to go, and it switches to the terminal, and then switches the session.

### Shell

I use **zsh** for the joy of using a terminal emulator. It's not impressive by default, but with a few modifications it makes my terminal experience unbeatable.

My prompt is simple. Just the current directory at left, and the git branch at the right. With transient prompt my terminal is always clean.

### Linux

I've used Linux Mint, Arch Linux, Alpine Linux and NixOS in the past. Currently I'm on Arch, btw.

Arch Linux gives you a great experience on building your system the way you want. Some great alternatives line Gentoo, which takes it to the extreme are not that friendly, by introducing some important trade-offs. While most program in the official Arch repository may be enough, the AUR may help you get some other tools installed as well.

If I had more than two devices, I would certainly use NixOS instead.

**AUR Helper**

I use **paru** as my AUR Helper, with no particular reason. Not because it's written in Rust. Since I use a very select few AUR packages, I may implement my own way to install AUR packages in the future.
