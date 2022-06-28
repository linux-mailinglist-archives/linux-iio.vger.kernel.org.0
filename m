Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5E55EDB9
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiF1TP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiF1TPI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 15:15:08 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC55B6E;
        Tue, 28 Jun 2022 12:15:07 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i194so13804445ioa.12;
        Tue, 28 Jun 2022 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVo7+DXyQxi73eOfnv2V979PsitDnvN1mrlQN40qb5E=;
        b=X39lEbxy8L1hbkkrIqrd19do6eZEZZKlQL34ZYzhRo3tQDsf7hjHlYIKpGbhIWA4Ru
         VWYv5AzSs5wikIOHeQpO7NzJp3NCnKzhRffiqWRPsO5Q1oxY4pDfi5JzmQBK79bRjBJm
         w7ckdNDd43kIQXxxmpO7bidGGjfd6N3tCnkP5AwDjbxAcZriMRhTXrPmeVODySFeSZqA
         wwbYc7/5S3SkaxECEQ7UeyvaogCTiAlKqKNXb/iaWcXTva8p51c7NKm7P5Km4zggEgex
         BeEQvGq6KnuPI6M6rN1Dbg8xcnmMHsYTZFDWCO6BFpLXbURqGFogzsNiwqyJa2la0aZI
         HGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVo7+DXyQxi73eOfnv2V979PsitDnvN1mrlQN40qb5E=;
        b=wSFoGFymGaUmsIPsjK9U90EGnOBEQ35xqZE1k8BkESMro+WrACprPEZsHBYAbMW4Vo
         tSMk4oekl/Vdsa6C0vESvYimvM+jGmpiqszFSoUDTuYN+7s9ZcDah92W7OVC1WB/39q/
         EDhMnWwk7/fjlNYCw8Q/GVWH1o1s6y7wBpJN8bYfn5dnPdZMM8FGSZooYoel+0ZOv1TS
         El/iy36NYiv2+jLqT3KhtRsRCEpRhhYoaHFW5jJfiOXRvFUpJ8EugSwCVmurBzRZ7dBm
         BLeOEmsO6U6gttzPxOwSw/i3GeHszXRKoMyHf6qCHa4CvickQK9Gcuj2VxSKDu4QJHTB
         Wy6w==
X-Gm-Message-State: AJIora/9Hu6hGA7bkwGdL6mKqmRBidSPX6QkYwfdi3Z7rbNNk0AfqhHC
        i7/kpAIAJBc9tLmrWopYAEJTZMZhgW4=
X-Google-Smtp-Source: AGRyM1sgL09VDiqSgeEEm5ubd1+MoFbIm5CeK2alfflHKWbL/MFgKbSUjo/L/6EeNSYwfPrSSJMGoA==
X-Received: by 2002:a05:6602:2e8e:b0:669:d5b1:3fc9 with SMTP id m14-20020a0566022e8e00b00669d5b13fc9mr10316935iow.210.1656443706557;
        Tue, 28 Jun 2022 12:15:06 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:5448:c223:9fa4:5f87])
        by smtp.gmail.com with ESMTPSA id c97-20020a02966a000000b0032b74686763sm6396009jai.76.2022.06.28.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:15:06 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v5 2/3] Input: adc-joystick - Add polled input device support
Date:   Tue, 28 Jun 2022 14:14:59 -0500
Message-Id: <20220628191500.69831-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220628191500.69831-1-macroalpha82@gmail.com>
References: <20220628191500.69831-1-macroalpha82@gmail.com>
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

