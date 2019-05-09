Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5841943F
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfEIVOo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:14:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37481 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfEIVOn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1836035pgc.4
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzJF/uXh/WW5SAPCgvx6TK/R44Xke1eEZxrKlpuTex0=;
        b=YS3ESIwN9KreU1g9DDMPzX3twR6LqR54jWPOsAI/nB6RadrHICpo3jQYRVx6KXY+6L
         weCui+3J6hL1zZkeRNtH152+N+FyDlloftGtUB/g+la+AGa63VHw2B4dg/pQAI+MV/GG
         rbKq2QYbwpvrlq1KMqXiuYjSZyB0SoXfVZVgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzJF/uXh/WW5SAPCgvx6TK/R44Xke1eEZxrKlpuTex0=;
        b=OSl2bKFPeHrj4T85OHz/+jQEKTL2Y3DGiVR57MgfbKEL/URMXMy3FxWw7E8oEOFlog
         x/hIFDHbd6y34MqaxkDlZJFhaUwP7oCw5egU6A33xnx5uDkz+PRehD5xn8LSbt5izSNJ
         M2aUqWKpdWMjgi4P4bYBRAo8Ekc2+eIeV1i3ezTO9Ancgcfw9o9CzLU+HUWUKZQoH51K
         GzAf/CaNQSzvqut9BeSNc90jZ9+SXhrzH4YmHsJjLHTn6gHxfKEv8Dp93EEhiwxi+Q94
         oTwI7JILhbt/51hDcZLcgch2aj8c8LbGN1+VbnsaYIlmiwOT5pNAX0sBgo8+GjluV790
         RJ0g==
X-Gm-Message-State: APjAAAV3LVpiVTwBQgm/glLOpRqXToYnoOUuDATtOQuGBiVCRQt0r79r
        J6iJOO9Fw59tFf2+kphL3KjbSw==
X-Google-Smtp-Source: APXvYqxSGHmueVpWq/pAYMp2JtvUKHMtTeGiFU1FU0qZZM5+1NYUy1u4haH51HgSeYPHLHML6dvnrw==
X-Received: by 2002:a62:4602:: with SMTP id t2mr8609152pfa.26.1557436482951;
        Thu, 09 May 2019 14:14:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 10sm4437786pgm.0.2019.05.09.14.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:42 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 26/30] mfd: cros_ec: Add API for Fingerprint support
