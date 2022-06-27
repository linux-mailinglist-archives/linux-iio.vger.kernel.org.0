Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02255DF05
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbiF0WPA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiF0WO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:14:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4076251;
        Mon, 27 Jun 2022 15:14:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p128so11127009iof.1;
        Mon, 27 Jun 2022 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVB7C/5MkJDKS/sblnSL0zYrA4sSlEYmWcTFfszpEhg=;
        b=TxOJM9caTshAkFhOQbUcF0w0mLeCH5nQpb0YnnqrpaxJ1pmJUIxkF3GUtCgEJT/QvC
         WPDqgWsFODH6UVlDWe2nbpf2IQ0AzTPUPN+73MUExjkNa7ed/AAEjcHO23ofmSPLP45T
         MYyBxe5X7ank1Vepl0pKaZK3lG5MHFALAcbHh5K22ot0kq4HfnS7NiNLmQ1f7M183xa/
         BirG2ibkuRa+p4GOc/Rhl2w6Kn9EdYe57B4na2sLccI5tzyW6AB0XRLfLY7e62KwpYFs
         n9ItgjYUPPtZqolyGrgOZjNJVy0Mty6T6OzVbse4Lt5N3eACNq4iHi/6L9SrZ9cL/PeL
         qAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVB7C/5MkJDKS/sblnSL0zYrA4sSlEYmWcTFfszpEhg=;
        b=d1EioRorAD+pRfwexg5gsav/QeYwxIAoOFm1xqwUOJlsgwXBS1imFuiPTyME/TRzYV
         7yXJ/j5lYbh+kzZregg/L0iQ1/9zimHHz3AojGKKht5U3mJyg8ALCrrQZqqheJZALNg8
         c13+u5wBRiYEsMZPMR8uzWt8++rBDgQwu3XcCwqbeeFfag7DugRNVvfTUrEh00sJ/6w/
         GukMfeUKMYOoXQVZNr3GkP4tis5M3lCgrsfsASHKq82ZsekmHEw2nDDaPMV2nTZMJFot
         rJEqJx8H7hOdrbzmPhkh8YQ1LVaNcsEhrJKzAeOhrCqx6KKUh/+aNHTwGjv9s6RjvAsm
         y+tw==
X-Gm-Message-State: AJIora/dCredCtcJbhg8R0pLJUN0djMlFdpmMiSCVfWCkj9y9wwH9ukb
        BU9h/RFvvcwMpGRhdkFwNLj4AxDo/Qg=
X-Google-Smtp-Source: AGRyM1vRPf22f5qviQc3o4uheuTBsXJFExE6Cz/WDRuc0KTc+cCvhK4GF9pxaV6kaViaB+/XmayHAg==
X-Received: by 2002:a05:6638:13cd:b0:33c:84c0:1ac7 with SMTP id i13-20020a05663813cd00b0033c84c01ac7mr7276791jaj.83.1656368095078;
        Mon, 27 Jun 2022 15:14:55 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:7a85:cf35:f4b3:542f])
        by smtp.gmail.com with ESMTPSA id p7-20020a02b007000000b00339dd3976absm5255589jah.110.2022.06.27.15.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:14:54 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 2/3] Input: adc-joystick - Add polled input device support
Date:   Mon, 27 Jun 2022 17:14:43 -0500
Message-Id: <20220627221444.3638-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220627221444.3638-1-macroalpha82@gmail.com>
References: <20220627221444.3638-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c | 49 +++++++++++++++++++++------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..7e3c5083ec3c 100644
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
+	int value;
 
 	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
 	if (!joy)
@@ -215,8 +231,15 @@ static int adc_joystick_probe(struct platform_device *pdev)
 	joy->input = input;
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
-	input->open = adc_joystick_open;
-	input->close = adc_joystick_close;
+
+	if (!device_property_read_u32(dev, "poll-interval", &value)) {
+		joy->polled = 1;
+		input_setup_polling(input, adc_joystick_poll);
+		input_set_poll_interval(input, value);
+	} else {
+		input->open = adc_joystick_open;
+		input->close = adc_joystick_close;
+	}
 
 	error = adc_joystick_set_axes(dev, joy);
 	if (error)
@@ -229,16 +252,20 @@ static int adc_joystick_probe(struct platform_device *pdev)
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

