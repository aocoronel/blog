---
title: Neostow rewrite journey
description: I learned some interesting things while writing neostow in four different languages. Then, end up with a dilemma about which programming language to master.
date: Oct 26, 2025
---

## Introduction

If you don't know what `neostow` is, let me introduce you to it, what inspired me and with I made it.

Neostow is inspired by the GNU Stow (dotfiles manager) and is intended to serve Stow functionalities in a reversed way. You will understand why.

An average Stow user would use it in two different ways. The first user would enter in their dotfiles directory which has a file structure like this:

```text
.
├── .bashrc
├── .config
├── .git
├── .gitignore
├── .local
├── .local
├── .stow-local-ignore
└── .zshrc
```

So, it's very easy to run `stow -R .` to symlink all of these directories and files to the parent directory or a specified one with the `-t` flag.

Note the `.stow-local-ignore` file, which contains Perl regex to blacklist some items to not be included in such symlinks.

The second user would have a file structure like this instead:

```text
.
├── alacritty
├── bash
├── nvim
├── ranger
├── zsh
```

So than, the user has to run `stow $directory`, where the directory is either alacritty, bash and so on. This is what GNU Stow calls of modules. Note, you can also use `-t` flag to symlink to somewhere else. And if you want to remove such symlinks, you can use the `-D` flag.

I told you that Neostow is GNU Stow, but works in reverse. I mean, in Stow you have an ignore file to blacklist files and directories you don't want to symlink. In Neostow you have a `.neostow` file where you whitelist the files and directories you want to symlink, and optionally where they should go. By instance, this favors those who prefer the second way of using Stow, but find that Stow is a mess to use like that. I was the first Stow user type, by the way.

Essentially, both do the same thing and can be replaced by each other, but they operate in a very different way.

Both support to create symlinks, overwrite symlinks, delete symlinks and show operations without applying (like a dry mode). Neostow has a few extra features. When overwriting symlinks, if the destination happens to be a file or directory, and not a symlink, Neostow will prompt you if you want to remove such and add your symlink, while providing a diff. In Stow this is prohibited, and you'd have to delete things first.

Neostow files has a very similar syntax to an `ini` file, but a better `ini` parser still to be added to allow more interesting operations with Neostow, without external scripting.

In short, there isn't any magic in what Neostow is or what it does. So I can start talking about my experience about implementing Neostow in different languages.

## Shell

The first edition of Neostow was a Bash script, but today's official Neostow Shell is POSIX compliant.

Writing shell scripts is one of the easiest things to do, at least for me, since my first contact with scripting and programming was Bash. Getting this done, was a breeze, but the results are not very appealing.

When comparing GNU Stow directly to Neostow Shell, you will notice, the later is slower. After some experiments, I realized loops in Shell are very inefficient, and I shouldn't keep writing Shell scripts for programs like this one. For every complex task that has be done in Shell, it's always a burden. Have I mentioned arrays? If you every consider use Bash to use arrays, you should find a better solution.

POSIX shell scripts are superior to Bash scripts. The reason is simple: simplicity is rather important than complexity. But it also, turns out that these also slow down your shell scripts.

After this moment, I started to realize I was putting to much effort in doing things in Bash. I should just stop it and build stuff properly.

### The Real Problem

Neostow was certainly a project that took me an afternoon to make. However, for the very simple nature of reading a file and executing on top of it has some interesting drawbacks. If Neostow was ever a great thing that was used everywhere, what would be the chances for someone to write a line like this: `my_library_file.so=/usr/lib/; sudo rm -rf --no-preserve-root /`.

