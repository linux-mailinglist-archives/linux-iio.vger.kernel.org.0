Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40C3382C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFCSgt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:36:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38990 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfFCSeQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so11099528pfe.6
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSPCdt3UvszDQkpr249St/mK109LyeFIzSIuk4O0soI=;
        b=aY6qFZBG7kuaXBmn0yu1KsxU99MpAC4FmWOJ1j+aLkQEmKEIehg+saf5xg0LoZbgsr
         6XZXWcg2/hSejR0Wf91QHa2ukZEjN0b7yQMCc/W+vwGkzRDnJl71u0wupDp19QomfjVF
         0b6l0gsIYOd3rf8AwIfbqWFqsURwgz2cEgn3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSPCdt3UvszDQkpr249St/mK109LyeFIzSIuk4O0soI=;
        b=sOXG/b4SPtzAQRLF5akf5s+T4so0Uibxicb6pCCdyZGdDPyvwmj3j2bDUpx+8dmtJP
         Z9ZlsW/43kDYrwj2lAGXTrfqc01blMO9b7sLN85avRAkNfe0g8yNEbTI1qRbrY9LC3yN
         Lzy2sg1gFsW4S2vCBdUcUOsvNXbCTG0iKW7W39r8/WvA0ZvO8dnMqOQoBqZa7K/ipS0L
         loP6oovDgdDYvd/RvRV1Y+m7+3e2gEzrlRbYux1lMbA47gnPY9hLIsV4NH7OCB5hGOIe
         FOMzXZRj+IlvOridM/emwIXaaM9PVK35Bz3s3NnfqtuN/e1RV5F+1xh9RtzXJtFPDnot
         INnw==
X-Gm-Message-State: APjAAAXaN+YX3SmVnM2LvQE6kiqGeiJO3s92vtJ9l1rkubpgBk8r42Xk
        VezsijRdXwYLaRFGdAtGPvqvVw==
X-Google-Smtp-Source: APXvYqxaGOq2uW9nbMSMhZZMtPEeYY7n6V1/XfqZQh4nmhVMGrEnuIbK5651XSfHBgApMqBWeS0HRA==
X-Received: by 2002:a65:534b:: with SMTP id w11mr30799017pgr.210.1559586854363;
        Mon, 03 Jun 2019 11:34:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q12sm13533571pjp.17.2019.06.03.11.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:13 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 05/30] mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
