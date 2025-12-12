---
title: Writing my own C standard library
description: I've been building my own sort of standard library for C. It's just an abstraction layer on top of the C std, but additional modifications to bring new features. Check out how it was been going.
date: Dec 11, 2025
---

## Introduction

You can skip to [`Why aoclibs`](#why-aoclibs), if you mind reading my trajectory to choosing C. You can also find the project repository [here](https://codeberg.org/aocoronel/aoclibs), and the page for it [here](https://aocoronel.codeberg.page/projects/aoclibs/).

I've been searching for a programming language to learn, and mostly important, to rely on. I've tried many, and you can check out my general thoughts in this post.

As I have already said, I'm not professional, and I take programming and Linux as my hobby. It's important to point this up, since my overview about things are totally based on the internet and videos, which shaped the way I look to Linux and programming in general.

Having that said, I was looking for a programming language that I could write programs that has good performance, and that would be easy to write and read. By this tiny statement, we can already discard a bunch of programming languages like Python, Lua, JavaScript, Ruby and many others. These languages depends on an interpreter, thus the execution is often slow. Even if my programs are simple, I still can't think of eventually writing a Python script I have to run several times per day, and pass part of the time waiting. Although, Python is a great language to improve my scripts, based on my long background with Bash and POSIX shell scripts. And I do have some scripts written in Python, but are not ran all the time, but for very specific scenarios.

After taking these "high level" programming languages, there are just a few others I can choose: Nim, Go, Rust, C, C++, Odin and Zig. Maybe even assembly, but easy to read.

Go and Nim are fairly good programming languages, but they fail in the fact they rely on a garbage collector. Nim can go manual memory management, but that seems to discouraged anyway. For simple programs, Go is too overkill, since it produces massive binaries. I just imagine myself writing my 30+ shell scripts into Go, which obviously I wouldn't do, but for hypothesis I would have around 100 MB in binary. I completely dislike this, although I know this characteristic is relevant when deploying code into a different machine without bundling many other dependencies with it, its all in a single binary that runs fast. And for curiosity, there is just two commands in my system that are written in Go: rclone and restic. Not really that mainstream for CLIs.

Then we have Odin, which I just see as Go, but without the GC, and why many quality of life improvements. However, just like Zig, these two languages are prone to change. I really needed a language that I could write once, and run it for years. These are not ready, yet.

Rust is a big contendor, but it fails me for many things. I love many concepts of Rust, but in the end its just C++ with the borrow checker. After learning a bit of C++, and actually written a bit of Rust, its obvious that Rust took a lot of inspiration from it, improving some parts, while worsening others.

C++ seemed to be interesting, like a better way to write libraries with namespaces, so name collisions are less likely compared to C. Templates and parametric polymorphism looked nice to, to write some functions that operates the same way for different types, thus keeping a simpler API usage. I thought: "If I use these features wisely, I could go so far!". Then I put my hands on the code, visited the string library header file and saw a non-stop, line after line definition of thousands of templates. They don't even explain me what is going on!

So the only option left: C. But is it really the one? I just like the fact I could learn C in a weekend, differently than Rust that I've took a whole week to barely learn the basics. C has few features, no interfaces, no methods, no OOP, no multiple value return (although, I would love this). It barely has modern features. But it makes the code easy to reason about, because there isn't a whole bunch of concepts you must think to write a line of code, greatly decreasing mental load, thus improving my speed I add new features. C sucks for not providing a better way to free memory or deinit things, like we would with the `defer` keyword in other languages. There are many, and many compile time warnings we can just ignore, and many warnings that are not even gonna be thrown, and then increasing the chances of an unwanted and pesky bug at runtime. Memory leaks are a reality, if you free twice or don't free, you are cooked. Have I already mentioned memory leaks? A major thing Rust tries to solve, it does, but not always.

End of talk. C is a simple language, that provides all the flexibility and control I want. Even if it's not perfect, its the only language that has many sources available around for over 50 years, backed by a big community and huge diversity with its tooling. I am here, to sum with the C programming language, as opposed to go on the hype train, which is the Rust adoption, and fail to provide code, that any outsider can read and contribute to. And if I fail to deliver a good quality code with less than 70% of memory related issues, I'll regret not have learned the Zig programming language earlier and support the project.

Learning C is necessary, so it can give me the insights on why people don't choose it for new projects in the same rate as other languages.

## Why aoclibs

I need abstractions to boring tasks, but I don't want to rely on the code of other people.

C is very barebones and the standard library provides very low level tools, that sometimes are flawed and may cause memory issues. The big thing behind my own library is provide a new convention and standard that is ultimately easy to read and reason about. Inspired by other languages, I'm trying to replicate some features in C on what possible with just code.

By providing higher abstractions to many tasks that would require a lot of attention and boilerplate, I could, perhaps, write C more safely and with more confidence by being the owner of the code that my projects are based on. This means stability in the long run, after the conventions are fully established.

First I thought myself the C standard library, or at least glibc is messy. If you go inspect stdio.h, string.h or anything else, I doubt you will understand what the several macros are doing. Them I believed I could just write the whole standard library from scratch for real. This is not really the best idea, since I just run Linux and I can't take the time to write an assembly file for each platform. This is the biggest downside of doing so.

But not everything relies on the kernel. There are several functions from string.h I've rewritten using just C code. Just like strlen, strcat and strcpy. I've wrote a version of these functions that explicit request the buffer and length of the strings, so they are strongly bounds-checked and contained to their buffers, without sacrificing on creating a struct to store these data. Differently than my String implementation, which is heap allocated, I store it in a struct and all functions associated to String do update the values from this struct.

Besides the reimplementation of the C std in some parts, I'm also writing some abstractions to it. Tasks like recursively reading a directory, printing debug messages, asserting, testing, fuzzing requires a lot of work to implement. So, then, it should be easier to embark in these operations.

## How has it been

I've had some spikes of development, and lately I had many changes on the convention and layout of the project. I've finally written most conventions I may need to stop changing naming and finally write code in a way that feels natural and cohese against the rest of the codebase. I also reached a point I'm more confident I can search my codebase and find exactly what I want, due to it.

There are just a few features, while must notably an error struct for each type, an alias for the stdint.h, the String type, the Heap type, rewrites to some C std functions, abstractions to others, and a memory debugger.

I still plan to add at lot of more modules as I need to.

## Conclusion

I think I made the right choice in picking C. I hope so.

My current main focus is the reason about my current convention and establish it once and for all, so I can focus full-time to write new features. And then, rewrite my C projects that came before aoclibs.

This is a very personal project in contestant to the modern approach of adding new features to a project like `go get this` or `cargo add that`, then compile code that run off the standards of your project.
