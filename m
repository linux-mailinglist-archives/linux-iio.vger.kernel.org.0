Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18157596423
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiHPVEy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiHPVEw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 17:04:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0876B786EB;
        Tue, 16 Aug 2022 14:04:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so406414otq.5;
        Tue, 16 Aug 2022 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=c13rZU/sHkVe3AVBpoXMuIMUwb2iadvrf9BWvXklTVQ=;
        b=EOI3It51llXIOXWbmV/a+WTR9xKGKAS+f1Amz+NeuQtcc+qqi21MP6PDV/CbvZG8M2
         6dPR5TRjnhptExKusRb23B6RYGARee3GiJlueppCYIcUvS4kAdmjmIig0v+AveBkVlmG
         rhs3Dc7/a356A7MGj8uw+xkTUuqGcTUYILGzKQ/u/XH8P49Y9ogR2F7H0oDl9uT3n4VU
         n0AKeAFlqspEaVSR7gSlXeSV3Jde8mXzbTrAzCOjmPj4T3Jv+7uAh9d/B/qC3/smYDsI
         4i47oNsTIyKwO8S6Abmt9BQVLwEhIz+663rqmaXu8wp+Rp8AVgdIgzIM26f8JeeE9AYh
         4ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=c13rZU/sHkVe3AVBpoXMuIMUwb2iadvrf9BWvXklTVQ=;
        b=3iBzHdaOefVMc87GuNAzVIC7PEisufmzyeg9dn8TvbtXlvqvIZ85okBSMy7Bd4WRI8
         /f4+YPZy5F7Pqy/S+c44Oow49RVw9XzhIh3yWBm88+lpcJihydZMZ/s6kO+M0XcelQ2N
         T9oTrJc8I8YoFmIhpDD4KA0jcIfCrjKkk78hW92boA/SsQGEkgmGuX4mzy4hPgjvS/Lj
         DoaHRbNlpz19ZT7lkoflJU0yRXah7WtKMhvrYUwHd9FtavDydJKfknori9PbHUaIUmAw
         RuSLNJHrWMhycnUnxvKuuwSUMPqo0LApbPRgxvRWJ/dg6L0nS98cimZY4Q8sOCQuAVtG
         b1Iw==
X-Gm-Message-State: ACgBeo2TNsr0QDTfa9mm3A6J2SZS86B/Pw2517pqZwV583Y8+mSF20u8
        nQTDCf4MR17YQL3t0Q+XzhcOscItuK0=
X-Google-Smtp-Source: AA6agR7ces5zfR6bZNxlvTX+xAKAO8qag+axUScPiZIUv3iPsDRnOqPd0I6LfvCGZVA6IFWtRO2ljQ==
X-Received: by 2002:a9d:2c3:0:b0:638:d57d:2250 with SMTP id 61-20020a9d02c3000000b00638d57d2250mr1227637otl.143.1660683890019;
        Tue, 16 Aug 2022 14:04:50 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id m24-20020a4ae3d8000000b00425678b9c4bsm2599653oov.0.2022.08.16.14.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:04:49 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v13 2/3] input: adc-joystick - Add polled input device support
Date:   Tue, 16 Aug 2022 16:04:39 -0500
Message-Id: <20220816210440.14260-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816210440.14260-1-macroalpha82@gmail.com>
References: <20220816210440.14260-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/input/joystick/adc-joystick.c | 48 +++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index e0cfdc84763f..3942574e8ecf 100644
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
@@ -192,8 +208,25 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	/* Count how many channels we got. NULL terminated. */
+	error = device_property_read_u32(dev, "poll-interval", &poll_interval);
+	if (error) {
+		/* -EINVAL means the property is absent. */
+		if (error != -EINVAL)
+			return error;
+	} else if (poll_interval == 0) {
+		dev_err(dev, "Unable to get poll-interval\n");
+		return -EINVAL;
+	} else {
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
@@ -215,13 +248,20 @@ static int adc_joystick_probe(struct platform_device *pdev)
 	joy->input = input;
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
-	input->open = adc_joystick_open;
-	input->close = adc_joystick_close;
 
 	error = adc_joystick_set_axes(dev, joy);
 	if (error)
 		return error;
 
+	if (joy->polled) {
+		input_setup_polling(input, adc_joystick_poll);
+		input_set_poll_interval(input, poll_interval);
+		goto register_joystick;
+	} else {
+		input->open = adc_joystick_open;
+		input->close = adc_joystick_close;
+	}
+
 	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
 	if (IS_ERR(joy->buffer)) {
 		dev_err(dev, "Unable to allocate callback buffer\n");
@@ -234,6 +274,8 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
+register_joystick:
+
 	input_set_drvdata(input, joy);
 
 	error = input_register_device(input);
-- 
2.25.1

