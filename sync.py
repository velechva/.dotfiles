#!/usr/bin/env python3

import subprocess
import sys

def print_help_and_exit():
    print("Syntax: ./sync.py <command>\n\nWhere <command> is one of:\n\tload\n\tsave")
    exit(-1)

def run_or_panic(cmd):
    print(cmd)
    # return subprocess.run(cmd.split(' '), shell=True, check=True, stdout=subprocess.PIPE)

FILES = {
    "zsh/.zshrc": "~/.zshrc",

    "git/.gitconfig": "~/.gitconfig",

    "vs-code/settings.json": "~/Library/Application\ Support/Code/User/settings.json",
    "vs-code/keybindings.json": "~/Library/Application\ Support/Code/User/keybindings.json",

    "vim/.vimrc": "~/.vimrc"
}

def save():
    for repo_path in FILES:
        system_path = FILES[repo_path]

        save = "%s %s" % (system_path, repo_path)
        print(save)
        run_or_panic(save)

def load():
    for repo_path in FILES:
        system_path = FILES[repo_path]

        backup = "cp %s %s.bak" % (system_path, system_path)
        run_or_panic(backup)

        load   = "cp %s %s"     % (repo_path,   system_path)
        run_or_panic(load)

if len(sys.argv) < 2:
    print_help_and_exit()

cmd = sys.argv[1]

if cmd == "load":
    load()
elif cmd == "save":
    save()
else:
    print_help_and_exit()
