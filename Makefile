export TARGET=iphone:5.0:5.0
include theos/makefiles/common.mk

TWEAK_NAME = CalliFy
CalliFy_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += callifyprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