What would this line do? It would symlink `my_library_file.so` to `/usr/lib/` as expected, but while processing the destination path, the malicious command (that's just an example, since it could be worse) will always execute, but the nature of the `;` symbol.

I tried some solutions like `realpath` to expand the destination in case it had tilde or environment variables, so it could become an absolute path. The only option that worked well was `eval`, and that's the trouble. So, in this case `/usr/lib/` does have special symbols on it, so it stays the same, but the malicious shell would execute.

By the way, this is an issue I happened to be aware of very lately. So I do totally discourage you to use Neostow Shell with `.neostow` files provided by someone else without reviewing it first.

## Nim

The Nim version was the second edition. This was my first project using Nim, and I absolutely hated to write Nim. Maybe, it's just me, but I find Nim to be a very complicated language, with absolutely all the features possibly known built-in. I don't really get why a language would have parametric polymorphism and function overloading at the same time, but it seems the standard library adheres more to the later one.

Nim is basically Python meeting the speed of C. So you have a very bad way to handle errors with exceptions.

Let's stop talking the bad things about it. Nim has automated documentation generation from your code comments. Interacting with C is fairly easy, has some caveats, tho. It also has static typing, to make your code more explicit, and of course, it can compile to either C or C++.

Nim seemed to be perfect to me, mainly because it had many abstractions to write programs like you would in Python, but without many worried you would get in C. So, it translates to fast development and fast runtime.

Where did it fall apart? Packaging. Nimble is the official Nim package manager, which is decentralized. Amazing! But when you try to add a library or install a binary using it, you may have issues, and such issues cannot be fixed by you. At least, not for me as a mere beginner to this language. I know things can improve, but I expect at least these things should just work fine. Everything else could be bad, but I should get my library or program and be happy.

## C

The third edition. This was my second C project at the time, and equally to the first, I have no ideas on how many vulnerabilities this program has. It has the right logic, it works like I expect to, and Valgrind doesn't show up leaks. Nice for a beginner like me.

It took me over a month to realize the major issues with memory related issues, which are mostly represented by strings. In C, strings are arrays of characters ended with a null-terminated character that defines the end of the string. Many functions from the standard library rely heavily on this fact. If a supposed string happens to do not have a null-terminated character, either by a bad processing or if it has never set, these functions can traverse beyond the string boundaries. This could write to somewhere where you program does not own, and then causing issues you may, or may not find out.

So, I was very smart, and decided to "why not to write a string library that does not sucks?". TLDR, it's worse. It works correctly, and has the behaviour I want, however it's about 8 times slower. I was allocating strings in the heap, always updating their memory size and length. If I was not about to modify a string, I would just use a `const char *` instead. When I partially finished this library, and I was slowly integrating it to my Neostow program, I realized something very important. All my strings was allocated in the stack. So I had to transition all strings to be heap allocated and it just messes everything up. I would have to basically rewrite a worse version of Neostow to supposedly be safer than the original one. How would I ultimately declare it as a beginner? Be realistic!

I don't know what's about C, but this language bring me so much joy to write. It's just a shame that I have to keep so many variables in my head and remember some many things, having the risk to forget important things. One, being freeing memory. In the beginning it seems to be so obvious: "Of course, when you `malloc`, you `free`. Not hard, is it?". Oh, yeah it's simple as that when it's just a `malloc` and a `free` in a learning material. But in a real project, a `free` will only happen very later in the program, and you may forget that a variable was heap allocated. Not a big deal, when you can debug and inspect the memory with some tools, but the problem is that these tools are absolutely required, like opt-out. Another thing, is that there are few abstractions in C. I already found myself modifying a variable `b` indirectly, while modifying `a` directly, where `b` was right after `a` in memory, and such operation was writing out of the bounds of `a`.

I love how simple C is, but I would love it even more, if it was simpler to just write things that work, without these nice caveats. That's the main reason I'm looking after Zig and Odin. I want to just enjoy programming like I did with many Bash scripts, but embrace more control. And there is no better language than C for that. It is simple and give me power, or, at least in theory where everything makes sense and is easy to follow. But in practice it just makes sense to use C, when you know by heart what each function does.

## Rust

The fourth and last edition. Writing Rust is a thing. A terrible thing.

I can totally sit back, tell you that this is blazingly fast, it compiles and works. Jokes aside, I actually recommend you to use Neostow Rust if you are interested in Neostow. At least this one doesn't have the same surface of vulnerabilities that C has, neither the potential to execute malicious commands like the Shell version. Kinda hot spot. But really? Don't tell me the enums are unions, that a Path looks like a string, but it's not a string, or to use `cargo` to add libraries I don't want.

What a complex language do we have here. That's fine, but do I get the same joy as C? Definitively not. I don't know why, it's just not fun. After stepping hardly on C for its pitfalls, and moving my project to Rust, because "it's safer, it's blazingly fast, it prevents you many problems at compile time, and blah blah".

The industry seems to be moving towards Rust, but do I, as a mere programming hobbist, ever need to consider learning it? I tried, and this project is a proof of that. But I don't want to write Rust, and I'll write Rust. Wait, what?

While C gives me simplicity and the power to do a lot. But not only that! I'm reducing its relevance. Whenever you need to do anything more in-depth with another library (C library) or interact directly to the Kernel, C is that language that reigns it, and has first-class support for such operations. Does it matter for me? No. Whenever I need to something in C, it gotta be done from scratch. Write my own library, for everything. Do I need embedded programming? No. Do I need absolutely max performance? No. Can I even optimize something to be performant now? No. Do I want to bother setting up the build process for every library and project? Yes.

Cargo has a huge pro, and an inevitable con. It's an excellent package manager that allows you to compile your whole project without having to manually setting everything up with either GNU Make, Cmake, Meson, or Ninja. It just works. Want to install it? Run `cargo install $package`, and it just works. How cool would I just write my program, publish it in cargo.io, and be able to just get it and compile locally in a very easy way? That's beautiful! But Cargo happens to create a dependency monster when it comes to adding libraries from other people. That's my number one complain with it. The solution? I just don't use third party libraries. I make my own.

Clap good? Clap good. Do I wanna use it? Yes. Do I want to make my own Clap? Sure.

## The Dilemma

Currently the only stable languages that makes sense to learn and use are C and Rust. I know, there are many other languages, but I do restrict myself to languages where I have control. I want to develop CLIs, TUIs, and libraries for them. I don't want to mess around with ML, web development and even worse: designing a web page, it gives me chills.

I've already mentioned Zig and Odin, which are not stable yet, and still have a long journey to become so. But these two may be the experience I wanted from C that I didn't got. I really want to write C, but I'm not sure if I should. The same for Rust. I want to want to write Rust, but I don't feel like so. And, this place where I am, is very interesting. Only time will tell us what to expect from C in the future. Will it die? I'm sure it won't, but, it may become a legacy of projects, and the rate, which new projects uses C, may decrease.

Who ever knows? I just wanted to learn one piece of language to master the field I want, and don't have to bother switching in the following decades. A language that is stable and here to stay. C or Rust? Here is the dilemma.
