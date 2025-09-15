Return-Path: <linux-iio+bounces-24122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C281FB5874B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 00:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E42116DBA4
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 22:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB32C08DC;
	Mon, 15 Sep 2025 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB2DZiUS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964D290DBB
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974605; cv=none; b=IqYqpAMn/GMKkoIqMGWA6HZzpk6i3q9BofVRFS34i2ltPoaf/8XcB883zMhpIPeoNNZyMo2vIVbRVFpQlNagSS3EVv8do3EdgE0LmkFcxbFg0Kyhg6ATPExeMbit3FdLhhvYGLssHNrxig8UYZ9j/98cAijv/Z4QxB5r1/m1L/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974605; c=relaxed/simple;
	bh=ZqHL7surV8LT4l9URAHAdRsZNJc7sCHKHarH3uZZ4UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQSHZlIwFCHnFjTDaqwMEweE3Sw+hp5G33v/BHGoSxN/OY1fAbUgkBw1EGZre2s8FGDA/mxuBvxwfdE9KjnsjtqKNnlyz+ylbA3FXqezQFzI5YStm/DgB+bszTnsTVCnqi0+9lwP2VEy76qRzl8NE0imIk78C0xBhczw5imhB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB2DZiUS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32ea5914786so51814a91.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757974602; x=1758579402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vACBPYnSiVVon/I906yPuzD5TPB5mIpjFjD3bY/O21w=;
        b=YB2DZiUSYxTA1nM0heQ1UnhoB/7FmN+uXXAKLFHgsO3ewF05dE598aQvSdWA6gsrW7
         /xTJiAaZ1b+cZlPJb6g6hxKkDY/qamLAL+LDXcu4JXLRp34CLzSLQzpnhU1BPF1CRc3A
         +5z8UBfC+E7CeNGr+y1nx1tRDp6rocH4DowKhd9UDbZAOfLZuJKiNnWN7ZnyOfoUNBkD
         FyaSPbieZVckYM++Ro8Xg356IinZ1IGT/+XLnCH7lwbV9pkr+j7nk8jWIQtcc7oRyCgq
         jTu/LQzAMiXMOKUzHhXljOjt/HJk9wU8K7cu8zp7GFd/emJOfr8uBmLyQIH//P7eQSeD
         Y1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974602; x=1758579402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vACBPYnSiVVon/I906yPuzD5TPB5mIpjFjD3bY/O21w=;
        b=P+UdP+nVLsfaAHooPQlH1xODIQ+cmi4c2HYtpj5kkVdfx2NaeoaVmxqpfwv9USJIk+
         8Rc5wHR9uRTwKCucotieCy/Ga6D8xVg9oLS7XCe+VcK3Xxl8eDYSrhbIjuvIpjExOKFo
         oRiiQ5ioNgeue1OzGrkEmvT3ltNuZYAxxLjQCtqn1EUmneaG8sFTQUqXzgoBBqp8x0rO
         SuuUq5XgsZ9fRFfEnZSM3api+0f5diX4GLWyCIchQm/+/ykRliOCAfMT8UfntlPPK54B
         yfungCCSdXp6zG7M/i1RSOlNSOzeLX3QZvCPpEakjc70kBsrw+2hLAWerH7QqHiU9/OI
         V91w==
X-Gm-Message-State: AOJu0YwTl4w7Kv3DcgFj6evWcu4SlXHTL5Z/5LB065sbNROhqUYlhRHf
	Q/3BGVHMIPIpDPh6HdNCwoc97YbPTDnwwZt1gZIysk8G8R2Lrw/OG/mV0GQHgaRyOXI=