Date:   Thu,  9 May 2019 14:13:49 -0700
Message-Id: <20190509211353.213194-27-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add API for fingerprint sensor presented by embedded controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 228 +++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 1d0311df44d3..4a9ac3861bdd 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,234 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/*****************************************************************************/
+/* Fingerprint MCU commands: range 0x0400-0x040x */
+
+/* Fingerprint SPI sensor passthru command: prototyping ONLY */
+#define EC_CMD_FP_PASSTHRU 0x0400
+
+#define EC_FP_FLAG_NOT_COMPLETE 0x1
+
+struct ec_params_fp_passthru {
+	uint16_t len;		/* Number of bytes to write then read */
+	uint16_t flags;		/* EC_FP_FLAG_xxx */
+	uint8_t data[];		/* Data to send */
+} __ec_align2;
+
+/* Configure the Fingerprint MCU behavior */
+#define EC_CMD_FP_MODE 0x0402
+
+/* Put the sensor in its lowest power mode */
+#define FP_MODE_DEEPSLEEP      BIT(0)
+/* Wait to see a finger on the sensor */
+#define FP_MODE_FINGER_DOWN    BIT(1)
+/* Poll until the finger has left the sensor */
+#define FP_MODE_FINGER_UP      BIT(2)
+/* Capture the current finger image */
+#define FP_MODE_CAPTURE        BIT(3)
+/* Finger enrollment session on-going */
+#define FP_MODE_ENROLL_SESSION BIT(4)
+/* Enroll the current finger image */
+#define FP_MODE_ENROLL_IMAGE   BIT(5)
+/* Try to match the current finger image */
+#define FP_MODE_MATCH          BIT(6)
+/* Reset and re-initialize the sensor. */
+#define FP_MODE_RESET_SENSOR   BIT(7)
+/* special value: don't change anything just read back current mode */
+#define FP_MODE_DONT_CHANGE    BIT(31)
+
+#define FP_VALID_MODES (FP_MODE_DEEPSLEEP      | \
+			FP_MODE_FINGER_DOWN    | \
+			FP_MODE_FINGER_UP      | \
+			FP_MODE_CAPTURE        | \
+			FP_MODE_ENROLL_SESSION | \
+			FP_MODE_ENROLL_IMAGE   | \
+			FP_MODE_MATCH          | \
+			FP_MODE_RESET_SENSOR   | \
+			FP_MODE_DONT_CHANGE)
+
+/* Capture types defined in bits [30..28] */
+#define FP_MODE_CAPTURE_TYPE_SHIFT 28
+#define FP_MODE_CAPTURE_TYPE_MASK  (0x7 << FP_MODE_CAPTURE_TYPE_SHIFT)
+/*
+ * This enum must remain ordered, if you add new values you must ensure that
+ * FP_CAPTURE_TYPE_MAX is still the last one.
+ */
+enum fp_capture_type {
+	/* Full blown vendor-defined capture (produces 'frame_size' bytes) */
+	FP_CAPTURE_VENDOR_FORMAT = 0,
+	/* Simple raw image capture (produces width x height x bpp bits) */
+	FP_CAPTURE_SIMPLE_IMAGE = 1,
+	/* Self test pattern (e.g. checkerboard) */
+	FP_CAPTURE_PATTERN0 = 2,
+	/* Self test pattern (e.g. inverted checkerboard) */
+	FP_CAPTURE_PATTERN1 = 3,
+	/* Capture for Quality test with fixed contrast */
+	FP_CAPTURE_QUALITY_TEST = 4,
+	/* Capture for pixel reset value test */
+	FP_CAPTURE_RESET_TEST = 5,
+	FP_CAPTURE_TYPE_MAX,
+};
+/* Extracts the capture type from the sensor 'mode' word */
+#define FP_CAPTURE_TYPE(mode) (((mode) & FP_MODE_CAPTURE_TYPE_MASK) \
+				       >> FP_MODE_CAPTURE_TYPE_SHIFT)
+
+struct ec_params_fp_mode {
+	uint32_t mode; /* as defined by FP_MODE_ constants */
+} __ec_align4;
+
+struct ec_response_fp_mode {
+	uint32_t mode; /* as defined by FP_MODE_ constants */
+} __ec_align4;
+
+/* Retrieve Fingerprint sensor information */
+#define EC_CMD_FP_INFO 0x0403
+
+/* Number of dead pixels detected on the last maintenance */
+#define FP_ERROR_DEAD_PIXELS(errors) ((errors) & 0x3FF)
+/* Unknown number of dead pixels detected on the last maintenance */
+#define FP_ERROR_DEAD_PIXELS_UNKNOWN (0x3FF)
+/* No interrupt from the sensor */
+#define FP_ERROR_NO_IRQ    BIT(12)
+/* SPI communication error */
+#define FP_ERROR_SPI_COMM  BIT(13)
+/* Invalid sensor Hardware ID */
+#define FP_ERROR_BAD_HWID  BIT(14)
+/* Sensor initialization failed */
+#define FP_ERROR_INIT_FAIL BIT(15)
+
+struct ec_response_fp_info_v0 {
+	/* Sensor identification */
+	uint32_t vendor_id;
+	uint32_t product_id;
+	uint32_t model_id;
+	uint32_t version;
+	/* Image frame characteristics */
+	uint32_t frame_size;
+	uint32_t pixel_format; /* using V4L2_PIX_FMT_ */
+	uint16_t width;
+	uint16_t height;
+	uint16_t bpp;
+	uint16_t errors; /* see FP_ERROR_ flags above */
+} __ec_align4;
+
+struct ec_response_fp_info {
+	/* Sensor identification */
+	uint32_t vendor_id;
+	uint32_t product_id;
+	uint32_t model_id;
+	uint32_t version;
+	/* Image frame characteristics */
+	uint32_t frame_size;
+	uint32_t pixel_format; /* using V4L2_PIX_FMT_ */
+	uint16_t width;
+	uint16_t height;
+	uint16_t bpp;
+	uint16_t errors; /* see FP_ERROR_ flags above */
+	/* Template/finger current information */
+	uint32_t template_size;  /* max template size in bytes */
+	uint16_t template_max;   /* maximum number of fingers/templates */
+	uint16_t template_valid; /* number of valid fingers/templates */
+	uint32_t template_dirty; /* bitmap of templates with MCU side changes */
+	uint32_t template_version; /* version of the template format */
+} __ec_align4;
+
+/* Get the last captured finger frame or a template content */
+#define EC_CMD_FP_FRAME 0x0404
+
+/* constants defining the 'offset' field which also contains the frame index */
+#define FP_FRAME_INDEX_SHIFT       28
+/* Frame buffer where the captured image is stored */
+#define FP_FRAME_INDEX_RAW_IMAGE    0
+/* First frame buffer holding a template */
+#define FP_FRAME_INDEX_TEMPLATE     1
+#define FP_FRAME_GET_BUFFER_INDEX(offset) ((offset) >> FP_FRAME_INDEX_SHIFT)
+#define FP_FRAME_OFFSET_MASK       0x0FFFFFFF
+
+/* Version of the format of the encrypted templates. */
+#define FP_TEMPLATE_FORMAT_VERSION 3
+
+/* Constants for encryption parameters */
+#define FP_CONTEXT_NONCE_BYTES 12
+#define FP_CONTEXT_USERID_WORDS (32 / sizeof(uint32_t))
+#define FP_CONTEXT_TAG_BYTES 16
+#define FP_CONTEXT_SALT_BYTES 16
+#define FP_CONTEXT_TPM_BYTES 32
+
+struct ec_fp_template_encryption_metadata {
+	/*
+	 * Version of the structure format (N=3).
+	 */
+	uint16_t struct_version;
+	/* Reserved bytes, set to 0. */
+	uint16_t reserved;
+	/*
+	 * The salt is *only* ever used for key derivation. The nonce is unique,
+	 * a different one is used for every message.
+	 */
+	uint8_t nonce[FP_CONTEXT_NONCE_BYTES];
+	uint8_t salt[FP_CONTEXT_SALT_BYTES];
+	uint8_t tag[FP_CONTEXT_TAG_BYTES];
+};
+
+struct ec_params_fp_frame {
+	/*
+	 * The offset contains the template index or FP_FRAME_INDEX_RAW_IMAGE
+	 * in the high nibble, and the real offset within the frame in
+	 * FP_FRAME_OFFSET_MASK.
+	 */
+	uint32_t offset;
+	uint32_t size;
+} __ec_align4;
+
+/* Load a template into the MCU */
+#define EC_CMD_FP_TEMPLATE 0x0405
+
+/* Flag in the 'size' field indicating that the full template has been sent */
+#define FP_TEMPLATE_COMMIT 0x80000000
+
+struct ec_params_fp_template {
+	uint32_t offset;
+	uint32_t size;
+	uint8_t data[];
+} __ec_align4;
+
+/* Clear the current fingerprint user context and set a new one */
+#define EC_CMD_FP_CONTEXT 0x0406
+
+struct ec_params_fp_context {
+	uint32_t userid[FP_CONTEXT_USERID_WORDS];
+} __ec_align4;
+
+#define EC_CMD_FP_STATS 0x0407
+
+#define FPSTATS_CAPTURE_INV  BIT(0)
+#define FPSTATS_MATCHING_INV BIT(1)
+
+struct ec_response_fp_stats {
+	uint32_t capture_time_us;
+	uint32_t matching_time_us;
+	uint32_t overall_time_us;
+	struct {
+		uint32_t lo;
+		uint32_t hi;
+	} overall_t0;
+	uint8_t timestamps_invalid;
+	int8_t template_matched;
+} __ec_align2;
+
+#define EC_CMD_FP_SEED 0x0408
+struct ec_params_fp_seed {
+	/*
+	 * Version of the structure format (N=3).
+	 */
+	uint16_t struct_version;
+	/* Reserved bytes, set to 0. */
+	uint16_t reserved;
+	/* Seed from the TPM. */
+	uint8_t seed[FP_CONTEXT_TPM_BYTES];
+} __ec_align4;
+
 /*****************************************************************************/
 /* Touchpad MCU commands: range 0x0500-0x05FF */
 
-- 
2.21.0.1020.gf2820cf01a-goog

