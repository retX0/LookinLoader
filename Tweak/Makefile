# -----------------------------------------------------------
# LookinLoader – Theos build configuration (rootful + rootless)
# -----------------------------------------------------------
# Usage examples
#   make package                 # ➜ rootful (Architecture: iphoneos-arm)
#   make package ROOTLESS=1      # ➜ rootless (Architecture: iphoneos-arm64)
# -----------------------------------------------------------

ROOTLESS ?= 0                          # 0 = rootful │ 1 = rootless

# ─── Packaging scheme & arch label ─────────────────────────
ifeq ($(ROOTLESS),1)
  THEOS_PACKAGE_SCHEME = rootless      # /var/jb layout
  PACKAGE_ARCH        := iphoneos-arm64
else
  PACKAGE_ARCH        := iphoneos-arm
endif
export PACKAGE_ARCH                     # pass to sub‑makes/env

# ─── Build target & flags ─────────────────────────────────
ARCHS  = arm64 arm64e                   # 64‑bit only
TARGET = iphone:clang:latest:14.0       # iOS 14+ is safe for rootful
ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
  TARGET = iphone:clang:latest:15.0     # iOS 15+ needed by rootless
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LookinLoader
LookinLoader_FILES = LookinLoader.xm

include $(THEOS_MAKE_PATH)/tweak.mk

# ─── Inject the correct Architecture into control ─────────
# We keep a template named "control.in" with a placeholder.
# before‑package is the last hook before dpkg-deb runs.

before-package:: gen-control sign-lookinserver

LOOKIN_SRC  := layout/Library/LookinLoader/LookinServer
LOOKIN_DST  := $(if $(filter $(THEOS_PACKAGE_SCHEME),rootless),\
							 $(THEOS_STAGING_DIR)/var/jb/Library/LookinLoader,\
							 $(THEOS_STAGING_DIR)/Library/LookinLoader)

sign-lookinserver:
	@echo "[build] › preparing LookinServer …"
	@mkdir -p $(LOOKIN_DST)
	@cp -f $(LOOKIN_SRC) $(LOOKIN_DST)/
	@ldid -e $(LOOKIN_DST)/LookinServer >/dev/null 2>&1 || \
		{ echo "[build] › ad-hoc signing LookinServer"; \
		ldid -S $(LOOKIN_DST)/LookinServer; }

gen-control:
	@echo "[build] > Writing Architecture $(PACKAGE_ARCH) into DEBIAN/control"
	@sed 's/^Architecture:.*/Architecture: $(PACKAGE_ARCH)/' control > $(THEOS_STAGING_DIR)/DEBIAN/control

# ─── Post‑install helper ──────────────────────────────────
after-install::
	install.exec "killall -9 SpringBoard"

