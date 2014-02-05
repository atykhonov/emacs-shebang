# Emacs package which helps insert shebang

## Installation

Assuming that the file `shebang.el` is somewhere on the load path,
add the following lines to your `.emacs` file:

```
(require 'shebang)
(global-set-key "\C-c b i" 'shebang-insert)
(global-set-key "\C-c b I" 'shebang-insert-at-point)
```

Change the key bindings to your liking.

## Commentary

`shebang-insert` queries for a command and inserts shebang line for
it.

For example an execution of such command:

```
M-x shebang-insert RET python RET
```

will insert at the beginning of buffer shebang line like:

```
 #!/usr/bin/python
```

With a `C-u` frefix `shebang-insert` queries for a command and
insert shebang line for `env` and a command. `env` is a programm
from GNU Coreutils (sample location: /usr/bin/env).

As example an execution of such command:

```
C-u M-x shebang-insert RET perl RET
```

will insert at the beginning of buffer shebang line like:

```
 #!/usr/bin/env perl
```

There is also `shebang-insert-at-point` which behaves in the same way
as `shebang-insert` except that it inserts shebang at point instead of
beginning of buffer.
