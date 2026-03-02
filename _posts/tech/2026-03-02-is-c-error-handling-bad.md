---
title: Is C error handling bad?
description: A take on C error handling design
date: Mar 02, 2026
---

While learning C we quickly notice C is fairly limited when it comes to error handling. Because of that, there were many attempts of improving it, with pure C. A great example is `errno`, which allows you to set an error somewhere else, but with its own caveats, not replacing the fact the function must return a signal rather an error occurred.

Ultimately, a decent `errno` style error handling somewhat requires the C11 `_Thread_local` keyword, so it's safe to use in multi-threaded programs. Otherwise, the LibC implementation doesn't seen to be any good idea for personal use. At least, for what I currently know. And if you actually inspect the LibC, particularly the Musl LibC, it's fairly obscure to understand it.

In the very early stages, when I was working with `aoclibs`, I thought I could have a struct that contains an error code and message, with the type you want to return:

```c
typedef struct {
    int code;
    const char *;
} Error;

typedef struct {
    Error err;
    int value;
} ErrInt;
```

This approach has a maintenance burden and may mostly waste memory.

The most used approach involves signalizing the error with the returned value. For instance, returning signed integer, when negative to tell there was an error. Or maybe a boolean, for simplicity. This approach also has a downside. What if I wanted to return an error, but the type is an struct? The only option is to return a zero initialized struct...

In case the struct was heap allocated, returning NULL would do it.

One of my latest attempts to make something smart out of it has turned into this:

```c
#define catch ; if (err != 0)
```

So then you can use it as follows:

```c
char err = 0;
int result = add(10, 20, &err) catch printf("Error!\n");
```

Greatly `err` could be an enum, for exhaustive error handling.

Although it's visually nice, it's dependent in a convention where `err` serves this sole case.

But honestly, for situations like this, we may prefer take a pointer to the type from the caller function, set the result to it and just return an int to signalize success or error. That's the end game.

Back to the struct situation, this is preferable, since returning an empty struct is useless.

Also, while exploring other programming languages, I found many approaches interesting, being the Go's approach the cleanest, with multiple return values and `if err != nil` error handling. Other languages like Rust take it, maybe too far with a whole new concept of Some and None. The Zig approach seems nice, with first-class support for an error type, but it's rather involving. It's easier to feel trapped step into a backward incompatible change.

But as an overview, I don't believe a good mechanism would require a special keyword or so. That's why I think Go's approach is the best, although it may get old fast.

The biggest drawback of developing any fancy solution to it, is that it may get overcomplicated very fast, given the constraints of C.

At the of the day, does C really need any better solution? Or the modern programming languages are trying to inject complexity for no real gain? By this perspective, they make C look poor.

In the end I just wasted my time, trying to bring a better error handling, that was not necessary, because other languages kind of shaped my idea of how error handling should be.

There some things that are only worth it experimenting yourself, rather than check on the opinion of other people, for what is the "best".

Shall simplicity be the endgame of programming.

```c
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool return_hello_world(char **s) {
    assert(s != NULL && "Passing invalid pointer");
    char *hello_world = "Hello, World!";
    int hello_buff = strlen(hello_world) + 1;
    *s = malloc(hello_buff);
    if (!s)
        return false;
    bool err = memcpy(*s, hello_world, hello_buff) == NULL;
    if (err) {
        free(*s);
        return false;
    }
    return true;
}

int main(void) {
    char *buff = NULL;
    if (!return_hello_world(&buff)) {
        fprintf(stderr, "Failed to retrieve the \"Hello, World!\" string\n");
        return 1;
    }
    printf("%s\n", buff);
    free(buff);
    return 0;
}
```
