# CMPS 260 Assignment 2 - README

## Problem 0: Setting Up The Environment

### What does pwd do?
`pwd` (print working directory) displays the absolute path of the current directory you are in. It shows your location in the filesystem hierarchy.

### What does whoami do?
`whoami` displays the username of the current user. It shows which user account you are logged in as.

---

## Problem 1: UNIX Filesystem + Shell

### Why do `ls ; date` and `ls ";" date` behave differently?

- `ls ; date`: The semicolon (`;`) acts as a command separator, so this runs two separate commands: first `ls`, then `date`.
- `ls ";" date`: The semicolon is inside quotes, so it's treated as a literal argument to `ls`. This tries to list files named `;` and `date`, which likely don't exist.

The key difference is that without quotes, `;` is a special shell metacharacter, but with quotes it's treated as a regular character.

### What happens in Step 6?

The command `mkdir -p data/projects/{raw,processed} data/{notes,archive}` uses:
- `mkdir -p`: Creates directories and parent directories as needed (no error if they exist)
- Brace expansion `{raw,processed}`: Expands to create both `raw` and `processed` subdirectories
- This single command creates the entire directory structure: `data/projects/raw`, `data/projects/processed`, `data/notes`, and `data/archive`

### Explain what happened from Step 17-21 (umask)

`umask` sets the default permissions for newly created files and directories by specifying which permissions to "mask out" (remove).

1. Initial `umask` value (typically 022) creates files with 644 permissions (rw-r--r--)
2. Created `u_before.txt` with default permissions
3. Changed `umask` to 077, which masks out all group and other permissions
4. Created `u_after.txt` with more restrictive permissions (600: rw-------)
5. The two files show different permissions based on the umask value when they were created

### Explain what happened in Step 23-24 (Links)

**Step 23**: Created two types of links:
- **Hard link** (`hardlink.txt`): Points directly to the same inode (data) as the original file. Both files are equal references to the same data.
- **Symbolic link** (`symlink.txt`): Points to the pathname of the original file, like a shortcut.

**Step 24**: After deleting `link_target.txt`:
- The **hard link still works** because it points directly to the data (inode), which still exists
- The **symbolic link is broken** because it points to a pathname that no longer exists
- This demonstrates that hard links preserve data even when the original filename is deleted, while symbolic links become broken.

### Explain what happened from Step 29-30 (diff and cmp)

Created two similar files with one difference:
- `a.txt`: contains "walnuts"
- `b.txt`: contains "grapes"

**diff output**: Shows line-by-line differences in a human-readable format (line 3 changed from "walnuts" to "grapes")

**cmp output**: Shows the byte and line position of the first difference. It's more suited for binary files or quick checks if files are identical.

Both tools compare files, but `diff` is better for text files and showing what changed, while `cmp` is faster for just detecting if files differ.

---

## Problem 2: Processes, Filters and Pipes

### Why are pipelines preferred over the "file approach"?

Pipelines are preferred because they:
1. **Avoid temporary files**: No need to create, manage, and clean up intermediate files
2. **Save disk space**: Data flows through memory, not stored on disk
3. **Improve performance**: Commands run concurrently, processing data as a stream
4. **Simplify code**: More readable and concise than creating multiple temporary files
5. **Real-time processing**: Data can be processed as it's generated without waiting for complete file writes

Example: `cat data/log.txt | wc -l` is cleaner than `cat data/log.txt > temp.txt; wc -l temp.txt; rm temp.txt`

---

## Problem 3: Regular Expressions

### Why is fgrep useful for fixed strings?

`fgrep` (or `grep -F`) treats the search pattern as a fixed string rather than a regular expression. This is useful when:

1. **Searching for literal special characters**: Characters like `*`, `^`, `$`, `.`, `[`, `]` are treated as regular characters, not regex metacharacters
2. **Performance**: Faster than regex matching since it doesn't parse patterns
3. **Simplicity**: Don't need to escape special characters

For example, searching for the literal string `a*b*` with `fgrep 'a*b*'` finds the exact string, while `grep 'a*b*'` would interpret `*` as "zero or more of the previous character" and match different strings.

---

## Summary

This assignment covered:
- File system navigation and manipulation
- Permission management with chmod and umask
- Understanding links (hard vs symbolic)
- Process management and job control
- Text processing with filters and pipes
- Regular expressions with grep, egrep, and fgrep
- Text transformation with tr and sed

All outputs have been saved to the `outputs/` directory, and scripts are in the `scripts/` directory.
