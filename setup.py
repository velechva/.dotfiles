import sys
import os
import subprocess

from enum import Enum

def exec(cmd, capture=False):
    return subprocess.run(cmd, shell=True, check=True, text=True, capture_output=capture)

def git_clone(repo, dest, depth=None):
    flag_depth = '' if depth is None else f'--depth={depth}'

    exec(f'git clone {flag_depth} {repo} {dest}')

def brew_install(pkg):
    exec(f'brew install {pkg}')

def apt_update():
    exec(f'sudo apt-get update')

HAS_UPDATED_APT = False

def apt_install(pkg):
    global HAS_UPDATED_APT

    if not HAS_UPDATED_APT:
        apt_update()
        HAS_UPDATED_APT = True

    exec(f'sudo apt-get install -y {pkg}')

class OS(Enum):
    OSX     = "Darwin",
    LINUX   = "Linux",

def get_os():
    return OS[exec("uname -s", capture=True).stdout.strip()]

class ARCH(Enum):
    X86_64  = "X86_64",
    ARM_64  = "ARM_64",

def get_arch():
    return ARCH[exec("uname -m", capture=True).stdout.strip()]

def get_dotfiles_dir():
    return os.path.dirname(os.path.realpath(__file__))

PATHS_APPENDED = []

def append_path(path):
    if path in PATHS_APPENDED:
        print(f'Path {path} already appended. Skipping.')
        PATHS_APPENDED.append(path)

    exec(f'echo "export PATH={path}:$PATH" >> ~/.zshcustom')

def rm(path, force=False, recurse=False):
    force_flag      = '-f' if force   else ''
    recurse_flag    = '-r' if recurse else '' 

    exec(f'rm {force_flag} {recurse_flag} {path}')

def curl_untar(url, fname):
    exec(f'curl -L0 {url}')
    exec(f'tar xzf {fname}')

class BasicInstaller:
    def __init__(self, name):
        self.name = name

    def linux(self):
        apt_install(self.name)

    def osx(self):
        brew_install(self.name)

class Fzf:
    def common(self):
        git_clone("https://github.com/junegunn/fzf.git", "~/.fzf")
        exec("~/.fzf/install")

class Neovim:
    def osx_silicon(self):
        curl_untar('https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz', 'nvim-macos-arm64.tar.gz')
        exec('cp ./nvim-macos-arm64/bin/nvim /usr/local/bin')
        rm('./nvim-macos-arm64', force=True, recurse=True)

    def osx(self):
        curl_untar('https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz', 'nvim-macos-x86_64.tar.gz')
        exec('cp ./nvim-macos-arm64/bin/nvim /usr/local/bin')
        rm('./nvim-macos-arm64', force=True, recurse=True)

    def linux(self):
        fname = 'nvim-macos-x86_64.tar.gz'
        curl_untar("https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz", fname)
        rm("/opt/nvim", force=True, recurse=True)
        exec("sudo tar -C /opt -xzf nvim-linux64.tar.gz")
        rm('./nvim-macos-x86_64', force=True, recurse=True)

INSTALLERS = {
    'fzf'       : Fzf(),
    'ripgrep'   : BasicInstaller('ripgrep'),
    'neovim'    : Neovim()
}

def print_help():
    msg = """
Usage: python setup.py [application]+
       python setup.py --help to display this message

Applications:
    fzf
    ripgrep
    neovim
    """

    print(msg)
    exit(1)

def install(name):
    installer = INSTALLERS[name]

    if hasattr(installer, 'common'):
        installer.common()
        return

    os      = get_os()
    arch    = get_arch()

    if os == OS.OSX and arch == ARCH.ARM_64 and hasattr(installer, 'osx_silicon'):
        installer.osx_silicon()

    elif os == OS.OSX:
        installer.osx()

    elif os == OS.LINUX:
        installer.linux()

    else:
        print(f'Unknown os: {os}')
        exit(1)

if __name__ == '__main__':
    dotfiles_dir = get_dotfiles_dir()

    if len(sys.argv) < 2 or '--help' in sys.argv:
        print_help()
        exit(1)

    for arg in sys.argv[1:]:
        if arg in INSTALLERS:
            install(arg)

        else:
            print(f"Unknown option: {arg}")
            print_help()
            exit(1)

