import sys
import subprocess

class BasicInstaller:
    def __init__(self, name):
        self.name = name

    def linux(self):
        exec(f'sudo apt-get install -y {self.name}')

    def osx(self):
        exec(f'brew install {self.name}')

class Fzf:
    def common(self):
        exec("git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf")
        exec("~/.fzf/install")

def exec(cmd, capture=False):
    return subprocess.run(cmd, shell=True, check=True, text=True, capture_output=capture)

installers = {
    'fzf': Fzf(),
    'ripgrep': BasicInstaller('ripgrep')
}

def get_os():
    return exec("uname -s", capture=True).stdout.strip()

def print_help():
    msg = """
Usage: python setup.py [application]+
       python setup.py --help to display this message

Applications:
    fzf
    ripgrep
    """

    print(msg)
    exit(1)

if __name__ == '__main__':
    if len(sys.argv) < 2 or '--help' in sys.argv:
        print_help()
        exit(1)

    for arg in sys.argv[1:]:
        if arg in installers:
            installer = installers[arg]
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

