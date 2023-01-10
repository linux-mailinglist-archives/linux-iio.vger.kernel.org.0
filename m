Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62F7664222
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jan 2023 14:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjAJNoN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Jan 2023 08:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbjAJNnu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2023 08:43:50 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF4F5A8AE
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2023 05:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358216;
  x=1704894216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccDY6TQH7ztz7Bhj6c1RPWzUK3yPpHu/cwy0/O5YPbE=;
  b=mKZwJDQ7EM5G66cVZQYoWlkg6HQDtQLLi8HMNYnaEo/wGCRKWxMEi4/S
   YN32yY2H26s4ezuRn8EQs130MVyUVM9nEpo6fyNYwwdEMHxCfoL/Bxl8B
   2BBIF4PQwYdjBqjtUWZi2eCToh6u3vKUzhINQG3mG2s1DEaUUhMdas/Mk
   AV1kpGG4lP19TdoL5SlegCi0QkOsT6AihJX4vSx4AKoYA88ch/5jBlXSy
   rq/amii8dlE1SBuSfWjsdS13UWiWiA0m4eCCGGVCOujmvDEUUJRgw9l8v
   9xrMZc8aUypR54LFNRKCiphtg3JHnf7VJX8u4YRj0zrwJZF5dnkITt46F
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3 2/3] iio: light: vcnl4000: Make irq handling more generic
Date:   Tue, 10 Jan 2023 14:43:22 +0100
Message-ID: <20230110134323.543123-3-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230110134323.543123-1-marten.lindahl@axis.com>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver supports 4 chips, by which only one (vcnl4010) handles
interrupts and has support for triggered buffer. The setup of these
functions is hardcoded for vcnl4010 inside the generic vcnl4000_probe,
and thus ignores the chip specific configuration structure where all
other chip specific functions are specified.

This complicates adding interrupt handler and triggered buffer support
to chips which may have support for it.

Add members for irq threads and iio_buffer_setup_ops to the generic
vcnl4000_chip_spec struct, so that instead of checking a chip specific
boolean irq support, we check for a chip specific triggered buffer
handler, and/or a chip specific irq thread handler.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 52 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 11b54b57e592..792fc7f9c36e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -150,11 +150,13 @@ struct vcnl4000_chip_spec {
 	struct iio_chan_spec const *channels;
 	const int num_channels;
 	const struct iio_info *info;
-	bool irq_support;
+	const struct iio_buffer_setup_ops *buffer_setup_ops;
 	int (*init)(struct vcnl4000_data *data);
 	int (*measure_light)(struct vcnl4000_data *data, int *val);
 	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
 	int (*set_power_state)(struct vcnl4000_data *data, bool on);
+	irqreturn_t (*irq_thread)(int irq, void *priv);
+	irqreturn_t (*trig_buffer_func)(int irq, void *priv);
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -1121,7 +1123,6 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.channels = vcnl4000_channels,
 		.num_channels = ARRAY_SIZE(vcnl4000_channels),
 		.info = &vcnl4000_info,
-		.irq_support = false,
 	},
 	[VCNL4010] = {
 		.prod = "VCNL4010/4020",
@@ -1132,7 +1133,9 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.channels = vcnl4010_channels,
 		.num_channels = ARRAY_SIZE(vcnl4010_channels),
 		.info = &vcnl4010_info,
-		.irq_support = true,
+		.irq_thread = vcnl4010_irq_thread,
+		.trig_buffer_func = vcnl4010_trigger_handler,
+		.buffer_setup_ops = &vcnl4010_buffer_ops,
 	},
 	[VCNL4040] = {
 		.prod = "VCNL4040",
@@ -1143,7 +1146,6 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.channels = vcnl4040_channels,
 		.num_channels = ARRAY_SIZE(vcnl4040_channels),
 		.info = &vcnl4040_info,
-		.irq_support = false,
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
@@ -1154,7 +1156,6 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.channels = vcnl4000_channels,
 		.num_channels = ARRAY_SIZE(vcnl4000_channels),
 		.info = &vcnl4000_info,
-		.irq_support = false,
 	},
 };
 
@@ -1214,31 +1215,36 @@ static int vcnl4000_probe(struct i2c_client *client)
 	indio_dev->name = VCNL4000_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (client->irq && data->chip_spec->irq_support) {
-		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
-						      NULL,
-						      vcnl4010_trigger_handler,
-						      &vcnl4010_buffer_ops);
+	if (data->chip_spec->trig_buffer_func &&
+	    data->chip_spec->buffer_setup_ops) {
+		ret = devm_iio_triggered_buffer_setup(&client->dev,
+						      indio_dev, NULL,
+						      data->chip_spec->trig_buffer_func,
+						      data->chip_spec->buffer_setup_ops);
 		if (ret < 0) {
 			dev_err(&client->dev,
 				"unable to setup iio triggered buffer\n");
 			return ret;
 		}
+	}
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
-						NULL, vcnl4010_irq_thread,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						"vcnl4010_irq",
-						indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "irq request failed\n");
-			return ret;
-		}
+	if (client->irq) {
+		if (data->chip_spec->irq_thread) {
+			ret = devm_request_threaded_irq(&client->dev,
+							client->irq, NULL,
+							data->chip_spec->irq_thread,
+							IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+							"vcnl4000_irq",
+							indio_dev);
+			if (ret < 0) {
+				dev_err(&client->dev, "irq request failed\n");
+				return ret;
+			}
 
-		ret = vcnl4010_probe_trigger(indio_dev);
-		if (ret < 0)
-			return ret;
+			ret = vcnl4010_probe_trigger(indio_dev);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
-- 
2.30.2

