Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1320D13516
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfECWCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:02:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33784 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfECWCw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:02:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so3354323pgh.0
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTnbZ0JVqOJuCviiKrZEFkB/EIxy969pDaCvDodDXyE=;
        b=BXrz2PQzLo2v6vgmML2jDhBlnpXAds6+onk3jO98JchDf2JvLcGnjNMB01G3DsL2w4
         kFi6GtMSrzTgo60M55b9Sw/PZW30mKcdYJbqAoX8QP5xMZGWJ3lhZ8CEHYv6y19zlesN
         IAOQTytW9HHC5JN/ooKjbHkczptB5D3Qx7Ntg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTnbZ0JVqOJuCviiKrZEFkB/EIxy969pDaCvDodDXyE=;
        b=MB1hWUwLesp4Ty3OydSD8l9InJJXIM0fLP5MtJbNhnhjH+6mkENXAFDghDRDp5spiL
         vtVHyzvdGFXBuo0xDOXCPpOPy2qqs+sCdLyZeqKNcn/A8SEvOc12p91RE/jem9IetfS9
         dUOw0j+mX0ICuPV4SCwol6y0Sc4H1bWz2UPHf3BA6ywWsbLPs9Rr/csFVj/0CIHYaE8E
         PmoUFL4BWibCupBgcfeG8KtH8/IuJQwzBUwvaKWFL6f7mYTNE54Y2Lx+cSSnYG6YnSiW
         24iWE2Q7NeLeHhVCHdKMJ0fb5XCXuceuhPWNdc2YS5llH1jn6jyHwz8cO8A4NT6XR/nf
         MHpg==
X-Gm-Message-State: APjAAAW+EocfEq+g5BNQ02gNvBBzCX2XX4jOeIyoskTq/kizpk3BRd1Q
        8cO29KA3G0rkS5PmoLosKlVuIQ==
X-Google-Smtp-Source: APXvYqy6Qyv2YY08UivT7tpENFcWihvJDtRuFgtHUyPQNDWJDvP48U6Rqsx/ioI9BhiCKgQo1vn2Lg==
X-Received: by 2002:a65:4183:: with SMTP id a3mr13755924pgq.121.1556920970122;
        Fri, 03 May 2019 15:02:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y14sm3499221pga.54.2019.05.03.15.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:02:49 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 04/30] mfd: cros_ec: add ec_align macros
Date:   Fri,  3 May 2019 15:02:07 -0700
Message-Id: <20190503220233.64546-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To reduce code and improve performance of the embedded controller
firmware, pragma __aligned(2) or __aligned(4) are used when alignment to
16 or 32 bit boundary is expected.

Define all ec_align to packed when compiling kernel.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 438 +++++++++++++++------------
 1 file changed, 236 insertions(+), 202 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 43fe1697b18b..e0f6e9d9f587 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -188,12 +188,46 @@
 #ifndef __ACPI__
 
 /*
- * Define __packed if someone hasn't beat us to it.  Linux kernel style
- * checking prefers __packed over __attribute__((packed)).
+ * Attributes for EC request and response packets.  Just defining __packed
+ * results in inefficient assembly code on ARM, if the structure is actually
+ * 32-bit aligned, as it should be for all buffers.
+ *
+ * Be very careful when adding these to existing structures.  They will round
+ * up the structure size to the specified boundary.
+ *
+ * Also be very careful to make that if a structure is included in some other
+ * parent structure that the alignment will still be true given the packing of
+ * the parent structure.  This is particularly important if the sub-structure
+ * will be passed as a pointer to another function, since that function will
+ * not know about the misaligment caused by the parent structure's packing.
+ *
+ * Also be very careful using __packed - particularly when nesting non-packed
+ * structures inside packed ones.  In fact, DO NOT use __packed directly;
+ * always use one of these attributes.
+ *
+ * Once everything is annotated properly, the following search strings should
+ * not return ANY matches in this file other than right here:
+ *
+ * "__packed" - generates inefficient code; all sub-structs must also be packed
+ *
+ * "struct [^_]" - all structs should be annotated, except for structs that are
+ * members of other structs/unions (and their original declarations should be
+ * annotated).
  */
-#ifndef __packed
-#define __packed __attribute__((packed))
-#endif
+
+/*
+ * Packed structures make no assumption about alignment, so they do inefficient
+ * byte-wise reads.
+ */
+#define __ec_align1 __packed
+#define __ec_align2 __packed
+#define __ec_align4 __packed
+#define __ec_align_size1 __packed
+#define __ec_align_offset1 __packed
+#define __ec_align_offset2 __packed
+#define __ec_todo_packed __packed
+#define __ec_todo_unpacked
+
 
 /* LPC command status byte masks */
 /* EC has written a byte in the data register and host hasn't read it yet */
@@ -317,7 +351,7 @@ struct ec_lpc_host_args {
 	uint8_t command_version;
 	uint8_t data_size;
 	uint8_t checksum;
-} __packed;
+} __ec_align4;
 
 /* Flags for ec_lpc_host_args.flags */
 /*
@@ -488,7 +522,7 @@ struct ec_host_request {
 	uint8_t command_version;
 	uint8_t reserved;
 	uint16_t data_len;
-} __packed;
+} __ec_align4;
 
 #define EC_HOST_RESPONSE_VERSION 3
 
@@ -507,7 +541,7 @@ struct ec_host_response {
 	uint16_t result;
 	uint16_t data_len;
 	uint16_t reserved;
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 /*
@@ -536,7 +570,7 @@ struct ec_host_response {
  */
 struct ec_response_proto_version {
 	uint32_t version;
-} __packed;
+} __ec_align4;
 
 /*
  * Hello.  This is a simple command to test the EC is responsive to
@@ -550,7 +584,7 @@ struct ec_response_proto_version {
  */
 struct ec_params_hello {
 	uint32_t in_data;
-} __packed;
+} __ec_align4;
 
 /**
  * struct ec_response_hello - Response to the hello command.
@@ -558,7 +592,7 @@ struct ec_params_hello {
  */
 struct ec_response_hello {
 	uint32_t out_data;
-} __packed;
+} __ec_align4;
 
 /* Get version number */
 #define EC_CMD_GET_VERSION 0x02
@@ -581,7 +615,7 @@ struct ec_response_get_version {
 	char version_string_rw[32];
 	char reserved[32];
 	uint32_t current_image;
-} __packed;
+} __ec_align4;
 
 /* Read test */
 #define EC_CMD_READ_TEST 0x03
