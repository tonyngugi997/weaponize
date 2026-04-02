---

# ⚙️ Weaponize: Configuration Guide

## Phase 3 – Turning Vanilla Neovim Into a God-Mode IDE

*Estimated time: 2-3 minutes*  
*Difficulty: 1/10 (Three commands. That's it.)*  
*Prerequisites: You ought to have completed Installation.md*

---

## 📋 What Happens in This Guide

| Step | What You Type | What Happens Automatically |
|------|---------------|---------------------------|
| 1 | `git clone` | Downloads Weaponize to your phone |
| 2 | `./install.sh` | Installs everything (config, plugins, LSP) |
| 3 | `nvim` | Launches your new IDE |

**That's all. Three commands. No editing. No decisions.**

---

## ⚠️ Before You Start

**Confirm you have these from Installtion.md:**

| Check | Command to Run | Expected Result |
|-------|----------------|-----------------|
| ✅ Termux works | `pwd` | `/data/data/com.termux/files/home` |
| ✅ Neovim installed | `nvim --version` | `NVIM v0.10.0` or higher |
| ✅ Git installed | `git --version` | `git version 2.x.x` |
| ✅ Internet connection | `ping -c 1 google.com` | `1 packets transmitted, 1 received` |

**If any of these fail**, go back to [Installation.md](INSTALLATION.md) and complete Phase 1 & 2 first.

---

# PHASE 3: Weaponizing Your Neovim

## Step 3.1: Clone the Weaponize Repository 

In Termux run the command:

```bash
git clone https://github.com/tonyngugi997/weaponize.git
```
**Press Enter.**

**Expected output:**
```
Cloning into 'weaponize'...
remote: Enumerating objects: 42, done.
remote: Counting objects: 100% (42/42), done.
remote: Compressing objects: 100% (35/35), done.
Receiving objects: 100% (42/42), 89.00 KiB | 890.00 KiB/s, done.
```

Now enter the Weaponize folder:

```bash
cd weaponize
```

**Verify you're in the right place:**

```bash
ls -la
```

**You should see:**
```
-rwxr-xr-x install.sh
-rw-r--r-- init.lua
drwx------ lua/
```

> ✅ If you see `install.sh` and `init.lua`, you're in the right folder.

---

## Step 3.2: Run the Auto-Installer

**First make the `install.sh` executable.**

```bash
chmod +x install.sh 
```
**Then we proceed to run the installation script:**

```bash
./install.sh
```
### What You'll See:

The script will output colored text showing each step:

```
🔫 Weaponizing your Neovim...

📦 Backing up existing Neovim config...
✅ Backed up to ~/.config/nvim.backup.20250115_143022

⚙️ Installing Weaponize config...
✅ Config files copied

📦 Installing lazy.nvim plugin manager...
✅ lazy.nvim installed

🚀 Installing plugins (first launch may take 1-2 minutes)...
✅ Plugins installed

🌳 Installing Treesitter parsers...
✅ Treesitter parsers installed

═══════════════════════════════════════════════════════════
✅ WEAPONIZE INSTALLED SUCCESSFULLY
═══════════════════════════════════════════════════════════

🚀 Type 'nvim' to start coding

📖 First-time tips:
   • Type :Lazy to see installed plugins
   • Type :Mason to install LSP servers
   • Type :checkhealth to verify everything works

🔥 You are now weaponized. Go build something insane.
```

> ⏱️ **Total time:** 30-60 seconds depending on your internet speed.

### If You See Errors:

| Error | What To Do |
|-------|------------|
| `Permission denied` | Run `chmod +x install.sh` again |
| `git: command not found` | Run `pkg install git` then retry |
| `nvim: command not found` | Run `pkg install neovim` then retry |
| `Connection refused` | Check your internet, then rerun `./install.sh` |

> 💡 **The script is safe to rerun.** It will not break anything.

---

## Step 3.3: Launch Weaponized Neovim

```bash
nvim
```

**First launch will take 15-30 seconds** as plugins finish loading. This is normal.

You'll see lazy.nvim's progress screen:

```
[Lazy] Started
[Lazy] Installing plugins...
[Lazy] Installing nvim-cmp...
[Lazy] Installing nvim-lspconfig...
[Lazy] Installing telescope.nvim...
[Lazy] All plugins installed!
```

**Wait for it to finish.** You'll eventually see Neovim's welcome screen with a clean, modern look.

---

## Step 3.4: Verify Your Weapon Works

### Test 1: Autocompletion (The `os.` Test)

Inside Neovim, type:

```
:edit test.py
```

**This creates a new Python file.**

Now type:

```python
import os
os.
```

**When you type the dot (`.`), a popup menu should appear** showing all methods inside `os`:

```
os.abort        os.link         os.setegid
os.add_dll_directory  os.listdir      os.seteuid
os.chdir        os.lseek        os.setgid
os.chmod        os.lstat        os.setpgrp
os.close        os.makedirs     os.setpid
os.closerange   os.mkdir        os.setregid
...
```

> ✅ **If you see this menu → Autocompletion works.**

**To dismiss the menu:** Press `Esc` or keep typing.

---

### Test 2: Hover Documentation (The `K` Test)

With your cursor on the word `os` (move it there with arrow keys or tap), press:

```
K
```

**That's Shift + K** (capital K).

A floating tooltip should appear showing documentation for the `os` module:

```
┌─────────────────────────────────────────────────────────┐
│ os                                                      │
│                                                         │
│ The `os` module provides a portable way of using       │
│ operating system dependent functionality.              │
│                                                         │
│ Available since: Python 1.4                            │
│                                                         │
│ Methods: abspath(), chdir(), getcwd(), listdir(),      │
│          mkdir(), remove(), rename(), rmdir(), etc.    │
└─────────────────────────────────────────────────────────┘
```

> ✅ **If you see this tooltip → LSP and hover work.**

**To close the tooltip:** Press `Esc` or `Ctrl + C`.

---

### Test 3: Indentation Lines

Look at the left edge of your editor. You should see **vertical dotted or solid lines** connecting indented lines:

```
1 | import os
2 | 
3 | def my_function():
4 │     print("hello")     ← Vertical line here
5 │     if True:
6 │ │         print("nested")  ← Two lines here
```

> ✅ **If you see vertical lines → Indentation guides work.**

---

### Test 4: Auto-Pairing

Type the following characters one by one:

| You Type | Should Auto-Complete To |
|----------|------------------------|
| `"` | `""` with cursor between |
| `'` | `''` with cursor between |
| `(` | `()` with cursor between |
| `{` | `{}` with cursor between |
| `[` | `[]` with cursor between |

> ✅ **If characters auto-close → Auto-pairing works.**

---

## Step 3.5: The Complete Verification Checklist

| Test | Action | Expected Result | Pass? |
|------|--------|-----------------|-------|
| 1 | Type `os.` in Python file | Popup menu with methods | ☐ |
| 2 | Press `K` on `os` | Floating documentation tooltip | ☐ |
| 3 | Look at indentation | Vertical lines on left edge | ☐ |
| 4 | Type `"` | Auto-closes with `""` | ☐ |

**If all four pass → You are fully weaponized. 🎉**

---

## 🎯 What Now?

### You're Ready to Code

Start a new project:

```bash
nvim my_project/main.py
```

Or open an existing one:

```bash
cd ~/storage/downloads/my_project
nvim .
```

### Useful First Commands Inside Neovim:

| Command | What It Does |
|---------|--------------|
| `:Lazy` | See installed plugins and update them |
| `:Mason` | Install LSP servers for other languages |
| `:checkhealth` | Verify everything is working |
| `:Telescope find_files` | Search for files in your project |
| `:Telescope live_grep` | Search inside files |
| `:help` | Open Neovim help |

### Essential Keymaps (Shortcuts):

| Shortcut | Action |
|----------|--------|
| `Space + w` | Save file |
| `Space + q` | Close file |
| `Space + f` | Find files (Telescope) |
| `Space + g` | Git status |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `Ctrl + d` | Scroll down half page |
| `Ctrl + u` | Scroll up half page |

> 📖 **Full keybindings:** [KEYBINDS.md](docs/KEYBINDS.md)

---

## 📚 Next Steps

| You Want To... | Read This |
|----------------|-----------|
| **Understand the config** (customize everything) | [Advanced.md](docs/Advanced.md) |
| **Learn all keyboard shortcuts** | [KEYBINDS.md](docs/KEYBINDS.md) |
| **Just start coding** | You're ready. Go build. |

---

## 🐛 Quick Troubleshooting

| Problem | Most Likely Fix |
|---------|-----------------|
| `os.` doesn't show methods | Run `:Lazy sync` inside Neovim, then restart |
| `K` doesn't show tooltip | Run `:LspRestart` inside Neovim |
| Colors look weird | Run `:TSInstallSync python` inside Neovim |
| Neovim is slow on first launch | That's normal. Wait 30 seconds. It will be fast after. |
| `command not found: nvim` | You closed Termux. Reopen Termux and type `nvim` again. |


---

## 🎉 Congratulations

You have transformed your Android phone into a professional development environment.

**What you now have:**
- ✅ Intelligent code completion (type `os.` → see methods)
- ✅ Hover documentation (press `K` on any function)
- ✅ Go to definition (`gd`)
- ✅ Find references (`gr`)
- ✅ Auto-pairing of quotes, brackets, and parentheses
- ✅ Indentation lines
- ✅ Syntax highlighting
- ✅ File search (`Space + f`)
- ✅ Git integration
- ✅ Extensible plugin system



## 🔥 The Final Word

```
═══════════════════════════════════════════════════════════
  You held the ember. You did not burn.
  
  The temple accepts you.
  
  You are weaponized.

═══════════════════════════════════════════════════════════
```

**Now go build something insane. From your phone.**

---

## 📎 Quick Reference Card

```bash
# Start coding
nvim

# Save file
Space + w

# Find files
Space + f

# Go to definition
gd

# Hover documentation
K

# Exit Neovim
:qa!
```

---