Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F097456772B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jul 2022 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiGETEJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jul 2022 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiGETEH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2022 15:04:07 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD42201B1;
        Tue,  5 Jul 2022 12:04:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l24so12001449ion.13;
        Tue, 05 Jul 2022 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBoAduiOY3dTG1kjtzuuO2xA8vXJSUeY7/uBXp/jxVc=;
        b=peuQZQF4D+5LgZxEzu9M9xhXv9pEUthYyEY5UwjphfRdsw/ghYG7P4qTOLQFrb7GL8
         2TGq/YL55wGe1zH1giVdtJ34VlTMoSPM3DSDPYYSuZNqNJEl1EPvr4NuSawWUJWnGEeR
         8ODM22c853V6/War/ReZ1GGklutM1BITIHP0uKxqiP8smRud+8I3CpQxzFnUuiGdBhXc
         VL3iKJ42V0S+qDkzqPF066ZCJFHHJepBQw5hxZUHbK5yQI/OZ3ooCf9EVPAPKdbvRjMr
         yKsT9cvhf+A4oO3BT6zOVMOTMNHMFm/Weu2ud45WZPCKLp6lfYkAxFZgdVJ3V7e7sy0p
         /QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBoAduiOY3dTG1kjtzuuO2xA8vXJSUeY7/uBXp/jxVc=;
        b=5t1s+c4lPGUH3O8+/9X9HYT/xFU4ajljtLJhpvs0f0CGJqTZ6MhZTy1YFMxl76B6Lt
         JtId/dbAAT3nz6kQFxbkrZj2WioOx1rxYlv9YMds1Oveb6Bbcqr/SVcsPe5aqk7D61My
         95nD+qn7tzvpt+jyZUh1G/3855qsetkGEbxTd9on328frkz7ujj/4xhx6jYn14pCNTUF
         mvtWfOYTtp1WR4JEP93p42nNVtPPT3NPNn0PE/w/D3L/XVtoqJsaWj4/fcjRFRTrn7Ro
         I0KLM9QyqyfSmFp1DzNgrgmPx7aiwmxfhTnTyc6PE5Nn79UBDmx1FHdLgmUtEKGIF10d
         CIHA==
X-Gm-Message-State: AJIora+NiIwdhDkO4sfR1kZ6mgQQnQK4sTmODVb+ZL8xjQkwz0w17JJn
        fMajp1XJx9456mJMH49JZKjKntAiOlQ=
X-Google-Smtp-Source: AGRyM1uVaTNH6OA/7IqEsGDU2r4z3CJ879Ru/r55x9DwqxBa8O8i9zkHF/kctqNKKdgdePdN3cwmYg==
X-Received: by 2002:a05:6638:2596:b0:33e:e4e3:ce9 with SMTP id s22-20020a056638259600b0033ee4e30ce9mr4650798jat.16.1657047843973;
        Tue, 05 Jul 2022 12:04:03 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:a8dc:16da:96d1:2d19])
        by smtp.gmail.com with ESMTPSA id d93-20020a0285e6000000b0033efe01c20esm397762jai.42.2022.07.05.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:04:03 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
X-Google-Original-From: Chris Morgan <macromorgan@hotmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v7 2/3] Input: adc-joystick - Add polled input device support
Date:   Tue,  5 Jul 2022 14:03:53 -0500
Message-Id: <20220705190354.69263-3-macromorgan@hotmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705190354.69263-1-macromorgan@hotmail.com>
References: <20220705190354.69263-1-macromorgan@hotmail.com>
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

From: Chris Morgan <macroalpha82@gmail.com>

Add polled input device support to the adc-joystick driver. This is
useful for devices which do not have hardware capable triggers on
their SARADC. Code modified from adc-joystick.c changes made by Maya
Matuszczyk.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/input/joystick/adc-joystick.c | 51 +++++++++++++++++++++------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..2f4bd12d6344 100644
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
@@ -215,8 +231,17 @@ static int adc_joystick_probe(struct platform_device *pdev)
 	joy->input = input;
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
-	input->open = adc_joystick_open;
-	input->close = adc_joystick_close;
+
+	joy->polled = !device_property_read_u32(dev, "poll-interval",
+						&poll_interval);
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
@@ -229,16 +254,20 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
2.34.1