@@ -594,7 +628,7 @@ struct ec_response_get_version {
 struct ec_params_read_test {
 	uint32_t offset;
 	uint32_t size;
-} __packed;
+} __ec_align4;
 
 /**
  * struct ec_response_read_test - Response to the read test command.
@@ -602,7 +636,7 @@ struct ec_params_read_test {
  */
 struct ec_response_read_test {
 	uint32_t data[32];
-} __packed;
+} __ec_align4;
 
 /*
  * Get build information
@@ -624,7 +658,7 @@ struct ec_response_get_chip_info {
 	char vendor[32];
 	char name[32];
 	char revision[32];
-} __packed;
+} __ec_align4;
 
 /* Get board HW version */
 #define EC_CMD_GET_BOARD_VERSION 0x06
@@ -635,7 +669,7 @@ struct ec_response_get_chip_info {
  */
 struct ec_response_board_version {
 	uint16_t board_version;
-} __packed;
+} __ec_align2;
 
 /*
  * Read memory-mapped data.
@@ -655,7 +689,7 @@ struct ec_response_board_version {
 struct ec_params_read_memmap {
 	uint8_t offset;
 	uint8_t size;
-} __packed;
+} __ec_align1;
 
 /* Read versions supported for a command */
 #define EC_CMD_GET_CMD_VERSIONS 0x08
@@ -666,7 +700,7 @@ struct ec_params_read_memmap {
  */
 struct ec_params_get_cmd_versions {
 	uint8_t cmd;
-} __packed;
+} __ec_align1;
 
 /**
  * struct ec_params_get_cmd_versions_v1 - Parameters for the get command
@@ -675,7 +709,7 @@ struct ec_params_get_cmd_versions {
  */
 struct ec_params_get_cmd_versions_v1 {
 	uint16_t cmd;
-} __packed;
+} __ec_align2;
 
 /**
  * struct ec_response_get_cmd_version - Response to the get command versions.
@@ -684,7 +718,7 @@ struct ec_params_get_cmd_versions_v1 {
  */
 struct ec_response_get_cmd_versions {
 	uint32_t version_mask;
-} __packed;
+} __ec_align4;
 
 /*
  * Check EC communications status (busy). This is needed on i2c/spi but not
@@ -707,7 +741,7 @@ enum ec_comms_status {
  */
 struct ec_response_get_comms_status {
 	uint32_t flags;		/* Mask of enum ec_comms_status */
-} __packed;
+} __ec_align4;
 
 /* Fake a variety of responses, purely for testing purposes. */
 #define EC_CMD_TEST_PROTOCOL		0x0a
@@ -717,12 +751,12 @@ struct ec_params_test_protocol {
 	uint32_t ec_result;
 	uint32_t ret_len;
 	uint8_t buf[32];
-} __packed;
+} __ec_align4;
 
 /* Here it comes... */
 struct ec_response_test_protocol {
 	uint8_t buf[32];
-} __packed;
+} __ec_align4;
 
 /* Get protocol information */
 #define EC_CMD_GET_PROTOCOL_INFO	0x0b
@@ -745,7 +779,7 @@ struct ec_response_get_protocol_info {
 	uint16_t max_request_packet_size;
 	uint16_t max_response_packet_size;
 	uint32_t flags;
-} __packed;
+} __ec_align4;
 
 
 /*****************************************************************************/
@@ -763,12 +797,12 @@ struct ec_response_get_protocol_info {
 struct ec_params_get_set_value {
 	uint32_t flags;
 	uint32_t value;
-} __packed;
+} __ec_align4;
 
 struct ec_response_get_set_value {
 	uint32_t flags;
 	uint32_t value;
-} __packed;
+} __ec_align4;
 
 /* More than one command can use these structs to get/set parameters. */
 #define EC_CMD_GSV_PAUSE_IN_S5	0x0c
@@ -863,7 +897,7 @@ enum ec_feature_code {
 
 struct ec_response_get_features {
 	uint32_t flags[2];
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 /* Flash commands */
@@ -888,7 +922,7 @@ struct ec_response_flash_info {
 	uint32_t write_block_size;
 	uint32_t erase_block_size;
 	uint32_t protect_block_size;
-} __packed;
+} __ec_align4;
 
 /*
  * Flags for version 1+ flash info command
@@ -929,7 +963,7 @@ struct ec_response_flash_info_1 {
 	/* Version 1 adds these fields: */
 	uint32_t write_ideal_size;
 	uint32_t flags;
-} __packed;
+} __ec_align4;
 
 /*
  * Read flash
@@ -946,7 +980,7 @@ struct ec_response_flash_info_1 {
 struct ec_params_flash_read {
 	uint32_t offset;
 	uint32_t size;
-} __packed;
+} __ec_align4;
 
 /* Write flash */
 #define EC_CMD_FLASH_WRITE 0x12
@@ -964,7 +998,7 @@ struct ec_params_flash_write {
 	uint32_t offset;
 	uint32_t size;
 	/* Followed by data to write */
-} __packed;
+} __ec_align4;
 
 /* Erase flash */
 #define EC_CMD_FLASH_ERASE 0x13
@@ -977,7 +1011,7 @@ struct ec_params_flash_write {
 struct ec_params_flash_erase {
 	uint32_t offset;
 	uint32_t size;
-} __packed;
+} __ec_align4;
 
 /*
  * Get/set flash protection.
@@ -1023,7 +1057,7 @@ struct ec_params_flash_erase {
 struct ec_params_flash_protect {
 	uint32_t mask;
 	uint32_t flags;
-} __packed;
+} __ec_align4;
 
 /**
  * struct ec_response_flash_protect - Response to the flash protect command.
@@ -1038,7 +1072,7 @@ struct ec_response_flash_protect {
 	uint32_t flags;
 	uint32_t valid_flags;
 	uint32_t writable_flags;
-} __packed;
+} __ec_align4;
 
 /*
  * Note: commands 0x14 - 0x19 version 0 were old commands to get/set flash
@@ -1070,12 +1104,12 @@ enum ec_flash_region {
  */
 struct ec_params_flash_region_info {
 	uint32_t region;
-} __packed;
+} __ec_align4;
 
 struct ec_response_flash_region_info {
 	uint32_t offset;
 	uint32_t size;
-} __packed;
+} __ec_align4;
 
 /* Read/write VbNvContext */
 #define EC_CMD_VBNV_CONTEXT 0x17
