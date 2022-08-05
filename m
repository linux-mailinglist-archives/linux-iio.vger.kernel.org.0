Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9A58AEAB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Aug 2022 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiHERK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Aug 2022 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbiHERK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 13:10:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51164F585;
        Fri,  5 Aug 2022 10:10:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u9so3270278oiv.12;
        Fri, 05 Aug 2022 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nwHryU0bZnt309RGGOE8P70CLHk18q0nOqSgqZBBh4U=;
        b=S9zGs8fsYEoYd4D3BNp4/n7jchmKkbi2ThFLepv76FDKXZxprLdYG/kwiRjid5p53y
         s1UJOQYijp3xNZvgmpphxKAh67V4KSEiSVMk5KpYAKE3WMOVWa879EgNrAYks7WntNId
         OK2Po+sfpbRmDryEhD8wrtek5e4vxiL9Pmdypt4VWHSGKJGXcPYQ/WV8Nb4SvnRti4bx
         y9l8MsO/xeNOHn6iyIkkcSvAdJXI/NeOhfyrKvZyDUQBUG2V2w8ob7FA//WukSlLcQcD
         EWkgFbfeMmiXi6p7AYW0c4qJCfYCVxqvcB+16P6qA1BtV190mA/2OmyPoDoSfKvcfmbC
         ZTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nwHryU0bZnt309RGGOE8P70CLHk18q0nOqSgqZBBh4U=;
        b=h67DpQ1AI3umoVw7m1L5R3cVDDByFIMw94fz6kRNlESpm1YQ8TBUY2auicB6AC6xLn
         Kmj34jZ8hQiPtSGIdWGEw2uH26ffiJ4oNC7SOKgqoB6s4JpxI7hOeMYpLJ78ZPTyDrDA
         TGSZz7grKHOPnYxlu48k9yyM+RDKA/J4P6dQV5VW/1KxOb/HlYJiGbYZg8S5nqlVoINR
         7AyRFmIikzTBdXVgLFKLB+/sO21VsrIlP8DE+bxYfEBzdWfhE9OjnN2qViWe0bo/ENfX
         XEWxEYEw71FRFXtEwNVyAqtv0sQrmS3g6ExMAemrRfCl1vq2xRb0g99sYFjwEUp0+jJ6
         wlwg==
X-Gm-Message-State: ACgBeo0VYeDo/UtoBihPmbNDmXu/p5RhCM9sCeRGIe4aVNZ/9ovTrfC9
        LlasuYFyLrRREFJXiWKKCVxXkkkHF4w=
X-Google-Smtp-Source: AA6agR5OkvP5Tp6ugZ1RX+TQ1iE2gbHX3JU6h+49ij0VCVhhmjdPMDCBo3i+zDaxdj6QymHDlPFpjg==
X-Received: by 2002:a54:4715:0:b0:342:b1b2:acfe with SMTP id k21-20020a544715000000b00342b1b2acfemr3080919oik.73.1659719426353;
        Fri, 05 Aug 2022 10:10:26 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r32-20020a056870e9a000b0010e046491f8sm794126oao.57.2022.08.05.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:10:25 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v12 2/3] Input: adc-joystick - Add polled input device support
Date:   Fri,  5 Aug 2022 12:10:15 -0500
Message-Id: <20220805171016.21217-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805171016.21217-1-macroalpha82@gmail.com>
References: <20220805171016.21217-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c | 44 +++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..77dfb7dd96eb 100644
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
@@ -229,6 +264,9 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	if (joy->polled)
+		return 0;
+
 	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
 	if (IS_ERR(joy->buffer)) {
 		dev_err(dev, "Unable to allocate callback buffer\n");
-- 
2.25.1

