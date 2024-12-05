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
    Darwin = "Darwin",
    Linux  = "Linux",

def get_os():
    return OS[exec("uname -s", capture=True).stdout.strip()]

class ARCH(Enum):
    x86_64  = "x86_64",
    arm_64  = "arm_64",

def get_arch():
    return ARCH[exec("uname -m", capture=True).stdout.strip()]

def get_dotfiles_dir():
    return os.path.dirname(os.path.realpath(__file__))

PATHS_APPENDED = []

def append_path(path):
    if path in PATHS_APPENDED:
        print(f'Path {path} already appended. Skipping.')
        PATHS_APPENDED.append(path)

    exec(f'echo "export PATH={path}:\$PATH" >> ~/.zshcustom')

def rm(path, force=False, recurse=False):
    force_flag      = '-f' if force   else ''
    recurse_flag    = '-r' if recurse else ''

    exec(f'rm {force_flag} {recurse_flag} {path}')

def curl_untar(url, fname):
    exec(f'curl -LO {url}')
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
        exec("git clone https://github.com/junegunn/fzf.git ~/.fzf")
        exec("~/.fzf/install")
        append_path("~/.fzf/bin")

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
        rm("/opt/nvim", force=True, recurse=True)

        fname = 'nvim-linux64.tar.gz'
        curl_untar("https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz", fname)

        exec("sudo tar -C /opt -xzf nvim-linux64.tar.gz")

        rm('./nvim-linux64',       force=True, recurse=True)
        rm('./nvim-linux64.tar.gz', force=True, recurse=True)

        append_path('/opt/nvim-linux64/bin')

class OhMyZsh:
    def common(self):
        exec('sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')

class OhMyZshPlugins:
    def common(self):
        exec('git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search')
        exec('rm ~/.zshrc*')
        exec('~/.zshrc* ~/.zshrc')
        exec(f'mv {get_dotfiles_dir()}/zsh/.zshrc ~/.zshrc')

class Tmux:
    def common(self):
        exec('git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm')

    def osx(self):
        exec('brew install tmux --HEAD')

    def linux(self):
        apt_install('tmux')

class LazyGit:
    def linux(self):
        exec("LAZYGIT_VERSION=$(curl -s \"https://api.github.com/repos/jesseduffield/lazygit/releases/latest\" | grep -Po '\"tag_name\": \"v\K[^\"]*') ; curl -Lo lazygit.tar.gz \"https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz\"")
        exec("tar xf lazygit.tar.gz lazygit")
        exec("sudo install lazygit /usr/local/bin")
        exec("rm ./lazygit ./lazygit.tar.gz")

class Node:
    def linux(self):
        exec("wget https://nodejs.org/dist/v23.1.0/node-v23.1.0-linux-x64.tar.xz")
        exec("tar -xf node-v23.1.0-linux-x64.tar.xz")
        exec("mv node-v23.1.0-linux-x64 /opt")
        exec("rm node-v23.1.0-linux-x64.tar.xz")

        append_path("/opt/node-v23.1.0-linux-x64/bin")

class RustAnalyzer:
    def common(self):
        exec("rustup component add rust-analyzer")

class Pure:
    def common(self):
        exec("mkdir -p '$HOME/.zsh'")
        exec("git clone https://github.com/sindresorhus/pure.git '$HOME/.zsh/pure'")

INSTALLERS = {
    'fzf'           : Fzf(),
    'ripgrep'       : BasicInstaller('ripgrep'),
    'neovim'        : Neovim(),
    'omz'           : OhMyZsh(),
    'omz-plugins'   : OhMyZshPlugins(),
    'lazygit'       : LazyGit(),
    'node'          : Node(),
    'rust-analyzer' : RustAnalyzer(),
    'pure':           Pure()
}

def print_help():
    msg = f"""
Usage: python setup.py [application]+
       python setup.py --help to display this message

Applications: {INSTALLERS.keys()}
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

    if os == OS.Darwin and arch == ARCH.arm_64 and hasattr(installer, 'osx_silicon'):
        installer.osx_silicon()

    elif os == OS.Darwin:
        installer.osx()

    elif os == OS.Linux:
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

