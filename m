Return-Path: <linux-iio+bounces-13126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0BB9E5CC2
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59531883355
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2020E22E3E4;
	Thu,  5 Dec 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz34ODfe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DBD22D4D0;
	Thu,  5 Dec 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418849; cv=none; b=io/I5hkNUzvwo5nS4tglgz3O8QJcV5ABjxoVBea6NOIOWDWV18eJqT53V83RSzTc+N30Hcjsl1yclNiv2JlvNcoinRFPAj0YqGdpeoo7j+nEvrW9KplxmZpGzhH3ZvTQT96wsuNMeHyFj3xgtkMXRAqWu2BoUuUgkTV//YAhyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418849; c=relaxed/simple;
	bh=ouiB3B4vc2uXHgZKY7KoVBDYrYDMYIWxcrixINDjfB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyS2DTvSFTg0Xy1nJ9/h5Mho7QZhs04+DrMyX/cAGZIWeG5ejqRiYnazlpva1IJseTyFxcacaifasGVnlbQvtm17J6/mP8uRk9cbo0tAdB0P0i2DnhbyadAe15pEp8qNKv03luiHXcF98IJSe4VHFpFJCLqIFg6R11el/Tx9NJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz34ODfe; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0d40fba2dso179498a12.1;
        Thu, 05 Dec 2024 09:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418846; x=1734023646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19cmypSDvl2qvZse+lbr7CC+6tE6QkbEy/nf+fZunuI=;
        b=Hz34ODfeUo5h8AU3xegkLZ5Go7nXkXw4Iii1y58ma5hhKHnPoH51QTq4jHwy78nWUt
         apHHnp2wU9HpxnCXQ1p7txrYY3IoZ83E1FPSyMwZKD+v0Xxj8GOV8yUYTgN/mhpNRvtG
         VSypPZl1Yhvoy1s2C4VIZfXuL9uuWUePHSQ/x/UYbSJS1RZb9yx8qlfzRtMkpgNIDe0m
         CQbwNa+T4LQzbNwvrglajouAm+6NkAl45niI2AAUjQZeAFzDEqtZIyCPjCKxSHKueiAs
         edhcbpe31jmbwG1cOpp7peiha+b3XeSUvnfZ+xmU9XRhWm41m6riCkqweRW4pCqbnnLe
         ZtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418846; x=1734023646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19cmypSDvl2qvZse+lbr7CC+6tE6QkbEy/nf+fZunuI=;
        b=YSWa0scPfd3GvzoB3YO+ZvvTahLhLrs+mHVxknsj9cMnfzc3C/E+z4Xg84ud+SO0I1
         1FCNqinGuVMiwc28beGP7hvW4aN8/Lg934uwmvUTMDNRtn8Ur81IEYn4s0zrBiGbQVdi
         L8vu1eYEMG23JjCy3cr2eX3dFR7P1GPS8BY5XCFdXKW1e/oydmquy3MgWccQzIuRWPEe
         xVK32dWro/ehXVyMbid3cL7TeeuFPCOF4HRFG/RfAT2PbuNuswtORKlWLExxSZ8174Yl
         Ll6FlqaBDQggP2lNTu23W5wkIeJVEwcuiaDDF8OKi3n81pxuDRFtrg6jZMfGC39JWuRN
         +7AA==
X-Forwarded-Encrypted: i=1; AJvYcCWD8Fpwi1Qiw88mWvRkK57BWL50MskuXHF0NM0gaXClYo5yrhlw0+zLuwHlBBKf3rwNffZo8z82vZ4=@vger.kernel.org, AJvYcCWTXRno5uyu4h0eKH/waADbyrqag3M/JZHrBlRG50pwaYFT3JknYQIuVXhRT6PNRx4dFPmAJQVEvVEbSaks@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkf3LDh/M/VVarotm+0sTD5FMowhHBzJ7LBs/zgHaCA+CNzh8R
	LWX8CPv85zg1ePJqJSl67UHbBEVX9XUfsSkHhVzKsIUh6X1Rpfb9
X-Gm-Gg: ASbGnct7qE5btce1lqhuHlx9RmNb0pGNiaqgIezG1NLh4xDVvAOt56aS36ThsxjkSlx
	Squtj7jXC5jh9/tplM6rP1UYr3LSc3xxX5trdstVT7jcqviAH2VuqIYPsbxv7DXKXA2id5HLtic
	uhulD7AdN2P+f7ZIHGZoYufcXjJqX56ruxLqQS9k1iKx2Di7xhksh/3sg/rzjvK47haupekZF60
	2wrFXqo/CESGh9WpwtQk3OXO/WjCfZ5WL1b0DP0rbJQkOVO6GykC+OwbUm9D76Wh/LW1m5HiWMy
	uJiVHKefb3OK35YE5PFYC51g5Ri+
