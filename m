Return-Path: <linux-iio+bounces-25081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8ABDC949
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 07:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC5318A61DE
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 05:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891182FD7D2;
	Wed, 15 Oct 2025 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThrKdF8g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329C2F7AB0
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505165; cv=none; b=Z7jeJ4Qpc+8NYEM+P5CoGwf9qwW0XQCwwe0UH+OWthYN6qT6qqtvA0wsr2H7evis8usErzuZ50qId2MSfzIoaVINX3I9yLI33/+LUAk1lq/+RiNZAenh4x9PtBJZ3iOol27PRBSe4OmLNRB0sajLKSE0Nl+ksSvM8rY6lYpoGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505165; c=relaxed/simple;
	bh=9ZCXg82wJsw3k/Plz/MQ6fbUZ2GA85JYlNbL/yU/wtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JiP8VVA9phvM/o7kgkgKyIy3nFbE37t7lxB/+OIcB+s6Z/315tuMQkUrf6FS88v+sLCHhf8/LtS9qci1ypGgGuGT5GxdHtT8p3mGSXKPVEkE5Ic0DQ/I41hXev7lWieDj1syaol7to8yhLy1k8jMXdLTbxoT47KUaVfovlcrPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThrKdF8g; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32ec291a325so4457257a91.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 22:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760505162; x=1761109962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5VbCFsT9dmfzRAee48Cbj9ew1lrNkurqw310Q/XABo=;
        b=ThrKdF8g50+fW3nnQ/Wfvdsvy97/CaU7QBpp/jg35HZlDnlirx1OL+0bIunLKGJJWU
         RsKJVeh/8FCE1l3t9ZvRPKIkbwBMycXrgqX3FCdgaL8oRmn5n14wzcbaQp4EphG09lgJ
         EWsxXDzW3Cq0KYiTMCtdl6fl5u2o2BwQlFSgdqWT+B/xtcF+C1Dz0WqsooG4LWu2VO5A
         f4ymaZ7uhFoIBYjBIa+xhk8eJ0ia6MeClmihOoTrcgjeKC/VFUCGed69HtBljwAl2Xlz
         hePMD+28lbJSv3KIAIr4ALOnIkhourTgtEO17y7Kb7uS3JiMrjoz3SNABSZjV2RNeaUw
         kMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505162; x=1761109962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5VbCFsT9dmfzRAee48Cbj9ew1lrNkurqw310Q/XABo=;
        b=krcEHrdETccVCiZujyg/BIRfVBrEPRgaBKdMgEGbmbuHfgD7C6GmKXk1tOOr+PoC8S
         POPV2SvvHQf0Acgc7nINcrmScM1zLQjKJ2M74v0QLfRUZKV4UfNenx4mmp3UYjKX7uV2
         rtEANlHNDVzAJzfTxJwOtyeXAYkJSEEbOVL3g1H5opDSxLNit8xLHd6J9RR5BebFeK9l
         dTqdAmL7xbfwwX3KlYWpnEc6LiHsVc1c15gZbLf1hHAsR9YpHVA90yCfzKnQohZXqDu4
         HJMg+vLPdwiGZL6QCvDyMKubymrZ7y4gxWM0/qFAL4AKPKM2UiFDsqT05QjOXZV7RioK
         vAGQ==
X-Gm-Message-State: AOJu0Yzl3evW1JXMiZvD24wy/hkF1nOXg/P9vk/B6YbX6g7IKS/gY63D
	9b3o+6iCHwXQfCrXJgnNqJMGmXID9KqrCU0sGS/L3MQe0ExZ+t541J6RamJoPS1p
X-Gm-Gg: ASbGncvvpjpay3kEEkCd9tjqPVsv1a4di86VCL+AaT6bodXQetuNkkqSneMvSDK6Fv+
	y7D6hWnErI8XFuhxQP7RrylY6Q3RjPMqvN2ZrRW3IoNdgTJXrn87Zh6rQ8KVl6E0BwaLh/TYgX0
	xf3rFG+LjIjYknUYI58QZTJm4D5PVXplS+9d4ut4OBF/C4karklWQGmJW0Qbe1+h8jWWlSEczx1
	gIvSZDYGnn+LZ6Re+21WXkHFSIMRhjoPXqJSqgG9jErO5Df3Akm67IZNMXGuhji5vJcj33GFxFR
	o8gx7LdgJc0C8cu4lx2NQAbA6pb2jdOkEen2mPHxfmRwFVXAnEwhl8q7/orxZUdRCbf3mL+fME2
	SlSwd6XftdJsT/9la6lF0T4txGWs5RdPK1it/rD1zPY0+zBnrB6R5sC64/GYg9j7otop9s2l3r/
	lC07dQqV9+5g==
