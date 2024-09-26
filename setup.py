import sys
import subprocess
import re
import pathlib

home = pathlib.Path.home()

### Base Installer ###

def exec(cmd, capture=False, shell=True, check=True, text=True):
    return subprocess.run(
        cmd, 
        shell=shell,
        check=check,
        text=text, 
        capture_output=capture
    )

def append_path_if_missing(path):
    with open(home /'.zshcustom') as f:
        f = f.read()

        if re.findall(f'export PATH.*${path}', f) is not None:
            print(f'{path} is already added in zshcustom. Skipping..')
            return

    cmd = f'echo "export PATH=\"{path}:$PATH\"" >> ~/.zshcustom'
    exec(cmd)

def get_os():
    return exec("uname -s", capture=True).stdout.strip()

# BaseInstaller Simply uses apt/brew
class BaseInstaller:
    def __init__(self, name):
        self.name = name

    def linux(self):
        exec(f'sudo apt-get install -y {self.name}')

    def osx(self):
        exec(f'brew install {self.name}')

class Fzf:
    def common(self):
        exec('git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf')
        exec('~/.fzf/install')

class Neovim:
    def linux(self):
        exec('rm -rf /opt/nvim')

        exec('curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz')
        exec('sudo tar -C /opt -xzf nvim-linux64.tar.gz')
        exec('echo "export PATH=/opt/nvim-linux64/bin:$PATH >> ~/.zshcustom')

        exec('rm -rf ./nvim-linux64.tar.gz')

### CLI ###

Installers = {
    'fzf': Fzf(),
    'ripgrep': BaseInstaller('ripgrep'),
    'neovim': Neovim(),
}

def print_help():
    msg = """
Usage: python setup.py [application]+
       python setup.py --help to display this message
    """

    applications = "\n".join(Installers.keys())

    print(msg)
    print(applications)
    exit(1)

if __name__ == '__main__':
    if len(sys.argv) < 2 or '--help' in sys.argv:
        print_help()
        exit(1)

    for arg in sys.argv[1:]:
        if arg in Installers:
            installer = Installers[arg]
            if hasattr(installer, 'common'):
                installer.common()
            else:
                os = get_os()
                print(os)

                if os == 'Darwin':
                    installer.osx()
                elif os == 'Linux':
                    installer.linux()
                else:
                    print(f'Unknown os: {os}')
                    exit(1)
        else:
            print(f"Unknown option: {arg}")
            print_help()
            exit(1)

