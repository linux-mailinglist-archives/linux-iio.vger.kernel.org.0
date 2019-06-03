Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB94337F8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFCSeq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38436 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfFCSeo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so8765308pgl.5
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hz5V6YUUKbQCf9zJopKesHEceG79IQrE8elrPDeqfIA=;
        b=aQ9MPswYniQYF/VdKEGa83AHZ5RcwOnAiRjnZU9kdPMUKqq4lkWjJfrxGSYaNBSa2M
         7Ozd1L3YdSwCVfklSjOEq+yoZ3Aq5rcVjPm3TXVn5aD/gT6wAu241TMQdNeNEoRv1W4n
         UkQo6o4yyGV9LY1WQFNGimqIwNoKhnUVrlciM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hz5V6YUUKbQCf9zJopKesHEceG79IQrE8elrPDeqfIA=;
        b=tvRHPOB6Or3SSN50X+Rcuoh4aH7Tvg+m6eLTAW4DxioJUlLVTnmMI/HQdPDDPjlhyR
         358XtaXVHU6+B3urlkbm1xyHT9Ixc/CppyYCQMKcNI5y03myFm4d/NESF9UO0vOEi3bv
         /78Z9gplmEhLgGzrAm7iIocym695YCVPAtgg4gQj/XhAAgJl2TWwgnB6E2taChpyiGEy
         aPTkv4Ygp2pPROSsWAJDARIvjmEUmqHZHSx3PAaWGXlWs5t65At7MHNAZNBNLkXSRAJM
         o+7vbPutc56YYVQtmlJNJNhzeoIchfRQ9/QzdERWJLQ8EQJD4HueqVoY8pt1iaP45BG+
         +aEA==
X-Gm-Message-State: APjAAAWU5tipyrUp7SyI1sPm2Eh7BskmbEQZV+oSmp2HydzPGpSof55D
        xrh5FHIUzHNeaS9subeZwDMaGA==
X-Google-Smtp-Source: APXvYqxCgWJ0IzOoKA7UD5Ilf35KswSj9PGa5spcxGeDMhtHufZS+8vOm3xoElqubc+gwOmf6i+aNg==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr16056124pgi.412.1559586883446;
        Mon, 03 Jun 2019 11:34:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id e124sm20964180pfa.135.2019.06.03.11.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:42 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 23/30] mfd: cros_ec: Add I2C passthru protection API
Date:   Mon,  3 Jun 2019 11:33:54 -0700
Message-Id: <20190603183401.151408-24-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Prevent direct i2c access to device behind EC when not in development mode.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 49ea905cfd18..59ad6bae3f9b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4316,6 +4316,28 @@ struct ec_params_entering_mode {
 #define VBOOT_MODE_DEVELOPER 1
 #define VBOOT_MODE_RECOVERY  2
 
+/*****************************************************************************/
+/*
+ * I2C passthru protection command: Protects I2C tunnels against access on
+ * certain addresses (board-specific).
+ */
+#define EC_CMD_I2C_PASSTHRU_PROTECT 0x00B7
+
+enum ec_i2c_passthru_protect_subcmd {
+	EC_CMD_I2C_PASSTHRU_PROTECT_STATUS = 0x0,
+	EC_CMD_I2C_PASSTHRU_PROTECT_ENABLE = 0x1,
+};
+
+struct ec_params_i2c_passthru_protect {
+	uint8_t subcmd;
+	uint8_t port;		/* I2C port number */
+} __ec_align1;
+
+struct ec_response_i2c_passthru_protect {
+	uint8_t status;		/* Status flags (0: unlocked, 1: locked) */
+} __ec_align1;
+
+
 /*****************************************************************************/
 /*
  * HDMI CEC commands
-- 
2.21.0.1020.gf2820cf01a-goog