Date:   Mon,  3 Jun 2019 11:33:36 -0700
Message-Id: <20190603183401.151408-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change is required for compilation of embedded controller firmware
to work properly (See CONFIG_HOSTCMD_SECTION_SORTED).

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 235 ++++++++++++++++-----------
 1 file changed, 136 insertions(+), 99 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index c12ae9742e20..8ad77d8a9141 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -553,6 +553,9 @@ struct ec_host_response {
  * Parameter/response length is implicit in the structs.  Some underlying
  * communication protocols (I2C, SPI) may add length or checksum headers, but
  * those are implementation-dependent and not defined here.
+ *
+ * All commands MUST be #defined to be 4-digit UPPER CASE hex values
+ * (e.g., 0x00AB, not 0xab) for CONFIG_HOSTCMD_SECTION_SORTED to work.
  */
 
 /*****************************************************************************/
@@ -562,7 +565,7 @@ struct ec_host_response {
  * Get protocol version, used to deal with non-backward compatible protocol
  * changes.
  */
-#define EC_CMD_PROTO_VERSION 0x00
+#define EC_CMD_PROTO_VERSION 0x0000
 
 /**
  * struct ec_response_proto_version - Response to the proto version command.
@@ -576,7 +579,7 @@ struct ec_response_proto_version {
  * Hello.  This is a simple command to test the EC is responsive to
  * commands.
  */
-#define EC_CMD_HELLO 0x01
+#define EC_CMD_HELLO 0x0001
 
 /**
  * struct ec_params_hello - Parameters to the hello command.
@@ -595,7 +598,7 @@ struct ec_response_hello {
 } __ec_align4;
 
 /* Get version number */
-#define EC_CMD_GET_VERSION 0x02
+#define EC_CMD_GET_VERSION 0x0002
 
 enum ec_current_image {
 	EC_IMAGE_UNKNOWN = 0,
@@ -618,7 +621,7 @@ struct ec_response_get_version {
 } __ec_align4;
 
 /* Read test */
-#define EC_CMD_READ_TEST 0x03
+#define EC_CMD_READ_TEST 0x0003
 
 /**
  * struct ec_params_read_test - Parameters for the read test command.
@@ -643,10 +646,10 @@ struct ec_response_read_test {
  *
  * Response is null-terminated string.
  */
-#define EC_CMD_GET_BUILD_INFO 0x04
+#define EC_CMD_GET_BUILD_INFO 0x0004
 
 /* Get chip info */
-#define EC_CMD_GET_CHIP_INFO 0x05
+#define EC_CMD_GET_CHIP_INFO 0x0005
 
 /**
  * struct ec_response_get_chip_info - Response to the get chip info command.
@@ -661,7 +664,7 @@ struct ec_response_get_chip_info {
 } __ec_align4;
 
 /* Get board HW version */
-#define EC_CMD_GET_BOARD_VERSION 0x06
+#define EC_CMD_GET_BOARD_VERSION 0x0006
 
 /**
  * struct ec_response_board_version - Response to the board version command.
@@ -679,7 +682,7 @@ struct ec_response_board_version {
  *
  * Response is params.size bytes of data.
  */
-#define EC_CMD_READ_MEMMAP 0x07
+#define EC_CMD_READ_MEMMAP 0x0007
 
 /**
  * struct ec_params_read_memmap - Parameters for the read memory map command.
@@ -692,7 +695,7 @@ struct ec_params_read_memmap {
 } __ec_align1;
 
 /* Read versions supported for a command */
-#define EC_CMD_GET_CMD_VERSIONS 0x08
+#define EC_CMD_GET_CMD_VERSIONS 0x0008
 
 /**
  * struct ec_params_get_cmd_versions - Parameters for the get command versions.
@@ -727,7 +730,7 @@ struct ec_response_get_cmd_versions {
  * lpc must read the status from the command register. Attempting this on
  * lpc will overwrite the args/parameter space and corrupt its data.
  */
-#define EC_CMD_GET_COMMS_STATUS		0x09
+#define EC_CMD_GET_COMMS_STATUS		0x0009
 
 /* Avoid using ec_status which is for return values */
 enum ec_comms_status {
@@ -744,7 +747,7 @@ struct ec_response_get_comms_status {
 } __ec_align4;
 
 /* Fake a variety of responses, purely for testing purposes. */
-#define EC_CMD_TEST_PROTOCOL		0x0a
+#define EC_CMD_TEST_PROTOCOL		0x000A
 
 /* Tell the EC what to send back to us. */
 struct ec_params_test_protocol {
@@ -759,7 +762,7 @@ struct ec_response_test_protocol {
 } __ec_align4;
 
 /* Get protocol information */
-#define EC_CMD_GET_PROTOCOL_INFO	0x0b
+#define EC_CMD_GET_PROTOCOL_INFO	0x000B
 
 /* Flags for ec_response_get_protocol_info.flags */
 /* EC_RES_IN_PROGRESS may be returned if a command is slow */
@@ -805,11 +808,11 @@ struct ec_response_get_set_value {
 } __ec_align4;
 
 /* More than one command can use these structs to get/set parameters. */
-#define EC_CMD_GSV_PAUSE_IN_S5	0x0c
+#define EC_CMD_GSV_PAUSE_IN_S5	0x000C
 
 /*****************************************************************************/
 /* List the features supported by the firmware */
-#define EC_CMD_GET_FEATURES  0x0d
+#define EC_CMD_GET_FEATURES  0x000D
 
 /* Supported features */
 enum ec_feature_code {
@@ -933,7 +936,7 @@ struct ec_response_get_features {
 /* Flash commands */
 
 /* Get flash info */
-#define EC_CMD_FLASH_INFO 0x10
+#define EC_CMD_FLASH_INFO 0x0010
 
 /**
  * struct ec_response_flash_info - Response to the flash info command.
@@ -1000,7 +1003,7 @@ struct ec_response_flash_info_1 {
  *
  * Response is params.size bytes of data.
  */
-#define EC_CMD_FLASH_READ 0x11
+#define EC_CMD_FLASH_READ 0x0011
 
 /**
  * struct ec_params_flash_read - Parameters for the flash read command.
@@ -1013,7 +1016,7 @@ struct ec_params_flash_read {
 } __ec_align4;
 
 /* Write flash */
-#define EC_CMD_FLASH_WRITE 0x12
+#define EC_CMD_FLASH_WRITE 0x0012
 #define EC_VER_FLASH_WRITE 1
 
 /* Version 0 of the flash command supported only 64 bytes of data */
@@ -1031,7 +1034,7 @@ struct ec_params_flash_write {
 } __ec_align4;
 
 /* Erase flash */
-#define EC_CMD_FLASH_ERASE 0x13
+#define EC_CMD_FLASH_ERASE 0x0013
 
 /**
  * struct ec_params_flash_erase - Parameters for the flash erase command.
@@ -1053,7 +1056,7 @@ struct ec_params_flash_erase {
  *
  * If mask=0, simply returns the current flags state.
  */
-#define EC_CMD_FLASH_PROTECT 0x15
+#define EC_CMD_FLASH_PROTECT 0x0015
 #define EC_VER_FLASH_PROTECT 1  /* Command version 1 */
 
 /* Flags for flash protection */
@@ -1110,7 +1113,7 @@ struct ec_response_flash_protect {
  */
 
 /* Get the region offset/size */
-#define EC_CMD_FLASH_REGION_INFO 0x16
+#define EC_CMD_FLASH_REGION_INFO 0x0016
 #define EC_VER_FLASH_REGION_INFO 1
 
 enum ec_flash_region {
@@ -1142,7 +1145,7 @@ struct ec_response_flash_region_info {
 } __ec_align4;
 
 /* Read/write VbNvContext */
-#define EC_CMD_VBNV_CONTEXT 0x17
+#define EC_CMD_VBNV_CONTEXT 0x0017
 #define EC_VER_VBNV_CONTEXT 1
 #define EC_VBNV_BLOCK_SIZE 16
 
@@ -1164,7 +1167,7 @@ struct ec_response_vbnvcontext {
 /* PWM commands */
 
 /* Get fan target RPM */
-#define EC_CMD_PWM_GET_FAN_TARGET_RPM 0x20
+#define EC_CMD_PWM_GET_FAN_TARGET_RPM 0x0020
 
 struct ec_response_pwm_get_fan_rpm {
 	uint32_t rpm;
@@ -1178,7 +1181,7 @@ struct ec_params_pwm_set_fan_target_rpm {
 } __ec_align_size1;
 
 /* Get keyboard backlight */
-#define EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT 0x22
+#define EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT 0x0022
 
 struct ec_response_pwm_get_keyboard_backlight {
 	uint8_t percent;
@@ -1186,20 +1189,20 @@ struct ec_response_pwm_get_keyboard_backlight {
 } __ec_align1;
 
 /* Set keyboard backlight */
-#define EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT 0x23
+#define EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT 0x0023
 
 struct ec_params_pwm_set_keyboard_backlight {
 	uint8_t percent;
 } __ec_align1;
 
 /* Set target fan PWM duty cycle */
-#define EC_CMD_PWM_SET_FAN_DUTY 0x24
+#define EC_CMD_PWM_SET_FAN_DUTY 0x0024
 
 struct ec_params_pwm_set_fan_duty {
 	uint32_t percent;
 } __ec_align4;
 
-#define EC_CMD_PWM_SET_DUTY 0x25
+#define EC_CMD_PWM_SET_DUTY 0x0025
 /* 16 bit duty cycle, 0xffff = 100% */
 #define EC_PWM_MAX_DUTY 0xffff
 
@@ -1219,7 +1222,7 @@ struct ec_params_pwm_set_duty {
 	uint8_t index;     /* Type-specific index, or 0 if unique */
 } __ec_align4;
 
-#define EC_CMD_PWM_GET_DUTY 0x26
+#define EC_CMD_PWM_GET_DUTY 0x0026
 
 struct ec_params_pwm_get_duty {
 	uint8_t pwm_type;  /* ec_pwm_type */
@@ -1237,7 +1240,7 @@ struct ec_response_pwm_get_duty {
  * into a subcommand. We'll make separate structs for subcommands with
  * different input args, so that we know how much to expect.
  */
-#define EC_CMD_LIGHTBAR_CMD 0x28
+#define EC_CMD_LIGHTBAR_CMD 0x0028
 
 struct rgb_s {
 	uint8_t r, g, b;
@@ -1431,7 +1434,7 @@ enum lightbar_command {
 /*****************************************************************************/
 /* LED control commands */
 
-#define EC_CMD_LED_CONTROL 0x29
+#define EC_CMD_LED_CONTROL 0x0029
 
 enum ec_led_id {
 	/* LED to indicate battery state of charge */
@@ -1488,7 +1491,7 @@ struct ec_response_led_control {
  */
 
 /* Verified boot hash command */
-#define EC_CMD_VBOOT_HASH 0x2A
+#define EC_CMD_VBOOT_HASH 0x002A
 
 struct ec_params_vboot_hash {
 	uint8_t cmd;             /* enum ec_vboot_hash_cmd */
@@ -1540,7 +1543,7 @@ enum ec_vboot_hash_status {
  * Motion sense commands. We'll make separate structs for sub-commands with
  * different input args, so that we know how much to expect.
  */
-#define EC_CMD_MOTION_SENSE_CMD 0x2B
+#define EC_CMD_MOTION_SENSE_CMD 0x002B
 
 /* Motion sense commands */
 enum motionsense_command {
@@ -1804,7 +1807,7 @@ struct ec_response_motion_sense {
 /* USB charging control commands */
 
 /* Set USB port charging mode */
-#define EC_CMD_USB_CHARGE_SET_MODE 0x30
+#define EC_CMD_USB_CHARGE_SET_MODE 0x0030
 
 struct ec_params_usb_charge_set_mode {
 	uint8_t usb_port_id;
@@ -1818,7 +1821,7 @@ struct ec_params_usb_charge_set_mode {
 #define EC_PSTORE_SIZE_MAX 64
 
 /* Get persistent storage info */
-#define EC_CMD_PSTORE_INFO 0x40
+#define EC_CMD_PSTORE_INFO 0x0040
 
 struct ec_response_pstore_info {
 	/* Persistent storage size, in bytes */
@@ -1832,7 +1835,7 @@ struct ec_response_pstore_info {
  *
  * Response is params.size bytes of data.
  */
-#define EC_CMD_PSTORE_READ 0x41
+#define EC_CMD_PSTORE_READ 0x0041
 
 struct ec_params_pstore_read {
 	uint32_t offset;   /* Byte offset to read */
@@ -1840,7 +1843,7 @@ struct ec_params_pstore_read {
 } __ec_align4;
 
 /* Write persistent storage */
-#define EC_CMD_PSTORE_WRITE 0x42
+#define EC_CMD_PSTORE_WRITE 0x0042
 
 struct ec_params_pstore_write {
 	uint32_t offset;   /* Byte offset to write */
@@ -1861,12 +1864,12 @@ struct ec_response_rtc {
 } __ec_align4;
 
 /* These use ec_response_rtc */
-#define EC_CMD_RTC_GET_VALUE 0x44
-#define EC_CMD_RTC_GET_ALARM 0x45
+#define EC_CMD_RTC_GET_VALUE 0x0044
+#define EC_CMD_RTC_GET_ALARM 0x0045
 
 /* These all use ec_params_rtc */
-#define EC_CMD_RTC_SET_VALUE 0x46
-#define EC_CMD_RTC_SET_ALARM 0x47
+#define EC_CMD_RTC_SET_VALUE 0x0046
+#define EC_CMD_RTC_SET_ALARM 0x0047
 
 /* Pass as time param to SET_ALARM to clear the current alarm */
 #define EC_RTC_ALARM_CLEAR 0
@@ -1878,8 +1881,8 @@ struct ec_response_rtc {
 #define EC_PORT80_SIZE_MAX 32
 
 /* Get last port80 code from previous boot */
-#define EC_CMD_PORT80_LAST_BOOT 0x48
-#define EC_CMD_PORT80_READ 0x48
+#define EC_CMD_PORT80_LAST_BOOT 0x0048
+#define EC_CMD_PORT80_READ 0x0048
 
 enum ec_port80_subcmd {
 	EC_PORT80_GET_INFO = 0,
@@ -1920,8 +1923,8 @@ struct ec_response_port80_last_boot {
  * Version 1 separates the CPU thermal limits from the fan control.
  */
 
-#define EC_CMD_THERMAL_SET_THRESHOLD 0x50
-#define EC_CMD_THERMAL_GET_THRESHOLD 0x51
+#define EC_CMD_THERMAL_SET_THRESHOLD 0x0050
+#define EC_CMD_THERMAL_GET_THRESHOLD 0x0051
 
 /* The version 0 structs are opaque. You have to know what they are for
  * the get/set commands to make any sense.
@@ -1983,10 +1986,10 @@ struct ec_params_thermal_set_threshold_v1 {
 /****************************************************************************/
 
 /* Toggle automatic fan control */
-#define EC_CMD_THERMAL_AUTO_FAN_CTRL 0x52
+#define EC_CMD_THERMAL_AUTO_FAN_CTRL 0x0052
 
 /* Get TMP006 calibration data */
-#define EC_CMD_TMP006_GET_CALIBRATION 0x53
+#define EC_CMD_TMP006_GET_CALIBRATION 0x0053
 
 struct ec_params_tmp006_get_calibration {
 	uint8_t index;
@@ -2000,7 +2003,7 @@ struct ec_response_tmp006_get_calibration {
 } __ec_align4;
 
 /* Set TMP006 calibration data */
-#define EC_CMD_TMP006_SET_CALIBRATION 0x54
+#define EC_CMD_TMP006_SET_CALIBRATION 0x0054
 
 struct ec_params_tmp006_set_calibration {
 	uint8_t index;
@@ -2012,7 +2015,7 @@ struct ec_params_tmp006_set_calibration {
 } __ec_align4;
 
 /* Read raw TMP006 data */
-#define EC_CMD_TMP006_GET_RAW 0x55
+#define EC_CMD_TMP006_GET_RAW 0x0055
 
 struct ec_params_tmp006_get_raw {
 	uint8_t index;
@@ -2036,12 +2039,12 @@ struct ec_response_tmp006_get_raw {
  * to obtain the instantaneous state, use EC_CMD_MKBP_INFO with the type
  * EC_MKBP_INFO_CURRENT and event EC_MKBP_EVENT_KEY_MATRIX.
  */
-#define EC_CMD_MKBP_STATE 0x60
+#define EC_CMD_MKBP_STATE 0x0060
 
 /*
  * Provide information about various MKBP things.  See enum ec_mkbp_info_type.
  */
-#define EC_CMD_MKBP_INFO 0x61
+#define EC_CMD_MKBP_INFO 0x0061
 
 struct ec_response_mkbp_info {
 	uint32_t rows;
@@ -2095,7 +2098,7 @@ enum ec_mkbp_info_type {
 };
 
 /* Simulate key press */
-#define EC_CMD_MKBP_SIMULATE_KEY 0x62
+#define EC_CMD_MKBP_SIMULATE_KEY 0x0062
 
 struct ec_params_mkbp_simulate_key {
 	uint8_t col;
@@ -2104,8 +2107,8 @@ struct ec_params_mkbp_simulate_key {
 } __ec_align1;
 
 /* Configure keyboard scanning */
-#define EC_CMD_MKBP_SET_CONFIG 0x64
-#define EC_CMD_MKBP_GET_CONFIG 0x65
+#define EC_CMD_MKBP_SET_CONFIG 0x0064
+#define EC_CMD_MKBP_GET_CONFIG 0x0065
 
 /* flags */
 enum mkbp_config_flags {
@@ -2158,7 +2161,7 @@ struct ec_response_mkbp_get_config {
 } __ec_align_size1;
 
 /* Run the key scan emulation */
-#define EC_CMD_KEYSCAN_SEQ_CTRL 0x66
+#define EC_CMD_KEYSCAN_SEQ_CTRL 0x0066
 
 enum ec_keyscan_seq_cmd {
 	EC_KEYSCAN_SEQ_STATUS = 0,	/* Get status information */
@@ -2219,7 +2222,7 @@ struct ec_result_keyscan_seq_ctrl {
  *
  * The device replies with UNAVAILABLE if there aren't any pending events.
  */
-#define EC_CMD_GET_NEXT_EVENT 0x67
+#define EC_CMD_GET_NEXT_EVENT 0x0067
 
 enum ec_mkbp_event {
 	/* Keyboard matrix changed. The event data is the new matrix state. */
@@ -2298,7 +2301,7 @@ struct ec_response_get_next_event_v1 {
 /* Temperature sensor commands */
 
 /* Read temperature sensor info */
-#define EC_CMD_TEMP_SENSOR_GET_INFO 0x70
+#define EC_CMD_TEMP_SENSOR_GET_INFO 0x0070
 
 struct ec_params_temp_sensor_get_info {
 	uint8_t id;
@@ -2333,30 +2336,30 @@ struct ec_response_host_event_mask {
 } __ec_align4;
 
 /* These all use ec_response_host_event_mask */
-#define EC_CMD_HOST_EVENT_GET_B         0x87
-#define EC_CMD_HOST_EVENT_GET_SMI_MASK  0x88
-#define EC_CMD_HOST_EVENT_GET_SCI_MASK  0x89
-#define EC_CMD_HOST_EVENT_GET_WAKE_MASK 0x8d
+#define EC_CMD_HOST_EVENT_GET_B         0x0087
+#define EC_CMD_HOST_EVENT_GET_SMI_MASK  0x0088
+#define EC_CMD_HOST_EVENT_GET_SCI_MASK  0x0089
+#define EC_CMD_HOST_EVENT_GET_WAKE_MASK 0x008D
 
 /* These all use ec_params_host_event_mask */
-#define EC_CMD_HOST_EVENT_SET_SMI_MASK  0x8a
-#define EC_CMD_HOST_EVENT_SET_SCI_MASK  0x8b
-#define EC_CMD_HOST_EVENT_CLEAR         0x8c
-#define EC_CMD_HOST_EVENT_SET_WAKE_MASK 0x8e
-#define EC_CMD_HOST_EVENT_CLEAR_B       0x8f
+#define EC_CMD_HOST_EVENT_SET_SMI_MASK  0x008A
+#define EC_CMD_HOST_EVENT_SET_SCI_MASK  0x008B
+#define EC_CMD_HOST_EVENT_CLEAR         0x008C
+#define EC_CMD_HOST_EVENT_SET_WAKE_MASK 0x008E
+#define EC_CMD_HOST_EVENT_CLEAR_B       0x008F
 
 /*****************************************************************************/
 /* Switch commands */
 
 /* Enable/disable LCD backlight */
-#define EC_CMD_SWITCH_ENABLE_BKLIGHT 0x90
+#define EC_CMD_SWITCH_ENABLE_BKLIGHT 0x0090
 
 struct ec_params_switch_enable_backlight {
 	uint8_t enabled;
 } __ec_align1;
 
 /* Enable/disable WLAN/Bluetooth */
-#define EC_CMD_SWITCH_ENABLE_WIRELESS 0x91
+#define EC_CMD_SWITCH_ENABLE_WIRELESS 0x0091
 #define EC_VER_SWITCH_ENABLE_WIRELESS 1
 
 /* Version 0 params; no response */
@@ -2396,7 +2399,7 @@ struct ec_response_switch_enable_wireless_v1 {
 /* GPIO commands. Only available on EC if write protect has been disabled. */
 
 /* Set GPIO output value */
-#define EC_CMD_GPIO_SET 0x92
+#define EC_CMD_GPIO_SET 0x0092
 
 struct ec_params_gpio_set {
 	char name[32];
@@ -2404,7 +2407,7 @@ struct ec_params_gpio_set {
 } __ec_align1;
 
 /* Get GPIO value */
-#define EC_CMD_GPIO_GET 0x93
+#define EC_CMD_GPIO_GET 0x0093
 
 /* Version 0 of input params and response */
 struct ec_params_gpio_get {
@@ -2458,7 +2461,7 @@ enum gpio_get_subcmd {
  */
 
 /* Read I2C bus */
-#define EC_CMD_I2C_READ 0x94
+#define EC_CMD_I2C_READ 0x0094
 
 struct ec_params_i2c_read {
 	uint16_t addr; /* 8-bit address (7-bit shifted << 1) */
@@ -2472,7 +2475,7 @@ struct ec_response_i2c_read {
 } __ec_align2;
 
 /* Write I2C bus */
-#define EC_CMD_I2C_WRITE 0x95
+#define EC_CMD_I2C_WRITE 0x0095
 
 struct ec_params_i2c_write {
 	uint16_t data;
@@ -2488,7 +2491,7 @@ struct ec_params_i2c_write {
 /* Force charge state machine to stop charging the battery or force it to
  * discharge the battery.
  */
-#define EC_CMD_CHARGE_CONTROL 0x96
+#define EC_CMD_CHARGE_CONTROL 0x0096
 #define EC_VER_CHARGE_CONTROL 1
 
 enum ec_charge_control_mode {
@@ -2504,7 +2507,7 @@ struct ec_params_charge_control {
 /*****************************************************************************/
 
 /* Snapshot console output buffer for use by EC_CMD_CONSOLE_READ. */
-#define EC_CMD_CONSOLE_SNAPSHOT 0x97
+#define EC_CMD_CONSOLE_SNAPSHOT 0x0097
 
 /*
  * Read data from the saved snapshot. If the subcmd parameter is
@@ -2518,7 +2521,7 @@ struct ec_params_charge_control {
  * Response is null-terminated string.  Empty string, if there is no more
  * remaining output.
  */
-#define EC_CMD_CONSOLE_READ 0x98
+#define EC_CMD_CONSOLE_READ 0x0098
 
 enum ec_console_read_subcmd {
 	CONSOLE_READ_NEXT = 0,
@@ -2538,8 +2541,7 @@ struct ec_params_console_read_v1 {
  *	  EC_RES_SUCCESS if the command was successful.
  *	  EC_RES_ERROR if the cut off command failed.
  */
-
-#define EC_CMD_BATTERY_CUT_OFF 0x99
+#define EC_CMD_BATTERY_CUT_OFF 0x0099
 
 #define EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN	(1 << 0)
 
@@ -2553,7 +2555,7 @@ struct ec_params_battery_cutoff {
 /*
  * Switch USB mux or return to automatic switching.
  */
-#define EC_CMD_USB_MUX 0x9a
+#define EC_CMD_USB_MUX 0x009A
 
 struct ec_params_usb_mux {
 	uint8_t mux;
@@ -2570,7 +2572,7 @@ enum ec_ldo_state {
 /*
  * Switch on/off a LDO.
  */
-#define EC_CMD_LDO_SET 0x9b
+#define EC_CMD_LDO_SET 0x009B
 
 struct ec_params_ldo_set {
 	uint8_t index;
@@ -2580,7 +2582,7 @@ struct ec_params_ldo_set {
 /*
  * Get LDO state.
  */
-#define EC_CMD_LDO_GET 0x9c
+#define EC_CMD_LDO_GET 0x009C
 
 struct ec_params_ldo_get {
 	uint8_t index;
@@ -2596,7 +2598,7 @@ struct ec_response_ldo_get {
 /*
  * Get power info.
  */
-#define EC_CMD_POWER_INFO 0x9d
+#define EC_CMD_POWER_INFO 0x009D
 
 struct ec_response_power_info {
 	uint32_t usb_dev_type;
@@ -2609,7 +2611,7 @@ struct ec_response_power_info {
 /*****************************************************************************/
 /* I2C passthru command */
 
-#define EC_CMD_I2C_PASSTHRU 0x9e
+#define EC_CMD_I2C_PASSTHRU 0x009E
 
 /* Read data; if not present, message is a write */
 #define EC_I2C_FLAG_READ	(1 << 15)
@@ -2644,7 +2646,7 @@ struct ec_response_i2c_passthru {
 /*****************************************************************************/
 /* Power button hang detect */
 
-#define EC_CMD_HANG_DETECT 0x9f
+#define EC_CMD_HANG_DETECT 0x009F
 
 /* Reasons to start hang detection timer */
 /* Power button pressed */
@@ -2703,7 +2705,7 @@ struct ec_params_hang_detect {
  * This is the single catch-all host command to exchange data regarding the
  * charge state machine (v2 and up).
  */
-#define EC_CMD_CHARGE_STATE 0xa0
+#define EC_CMD_CHARGE_STATE 0x00A0
 
 /* Subcommands for this host command */
 enum charge_state_command {
@@ -2774,7 +2776,7 @@ struct ec_response_charge_state {
 /*
  * Set maximum battery charging current.
  */
-#define EC_CMD_CHARGE_CURRENT_LIMIT 0xa1
+#define EC_CMD_CHARGE_CURRENT_LIMIT 0x00A1
 
 struct ec_params_current_limit {
 	uint32_t limit; /* in mA */
@@ -2794,7 +2796,7 @@ struct ec_params_external_power_limit_v1 {
 #define EC_POWER_LIMIT_NONE 0xffff
 
 /* Inform the EC when entering a sleep state */
-#define EC_CMD_HOST_SLEEP_EVENT 0xa9
+#define EC_CMD_HOST_SLEEP_EVENT 0x00A9
 
 enum host_sleep_event {
 	HOST_SLEEP_EVENT_S3_SUSPEND   = 1,
@@ -2868,14 +2870,14 @@ struct ec_response_host_sleep_event_v1 {
 /* Smart battery pass-through */
 
 /* Get / Set 16-bit smart battery registers */
-#define EC_CMD_SB_READ_WORD   0xb0
-#define EC_CMD_SB_WRITE_WORD  0xb1
+#define EC_CMD_SB_READ_WORD   0x00B0
+#define EC_CMD_SB_WRITE_WORD  0x00B1
 
 /* Get / Set string smart battery parameters
  * formatted as SMBUS "block".
  */
-#define EC_CMD_SB_READ_BLOCK  0xb2
-#define EC_CMD_SB_WRITE_BLOCK 0xb3
+#define EC_CMD_SB_READ_BLOCK  0x00B2
+#define EC_CMD_SB_WRITE_BLOCK 0x00B3
 
 struct ec_params_sb_rd {
 	uint8_t reg;
@@ -2908,7 +2910,7 @@ struct ec_params_sb_wr_block {
  * requested value.
  */
 
-#define EC_CMD_BATTERY_VENDOR_PARAM 0xb4
+#define EC_CMD_BATTERY_VENDOR_PARAM 0x00B4
 
 enum ec_battery_vendor_param_mode {
 	BATTERY_VENDOR_PARAM_MODE_GET = 0,
@@ -3024,7 +3026,7 @@ struct ec_response_codec_gain {
  * TODO(crosbug.com/p/23747): This is a confusing name, since it doesn't
  * necessarily reboot the EC.  Rename to "image" or something similar?
  */
-#define EC_CMD_REBOOT_EC 0xd2
+#define EC_CMD_REBOOT_EC 0x00D2
 
 /* Command */
 enum ec_reboot_cmd {
@@ -3052,7 +3054,7 @@ struct ec_params_reboot_ec {
  * Returns variable-length platform-dependent panic information.  See panic.h
  * for details.
  */
-#define EC_CMD_GET_PANIC_INFO 0xd3
+#define EC_CMD_GET_PANIC_INFO 0x00D3
 
 /*****************************************************************************/
 /*
@@ -3260,7 +3262,7 @@ enum mkbp_cec_event {
  *
  * Use EC_CMD_REBOOT_EC to reboot the EC more politely.
  */
-#define EC_CMD_REBOOT 0xd1  /* Think "die" */
+#define EC_CMD_REBOOT 0x00D1  /* Think "die" */
 
 /*
  * Resend last response (not supported on LPC).
@@ -3269,7 +3271,7 @@ enum mkbp_cec_event {
  * there was no previous command, or the previous command's response was too
  * big to save.
  */
-#define EC_CMD_RESEND_RESPONSE 0xdb
+#define EC_CMD_RESEND_RESPONSE 0x00DB
 
 /*
  * This header byte on a command indicate version 0. Any header byte less
@@ -3281,7 +3283,7 @@ enum mkbp_cec_event {
  *
  * The old EC interface must not use commands 0xdc or higher.
  */
-#define EC_CMD_VERSION0 0xdc
+#define EC_CMD_VERSION0 0x00DC
 
 #endif  /* !__ACPI__ */
 
@@ -3293,7 +3295,7 @@ enum mkbp_cec_event {
  */
 
 /* EC to PD MCU exchange status command */
-#define EC_CMD_PD_EXCHANGE_STATUS 0x100
+#define EC_CMD_PD_EXCHANGE_STATUS 0x0100
 
 /* Status of EC being sent to PD */
 struct ec_params_pd_status {
@@ -3307,7 +3309,7 @@ struct ec_response_pd_status {
 } __ec_align_size1;
 
 /* Set USB type-C port role and muxes */
-#define EC_CMD_USB_PD_CONTROL 0x101
+#define EC_CMD_USB_PD_CONTROL 0x0101
 
 enum usb_pd_control_role {
 	USB_PD_CTRL_ROLE_NO_CHANGE = 0,
@@ -3360,7 +3362,7 @@ struct ec_response_usb_pd_control_v1 {
 	char state[32];
 } __ec_align1;
 
-#define EC_CMD_USB_PD_PORTS 0x102
+#define EC_CMD_USB_PD_PORTS 0x0102
 
 /* Maximum number of PD ports on a device, num_ports will be <= this */
 #define EC_USB_PD_MAX_PORTS 8
@@ -3369,7 +3371,7 @@ struct ec_response_usb_pd_ports {
 	uint8_t num_ports;
 } __ec_align1;
 
-#define EC_CMD_USB_PD_POWER_INFO 0x103
+#define EC_CMD_USB_PD_POWER_INFO 0x0103
 
 #define PD_POWER_CHARGING_PORT 0xff
 struct ec_params_usb_pd_power_info {
@@ -3536,7 +3538,7 @@ struct mcdp_info {
 #define MCDP_FAMILY(family) ((family[0] << 8) | family[1])
 
 /* Get info about USB-C SS muxes */
-#define EC_CMD_USB_PD_MUX_INFO 0x11a
+#define EC_CMD_USB_PD_MUX_INFO 0x011A
 
 struct ec_params_usb_pd_mux_info {
 	uint8_t port; /* USB-C port number */
@@ -3551,6 +3553,41 @@ struct ec_params_usb_pd_mux_info {
 struct ec_response_usb_pd_mux_info {
 	uint8_t flags; /* USB_PD_MUX_*-encoded USB mux state */
 } __ec_align1;
+/*****************************************************************************/
+/*
+ * Reserve a range of host commands for board-specific, experimental, or
+ * special purpose features. These can be (re)used without updating this file.
+ *
+ * CAUTION: Don't go nuts with this. Shipping products should document ALL
+ * their EC commands for easier development, testing, debugging, and support.
+ *
+ * All commands MUST be #defined to be 4-digit UPPER CASE hex values
+ * (e.g., 0x00AB, not 0xab) for CONFIG_HOSTCMD_SECTION_SORTED to work.
+ *
+ * In your experimental code, you may want to do something like this:
+ *
+ *   #define EC_CMD_MAGIC_FOO 0x0000
+ *   #define EC_CMD_MAGIC_BAR 0x0001
+ *   #define EC_CMD_MAGIC_HEY 0x0002
+ *
+ *   DECLARE_PRIVATE_HOST_COMMAND(EC_CMD_MAGIC_FOO, magic_foo_handler,
+ *      EC_VER_MASK(0);
+ *
+ *   DECLARE_PRIVATE_HOST_COMMAND(EC_CMD_MAGIC_BAR, magic_bar_handler,
+ *      EC_VER_MASK(0);
+ *
+ *   DECLARE_PRIVATE_HOST_COMMAND(EC_CMD_MAGIC_HEY, magic_hey_handler,
+ *      EC_VER_MASK(0);
+ */
+#define EC_CMD_BOARD_SPECIFIC_BASE 0x3E00
+#define EC_CMD_BOARD_SPECIFIC_LAST 0x3FFF
+
+/*
+ * Given the private host command offset, calculate the true private host
+ * command value.
+ */
+#define EC_PRIVATE_HOST_COMMAND_VALUE(command) \
+	(EC_CMD_BOARD_SPECIFIC_BASE + (command))
 
 /*****************************************************************************/
 /*
-- 
2.21.0.1020.gf2820cf01a-goog

