Return-Path: <linux-iio+bounces-12356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C919D051B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05391280936
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A51DDC34;
	Sun, 17 Nov 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbEdO3+U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F81DDC02;
	Sun, 17 Nov 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868113; cv=none; b=Fwag4qvhMAzrTYkdojtS5ihbrVEuaH4Nlgj+KmDfOr7MrZtYR/nGYfHvGrqyUPH0SsYO6T7t4a2/9HIdkbbZXMLRCUvaC09vx9r3SzwNpZ655QlvUvcqbmGYqL1lMKeFdGmJofYZw0QEL0CBnmOE01jCFnnTJFGBhh7/aRkORTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868113; c=relaxed/simple;
	bh=JxslxY6nz+N7Qayo8xOOBDlH/hySO0/OoVvaLU8Mq64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxkJogHL1uVP1Q66RaegcaGWK0GPA5K6a0ZA6ZBmBzvmfFm97SuWU7i7fJAq4fnnLY600BId4/wfJduJgSQ6N9yg+mFbTNVblah9QgpS/069R1XzoCOFZkYnMN03Ik0IFH64TRMNMrMNc6wegph/OsNn5LohKYvsPFlBa77GfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbEdO3+U; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38233152c8fso81020f8f.0;
        Sun, 17 Nov 2024 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868110; x=1732472910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpE9m38atunxHDylQkGqfI57mWJ+meMxLZ5550/ySnA=;
        b=NbEdO3+UOyWA0+yobEgV+zfhn7tbt6c+1HjG5jSrDIoAbTsPD9pCWbB0bx7EzinIat
         dPVkXvhnUxRUTlpQIXz9jzzK61hbClzHe7xa2l+xi7LFb/7cTzXE3B3Ve+1Woyl4OoOd
         w8Tc+sgVzsJNDK1sg978yvn1dtsKk0dL4oy+VYDicRbCVFRdFsAlPO9vIMXlqVK30Cb7
         yZ9F9pLVlf73dAvZQRauhZKQAGONxBN+Eh4vF9VvwGOyUXisXaZU+Sw3PEETSTrTKiz6
         Lvrj5FNftu+DGmP+oSyghjeCz0p78wAG7GMHgY/g3UIfB0E32aiYo3nR8jmxnAE73BnI
         ODnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868110; x=1732472910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpE9m38atunxHDylQkGqfI57mWJ+meMxLZ5550/ySnA=;
        b=DeSB0VYaASKSaiEFNukcmP+qPGMW7Zju7Kcl4rCiMBCHmkfGE0azVaVaY4ZhDOse63
         wMnd2Y0TheVDcypk5FmZDagYLmzm8qzo3USByZ58rD78iHy5QV284sU0O6V/WPAOJTQy
         2bEMnq3wlN9Nb/c9ScC7u8ZrS8ypbCGYIRlOn8dTQ0dDbOVi+fFEsWX2n2LDHKTDjDfl
         +d9JjGpjAzjzO70XsIZExuh3HMdnxAcCZjZbeE37llRJQWEJfvRfGYy9rvxRYwxDCODU
         4m0vxd4XvBvnIF5JbidNJkkXeJgvEouLLdt/XTSnWcut/s547+iwtfz5IRkAheEhLiuj
         RaGg==
X-Forwarded-Encrypted: i=1; AJvYcCXL9hQjKQSChqXaRM31zoYCq9k7eweXjGA5DrnxWyKnEZrsMcBS6WVSK+aVgBVjS/jbKoAcqCLYCMbNiMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHT4pSTAd6Os34MKQxyURVMyqFVIwgQudyLyWueZRHxOKpY53
	7U10bZ/SJ4y7qeBgVvmYyNl1CW9VSvT44mJbR/ZjNo+5TYKuwrO1
X-Gm-Gg: ASbGncuWg7R6ohpX9OMaezMMZBMwOT1wTvI9Dny7bB7t1lCAV8QwmljRLK5L9FqaZNB
	qQEtjtVb2iXsVtlNtmVgb35Dxu2ruM5545APFAAK6VToaMu9fDo6IWvnUH6oQJalw5mWo1vbZaz
	Vv4vH29Earc9+Xh5GXY0kh09rLYExMdD/c3JOvHdsefQZeGGXUoLylVN+4tMo63tPRr3/Jh3Lqi
	vKqPwlDhQ80nR+wST8kUeoD8kEs1Mj3umR6Yy2cr+t0WZZj3jl4aZosujdEiqetB/4/EMzT8cCG
	FU/f2Xecy5pThvRuQZRX3qPVnrYT
X-Google-Smtp-Source: AGHT+IGw1VMqflB5rOHmMnXMDL+5jOjGPU5J8rgylmSUrJsFU4qhtt/V63HzL2Vs85RlwocOlM4l3Q==
X-Received: by 2002:a05:6000:1acb:b0:37d:52cc:c484 with SMTP id ffacd0b85a97d-38225a85c5fmr2813494f8f.9.1731868109574;
        Sun, 17 Nov 2024 10:28:29 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:29 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 13/22] iio: accel: adxl345: add trigger handler
Date: Sun, 17 Nov 2024 18:26:42 +0000
Message-Id: <20241117182651.115056-14-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 105 ++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index f98ddef4c5..508de81bb9 100644
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
@@ -302,6 +306,10 @@ static void adxl345_powerdown(void *ptr)
 	adxl345_set_measure_en(st, false);
 }
 
+static const struct iio_dev_attr *adxl345_fifo_attributes[] = {
+	NULL,
+};
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
@@ -315,6 +323,75 @@ static const struct attribute_group adxl345_attrs_group = {
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
+ * irqreturn_t adxl345_trigger_handler() - Interrupt handler used for several
+ *                                         features of the ADXL345.
+ * @irq: The interrupt number.
+ * @p: The iio poll function instance, used to derive the device and data.
+ *
+ * Having an interrupt imples FIFO_STREAM mode was enabled. Since this is given
+ * there will no be further test for being in FIFO_BYPASS mode. FIFO_TRIGGER
+ * and FIFO_FIFO mode (being similar to FIFO_STREAM mode) are not separately
+ * implemented so far. Both should be work smoothly with the same way of
+ * interrupt handling.
+ *
+ * Return: Describe if the interrupt was handled.
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
@@ -351,6 +428,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	const struct adxl34x_platform_data *data;
+	u8 fifo_ctl;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -419,9 +497,32 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
2.39.5


