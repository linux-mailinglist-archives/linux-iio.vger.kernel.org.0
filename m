Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1033821
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfFCSgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:36:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39009 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFCSeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so11099782pfe.6
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvZiZSSFkASZ5axf4GdcvO3VA5BWdLsCt0PgYjP2wg8=;
        b=GaEfwoE3r3zfeWQ4KDC6T9NUpxSoP6jdGq8hH/BjsINnpD03nl2cgu0I8T2F9a9F6c
         mQW61XXsEsbci5U+4KZHQWSkrFsuH3VY5j5n89f7DdHLRY6mo3AHH2lHzAim0rTq4/i/
         Ckpp8IYQQYNL+V6jmNmc/Ld4MfHznd6Jhvhz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvZiZSSFkASZ5axf4GdcvO3VA5BWdLsCt0PgYjP2wg8=;
        b=bRdLUCDQ0pJPe2WlQnmmtIFjc5km+BR3Hmtf/uToBKs+NjPGOqjKIQMmy7680nRIck
         IXeU75lFWI/u5Cd147DJitgJmpFRLEki1y6rhiAJqqRtBeCwFyI4lFgJ/U2U3hAVI7jd
         VimAzrppbMMdKo+tAeSv498Ii5QwlMTMPr+EXsc9bTWXQj3GzEVBY5WzuHQ7Kp1L10RY
         4lpAuVMqJak+QUiEa1tD0WZraIW/i7/qPbugE3HkHN/P/UAQqgkm8+O6zZQZVpcW76RK
         T5edd9Z40zYMbwoLq1ja5O2pvS1veUK9/VsqzUsP5Zxy+gas9jffhnHiv/qaR+gFIAMw
         Rlkg==
X-Gm-Message-State: APjAAAWOJCCwnyYXVSYeXQD966OY7vT/6rCo+uGBqONyDBXaxbv9Abuh
        TSnLnaBrE7x9M+0YOK7dszHFAA==
X-Google-Smtp-Source: APXvYqxhGSi8FalDs2H+ynSi6npuip07SQ4klfbB8Og2QjsS3T0o8XHpuUCWAcI6eabjmwACtAnkZw==
X-Received: by 2002:aa7:93ba:: with SMTP id x26mr32460996pff.238.1559586864995;
        Mon, 03 Jun 2019 11:34:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id x128sm17682344pfd.186.2019.06.03.11.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:24 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 12/30] mfd: cros_ec: Add lightbar v2 API