X-Google-Smtp-Source: AGHT+IEp64Y0msYiZJ016ZCLkH/tw6IF8U6znbISVckS+ZWtlrT4iTuSjRk6Fgl/MHsaWjZ+qzSb/w==
X-Received: by 2002:a17:90b:3a8a:b0:32e:ddbc:9bd6 with SMTP id 98e67ed59e1d1-33b5138408emr37533177a91.27.1760505162200;
        Tue, 14 Oct 2025 22:12:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:9826:e291:f414:9cb9:f6e4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a08c4b7d6sm1116903a12.7.2025.10.14.22.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:12:41 -0700 (PDT)
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
Subject: [PATCH v13 2/2] iio: adc: max14001: New driver
Date: Wed, 15 Oct 2025 02:12:08 -0300
Message-Id: <2e0e5fadeb3083a79a31776d9e996b865c1b1f5f.1760502331.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
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
- MV fault disable.
- Selection of external or internal ADC voltage reference, depending on
whether it is declared in the device tree.

Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---

Hello maintainers,
Thank you for reviewing v12.
I believe I have addressed the requested code changes.

As discussed, I have dropped the averaging feature from this series and I
am going to add it in a later series. Also, because of that, I am not going
to send the patch related to the in_voltageY_mean_raw ABI documentation
change, but I did take notes about your suggestion in my v12 version patch
related to that, David, thanks.

As I said before, I intend to continue sending patches to implement all the
features of the device. It will be at a low frequency, but consistently.

Thank you, Marcelo, for the code example and for testing on your end as
well. In my tests, I also got 0x80 from the FLAGS (0x02) register. I 
thought it could be because I am using low voltage as power input, as I am
using the 5V provided by the Raspberry Pi. As soon as I get a proper power
supply, I am going to investigate that.

Notes:
I have returned the st->chip_info null check as requested in the v12
reviews, even though I had dropped it because of a suggestion in v11.

Best regards,
Marilene Andrade Garcia


 MAINTAINERS                |   1 +
 drivers/iio/adc/Kconfig    |  10 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max14001.c | 391 +++++++++++++++++++++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 drivers/iio/adc/max14001.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f584196d3260..940889b158eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15181,6 +15181,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+F:	drivers/iio/adc/max14001.c
 
 MAX15301 DRIVER
 M:	Daniel Nilsson <daniel.nilsson@flex.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b0580fcefef5..31335af6b2f1 100644
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
index ed647a734c51..e5349b01e4d9 100644
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
index 000000000000..90ad4cb5868d
--- /dev/null
+++ b/drivers/iio/adc/max14001.c
@@ -0,0 +1,391 @@
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
+	 * SPI_LSB_FIRST, this step will be handled by the SPI controller.
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
+	 * will be handled by the SPI controller.
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
+	 * SPI_LSB_FIRST, this step will be handled by the SPI controller.
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
+	/* Enable writing to the SPI register. */
+	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_REG_WEN_VALUE_WRITE);
+	if (ret)
+		return ret;
+
+	/* Writing data into SPI register. */
+	ret = max14001_write(st, reg, val);
+	if (ret)
+		return ret;
+
+	/* Disable writing to the SPI register. */
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
+	/* Enable writing to the SPI registers. */
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
+	/* Disable writing to the SPI registers. */
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
+static const struct regmap_range max14001_regmap_rd_range[] = {
+	regmap_reg_range(MAX14001_REG_ADC, MAX14001_REG_ENBL),
+	regmap_reg_range(MAX14001_REG_WEN, MAX14001_REG_WEN),
+	regmap_reg_range(MAX14001_REG_VERIFICATION(MAX14001_REG_FLTEN),
+			 MAX14001_REG_VERIFICATION(MAX14001_REG_ENBL)),
+};
+
+static const struct regmap_access_table max14001_regmap_rd_table = {
+	.yes_ranges = max14001_regmap_rd_range,
+	.n_yes_ranges = ARRAY_SIZE(max14001_regmap_rd_range),
+};
+
+static const struct regmap_range max14001_regmap_wr_range[] = {
+	regmap_reg_range(MAX14001_REG_FLTEN, MAX14001_REG_WEN),
+	regmap_reg_range(MAX14001_REG_VERIFICATION(MAX14001_REG_FLTEN),
+			 MAX14001_REG_VERIFICATION(MAX14001_REG_ENBL)),
+};
+
+static const struct regmap_access_table max14001_regmap_wr_table = {
+	.yes_ranges = max14001_regmap_wr_range,
+	.n_yes_ranges = ARRAY_SIZE(max14001_regmap_wr_range),
+};
+
+static const struct regmap_config max14001_regmap_config = {
+	.reg_read = max14001_read,
+	.reg_write = max14001_write_single_reg,
+	.max_register = MAX14001_REG_VERIFICATION(MAX14001_REG_ENBL),
+	.rd_table = &max14001_regmap_rd_table,
+	.wr_table = &max14001_regmap_wr_table,
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
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int max14001_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct max14001_state *st;
+	int ret;
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
+	if (!st->chip_info)
+		return -EINVAL;
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


