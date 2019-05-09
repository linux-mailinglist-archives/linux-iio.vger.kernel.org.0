Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8119432
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEIVOJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:14:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40428 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfEIVOI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so1728060plr.7
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v2F4KWm2eiK23Yoj5KHgGaf1XqLoLzcralXowddf1E=;
        b=KEOzxKWa/p3fz4hwbBh3MLFQ85xVFqHfrgW/M5fqVpduoGzdbN0mLSs9uOxr6F1Ne/
         QxQcVPg+pl2DgApuFXDksXpLeFk+GtBI5InLam3t+UDpNMkhALBhaq9Zdg4UbHj7GgwN
         55XEiTG/Kx3rw/fRI1Pqbe4ltqopcZCdA0Ric=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v2F4KWm2eiK23Yoj5KHgGaf1XqLoLzcralXowddf1E=;
        b=sscVZ+xZNTK+dtNdEs6zVW4PtdokOTSmg86jF3Cger2QNzWDIodJP3+YxBYqONftLz
         7ewysjIT7LixThtWtSeA1SiDGTsg1YsSspGIVnxA369Maatlu7FN5rwdhPBq0EMqXZDZ
         JM2wj1LAxb7bafCkSm4PJSGrlWyw7UJca7idOBqiuFsZNJqMBWJhYH+Ytde8eVAs9Zyq
         Ag//TyO/7o2aJacPVAONNZsAjxyAdoH208xMTknvEhx6NCLJ8QBYuHdBQKL4Dr72aTj6
         y5Kz9lGz2E7Lv0D3FnhYlnCrzA/N3z4L8N158uH/GHJ+A/lEryr2IdUxSJbT9xtBcGby
         uwhw==
X-Gm-Message-State: APjAAAUqHzQ30xrAC4oexa5gRq9/oD7Ya8DqrfcYsGO4YJbSgTQ94vRV
        jFZUxrFktfkVGCLgFH4Eqq12Zw==
X-Google-Smtp-Source: APXvYqwNC/OFbZqKpgq/dzu1PtxhiY9O16+/Sg0dfTLm4fEEORmF/MKJG071Xd2JvapBA9UaAMd8GQ==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr8352920plp.282.1557436447621;
        Thu, 09 May 2019 14:14:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h27sm5631972pfd.53.2019.05.09.14.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 03/30] mfd: cros_ec: set comments properly
Date:   Thu,  9 May 2019 14:13:26 -0700
Message-Id: <20190509211353.213194-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix comments syntax and spelling errors.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 65 +++++++++++++++++-----------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 7b8fac4d0c89..a7a7060f44f7 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -42,13 +42,16 @@
 /* Protocol version 2 */
 #define EC_LPC_ADDR_HOST_ARGS    0x800  /* And 0x801, 0x802, 0x803 */
 #define EC_LPC_ADDR_HOST_PARAM   0x804  /* For version 2 params; size is
-					 * EC_PROTO2_MAX_PARAM_SIZE */
+					 * EC_PROTO2_MAX_PARAM_SIZE
+					 */
 /* Protocol version 3 */
 #define EC_LPC_ADDR_HOST_PACKET  0x800  /* Offset of version 3 packet */
 #define EC_LPC_HOST_PACKET_SIZE  0x100  /* Max size of version 3 packet */
 
-/* The actual block is 0x800-0x8ff, but some BIOSes think it's 0x880-0x8ff
- * and they tell the kernel that so we have to think of it as two parts. */
+/*
+ * The actual block is 0x800-0x8ff, but some BIOSes think it's 0x880-0x8ff
+ * and they tell the kernel that so we have to think of it as two parts.
+ */
 #define EC_HOST_CMD_REGION0    0x800
 #define EC_HOST_CMD_REGION1    0x880
 #define EC_HOST_CMD_REGION_SIZE 0x80