X-Gm-Gg: ASbGnctMwoGUcrTwBBrausKTYtWwQYWZgQHMZe1i0yqbadBItbxMSozoAsaFDsUFBRP
	jXp1CSzclqFGr9GXm7CBehVWk4UjuVUhWZbNmnrik8XKvRoyC2QInw9Z5kko0DqFeIZmFBCHAPI
	nvQ9BbGsU6BuPasbde0Rpc68gvl7XQRebfwrbvm6mIpkL3LMbsYPlg/u6p1JuNsBhoTRG6KOu4K
	wjiczDD5RN9XhJsGG2VaWICO9xJrb5V1dfFaPN0FKhbUvYZdytc9XZKqKDkOJHUZOePlZLvC26y
	LJGBoPd0Gz5whdxyQk3IBozPtSGQXrGKnwdBLLFWlySmoQRZEccC38kDYEnujc1F3lJc8UtzhcB
	fPzf+UeNm3e/74cB4lZQnsE9y/AUQhbZFDOSTP8HW0nFhQmBkdP2DnxeE
X-Google-Smtp-Source: AGHT+IGZTnWZswXVEHyU/KrNmIrHt1gEUPjHN5tIQFF/lASixc3Q6MVaSS+nf0LWU6u1Gc2/cPeIgA==
X-Received: by 2002:a17:90b:39cf:b0:32e:7512:b67c with SMTP id 98e67ed59e1d1-32e7512b77emr5103793a91.17.1757974601745;
        Mon, 15 Sep 2025 15:16:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:d43e:6485:d878:c0c4:abbd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dff06dbc5sm9293253a91.17.2025.09.15.15.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:16:41 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v11 2/3] iio: adc: max14001: New driver
Date: Mon, 15 Sep 2025 19:16:31 -0300
Message-Id: <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757971454.git.marilene.agarcia@gmail.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-range
binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers
more features, like a binary comparator, a filtered reading that can
provide the average of the last 2, 4, or 8 ADC readings, and an inrush
comparator that triggers the inrush current. There is also a fault feature
that can diagnose seven possible fault conditions. And an option to select
an external or internal ADC voltage reference.

MAX14001/MAX14002 features implemented so far:
- Raw ADC reading.
- Filtered ADC average reading with the default configuration.
- MV fault disable.
- Selection of external or internal ADC voltage reference, depending on
whether it is declared in the device tree.

Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
---

I have addressed almost all of the comments, thank you very much for the 
review. I would like to highlight some of them:

Changes since v10:
- Dropped the kernel.h include
- Add the cleanup.h, mutex.h, regmap.h and units.h includes
- Renamed the reg_addr variable name to reg
- Renamed the reg_data variable name to val
- Added the regmap implementation
- Used scoped_guard()
- Refactored the get refin voltage code
- Replace max14001_chip_model with data structures separated
- Added debugfs_reg_access

Change I was not able to do:
- I could not remove bitrev16 because I am using an SPI controller that
does not support SPI_LSB_FIRST. So I suggest keeping bitrev16 and not using
the spi-lsb-first devicetree property for now, since this driver currently
works for both types of controllers: those that support it and those that
do not. I left a TODO comment to address this issue as soon as the SPI
kernel code starts handling the bit-reverse operation for controllers that
do not have this support. Once I finish my work on this driver, if the SPI
code still does not include this handling, I can submit patches to add it.

 MAINTAINERS                |   1 +
 drivers/iio/adc/Kconfig    |  10 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max14001.c | 356 +++++++++++++++++++++++++++++++++++++
 4 files changed, 368 insertions(+)
 create mode 100644 drivers/iio/adc/max14001.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bae420caa63..a9cf93ba8b21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14998,6 +14998,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+F:	drivers/iio/adc/max14001.c
 
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 237fa2061329..a1f2afce60ad 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -991,6 +991,16 @@ config MAX11410
 	  To compile this driver as a module, choose M here: the module will be
 	  called max11410.
 
+config MAX14001
+	tristate "Analog Devices MAX14001/MAX14002 ADC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices MAX14001/MAX14002
+	  Configurable, Isolated 10-bit ADCs for Multi-Range Binary Inputs.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max14001.
+
 config MAX1241
 	tristate "Maxim max1241 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 611c16430621..9c4ceb527db7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
 obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
+obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX34408) += max34408.o
diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
new file mode 100644
index 000000000000..2ade57970064
--- /dev/null
+++ b/drivers/iio/adc/max14001.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Analog Devices MAX14001/MAX14002 ADC driver
+ *
+ * Copyright (C) 2023-2025 Analog Devices Inc.
+ * Copyright (C) 2023 Kim Seer Paller <kimseer.paller@analog.com>
+ * Copyright (c) 2025 Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
+ */
+
+/*
+ * TODO:
+ * Replace bitrev16 with SPI_LSB_FIRST once the SPI kernel code supports handling
+ * SPI controllers that lack LSB-first support.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitrev.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+/* MAX14001 Registers Address */
+#define MAX14001_REG_ADC		0x00
+#define MAX14001_REG_FADC		0x01
+#define MAX14001_REG_FLAGS		0x02
+#define MAX14001_REG_FLTEN		0x03
+#define MAX14001_REG_THL		0x04
+#define MAX14001_REG_THU		0x05
+#define MAX14001_REG_INRR		0x06
+#define MAX14001_REG_INRT		0x07
+#define MAX14001_REG_INRP		0x08
+#define MAX14001_REG_CFG		0x09
+#define MAX14001_REG_ENBL		0x0A
+#define MAX14001_REG_ACT		0x0B
+#define MAX14001_REG_WEN		0x0C
+
+#define MAX14001_REG_VERIFICATION(x)	((x) + 0x10)
+
+#define MAX14001_REG_CFG_BIT_EXRF	BIT(5)
+
+#define MAX14001_REG_WEN_VALUE_WRITE	0x294
+
+#define MAX14001_MASK_ADDR		GENMASK(15, 11)
+#define MAX14001_MASK_WR		BIT(10)
+#define MAX14001_MASK_DATA		GENMASK(9, 0)
+
+struct max14001_state {
+	const struct max14001_chip_info *chip_info;
+	struct spi_device *spi;
+	struct regmap *regmap;
+	int vref_mV;
+	/*
+	 * lock protect against multiple concurrent accesses, RMW sequence,
+	 * and SPI transfer.
+	 */
+	struct mutex lock;
+	/*
+	 * The following buffers will be bit-reversed during device
+	 * communication, because the device transmits and receives data
+	 * LSB-first.
+	 * DMA (thus cache coherency maintenance) requires the transfer
+	 * buffers to live in their own cache lines.
+	 */
+	__be16 spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
+	__be16 spi_rx_buffer;
+};
+
+struct max14001_chip_info {
+	const char *name;
+};
+
+static struct max14001_chip_info max14001_chip_info = {
+	.name = "max14001",
+};
+
+static struct max14001_chip_info max14002_chip_info = {
+	.name = "max14002",
+};
+
+static int max14001_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct max14001_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &st->spi_tx_buffer,
+			.len = sizeof(st->spi_tx_buffer),
+			.cs_change = 1,
+		}, {
+			.rx_buf = &st->spi_rx_buffer,
+			.len = sizeof(st->spi_rx_buffer),
+		},
+	};
+	int ret;
+
+	/*
+	 * Prepare SPI transmit buffer 16 bit-value big-endian format and
+	 * reverses bit order to align with the LSB-first input on SDI port
+	 * in order to meet the device communication requirements.
+	 */
+	st->spi_tx_buffer = cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_MASK_ADDR, reg)));
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	/*
+	 * Convert received 16-bit value from big-endian to cpu-endian format
+	 * and reverses bit order.
+	 */
+	*val = FIELD_GET(MAX14001_MASK_DATA, bitrev16(be16_to_cpu(st->spi_rx_buffer)));
+
+	return 0;
+}
+
+static int max14001_write(struct max14001_state *st, unsigned int reg, unsigned int val)
+{
+	/*
+	 * Prepare SPI transmit buffer 16 bit-value big-endian format and
+	 * reverses bit order to align with the LSB-first input on SDI port
+	 * in order to meet the device communication requirements.
+	 */
+	st->spi_tx_buffer = cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_MASK_ADDR, reg) |
+						 FIELD_PREP(MAX14001_MASK_WR, 1) |
+						 FIELD_PREP(MAX14001_MASK_DATA, val)));
+
+	return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
+}
+
+static int max14001_write_single_reg(void *context, unsigned int reg, unsigned int val)
+{
+	struct max14001_state *st = context;
+	int ret;
+
+	/* Enable writing to the SPI register */
+	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_REG_WEN_VALUE_WRITE);
+	if (ret)
+		return ret;
+
+	/* Writing data into SPI register */
+	ret = max14001_write(st, reg, val);
+	if (ret)
+		return ret;
+
+	/* Disable writing to the SPI register */
+	return max14001_write(st, MAX14001_REG_WEN, 0);
+}
+
+static int max14001_write_verification_reg(struct max14001_state *st, unsigned int reg)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	return max14001_write(st, MAX14001_REG_VERIFICATION(reg), val);
+}
+
+static int max14001_disable_mv_fault(struct max14001_state *st)
+{
+	unsigned int reg;
+	int ret;
+
+	/* Enable writing to the SPI registers */
+	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_REG_WEN_VALUE_WRITE);
+	if (ret)
+		return ret;
+
+	/*
+	 * Reads all registers and writes the values to their appropriate
+	 * verification registers to clear the Memory Validation fault.
+	 */
+	for (reg = MAX14001_REG_FLTEN; reg <= MAX14001_REG_ENBL; reg++) {
+		ret = max14001_write_verification_reg(st, reg);
+		if (ret)
+			return ret;
+	}
+
+	/* Disable writing to the SPI registers */
+	return max14001_write(st, MAX14001_REG_WEN, 0);
+}
+
+static int max14001_debugfs_reg_access(struct iio_dev *indio_dev,
+				       unsigned int reg, unsigned int writeval,
+				       unsigned int *readval)
+{
+	struct max14001_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int max14001_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max14001_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &st->lock)
+			ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		scoped_guard(mutex, &st->lock)
+			ret = regmap_read(st->regmap, MAX14001_REG_FADC, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mV;
+		*val2 = 10;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct regmap_config max14001_regmap_config = {
+	.reg_read = max14001_read,
+	.reg_write = max14001_write_single_reg,
+};
+
+static const struct iio_info max14001_info = {
+	.read_raw = max14001_read_raw,
+	.debugfs_reg_access = max14001_debugfs_reg_access,
+};
+
+static const struct iio_chan_spec max14001_channel[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_AVERAGE_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int max14001_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct max14001_state *st;
+	int ret, ext_vrefin = 0;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(dev, -ENODEV, "Failed to get match data\n");
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &max14001_info;
+	indio_dev->channels = max14001_channel;
+	indio_dev->num_channels = ARRAY_SIZE(max14001_channel);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &max14001_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap), "Failed to initialize regmap\n");
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable Vdd supply\n");
+
+	ret = devm_regulator_get_enable(dev, "vddl");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable Vddl supply\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
+
+	if (ret < 0)
+		ret = 1250000;
+	else
+		ext_vrefin = 1;
+	st->vref_mV = ret / (MICRO / MILLI);
+
+	if (ext_vrefin) {
+		/*
+		 * Configure the MAX14001/MAX14002 to use an external voltage reference source
+		 * by setting the bit 5 of the configuration register
+		 */
+		ret = regmap_update_bits(st->regmap, MAX14001_REG_CFG, MAX14001_REG_CFG_BIT_EXRF, MAX14001_REG_CFG_BIT_EXRF);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to set External REFIN in Configuration Register\n");
+	}
+
+	ret = max14001_disable_mv_fault(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to disable MV Fault\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id max14001_id_table[] = {
+	{ "max14001", (kernel_ulong_t)&max14001_chip_info },
+	{ "max14002", (kernel_ulong_t)&max14002_chip_info },
+	{ }
+};
+
+static const struct of_device_id max14001_of_match[] = {
+	{ .compatible = "adi,max14001", .data = &max14001_chip_info },
+	{ .compatible = "adi,max14002", .data = &max14002_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max14001_of_match);
+
+static struct spi_driver max14001_driver = {
+	.driver = {
+		.name = "max14001",
+		.of_match_table = max14001_of_match,
+	},
+	.probe = max14001_probe,
+	.id_table = max14001_id_table,
+};
+module_spi_driver(max14001_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_AUTHOR("Marilene Andrade Garcia <marilene.agarcia@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices MAX14001/MAX14002 ADCs driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


