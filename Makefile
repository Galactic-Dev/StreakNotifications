PREFIX=$(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
export TARGET := iphone:clang:13.4
export ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StreakNotifications

StreakNotifications_FILES = Tweak.x
StreakNotifications_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += streaknotifications
include $(THEOS_MAKE_PATH)/aggregate.mk
