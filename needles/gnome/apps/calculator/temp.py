#!/bin/python

import glob
import shutil

for fn in glob.glob("calc_button*.json"):
    basename = fn.split(".")[0]
    newjson = f"{basename}-flatpak-20220808.json"
    newpng = f"{basename}-flatpak-20220808.png"
    shutil.copy2(fn, newjson)
    shutil.copy2("/tmp/old.png", newpng)
