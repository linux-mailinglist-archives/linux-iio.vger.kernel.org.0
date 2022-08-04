Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFB58A0BB
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 20:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiHDSq7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiHDSq4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 14:46:56 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1546D560;
        Thu,  4 Aug 2022 11:46:54 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h188so333037oia.13;
        Thu, 04 Aug 2022 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KT5o4rt36m7BxJc04DTnWf34jJojmIKYLK34WwqIMFI=;
        b=q5GrPO/DfnDGyvG4h2SPRbu2Q20kTghMRgkNVC4VX9T8TKPXry2BUTZKxdd2xrEM1e
         adLD5l5L6Wk8Qm9i+gWuVzqNd/D3aBd0IrSUVHClIGPFSG14rYIshmDJR+6n8bL9jTpH
         m6gk+zYXf17gKTLkbmHXlfBStcsf+pL+W7JMiuNiZg4H+dEOoNPAoBq60ypvgxJZEHTw
         zC/AJjWlQNrVyGoVpJFsKZDRzHjbuN0tW8A1UtJaiHlet5DiR+hnfI2x5M4ejboKCTzL
         vmFsOvUzjoG+4MfWkGoMQQo0w+cy7C/K1iEQlAxDgV9HcN9ZFOlp4gO/WZvTx4wAmtsO
         Ct6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KT5o4rt36m7BxJc04DTnWf34jJojmIKYLK34WwqIMFI=;
        b=QdszYlbQqNjfSoGDp/HDJWycpzyrEqOse5HpxGFLCZL3AYEW4AjfPSrujZnlTJIDod
         G/uOsk9KWSO8Tll0M1YtT5SWSLUc0r11Lvi5J+niYRRVG5HrJ6fmFCU/KxEx3tM2LiUO
         +jkr5/VtbQZfNXZaKCwOUhPfyKn72+dUCvdAFW2B4fmQMn5A8ZT/uKIJIlOQvqRl2cT8
         Zu98aXvRWm/lNqdE5/bKZJBroolz+6jL8TQfQrFIfEJlEIaMfIun1UfV6sbldMQ9EnGO
         n6I15YVlrTEzomh6S2Patxvfp/8w2lInyyaE09A3a7NAMkEA0WyaFwXrmeL3XeKKfR41
         N53g==
X-Gm-Message-State: ACgBeo3a+qQh70Jj7P3fjzCp2oJW1BpKumxaVIZyokYb0jItAjxP+7K+
        bO2xcGMLtIyOyPksZOrxRHAaXSxDphs=
X-Google-Smtp-Source: AA6agR53g+VDUkpCcMYALLnH5bKGh/VPOjRUVeOasumAfHiaUe7YbbKkOXKfNXrUV86gvFb5uVXjLw==
X-Received: by 2002:a54:4015:0:b0:340:2eb7:62e9 with SMTP id x21-20020a544015000000b003402eb762e9mr1458628oie.65.1659638813391;
        Thu, 04 Aug 2022 11:46:53 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p17-20020a9d76d1000000b00636a8dafdc9sm87945otl.2.2022.08.04.11.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:46:53 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v11 2/3] Input: adc-joystick - Add polled input device support
Date:   Thu,  4 Aug 2022 13:46:43 -0500
Message-Id: <20220804184644.20710-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804184644.20710-1-macroalpha82@gmail.com>
References: <20220804184644.20710-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add polled input device support to the adc-joystick driver. This is
useful for devices which do not have hardware capable triggers on
their SARADC. Code modified from adc-joystick.c changes made by Maya
Matuszczyk.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/input/joystick/adc-joystick.c | 47 ++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..1094d0fb78ed 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -26,8 +26,23 @@ struct adc_joystick {
 	struct adc_joystick_axis *axes;
 	struct iio_channel *chans;
 	int num_chans;
+	bool polled;
 };
 
+static void adc_joystick_poll(struct input_dev *input)
+{
+	struct adc_joystick *joy = input_get_drvdata(input);
+	int i, val, ret;
+
+	for (i = 0; i < joy->num_chans; i++) {
+		ret = iio_read_channel_raw(&joy->chans[i], &val);
+		if (ret < 0)
+			return;
+		input_report_abs(input, joy->axes[i].code, val);
+	}
+	input_sync(input);
+}
+
 static int adc_joystick_handle(const void *data, void *private)
 {
 	struct adc_joystick *joy = private;
@@ -179,6 +194,7 @@ static int adc_joystick_probe(struct platform_device *pdev)
 	int error;
 	int bits;
 	int i;
+	unsigned int poll_interval;
 
 	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
 	if (!joy)
@@ -192,8 +208,21 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	/* Count how many channels we got. NULL terminated. */
+	if (device_property_present(dev, "poll-interval")) {
+		error = device_property_read_u32(dev, "poll-interval",
+						 &poll_interval);
+		if (error)
+			return error;
+		joy->polled = true;
+	}
+
+	/*
+	 * Count how many channels we got. NULL terminated.
+	 * Do not check the storage size if using polling.
+	 */
 	for (i = 0; joy->chans[i].indio_dev; i++) {
+		if (joy->polled)
+			continue;
 		bits = joy->chans[i].channel->scan_type.storagebits;
 		if (!bits || bits > 16) {
 			dev_err(dev, "Unsupported channel storage size\n");
@@ -215,8 +244,14 @@ static int adc_joystick_probe(struct platform_device *pdev)
 	joy->input = input;
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
-	input->open = adc_joystick_open;
-	input->close = adc_joystick_close;
+
+	if (joy->polled) {
+		input_setup_polling(input, adc_joystick_poll);
+		input_set_poll_interval(input, poll_interval);
+	} else {
+		input->open = adc_joystick_open;
+		input->close = adc_joystick_close;
+	}
 
 	error = adc_joystick_set_axes(dev, joy);
 	if (error)
@@ -229,13 +264,17 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	if (joy->polled)
+		return 0;
+
 	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
 	if (IS_ERR(joy->buffer)) {
 		dev_err(dev, "Unable to allocate callback buffer\n");
 		return PTR_ERR(joy->buffer);
 	}
 
-	error = devm_add_action_or_reset(dev, adc_joystick_cleanup, joy->buffer);
+	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
+					 joy->buffer);
 	if (error)  {
 		dev_err(dev, "Unable to add action\n");
 		return error;
-- 
2.25.1