@@ -324,7 +327,7 @@ struct ec_lpc_host_args {
  * If EC gets a command and this flag is not set, this is an old-style command.
  * Command version is 0 and params from host are at EC_LPC_ADDR_OLD_PARAM with
  * unknown length.  EC must respond with an old-style response (that is,
- * withouth setting EC_HOST_ARGS_FLAG_TO_HOST).
+ * without setting EC_HOST_ARGS_FLAG_TO_HOST).
  */
 #define EC_HOST_ARGS_FLAG_FROM_HOST 0x01
 /*
@@ -511,7 +514,7 @@ struct ec_host_response {
  * Notes on commands:
  *
  * Each command is an 16-bit command value.  Commands which take params or
- * return response data specify structs for that data.  If no struct is
+ * return response data specify structures for that data.  If no structure is
  * specified, the command does not input or output data, respectively.
  * Parameter/response length is implicit in the structs.  Some underlying
  * communication protocols (I2C, SPI) may add length or checksum headers, but
@@ -684,7 +687,7 @@ struct ec_response_get_cmd_versions {
 } __packed;
 
 /*
- * Check EC communcations status (busy). This is needed on i2c/spi but not
+ * Check EC communications status (busy). This is needed on i2c/spi but not
  * on lpc since it has its own out-of-band busy indicator.
  *
  * lpc must read the status from the command register. Attempting this on
@@ -721,7 +724,7 @@ struct ec_response_test_protocol {
 	uint8_t buf[32];
 } __packed;
 
-/* Get prococol information */
+/* Get protocol information */
 #define EC_CMD_GET_PROTOCOL_INFO	0x0b
 
 /* Flags for ec_response_get_protocol_info.flags */
@@ -767,7 +770,7 @@ struct ec_response_get_set_value {
 	uint32_t value;
 } __packed;
 
-/* More than one command can use these structs to get/set paramters. */
+/* More than one command can use these structs to get/set parameters. */
 #define EC_CMD_GSV_PAUSE_IN_S5	0x0c
 
 /*****************************************************************************/
@@ -917,8 +920,10 @@ struct ec_response_flash_info {
 	uint32_t protect_block_size;
 } __packed;
 
