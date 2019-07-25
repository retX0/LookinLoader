export TARGET=:clang:latest:7.0
export ARCHS=armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LookinLoader
LookinLoader_FILES = LookinLoader.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
