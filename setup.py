import sys
import os
import subprocess

from enum import Enum

from pathlib import Path

## Utilities ##

def exec(cmd, capture=False, check=True, text=True):
    return subprocess.run(cmd, shell=True, check=check, text=text, capture_output=capture)

def git_clone(repo, dest, depth=None):
    flag_depth = "" if depth is None else f"--depth={depth}"

    exec(f"git clone {flag_depth} {repo} {dest}")

def brew_install(pkg):
    exec(f"brew install {pkg}")

def apt_update():
    exec(f"sudo apt-get update")

HAS_UPDATED_APT = False

def program_in_path(program):
    return exec(f"which {program}", capture=True, check=False).returncode == 0

def apt_install(pkg):
    global HAS_UPDATED_APT

    if not HAS_UPDATED_APT:
        apt_update()
        HAS_UPDATED_APT = True

    exec(f"sudo apt-get install -y {pkg}")

## Target Definitions ##

class OS(Enum):
    Darwin = "Darwin",
    Linux  = "Linux",

def get_os():
    return OS[exec("uname -s", capture=True).stdout.strip()]

class Architecture(Enum):
    x86_64  = "x86_64",
    arm_64  = "arm_64",

def get_architecture():
    return Architecture[exec("uname -m", capture=True).stdout.strip()]

def get_dotfiles_dir():
    return os.path.dirname(os.path.realpath(__file__))

def maybe_append_path(path):
    fname = Path.home() / ".zshcustom"

    with open(fname) as zshcustom:
        existing = [x for x in zshcustom.readlines() if "# Added by setup.py" in x]

        for ex in existing:
            if path in ex:
                print(f"Path {path} already in ~/.zshcustom")
                return

    append_path(path)

def append_path(path):
    exec(f'echo "export PATH={path}:\\$PATH # Added by setup.py" >> ~/.zshcustom')

def rm(path, force=False, recurse=False, ignore_error=False):
    force_flag      = '-f' if force   else ''
    recurse_flag    = '-r' if recurse else ''

    try:
        exec(f'rm {force_flag} {recurse_flag} {path}')
    except:
        if not ignore_error:
            raise Exception(f'Failed to remove {path}')

def curl(url, fname):
    exec(f'curl -LO {url} -o {fname}')

def untar(fname):
    exec(f'tar xzf {fname}')

def curl_untar(url, fname):
    curl(url, fname)
    untar(fname)

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
        maybe_append_path("~/.fzf/bin")

    def installed(self):
        return os.path.exists(Path.home() / ".fzf")

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
        rm("/opt/nvim", force=True, recurse=True, ignore_error=True)

        fname   = 'nvim-linux-x86_64.tar.gz'
        pathname = 'nvim-linux-x86_64'

        curl_untar("https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz", fname)

        exec(f"sudo tar -C /opt -xzf {fname}")

        rm(f"./{fname}*", force=True, recurse=True)
        rm(f"./{pathname}*", force=True, recurse=True)

        maybe_append_path(f"/opt/{pathname}/bin")

    def installed(self):
        return program_in_path("nvim")

class OhMyZsh:
    def common(self):
        exec('sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')
        exec("git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search")

class Tmux:
    def common(self):
        exec("git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm")

    def osx(self):
        exec("brew install tmux --HEAD")

    def linux(self):
        apt_install("tmux")

    def installed(self):
        return program_in_path("tmux")

class LazyGit:
    def linux(self):
        exec("LAZYGIT_VERSION=$(curl -s \"https://api.github.com/repos/jesseduffield/lazygit/releases/latest\" | grep -Po '\"tag_name\": \"v\\K[^\"]*') ; curl -Lo lazygit.tar.gz \"https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz\"")
        exec("tar xf lazygit.tar.gz lazygit")
        exec("sudo install lazygit /usr/local/bin")
        exec("rm ./lazygit ./lazygit.tar.gz")

    def installed(self):
        return program_in_path("lazygit")

