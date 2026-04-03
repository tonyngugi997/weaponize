# ⚙️ Weaponize: Configuration Guide

## Phase 3 – Turning Vanilla Neovim Into a God-Mode IDE

*Estimated time: 2-3 minutes*  
*Difficulty: 1/10 (Three commands. That's it.)*  
*Prerequisites: You ought to have completed Installation.md*


## 📋 What Happens in This Guide

| Step | What You Type | What Happens Automatically |
|------|---------------|---------------------------|
| 1 | `git clone` | Downloads Weaponize to your phone |
| 2 | `./install.sh` | Installs everything (config, plugins, LSP) |
| 3 | `nvim` | Launches your new IDE |

**That's all. Three commands. No editing. No decisions.**


## ⚠️ Before You Start

**Confirm you have these from Installtion.md:**

| Check | Command to Run | Expected Result |
|-------|----------------|-----------------|
| ✅ Termux works | `pwd` | `/data/data/com.termux/files/home` |
| ✅ Neovim installed | `nvim --version` | `NVIM v0.10.0` or higher |
| ✅ Git installed | `git --version` | `git version 2.x.x` |
| ✅ Internet connection | `ping -c 1 google.com` | `1 packets transmitted, 1 received` |

**If any of these fail**, go back to [Installation.md](Installation.md) and complete Phase 1 & 2 first.

<div style="display: flex; justify-content: center; margin: 24px 0;">
  <figure style="margin: 0; padding: 20px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 12px; box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3); max-width: 600px; width: 100%;">
    <div style="background: white; border-radius: 8px; padding: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/SCREENSHOT.jpg" 
           alt="Prerequisites Check - Verifying your setup" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 6px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 12px; color: white; font-weight: 500; font-size: 14px;">
      🔍 Verify your Termux environment is properly configured
    </figcaption>
  </figure>
</div>

# PHASE 3: Weaponizing Your Neovim

## Step 3.1: Clone the Weaponize Repository 

In Termux run the command:

```bash
git clone https://github.com/tonyngugi997/weaponize.git
```
**Press Enter.**

<div style="display: flex; justify-content: center; margin: 24px 0;">
  <figure style="margin: 0; padding: 20px; background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%); border-radius: 12px; box-shadow: 0 8px 32px rgba(76, 175, 80, 0.3); max-width: 700px; width: 100%;">
    <div style="background: white; border-radius: 8px; padding: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/git.jpg" 
           alt="Clone Output - Repository cloned successfully" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 6px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 12px; color: white; font-weight: 500; font-size: 14px;">
      📦 Repository cloned successfully - Ready for installation
    </figcaption>
  </figure>
</div>

Now enter the Weaponize folder:

```bash
cd weaponize
```

**Verify you're in the right place:**

```bash
ls -la
```

<div style="display: flex; justify-content: center; margin: 24px 0;">
  <figure style="margin: 0; padding: 20px; background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%); border-radius: 12px; box-shadow: 0 8px 32px rgba(76, 175, 80, 0.3); max-width: 700px; width: 100%;">
    <div style="background: white; border-radius: 8px; padding: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/ls-la" 
           alt="Directory Listing - init.lua and install.sh visible" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 6px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 12px; color: white; font-weight: 500; font-size: 14px;">
      📁 Files ready for installation - Configuration verified
    </figcaption>
  </figure>
</div>


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

<div style="margin: 32px 0;">
  <h4 style="text-align: center; color: #1976D2; margin-bottom: 24px; font-size: 18px;">⏳ Installation Process - Step by Step</h4>
  
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-bottom: 20px;">
    
    <!-- Installation Start -->
    <figure style="margin: 0; padding: 16px; background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%); border-radius: 10px; box-shadow: 0 6px 24px rgba(33, 150, 243, 0.3);">
      <div style="background: white; border-radius: 6px; padding: 12px; box-shadow: 0 3px 12px rgba(0,0,0,0.1);">
        <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/install.sh.jpg" 
             alt="Installation Start - Making script executable" 
             style="width: 100%; height: auto; max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
      </div>
      <figcaption style="text-align: center; margin-top: 8px; color: white; font-weight: 500; font-size: 13px;">
        🚀 Phase 1: Configuration & Setup
      </figcaption>
    </figure>
    
    <!-- Installation Progress -->
    <figure style="margin: 0; padding: 16px; background: linear-gradient(135deg, #FF9800 0%, #F57C00 100%); border-radius: 10px; box-shadow: 0 6px 24px rgba(255, 152, 0, 0.3);">
      <div style="background: white; border-radius: 6px; padding: 12px; box-shadow: 0 3px 12px rgba(0,0,0,0.1);">
        <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_101427_Termux.jpg" 
             alt="Installation Progress - Plugins installing" 
             style="width: 100%; height: auto; max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
      </div>
      <figcaption style="text-align: center; margin-top: 8px; color: white; font-weight: 500; font-size: 13px;">
        ⚙️ Phase 2: Installing Plugins & LSP
      </figcaption>
    </figure>
    
    <!-- Installation Complete -->
    <figure style="margin: 0; padding: 16px; background: linear-gradient(135deg, #4CAF50 0%, #388E3C 100%); border-radius: 10px; box-shadow: 0 6px 24px rgba(76, 175, 80, 0.3);">
      <div style="background: white; border-radius: 6px; padding: 12px; box-shadow: 0 3px 12px rgba(0,0,0,0.1);">
        <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_102905_Termux.jpg" 
             alt="Installation Wrapping Up - Final stages" 
             style="width: 100%; height: auto; max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
      </div>
      <figcaption style="text-align: center; margin-top: 8px; color: white; font-weight: 500; font-size: 13px;">
        ✅ Phase 3: Finalizing Installation
      </figcaption>
    </figure>
    
  </div>
  
  <div style="text-align: center; margin-top: 16px;">
    <div style="display: inline-block; background: linear-gradient(135deg, #E91E63 0%, #C2185B 100%); color: white; padding: 8px 16px; border-radius: 20px; font-weight: 600; font-size: 14px; box-shadow: 0 4px 16px rgba(233, 30, 99, 0.3);">
      ⏱️ Total Installation Time: 30-60 seconds
    </div>
  </div>
</div>

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

<div style="border-left: 4px solid #2196F3; background-color: #e3f2fd; padding: 12px; border-radius: 4px; margin: 12px 0;">

```
[Lazy] Started
[Lazy] Installing plugins...
[Lazy] Installing nvim-cmp...
[Lazy] Installing nvim-lspconfig...
[Lazy] Installing telescope.nvim...
[Lazy] All plugins installed!
```

</div>

**Wait for it to finish.** You'll eventually see Neovim's welcome screen with a clean, modern look.

<div style="display: flex; justify-content: center; margin: 24px 0;">
  <figure style="margin: 0; padding: 20px; background: linear-gradient(135deg, #9C27B0 0%, #7B1FA2 100%); border-radius: 12px; box-shadow: 0 8px 32px rgba(156, 39, 176, 0.3); max-width: 800px; width: 100%;">
    <div style="background: white; border-radius: 8px; padding: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_102941_Termux.jpg" 
           alt="Neovim Launch - Welcome screen" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 6px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 12px; color: white; font-weight: 500; font-size: 14px;">
      🎯 Neovim launches with your weaponized config - Ready for development
    </figcaption>
  </figure>
</div>

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

<div style="border-left: 4px solid #FF9800; background-color: #fff3e0; padding: 12px; border-radius: 4px; margin: 12px 0;">

```
os.abort        os.link         os.setegid
os.add_dll_directory  os.listdir      os.seteuid
os.chdir        os.lseek        os.setgid
os.chmod        os.lstat        os.setpgrp
os.close        os.makedirs     os.setpid
os.closerange   os.mkdir        os.setregid
...
```

</div>

<div style="display: flex; justify-content: center; margin: 20px 0;">
  <figure style="margin: 0; padding: 16px; background: linear-gradient(135deg, #FF9800 0%, #F57C00 100%); border-radius: 10px; box-shadow: 0 6px 24px rgba(255, 152, 0, 0.3); max-width: 600px; width: 100%;">
    <div style="background: white; border-radius: 6px; padding: 12px; box-shadow: 0 3px 12px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_104234_Termux.jpg" 
           alt="Autocompletion popup showing available methods" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 8px; color: white; font-weight: 500; font-size: 13px;">
      💡 Intelligent autocompletion in action
    </figcaption>
  </figure>
</div>

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

<div style="border-left: 4px solid #9C27B0; background-color: #f3e5f5; padding: 12px; border-radius: 4px; margin: 12px 0;">

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

</div>

<div style="display: flex; justify-content: center; margin: 20px 0;">
  <figure style="margin: 0; padding: 16px; background: linear-gradient(135deg, #9C27B0 0%, #7B1FA2 100%); border-radius: 10px; box-shadow: 0 6px 24px rgba(156, 39, 176, 0.3); max-width: 600px; width: 100%;">
    <div style="background: white; border-radius: 6px; padding: 12px; box-shadow: 0 3px 12px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_104303_Termux.jpg" 
           alt="Hover documentation showing module info" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 8px; color: white; font-weight: 500; font-size: 13px;">
      📖 LSP hover documentation displaying real-time help
    </figcaption>
  </figure>
</div>

> ✅ **If you see this tooltip → LSP and hover work.**

**To close the tooltip:** Press `Esc` or `Ctrl + C`.

---

### Test 3: Indentation Lines

Look at the left edge of your editor. You should see **vertical dotted or solid lines** connecting indented lines:

<div style="border-left: 4px solid #4CAF50; background-color: #e8f5e9; padding: 12px; border-radius: 4px; margin: 12px 0;">

```
1 | import os
2 | 
3 | def my_function():
4 │     print("hello")     ← Vertical line here
5 │     if True:
6 │ │         print("nested")  ← Two lines here
```

</div>

<div style="display: flex; justify-content: center; margin: 20px 0;">
  <figure style="margin: 0; padding: 16px; background: linear-gradient(135deg, #4CAF50 0%, #388E3C 100%); border-radius: 10px; box-shadow: 0 6px 24px rgba(76, 175, 80, 0.3); max-width: 600px; width: 100%;">
    <div style="background: white; border-radius: 6px; padding: 12px; box-shadow: 0 3px 12px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_104151_Termux.jpg" 
           alt="Indentation guides showing nested code structure" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 8px; color: white; font-weight: 500; font-size: 13px;">
      📏 Visual indentation guides for better code readability
    </figcaption>
  </figure>
</div>

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

<div style="display: flex; justify-content: center; margin: 20px 0;">
  <figure style="margin: 0; padding: 16px; background: linear-gradient(135deg, #E91E63 0%, #C2185B 100%); border-radius: 10px; box-shadow: 0 6px 24px rgba(233, 30, 99, 0.3); max-width: 600px; width: 100%;">
    <div style="background: white; border-radius: 6px; padding: 12px; box-shadow: 0 3px 12px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_104248_Termux.jpg" 
           alt="Auto-pairing demonstration in code" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 8px; color: white; font-weight: 500; font-size: 13px;">
      🔄 Automatic bracket and quote pairing in action
    </figcaption>
  </figure>
</div>

---

## Step 3.5: The Complete Verification Checklist

| Test | Action | Expected Result | Pass? |
|------|--------|-----------------|-------|
| 1 | Type `os.` in Python file | Popup menu with methods | ☐ |
| 2 | Press `K` on `os` | Floating documentation tooltip | ☐ |
| 3 | Look at indentation | Vertical lines on left edge | ☐ |
| 4 | Type `"` | Auto-closes with `""` | ☐ |

<div style="display: flex; justify-content: center; margin: 24px 0;">
  <figure style="margin: 0; padding: 20px; background: linear-gradient(135deg, #FFD700 0%, #FFA000 100%); border-radius: 12px; box-shadow: 0 8px 32px rgba(255, 215, 0, 0.4); max-width: 700px; width: 100%;">
    <div style="background: white; border-radius: 8px; padding: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_104621_Termux.jpg" 
           alt="Final verification - All tests passing" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 6px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 12px; color: #333; font-weight: 600; font-size: 14px;">
      🎉 Fully weaponized Neovim ready for development
    </figcaption>
    <div style="text-align: center; margin-top: 8px;">
      <span style="background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%); color: white; padding: 6px 12px; border-radius: 16px; font-weight: 600; font-size: 12px; box-shadow: 0 3px 12px rgba(255, 107, 53, 0.3);">
        ✅ All Tests Passed - You're Weaponized!
      </span>
    </div>
  </figure>
</div>

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

<div style="display: flex; justify-content: center; margin: 24px 0;">
  <figure style="margin: 0; padding: 20px; background: linear-gradient(135deg, #3F51B5 0%, #2196F3 100%); border-radius: 12px; box-shadow: 0 8px 32px rgba(63, 81, 181, 0.3); max-width: 800px; width: 100%;">
    <div style="background: white; border-radius: 8px; padding: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
      <img src="https://raw.githubusercontent.com/tonyngugi997/weaponize/master/images/Screenshot_20260403_104550_Termux.jpg" 
           alt="Neovim in action - Ready to develop" 
           style="width: 100%; height: auto; max-width: 100%; border-radius: 6px; display: block; margin: 0 auto;">
    </div>
    <figcaption style="text-align: center; margin-top: 12px; color: white; font-weight: 500; font-size: 14px;">
      🚀 Start coding with your weaponized Neovim setup
    </figcaption>
  </figure>
</div>

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