X-Google-Smtp-Source: AGHT+IFdZZt/TG/R335JOuTpNAFCstOddX9DIG64BNbltmsV29VyaaQJgub+2dsNzOEwa/FtPfz4OQ==
X-Received: by 2002:a05:6402:27ca:b0:5d0:8111:e958 with SMTP id 4fb4d7f45d1cf-5d10cb99badmr4186728a12.9.1733418846016;
        Thu, 05 Dec 2024 09:14:06 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:14:05 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark events
Date: Thu,  5 Dec 2024 17:13:43 +0000
Message-Id: <20241205171343.308963-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic setup for FIFO with configurable watermark. Add a handler
for watermark interrupt events and extend the channel for the
scan_index needed for the iio channel. The sensor is configurable to use
a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode now
a watermark can be configured, or disabled by setting 0. Further features
require a working FIFO setup.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 300 +++++++++++++++++++++++++++++++
 1 file changed, 300 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 3067a70c54e..58ed82d66dc 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -15,15 +15,28 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/kfifo_buf.h>
 
 #include "adxl345.h"
 
+#define ADXL345_FIFO_BYPASS	0
+#define ADXL345_FIFO_FIFO	1
+#define ADXL345_FIFO_STREAM	2
+
+#define ADXL345_DIRS 3
+
 struct adxl345_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE];
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
+	u8 int_map;
+	u8 watermark;
+	u8 fifo_mode;
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -36,6 +49,13 @@ struct adxl345_state {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 	.scan_index = (index),				\
+	.scan_type = {					\
+		.sign = 's',				\
+		.realbits = 13,				\
+		.storagebits = 16,			\
+		.shift = 0,				\
+		.endianness = IIO_LE,			\
+	},						\
 }
 
 enum adxl345_chans {
@@ -48,6 +68,25 @@ static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(2, chan_z, Z),
 };
 
+static int adxl345_set_interrupts(struct adxl345_state *st)
+{
+	int ret;
+	unsigned int int_enable = st->int_map;
+	unsigned int int_map;
+
+	/* Any bits set to 0 in the INT map register send their respective
+	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
+	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+	 */
+	int_map = 0xFF & (st->intio ? st->int_map : ~st->int_map);
+
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -133,6 +172,31 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int fifo_mask = 0x1F;
+	int ret;
+
+	if (value == 0) {
+		st->int_map &= ~ADXL345_INT_WATERMARK;
+		return 0;
+	}
+
+	if (value > ADXL345_FIFO_SIZE)
+		value = ADXL345_FIFO_SIZE;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_FIFO_CTL,
+				 fifo_mask, value);
+	if (ret)
+		return ret;
+
+	st->watermark = value;
+	st->int_map |= ADXL345_INT_WATERMARK;
+
+	return 0;
+}
+
 static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     long mask)
@@ -188,11 +252,224 @@ static const struct attribute_group adxl345_attrs_group = {
 	.attrs = adxl345_attrs,
 };
 
