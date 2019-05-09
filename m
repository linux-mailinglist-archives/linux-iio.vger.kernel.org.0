Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40DB19459
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfEIVPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:15:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45860 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfEIVOb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so1716621pls.12
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdBQmcIdU0Rz/x8vcPlOves92mcg6yTCi+x1gfv5Pak=;
        b=Bfd/Ekf2p/8ipmAOdUnSq+3U+hBLAtjV69d+L0A5aiqMeWrRbYXuREhAR3zxvuNnKY
         XW4VfFk8dw/iEMnIEvtF82oVHKPtTcEuwAElg84/cOriyZyt4kGa8XtDzC4v/Y/0v92R
         6kxrU3rQ+Ife1RHQCo35bkUNvd8mbc1xMJxnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdBQmcIdU0Rz/x8vcPlOves92mcg6yTCi+x1gfv5Pak=;
        b=Zw/oM2pQW1JUCQntpXmDFCLo8lkqbr1S2+dgYdZIBzW7cpxOcbFGmmtKBIC8KPz5cG
         qw6FB7kPM4uv8uJmuZ9G/XDh3AdM4DRAHXOlUvgBLYtjAxjiFkF0xKuaJEatj5x3teNz
         pYhsGc2TMnp3yfB0iyKLvCvMi/ba0M8CCtXUzmQDZod8MyWQtdZYF2ay3RHrNve7kU8d
         Ba3ZfQqIBHy3qANbKcXODmn4pshGLd3St7n4ptxKAmVjUrpjVddlwAMYimCTt2JtcLGo
         WA4SCXNrSuMJoq6t6xsOzc+J58AGPyds59zmhihOlPaFOXYAIiqEmskVjG30/v6S97Dr
         oY8A==
X-Gm-Message-State: APjAAAWvwoCb9WWdLjGABABeznH5Ie4QkfFWP4iekjPb1dlt0AboOjeX
        K1KpAVaN30Tsx1MxZCbPA6GFdA==
X-Google-Smtp-Source: APXvYqxbJXdzA8oxT2Bn+g8DBr4t1WTxDT7A8NncOrsx+sD74nqvfLbZIIXeJW3uwslBJ+FXKtQ/AQ==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr8290208pll.65.1557436470337;
        Thu, 09 May 2019 14:14:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h189sm4414601pfc.125.2019.05.09.14.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:29 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 18/30] mfd: cros_ec: Fix temperature API
Date:   Thu,  9 May 2019 14:13:41 -0700
Message-Id: <20190509211353.213194-19-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve API to retrieve temperature information.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 64 +++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index d5d07a9957ec..9a84aad7475a 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2945,9 +2945,28 @@ enum ec_temp_thresholds {
 /*
  * Thermal configuration for one temperature sensor. Temps are in degrees K.
  * Zero values will be silently ignored by the thermal task.
+ *
+ * Set 'temp_host' value allows thermal task to trigger some event with 1 degree
+ * hysteresis.
+ * For example,
+ *	temp_host[EC_TEMP_THRESH_HIGH] = 300 K
+ *	temp_host_release[EC_TEMP_THRESH_HIGH] = 0 K
+ * EC will throttle ap when temperature >= 301 K, and release throttling when
+ * temperature <= 299 K.
+ *
+ * Set 'temp_host_release' value allows thermal task has a custom hysteresis.
+ * For example,
+ *	temp_host[EC_TEMP_THRESH_HIGH] = 300 K
+ *	temp_host_release[EC_TEMP_THRESH_HIGH] = 295 K
+ * EC will throttle ap when temperature >= 301 K, and release throttling when
+ * temperature <= 294 K.
+ *
+ * Note that this structure is a sub-structure of
+ * ec_params_thermal_set_threshold_v1, but maintains its alignment there.
  */
 struct ec_thermal_config {
 	uint32_t temp_host[EC_TEMP_THRESH_COUNT]; /* levels of hotness */
+	uint32_t temp_host_release[EC_TEMP_THRESH_COUNT]; /* release levels */
 	uint32_t temp_fan_off;		/* no active cooling needed */
 	uint32_t temp_fan_max;		/* max active cooling needed */
 } __ec_align4;
@@ -2973,32 +2992,63 @@ struct ec_params_thermal_set_threshold_v1 {
 /* Toggle automatic fan control */
 #define EC_CMD_THERMAL_AUTO_FAN_CTRL 0x0052
 
-/* Get TMP006 calibration data */
+/* Version 1 of input params */
+struct ec_params_auto_fan_ctrl_v1 {
+	uint8_t fan_idx;
+} __ec_align1;
+
+/* Get/Set TMP006 calibration data */
 #define EC_CMD_TMP006_GET_CALIBRATION 0x0053
+#define EC_CMD_TMP006_SET_CALIBRATION 0x0054
+
+/*
+ * The original TMP006 calibration only needed four params, but now we need
+ * more. Since the algorithm is nothing but magic numbers anyway, we'll leave
+ * the params opaque. The v1 "get" response will include the algorithm number
+ * and how many params it requires. That way we can change the EC code without
+ * needing to update this file. We can also use a different algorithm on each
+ * sensor.
+ */
 
+/* This is the same struct for both v0 and v1. */
 struct ec_params_tmp006_get_calibration {
 	uint8_t index;
 } __ec_align1;
 
-struct ec_response_tmp006_get_calibration {
+/* Version 0 */
+struct ec_response_tmp006_get_calibration_v0 {
 	float s0;
 	float b0;
 	float b1;
 	float b2;
 } __ec_align4;
 
-/* Set TMP006 calibration data */
-#define EC_CMD_TMP006_SET_CALIBRATION 0x0054
-
-struct ec_params_tmp006_set_calibration {
+struct ec_params_tmp006_set_calibration_v0 {
 	uint8_t index;
-	uint8_t reserved[3];  /* Reserved; set 0 */
+	uint8_t reserved[3];
 	float s0;
 	float b0;
 	float b1;
 	float b2;
 } __ec_align4;
 
+/* Version 1 */
+struct ec_response_tmp006_get_calibration_v1 {
+	uint8_t algorithm;
+	uint8_t num_params;
+	uint8_t reserved[2];
+	float val[0];
+} __ec_align4;
+
+struct ec_params_tmp006_set_calibration_v1 {
+	uint8_t index;
+	uint8_t algorithm;
+	uint8_t num_params;
+	uint8_t reserved;
+	float val[0];
+} __ec_align4;
+
+
 /* Read raw TMP006 data */
 #define EC_CMD_TMP006_GET_RAW 0x0055
 
-- 
2.21.0.1020.gf2820cf01a-goog

