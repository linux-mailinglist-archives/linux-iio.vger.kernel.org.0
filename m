Return-Path: <linux-iio+bounces-13435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ACF9F17F8
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9916188F96E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE031EC00E;
	Fri, 13 Dec 2024 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS8iZFq8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365DE1A9B5D;
	Fri, 13 Dec 2024 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124769; cv=none; b=qTFb5CSbOIuxt/etmNrnmYGuVyyYj7oYMFv3LM8uiSQ7cc9PJupoxP/Qbo7x+3dQ6SteliUySn5nto70pgY4J4YplNs1sdKfTLEATCoq2wukzaVVhraasVUCoNSwpuqE965IXYH7MF3OnPh6R5Ne4SMn3L6tbjVixc1XQI7n0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124769; c=relaxed/simple;
	bh=rqxanvAwt5GjmMDQHIo1PiGibGwZLos7u8UdcuKi60Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Brf6juG81uGa7sHodVe7oo0axzU83AyAVK93en5w/ZnlOD0lmPMtwlsXabE/EPJgfeVeohloO/Amn70SfAeQKSnUr6EKWji6NxFWCraXYbcXL8ZHYiF4nY+4do3auvaOnFKQW/so0rigwpIHJlKNy7CE3ihAKSGjYiUcjoDElw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS8iZFq8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862e570832so239684f8f.0;
        Fri, 13 Dec 2024 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124765; x=1734729565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td5opudK4E//6f8GciLiEGMyM4CWMS13OyWPAT8pU9s=;
        b=KS8iZFq8AOMfrw/lqvUoXqhuHvnfh3KSjXNmuhUvmBUW7xkui1jYVPZyiz5wgFpnM8
         1uPLBDeABXVzOtsH8DSfko0An2+CryFxtL6F1mKfKkIL5VufLaijGQ5MwQnhTmOgrAV9
         8r5+a0yZkNRPlC8j+jHuaz9Wg9P+SQac/tWqElyR8VbBFlLHMu7kRStEcoxA1fJGFyP1
         axkRjcmzKs3IyTdOAATATY3oI+bWtgN1PcyRNgNSwdwgEnqarRMO/aT5i708lsslSCfw
         y6wijBN4JPVK9wfniMX2SddB4i208LSpkOeyJLRTi4KZxOdHLfmTAmzdWsnuAki+9T0t
         nuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124765; x=1734729565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td5opudK4E//6f8GciLiEGMyM4CWMS13OyWPAT8pU9s=;
        b=XCsk3kDn2J1mt/UMBpwrb2sDliSamXvo4U4oxpNQvOGiA+fgR2/yVRltTGDmQLfXpI
         jFA2OVmIcU6/iu5yCk7RaGAUIDFUggkZnKnRe+mytJwBj2ETVblNq1fCkBMGbOjqBEAt
         arsOuCQdRZCkuqm5OipneWXLqML5c6DAASRY1NTbRI7mm2vN3Ar0JJiVtHfofdK+Sax6
         fioTM0PB1+KEWqyU+4Uhda0L7hTIG9wDs0rrN0KfRgwcpB1rFopVYhhK76x+T6VcCOvs
         FpeGqdOg07miN5hX1jNd/83c2J0H5riYpzmQGVQUofhVb3+3Owj2ulexOB4kFgQkvZhu
         BdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGpwU4M1cktv4oQf4lzmkBERuwHyPMZpOschHVDW8NGVJnW3pYWSVq318k9KBPh2OlDaRzAfnvZqNc5+qf@vger.kernel.org, AJvYcCWTnaV27eWausQLp5ra19dAaUlZ2d5xz/YPUE/lpOQHdyp/5c/HZ3vxLC4hjPsDiCQpW6tdqMgcies=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6DgIjiB35rKLE79DamwtgWJnOlQ6zFXBeV9Eof5xvwEUgIq3C
	nMRLVl2YQcXk0VfhI4woMkwVNEXmRcYBWMQMrxDwEmOmiQVntjWO
