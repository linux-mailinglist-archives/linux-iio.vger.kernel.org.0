Return-Path: <linux-iio+bounces-12281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7A9C95E9
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D20D283D29
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B031C07C3;
	Thu, 14 Nov 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOOlXBn0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2C1BD4F1;
	Thu, 14 Nov 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625831; cv=none; b=uoLD0rFbs0DA2FhUAJ2E8/LJUnSa0F/CKkmaRv66YhCJhPHF6in3XgCfamALKe6/I1Z1x0BmZIGOCrTVyxQzWKe6jgeIt2JlFhgitsSa9HLFgd9lmdY13osNgex2LPXA0zrE8mztsa+JRwNqgkU78r25GjPEQ68qnybyvqlzCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625831; c=relaxed/simple;
	bh=Qe87npJOJ+/IaVN9tHz550rK0cIOqPjrDDeeKh3+79w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u47tKlQThFkl/W8vavwZedRh5L4mkEid9PPzVTpvbf0fjDSa/gk5hs0Ktv5Z88g7YGzw6V40Ucfk0MXDF/FUKrlAXGZqzsf0/CYrSknDTBiUzmXDABfvP+GPsg4dJTWUmGKgFY4jbmPcBbdyPtiKeRxPdWn7yKiAKjemgw5oVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOOlXBn0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso1070105e9.1;
        Thu, 14 Nov 2024 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625828; x=1732230628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5fLWgiG6X9Z8EV7WoH09eywkpTwsg6we3ZixqL9jKU=;
        b=OOOlXBn0vFhhoJLaOT//LtW90uInVvAQ2Et/plvid0N1Xs64vc8DwmM699lDyldb/n
         5X8JsLOdZr1WLZ5aS06SpWtPei4AMKaZZ+bdgoj+HrsLZAL2SsqNu7DqdEb6ywffEgm4
         0QImLavKjFuBRL6NJ2QD3J2PKewyKH+MFjiHuSqrgX78sq06Dru9TJL4bqZUBsJac+oE
         n3MTBCl/KUS3BRIVGIHrhBVmX9JrslXaXaEguLYU4MiKmfYmRwHqhsAB9pIs8ZfURf0k
         QxtO5LIx2kV+dVaT+oiTlnoTbJBw5AXpIoW0h4ggLIZGt7UAIWd3hrSC3byLRPIomHhu
         /Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625828; x=1732230628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5fLWgiG6X9Z8EV7WoH09eywkpTwsg6we3ZixqL9jKU=;
        b=cAD3Fh49JbpNJMr1oVsZYyrsqcVEweMov3nPqWmV9To0VhimbNw8QLvILFCf2eaqVD
         QXM6e9jZMa+YMg/Qs9q4iBaVwD9h42mBY0AI3MsrzvgHCTnnVvGqFRdzqNwYEJWUVqL8
         NIOVOREaQ2ln3LrHve7ked0RIuQCkKRQQKfgAGqpBEpY/KS30AodVRHRu32c+QLXGMEZ
         hqk+Rr/Zs2o0WSmodBSMMwzbXUOfxOJiG8oTxkL0XFQdo34vlRmxSgaYsF8wgQwTNqSw
         J28uGzJkxWEYaC1Mv00nG3+wgeVv4heAd83vcNEu17hLQ/mljNSjm9d84TloMZ08pb22
         8zgw==
X-Forwarded-Encrypted: i=1; AJvYcCXCDG/qpfiK34xwKoj5dc0sjjXZ4Ak1P0ASk0M1S8VzJWk4v9fP6/Q0GnY25OFwiBql5T4mmfDM754YDpRl@vger.kernel.org, AJvYcCXQcDKFaRoj5yoDOPP3cQfWo7dYN2spcA5PvJBKhKQMqGF5QpLueabSJL38NH2w60ZbHsTtoSj1IbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRaKMGvFL4fu9JWeP1ok2chfXAiSrUHLSjNQIMgdw+aiCrfBMT
	tyc0dkkJwYdLQ9dpJD6xTIr3NwEEAFZaUyeAf1cdifYVDLNGONMM
X-Gm-Gg: ASbGncvlVDLbCFjkRCkO2EOiptxp3sJ4mMpleKidq+lkYiDVlNMTXj6+PaIAO9tmxLy
	hlCKUHdOVFjRpWrnJaiuDFsNjmGuiuDEFbftU5XmmU5QwCVI6ZFyuyvIxjrM0ECQzD/aK1L7z38
	UByXZOXBv/uXLmVLyG1cUgQMvSG5DSbep0+YiPtLrbxa3MgY/SXAVf1WcDfDKfZw/oVb6DbpTsL
	Vm130Az9RJIFGFFJ7TpFqs+H8Gu0tAEM5E4YqdP2h8Pu6zd1YCb7xiXGHSdF0FG1IujGmY98QmX
	DxYvSM+dC4HZanJY0pi6Hmw+koA0
