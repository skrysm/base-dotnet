# Line Endings in C# Files

The default line ending type defined in `.editorconfig` is `LF` (Linux/Unix line endings). So ideally, C# files (`.cs`) should also use `LF` as line ending type.

Unfortunately, this is not possible because Linux line endings are not *fully* supported by Visual Studio and ReSharper (the primary editors for C# code).

Without *full* support, when editing C# files you'd sometimes get Linux line endings (as defined by `.editorconfig`) and sometimes Windows line endings (for features that don't support Linux line endings or `.editorconfig`) - resulting in files with **mixed line endings**.

In other editors (like Visual Studio Code) this would not be a problem because they would **normalize the line endings** when saving a file. Unfortunately, Visual Studio does *not* do this (see [feature request](https://developercommunity.visualstudio.com/idea/1296741/normalize-line-endings-on-save-according-to-editor.html)).

So, for now, the pragmatic approach is to define line endings for C# files as `CRLF` (Windows line endings).

If the bugs down below will ever all get fixes, this decision can be reverted.

## Bugs

This section tracks the various bug reports regarding missing Linux line ending support.

### Visual Studio

None known.

### ReSharper

* <https://youtrack.jetbrains.com/issue/RSRP-478837>
