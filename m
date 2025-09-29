Return-Path: <linux-iio+bounces-24547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F3BA80AD
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 07:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343CB189B195
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B4284681;
	Mon, 29 Sep 2025 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSChbtMg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFC296BDE
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125590; cv=none; b=oXAgGQxTJz5O7MU3qjuNGoGSZkWaqn70y3Mp5LEuY9/Xq03+4XDG1zGhQhRMzOUk65htYDYU+rhaTdVMW5K+/L8yUD7hw7YEXNoSZYRvUM8vlVO1bX8drmy31aC4gxE82RV74AdWCWIwx7PFzZi23BFEafRHOPrR/cAfVv7DY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125590; c=relaxed/simple;
	bh=z6ASDPQheRQRfz/V69Coqjj2rXQ8d8Xf7YoQIZponG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvIJcOt/lMUXBRqfJW40xlaPPBOWPjhXyDy/2xgwqKKwQg/5FTTqYUpPjIi7RQCVKDR9ZY5r7nmFJfJ1AekiMiSMQJ4PdnyW69OH8rJpTtHYD1SADrwYQUY7z5dOsnWQ4b8KudWnImAdl1dVG3rNsOIRVOBUy91uG4iQSr1EZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSChbtMg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-269af38418aso54171525ad.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759125588; x=1759730388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgVSWDcc7XefumrjG6AtXdyuH6wRZHw26TRPJFsvcsg=;
        b=NSChbtMgWwkAjveLxgUWN2M5cu64l/vDBCGRaI1FHdw1j4GZBl76jUKGurp8GEhTsk
         UTZrTy70BIvKOOmFvkHa/SKtD6uMAnPIPC5QfhZvS506bHS4D0q4Wlh3Umhor5Srom39
         SvRfO2wTJsTz+XhhRvltTAzmLZe9lWl/Wixhz/a2GJbAYdzSZZgeUeGDmyo/90tENrFZ
         sl4F+zhT8TZQ7Gb+nsGcu/mR1aUPurFfEu+IPXnutgqdRBeDLxx9OezW0uyol0E1HqT/
         8RWXDqGHaJGDiagDMg05pOo33BuONqq0MqyoSnWEuMJfL9o2zvMDnnpK7WOkLPql8UPy
         5XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125588; x=1759730388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgVSWDcc7XefumrjG6AtXdyuH6wRZHw26TRPJFsvcsg=;
        b=iZKKsDUWtoINO1Pj42SPhNHtG5f6mej0zUP7sqQla25jImYxKW1Dm5zO+/i1zARAlD
         2wvtZ/HccMZOg7usnYatSLwtY2fBEiUxfhgZgSUveBpjjk+VYBvGPpf1WUVNvf7b4P0r
         y6C6CfMbN6TEyajMywRyt/00UTFMeW6122E/VyVYep2QW2Y66SKFVDTxSoNwcErkdZoL
         Vl8df8ujcvIHXNiZpE+q/o1aPQfPnzZP4rWpHI6Iu2JdGulw7bzckDpOSkEQZUT/ucDA
         Ml04KZ4fX5VL4IRFaZPcbZft9cBWIb5oaPMBgLv0icFGcoXMAkkxUSjJddsQkJ8STpEd
         qELw==
X-Gm-Message-State: AOJu0YwhQ7w41NqlREWoKWc2QUevfl+nLn/OZVfjnEYx6wt7yGrmCOGj
	P6V02PV3jZHMovaf0CGADF5eKJlAnuE1XrniK2ZzEa2g9PMTp67BAnVjBxkqw7om
