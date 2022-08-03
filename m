Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5F5891AE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiHCRpV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiHCRpT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:45:19 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155E60E5;
        Wed,  3 Aug 2022 10:45:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p132so20648000oif.9;
        Wed, 03 Aug 2022 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cK8P+NQx1HxjzaitSSfn9Crns+5z0PdzCX3QJxjESvY=;
        b=VbpxpWZe71OV9ZsGhSOHFw3j4jFe5aWqBvzt+3AcwyrqU+kzhSj7GW2djSKXXXniqx
         +6ZZ/pbZV2wlXVPm0jVnN8RFJz4qfUrhkwRk/U4Sdyj3hCl/SzB9qqgffMdnTRiI2olz
         YlIGqnNB2IEjwp0//2r1F5Tp/kUmnwmf8MXmKn/zi9wWg4XsNpxtVA7Ro1XejttMv8ng
         tbCcxgRarasoYspDxFm30+J32VQb83iy/EdOyJFpDSptRQw40XhA+xLBSyNqYy1o3cf/
         y78iaKUeVRTkItF5KSNxm8pjL6AAyEu/al3xuZHwesa7xa7egjDTylwYSMmlBLtxOTn2
         RN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cK8P+NQx1HxjzaitSSfn9Crns+5z0PdzCX3QJxjESvY=;
        b=HX4QZPga7HQ8KBGYagIL93v0c+C6Any53Hc9y4xicU8DUWXX8D2jED2dX6dHT4+YGX
         aP00ygwt9xNSORN4JeDHAWRzbS71RwyW2NGtDso7sIgA/J9ZbKnC/qbqQl/eQxLfZShx
         97wqaTQrW28/3PeJHqQZZuLN9IGpfTslbP34ss6/rWXqWBtKqM5gMiutR94aAj2uaR++
         0LwXThVcK2hklCuRmV188A4UYAIhShfQaQD9qXem1lQ3lylvKq7JHcvHbqASg/PYnwxS
         /KLnpvltYMBtIEgvOq5ftCj2zfOn+JKlAPZ8HKWNdZoZgF04LoaK6SSoItrhFQakTNBK
         H0iA==
X-Gm-Message-State: ACgBeo2ku13O16g+pnuwMxqiEeaPYx61Hgcf3ScMVVod8Cv4qfGIrF5x
        EmcrdjlFqS7eoHNW4xyUtxdSc6ez0FQ=
X-Google-Smtp-Source: AA6agR4dbysuDm+Z/+s7SwMXTMQ2GZT7Jae2of/lZ1+UGoVKE44v2SX/0Gpi+nQczkhCjDoFrb2LgA==
X-Received: by 2002:a05:6808:f90:b0:33a:c3ed:cae8 with SMTP id o16-20020a0568080f9000b0033ac3edcae8mr2098280oiw.218.1659548717842;
        Wed, 03 Aug 2022 10:45:17 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id bx6-20020a0568081b0600b0033a6bfdc5adsm3551893oib.36.2022.08.03.10.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:45:17 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v10 2/3] Input: adc-joystick - Add polled input device support
Date:   Wed,  3 Aug 2022 12:45:04 -0500
Message-Id: <20220803174505.21420-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803174505.21420-1-macroalpha82@gmail.com>
References: <20220803174505.21420-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c | 53 ++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..a288ebfe254e 100644
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
@@ -192,11 +208,25 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
-			dev_err(dev, "Unsupported channel storage size\n");
+			dev_err(dev,
+				"Unsupported channel storage size\n");
 			return -EINVAL;
 		}
 		if (bits != joy->chans[0].channel->scan_type.storagebits) {
@@ -215,8 +245,14 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
@@ -229,13 +265,18 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
+	if (joy->polled)
+		return 0;
+
+	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
+					     joy);
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

