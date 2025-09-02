Return-Path: <linux-iio+bounces-23642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0FB40269
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B72A1B21A4F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEB62F8BDC;
	Tue,  2 Sep 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPXdyuRD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335F2DCBF7;
	Tue,  2 Sep 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818986; cv=none; b=mqYQ51rB4vZnHxAddVzZvWpGja8Pg7abmUnwpmi0idUIC/dVdHloTZSsdHn2HDb80lLQCutvlK/u2mlBqYNKTxpwxfZdNwcUIDCO+cXH46hucLFzuoSKfAhSlq6OshK96oKqAF9bLmC8xbtUohC0CToGJlHfmtr520yNKTZpio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818986; c=relaxed/simple;
	bh=6eOE26bI65MsDQNpoFXFLrhR0ZKs9oOluZgE9AeAjYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Id9Q0HNf0T0Tpp5SvkFGHkMQCJJssCPHg3dMrwMCosDd1oBQDBadRExXIiymbYqtw8GtBLguRZYU3xXKco9+l1pgpNT0iM/RfyI4L+a3ayARzSMqfzQ02fxXiKER0IouNRbV8VREctlrhKp3pZh9MFfsM+XjEJXxPcyWiPYLWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPXdyuRD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248d5074ff7so35063255ad.0;
        Tue, 02 Sep 2025 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756818984; x=1757423784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gohftFrtrVQCme5K59+N4VU+fitHE4I6hHU74UHi5eo=;
        b=FPXdyuRD2FIjZzhkcQhFfiYejscFvyPlVqkApm4+tea35+B2xZVQx0UfdLx7D+GuFq
         qlhp8zqKySi6jChJY10wu6v/vEwh7GENztJGCsjirrnO2zkf7EEaTUn+Yz485hb+kARN
         yCxVox46FHSkjkgpYhip04O/U6A5HfDMlyiz2bcUJO0xCgM4KDaFIabn8q22q3eqcHug
         qV7fXALcxi4DRqUxbhx7B7JVdRC83P+TJSFrJjAnXbd3+NHUkUCTzFlPogSAW/cWuafB
         O8Iiq+xL+vibyiOOn9mg+lZLrJGdtc3OhmNGNBPUp7Y6bXTijsyCEkOykjg21hrIJwBn
         B29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818984; x=1757423784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gohftFrtrVQCme5K59+N4VU+fitHE4I6hHU74UHi5eo=;
        b=QmCsJMGSFl8HeCjO8upcgSdEaVHIRwdyPgqIQgTTOJaALFfrFTdhGnuFKh7QSqZgWq
         hGETuWknS4jJhhjgcZbB54nXIqotW24AcTwVJE1VUr755A9qFnBqffRFK+z6etkU0AWu
         hZeSedJaQEtFM24EGLyfhwLYx3NRBlN4BV/O7TnTAZUHJyeZHTVq+lOcSSyB2f0HW+0J
         VEiQ4UhD4MLe9+xz7K6GAcOD+ancFiET/NPBp3g9oSb2rbvO9WgxFpKVislr80+1L5VG
         j54Oij6OuHJaBHvj2TgsyBSRV+w0l2Gvo4a6LdPNM06XEp+r0gcaXzSLZ5OxCcLNBrlV
         y7vw==
X-Forwarded-Encrypted: i=1; AJvYcCW0eZU1Ywnt45kKawS/UEMVTJ0ris28bsjJ0bHLVjpecFjFfRDPmETCV+GPtCp9U7Jlb/Adw8ThvLM8Zdvs@vger.kernel.org, AJvYcCXmuj9nvlGfF0WMR8FkFKLzhW1LmZlRCYdlnF9K6w1YAIQSc6pBFaW/7zFDjdK7yRUtJS+ajiIG0Dh7@vger.kernel.org
X-Gm-Message-State: AOJu0YzAG+0bGX08laFoWcoaoTQpVik97QYKnHrd9Nqdg8W4ipFHC9x1
	+7E2kWwjzzCfjL7lQkOMQvHJONN1g67sxrbgRc0zGAU8vigaBzN9mDu4IY5issM8f22vbA==
