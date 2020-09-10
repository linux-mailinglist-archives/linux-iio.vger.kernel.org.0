Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE65264B81
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIJRjv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgIJRhI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:08 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F9722225;
        Thu, 10 Sep 2020 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759354;
        bh=JEW06y7qbjdix6iF0OHVUEjfJhAHopZUUAFHjSBar3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxzRkAiKyJHFmlqP1SSnItO+PSSIU6Jh5CJ7s3vKoxYEW/x4htUrxg7X4Af2tw8QR
         R6YrRdQf0V8lTqF+EgOVNOUfFapNqTqsTRc2KkRnBeRjOhgEwRW9Jvpr+z0anKkoA+
         9E3xAdeNnwcRGfqoqdxTCdNqhSSRratre4B5QIEQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 31/38] iio:proximity:as3935: Use local struct device pointer to simplify code.
Date:   Thu, 10 Sep 2020 18:32:35 +0100
Message-Id: <20200910173242.621168-32-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910173242.621168-1-jic23@kernel.org>
References: <20200910173242.621168-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This makes the existing code easier to read and will make the following
patch a little simpler.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index c339e7339ec8..4df8d53d65fb 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -352,19 +352,20 @@ static void as3935_stop_work(void *data)
 
 static int as3935_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct iio_trigger *trig;
 	struct as3935_state *st;
-	struct device_node *np = spi->dev.of_node;
+	struct device_node *np = dev->of_node;
 	int ret;
 
 	/* Be sure lightning event interrupt is specified */
 	if (!spi->irq) {
-		dev_err(&spi->dev, "unable to get event interrupt\n");
+		dev_err(dev, "unable to get event interrupt\n");
 		return -EINVAL;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -378,14 +379,12 @@ static int as3935_probe(struct spi_device *spi)
 			"ams,tuning-capacitor-pf", &st->tune_cap);
 	if (ret) {
 		st->tune_cap = 0;
-		dev_warn(&spi->dev,
-			"no tuning-capacitor-pf set, defaulting to %d",
+		dev_warn(dev, "no tuning-capacitor-pf set, defaulting to %d",
 			st->tune_cap);
 	}
 
 	if (st->tune_cap > MAX_PF_CAP) {
-		dev_err(&spi->dev,
-			"wrong tuning-capacitor-pf setting of %d\n",
+		dev_err(dev, "wrong tuning-capacitor-pf setting of %d\n",
 			st->tune_cap);
 		return -EINVAL;
 	}
@@ -393,8 +392,7 @@ static int as3935_probe(struct spi_device *spi)
 	ret = of_property_read_u32(np,
 			"ams,nflwdth", &st->nflwdth_reg);
 	if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
-		dev_err(&spi->dev,
-			"invalid nflwdth setting of %d\n",
+		dev_err(dev, "invalid nflwdth setting of %d\n",
 			st->nflwdth_reg);
 		return -EINVAL;
 	}
@@ -405,7 +403,7 @@ static int as3935_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &as3935_info;
 
-	trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+	trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 				      indio_dev->name, indio_dev->id);
 
 	if (!trig)
@@ -417,42 +415,42 @@ static int as3935_probe(struct spi_device *spi)
 	iio_trigger_set_drvdata(trig, indio_dev);
 	trig->ops = &iio_interrupt_trigger_ops;
 
-	ret = devm_iio_trigger_register(&spi->dev, trig);
+	ret = devm_iio_trigger_register(dev, trig);
 	if (ret) {
-		dev_err(&spi->dev, "failed to register trigger\n");
+		dev_err(dev, "failed to register trigger\n");
 		return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      as3935_trigger_handler, NULL);
 
 	if (ret) {
-		dev_err(&spi->dev, "cannot setup iio trigger\n");
+		dev_err(dev, "cannot setup iio trigger\n");
 		return ret;
 	}
 
 	calibrate_as3935(st);
 
 	INIT_DELAYED_WORK(&st->work, as3935_event_work);
-	ret = devm_add_action(&spi->dev, as3935_stop_work, indio_dev);
+	ret = devm_add_action(dev, as3935_stop_work, indio_dev);
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq,
+	ret = devm_request_irq(dev, spi->irq,
 				&as3935_interrupt_handler,
 				IRQF_TRIGGER_RISING,
-				dev_name(&spi->dev),
+				dev_name(dev),
 				indio_dev);
 
 	if (ret) {
-		dev_err(&spi->dev, "unable to request irq\n");
+		dev_err(dev, "unable to request irq\n");
 		return ret;
 	}
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0) {
-		dev_err(&spi->dev, "unable to register device\n");
+		dev_err(dev, "unable to register device\n");
 		return ret;
 	}
 	return 0;
-- 
2.28.0

