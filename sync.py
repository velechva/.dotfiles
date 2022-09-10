#!/usr/bin/env python3

import subprocess
import sys
import os

env_home = os.getenv('HOME')

def print_help_and_exit():
    print('Syntax: ./sync.py <command>\n\nWhere <command> is one of:\n\tload\n\tsave')
    exit(-1)

def run_or_panic(cmd):
    print('Executing: ' + ' '.join(cmd))
    output = subprocess.run(cmd, shell=False, check=True, stdout=subprocess.PIPE)
    if (output.stderr):
        print(output.stderr)

def fix_path(path):
    return path.replace('~', env_home)

RAW_FILES = {
    'zsh/.zshrc': '~/.zshrc',

    'git/.gitconfig': '~/.gitconfig',

    'vs-code/settings.json': '~/Library/Application Support/Code/User/settings.json',
    'vs-code/keybindings.json': '~/Library/Application Support/Code/User/keybindings.json',

    'vim/.vimrc': '~/.vimrc'
}

FILES = {}
for file in RAW_FILES:
    FILES[fix_path(file)] = fix_path(RAW_FILES[file])

def save():
    for repo_path in FILES:
        system_path = FILES[repo_path]

        # save = 'cp %s %s' % (system_path, repo_path)
        save = ['cp', system_path, repo_path]
        run_or_panic(save)

def load():
    for repo_path in FILES:
        system_path = FILES[repo_path]

        # backup = 'cp %s %s.bak' % (system_path, system_path)
        backup = ['cp', system_path, '%s.bak' % system_path]
        run_or_panic(backup)

        # load   = 'cp %s %s'     % (repo_path,   system_path)
        load = ['cp', repo_path, system_path]
        run_or_panic(load)

if len(sys.argv) < 2:
    print_help_and_exit()

cmd = sys.argv[1]

if cmd == 'load':
    load()
elif cmd == 'save':
    save()
else:
    print_help_and_exit()
