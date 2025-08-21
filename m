Return-Path: <linux-iio+bounces-23106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C1B2FB38
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEB81D20FB8
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF502EC579;
	Thu, 21 Aug 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6dZGkU8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1D2EC56D;
	Thu, 21 Aug 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783568; cv=none; b=OKGKcjr7RWhO4mJdE3asXa4auNAHmbxRAQMlnnMdvy4YpVhNR8ND7nyhaBS9cmzy7n8ks+sXZGkDTD01ga2//k2nTaHF7ZUa5W5IVEjDs12en6a2L55mzmSvqsjOuUfKo6IrxJqZvdNFhjYCM9YidrFZ702sY12rmzwcDbDlQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783568; c=relaxed/simple;
	bh=7+xquo8iNso3S3q+2l++R5bqfslwyRxXbgt7tuMr11I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUD+dqygBjUifAO6u+Ij3mqHGpk426c2OSK+8FD46OJbv2wo/5EgzRaPuqT4cguK4MQ+z0orD3WLLtx1faBgMKIBAajmrP45npTGqyv6n3lgu/SjXQqV0XidsAPo+G8Vtjb/oJirryJJkN0dly4pVeiC0sRmJJQO49HT7iR9jfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6dZGkU8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e434a0118so1338764b3a.0;
        Thu, 21 Aug 2025 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755783566; x=1756388366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj4njmsyh3zCbx5RUFpo8jX4troQZSXvaeL54DQGB4o=;
        b=P6dZGkU8WvSb3tcXXsR+ly9GkbgOo35vnXaU6cGpCDrA2bxUM8E+T1sljoUXSSaDNJ
         6l/06qu4zIYJDGIeug5AioB8HNArlkgFY3HX/QPqctYnaowMbhPqCnLXZj/epMWjKtRK
         nbUCJf6XJSlTACojQ9kUeYvM7B6CprevQADD+XWqxzH3VRsy1dW+SLgLl17BtEQi2DqB
         eJYepR+2lGdkhXr2RmWF+2ngPHhdV7UZWdSHJVkorQ1tP2bx+7YDjBKrGS84wArsTTms
         N/zBv3uSvnOuLuZqjgxmGPWOXzdf9qqZvDxFrVx8fEzDqWSnjyr4x1UCcwhtXAAnUibS
         d/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783566; x=1756388366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rj4njmsyh3zCbx5RUFpo8jX4troQZSXvaeL54DQGB4o=;
        b=isrwUVpwMQOC1vejhvtM2FgXcEOBZ0mtaMq2FX7TgPOBXvwREthQW5hPRETmE2UbSE
         8KWCa7ulgMYuFP3ElaB01zcqidE4vqTCwFIOy0mFAFXsEvnSyN9Zb0sXt9cAFQGj8t54
         elMCBzFRujuoXMJzbcsYG4DZeS2HZSUe+trFgpTNExkNmRhYXvWsXwhy67gqGT/+PLpc
         bjWheL6eIh58LOEikfZ+rd0phR8WMpiqO9gtlBF7hyWEs5FOUDlL5Lsfbuo5rsAWO3we
         YVLh4TH53kzsRJvDxU2udr/VJQXgrVr2VlJX3nhRUkURKm85iZb63g4lmjL/1r/vdrDq
         xQZA==
X-Forwarded-Encrypted: i=1; AJvYcCUQhoPe4og1ahvg9hUCPmjceQmbgzfbwLKXvUFGEr2Z3xpSSBnGOJWHFIk/22H79gaHkp6ExBJhETCf@vger.kernel.org, AJvYcCXtDealGMewQBinWjanm73JERevhm2dqCZC5MQsBhwsKG2GsJXCSHX0mJso9FgVuI9Z/StCNi252hV+LCT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwYY0P2JShFKfRniSXOj2/atvNRWjSzofWPWuc3nszpy7LKi9Kq
	/cBzJnOcl9mrkGuv709DimyMqMJY6znm/HK0DPcondSvWKBnNc9gcvoLIj7WGupkEhg=
X-Gm-Gg: ASbGncunty3TT3SzxiMwdIEeZOF2IJ4+YfIMHAFkUqFXoh0tGZm4CJvz2IUxGRIWuVy
	91vt+6PGcVb8m9Au3wSXCoU9v3+UA0SLwJXdBDBYf2OJoSNRCWtcpHP4NTH2rWPBVto9E9RTiLD
	AL61a994cnQWB/3UH1tCD2L0Lf3XMdDWs4vM4Zb7qL6WIrHFCm/b/WkTj/kJwHTVEDkkGHDI1s5
	YCtIWF7OOCxi5ypdXbLwnMAKjpxBoEKai7K0/i7ARsSu/0+dX+zH3yC8WV+yHGcv5olH89S8D8l
	L5ac/3051Dyil6qZnaGCcbPbuJh/br1Kmujp6VMO/ddCfup0pG5ZDWfWLyD34E+1Ya20LQpnJZb
	hrsOdBNRwcHZXHN4+NOwL9PkliTK+n2h0g2vMx7sDDe3k2Al9QFZWLqR3