-/* Flags for version 1+ flash info command */
-/* EC flash erases bits to 0 instead of 1 */
+/*
+ * Flags for version 1+ flash info command
+ * EC flash erases bits to 0 instead of 1.
+ */
 #define EC_FLASH_INFO_ERASE_TO_0 (1 << 0)
 
 /**
@@ -941,7 +946,8 @@ struct ec_response_flash_info {
  * fields following.
  *
  * gcc anonymous structs don't seem to get along with the __packed directive;
- * if they did we'd define the version 0 struct as a sub-struct of this one.
+ * if they did we'd define the version 0 structure as a sub-structure of this
+ * one.
  */
 struct ec_response_flash_info_1 {
 	/* Version 0 fields; see above for description */
@@ -1036,7 +1042,7 @@ struct ec_params_flash_erase {
  * re-requesting the desired flags, or by a hard reset if that fails.
  */
 #define EC_FLASH_PROTECT_ERROR_INCONSISTENT (1 << 5)
-/* Entile flash code protected when the EC boots */
+/* Entire flash code protected when the EC boots */
 #define EC_FLASH_PROTECT_ALL_AT_BOOT        (1 << 6)
 
 /**
@@ -1629,7 +1635,7 @@ struct ec_response_motion_sensor_data {
 	union {
 		int16_t             data[3];
 		struct {
-			uint16_t    rsvd;
+			uint16_t    reserved;
 			uint32_t    timestamp;
 		} __packed;
 		struct {
@@ -1828,7 +1834,7 @@ struct ec_response_rtc {
 #define EC_CMD_RTC_SET_VALUE 0x46
 #define EC_CMD_RTC_SET_ALARM 0x47
 
-/* Pass as param to SET_ALARM to clear the current alarm */
+/* Pass as time param to SET_ALARM to clear the current alarm */
 #define EC_RTC_ALARM_CLEAR 0
 
 /*****************************************************************************/
@@ -1914,7 +1920,8 @@ enum ec_temp_thresholds {
 	EC_TEMP_THRESH_COUNT
 };
 
-/* Thermal configuration for one temperature sensor. Temps are in degrees K.
+/*
+ * Thermal configuration for one temperature sensor. Temps are in degrees K.
  * Zero values will be silently ignored by the thermal task.
  */
 struct ec_thermal_config {
@@ -1929,8 +1936,10 @@ struct ec_params_thermal_get_threshold_v1 {
 } __packed;
 /* This returns a struct ec_thermal_config */
 
-/* Version 1 - set config for one sensor.
- * Use read-modify-write for best results! */
+/*
+ * Version 1 - set config for one sensor.
+ * Use read-modify-write for best results!
+ */
 struct ec_params_thermal_set_threshold_v1 {
 	uint32_t sensor_num;
 	struct ec_thermal_config cfg;
@@ -2079,7 +2088,12 @@ enum mkbp_config_valid {
 	EC_MKBP_VALID_FIFO_MAX_DEPTH		= 1 << 7,
 };
 
-/* Configuration for our key scanning algorithm */
+/*
+ * Configuration for our key scanning algorithm.
+ *
+ * Note that this is used as a sub-structure of
+ * ec_{params/response}_mkbp_get_config.
+ */
 struct ec_mkbp_config {
 	uint32_t valid_mask;		/* valid fields */
 	uint8_t flags;		/* some flags (enum mkbp_config_flags) */
@@ -2362,6 +2376,7 @@ struct ec_params_gpio_set {
 struct ec_params_gpio_get {
 	char name[32];
 } __packed;
+
 struct ec_response_gpio_get {
 	uint8_t val;
 } __packed;
@@ -2402,8 +2417,10 @@ enum gpio_get_subcmd {
 /* I2C commands. Only available when flash write protect is unlocked. */
 
 /*
- * TODO(crosbug.com/p/23570): These commands are deprecated, and will be
- * removed soon.  Use EC_CMD_I2C_XFER instead.
+ * CAUTION: These commands are deprecated, and are not supported anymore in EC
+ * builds >= 8398.0.0 (see crosbug.com/p/23570).
+ *
+ * Use EC_CMD_I2C_PASSTHRU instead.
  */
 
 /* Read I2C bus */
@@ -2415,6 +2432,7 @@ struct ec_params_i2c_read {
 	uint8_t port;
 	uint8_t offset;
 } __packed;
+
 struct ec_response_i2c_read {
 	uint16_t data;
 } __packed;
@@ -2450,7 +2468,6 @@ struct ec_params_charge_control {
 } __packed;
 
 /*****************************************************************************/
-/* Console commands. Only available when flash write protect is unlocked. */
 
 /* Snapshot console output buffer for use by EC_CMD_CONSOLE_READ. */
 #define EC_CMD_CONSOLE_SNAPSHOT 0x97
@@ -2904,9 +2921,7 @@ enum ec_i2s_config {
 };
 
 struct ec_param_codec_i2s {
-	/*
-	 * enum ec_codec_i2s_subcmd
-	 */
+	/* enum ec_codec_i2s_subcmd */
 	uint8_t cmd;
 	union {
 		/*
@@ -2981,7 +2996,7 @@ struct ec_response_codec_gain {
 enum ec_reboot_cmd {
 	EC_REBOOT_CANCEL = 0,        /* Cancel a pending reboot */
 	EC_REBOOT_JUMP_RO = 1,       /* Jump to RO without rebooting */
-	EC_REBOOT_JUMP_RW = 2,       /* Jump to RW without rebooting */
+	EC_REBOOT_JUMP_RW = 2,       /* Jump to active RW without rebooting */
 	/* (command 3 was jump to RW-B) */
 	EC_REBOOT_COLD = 4,          /* Cold-reboot */
 	EC_REBOOT_DISABLE_JUMP = 5,  /* Disable jump until next reboot */
-- 
2.21.0.1020.gf2820cf01a-goog

