# 🔧 Weaponize: Installation Guide 

## Your Mission, Should You Choose to Accept It

You are about to transform your Android phone into a development workstation.

---

## 📋 What You'll Have After This Guide

| Component | Status |
|-----------|--------|
| F-Droid (App Store) | ✅ Installed |
| Termux (Terminal Emulator) | ✅ Installed |
| Neovim (The Editor) | ✅ Installed |
| Git (Version Control) | ✅ Installed |

---

## ⚠️ CRITICAL WARNING – READ THIS FIRST

> ### 🚫 DO NOT USE THE GOOGLE PLAY STORE
>
> If you install Termux from the Google Play Store, **some features may fail since the version is depriciated**.
>
> The Play Store version is:
> - Abandoned since 2021
> - Missing critical Android API permissions
> - Unable to run LSP servers
> - Known to crash on startup
>
> **You have been warned. Use F-Droid only.**

---

# PHASE 1: Installing Termux (The Sacred Container)

## Step 1.1: Install F-Droid (The Alternative App Store)

F-Droid is like Google Play but for open-source apps. Termux lives here.

### On your Android phone:

| Action | Details |
|--------|---------|
| **1** | Open **Chrome** (or any browser) |
| **2** | Tap the address bar at the top |
| **3** | Type: `f-droid.org` |
| **4** | Press **Enter** or tap **Go** |

### Download the F-Droid APK:

| Action | Details |
|--------|---------|
| **5** | On the F-Droid website, look for the big **"Download F-Droid"** button |
| **6** | Tap it. The download will start. |
| **7** | Wait for the download to complete (usually 5-10 seconds) |

> 📱 **Troubleshooting:** If the download doesn't start, tap the "Alternative download link" below the button.

### Install F-Droid:

| Action | Details |
|--------|---------|
| **8** | When download finishes, tap the notification that says **"Download complete"** |
| **9** | If Chrome blocks it, tap **"Settings"** |
| **10** | Toggle ON **"Allow from this source"** |
| **11** | Go back and tap the downloaded file again |
| **12** | Tap **"Install"** |
| **13** | Tap **"Open"** when installation finishes |

> 📱 **Visual cue:** F-Droid icon is a blue circle with a white letter "F".

---

## Step 1.2: Install Termux from F-Droid

Now that F-Droid is installed, we get Termux.

| Action | Details |
|--------|---------|
| **1** | Open **F-Droid** (blue circle icon) |
| **2** | Tap the **magnifying glass** (search icon) at the bottom |
| **3** | Type: `termux` |
| **4** | Tap on the result that says just **"Termux"** |

> 🚨 **NOT these:** Do NOT tap Termux:Boot, Termux:API, Termux:Styling, or Termux:Widget. Just **Termux**.

| Action | Details |
|--------|---------|
| **5** | On the Termux page, tap the green **"INSTALL"** button |
| **6** | Wait for the download and installation (30-60 seconds) |
| **7** | Tap **"OPEN"** when it's done |

---

## Step 1.3: First Launch of Termux

You will see a **black screen** with some white text and a `$` symbol at the bottom.

```
Welcome to Termux!

$ 
```
You now have a unix terminal emulator on your phone. Congrats.

### Grant Storage Permission:

| Action | Details |
|--------|---------|
| **1** | Type exactly this: `termux-setup-storage` |
| **2** | Press the **Enter** |

**A popup will appear** asking: *"Allow Termux to access photos, media, and files on your device?"*

| Action | Details |
|--------|---------|
| **3** | Tap **"Allow"** |

You should see output like:
```
Converting to new app location: /data/data/com.termux/files/home
Filesystem already prepared.
```

> ✅ **Success indicator:** You see the `$` prompt again, waiting for your next command.

### Update the Package Manager:

| Action | Details |
|--------|---------|
| **4** | Type exactly: `pkg update && pkg upgrade -y` |
| **5** | Press **Enter** |

**What this does:** Updates Termux's internal list of available software.

**Expected output:**
```
Hit:1 https://packages.termux.org/apt/termux-main stable InRelease
Reading package lists... Done
Building dependency tree... Done
...
```

> ⏱️ This takes 30-60 seconds. Do not close Termux.

**If prompted** about configuration files (something like `Configuration file '...'`), just press **Enter** to accept the default.

> ✅ **Success indicator:** You see the `$` prompt again.

---

## Step 1.4: Verify Termux is Working

| Action | Details |
|--------|---------|
| **1** | Type: `pwd` |
| **2** | Press **Enter** |

**Expected output:**
```
/data/data/com.termux/files/home
```

> ✅ If you see that path, Termux is installed correctly.

---

# PHASE 2: Installing Neovim & Dependencies

## Step 2.1: Install Essential Packages


**Run the command below.**

```bash
pkg install -y neovim git python nodejs openjdk-17 ripgrep fd wget curl
```

Press **Enter** after pasting.

### What Each Package Does:

| Package | Purpose | Size |
|---------|---------|------|
| `neovim` | The text editor (your IDE) | ~30 MB |
| `git` | Download Weaponize and version control | ~15 MB |
| `python` | Run Python code and Pyright LSP | ~50 MB |
| `nodejs` | Run JavaScript and TypeScript LSP | ~40 MB |
| `openjdk-17` | Run Java LSP (if you code Java) | ~80 MB |
| `ripgrep` | Fast file search (like grep but better) | ~5 MB |
| `fd` | Find files by name (like `find` but better) | ~3 MB |
| `wget` | Download files from the internet | ~2 MB |
| `curl` | Download files and API requests | ~2 MB |