X-Gm-Gg: ASbGncssPwWfVijQp4HdxcxVGLVyjurfCiakNqFvmFl/w7Ni4CpdQ87jO5sPvGj1yai
	y4Qb5PjSEZLSra9pVmmd4aa9wpbeNTzehNp5iPIRjHx5Y6/jFKT+MyODDdiZ+5bLb6k+x5MgLkO
	s2C16i81ahWXox4MA7pwmVKyyUR5ZJ0XymVlU343bakVckqiaD+i46yBEZS0cUVSwXOiL3ilJ4Q
	aye+rbdUwkZIJsWlxxXCnufd4bo/DqLkenjuTFDjUbEaIRL/0qa/f9SLtZFvCNrTSTT5fH15oUO
	9yUpyWdhH2j8UnzZ/cNJl/vGTidXZ4nzDpY=
X-Google-Smtp-Source: AGHT+IGMTAbZJJpWfnE/VoCWGodZwxCWeQxs6nCSFLAt5X64lIsGc2w8kpVwPfa+JAvL83xRuB1s8g==
X-Received: by 2002:a5d:6da6:0:b0:385:e10a:4d98 with SMTP id ffacd0b85a97d-38880ada7c6mr1501605f8f.8.1734124765284;
        Fri, 13 Dec 2024 13:19:25 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:24 -0800 (PST)
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
Subject: [PATCH v7 6/7] iio: accel: adxl345: add FIFO with watermark events
Date: Fri, 13 Dec 2024 21:19:08 +0000
Message-Id: <20241213211909.40896-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213211909.40896-1-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345.h      |  27 ++-
 drivers/iio/accel/adxl345_core.c | 308 ++++++++++++++++++++++++++++++-
 2 files changed, 324 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 6f39f16d3..bf9e86cff 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -15,18 +15,32 @@
 #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
 #define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_INT_ENABLE		0x2E
+#define ADXL345_REG_INT_MAP		0x2F
+#define ADXL345_REG_INT_SOURCE		0x30
+#define ADXL345_REG_INT_SOURCE_MSK	0xFF
 #define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+#define ADXL345_REG_XYZ_BASE		0x32
+#define ADXL345_REG_DATA_AXIS(index)				\
+	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
 
+#define ADXL345_REG_FIFO_CTL		0x38
+#define ADXL345_REG_FIFO_STATUS	0x39
+#define ADXL345_REG_FIFO_STATUS_MSK	0x3F
+
+#define ADXL345_FIFO_CTL_SAMPLES(x)	FIELD_PREP(GENMASK(4, 0), x)
+/* 0: INT1, 1: INT2 */
+#define ADXL345_FIFO_CTL_TRIGGER(x)	FIELD_PREP(BIT(5), x)
+#define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)
+
+#define ADXL345_INT_DATA_READY		BIT(7)
+#define ADXL345_INT_WATERMARK		BIT(1)
+#define ADXL345_INT_OVERRUN		BIT(0)
 #define ADXL345_BW_RATE			GENMASK(3, 0)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
 
 #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
 #define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
@@ -40,6 +54,7 @@
 #define ADXL345_DATA_FORMAT_16G		3
 
 #define ADXL345_DEVID			0xE5
+#define ADXL345_FIFO_SIZE		32
 
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index fc4f89f22..e31a7cb3f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -15,9 +15,17 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
 
 #include "adxl345.h"
 
+#define ADXL345_FIFO_BYPASS	0
+#define ADXL345_FIFO_FIFO	1
+#define ADXL345_FIFO_STREAM	2
+
+#define ADXL345_DIRS 3
+
 #define ADXL345_INT_NONE		0xff
 #define ADXL345_INT1			0
 #define ADXL345_INT2			1
@@ -26,27 +34,68 @@ struct adxl345_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1];
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
+	u8 int_map;
+	u8 watermark;
+	u8 fifo_mode;
 };
 
-#define ADXL345_CHANNEL(index, axis) {					\
+#define ADXL345_CHANNEL(index, reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
-	.address = index,						\
+	.address = (reg),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = (index),				\
+	.scan_type = {					\
+		.sign = 's',				\
+		.realbits = 13,				\
+		.storagebits = 16,			\
+		.endianness = IIO_LE,			\
+	},						\
 }
 
