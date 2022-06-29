Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6217560C4E
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 00:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiF2W3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jun 2022 18:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF2W3u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2022 18:29:50 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7CD117;
        Wed, 29 Jun 2022 15:29:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r133so17458697iod.3;
        Wed, 29 Jun 2022 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVo7+DXyQxi73eOfnv2V979PsitDnvN1mrlQN40qb5E=;
        b=Ln2+54UcaNqgRmSN+xlJ47bbYr7xeUeYdHyVyI3jmVUk/oI75lUzFiRd9ySk/uQuEp
         iy89UVQx7GWGfEHY3/PDrNHIYOGrrjG8GkJW01qgnv9JlMXQT6cgL9Js0bJXXohtSDeK
         YzKTvNR5+HY9jltv/YWaoGvebQITe73KjytEsFkVW/R6ZIQeJ/Eych7eQjBLeo6Q3Df/
         M1YbvR5+rJSRhKhGS9nlAaO5HALwAv7uWM8NmoVmdHK0YAG53BjX9q6q07ASpIaunYUd
         AadAHA9lof6Pl/jDjxVJioIaceppGZFTEMOs6slgEE9AracySIHMjQtZTQDhAo15X8LA
         GHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVo7+DXyQxi73eOfnv2V979PsitDnvN1mrlQN40qb5E=;
        b=4npp+f9tqoMnoXG5Ltf3d/ndZKnMWuxVN/RWZqwmWwYifLtXXGGXlAAmDbWdojU2lF
         UrUVFgcIoAkioCmhh6NmHQ/3jLIsXanQrlrsJ8J9KWoUI03xsnjpzOMTy9DEZeam+K3E
         gp2h/xSqZD2fUYrn/QjNj/ySFfLdpem2SRzvtzwPq5klM5KGdUBAdIXSkp/D2Fqf6pRp
         WMmv/thGtZlyBZrjCBh6XIpwAqEBG1eeZ2ebcm3t1V9Y4CEMJFO4HbDHqgXxT7IKIsuq
         m3N+hUHJDVSUrg9hJmlRUVmHAtiiaZKpY/PGCDwnzAudC7IDSMhuJjiJOP7XKaYKeEsl
         CrvQ==
X-Gm-Message-State: AJIora+agD6+NJqKY9hz/FgAsNqiDudTJDC5n8tQESloNHYCYJvbqd6n
        UzbJ8j3A4PgYMscxoqYP/GCQX4WPfiQ=
X-Google-Smtp-Source: AGRyM1usQ3nvh7WnzCe9WTvh5nuNFzQWQ3fi6AtY4mRGfQfyLpXyPcLKcwkCZu8eHfSGt8kdQMqdIg==
X-Received: by 2002:a05:6638:3a0a:b0:339:ec66:febd with SMTP id cn10-20020a0566383a0a00b00339ec66febdmr3146723jab.313.1656541788742;
        Wed, 29 Jun 2022 15:29:48 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:2d4b:b7b2:944:3519])
        by smtp.gmail.com with ESMTPSA id ca19-20020a0566381c1300b0033158c4a312sm7845597jab.55.2022.06.29.15.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:29:48 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v6 2/3] Input: adc-joystick - Add polled input device support
Date:   Wed, 29 Jun 2022 17:29:29 -0500
Message-Id: <20220629222931.30599-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629222931.30599-1-macroalpha82@gmail.com>
References: <20220629222931.30599-1-macroalpha82@gmail.com>
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
index 78ebca7d400a..e52f8b2b5563 100644
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
+	joy->polled = !device_property_read_u32(dev, "poll-interval-ms",
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

