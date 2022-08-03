Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE95890EC
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiHCRCA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiHCRB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:01:59 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5E4E862;
        Wed,  3 Aug 2022 10:01:56 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l188so20545408oia.4;
        Wed, 03 Aug 2022 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qdcjs9XGhmK/cRJUiHaI67EDCLuIo42dxXhjz0b2c3g=;
        b=Tsh13Z6nOwC6FPfe5E1lBiXdo1sPtVWsSfmL+xvD/zJ4gfle+L6AtgMsgX0BGYtZ4f
         HDiq3ApBKmoHCfOBZ6/EMJssXfdW6tjdUENPtWU+wXOp6J2rnqR38F6KuaDkNslzvWYj
         v8+Zuf9EntYNU6uwj5UdSLezj6CvcWKIgvUztMT4CpixNES/4WEciaed20YOCEwva61g
         ldQ/4NB31jnUkQSrXZWOit7rGhRXGK5GHJZcnjtpT0N0GXroiIUwyLgjU9oSYmi+muA6
         27sqDGTaPxQO+sQNg+unaZjs+OTIGbOOVhKJfQvHgt4to14/JZ5bovLoJErchciXDbDh
         Llxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qdcjs9XGhmK/cRJUiHaI67EDCLuIo42dxXhjz0b2c3g=;
        b=xutgeyWBJFhxmcgRrRwp4Lttu7ICcXSeEkigY0iz2et2C06s0rjAhXEaIvqw4w0fiy
         ztXKoUbhDueDVsTpspfMsXBbZSMluyHmicqVfluAfeAJEs1WXyKreYYnx5AnyhO5lHFC
         kl9/FCcx5NHbLWETf71po2u/9F9AhjLZ8gfgSO4iq5Dg5W/0p92f8+yoA7s9LPd2XbkL
         pjpTYH2vvwGbGghHJp+2H10P+JcdJK011CkWmF8qieDb84cmgI2dOSFBwouYIANesoOV
         4gM7rbrE9Cdvkvg5GiIcjUwkBvKsZa1zSdRVIBgZF2ZpP6JETpROV9l8qDYVkWmXYejw
         gRWw==
X-Gm-Message-State: ACgBeo3s9gv8WEgoyhdbk3Z3PzwmTKcf5vhkUVO8AkwNzY9IWKwFrtm/
        4uMhK4/c6AzkucKZckuqz+KuKfcclPU=
X-Google-Smtp-Source: AA6agR5t50Xa3cfKhLqcDElVUOU0wCnVNI+7dY3NvVy6Oycl/i9IFOxW6fZCHI8oqe0C79tObNRK7w==
X-Received: by 2002:a05:6808:2225:b0:341:408b:4a37 with SMTP id bd37-20020a056808222500b00341408b4a37mr2196521oib.29.1659546115554;
        Wed, 03 Aug 2022 10:01:55 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id q16-20020a05683033d000b0061c29a38b3bsm4088453ott.33.2022.08.03.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:01:54 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v9 2/3] Input: adc-joystick - Add polled input device support
Date:   Wed,  3 Aug 2022 12:01:44 -0500
Message-Id: <20220803170145.16186-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803170145.16186-1-macroalpha82@gmail.com>
References: <20220803170145.16186-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c | 69 +++++++++++++++++++++------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..0a2c0fb73618 100644
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
@@ -192,14 +208,27 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
 		bits = joy->chans[i].channel->scan_type.storagebits;
-		if (!bits || bits > 16) {
-			dev_err(dev, "Unsupported channel storage size\n");
+		if (!joy->polled && (!bits || bits > 16)) {
+			dev_err(dev,
+				"Unsupported channel storage size\n");
 			return -EINVAL;
 		}
-		if (bits != joy->chans[0].channel->scan_type.storagebits) {
+		if (!joy->polled &&
+			bits != joy->chans[0].channel->scan_type.storagebits) {
 			dev_err(dev, "Channels must have equal storage size\n");
 			return -EINVAL;
 		}
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
@@ -229,16 +264,20 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
-	if (IS_ERR(joy->buffer)) {
-		dev_err(dev, "Unable to allocate callback buffer\n");
-		return PTR_ERR(joy->buffer);
-	}
+	if (!joy->polled) {
+		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
+						     joy);
+		if (IS_ERR(joy->buffer)) {
+			dev_err(dev, "Unable to allocate callback buffer\n");
+			return PTR_ERR(joy->buffer);
+		}
 
-	error = devm_add_action_or_reset(dev, adc_joystick_cleanup, joy->buffer);
-	if (error)  {
-		dev_err(dev, "Unable to add action\n");
-		return error;
+		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
+						 joy->buffer);
+		if (error)  {
+			dev_err(dev, "Unable to add action\n");
+			return error;
+		}
 	}
 
 	return 0;
-- 
2.25.1

