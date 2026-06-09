#!/bin/sh
# build-macos.sh — reproducible build wrapper for THIS machine
# (Apple Silicon / macOS 26 Tahoe). Verified to produce the byte-exact
# Rev-1 ROM: sha1 0862ec35b24de5c7e2dcb88c9eea0873110d755c
#
# Why this wrapper exists (hard-won truth, do not strip without reason):
#   1. The official Homebrew `wine-stable` cask (wine 11.0) CANNOT initialize
#      a 32-bit prefix on macOS 26 — wineboot aborts on ole32.CoInitialize and
#      syswow64 stays empty, so the 32-bit CodeWarrior compiler (mwccarm.exe)
#      fails with "could not load kernel32.dll". We use a newer Gcenx wine
#      (wine-devel 11.10) extracted locally and point $WINE at it. metroskrew's
#      mwccarm wrapper honours $WINE.
#   2. Anaconda (`/opt/anaconda3/bin`) sits early in PATH and shadows the system
#      linker with a broken `ld` ("library 'System' not found"). We build with an
#      anaconda-free PATH so /usr/bin/ld is used.
#   3. Homebrew gcc-14 needs SDKROOT pointed at the Xcode SDK to find -lSystem.
#   4. INSTALL.md's macOS dep list omits `wget`, which get_metroskrew.sh needs.
#      Install it: `brew install wget`.
#
# First-build note (from INSTALL.md): the very first `make` may hang during the
# meson compiler probe while wineserver is cold. If it sits with no progress for
# minutes, Ctrl+C and re-run — a warm wineserver gets past it.
#
# Override the wine location with WINE_APP=/path/to/Wine.app if you move it.
set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

# 1. anaconda-free PATH (system ld), homebrew first
export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# 2. Xcode SDK so gcc-14 can link against -lSystem
export SDKROOT="$(xcrun --show-sdk-path)"

# 3. Gcenx wine that supports 32-bit on Apple Silicon
WINE_APP="${WINE_APP:-$HOME/wine-gcenx/Wine Devel.app}"
export WINE="$WINE_APP/Contents/Resources/wine/bin/wine"
export WINEPREFIX="${WINEPREFIX:-$HOME/.wine-gcenx}"
export WINEDLLOVERRIDES="mscoree=d;mshtml=d;winemenubuilder.exe=d"
export WINEDEBUG=-all

if [ ! -x "$WINE" ]; then
  echo "ERROR: wine not found at: $WINE" >&2
  echo "Download Gcenx wine-devel and extract to ~/wine-gcenx, or set WINE_APP." >&2
  echo "  https://github.com/Gcenx/macOS_Wine_builds/releases" >&2
  exit 1
fi

# Initialize the wine prefix once if missing (headless).
if [ ! -f "$WINEPREFIX/drive_c/windows/syswow64/kernel32.dll" ]; then
  echo ">> initializing wine prefix at $WINEPREFIX ..."
  "$WINE" wineboot -u >/dev/null 2>&1 || true
fi

echo ">> building pokeplatinum (rev 1) ..."
exec make "$@"
