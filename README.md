# About
My .emacs.d files.

# Prerequisites
* w3m
* cmigemo

# Usage
## common
1. Clone the repository  
```bash
git clone git@github.com:yewton/dot-emacs.git ~/yewton.emacs.d
```
2. Initialize submodules  
```bash
cd ~/yewton.emacs.d
git submodule init
git submodule update
```

## for Mac OS X
1. Use Automator. Choose `Run shell script` and set it up like below:  
```bash
/Applications/Emacs.app/Contents/MacOS/Emacs -q --debug-init -l ~/src/dotemacs/init.el &
```
1. Save the workflow as an Application for your convenience.

## for Windows
1. Create a shortcut with option `--debug-init -l ~/src/dotemacs/init.el`

# Notes
1. It takes several minutes to start up for the first time.
1. Initialization often fails due to `el-get`(or Emacs itself).
To avoid this, activate the frame and keep moving the mouse pointer on the frame.  
cf. https://github.com/dimitri/el-get/issues/698
1. Automatic `(el-get-install package)` often fails also.
Install it manually using `el-get-install` if the installation failed.
