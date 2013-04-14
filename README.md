# About
My .emacs.d files.

# Prerequisites
* w3m
* cmigemo

# Usage
## for Mac OS X
1. Use Automator. Choose `Run shell script` and set it up like below:  
'''bash
/Applications/Emacs.app/Contents/MacOS/Emacs -q --debug-init -l ~/src/dotemacs/init.el &
'''
1. Save the workflow as an Application for your convenience.