@@ -1090,11 +1124,11 @@ enum ec_vbnvcontext_op {
 struct ec_params_vbnvcontext {
 	uint32_t op;
 	uint8_t block[EC_VBNV_BLOCK_SIZE];
-} __packed;
+} __ec_align4;
 
 struct ec_response_vbnvcontext {
 	uint8_t block[EC_VBNV_BLOCK_SIZE];
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 /* PWM commands */
@@ -1104,14 +1138,14 @@ struct ec_response_vbnvcontext {
 
 struct ec_response_pwm_get_fan_rpm {
 	uint32_t rpm;
-} __packed;
+} __ec_align4;
 
 /* Set target fan RPM */
-#define EC_CMD_PWM_SET_FAN_TARGET_RPM 0x21
+#define EC_CMD_PWM_SET_FAN_TARGET_RPM 0x0021
 
 struct ec_params_pwm_set_fan_target_rpm {
 	uint32_t rpm;
-} __packed;
+} __ec_align_size1;
 
 /* Get keyboard backlight */
 #define EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT 0x22
@@ -1119,21 +1153,21 @@ struct ec_params_pwm_set_fan_target_rpm {
 struct ec_response_pwm_get_keyboard_backlight {
 	uint8_t percent;
 	uint8_t enabled;
-} __packed;
+} __ec_align1;
 
 /* Set keyboard backlight */
 #define EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT 0x23
 
 struct ec_params_pwm_set_keyboard_backlight {
 	uint8_t percent;
-} __packed;
+} __ec_align1;
 
 /* Set target fan PWM duty cycle */
 #define EC_CMD_PWM_SET_FAN_DUTY 0x24
 
 struct ec_params_pwm_set_fan_duty {
 	uint32_t percent;
-} __packed;
+} __ec_align4;
 
 #define EC_CMD_PWM_SET_DUTY 0x25
 /* 16 bit duty cycle, 0xffff = 100% */
@@ -1153,18 +1187,18 @@ struct ec_params_pwm_set_duty {
 	uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY = 100% */
 	uint8_t pwm_type;  /* ec_pwm_type */
 	uint8_t index;     /* Type-specific index, or 0 if unique */
-} __packed;
+} __ec_align4;
 
 #define EC_CMD_PWM_GET_DUTY 0x26
 
 struct ec_params_pwm_get_duty {
 	uint8_t pwm_type;  /* ec_pwm_type */
 	uint8_t index;     /* Type-specific index, or 0 if unique */
-} __packed;
+} __ec_align1;
 
 struct ec_response_pwm_get_duty {
 	uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY = 100% */
-} __packed;
+} __ec_align2;
 
 /*****************************************************************************/
 /*
@@ -1177,7 +1211,7 @@ struct ec_response_pwm_get_duty {
 
 struct rgb_s {
 	uint8_t r, g, b;
-};
+} __ec_todo_unpacked;
 
 #define LB_BATTERY_LEVELS 4
 
@@ -1217,7 +1251,7 @@ struct lightbar_params_v0 {
 
 	/* Color palette */
 	struct rgb_s color[8];			/* 0-3 are Google colors */
-} __packed;
+} __ec_todo_packed;
 
 struct lightbar_params_v1 {
 	/* Timing */
@@ -1260,14 +1294,14 @@ struct lightbar_params_v1 {
 
 	/* Color palette */
 	struct rgb_s color[8];			/* 0-3 are Google colors */
-} __packed;
+} __ec_todo_packed;
 
 /* Lightbar program */
 #define EC_LB_PROG_LEN 192
 struct lightbar_program {
 	uint8_t size;
 	uint8_t data[EC_LB_PROG_LEN];
-};
+} __ec_todo_unpacked;
 
 struct ec_params_lightbar {
 	uint8_t cmd;		      /* Command (see enum lightbar_command) */
@@ -1277,23 +1311,23 @@ struct ec_params_lightbar {
 		} dump, off, on, init, get_seq, get_params_v0, get_params_v1,
 			version, get_brightness, get_demo, suspend, resume;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t num;
 		} set_brightness, seq, demo;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t ctrl, reg, value;
 		} reg;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t led, red, green, blue;
 		} set_rgb;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t led;
 		} get_rgb;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t enable;
 		} manual_suspend_ctrl;
 
@@ -1301,31 +1335,31 @@ struct ec_params_lightbar {
 		struct lightbar_params_v1 set_params_v1;
 		struct lightbar_program set_program;
 	};
