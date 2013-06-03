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
open /Applications/Emacs.app --args -q --debug-init -l ~/dot-emacs/init.el --chdir ~ &
```
1. Save the workflow as an Application for your convenience.

## for Windows
1. Create a shortcut with option `--debug-init -l ~/src/dotemacs/init.el`
1. Make sure your `install-info` is that of the GNU Win 32 distribution of TexInfo for windows.  
cf. https://github.com/dimitri/el-get#installation-dependencies

# Notes
1. It takes several minutes to start up for the first time.
1. Initialization often fails due to `el-get`(or Emacs itself).
To avoid this, activate the frame and keep moving the mouse pointer on the frame.  
cf. https://github.com/dimitri/el-get/issues/698