X-Google-Smtp-Source: AGHT+IGVfLPyvLTA4cPtSdW3vb/s66FtzKlDSr0s5/nY3RPEypj6xzF9KQ6PPpJGs9cpkInjxJvhLg==
X-Received: by 2002:a05:6a20:3c90:b0:23d:40b6:3f9 with SMTP id adf61e73a8af0-243307c8ebcmr3617273637.13.1755783565514;
        Thu, 21 Aug 2025 06:39:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:9c08:cdb4:8bd9:b0e0:e77c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fba4cesm4886455a12.9.2025.08.21.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:39:25 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
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
Subject: [PATCH v1 2/2] iio: adc: Add basic support for MAX14001
Date: Thu, 21 Aug 2025 10:39:07 -0300
Message-Id: <2919a00f86c1188b83446853bcb9740138d70f44.1755778212.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755778211.git.marilene.agarcia@gmail.com>
References: <cover.1755778211.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14001/MAX14002 are configurable, isolated 10-bit ADCs for
multi-range binary inputs. Besides the ADC readings, the MAX14001/MAX14002
offers more features, like a binary comparator, a filtered reading that
can provide the average of the last 2, 4, or 8 ADC readings, and an inrush
comparator that triggers the inrush current. There is also a fault feature
that can diagnose seven possible fault conditions. And an option to select
an external or internal ADC voltage reference.

Add basic support for MAX14001/MAX14002 with the following features:
- Raw ADC reading.
- Filtered ADC average reading with the default configuration.

Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
---
 MAINTAINERS                |   1 +
 drivers/iio/adc/Kconfig    |  10 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max14001.c | 213 +++++++++++++++++++++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 drivers/iio/adc/max14001.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0aeab5dbd39d..ea5d6d9ba5eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14990,6 +14990,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+F:	drivers/iio/adc/max14001.c
 
 MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
 R:	Iskren Chernev <iskren.chernev@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6de2abad0197..12688c9780e1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -976,6 +976,16 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX14001
+       tristate "Analog Devices MAX14001/MAX14002 ADCs driver"
+       depends on SPI
+       help
+         Say yes here to build support for Analog Devices MAX14001/MAX14002
+         Configurable, Isolated 10-bit ADCs for Multi-Range Binary Inputs.
+
+         To compile this driver as a module, choose M here: the module will be
+         called max14001.
+
 config MAX34408
 	tristate "Maxim max34408/max344089 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1c6ca5fd4b6d..05b930a1bce5 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
new file mode 100644
index 000000000000..fb79f3b81e0c
--- /dev/null
+++ b/drivers/iio/adc/max14001.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MAX14001/MAX14002 SPI ADC driver
+ *
+ * Copyright (c) 2025 Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
+ */
+
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/bitrev.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
+
+/* MAX14001 registers definition */
+#define MAX14001_REG_ADC				0x00
+#define MAX14001_REG_FADC				0x01
+#define MAX14001_REG_FLAGS				0x02
+#define MAX14001_REG_FLTEN				0x03
+#define MAX14001_REG_THL				0x04
+#define MAX14001_REG_THU				0x05
+#define MAX14001_REG_INRR				0x06
+#define MAX14001_REG_INRT				0x07
+#define MAX14001_REG_INRP				0x08
+#define MAX14001_REG_CFG				0x09
+#define MAX14001_REG_ENBL				0x0A
+#define MAX14001_REG_ACT				0x0B
+#define MAX14001_REG_WEN				0x0C
+
+/* MAX14001 CONTROL values*/
+#define MAX14001_REG_WRITE				0x1
+#define MAX14001_REG_READ				0x0
+
+/* MAX14001 MASKS */
+#define MAX14001_MASK_ADDR				GENMASK(15, 11)
+#define MAX14001_MASK_WR				BIT(10)
+#define MAX14001_MASK_DATA				GENMASK(9, 0)
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
+
+	__be16 rx_buffer __aligned(IIO_DMA_MINALIGN);
+	__be16 tx_buffer;
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
+static int max14001_spi_read(struct max14001_state *st, u16 reg, int *val)
+{
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = &st->tx_buffer,
+			.len = sizeof(st->tx_buffer),
+			.cs_change = 1,
+		},
+		{
+			.rx_buf = &st->rx_buffer,
+			.len = sizeof(st->rx_buffer),
+		},
+	};
+	int ret;
+
+	st->tx_buffer = FIELD_PREP(MAX14001_MASK_ADDR, reg) |
+			FIELD_PREP(MAX14001_MASK_WR, MAX14001_REG_READ);
+	st->tx_buffer = bitrev16(st->tx_buffer);
+
+	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret < 0)
+		return ret;
+
+	st->rx_buffer = bitrev16(be16_to_cpu(st->rx_buffer));
+	*val = FIELD_GET(MAX14001_MASK_DATA, st->rx_buffer);
+
+	return 0;
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
+		ret = max14001_spi_read(st, MAX14001_REG_ADC, val);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		ret = max14001_spi_read(st, MAX14001_REG_FADC, val);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = 10;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
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
+static int max14001_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct max14001_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
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
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &max14001_info;
+	indio_dev->channels = max14001_channel;
+	indio_dev->num_channels = ARRAY_SIZE(max14001_channel);
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
+	if (ret < 0)
+		st->vref_mv = 1250000 / 1000;
+	else
+		st->vref_mv = ret / 1000;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id max14001_id_table[] = {
+	{ "max14001", (kernel_ulong_t)&max14001_chip_info_tbl[max14001] },
+	{ "max14002", (kernel_ulong_t)&max14001_chip_info_tbl[max14002] },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, max14001_id_table);
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
+MODULE_AUTHOR("Marilene Andrade Garcia <marilene.agarcia@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices MAX14001/MAX14002 ADCs driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