X-Gm-Gg: ASbGncvnVcFjZY0e5jjJJ/7NwRuiwMBVktqgmLkyhX9k/h6PBBIfR1u4/Qi1cCNGmwM
	RQpueFtf/V7oXOKf3hf14li1U+L2orx/os8qO0S55x9ZQHf5DzRRwxV3RpALs39nn8iRwvzyFOI
	0TtNAqUlBwmouJNMqwQNXV9MT7LxFbdvW88pS/Q2LxNDkiUzG9IsYypKPMPweS/8K6XiX3JqbcZ
	HKrbf8W5V47THFaLFFf6Bh3hkk/I/sk+1gByQJB25JFHv8SP7XsqkA3bHIKUyjW1vExIQl9bSXj
	rg3RK721lszd9uz4JjFtt4hoDAG6FgnKwyjdm3v12+u9b7pUduJPcXdX5BlvuHH6nh9LAlSGpao
	UGmN+LUyfwTN+LwllruvgWWoASgBeAC6BYDcXfH9zvFjlnw==
X-Google-Smtp-Source: AGHT+IEyWmvVZbxWXBviY1wA472mF42frU5Juzy+89JK+WY6RRbxZNGbrOTqTRCiAMTs2KbEepBaSg==
X-Received: by 2002:a17:903:19e3:b0:274:a5ec:1fe9 with SMTP id d9443c01a7336-27ed4a5a845mr168158715ad.38.1759125587531;
        Sun, 28 Sep 2025 22:59:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:fda4:f56e:95d0:3775:a428])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688223dsm119683075ad.86.2025.09.28.22.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:59:47 -0700 (PDT)
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
Subject: [PATCH v12 2/3] iio: adc: max14001: New driver
Date: Mon, 29 Sep 2025 02:59:37 -0300
Message-Id: <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hello maintainers,
Thank you for reviewing v11 and for your suggestions.
I believe I have addressed most of the requested code changes in this v12.
There were some discussions about a few of them, and I tried to follow the
path that you seemed to agree with.

I have one remaining question related to the max_register attribute of the
regmap. The register regions that can be accessed are 0x00–0x0c and
0x13–0x1a. As suggested, I used max_register to set the upper limit of the
register region that can be accessed (0x1a). Beyond this address, there is
a reserved region that should not be used (0x1b–0x1f). However, there is 
also a reserved region that should not be used between addresses 0x0d–0x12.
Should I use something to mark this region in the regmap?

Notes:
As suggested by Andy, I have chosen to use the code "if (ret == -ENODEV)" 
rather than "if (ret < 0)" on line 312, because it produces a slightly smaller
max14001.o file compared to the other approach (10640 bytes vs. 10648 bytes).
Additionally, as mentioned, it is more explicit check.

As suggested by David, I added support for SPI_LSB_FIRST, and I also used a
union to avoid clang compiler warnings related to casts between __le16,
__be16, and u16. Thank you for the code examples.

I tested it on the Raspberry Pi modified kernel version rpi-6.12 with
Raspberry Pi 5 hardware, using the MAX14001PMB evaluation board, and it
seems to work fine.

Main changes since v11:
- I think I fixed the alphabetical order in the files pointed.
- Fixed small issues in the include files.
- Removed the mutex since regmap has a lock mechanism (also removed the 
mutex include).
- Added support for SPI_LSB_FIRST in case it is used in a device tree file.

Best regards,
Marilene Andrade Garcia

 MAINTAINERS                |   1 +
 drivers/iio/adc/Kconfig    |  10 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max14001.c | 371 +++++++++++++++++++++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 drivers/iio/adc/max14001.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e1a30f77a0c..da024038d6a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14929,6 +14929,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+F:	drivers/iio/adc/max14001.c
 
 MAX15301 DRIVER
 M:	Daniel Nilsson <daniel.nilsson@flex.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58a14e6833f6..7c5dc06408a4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1020,6 +1020,16 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
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
 config MAX34408
 	tristate "Maxim max34408/max344089 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d008f78dc010..4241178c1098 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