X-Gm-Gg: ASbGncsvbpb1ZWzr6rEyTCu+OKg+PWA2bUykWa1jqILt5yJ0lMkJQvKgrYit/cyZ+7P
	8CvWMSUjGPU+R1htcLwKMN9/L/8R8gfInQgFH4DrEvp6ql8YNGx0urVAKyGHUd73HHjdFnfLva2
	QFikIB0PYnYAJZEGmkkp0aph5jRLLq5JQqKkj7eJsgDIbsoTu0PV6noYC85U+lXQ+DWdCwQgKBE
	T8nvnQa+IXco1DBOyGlALvu+fR0mzoU4+twsV4pAHlLcfoXJ+NRcSdwEWerfz5OdcK9D1EgODfJ
	z3+KJtTX4LPcrJQNzASUH8dyULExCJePNmDZCWaUW2ICPmkdoFXD+9mquoqU/znTEyqTuPIYjmE
	NKWAZCF/9RC3OGgDfyxW34fowk1l1+TnFlwSkmdBQB/7VxhbxoibNO7g=
X-Google-Smtp-Source: AGHT+IEKJJfxOnzi8UjkWFq1lGAp6FixeFFDlpGOYwHIFGUh4ptBwTMVlU1sZURoeAC01sQ5VBA1Vg==
X-Received: by 2002:a17:902:c950:b0:249:304c:dbbf with SMTP id d9443c01a7336-2493ef95429mr129291775ad.23.1756818983447;
        Tue, 02 Sep 2025 06:16:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:bc66:1b1c:d88:2aac:2997])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57ab9esm19900206a91.4.2025.09.02.06.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:16:23 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v10 2/2] iio: adc: max14001: New driver
Date: Tue,  2 Sep 2025 10:16:12 -0300
Message-Id: <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756816682.git.marilene.agarcia@gmail.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
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

Co-developed-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS                |   1 +
 drivers/iio/adc/Kconfig    |  10 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max14001.c | 355 +++++++++++++++++++++++++++++++++++++
 4 files changed, 367 insertions(+)
 create mode 100644 drivers/iio/adc/max14001.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f145f0204407..b6457063da6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14976,6 +14976,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+F:	drivers/iio/adc/max14001.c
 
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e3d3826c3357..11e911ceab4c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -958,6 +958,16 @@ config MAX11410
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
index 89d72bf9ce70..569f2f5613d4 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
 obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
+obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX34408) += max34408.o
diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
new file mode 100644
index 000000000000..6755df152976
--- /dev/null
+++ b/drivers/iio/adc/max14001.c
@@ -0,0 +1,355 @@
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
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitrev.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
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
+#define MAX14001_REG_CFG_EXRF		BIT(5)
+
+#define MAX14001_MASK_ADDR		GENMASK(15, 11)
+#define MAX14001_MASK_DATA		GENMASK(9, 0)
+
+#define MAX14001_SET_WRITE_BIT		BIT(10)
+#define MAX14001_WRITE_WEN		0x294
+
+enum max14001_chip_model {
+	max14001,
+	max14002,
+};
+
+struct max14001_chip_info {
+	const char *name;
+};
+
+struct max14001_state {
+	const struct max14001_chip_info *chip_info;
+	struct spi_device *spi;
+	int vref_mv;
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
+static struct max14001_chip_info max14001_chip_info_tbl[] = {
+	[max14001] = {
+		.name = "max14001",
+	},
+	[max14002] = {
+		.name = "max14002",
+	},
+};
+
+static int max14001_read(struct max14001_state *st, u16 reg_addr, u16 *reg_data)
+{
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
+	st->spi_tx_buffer = FIELD_PREP(MAX14001_MASK_ADDR, reg_addr);
+	st->spi_tx_buffer = bitrev16(cpu_to_be16(st->spi_tx_buffer));
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	/*
+	 * Convert received 16-bit value from big-endian to cpu-endian format
+	 * and reverses bit order.
+	 */
+	st->spi_rx_buffer = bitrev16(be16_to_cpu(st->spi_rx_buffer));
+	*reg_data = FIELD_GET(MAX14001_MASK_DATA, st->spi_rx_buffer);
+
+	return 0;
+}
+
+static int max14001_write(struct max14001_state *st, u16 reg_addr, u16 reg_data)
+{
+	/*
+	 * Prepare SPI transmit buffer 16 bit-value big-endian format and
+	 * reverses bit order to align with the LSB-first input on SDI port
+	 * in order to meet the device communication requirements.
+	 */
+	st->spi_tx_buffer = FIELD_PREP(MAX14001_MASK_ADDR, reg_addr) |
+			    FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
+			    FIELD_PREP(MAX14001_MASK_DATA, reg_data);
+	st->spi_tx_buffer = bitrev16(cpu_to_be16(st->spi_tx_buffer));
+
+	return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
+}
+
+static int max14001_write_single_reg(struct max14001_state *st, u16 reg_addr,
+				     u16 reg_data)
+{
+	int ret;
+
+	/* Enable register write */
+	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_WRITE_WEN);
+	if (ret)
+		return ret;
+
+	/* Write data into register */
+	ret = max14001_write(st, reg_addr, reg_data);
+	if (ret)
+		return ret;
+
+	/* Disable register write */
+	ret = max14001_write(st, MAX14001_REG_WEN, 0);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int max14001_write_verification_reg(struct max14001_state *st,
+					   u16 reg_addr)
+{
+	u16 reg_data;
+	int ret;
+
+	ret = max14001_read(st, reg_addr, &reg_data);
+	if (ret)
+		return ret;
+
+	return max14001_write(st, MAX14001_REG_VERIFICATION(reg_addr), reg_data);
+}
+
+static int max14001_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max14001_state *st = iio_priv(indio_dev);
+	u16 reg_data;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = max14001_read(st, MAX14001_REG_ADC, &reg_data);
+		mutex_unlock(&st->lock);
+		if (ret)
+			return ret;
+
+		*val = reg_data;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		mutex_lock(&st->lock);
+		ret = max14001_read(st, MAX14001_REG_FADC, &reg_data);
+		mutex_unlock(&st->lock);
+		if (ret)
+			return ret;
+
+		*val = reg_data;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = 10;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max14001_info = {
+	.read_raw = max14001_read_raw,
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
+	}
+};
+
+static int max14001_disable_mv_fault(struct max14001_state *st)
+{
+	u16 reg_addr;
+	int ret;
+
+	/* Enable SPI Registers Write */
+	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_WRITE_WEN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Reads all registers and writes the values back to their appropriate
+	 * verification registers to clear the Memory Validation fault.
+	 */
+	for (reg_addr = MAX14001_REG_FLTEN; reg_addr <= MAX14001_REG_ENBL; reg_addr++) {
+		ret = max14001_write_verification_reg(st, reg_addr);
+		if (ret)
+			return ret;
+	}
+
+	/* Disable SPI Registers Write */
+	return max14001_write(st, MAX14001_REG_WEN, 0);
+}
+
+static int max14001_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct max14001_state *st;
+	struct device *dev = &spi->dev;
+	int ret, ext_vrefin = 0;
+	u16 reg_data;
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
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to enable specified Vdd supply\n");
+
+	ret = devm_regulator_get_enable(dev, "vddl");
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to enable specified Vddl supply\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");
+	if (ret < 0) {
+		st->vref_mv = 1250000 / 1000;
+	} else {
+		st->vref_mv = ret / 1000;
+		ext_vrefin = 1;
+	}
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to init the mutex\n");
+
+	if (ext_vrefin) {
+		/*
+		 * Configure the MAX14001/MAX14002 to use an external voltage
+		 * reference source for the ADC.
+		 */
+		ret = max14001_read(st, MAX14001_REG_CFG, &reg_data);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"Failed to read Configuration Register\n");
+
+		reg_data |= FIELD_PREP(MAX14001_REG_CFG_EXRF, 1);
+		ret = max14001_write_single_reg(st, MAX14001_REG_CFG, reg_data);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"Failed to set Configuration Register\n");
+	}
+
+	ret = max14001_disable_mv_fault(st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to disable MV Fault\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id max14001_id_table[] = {
+	{ "max14001", (kernel_ulong_t)&max14001_chip_info_tbl[max14001] },
+	{ "max14002", (kernel_ulong_t)&max14001_chip_info_tbl[max14002] },
+	{ }
+};
+
+static const struct of_device_id max14001_of_match[] = {
+	{ .compatible = "adi,max14001",
+	  .data = &max14001_chip_info_tbl[max14001], },
+	{ .compatible = "adi,max14002",
+	  .data = &max14001_chip_info_tbl[max14002], },
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


