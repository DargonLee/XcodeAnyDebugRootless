ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = rootless


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = XcodeAnyDebugRootless

XcodeAnyDebugRootless_FILES = Tweak.x
XcodeAnyDebugRootless_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
