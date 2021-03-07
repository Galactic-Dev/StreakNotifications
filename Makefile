ARCHS = armv7 armv7s arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StreakNotifications

StreakNotifications_FILES = Tweak.x
StreakNotifications_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += streaknotifications
include $(THEOS_MAKE_PATH)/aggregate.mk
