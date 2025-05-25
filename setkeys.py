#!/usr/bin/env python3

import os
import subprocess

def exec(cmd, capture=False):
    return subprocess.run(cmd, shell=True, check=True, text=True, capture_output=capture)

PATH = os.path.expanduser("~/.ssh/default_keys")

if os.path.exists(PATH):
    with open(PATH, 'r') as file:
        for line in file:
            exec(f"ssh-add {line.strip()}")
