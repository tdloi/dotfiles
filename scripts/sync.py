#!/bin/python3
import os
from subprocess import Popen, PIPE
from shutil import which, copy2
from time import time

OVERRIDE = True

LIST_FILE_SYMLINK = [
    '.bashrc',
    '.xinitrc',
    '.profile',
    '.zshenv',
]

# List of folder/file need to be symlinked
# It is relative to current .config folder
LIST_CONFIG_SYMLINK = [
    "alacritty",
    "cmus",
    "fcitx",
    "fontconfig",
    "i3",
    "mpv",
    "pulse",
    "rofi",
    "zsh",
]

# List folder to copy outside of .config
LIST_FOLDER_COPY = [
    '.icons',
    '.mozilla',
]

LIST_FOLDER_IGNORE = [
    '.config/xfce4',
]

HOME = os.getenv('HOME')
HOME_CONFIG = os.getenv('HOME_CONFIG')
DOTFILES = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
DOTFILES_CONFIG = os.path.join(DOTFILES, '.config')

LIST_SYMLINK = ['.config/' + i for i in LIST_CONFIG_SYMLINK] + LIST_FILE_SYMLINK
LIST_CONFIG = ['.config/' + i for i in os.listdir(DOTFILES_CONFIG)] \
              + LIST_FOLDER_COPY \
              + LIST_FILE_SYMLINK


class log:
    """ Print a message to terminal """

    @classmethod
    def info(self, message):
        print("\033[0;32m" + message + "\033[0m")

    @classmethod
    def error(self, message):
        print("\033[0;31m" + message + "\033[0m")

    @classmethod
    def warn(self, message):
        print("\033[0;33m" + message + "\033[0m")


if which('fd') is None:
    log.error('fd package is not installed. Please install and try again')
    quit()

if OVERRIDE:
    log.warn('Running in OVERRIDE mode')


timestart = time()
for fi in LIST_CONFIG:
    path = os.path.join(DOTFILES, fi)

    if os.path.isfile(path):
        if os.path.exists(os.path.join(HOME, fi)) and OVERRIDE:
           os.remove(os.path.join(HOME, fi))

        # Check again to avoid error in case OVERRIDE is off
        if not os.path.exists(os.path.join(HOME, fi)):
            if fi in LIST_SYMLINK:
                os.symlink(path, os.path.join(HOME, fi))
            elif f:
                copy2(path, os.path.join(HOME, fi))

    if os.path.isdir(path):
        # Use fd for life easier
        lsdir, err = Popen(['fd', '--type', 'file', '.', path],
                           stdout=PIPE).communicate()
        lsdir = lsdir.decode().strip().split('\n')

        for f in lsdir:
            dest = f.replace(DOTFILES, HOME)

            if not os.path.exists(os.path.dirname(dest)):
                os.makedirs(os.path.dirname(dest))

            if os.path.exists(dest) and OVERRIDE:
                os.remove(dest)

            if not os.path.exists(dest):
                # Extract basename
                basename = '.config/' + f.replace(DOTFILES, '').split('/')[2]
                if basename in LIST_SYMLINK:
                    os.symlink(f, dest)
                elif basename not in LIST_FOLDER_IGNORE:
                    copy2(f, dest)


print()
log.info(f'Complete in {time() - timestart:.3f}s')