+enum adxl345_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
-	ADXL345_CHANNEL(0, X),
-	ADXL345_CHANNEL(1, Y),
-	ADXL345_CHANNEL(2, Z),
+	ADXL345_CHANNEL(0, chan_x, X),
+	ADXL345_CHANNEL(1, chan_y, Y),
+	ADXL345_CHANNEL(2, chan_z, Z),
 };
 
+static const unsigned long adxl345_scan_masks[] = {
+	BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
+	0,
+};
+
+static int adxl345_set_interrupts(struct adxl345_state *st)
+{
+	int ret;
+	unsigned int int_enable = st->int_map;
+	unsigned int int_map;
+
+	/*
+	 * Any bits set to 0 in the INT map register send their respective
+	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
+	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+	 */
+	int_map = FIELD_GET(ADXL345_REG_INT_SOURCE_MSK,
+			st->intio ? st->int_map : ~st->int_map);
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
@@ -132,6 +181,25 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int fifo_mask = 0x1F;
+	int ret;
+
+	if (value > ADXL345_FIFO_SIZE)
+		value = ADXL345_FIFO_SIZE - 1;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_FIFO_CTL, fifo_mask, value);
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
@@ -187,11 +255,220 @@ static const struct attribute_group adxl345_attrs_group = {
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
+	fifo_ctl = ADXL345_FIFO_CTL_SAMPLES(st->watermark) |
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
+	return FIELD_GET(ADXL345_REG_FIFO_STATUS_MSK, regval);
+}
+
+/**
+ * adxl345_fifo_transfer() - Read samples number of elements.
+ * @st: The instance of the state object of this sensor.
+ * @samples: The number of lines in the FIFO referred to as fifo_entry.
+ *
+ * It is recommended that a multiple-byte read of all registers be performed to
+ * prevent a change in data between reads of sequential registers. That is to
+ * read out the data registers X0, X1, Y0, Y1, Z0, Z1, i.e. 6 bytes at once.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
+{
+	size_t count;
+	int i, ret = 0;
+
+	/* count is the 3x the fifo_buf element size, hence 6B */
+	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
+	for (i = 0; i < samples; i++) {
+		/* read 3x 2 byte elements from base address into next fifo_buf position */
+		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
+				st->fifo_buf + (i * count / 2), count);
+		if (ret < 0)
+			return ret;
+
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
+	st->fifo_mode = ADXL345_FIFO_BYPASS;
+	ret = adxl345_set_fifo(st);
+	if (ret < 0)
+		return ret;
+
+	st->int_map = 0x00;
+	return adxl345_set_interrupts(st);
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
+	return FIELD_GET(ADXL345_REG_INT_SOURCE_MSK, regval);
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
+	for (i = 0; i < ADXL345_DIRS * samples; i += ADXL345_DIRS)
+		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+
+	return 0;
+}
+
+/**
+ * adxl345_irq_handler() - Handle irqs of the ADXL345.
+ * @irq: The irq being handled.
+ * @p: The struct iio_device pointer for the device.
+ *
+ * Return: The interrupt was handled.
+ */
+static irqreturn_t adxl345_irq_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int int_stat;
+	int samples;
+
+	int_stat = adxl345_get_status(st);
+	if (int_stat <= 0)
+		return IRQ_NONE;
+
+	if (int_stat & ADXL345_INT_OVERRUN)
+		goto err;
+
+	if (int_stat & ADXL345_INT_WATERMARK) {
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
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	u8 fifo_ctl;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -242,6 +520,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+	indio_dev->available_scan_masks = adxl345_scan_masks;
 
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
@@ -292,6 +571,25 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 			st->intio = ADXL345_INT_NONE;
 	}
 
+	if (st->intio != ADXL345_INT_NONE) {
+		/* FIFO_STREAM mode is going to be activated later */
+		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
+		if (ret)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev, st->irq, NULL, &adxl345_irq_handler,
+				IRQF_SHARED | IRQF_ONESHOT,
+				indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+	} else {
+		/* FIFO_BYPASS mode */
+		fifo_ctl = ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
+		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
+		if (ret < 0)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
-- 
2.39.5


