Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584351351E
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfECWDE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35695 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfECWDE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so3324847plp.2
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syLGbC6LgwBEoz8/wCdHT2oo9MnmTLydtGDQC37+PpE=;
        b=VGM0uTCHMN7Lc3t5K0dqxzV1Q7drtr4cvIKkzAX8TO8AX+EfXYIue2a/yCCxSfqEvE
         p1FS/uE1Hlfx6lIeH7c6J3GTVliAsQCwCYZTi7Enccanr++Q8UPa3hNDU1vWB1Xai9hF
         WyuHUSWx6KyIfx2uONQwRMsxZiArCJFIugvyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syLGbC6LgwBEoz8/wCdHT2oo9MnmTLydtGDQC37+PpE=;
        b=r8XtbPbiy5qZRMAllqpFfmKbOdgTvW8s+E96jifI8/vBX2qmHpeRyiSvJDQD/7VLcK
         5KUbI9pZTo2czH3EcsjtFeHzyXqBRBwp4u4KapELKKwOwE/Jd37dADx10EaMpa4MM+2M
         2uHjH5mvCqu0RBpkSfY9cdAAV8m5cDzeW1ziXDx1u75dJ8ovJyAokmr+OJyeb51SiC6g
         V5Mu1cXjEwIDnsWuah5GKJzfcGJz1gpwCChy63Qa6DegX+TmGGOESOwKaMO71bJL4zst
         slGSN5PHHLd0Yy4dKMJTkitCi6ADV/uGeS1GQjkSRKlDSOtMWBldwujaWpq2DIbkqLXH
         TIEQ==
X-Gm-Message-State: APjAAAUyXl6pRDoTYBWTtFeg+EUuzNoYHwAs0MB/zClAkt9qhATGAzcT
        12wi7kCPnHzuW9il4bDRkliQGQ==
X-Google-Smtp-Source: APXvYqyqSKdgYuq4rVzeteojAToyJ2tKxqFIyRSHj93FOrhWxTjqzpGdvDx/AjkBxpU2KazdTs3cjw==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr14013894plb.4.1556920983194;
        Fri, 03 May 2019 15:03:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id s20sm4308642pgs.39.2019.05.03.15.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 12/30] mfd: cros_ec: Add lightbar v2 API
Date:   Fri,  3 May 2019 15:02:15 -0700
Message-Id: <20190503220233.64546-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New API split commands, improve EC command latency.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 124 ++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 5747bbcfa45f..d55f155eb735 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1628,7 +1628,10 @@ struct lightbar_params_v1 {
 	int32_t s3_sleep_for;
 	int32_t s3_ramp_up;
 	int32_t s3_ramp_down;
+	int32_t s5_ramp_up;
+	int32_t s5_ramp_down;
 	int32_t tap_tick_delay;
+	int32_t tap_gate_delay;
 	int32_t tap_display_time;
 
 	/* Tap-for-battery params */
@@ -1656,11 +1659,82 @@ struct lightbar_params_v1 {
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
@@ -1674,7 +1748,10 @@ struct ec_params_lightbar {
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
@@ -1701,6 +1778,14 @@ struct ec_params_lightbar {
 
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
@@ -1722,6 +1807,14 @@ struct ec_response_lightbar {
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
@@ -1734,9 +1827,11 @@ struct ec_response_lightbar {
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
@@ -1765,6 +1860,18 @@ enum lightbar_command {
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
 
@@ -1783,6 +1890,14 @@ enum ec_led_id {
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
@@ -1797,6 +1912,7 @@ enum ec_led_colors {
 	EC_LED_COLOR_BLUE,
 	EC_LED_COLOR_YELLOW,
 	EC_LED_COLOR_WHITE,
+	EC_LED_COLOR_AMBER,
 
 	EC_LED_COLOR_COUNT
 };
-- 
2.21.0.1020.gf2820cf01a-goog

