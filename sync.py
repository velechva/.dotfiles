#!/usr/bin/env python3

import subprocess
import sys
import os

# Maps relative paths within the code repo to paths relative to $HOME
FILES_TO_SYNC = {
    'zsh/.zshrc': '~/.zshrc',

    'git/.gitconfig': '~/.gitconfig',

    'vs-code/settings.json': '~/Library/Application Support/Code/User/settings.json',
    'vs-code/keybindings.json': '~/Library/Application Support/Code/User/keybindings.json',

    'vim/.vimrc': '~/.vimrc'
}

env_home = os.getenv('HOME')
if env_home is None or len(env_home) < 1:
    print("Missing $HOME environment variable")
    exit(-1)

def print_help_and_exit():
    print('Syntax: ./sync.py <command>\n\nWhere <command> is one of:\n\tload (repo -> system)\n\tsave (system -> repo)')
    exit(-1)

def run_or_panic(cmd):
    print('Executing: ' + ' '.join(cmd))
    output = subprocess.run(cmd, shell=False, check=True, stdout=subprocess.PIPE)
    if (output.stderr):
        print(output.stderr)

def process_path(path):
    return path.replace('~', env_home)

# Process each (key, value) in `FILES_TO_SYNC` and put it in `files`
files = {}
for file in FILES_TO_SYNC:
    files[process_path(file)] = process_path(FILES_TO_SYNC[file])

def save():
    for repo_path in files:
        system_path = files[repo_path]

        save = ['cp', system_path, repo_path]
        run_or_panic(save)

def load():
    for repo_path in files:
        system_path = files[repo_path]

        backup = ['cp', system_path, '%s.bak' % system_path]
        run_or_panic(backup)

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
