# ZX Spectrum MiniLib

A very small alternative ZX Spectrum CRT library for z88dk.

This library is designed to provide support for Z88DK C development on
the ZX Spectrum and ZX Spectrum Next that aims for minimal memory use
by relying on ROM routines rather than z88dk library code where possible.
It throws away the stdio provided by z88dk, replacing it with a much more
bare-bones version based on the I/O streams provided by the ROM.

But in one sense, despite being minimal, it provides a better
experience when it comes to input than the stdio provided by z88dk,
using the ROM routines that are used for the `INPUT` command in Basic,
thereby allowing interactive line editing.  But it actually provides
an even better experience, allowing the last line entered to be
recalled (very useful for REPLs), or other, more sophisticated input
routines with pre-prepared input for the user to edit.

* On a ZX Spectrum, press cursor-down to recall the last line.
* On a ZX Spectrum Next, press shift-return to recall the last line.
