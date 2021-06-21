#
# Copyright (C) 2012 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#

TARGET_ALSA_CONF_DIR := system/usr/share/alsa
LOCAL_ALSA_CONF_DIR  := external/alsa-lib/src/conf

copy_conf := \
	alsa.conf \
	cards/aliases.conf \
	ctl/default.conf \
	pcm/center_lfe.conf \
	pcm/default.conf \
	pcm/dmix.conf \
	pcm/dpl.conf \
	pcm/dsnoop.conf \
	pcm/front.conf \
	pcm/hdmi.conf \
	pcm/iec958.conf \
	pcm/modem.conf \
	pcm/rear.conf \
	pcm/side.conf \
	pcm/surround21.conf \
	pcm/surround40.conf \
	pcm/surround41.conf \
	pcm/surround50.conf \
	pcm/surround51.conf \
	pcm/surround71.conf \
	smixer.conf \

LOCAL_ALSA_INIT_DIR  := external/alsa-utils/alsactl/init

copy_init := \
	00main \
	ca0106 \
	default \
	hda \
	help \
	info \
	test

LOCAL_ALSA_UCM_DIR := external/alsa-ucm-conf

excluded_ucm := \
	codecs/qcom-lpass/% \
	OMAP/% \
	Qualcomm/% \
	README.md \
	Rockchip/% \
	Samsung/% \
	Tegra/% \

PRODUCT_COPY_FILES := \
	$(foreach f,$(copy_conf),$(LOCAL_ALSA_CONF_DIR)/$(f):$(TARGET_ALSA_CONF_DIR)/$(f)) \
	$(foreach f,$(copy_init),$(LOCAL_ALSA_INIT_DIR)/$(f):$(TARGET_ALSA_CONF_DIR)/init/$(f)) \
	$(foreach f,$(filter-out $(addprefix ucm2/,$(excluded_ucm)),$(shell cd $(LOCAL_ALSA_UCM_DIR) && find ucm2 -type f)),$(LOCAL_ALSA_UCM_DIR)/$(f):$(TARGET_ALSA_CONF_DIR)/$(f)) \
	$(if $(wildcard $(PRODUCT_DIR)audio_policy.conf),$(PRODUCT_DIR),$(LOCAL_PATH)/)audio_policy.conf:system/etc/audio_policy.conf \

PRODUCT_PACKAGES := \
	alsa_alsamixer \
	alsa_amixer \
	alsa_aplay \
	alsa_ctl \
	alsa_ucm \
	audio.primary.x86 \
	audio.primary.hdmi \
	audio.a2dp.default \
	audio.usb.default \
	audio_policy.default \
	audio.r_submix.default \