-} __packed;
+} __ec_todo_packed;
 
 struct ec_response_lightbar {
 	union {
-		struct {
-			struct {
+		struct __ec_todo_unpacked {
+			struct __ec_todo_unpacked {
 				uint8_t reg;
 				uint8_t ic0;
 				uint8_t ic1;
 			} vals[23];
 		} dump;
 
-		struct  {
+		struct __ec_todo_unpacked {
 			uint8_t num;
 		} get_seq, get_brightness, get_demo;
 
 		struct lightbar_params_v0 get_params_v0;
 		struct lightbar_params_v1 get_params_v1;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint32_t num;
 			uint32_t flags;
 		} version;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t red, green, blue;
 		} get_rgb;
 
@@ -1335,7 +1369,7 @@ struct ec_response_lightbar {
 			demo, set_params_v0, set_params_v1,
 			set_program, manual_suspend_ctrl, suspend, resume;
 	};
-} __packed;
+} __ec_todo_packed;
 
 /* Lightbar commands */
 enum lightbar_command {
@@ -1402,7 +1436,7 @@ struct ec_params_led_control {
 	uint8_t flags;      /* Control flags */
 
 	uint8_t brightness[EC_LED_COLOR_COUNT];
-} __packed;
+} __ec_align1;
 
 struct ec_response_led_control {
 	/*
@@ -1413,7 +1447,7 @@ struct ec_response_led_control {
 	 * Other values means the LED is control by PWM.
 	 */
 	uint8_t brightness_range[EC_LED_COLOR_COUNT];
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* Verified boot commands */
@@ -1434,7 +1468,7 @@ struct ec_params_vboot_hash {
 	uint32_t offset;         /* Offset in flash to hash */
 	uint32_t size;           /* Number of bytes to hash */
 	uint8_t nonce_data[64];  /* Nonce data; ignored if nonce_size=0 */
-} __packed;
+} __ec_align4;
 
 struct ec_response_vboot_hash {
 	uint8_t status;          /* enum ec_vboot_hash_status */
@@ -1444,7 +1478,7 @@ struct ec_response_vboot_hash {
 	uint32_t offset;         /* Offset in flash which was hashed */
 	uint32_t size;           /* Number of bytes hashed */
 	uint8_t hash_digest[64]; /* Hash digest data */
-} __packed;
+} __ec_align4;
 
 enum ec_vboot_hash_cmd {
 	EC_VBOOT_HASH_GET = 0,       /* Get current hash status */
@@ -1604,23 +1638,23 @@ struct ec_response_motion_sensor_data {
 	/* Each sensor is up to 3-axis. */
 	union {
 		int16_t             data[3];
-		struct {
+		struct __ec_todo_packed {
 			uint16_t    reserved;
 			uint32_t    timestamp;
-		} __packed;
-		struct {
+		};
+		struct __ec_todo_unpacked {
 			uint8_t     activity; /* motionsensor_activity */
 			uint8_t     state;
 			int16_t     add_info[2];
 		};
 	};
-} __packed;
+} __ec_todo_packed;
 
 struct ec_params_motion_sense {
 	uint8_t cmd;
 	union {
 		/* Used for MOTIONSENSE_CMD_DUMP. */
-		struct {
+		struct __ec_todo_unpacked {
 			/* no args */
 		} dump;
 
@@ -1628,13 +1662,13 @@ struct ec_params_motion_sense {
 		 * Used for MOTIONSENSE_CMD_EC_RATE and
 		 * MOTIONSENSE_CMD_KB_WAKE_ANGLE.
 		 */
-		struct {
+		struct __ec_todo_unpacked {
 			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read. */
 			int16_t data;
 		} ec_rate, kb_wake_angle;
 
 		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
-		struct {
+		struct __ec_todo_packed {
 			uint8_t sensor_num;
 
 			/*
@@ -1660,10 +1694,10 @@ struct ec_params_motion_sense {
 			 * Compass:       1/16 uT
 			 */
 			int16_t offset[3];
-		} __packed sensor_offset;
+		} sensor_offset;
 
 		/* Used for MOTIONSENSE_CMD_INFO. */
-		struct {
+		struct __ec_todo_packed {
 			uint8_t sensor_num;
 		} info;
 
@@ -1684,12 +1718,12 @@ struct ec_params_motion_sense {
 			int32_t data;
 		} sensor_odr, sensor_range;
 	};
-} __packed;
+} __ec_todo_packed;
 
 struct ec_response_motion_sense {
 	union {
 		/* Used for MOTIONSENSE_CMD_DUMP. */
-		struct {
+		struct __ec_todo_unpacked {
 			/* Flags representing the motion sensor module. */
 			uint8_t module_flags;
 
@@ -1704,7 +1738,7 @@ struct ec_response_motion_sense {
 		} dump;
 
 		/* Used for MOTIONSENSE_CMD_INFO. */
-		struct {
+		struct __ec_todo_unpacked {
 			/* Should be element of enum motionsensor_type. */
 			uint8_t type;
 
@@ -1723,18 +1757,18 @@ struct ec_response_motion_sense {
 		 * MOTIONSENSE_CMD_SENSOR_RANGE, and
 		 * MOTIONSENSE_CMD_KB_WAKE_ANGLE.
 		 */
-		struct {
+		struct __ec_todo_unpacked {
 			/* Current value of the parameter queried. */
 			int32_t ret;
 		} ec_rate, sensor_odr, sensor_range, kb_wake_angle;
 
 		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
-		struct {
+		struct __ec_todo_unpacked  {
 			int16_t temp;
 			int16_t offset[3];
 		} sensor_offset, perform_calib;
 	};
-} __packed;
+} __ec_todo_packed;
 
 /*****************************************************************************/
 /* USB charging control commands */
@@ -1745,7 +1779,7 @@ struct ec_response_motion_sense {
 struct ec_params_usb_charge_set_mode {
 	uint8_t usb_port_id;
 	uint8_t mode;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* Persistent storage for host */
@@ -1761,7 +1795,7 @@ struct ec_response_pstore_info {
 	uint32_t pstore_size;
 	/* Access size; read/write offset and size must be a multiple of this */
 	uint32_t access_size;
-} __packed;
+} __ec_align4;
 
 /*
  * Read persistent storage
@@ -1773,7 +1807,7 @@ struct ec_response_pstore_info {
 struct ec_params_pstore_read {
 	uint32_t offset;   /* Byte offset to read */
 	uint32_t size;     /* Size to read in bytes */
-} __packed;
+} __ec_align4;
 
 /* Write persistent storage */
 #define EC_CMD_PSTORE_WRITE 0x42
@@ -1782,7 +1816,7 @@ struct ec_params_pstore_write {
 	uint32_t offset;   /* Byte offset to write */
 	uint32_t size;     /* Size to write in bytes */
 	uint8_t data[EC_PSTORE_SIZE_MAX];
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 /* Real-time clock */
@@ -1790,11 +1824,11 @@ struct ec_params_pstore_write {
 /* RTC params and response structures */
 struct ec_params_rtc {
 	uint32_t time;
-} __packed;
+} __ec_align4;
 
 struct ec_response_rtc {
 	uint32_t time;
-} __packed;
+} __ec_align4;
 
 /* These use ec_response_rtc */
 #define EC_CMD_RTC_GET_VALUE 0x44
@@ -1825,29 +1859,29 @@ enum ec_port80_subcmd {
 struct ec_params_port80_read {
 	uint16_t subcmd;
 	union {
-		struct {
+		struct __ec_todo_unpacked {
 			uint32_t offset;
 			uint32_t num_entries;
 		} read_buffer;
 	};
-} __packed;
+} __ec_todo_packed;
 
 struct ec_response_port80_read {
 	union {
-		struct {
+		struct __ec_todo_unpacked {
 			uint32_t writes;
 			uint32_t history_size;
 			uint32_t last_boot;
 		} get_info;
-		struct {
+		struct __ec_todo_unpacked {
 			uint16_t codes[EC_PORT80_SIZE_MAX];
 		} data;
 	};
-} __packed;
+} __ec_todo_packed;
 
 struct ec_response_port80_last_boot {
 	uint16_t code;
-} __packed;
+} __ec_align2;
 
 /*****************************************************************************/
 /* Thermal engine commands. Note that there are two implementations. We'll
@@ -1868,17 +1902,17 @@ struct ec_params_thermal_set_threshold {
 	uint8_t sensor_type;
 	uint8_t threshold_id;
 	uint16_t value;
-} __packed;
+} __ec_align2;
 
 /* Version 0 - get */
 struct ec_params_thermal_get_threshold {
 	uint8_t sensor_type;
 	uint8_t threshold_id;
-} __packed;
+} __ec_align1;
 
 struct ec_response_thermal_get_threshold {
 	uint16_t value;
-} __packed;
+} __ec_align2;
 
 
 /* The version 1 structs are visible. */
@@ -1898,12 +1932,12 @@ struct ec_thermal_config {
 	uint32_t temp_host[EC_TEMP_THRESH_COUNT]; /* levels of hotness */
 	uint32_t temp_fan_off;		/* no active cooling needed */
 	uint32_t temp_fan_max;		/* max active cooling needed */
-} __packed;
+} __ec_align4;
 
 /* Version 1 - get config for one sensor. */
 struct ec_params_thermal_get_threshold_v1 {
 	uint32_t sensor_num;
-} __packed;
+} __ec_align4;
 /* This returns a struct ec_thermal_config */
 
 /*
@@ -1913,7 +1947,7 @@ struct ec_params_thermal_get_threshold_v1 {
 struct ec_params_thermal_set_threshold_v1 {
 	uint32_t sensor_num;
 	struct ec_thermal_config cfg;
-} __packed;
+} __ec_align4;
 /* This returns no data */
 
 /****************************************************************************/
@@ -1926,14 +1960,14 @@ struct ec_params_thermal_set_threshold_v1 {
 
 struct ec_params_tmp006_get_calibration {
 	uint8_t index;
-} __packed;
+} __ec_align1;
 
 struct ec_response_tmp006_get_calibration {
 	float s0;
 	float b0;
 	float b1;
 	float b2;
-} __packed;
+} __ec_align4;
 
 /* Set TMP006 calibration data */
 #define EC_CMD_TMP006_SET_CALIBRATION 0x54
@@ -1945,19 +1979,19 @@ struct ec_params_tmp006_set_calibration {
 	float b0;
 	float b1;
 	float b2;
-} __packed;
+} __ec_align4;
 
 /* Read raw TMP006 data */
 #define EC_CMD_TMP006_GET_RAW 0x55
 
 struct ec_params_tmp006_get_raw {
 	uint8_t index;
-} __packed;
+} __ec_align1;
 
 struct ec_response_tmp006_get_raw {
 	int32_t t;  /* In 1/100 K */
 	int32_t v;  /* In nV */
-};
+} __ec_align4;
 
 /*****************************************************************************/
 /* MKBP - Matrix KeyBoard Protocol */
@@ -1984,12 +2018,12 @@ struct ec_response_mkbp_info {
 	uint32_t cols;
 	/* Formerly "switches", which was 0. */
 	uint8_t reserved;
-} __packed;
+} __ec_align_size1;
 
 struct ec_params_mkbp_info {
 	uint8_t info_type;
 	uint8_t event_type;
-} __packed;
+} __ec_align1;
 
 enum ec_mkbp_info_type {
 	/*
@@ -2037,7 +2071,7 @@ struct ec_params_mkbp_simulate_key {
 	uint8_t col;
 	uint8_t row;
 	uint8_t pressed;
-} __packed;
+} __ec_align1;
 
 /* Configure keyboard scanning */
 #define EC_CMD_MKBP_SET_CONFIG 0x64
@@ -2083,15 +2117,15 @@ struct ec_mkbp_config {
 	uint16_t debounce_up_us;	/* time for debounce on key up */
 	/* maximum depth to allow for fifo (0 = no keyscan output) */
 	uint8_t fifo_max_depth;
-} __packed;
+} __ec_align_size1;
 
 struct ec_params_mkbp_set_config {
 	struct ec_mkbp_config config;
-} __packed;
+} __ec_align_size1;
 
 struct ec_response_mkbp_get_config {
 	struct ec_mkbp_config config;
-} __packed;
+} __ec_align_size1;
 
 /* Run the key scan emulation */
 #define EC_CMD_KEYSCAN_SEQ_CTRL 0x66
