import sys
import os
import subprocess

import json

from enum       import Enum
from datetime   import datetime

MANIFEST_PATH = "~/.dotfiles/.manifest"

def read_manifest():
    manifest_path = os.path.expanduser(MANIFEST_PATH)

    if not os.path.exists(manifest_path):
        manifest = {
            "installed": {}
        }

        write_manifest(manifest)

        return manifest

    with open(manifest_path, 'r') as f:
        return json.load(f)

def write_manifest(data):
    manifest_path = os.path.expanduser(MANIFEST_PATH)

    with open(manifest_path, 'w') as f:
        json.dump(data, f, indent=4)

def set_manifest(name, location=None, status="installed"):
    manifest    = read_manifest()
    installed   = manifest["installed"]

    installed[name] = {
        "name":     name,
        "location": location,
        "status":   status,
        "date":     datetime.now().isoformat()
    }

    write_manifest(manifest)

def status(name):
    manifest = read_manifest()

    if name in manifest["installed"]:
        entry = manifest["installed"][name]

        return entry["status"]

    return None

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
    arm64  = "arm64",

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

def rm(path, force=False, recurse=False, ignore_error=False):
    force_flag      = '-f' if force   else ''
    recurse_flag    = '-r' if recurse else ''

    try:
        exec(f'rm {force_flag} {recurse_flag} {path}')
    except:
        if not ignore_error:
            raise Exception(f'Failed to remove {path}')

def curl_untar(url, fname):
    exec(f'curl -LO {url} -o {fname}')
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
        curl_untar('https://github.com/neovim/neovim/releases/download/stable/nvim-macos-amd64.tar.gz', 'nvim-macos.tar.gz')
        exec('cp ./nvim-macos/* /usr/local/')
        rm('./nvim-macos', force=True, recurse=True)

    def osx(self):
        curl_untar('https://github.com/neovim/neovim/releases/download/stable/nvim-macos-x86_64.tar.gz', 'nvim-macos.tar.gz')
        exec('cp ./nvim-macos/* /usr/local/')
        rm('./nvim-macos', force=True, recurse=True)

    def linux(self):
        rm("/opt/nvim", force=True, recurse=True, ignore_error=True)

        fname   = 'nvim-linux-x86_64.tar.gz'
        pathname = 'nvim-linux-x86_64'

        curl_untar("https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz", fname)

        exec(f"sudo tar -C /opt -xzf {fname}")

        rm(f"./{fname}*", force=True, recurse=True)
        rm(f"./{pathname}*", force=True, recurse=True)

        append_path(f"/opt/{pathname}/bin")

class OhMyZsh:
    def common(self):
        exec('sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')
        exec('git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search')

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
        exec("sudo mv node-v23.1.0-linux-x64 /opt")
        exec("rm node-v23.1.0-linux-x64.tar.xz")

        append_path("/opt/node-v23.1.0-linux-x64/bin")

class RustAnalyzer:
    def common(self):
        exec("rustup component add rust-analyzer")

def template_git_clone(repo_url, dest_path):
    def decorator(cls):
        def common(self):
            exec(f"git clone {repo_url} {dest_path}")

        cls.common = common
        return cls

    return decorator

@template_git_clone(
    "https://github.com/sindresorhus/pure.git",
    "~/.zsh/pure"
)
class Pure:
    pass

class Ldev:
    def common(self):
        cwd = os.getcwd()

        exec(f"sudo ln -s {cwd}/python/ldev /usr/local/bin/ldev")
class Ak:
    def common(self):
        cwd = os.getcwd()

        exec(f"sudo ln -s {cwd}/python/ak /usr/local/bin/ak")

class Locale:
    def linux(self):
        exec("sudo apt-get install -y locales")
        exec("sudo locale-gen en_US.UTF-8")

class Zoxide:
    def linux(self):
        exec("curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh")

    def osx(self):
        exec("brew install zoxide")

INSTALLERS = {
    'fzf'           : Fzf(),
    'ripgrep'       : BasicInstaller('ripgrep'),
    'neovim'        : Neovim(),
    'omz'           : OhMyZsh(),
    'lazygit'       : LazyGit(),
    'node'          : Node(),
    'rust-analyzer' : RustAnalyzer(),
    'pure'          : Pure(),
    'locale'        : Locale(),
    'ak'            : Ak(),
    'ldev'          : Ldev(),
    'zoxide'        : Zoxide()
}

def print_help():
    msg = f"""
Usage: python setup.py [application...]+
       python setup.py defaults             # Install the default applications
       python setup.py --help               # display this message

Applications: {INSTALLERS.keys()}

Defautls: python setup.py omz lazygit fzf ripgrep neovim locale node zoxide

Note: restart the shell after installing in order to get PATH updates
    """

    print(msg)
    exit(1)

def install(name):
    print("\n\n\n-------------------------")
    print(f"Installing {name}")
    print("-------------------------\n\n\n")

    installer = INSTALLERS[name]

    if hasattr(installer, 'common'):
        installer.common()
        return

    os      = get_os()
    arch    = get_arch()

    try:
        if status(name) == "installed":
            print(f"{name}: already installed")
            return

        if os == OS.Darwin and arch == ARCH.arm64 and hasattr(installer, 'osx_silicon'):
            installer.osx_silicon()

        elif os == OS.Darwin:
            installer.osx()

        elif os == OS.Linux:
            installer.linux()

        else:
            print(f'Unknown os: {os}')
            exit(1)

        set_manifest(name, status="installed")


    except subprocess.CalledProcessError:
        set_manifest(name, status="failed")
        print(f"{name}: FAILED")

DEFAULTS = [
    'omz', 'lazygit', 'fzf', 'ripgrep', 'neovim', 'locale', 'node', 'zoxide', 'rust-analyzer'
]

if __name__ == '__main__':
    dotfiles_dir = get_dotfiles_dir()

    if len(sys.argv) < 2 or '--help' in sys.argv:
        print_help()
        exit(1)

    for arg in sys.argv[1:]:
        if arg == 'defaults':
            for x in DEFAULTS:
                install(x)
        if arg in INSTALLERS:
            install(arg)

        else:
            print(f"Unknown option: {arg}")
            print_help()
            exit(1)

