# About
My .emacs.d files.

# Prerequisites
* w3m
* cmigemo
* automake
* cvs
* git
* aspell

# Usage
## common
* Clone the repository with submodules

```bash
git clone --recursive git@github.com:yewton/dot-emacs.git ~/yewton.emacs.d
```


## for Mac OS X
Use Automator. Choose `Run shell script` and set it up like below:

```bash
open /Applications/Emacs.app --args -q --debug-init -l ~/yewton.emacs.d/init.el --chdir ~ &
```
Save the workflow as an Application for your convenience.

## for Windows
1. Create a shortcut with option `--debug-init -l ~/yewton.emacs.d/init.el`
1. Make sure your `install-info` is that of the GNU Win 32 distribution of TexInfo for windows.  
  cf. https://github.com/dimitri/el-get#installation-dependencies

## for Lubuntu
1. Create a shortcut with option `/usr/bin/emacs24 -q --debug-init -l ~/yewton.emacs.d/init.el`

# Notes
1. It takes several minutes to start up for the first time.
1. Initialization often fails due to `el-get`(or Emacs itself).
To avoid this, activate the frame and keep moving the mouse pointer on the frame.  
cf. https://github.com/dimitri/el-get/issues/698