@@ -2114,18 +2148,18 @@ enum ec_collect_flags {
 
 struct ec_collect_item {
 	uint8_t flags;		/* some flags (enum ec_collect_flags) */
-};
+} __ec_align1;
 
 struct ec_params_keyscan_seq_ctrl {
 	uint8_t cmd;	/* Command to send (enum ec_keyscan_seq_cmd) */
 	union {
-		struct {
+		struct __ec_align1 {
 			uint8_t active;		/* still active */
 			uint8_t num_items;	/* number of items */
 			/* Current item being presented */
 			uint8_t cur_item;
 		} status;
-		struct {
+		struct __ec_todo_unpacked {
 			/*
 			 * Absolute time for this scan, measured from the
 			 * start of the sequence.
@@ -2133,22 +2167,22 @@ struct ec_params_keyscan_seq_ctrl {
 			uint32_t time_us;
 			uint8_t scan[0];	/* keyscan data */
 		} add;
-		struct {
+		struct __ec_align1 {
 			uint8_t start_item;	/* First item to return */
 			uint8_t num_items;	/* Number of items to return */
 		} collect;
 	};
-} __packed;
+} __ec_todo_packed;
 
 struct ec_result_keyscan_seq_ctrl {
 	union {
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t num_items;	/* Number of items */
 			/* Data for each item */
 			struct ec_collect_item item[0];
 		} collect;
 	};
-} __packed;
+} __ec_todo_packed;
 
 /*
  * Command for retrieving the next pending MKBP event from the EC device
@@ -2186,8 +2220,8 @@ enum ec_mkbp_event {
 	EC_MKBP_EVENT_COUNT,
 };
 
-union ec_response_get_next_data {
-	uint8_t   key_matrix[13];
+union __ec_align_offset1 ec_response_get_next_data {
+	uint8_t key_matrix[13];
 
 	/* Unaligned */
 	uint32_t  host_event;
@@ -2195,9 +2229,9 @@ union ec_response_get_next_data {
 	uint32_t   buttons;
 	uint32_t   switches;
 	uint32_t   sysrq;
-} __packed;
+};
 
