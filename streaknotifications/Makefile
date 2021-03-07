include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = streaknotifications

streaknotifications_FILES = SNCRootListController.m
streaknotifications_INSTALL_PATH = /Library/PreferenceBundles
streaknotifications_FRAMEWORKS = UIKit
streaknotifications_PRIVATE_FRAMEWORKS = Preferences
streaknotifications_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/streaknotifications.plist$(ECHO_END)