Date:   Mon,  3 Jun 2019 11:33:43 -0700
Message-Id: <20190603183401.151408-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New API split commands, improve EC command latency.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 124 ++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 2b3a94a4f0f4..0ff1941288cf 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1658,7 +1658,10 @@ struct lightbar_params_v1 {
 	int32_t s3_sleep_for;
 	int32_t s3_ramp_up;
 	int32_t s3_ramp_down;
+	int32_t s5_ramp_up;
+	int32_t s5_ramp_down;
 	int32_t tap_tick_delay;
+	int32_t tap_gate_delay;
 	int32_t tap_display_time;
 
 	/* Tap-for-battery params */
@@ -1686,11 +1689,82 @@ struct lightbar_params_v1 {
 	uint8_t s0_idx[2][LB_BATTERY_LEVELS];	/* AP is running */
 	uint8_t s3_idx[2][LB_BATTERY_LEVELS];	/* AP is sleeping */
 
+	/* s5: single color pulse on inhibited power-up */
+	uint8_t s5_idx;
+
 	/* Color palette */
 	struct rgb_s color[8];			/* 0-3 are Google colors */
 } __ec_todo_packed;
 
-/* Lightbar program */
+/* Lightbar command params v2
+ * crbug.com/467716
+ *
+ * lightbar_parms_v1 was too big for i2c, therefore in v2, we split them up by
+ * logical groups to make it more manageable ( < 120 bytes).
+ *
+ * NOTE: Each of these groups must be less than 120 bytes.
+ */
+
+struct lightbar_params_v2_timing {
+	/* Timing */
+	int32_t google_ramp_up;
+	int32_t google_ramp_down;
+	int32_t s3s0_ramp_up;
+	int32_t s0_tick_delay[2];		/* AC=0/1 */
+	int32_t s0a_tick_delay[2];		/* AC=0/1 */
+	int32_t s0s3_ramp_down;
+	int32_t s3_sleep_for;
+	int32_t s3_ramp_up;
+	int32_t s3_ramp_down;
+	int32_t s5_ramp_up;
+	int32_t s5_ramp_down;
+	int32_t tap_tick_delay;
+	int32_t tap_gate_delay;
+	int32_t tap_display_time;
+} __ec_todo_packed;
+
+struct lightbar_params_v2_tap {
+	/* Tap-for-battery params */
+	uint8_t tap_pct_red;
+	uint8_t tap_pct_green;
+	uint8_t tap_seg_min_on;
+	uint8_t tap_seg_max_on;
+	uint8_t tap_seg_osc;
+	uint8_t tap_idx[3];
+} __ec_todo_packed;
+
+struct lightbar_params_v2_oscillation {
+	/* Oscillation */
+	uint8_t osc_min[2];			/* AC=0/1 */
+	uint8_t osc_max[2];			/* AC=0/1 */
+	uint8_t w_ofs[2];			/* AC=0/1 */
+} __ec_todo_packed;
+
+struct lightbar_params_v2_brightness {
+	/* Brightness limits based on the backlight and AC. */
+	uint8_t bright_bl_off_fixed[2];		/* AC=0/1 */
+	uint8_t bright_bl_on_min[2];		/* AC=0/1 */
+	uint8_t bright_bl_on_max[2];		/* AC=0/1 */
+} __ec_todo_packed;
+
+struct lightbar_params_v2_thresholds {
+	/* Battery level thresholds */
+	uint8_t battery_threshold[LB_BATTERY_LEVELS - 1];
+} __ec_todo_packed;
+
+struct lightbar_params_v2_colors {
+	/* Map [AC][battery_level] to color index */
+	uint8_t s0_idx[2][LB_BATTERY_LEVELS];	/* AP is running */
+	uint8_t s3_idx[2][LB_BATTERY_LEVELS];	/* AP is sleeping */
+
+	/* s5: single color pulse on inhibited power-up */
+	uint8_t s5_idx;
+
+	/* Color palette */
+	struct rgb_s color[8];			/* 0-3 are Google colors */
+} __ec_todo_packed;
+
+/* Lightbar program. */
 #define EC_LB_PROG_LEN 192
 struct lightbar_program {
 	uint8_t size;
@@ -1704,7 +1778,10 @@ struct ec_params_lightbar {
 		 * The following commands have no args:
 		 *
 		 * dump, off, on, init, get_seq, get_params_v0, get_params_v1,
-		 * version, get_brightness, get_demo, suspend, resume
+		 * version, get_brightness, get_demo, suspend, resume,
+		 * get_params_v2_timing, get_params_v2_tap, get_params_v2_osc,
+		 * get_params_v2_bright, get_params_v2_thlds,
+		 * get_params_v2_colors
 		 *
 		 * Don't use an empty struct, because C++ hates that.
 		 */
@@ -1731,6 +1808,14 @@ struct ec_params_lightbar {
 
 		struct lightbar_params_v0 set_params_v0;
 		struct lightbar_params_v1 set_params_v1;
+
+		struct lightbar_params_v2_timing set_v2par_timing;
+		struct lightbar_params_v2_tap set_v2par_tap;
+		struct lightbar_params_v2_oscillation set_v2par_osc;
+		struct lightbar_params_v2_brightness set_v2par_bright;
+		struct lightbar_params_v2_thresholds set_v2par_thlds;
+		struct lightbar_params_v2_colors set_v2par_colors;
+
 		struct lightbar_program set_program;
 	};
 } __ec_todo_packed;
@@ -1752,6 +1837,14 @@ struct ec_response_lightbar {
 		struct lightbar_params_v0 get_params_v0;
 		struct lightbar_params_v1 get_params_v1;
 
+
+		struct lightbar_params_v2_timing get_params_v2_timing;
+		struct lightbar_params_v2_tap get_params_v2_tap;
+		struct lightbar_params_v2_oscillation get_params_v2_osc;
+		struct lightbar_params_v2_brightness get_params_v2_bright;
+		struct lightbar_params_v2_thresholds get_params_v2_thlds;
+		struct lightbar_params_v2_colors get_params_v2_colors;
+
 		struct __ec_todo_unpacked {
 			uint32_t num;
 			uint32_t flags;
@@ -1764,9 +1857,11 @@ struct ec_response_lightbar {
 		/*
 		 * The following commands have no response:
 		 *
-		 * off, on, init, set_brightness, seq, reg, set_rgb,
+		 * off, on, init, set_brightness, seq, reg, set_rgb, demo,
 		 * set_params_v0, set_params_v1, set_program,
-		 * manual_suspend_ctrl, suspend, resume
+		 * manual_suspend_ctrl, suspend, resume, set_v2par_timing,
+		 * set_v2par_tap, set_v2par_osc, set_v2par_bright,
+		 * set_v2par_thlds, set_v2par_colors
 		 */
 	};
 } __ec_todo_packed;
@@ -1795,6 +1890,18 @@ enum lightbar_command {
 	LIGHTBAR_CMD_MANUAL_SUSPEND_CTRL = 19,
 	LIGHTBAR_CMD_SUSPEND = 20,
 	LIGHTBAR_CMD_RESUME = 21,
+	LIGHTBAR_CMD_GET_PARAMS_V2_TIMING = 22,
+	LIGHTBAR_CMD_SET_PARAMS_V2_TIMING = 23,
+	LIGHTBAR_CMD_GET_PARAMS_V2_TAP = 24,
+	LIGHTBAR_CMD_SET_PARAMS_V2_TAP = 25,
+	LIGHTBAR_CMD_GET_PARAMS_V2_OSCILLATION = 26,
+	LIGHTBAR_CMD_SET_PARAMS_V2_OSCILLATION = 27,
+	LIGHTBAR_CMD_GET_PARAMS_V2_BRIGHTNESS = 28,
+	LIGHTBAR_CMD_SET_PARAMS_V2_BRIGHTNESS = 29,
+	LIGHTBAR_CMD_GET_PARAMS_V2_THRESHOLDS = 30,
+	LIGHTBAR_CMD_SET_PARAMS_V2_THRESHOLDS = 31,
+	LIGHTBAR_CMD_GET_PARAMS_V2_COLORS = 32,
+	LIGHTBAR_CMD_SET_PARAMS_V2_COLORS = 33,
 	LIGHTBAR_NUM_CMDS
 };
 
@@ -1813,6 +1920,14 @@ enum ec_led_id {
 	EC_LED_ID_POWER_LED,
 	/* LED on power adapter or its plug */
 	EC_LED_ID_ADAPTER_LED,
+	/* LED to indicate left side */
+	EC_LED_ID_LEFT_LED,
+	/* LED to indicate right side */
+	EC_LED_ID_RIGHT_LED,
+	/* LED to indicate recovery mode with HW_REINIT */
+	EC_LED_ID_RECOVERY_HW_REINIT_LED,
+	/* LED to indicate sysrq debug mode. */
+	EC_LED_ID_SYSRQ_DEBUG_LED,
 
 	EC_LED_ID_COUNT
 };
@@ -1827,6 +1942,7 @@ enum ec_led_colors {
 	EC_LED_COLOR_BLUE,
 	EC_LED_COLOR_YELLOW,
 	EC_LED_COLOR_WHITE,
+	EC_LED_COLOR_AMBER,
 
 	EC_LED_COLOR_COUNT
 };
-- 
2.21.0.1020.gf2820cf01a-goog