-union ec_response_get_next_data_v1 {
+union __ec_align_offset1 ec_response_get_next_data_v1 {
 	uint8_t key_matrix[16];
 	uint32_t host_event;
 	uint32_t buttons;
@@ -2205,19 +2239,19 @@ union ec_response_get_next_data_v1 {
 	uint32_t sysrq;
 	uint32_t cec_events;
 	uint8_t cec_message[16];
-} __packed;
+};
 
 struct ec_response_get_next_event {
 	uint8_t event_type;
 	/* Followed by event data if any */
 	union ec_response_get_next_data data;
-} __packed;
+} __ec_align1;
 
 struct ec_response_get_next_event_v1 {
 	uint8_t event_type;
 	/* Followed by event data if any */
 	union ec_response_get_next_data_v1 data;
-} __packed;
+} __ec_align1;
 
 /* Bit indices for buttons and switches.*/
 /* Buttons */
@@ -2238,12 +2272,12 @@ struct ec_response_get_next_event_v1 {
 
 struct ec_params_temp_sensor_get_info {
 	uint8_t id;
-} __packed;
+} __ec_align1;
 
 struct ec_response_temp_sensor_get_info {
 	char sensor_name[32];
 	uint8_t sensor_type;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 
@@ -2262,11 +2296,11 @@ struct ec_response_temp_sensor_get_info {
  */
 struct ec_params_host_event_mask {
 	uint32_t mask;
-} __packed;
+} __ec_align4;
 
 struct ec_response_host_event_mask {
 	uint32_t mask;
-} __packed;
+} __ec_align4;
 
 /* These all use ec_response_host_event_mask */
 #define EC_CMD_HOST_EVENT_GET_B         0x87
@@ -2289,7 +2323,7 @@ struct ec_response_host_event_mask {
 
 struct ec_params_switch_enable_backlight {
 	uint8_t enabled;
-} __packed;
+} __ec_align1;
 
 /* Enable/disable WLAN/Bluetooth */
 #define EC_CMD_SWITCH_ENABLE_WIRELESS 0x91