new file mode 100644
index 000000000000..52584c24fb08
--- /dev/null
+++ b/drivers/iio/adc/max14001.c
@@ -0,0 +1,371 @@
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
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+#include <asm/byteorder.h>
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
+	bool spi_hw_has_lsb_first;
+
+	/*
+	 * The following buffers will be bit-reversed during device
+	 * communication, because the device transmits and receives data
+	 * LSB-first.
+	 * DMA (thus cache coherency maintenance) requires the transfer
+	 * buffers to live in their own cache lines.
+	 */
+	union {
+		__be16 be;
+		__le16 le;
+	} spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
+
+	union {
+		__be16 be;
+		__le16 le;
+	} spi_rx_buffer;
+};
+
+struct max14001_chip_info {
+	const char *name;
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
+	unsigned int addr, data;
+
+	/*
+	 * Prepare SPI transmit buffer 16 bit-value and reverse bit order
+	 * to align with the LSB-first input on SDI port in order to meet
+	 * the device communication requirements. If the controller supports
+	 * SPI_LSB_FIRST, this step will be handled by the SPI code.
+	 */
+	addr = FIELD_PREP(MAX14001_MASK_ADDR, reg);
+
+	if (st->spi_hw_has_lsb_first)
+		st->spi_tx_buffer.le = cpu_to_le16(addr);
+	else
+		st->spi_tx_buffer.be = cpu_to_be16(bitrev16(addr));
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	/*
+	 * Convert received 16-bit value to cpu-endian format and reverse
+	 * bit order. If the controller supports SPI_LSB_FIRST, this step
+	 * will be handled by the SPI code.
+	 */
+	if (st->spi_hw_has_lsb_first)
+		data = le16_to_cpu(st->spi_rx_buffer.le);
+	else
+		data = bitrev16(be16_to_cpu(st->spi_rx_buffer.be));
+
+	*val = FIELD_GET(MAX14001_MASK_DATA, data);
+
+	return 0;
+}
+
+static int max14001_write(struct max14001_state *st, unsigned int reg, unsigned int val)
+{
+	unsigned int addr;
+
+	/*
+	 * Prepare SPI transmit buffer 16 bit-value and reverse bit order
+	 * to align with the LSB-first input on SDI port in order to meet
+	 * the device communication requirements. If the controller supports
+	 * SPI_LSB_FIRST, this step will be handled by the SPI code.
+	 */
+	addr = FIELD_PREP(MAX14001_MASK_ADDR, reg) |
+	       FIELD_PREP(MAX14001_MASK_WR, 1) |
+	       FIELD_PREP(MAX14001_MASK_DATA, val);
+
+	if (st->spi_hw_has_lsb_first)
+		st->spi_tx_buffer.le = cpu_to_le16(addr);
+	else
+		st->spi_tx_buffer.be = cpu_to_be16(bitrev16(addr));
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
+		ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		ret = regmap_read(st->regmap, MAX14001_REG_FADC, val);
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
+	.max_register = MAX14001_REG_VERIFICATION(MAX14001_REG_ENBL),
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
+	int ret = 0;
+	bool use_ext_vrefin = false;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->spi_hw_has_lsb_first = spi->mode & SPI_LSB_FIRST;
+	st->chip_info = spi_get_device_match_data(spi);
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
+	if (ret == -ENODEV)
+		ret = 1250000;
+	else
+		use_ext_vrefin = true;
+	st->vref_mV = ret / (MICRO / MILLI);
+
+	if (use_ext_vrefin) {
+		/*
+		 * Configure the MAX14001/MAX14002 to use an external voltage
+		 * reference source by setting the bit 5 of the configuration register.
+		 */
+		ret = regmap_set_bits(st->regmap, MAX14001_REG_CFG,
+				      MAX14001_REG_CFG_BIT_EXRF);
+		if (ret)
+			return dev_err_probe(dev, ret,
+			       "Failed to set External REFIN in Configuration Register\n");
+	}
+
+	ret = max14001_disable_mv_fault(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to disable MV Fault\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct max14001_chip_info max14001_chip_info = {
+	.name = "max14001",
+};
+
+static struct max14001_chip_info max14002_chip_info = {
+	.name = "max14002",
+};
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