X-Google-Smtp-Source: AGHT+IHTDVs5sk34sIs2Md1tJEYvnpBZX6JiMRYXVtnpy7VaMS2MbG0JvK6Q9ftI01DOLCZCREuPLw==
X-Received: by 2002:a05:600c:354b:b0:42c:aeee:80b with SMTP id 5b1f17b1804b1-432df797e02mr1637045e9.8.1731625827978;
        Thu, 14 Nov 2024 15:10:27 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:27 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 13/22] iio: accel: adxl345: add trigger handler
Date: Thu, 14 Nov 2024 23:09:53 +0000
Message-Id: <20241114231002.98595-14-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic setup to the interrupt handler function and prepare probe
for using and not using the FIFO on the adxl345. Interrupt handler and
basic structure integration is needed to evaluate interrupt source
register. This is crucial for implementing further features of the
sensor.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 106 ++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7e607534df..dbd07308a7 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -15,6 +15,9 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <linux/input/adxl34x.h>
 
@@ -137,6 +140,7 @@ struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
+	u8 int_map;
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
 };
@@ -300,6 +304,10 @@ static void adxl345_powerdown(void *ptr)
 	adxl345_set_measure_en(st, false);
 }
 
+static const struct iio_dev_attr *adxl345_fifo_attributes[] = {
+	NULL,
+};
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
@@ -313,6 +321,76 @@ static const struct attribute_group adxl345_attrs_group = {
 	.attrs = adxl345_attrs,
 };
 
+static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
+};
+
+static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
+{
+	int ret;
+	unsigned int regval;
+
+	*int_stat = 0;
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
+	if (ret) {
+		pr_warn("%s(): Failed to read INT_SOURCE register\n", __func__);
+		return -EINVAL;
+	}
+
+	*int_stat = 0xff & regval;
+	pr_debug("%s(): int_stat 0x%02X (INT_SOURCE)\n", __func__, *int_stat);
+
+	return 0;
+}
+
+/**
+ * Interrupt handler used for several features of the ADXL345.
+ * - DATA_READY / FIFO watermark
+ * - single tap / double tap
+ * - activity / inactivity
+ * - freefall detection
+ * - overrun
+ *
+ * @irq: The interrupt number. Having an interrupt imples FIFO_STREAM mode was
+ * enabled. Since this is given there will no be further test for being in
+ * FIFO_BYPASS mode. FIFO_TRIGGER and FIFO_FIFO mode (being similar to
+ * FIFO_STREAM mode) are not separately implemented so far. Both should be
+ * work smoothly with the same way of interrupt handling.
+ * @p: The iio poll function instance, used to derive the device and data.
+ */
+static irqreturn_t adxl345_trigger_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = ((struct iio_poll_func *) p)->indio_dev;
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	u8 int_stat;
+	int ret;
+
+	ret = adxl345_get_status(st, &int_stat);
+	if (ret < 0)
+		goto done;
+
+	/* Ignore already read event by reissued too fast */
+	if (int_stat == 0x0)
+		goto done;
+
+	/* evaluation */
+
+	if (int_stat & ADXL345_INT_OVERRUN) {
+		pr_debug("%s(): OVERRUN event detected\n", __func__);
+		goto done;
+	}
+
+	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK))
+		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
+
+	goto done;
+done:
+
+	if (indio_dev)
+		iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info adxl345_info = {
 	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
@@ -349,6 +427,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	const struct adxl34x_platform_data *data;
+	u8 fifo_ctl;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -417,9 +496,32 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
 
-	/* Enable measurement mode */
-	adxl345_set_measure_en(st, true);
+	/* Basic common initialization of the driver is done now */
+
+	if (st->irq) { /* Initialization to prepare for FIFO_STREAM mode */
+		ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+							  NULL,
+							  adxl345_trigger_handler,
+							  IIO_BUFFER_DIRECTION_IN,
+							  &adxl345_buffer_ops,
+							  adxl345_fifo_attributes);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
+
+	} else { /* Initialization to prepare for FIFO_BYPASS mode (fallback) */
 
+		/* The following defaults to 0x00, anyway */
+		fifo_ctl = 0x00 | ADXL345_FIFO_CTL_MODE(ADXL_FIFO_BYPASS);
+
+		dev_dbg(dev, "fifo_ctl 0x%02X [0x00]\n", fifo_ctl);
+		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
+		if (ret < 0)
+			return ret;
+
+		/* Enable measurement mode */
+		adxl345_set_measure_en(st, true);
+	}
+	dev_dbg(dev, "Driver operational\n");
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
-- 
2.39.2


