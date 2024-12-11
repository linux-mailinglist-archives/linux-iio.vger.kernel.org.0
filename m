Return-Path: <linux-iio+bounces-13378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75C9EDAFA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E06C16899F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD31F866A;
	Wed, 11 Dec 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm5oXJd4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED11F63DC;
	Wed, 11 Dec 2024 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958434; cv=none; b=HKq5lXqzKvtBF+x5r/out+yGqrkuRg3ILaTNifz4MgkM9EHPqHfMQ9GuaVPBNi6UaIqT1UlenYOcPBivSt0BWvT/WyFSIXyrNR6ooSf0n7vmcIKH6ggOzsRzCjFF7xNm3QFnBRseLw/jniuGdBBfhaQJJ2GXyjwgSXo2afsPHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958434; c=relaxed/simple;
	bh=uyuuNqCUhTh6PsNFzf1gqV8796nQZKFFkD4/dxc71cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrK7SZNqY1FsjB+1G7ido+D2miCGLISSP5T6565QC/BBSlf6DMmsqKEAnneop84Ize2kqbPLfO+ZX2ytaACA6tLqMrK49pYpUk9fTo3cIW66T/uWsnEYzwdoZJjnW4GittfHUG0lsjbAuvfgDq9MGawlbrV7a9cFd9JVat6o7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm5oXJd4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa659775dd5so63088766b.0;
        Wed, 11 Dec 2024 15:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958431; x=1734563231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9+60i128BFsYVtDJnM1GnUpwBAGwJV3rhgLTU/dojM=;
        b=Vm5oXJd4evafbut4oXHoxqj9hv/crrxsJ7hYX78YO/qnISjyk5sBHSSWa1k0dEnAuY
         AHl4usR3eibStO+DucjNeHxt3hTVflQMZZn1Dh3mPueGh+vFjVWIDYUkHPVDliCB8HMQ
         page/fY0hF6j+QrmX+qm3rU2IzOkyrYdQ6X2bANExqOr36X6eGOfGnELEEj1Pl33QZPD
         +NG8fKJ+tsiwoqg/GLEz8MAIoPq6eQnqJLRsOU5MV3QwyR6VQAE+gh0MRDIUaxO12228
         tyQ/9PC5NIM5clxCdU4n/UWpUzVvJzCg4eX26HLRuyLVqVvqW32vXpjUmiyezoxVDOMR
         tdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958431; x=1734563231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9+60i128BFsYVtDJnM1GnUpwBAGwJV3rhgLTU/dojM=;
        b=evEMQSFMSedhrSWn3pRI2OIYqOUkRbzMv9qOarUl0uuG06UhfdVprMSka/WPgfbeaA
         5tpk5YGZU7kA6km4IdEnye/vJRCUcnuh0sVwe4RlwKnWAzhesIIpOTUz+wpz7nPrcUSs
         7JRyiEuFefXIjCZHp72MyVs3OyL2sNEH5vHDQ/PJAC7P4khrSPICrbi97st4xwGYcCmK
         wWl4Ib3mAxY5ZECEqektM/l/ob81MoIpER1F9JtyVbjT5lw2LqrLQzuRNoVokrH5BThW
         r4zHnBxu1A2804G6waEsyVsak/bHj/fZ5cuP811xvUGHR3VL6lGiuQ9nxoGZQe3wq5g0
         /Fcg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Yp/O5ZmlZ3nIGj1HcUasIRQjG5JWMhWqX+QUvxia0HthVU7z/YKsOTWZmkx4ILMcpk+ySfQWllk=@vger.kernel.org, AJvYcCXyjXQ1euBh+YF7smVPqoDl+ctKUNnIV+kV5JFvBiENtb+F+lHhPUgFwJ9ztvT5GeoQSpsYnC1UisYfXAxd@vger.kernel.org
X-Gm-Message-State: AOJu0YybCYEV1MjH3rEGCvhJGVevYFRsC9TAaIwKiHnpO5h9qtYaltD/
	Ape3u01eK+OcNMThPfBslkwQD1sVh9Z/wGxDB7rCkQD2umaLaSuC
X-Gm-Gg: ASbGncugxLPk4Me1z97o5ryS9MEz7cY7ISZ+i4ScqJdCgNnGV0fcA+jWj0O1nfeTkGG
	3dxN9u8RvLMhJ0tW1j2snvOEu38S2hJ/LaYdiVEvo9RbYiL/9XInXKgrOymp8XYfJVhv/oBK6zR
	9J/5HDM2eX68nshd/dtaOkHFIFFCx9mckzO3uoweaEtrqqXiwSMF1PV6uWqwZpWzelu4DPIm3ex
	aG4MufXgnBvxEFF2EMdzqv87U6dPJ6W+evzz3KZPsRdc1pmQLQWD16V2u+LeVsyemwvSI7WrD8F
	MdKHpUE6I61aq08JCHYCZpGBnTqm8ixB
X-Google-Smtp-Source: AGHT+IH26ufAE/q2GhMSKYt7No5Y8a0NsC7Ifnd7R3lxk8vY+x4VEq4yGXPLcsQ2J6FIxD5n1GKnAQ==
X-Received: by 2002:a17:907:9710:b0:aa6:91ca:3674 with SMTP id a640c23a62f3a-aa6b1168062mr181001366b.4.1733958430498;
        Wed, 11 Dec 2024 15:07:10 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:07:10 -0800 (PST)
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
Subject: [PATCH v6 7/7] iio: accel: adxl345: add FIFO with watermark events
Date: Wed, 11 Dec 2024 23:06:48 +0000
Message-Id: <20241211230648.205806-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211230648.205806-1-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345.h      |   2 +
 drivers/iio/accel/adxl345_core.c | 314 ++++++++++++++++++++++++++++++-
 2 files changed, 311 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 3c2e12452..1faad1c8c 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -43,6 +43,7 @@
 #define ADXL345_REG_INT_ENABLE		0x2E
 #define ADXL345_REG_INT_MAP		0x2F
 #define ADXL345_REG_INT_SOURCE		0x30
+#define ADXL345_REG_INT_SOURCE_MSK	0xFF
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_XYZ_BASE		0x32
 #define ADXL345_REG_DATA_AXIS(index)				\
@@ -50,6 +51,7 @@
 
 #define ADXL345_REG_FIFO_CTL		0x38
 #define ADXL345_REG_FIFO_STATUS		0x39
+#define ADXL345_REG_FIFO_STATUS_MSK	0x3F
 
 #define ADXL345_DEVID			0xE5
 
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index fc4f89f22..f429b8f56 100644
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
+	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE];
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
@@ -132,6 +181,31 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -187,11 +261,220 @@ static const struct attribute_group adxl345_attrs_group = {
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
@@ -222,6 +505,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	u8 fifo_ctl;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -242,6 +526,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+	indio_dev->available_scan_masks = adxl345_scan_masks;
 
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
@@ -292,6 +577,25 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