@@ -2298,7 +2332,7 @@ struct ec_params_switch_enable_backlight {
 /* Version 0 params; no response */
 struct ec_params_switch_enable_wireless_v0 {
 	uint8_t enabled;
-} __packed;
+} __ec_align1;
 
 /* Version 1 params */
 struct ec_params_switch_enable_wireless_v1 {
@@ -2317,7 +2351,7 @@ struct ec_params_switch_enable_wireless_v1 {
 
 	/* Which flags to copy from suspend_flags */
 	uint8_t suspend_mask;
-} __packed;
+} __ec_align1;
 
 /* Version 1 response */
 struct ec_response_switch_enable_wireless_v1 {
@@ -2326,7 +2360,7 @@ struct ec_response_switch_enable_wireless_v1 {
 
 	/* Flags to leave enabled in S3 */
 	uint8_t suspend_flags;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* GPIO commands. Only available on EC if write protect has been disabled. */
@@ -2337,7 +2371,7 @@ struct ec_response_switch_enable_wireless_v1 {
 struct ec_params_gpio_set {
 	char name[32];
 	uint8_t val;
-} __packed;
+} __ec_align1;
 
 /* Get GPIO value */
 #define EC_CMD_GPIO_GET 0x93
@@ -2345,37 +2379,37 @@ struct ec_params_gpio_set {
 /* Version 0 of input params and response */
 struct ec_params_gpio_get {
 	char name[32];
-} __packed;
+} __ec_align1;
 
 struct ec_response_gpio_get {
 	uint8_t val;
-} __packed;
+} __ec_align1;
 
 /* Version 1 of input params and response */
 struct ec_params_gpio_get_v1 {
 	uint8_t subcmd;
 	union {
-		struct {
+		struct __ec_align1 {
 			char name[32];
 		} get_value_by_name;
-		struct {
+		struct __ec_align1 {
 			uint8_t index;
 		} get_info;
 	};
-} __packed;
+} __ec_align1;
 
 struct ec_response_gpio_get_v1 {
 	union {
-		struct {
+		struct __ec_align1 {
 			uint8_t val;
 		} get_value_by_name, get_count;
-		struct {
+		struct __ec_todo_unpacked {
 			uint8_t val;
 			char name[32];
 			uint32_t flags;
 		} get_info;
 	};
-} __packed;
+} __ec_todo_packed;
 
 enum gpio_get_subcmd {
 	EC_GPIO_GET_BY_NAME = 0,
@@ -2401,11 +2435,11 @@ struct ec_params_i2c_read {
 	uint8_t read_size; /* Either 8 or 16. */
 	uint8_t port;
 	uint8_t offset;
-} __packed;
+} __ec_align_size1;
 
 struct ec_response_i2c_read {
 	uint16_t data;
-} __packed;
+} __ec_align2;
 
 /* Write I2C bus */
 #define EC_CMD_I2C_WRITE 0x95
@@ -2416,7 +2450,7 @@ struct ec_params_i2c_write {
 	uint8_t write_size; /* Either 8 or 16. */
 	uint8_t port;
 	uint8_t offset;
-} __packed;
+} __ec_align_size1;
 
 /*****************************************************************************/
 /* Charge state commands. Only available when flash write protect unlocked. */
@@ -2435,7 +2469,7 @@ enum ec_charge_control_mode {
 
 struct ec_params_charge_control {
 	uint32_t mode;  /* enum charge_control_mode */
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 
@@ -2463,7 +2497,7 @@ enum ec_console_read_subcmd {
 
 struct ec_params_console_read_v1 {
 	uint8_t subcmd; /* enum ec_console_read_subcmd */
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 
@@ -2481,7 +2515,7 @@ struct ec_params_console_read_v1 {
 
 struct ec_params_battery_cutoff {
 	uint8_t flags;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* USB port mux control. */
@@ -2493,7 +2527,7 @@ struct ec_params_battery_cutoff {
 
 struct ec_params_usb_mux {
 	uint8_t mux;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* LDOs / FETs control. */
@@ -2511,7 +2545,7 @@ enum ec_ldo_state {
 struct ec_params_ldo_set {
 	uint8_t index;
 	uint8_t state;
-} __packed;
+} __ec_align1;
 
 /*
  * Get LDO state.
@@ -2520,11 +2554,11 @@ struct ec_params_ldo_set {
 
 struct ec_params_ldo_get {
 	uint8_t index;
-} __packed;
+} __ec_align1;
 
 struct ec_response_ldo_get {
 	uint8_t state;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* Power info. */
@@ -2540,7 +2574,7 @@ struct ec_response_power_info {
 	uint16_t voltage_system;
 	uint16_t current_system;
 	uint16_t usb_current_limit;
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 /* I2C passthru command */
@@ -2562,20 +2596,20 @@ struct ec_response_power_info {
 struct ec_params_i2c_passthru_msg {
 	uint16_t addr_flags;	/* I2C slave address (7 or 10 bits) and flags */
 	uint16_t len;		/* Number of bytes to read or write */
-} __packed;
+} __ec_align2;
 
 struct ec_params_i2c_passthru {
 	uint8_t port;		/* I2C port number */
 	uint8_t num_msgs;	/* Number of messages */
 	struct ec_params_i2c_passthru_msg msg[];
 	/* Data to write for all messages is concatenated here */
-} __packed;
+} __ec_align2;
 
 struct ec_response_i2c_passthru {
 	uint8_t i2c_status;	/* Status flags (EC_I2C_STATUS_...) */
 	uint8_t num_msgs;	/* Number of messages processed */
 	uint8_t data[];		/* Data read by messages concatenated here */
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* Power button hang detect */
@@ -2630,7 +2664,7 @@ struct ec_params_hang_detect {
 
 	/* Timeout in msec before generating warm reboot, if enabled */
 	uint16_t warm_reboot_timeout_msec;
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 /* Commands for battery charging */
@@ -2676,20 +2710,20 @@ struct ec_params_charge_state {
 			/* no args */
 		} get_state;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint32_t param;		/* enum charge_state_param */
 		} get_param;
 
-		struct {
+		struct __ec_todo_unpacked {
 			uint32_t param;		/* param to set */
 			uint32_t value;		/* value to set */
 		} set_param;
 	};
-} __packed;
+} __ec_todo_packed;
 
 struct ec_response_charge_state {
 	union {
-		struct {
+		struct __ec_align4 {
 			int ac;
 			int chg_voltage;
 			int chg_current;
@@ -2697,14 +2731,14 @@ struct ec_response_charge_state {
 			int batt_state_of_charge;
 		} get_state;
 
-		struct {
+		struct __ec_align4 {
 			uint32_t value;
 		} get_param;
 		struct {
 			/* no return values */
 		} set_param;
 	};
-} __packed;
+} __ec_align4;
 
 
 /*
@@ -2714,7 +2748,7 @@ struct ec_response_charge_state {
 
 struct ec_params_current_limit {
 	uint32_t limit; /* in mA */
-} __packed;
+} __ec_align4;
 
 /*
  * Set maximum external voltage / current.
@@ -2725,7 +2759,7 @@ struct ec_params_current_limit {
 struct ec_params_external_power_limit_v1 {
 	uint16_t current_lim; /* in mA, or EC_POWER_LIMIT_NONE to clear limit */
 	uint16_t voltage_lim; /* in mV, or EC_POWER_LIMIT_NONE to clear limit */
-} __packed;
+} __ec_align2;
 
 #define EC_POWER_LIMIT_NONE 0xffff
 
@@ -2741,7 +2775,7 @@ enum host_sleep_event {
 
 struct ec_params_host_sleep_event {
 	uint8_t sleep_event;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* Smart battery pass-through */
@@ -2758,25 +2792,25 @@ struct ec_params_host_sleep_event {
 
 struct ec_params_sb_rd {
 	uint8_t reg;
-} __packed;
+} __ec_align1;
 
 struct ec_response_sb_rd_word {
 	uint16_t value;
-} __packed;
+} __ec_align2;
 
 struct ec_params_sb_wr_word {
 	uint8_t reg;
 	uint16_t value;
-} __packed;
+} __ec_align1;
 
 struct ec_response_sb_rd_block {
 	uint8_t data[32];
-} __packed;
+} __ec_align1;
 
 struct ec_params_sb_wr_block {
 	uint8_t reg;
 	uint16_t data[32];
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* Battery vendor parameters
@@ -2798,11 +2832,11 @@ struct ec_params_battery_vendor_param {
 	uint32_t param;
 	uint32_t value;
 	uint8_t mode;
-} __packed;
+} __ec_align_size1;
 
 struct ec_response_battery_vendor_param {
 	uint32_t value;
-} __packed;
+} __ec_align4;
 
 /*****************************************************************************/
 /* Commands for I2S recording on audio codec. */
@@ -2833,7 +2867,7 @@ enum ec_i2s_config {
 	EC_DAI_FMT_PCM_TDM = 5,
 };
 
-struct ec_param_codec_i2s {
+struct __ec_todo_packed ec_param_codec_i2s {
 	/* enum ec_codec_i2s_subcmd */
 	uint8_t cmd;
 	union {
@@ -2847,10 +2881,10 @@ struct ec_param_codec_i2s {
 		 * EC_CODEC_SET_GAIN
 		 * Value should be 0~43 for both channels.
 		 */
-		struct ec_param_codec_i2s_set_gain {
+		struct __ec_align1 ec_param_codec_i2s_set_gain {
 			uint8_t left;
 			uint8_t right;
-		} __packed gain;
+		} gain;
 
 		/*
 		 * EC_CODEC_I2S_ENABLE
@@ -2868,7 +2902,7 @@ struct ec_param_codec_i2s {
 		 * EC_CODEC_I2S_SET_TDM_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
-		struct ec_param_codec_i2s_tdm {
+		struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
 			/*
 			 * 0 to 496
 			 */
@@ -2879,14 +2913,14 @@ struct ec_param_codec_i2s {
 			int16_t ch1_delay;
 			uint8_t adjacent_to_ch0;
 			uint8_t adjacent_to_ch1;
-		} __packed tdm_param;
+		} tdm_param;
 
 		/*
 		 * EC_CODEC_I2S_SET_BCLK
 		 */
 		uint32_t bclk;
 	};
-} __packed;
+};
 
 /*
  * For subcommand EC_CODEC_GET_GAIN.
@@ -2894,7 +2928,7 @@ struct ec_param_codec_i2s {
 struct ec_response_codec_gain {
 	uint8_t left;
 	uint8_t right;
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /* System commands */
@@ -2923,7 +2957,7 @@ enum ec_reboot_cmd {
 struct ec_params_reboot_ec {
 	uint8_t cmd;           /* enum ec_reboot_cmd */
 	uint8_t flags;         /* See EC_REBOOT_FLAG_* */
-} __packed;
+} __ec_align1;
 
 /*
  * Get information on last EC panic.
@@ -3066,7 +3100,7 @@ struct ec_params_reboot_ec {
  */
 struct ec_params_cec_write {
 	uint8_t msg[EC_MAX_CEC_MSG_LEN];
-} __packed;
+} __ec_align1;
 
 /* Set various CEC parameters */
 #define EC_CMD_CEC_SET 0x00BA
@@ -3082,7 +3116,7 @@ struct ec_params_cec_write {
 struct ec_params_cec_set {
 	uint8_t cmd; /* enum cec_command */
 	uint8_t val;
-} __packed;
+} __ec_align1;
 
 /* Read various CEC parameters */
 #define EC_CMD_CEC_GET 0x00BB
@@ -3093,7 +3127,7 @@ struct ec_params_cec_set {
  */
 struct ec_params_cec_get {
 	uint8_t cmd; /* enum cec_command */
-} __packed;
+} __ec_align1;
 
 /**
  * struct ec_response_cec_get - CEC parameters get response
@@ -3104,7 +3138,7 @@ struct ec_params_cec_get {
  */
 struct ec_response_cec_get {
 	uint8_t val;
-} __packed;
+} __ec_align1;
 
 /* CEC parameters command */
 enum ec_cec_command {
@@ -3177,13 +3211,13 @@ enum mkbp_cec_event {
 /* Status of EC being sent to PD */
 struct ec_params_pd_status {
 	int8_t batt_soc; /* battery state of charge */
-} __packed;
+} __ec_align1;
 
 /* Status of PD being sent back to EC */
 struct ec_response_pd_status {
 	int8_t status;        /* PD MCU status */
 	uint32_t curr_lim_ma; /* input current limit */
-} __packed;
+} __ec_align_size1;
 
 /* Set USB type-C port role and muxes */
 #define EC_CMD_USB_PD_CONTROL 0x101
@@ -3218,7 +3252,7 @@ struct ec_params_usb_pd_control {
 	uint8_t role;
 	uint8_t mux;
 	uint8_t swap;
-} __packed;
+} __ec_align1;
 
 #define PD_CTRL_RESP_ENABLED_COMMS      (1 << 0) /* Communication enabled */
 #define PD_CTRL_RESP_ENABLED_CONNECTED  (1 << 1) /* Device connected */
@@ -3237,7 +3271,7 @@ struct ec_response_usb_pd_control_v1 {
 	uint8_t role;
 	uint8_t polarity;
 	char state[32];
-} __packed;
+} __ec_align1;
 
 #define EC_CMD_USB_PD_PORTS 0x102
 