> ⏱️ **This takes 2-4 minutes** depending on your internet speed.
> 
> You will see a lot of text scrolling. This is normal. Let it finish.

**When it's done**, you will see the `$` prompt again.

---

## Step 2.2: Verify Neovim Installation

| Action | Details |
|--------|---------|
| **1** | Type: `nvim --version` |
| **2** | Press **Enter** |

**Expected output (first few lines):**
```
NVIM v0.10.0
Build type: Release
LuaJIT 2.1.0...
```

> 🚨 **If you see `NVIM v0.9.x` or lower:** Run `pkg upgrade neovim` and try again.
>
> 🚨 **If you see `command not found: nvim`:** Run `pkg install neovim` again.

### Quick Test: Launch Neovim

| Action | Details |
|--------|---------|
| **3** | Type: `nvim` |
| **4** | Press **Enter** |

You should see Neovim's welcome screen:
```
~
~                              NVIM v0.10.0
~                  Build type: Release
~                  LuaJIT 2.1.0...
```

### Exit Neovim:

| Action | Details |
|--------|---------|
| **5** | Type: `:qa!` |
| **6** | Press **Enter** |

The `:` tells Neovim you're typing a command. `qa` means "quit all". `!` means "force quit without saving".

You should be back at the Termux `$` prompt.

---

## Step 2.3: Verify All Dependencies

Run each of these commands one by one. Each should show a version number, not an error.

| Command | Expected Output (example) |
|---------|--------------------------|
| `git --version` | `git version 2.45.0` |
| `python --version` | `Python 3.11.8` |
| `node --version` | `v20.11.0` |
| `ripgrep --version` | `ripgrep 14.1.0` |
| `fd --version` | `fd 8.7.0` |

**If any command says `command not found`**, go back to Step 2.1 and run the install command again.

---

## Step 2.4: Create Required Directories

Even though we haven't installed Weaponize yet, let's create the folders Neovim expects.

| Action | Details |
|--------|---------|
| **1** | Type: `mkdir -p ~/.config/nvim` |
| **2** | Press **Enter** |
| **3** | Type: `mkdir -p ~/.local/share/nvim/site/pack` |
| **4** | Press **Enter** |

**These commands create hidden folders.** You won't see them in a normal file manager, but Termux can see them.

To see the hidden directories you just created, run:
**`ls -a`**

---

## Step 2.5: Final Verification Checklist

Run this command to check everything:

```bash
echo "=== NEOVIM ===" && nvim --version | head -1 && echo "=== GIT ===" && git --version && echo "=== PYTHON ===" && python --version && echo "=== NODE ===" && node --version && echo "=== ALL GOOD ==="
```

**Expected output:**
```
=== NEOVIM ===
NVIM v0.10.0
=== GIT ===
git version 2.45.0
=== PYTHON ===
Python 3.11.8
=== NODE ===
v20.11.0
=== ALL GOOD ===
```

> 🎉 **If you see "ALL GOOD"**, you have successfully completed Phase 1 and Phase 2.

---

## 🐛 Troubleshooting Phase 1 & 2

| Problem | Most Likely Cause | Solution |
|---------|------------------|----------|
| Termux crashes on open(though less likely to occure) | You installed from Play Store | Uninstall Termux. Reinstall from F-Droid. |
| Storage permission denied | You didn't allow the popup | Run `termux-setup-storage` again. Tap "Allow". |
| `nvim: No such file` | Neovim didn't install | Run `pkg install neovim` again. |
| Download takes forever | Slow internet | Switch from mobile data to WiFi or vice versa. |
| Weird characters / boxes | Missing font | Ignore for now. Weaponize will fix this. |
| `Permission denied` on commands | You're in the wrong folder | Type `cd ~` and try again. |
| Keyboard covers the screen | Android keyboard issue | Swipe down to hide keyboard. Or install "Hacker's Keyboard" from Play Store. |

---

## 📱 Pro Tips for Mobile Typing

| Tip | How To |
|-----|--------|
| **Copy from this guide** | Tap and hold on the code block → Select all → Copy |
| **Paste into Termux** | Tap and hold on the Termux screen → Paste |
| **Show extra keys** | Swipe left/right on the top row of Termux keyboard |
| **Ctrl key** | Termux has a special CTRL button on the top row |
| **Esc key** | Also on the top row (important for Neovim) |
| **Arrow keys** | Use volume keys + WASD? No. Just tap the screen where you want to edit. |

---

## 🎯 What Now?

**You have successfully installed:**
- ✅ Termux (the terminal)
- ✅ Neovim (the editor)
- ✅ Git, Python, Node.js, and other tools

**Your Android now has the foundation. Next, we add the soul.**

---

## 👉 Proceed to Phase 3

Open the next guide:

### [➡️ CONFIGURATION.md](CONFIGURATION.md)

In the next guide, you will:
1. Clone the Weaponize repository using Git
2. Run the automatic installer script
3. Transform vanilla Neovim into a god-mode IDE
4. Verify everything works (hover, autocomplete, LSP)

---

**Phase 1 & 2 complete. You have passed the trial of the ember.**

*Now go forth to CONFIGURATION.md and claim your flame.*
```


