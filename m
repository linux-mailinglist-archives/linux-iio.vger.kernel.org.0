Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF013530
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfECWDc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38976 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfECWDc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so3316311plb.6
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxG/c9D/NBsdphFkOGYkAYx60e4Yug/i+ObZmhuuRY8=;
        b=ETydW/rUCRPTh/s1yRtjS/ww9Ye62p9REMf4WtG03cMNsTX5maPCwuBhO2eER25Z3/
         P4oHoAjQS/NsQVmxdCQ8B7PPSTmvE+2ouAMCw2Obcn4a8QM7roA9s4Dej034CL9gI682
         Ruu2DoFhwjlFDCh7nl7nDguq0oex3EtOs+b0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxG/c9D/NBsdphFkOGYkAYx60e4Yug/i+ObZmhuuRY8=;
        b=iCzgxv9xpUcL34QRYExaKDWpqccPsvlycQDBo1//pjpboT3sVmtZ94hb9tHSUzz2gO
         EaWPfq+dICZ5hn3Ve3UFIVMOIkildch1JcU2lDCWvQKF2Xs9B7L4z8kF5HNzm40Bg65j
         UYN5p9FjigZhzcBWXLIBtIpDFVQdaBiuC4Z9GVPQ3SsrqmN39m8tnaBF8dXu6wwkoOaS
         dSMj8lvllSaAs1GXm/oRCaS0ZAYLLpJ1vO3V7Wy8j8+JQfWtmgmDU+Mwl0cL2BoUYL4o
         KkmH4yXdyqxJ9oMd6vA3R/GLxusECVM7zFjlimWJqJTi8W9yG4A4H9DM+LNvOaxZuO9G
         0D/w==
X-Gm-Message-State: APjAAAUXZqu6WSIXlV0+04WFoqpAFKFAJKW7RtXRFMwIlC6JS5CTVsJ7
        GdxwAbHQugoTU2C0wTrfT4xH1A==
X-Google-Smtp-Source: APXvYqwHdgpmFAKQlh4ZEvHE9aKItt4Jwss7q0Y/my1NDvARzJ6Oi1TH0GlwenQcfqE+5oaotr+Zvg==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr13950720plo.67.1556921011585;
        Fri, 03 May 2019 15:03:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f87sm5704424pff.56.2019.05.03.15.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:30 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 30/30] mfd: cros_ec: Update I2S API
Date:   Fri,  3 May 2019 15:02:33 -0700
Message-Id: <20190503220233.64546-31-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve I2S API.
Rename ec_response_codec_gain into ec_codec_i2s_gain,
update caller accordlingly.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 44 +++++++++++++---------------
 sound/soc/codecs/cros_ec_codec.c     |  8 ++---
 2 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc8babce1576..fa397722f17e 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4471,6 +4471,7 @@ enum mkbp_cec_event {
 /* Commands for I2S recording on audio codec. */
 
 #define EC_CMD_CODEC_I2S 0x00BC
+#define EC_WOV_I2S_SAMPLE_RATE 48000
 
 enum ec_codec_i2s_subcmd {
 	EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
@@ -4480,6 +4481,7 @@ enum ec_codec_i2s_subcmd {
 	EC_CODEC_I2S_SET_CONFIG = 0x4,
 	EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
 	EC_CODEC_I2S_SET_BCLK = 0x6,
+	EC_CODEC_I2S_SUBCMD_COUNT = 0x7,
 };
 
 enum ec_sample_depth_value {
@@ -4496,6 +4498,21 @@ enum ec_i2s_config {
 	EC_DAI_FMT_PCM_TDM = 5,
 };
 
+/*
+ * For subcommand EC_CODEC_GET_GAIN.
+ */
+struct __ec_align1 ec_codec_i2s_gain {
+	uint8_t left;
+	uint8_t right;
+};
+
+struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
+	int16_t ch0_delay; /* 0 to 496 */
+	int16_t ch1_delay; /* -1 to 496 */
+	uint8_t adjacent_to_ch0;
+	uint8_t adjacent_to_ch1;
+};
+
 struct __ec_todo_packed ec_param_codec_i2s {
 	/* enum ec_codec_i2s_subcmd */
 	uint8_t cmd;
@@ -4510,10 +4527,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_SET_GAIN
 		 * Value should be 0~43 for both channels.
 		 */
-		struct __ec_align1 ec_param_codec_i2s_set_gain {
-			uint8_t left;
-			uint8_t right;
-		} gain;
+		struct ec_codec_i2s_gain gain;
 
 		/*
 		 * EC_CODEC_I2S_ENABLE
@@ -4522,7 +4536,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		uint8_t i2s_enable;
 
 		/*
-		 * EC_CODEC_I2S_SET_COFNIG
+		 * EC_CODEC_I2S_SET_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
 		uint8_t i2s_config;
@@ -4531,18 +4545,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_I2S_SET_TDM_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
-		struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
-			/*
-			 * 0 to 496
-			 */
-			int16_t ch0_delay;
-			/*
-			 * -1 to 496
-			 */
-			int16_t ch1_delay;
-			uint8_t adjacent_to_ch0;
-			uint8_t adjacent_to_ch1;
-		} tdm_param;
+		struct ec_param_codec_i2s_tdm tdm_param;
 
 		/*
 		 * EC_CODEC_I2S_SET_BCLK
@@ -4551,13 +4554,6 @@ struct __ec_todo_packed ec_param_codec_i2s {
 	};
 };
 
-/*
- * For subcommand EC_CODEC_GET_GAIN.
- */
-struct ec_response_codec_gain {
-	uint8_t left;
-	uint8_t right;
-} __ec_align1;
 
 /*****************************************************************************/
 /* System commands */
diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 99a3af8a15ff..87830ed5ebf4 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -38,21 +38,21 @@ static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
 
 static int ec_command_get_gain(struct snd_soc_component *component,
 			       struct ec_param_codec_i2s *param,
-			       struct ec_response_codec_gain *resp)
+			       struct ec_codec_i2s_gain *resp)
 {
 	struct cros_ec_codec_data *codec_data =
 		snd_soc_component_get_drvdata(component);
 	struct cros_ec_device *ec_device = codec_data->ec_device;
 	u8 buffer[sizeof(struct cros_ec_command) +
 		  max(sizeof(struct ec_param_codec_i2s),
-		      sizeof(struct ec_response_codec_gain))];
+		      sizeof(struct ec_codec_i2s_gain))];
 	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
 	int ret;
 
 	msg->version = 0;
 	msg->command = EC_CMD_CODEC_I2S;
 	msg->outsize = sizeof(struct ec_param_codec_i2s);
-	msg->insize = sizeof(struct ec_response_codec_gain);
+	msg->insize = sizeof(struct ec_codec_i2s_gain);
 
 	memcpy(msg->data, param, msg->outsize);
 
@@ -226,7 +226,7 @@ static int get_ec_mic_gain(struct snd_soc_component *component,
 			   u8 *left, u8 *right)
 {
 	struct ec_param_codec_i2s param;
-	struct ec_response_codec_gain resp;
+	struct ec_codec_i2s_gain resp;
 	int ret;
 
 	param.cmd = EC_CODEC_GET_GAIN;
-- 
2.21.0.1020.gf2820cf01a-goog