+static int adxl345_set_fifo(struct adxl345_state *st)
+{
+	u8 fifo_ctl;
+	int ret;
+
+	/* FIFO should only be configured while in standby mode */
+	ret = adxl345_set_measure_en(st, false);
+	if (ret < 0)
+		return ret;
+
+	fifo_ctl = ADXL345_FIFO_CTL_SAMLPES(st->watermark) |
+		ADXL345_FIFO_CTL_TRIGGER(st->intio) |
+		ADXL345_FIFO_CTL_MODE(st->fifo_mode);
+
+	ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
+	if (ret < 0)
+		return ret;
+
+	return adxl345_set_measure_en(st, true);
+}
+
+/**
+ * adxl345_get_samples() - Read number of FIFO entries.
+ * @st: The initialized state instance of this driver.
+ *
+ * The sensor does not support treating any axis individually, or exclude them
+ * from measuring.
+ *
+ * Return: negative error, or value.
+ */
+static int adxl345_get_samples(struct adxl345_state *st)
+{
+	unsigned int regval = 0;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_FIFO_STATUS, &regval);
+	if (ret < 0)
+		return ret;
+
+	return 0x3f & regval;
+}
+
+/**
+ * adxl345_fifo_transfer() - Read samples number of elements.
+ * @st: The instance of the state object of this sensor.
+ * @samples: The number of lines in the FIFO referred to as fifo_entry,
+ * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes each.
+ *
+ * It is recommended that a multiple-byte read of all registers be performed to
+ * prevent a change in data between reads of sequential registers. That is to
+ * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
+{
+	size_t count;
+	int i, ret;
+
+	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
+	for (i = 0; i < samples; i++) {
+		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
+				st->fifo_buf + (i * count / 2), count);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
+/**
+ * adxl345_fifo_reset() - Empty the FIFO in error condition.
+ * @st: The instance to the state object of the sensor.
+ *
+ * Read all elements of the FIFO. Reading the interrupt source register
+ * resets the sensor.
+ */
+static void adxl345_fifo_reset(struct adxl345_state *st)
+{
+	int regval;
+	int samples;
+
+	adxl345_set_measure_en(st, false);
+
+	samples = adxl345_get_samples(st);
+	if (samples > 0)
+		adxl345_fifo_transfer(st, samples);
+
+	regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
+
+	adxl345_set_measure_en(st, true);
+}
+
+static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = adxl345_set_interrupts(st);
+	if (ret < 0)
+		return ret;
+
+	st->fifo_mode = ADXL345_FIFO_STREAM;
+	return adxl345_set_fifo(st);
+}
+
+static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->int_map = 0x00;
+
+	ret = adxl345_set_interrupts(st);
+	if (ret < 0)
+		return ret;
+
+	st->fifo_mode = ADXL345_FIFO_BYPASS;
+	return adxl345_set_fifo(st);
+}
+
+static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
+	.postenable = adxl345_buffer_postenable,
+	.predisable = adxl345_buffer_predisable,
+};
+
+static int adxl345_get_status(struct adxl345_state *st)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
+	if (ret < 0)
+		return ret;
+
+	return (0xff & regval);
+}
+
+static int adxl345_fifo_push(struct iio_dev *indio_dev,
+				  int samples)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int i, ret;
+
+	if (samples <= 0)
+		return -EINVAL;
+
+	ret = adxl345_fifo_transfer(st, samples);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ADXL345_DIRS * samples; i += ADXL345_DIRS) {
+		/*
+		 * To ensure that the FIFO has completely popped, there must be at least 5
+		 * us between the end of reading the data registers, signified by the
+		 * transition to register 0x38 from 0x37 or the CS pin going high, and the
+		 * start of new reads of the FIFO or reading the FIFO_STATUS register. For
+		 * SPI operation at 1.5 MHz or lower, the register addressing portion of the
+		 * transmission is sufficient delay to ensure the FIFO has completely
+		 * popped. It is necessary for SPI operation greater than 1.5 MHz to
+		 * de-assert the CS pin to ensure a total of 5 us, which is at most 3.4 us
+		 * at 5 MHz operation.
+		 */
+		if (st->fifo_delay && (samples > 1))
+			udelay(3);
+
+		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	}
+
+	return 0;
+}
+
+/**
+ * adxl345_event_handler() - Handle events of the ADXL345.
+ * @irq: The irq being handled.
+ * @p: The struct iio_device pointer for the device.
+ *
+ * Return: The interrupt was handled.
+ */
+static irqreturn_t adxl345_event_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct adxl345_state *st = iio_priv(indio_dev);
+	u8 int_stat;
+	int samples;
+
+	int_stat = adxl345_get_status(st);
+	if (int_stat < 0)
+		return IRQ_NONE;
+
+	if (int_stat == 0x0)
+		goto err;
+
+	if (int_stat & ADXL345_INT_OVERRUN)
+		goto err;
+
+	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
+		samples = adxl345_get_samples(st);
+		if (samples < 0)
+			goto err;
+
+		if (adxl345_fifo_push(indio_dev, samples) < 0)
+			goto err;
+
+	}
+	return IRQ_HANDLED;
+
+err:
+	adxl345_fifo_reset(st);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info adxl345_info = {
 	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
+	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
 /**
@@ -222,6 +499,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	u8 fifo_ctl;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -293,6 +571,28 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
 
+	if (st->irq > 0) {
+		dev_dbg(dev, "initialize for FIFO_STREAM mode\n");
+
+		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
+		if (ret)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev, st->irq, NULL, &adxl345_event_handler,
+				IRQF_SHARED | IRQF_ONESHOT,
+				indio_dev->name, indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
+
+	} else {
+		dev_dbg(dev, "initialize for FIFO_BYPASS mode (fallback)\n");
+
+		fifo_ctl = ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
+
+		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
+		if (ret < 0)
+			return ret;
+	}
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
-- 
2.39.2


