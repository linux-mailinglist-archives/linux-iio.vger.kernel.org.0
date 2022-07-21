Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4672B57D1DB
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jul 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiGUQqQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jul 2022 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiGUQqO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2022 12:46:14 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400388102;
        Thu, 21 Jul 2022 09:46:12 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10cf9f5b500so3154971fac.2;
        Thu, 21 Jul 2022 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bn5dzO1DvZMCQuqiDHL4eb767GRAGDv6mTm1J8YKIeM=;
        b=LdRjmKVLwSjr+016c5CwB8eUtqczUA+1PZno6U3lYFMfWQ7yuU/xR52SAF6wjBXKF0
         6zMdoeWS3NL+WNSbIN1T1F4vAt0hWC4898rm8Xijqq1yAbShU2DtQOECIDtmW2kBAtuQ
         skMTBK4lZ/QEKHCEMgUlh80hxrNqnAkpjFzzPRWDn0XBWmMpgRDL4CyJeXeFD28u0xn9
         BvkUIX+d+Mc5/M3peQx8QFH4eFFPowjsiQHYXJ8OadL1XReNsG9A/B9P/5z888/5AnY2
         ziwxbtRd0CMpxIIZB2ijts34aZgooDiIftgFdZd/0S3oqKXmbYFKzkYCMiAdLXlRA5Ao
         ITLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bn5dzO1DvZMCQuqiDHL4eb767GRAGDv6mTm1J8YKIeM=;
        b=sMEctI+cICTy/8yWCVfpW+aSaEdLmJIOe5JRvMzd/g6ltZrIR/eNNW/ixZEje1e9ys
         89qY9ciy0Mfq1BucLmGqlK+w3LDbOrzFmu1yTwJWJCPweFjwmbqBHlg85HSLIrXJmh3X
         ywv0kVOjazW3IHE1Dgq7PqImCjRTJ8P/YK9+tRG/uAJ4qe6BUAainSQw8ousoqjktO7R
         ZZ80S43djYdcIGXo3JFFtZEFhPXPVj4L6Iyy4W1uja0BqErCP9hAcCHGyn4PbLTcLJAw
         SyZihAnWwY4DiZEV3Z1DshlEiXiijpSy9jpYK+HcwbG1boxavlo2AeJHDzzbHa2chrJu
         Fe8Q==
X-Gm-Message-State: AJIora8MrM4QGfnXtYmLs0DMCv0WyN5WECPq9AF9zpTSiSbitpy3Y6L6
        qh5kPCIGzBnZag6v8ac2va8Jmxbrk60=
X-Google-Smtp-Source: AGRyM1ss7FtGgsBlwnStWCgP6CQbgLH1iXm55RRErUI/60rXXvKKYIMpYUrn4hNw/0I54OQHfClyBw==
X-Received: by 2002:a05:6870:c391:b0:10c:a937:aaf1 with SMTP id g17-20020a056870c39100b0010ca937aaf1mr5520749oao.272.1658421972047;
        Thu, 21 Jul 2022 09:46:12 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id f189-20020aca38c6000000b0033a45705cb2sm831512oia.8.2022.07.21.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:46:11 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        contact@artur-rojek.eu, jic23@kernel.org, paul@crapouillou.net,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v8 2/3] Input: adc-joystick - Add polled input device support
Date:   Thu, 21 Jul 2022 11:46:02 -0500
Message-Id: <20220721164603.13534-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721164603.13534-1-macroalpha82@gmail.com>
References: <20220721164603.13534-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c | 82 ++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..085b8e10dfb5 100644
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
@@ -178,7 +193,9 @@ static int adc_joystick_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	int error;
 	int bits;
+	int chan_storage;
 	int i;
+	unsigned int poll_interval;
 
 	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
 	if (!joy)
@@ -192,16 +209,31 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
+	/* Count how many channels we got. NULL terminated. Do not check the
+	 * storage size if using polling.
+	 */
+	chan_storage = joy->chans[0].channel->scan_type.storagebits;
 	for (i = 0; joy->chans[i].indio_dev; i++) {
-		bits = joy->chans[i].channel->scan_type.storagebits;
-		if (!bits || bits > 16) {
-			dev_err(dev, "Unsupported channel storage size\n");
-			return -EINVAL;
-		}
-		if (bits != joy->chans[0].channel->scan_type.storagebits) {
-			dev_err(dev, "Channels must have equal storage size\n");
-			return -EINVAL;
+		if (!joy->polled) {
+			bits = joy->chans[i].channel->scan_type.storagebits;
+			if (!bits || bits > 16) {
+				dev_err(dev,
+					"Unsupported channel storage size\n");
+				return -EINVAL;
+			}
+			if (bits != chan_storage) {
+				dev_err(dev,
+					"Channels must be equal size\n");
+				return -EINVAL;
+			}
 		}
 	}
 	joy->num_chans = i;
@@ -215,8 +247,14 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
@@ -229,16 +267,20 @@ static int adc_joystick_probe(struct platform_device *pdev)
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