class NodeVersionManager:
    def common(self):
        exec("curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash")

        with open(Path.home() / ".zshcustom", "a") as zshcustom:
            zshcustom.write('export NVM_DIR="$HOME/.nvm"\n')
            zshcustom.write('[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm\n')
            zshcustom.write('[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion\n')

    def installed(self):
        return False # "NVM_DIR" in os.environ

class Node:
    def __init__(self, version):
        self.version = version

    def linux(self):
        exec(f"wget https://nodejs.org/dist/v23.1.0/{self.version}-linux-x64.tar.xz")
        exec(f"tar -xf {self.version}-linux-x64.tar.xz")
        exec(f"sudo mv {self.version}-linux-x64 /opt")
        exec(f"rm {self.version}-linux-x64.tar.xz")

        maybe_append_path(f"/opt/{self.version}-linux-x64/bin")

    def installed(self):
        return os.path.exists(f"/opt/{self.version}-linux-x64")

class RustAnalyzer:
    def common(self):
        exec("rustup component add rust-analyzer")

    def installed(self):
        return program_in_path("rust-analyzer")

class Pure:
    def common(self):
        exec("git clone https://github.com/sindresorhus/pure.git ~/.zsh/pure")

class Ak:
    def common(self):
        cwd = os.getcwd()

        exec(f"sudo ln -s {cwd}/python/ak /usr/local/bin/ak")

    def installed(self):
        return program_in_path("ak")

class Locale:
    def linux(self):
        exec("sudo apt-get install -y locales")
        exec("sudo locale-gen en_US.UTF-8")

INSTALLERS = {
    'fzf'           : Fzf(),
    'ripgrep'       : BasicInstaller('ripgrep'),
    'neovim'        : Neovim(),
    'omz'           : OhMyZsh(),
    'lazygit'       : LazyGit(),
    'node'          : Node("23.1.0"),
    'nvm'           : NodeVersionManager(),
    'rust-analyzer' : RustAnalyzer(),
    'pure'          : Pure(),
    'locale'        : Locale(),
    'ak'            : Ak()
}

def print_help():
    msg = f"""
Usage: python setup.py [application...]+
       python setup.py --help to display this message

Applications: {INSTALLERS.keys()}

Recommended setup: python setup.py omz lazygit fzf ripgrep neovim locale nvm

Note: restart the shell after installing in order to get PATH updates
    """

    print(msg)
    exit(1)

def install(name):
    print("\n-------------------------")

    installer = INSTALLERS[name]

    if hasattr(installer, 'installed') and installer.installed():
        print(f"({name}) already installed")
        print("-------------------------\n")
        return True

    print(f"Installing ({name})")
    print("-------------------------\n")

    os      = get_os()
    arch    = get_architecture()

    try:
        if hasattr(installer, 'common'):
            installer.common()
            return True

        elif os == OS.Darwin and arch == Architecture.arm_64 and hasattr(installer, 'osx_silicon'):
            installer.osx_silicon()

        elif os == OS.Darwin:
            installer.osx()

        elif os == OS.Linux:
            installer.linux()

        else:
            print(f'Unknown os: {os}')
            exit(1)

    except subprocess.CalledProcessError:
        print(f"({name}): FAILED")
        return False

    return True

if __name__ == '__main__':
    failures  = []
    successes = []

    dotfiles_dir = get_dotfiles_dir()

    if len(sys.argv) < 2 or '--help' in sys.argv:
        print_help()
        exit(1)

    for arg in sys.argv[1:]:
        if arg in INSTALLERS:
            if not install(arg):
                failures.append(arg)
            else:
                successes.append(arg)

        else:
            print(f"Unknown option: {arg}")
            print_help()
            exit(1)

    print("\n-------------------------")
    print("Installation Summary")
    print("-------------------------\n")

    print("Successes:")
    for s in successes:
        print(f"  {s}")

    print("Failures:")
    for f in failures:
        print(f"  {f}")