@@ -3246,14 +3280,14 @@ struct ec_response_usb_pd_control_v1 {
 
 struct ec_response_usb_pd_ports {
 	uint8_t num_ports;
-} __packed;
+} __ec_align1;
 
 #define EC_CMD_USB_PD_POWER_INFO 0x103
 
 #define PD_POWER_CHARGING_PORT 0xff
 struct ec_params_usb_pd_power_info {
 	uint8_t port;
-} __packed;
+} __ec_align1;
 
 enum usb_chg_type {
 	USB_CHG_TYPE_NONE,
@@ -3279,7 +3313,7 @@ struct usb_chg_measures {
 	uint16_t voltage_now;
 	uint16_t current_max;
 	uint16_t current_lim;
-} __packed;
+} __ec_align2;
 
 struct ec_response_usb_pd_power_info {
 	uint8_t role;
@@ -3288,11 +3322,11 @@ struct ec_response_usb_pd_power_info {
 	uint8_t reserved1;
 	struct usb_chg_measures meas;
 	uint32_t max_power;
-} __packed;
+} __ec_align4;
 
 struct ec_params_usb_pd_info_request {
 	uint8_t port;
-} __packed;
+} __ec_align1;
 
 /*
  * This command will return the number of USB PD charge port + the number
@@ -3302,7 +3336,7 @@ struct ec_params_usb_pd_info_request {
 #define EC_CMD_CHARGE_PORT_COUNT 0x0105
 struct ec_response_charge_port_count {
 	uint8_t port_count;
-} __packed;
+} __ec_align1;
 
 /* Read USB-PD Device discovery info */
 #define EC_CMD_USB_PD_DISCOVERY 0x0113
@@ -3310,7 +3344,7 @@ struct ec_params_usb_pd_discovery_entry {
 	uint16_t vid;  /* USB-IF VID */
 	uint16_t pid;  /* USB-IF PID */
 	uint8_t ptype; /* product type (hub,periph,cable,ama) */
-} __packed;
+} __ec_align_size1;
 
 /* Override default charge behavior */
 #define EC_CMD_PD_CHARGE_PORT_OVERRIDE 0x0114
@@ -3324,7 +3358,7 @@ enum usb_pd_override_ports {
 
 struct ec_params_charge_port_override {
 	int16_t override_port; /* Override port# */
-} __packed;
+} __ec_align2;
 
 /* Read (and delete) one entry of PD event log */
 #define EC_CMD_PD_GET_LOG_ENTRY 0x0115
@@ -3335,7 +3369,7 @@ struct ec_response_pd_log {
 	uint8_t size_port;  /* [7:5] port number [4:0] payload size in bytes */
 	uint16_t data;      /* type-defined data payload */
 	uint8_t payload[0]; /* optional additional data payload: 0..16 bytes */
-} __packed;
+} __ec_align4;
 
 /* The timestamp is the microsecond counter shifted to get about a ms. */
 #define PD_LOG_TIMESTAMP_SHIFT 10 /* 1 LSB = 1024us */
@@ -3401,14 +3435,14 @@ struct mcdp_version {
 	uint8_t major;
 	uint8_t minor;
 	uint16_t build;
-} __packed;
+} __ec_align4;
 
 struct mcdp_info {
 	uint8_t family[2];
 	uint8_t chipid[2];
 	struct mcdp_version irom;
 	struct mcdp_version fw;
-} __packed;
+} __ec_align4;
 
 /* struct mcdp_info field decoding */
 #define MCDP_CHIPID(chipid) ((chipid[0] << 8) | chipid[1])
@@ -3419,7 +3453,7 @@ struct mcdp_info {
 
 struct ec_params_usb_pd_mux_info {
 	uint8_t port; /* USB-C port number */
-} __packed;
+} __ec_align1;
 
 /* Flags representing mux state */
 #define USB_PD_MUX_USB_ENABLED       (1 << 0)
@@ -3429,7 +3463,7 @@ struct ec_params_usb_pd_mux_info {
 
 struct ec_response_usb_pd_mux_info {
 	uint8_t flags; /* USB_PD_MUX_*-encoded USB mux state */
-} __packed;
+} __ec_align1;
 
 /*****************************************************************************/
 /*
-- 
2.21.0.1020.gf2820cf01a-goog

