CookUp
======

Description
-----------

Easy build from source and install tool for UNIX platforms (using perl)

Rationale
---------

Cookup was inspired on homebrew (https://github.com/mxcl/homebrew) for MacOSX
but it aims to be simpler and not as complete.

It is a tool with minimal requirements to build and install software on super computers 
and clusters that often do not have Ruby or Python. Somewhat old versions of Perl seem
to be always available on such HPC systems.

The initial code for cookup was based on the install-deps.pl script from the
http://github.com/coolfluid/coolfluid3 project, but improved with object oriented perl features.

In cookup each package is cooked (built & installed) following a recipe which is a simple Perl class (homebrew brews formulas, cookup cooks recipes).

Requierements
-------------

* C/C++ compiler
* Perl 5

* Fortan compiler [optional]

Available Recipes
-----------------

https://github.com/tlmquintino/cookup/tree/master/cookbook

