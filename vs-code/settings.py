import json
import shutil
import os

settings = {
    # GENERAL #

    # Disable spammy bullshit
    "extensions.ignoreRecommendations": True,
    "security.workspace.trust.enabled": False,

    # Font #

    "editor.fontFamily": "JetBrainsMono NFM Regular",
    "editor.fontSize": 15,

    # Editor #

    "editor.inlayHints.enabled": "offUnlessPressed",
    "editor.minimap.enabled": False,
    "editor.autoClosingBrackets": "never",
    "editor.rulers": [ 120 ],
    "editor.wordWrap": "off",

    "diffEditor.maxComputationTime": 0,

    # Files #

    "files.trimTrailingWhitespace": True,
    "files.insertFinalNewline": False,

    # Custom file associations
    "files.associations": {
        "*.in": "toml"
    },

    # UI #

    "workbench.startupEditor": "none",
    "workbench.editorLargeFileConfirmation": 20,
    "workbench.sideBar.location": "left",
    "workbench.activityBar.location": "top",

    # Theme #

    # Auto-detect light/dark theme
    "window.autoDetectColorScheme": True,
    "workbench.preferredDarkColorTheme": "Catppuccin Macchiato",
    "workbench.preferredLightColorTheme": "Visual Studio Light",

    # Terminal #

    "terminal.integrated.fontFamily": "JetBrainsMono NFM Regular",
    "terminal.integrated.fontSize": 15,

    # Git #

    "git.openRepositoryInParentFolders": "never",

    # Vim #

    "vim.leader": "<space>",
    "vim.useSystemClipboard": True,
    "vim.normalModeKeyBindingsNonRecursive": [
        {
            "before": ["<C-w>", "\\"],
            "commands": [ "workbench.action.splitEditor" ]
        },
        {
            "before": ["<C-w>", "-"],
            "commands": [ "workbench.action.splitEditorDown" ]
        },
        {
            "before": ["<C-b>"],
            "commands": [ "workbench.action.toggleSidebarVisibility" ]
        },
        {
            "before": ["<C-j>"],
            "commands": [ "workbench.action.togglePanel" ]
        }
    ],
    "vim.foldfix": True,

    # Rust #

    "rust-analyzer.trace.server": "verbose",
    "rust-analyzer.server.extraEnv": {
        "RA_LOG": "warn"
    },

    # Python #

    "[python]": {
        "editor.formatOnType": True
    },
    "python.analysis.extraPaths": [
        "~/devenv/repos/nimbus"
    ],

    # Ruby #

    "sorbet.enabled": True,

    # Javascript #

    "[javascript]": {
        "editor.defaultFormatter": "vscode.typescript-language-features"
    },
}

keybindings = [
    # Debugging #

    {
        "command": "workbench.action.debug.stepOver",
        "key": "F6"
    },
    {
        "command": "workbench.action.debug.stepInto",
        "key": "F7"
    },
    {
        "command": "workbench.action.debug.stepOut",
        "key": "F8"
    },


    # Terminal #

    {
        "command": "workbench.action.terminal.focusNext",
        "key": "Ctrl+b n"
    },
    {
        "command": "workbench.action.terminal.focusPrevious",
        "key": "Ctrl+b p"
    },
    {
        "command": "workbench.action.terminal.new",
        "key": "Ctrl+b c"
    },
    {
        "command": "workbench.action.terminal.kill",
        "key": "Ctrl+b x y"
    },
    {
        "command": "workbench.action.toggleMaximizedPanel",
        "key": "Ctrl+b z"
    },
]

def dotfiles_path():
    if "DOTFILESPATH" in os.environ:
        return os.environ["DOTFILESPATH"]

    return os.path.expanduser("~/.dotfiles")

def config_path():
    if os.uname() == "Linux":
        return os.path.expanduser("~/.config/Code/User")
    elif os.uname() == "Darwin":
        return os.path.expanduser("~/Library/Application Support/Code/User")
    elif os.uname() == "Windows":
        return os.path.expanduser("~\\AppData\\Roaming\\Code\\User")

custom_settings     = {}
custom_keybindings  = []

merged_settings     = json.dumps({ **settings,     **custom_settings    })
merged_keybindings  = json.dumps({ **keybindings,  **custom_keybindings })

shutil.cp(merged_settings,      config_path() / "settings.json",    force=True)
shutil.cp(merged_keybindings,   config_path() / "keybindings.json", force=True)
