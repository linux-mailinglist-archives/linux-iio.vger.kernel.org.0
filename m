Return-Path: <linux-iio+bounces-23266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65516B34DF7
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 23:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F169B48743B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683E28C039;
	Mon, 25 Aug 2025 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLoKvoS2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA928467B;
	Mon, 25 Aug 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157177; cv=none; b=BhQevTHVmnQ8n/9Y/S0Lh0UTtVLE0tx7aBfsEYlVm+YGA3pA6WEBVyP0npWTrr+jDUvwqvxF7YvqaJ0o9oAmse6dxyFeMHSNf7JIgikVtBh+IZo8wJn/Nb+mZVKJdebWri9+kuzz/TyIui1rtqsVrfIMKyT29RKNMMwZGQWNbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157177; c=relaxed/simple;
	bh=ZqITVkuU/WtCZZNhVI/JxDVWxBXCSfmQaFO/4rNP3Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HK9K4WRf0PgiVdP3yMzitSPW46beyI6Hn0d7O/yyixwPrbaT8WXSWN+0FcOQvCh8FLzuW2Nle+G7/85Ro9i+j0mvFVfGyicRKHAogtwPE2QgChIQGxygqAHMZdvc/Oqgzxxmq+pUU7/xUpKipU7WnZ4irOQ7Grj4gw1DujnyH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLoKvoS2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e202e0so4374644a91.2;
        Mon, 25 Aug 2025 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756157173; x=1756761973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR93L6JS5JVt1PsM0eh5o5SQq28LAsnFmZ0I7aPIrvQ=;
        b=bLoKvoS2FrTd2nUj4jTn23FVrQQODiJX1INRhPQtAxjyEvae6ZTFeGMmQ5zgb3tlzW
         zk9+Hg4+E5howLWe0Ys9X3B8/VP81BGsPX1SUJgnvsoDfhVayo8k43d19Hftxcf1H0Va
         LkTQcyQwa9LOkQPdnjTM0NLxEran2/A1r/KGLbKVGUkBvXHK9bvgE+gqN2gha2zKWkTf
         CHrKjbHG0ThaSCfikGHUSWsyv+w4+2JRZGkuBPkDLaA/ZxEW8CWW7dsrq+Io3mFHYt2S
         jenTltkplPA6J8nmYrZaPZsNTy6YBl10dGh7pmHI7I8OSjaxD2nko52Y+qWkzqfXfcvw
         rABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157173; x=1756761973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR93L6JS5JVt1PsM0eh5o5SQq28LAsnFmZ0I7aPIrvQ=;
        b=fCsZI2upNEZlZahObyotk2khv8pjsLe1YRjNVn7L905xA2+K178yfw35Iv6VSk4hMj
         v2Wzi89QJWlts6D2VviYG2pLO382xwdqOzt4vStfs5gCgq0pUGHJ4s8rn327VqT0Jtic
         Fen8ot89pwWD49ZHpXoPDLSYo/KACU32BGGRFtV2gMRmmPI4H6IEbFALuAqA6tECJ8Aw
         pQcDs6T/5iufJv6261jPB40BHklTH6LUXYMBL0Gy6aolOIgjgp740q4LULLciZew0OU9
         PLJxEBlDxr0wqzpEZnp9PtbxxjPVAeZjcNUzaPCInM4AqA8f+9Met7XJovJ4Ad9u8XIv
         snbg==
X-Forwarded-Encrypted: i=1; AJvYcCVHUpawXK5Oqh4fzA7D/7nRBIWr62Xkr+4EG7b+FVl0ShIwmjkTjD6FWrLLdphSebPlj3oynfqBe5LS@vger.kernel.org, AJvYcCW/ZzF68yE8jBWLxmhaAJcNsw8PyMyvsWsAP5ShGVdpSjOwRy5icQk4PgWhDxT6/JiL/XO9YQwSa9rRjGup@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbnQIDgU9kioUrj63ED43R8Ki0OVzOctHtAuVwuQQXJqsPqip
	BzWKXJBw7ocaj81jaI42P7Taj7w5uSRGbprSQjjkbBZ49qonxx8PDjwIsr1NFuUrKJw=
X-Gm-Gg: ASbGnctDWKcWKk4PQgyT2BAJBpahZxuFeAV/RggOLXRSKD5sowPJhNweSIin+uSzibh
	tnWr2IzyARVT/6eaJwfRRkyE4wewnp+KxoqaIRGXYl2FLFoqx+fLVZqbZll6F6qs3ksObXX1sJ3
	/O8ohru7+hgjptJRys6rcezcEUH0Yirp0jQmhEj0GXXvRgtIYugCeSTm3U1f3AdFmfovV/nTXs5
	+pITmbq5+pZEldQ2yzXV3exQePfMLXFjHVsqc4W4JzvnEapq50LjLrQhX1NLk4v32cfY46nE2oT
	2Hh1y64hEoOgBwd4/t/3He1amrItNuSE/eeNE8lkiHqO/k1AKGkP8tRbPnw+O3vyoLfNrt3dCL+
	qKMiO2giQ2YFqezth5c1cDMF4sw==
X-Google-Smtp-Source: AGHT+IFwDNgaw5B9s3t9PMOS/BzrPeVFpNdomtJrybpYy2Dtf9ykLX19F1/w9PLzQS9chsHpqxLZqA==
X-Received: by 2002:a17:90b:2892:b0:323:39c0:8e74 with SMTP id 98e67ed59e1d1-3251744bc8dmr18374014a91.24.1756157173055;
        Mon, 25 Aug 2025 14:26:13 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:38cc:eb35:b786:98be:f27d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3274595e506sm13502a91.5.2025.08.25.14.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:26:12 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	alexandru.ardelean@analog.com,
	jlc23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Marcelo.Schmitt@analog.com,
	dumitru.ceclan@analog.com,
	Jonathan.Santos@analog.com,
	dragos.bogdan@analog.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v1 2/2] iio: adc: Add initial support for MAX22531 ADC
Date: Tue, 26 Aug 2025 02:55:49 +0530
Message-Id: <edc52c93e0d4e08619ba8a98674aeb7d49e6dd1b.1756115378.git.jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756115378.git.jain.abhinav177@gmail.com>
References: <cover.1756115378.git.jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device support for MAX22530-MAX22531.
Implement scale and read functionality for raw/filtered ADC readings.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 MAINTAINERS                |   1 +
 drivers/iio/adc/Kconfig    |  10 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max22531.c | 191 +++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 drivers/iio/adc/max22531.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f26db9cf742..8a63faf1bde7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14708,6 +14708,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml
+F:	drivers/iio/adc/max22531.c
 
 MAX31335 RTC DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ea3ba1397392..a35c3c945e27 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -933,6 +933,16 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX22531
+        tristate "Analog Devices MAX22531 ADC Driver"
+        depends on SPI
+        help
+          Say yes here to build support for field-side self-powered 12-bit
+	   isolated Maxim ADCs. (max22530, max22531, max22532).
+
+	   To compile this driver as a module, choose M here: the module will be
+	   called max22531.
+
 config MAX34408
 	tristate "Maxim max34408/max344089 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 09ae6edb2650..0429d9da571f 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX22531) += max22531.o
 obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
diff --git a/drivers/iio/adc/max22531.c b/drivers/iio/adc/max22531.c
new file mode 100644
index 000000000000..fb035225e426
--- /dev/null
+++ b/drivers/iio/adc/max22531.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MAX22531 SPI ADC Driver
+ *
+ * Copyright (C) 2025 Abhinav Jain
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max22530-max22532.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/unaligned.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
+
+#define MAX22531_REG_PROD_ID		0x00
+#define MAX22531_REG_ADC_CHAN(x)	((x) + 1)
+#define MAX22531_REG_FADC_CHAN(x)	((x) + 1)
+
+#define MAX22531_VREF_MV		1800
+#define MAX22531_DEVICE_REV_MSK		GENMASK(6, 0)
+#define MAX22531_DEVICE_REV		0x01
+
+#define MAX22531_REG_ADDR_MASK		GENMASK(7, 2)
+#define MAX22531_REG_WRITE_MASK		BIT(1)
+
+enum max22531_id {
+	max22530,
+	max22531,
+	max22532,
+};
+
+struct max22531_chip_info {
+	const char *name;
+};
+
+static struct max22531_chip_info max22531_chip_info_tbl[] = {
+	[max22530] = {
+		.name = "max22530",
+	},
+	[max22531] = {
+		.name = "max22531",
+	},
+	[max22532] = {
+		.name = "max22532",
+	},
+};
+
+struct max22531 {
+	struct spi_device *spi_dev;
+	const struct max22531_chip_info *chip_info;
+};
+
+#define MAX22531_CHANNEL(ch)						\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (ch),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				BIT(IIO_CHAN_INFO_AVERAGE_RAW),         \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	}
+
+static const struct iio_chan_spec max22531_channels[] = {
+	MAX22531_CHANNEL(0),
+	MAX22531_CHANNEL(1),
+	MAX22531_CHANNEL(2),
+	MAX22531_CHANNEL(3),
+};
+
+static int max22531_reg_read(struct max22531 *adc, unsigned int reg,
+			     unsigned int *readval)
+{
+	u8 cmd;
+
+	cmd = FIELD_PREP(MAX22531_REG_ADDR_MASK, reg);
+	*readval = spi_w8r16be(adc->spi_dev, cmd);
+	if (*readval < 0)
+		return *readval;
+
+	return 0;
+}
+
+static int max22531_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max22531 *adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max22531_reg_read(adc, MAX22531_REG_ADC_CHAN(chan->channel), val);
+		if (ret)
+			return ret;
+	return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		ret = max22531_reg_read(adc, MAX22531_REG_FADC_CHAN(chan->channel), val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = MAX22531_VREF_MV;
+		*val2 = 12;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max22531_info = {
+	.read_raw = max22531_read_raw,
+};
+
+static int max22531_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct max22531 *adc;
+	unsigned int prod_id;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->spi_dev = spi;
+	adc->chip_info = spi_get_device_match_data(spi);
+	if (!adc->chip_info)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				"no chip info\n");
+
+	indio_dev->name = adc->chip_info->name;
+	indio_dev->info = &max22531_info;
+	indio_dev->channels = max22531_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max22531_channels);
+
+	ret = devm_regulator_get_enable(&spi->dev, "vddl");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+		       "Failed to retrieve power logic supply.\n");
+
+	ret = devm_regulator_get_enable(&spi->dev, "vddpl");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+		       "Failed to retrieve isolated DC-DC supply.\n");
+
+	ret = max22531_reg_read(adc, MAX22531_REG_PROD_ID, &prod_id);
+	if (ret ||
+	    FIELD_GET(MAX22531_DEVICE_REV_MSK, prod_id) != MAX22531_DEVICE_REV)
+		dev_warn(&spi->dev, "PROD_ID verification failed\n");
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id max22531_id[] = {
+	{ "max22530", (kernel_ulong_t)&max22531_chip_info_tbl[max22530] },
+	{ "max22531", (kernel_ulong_t)&max22531_chip_info_tbl[max22531] },
+	{ "max22532", (kernel_ulong_t)&max22531_chip_info_tbl[max22532] },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max22531_id);
+
+static const struct of_device_id max22531_spi_of_id[] = {
+	{ .compatible = "adi,max22530",
+		.data = &max22531_chip_info_tbl[max22530], },
+	{ .compatible = "adi,max22531",
+		.data = &max22531_chip_info_tbl[max22531], },
+	{ .compatible = "adi,max22532",
+		.data = &max22531_chip_info_tbl[max22532], },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max22531_spi_of_id);
+
+static struct spi_driver max22531_driver = {
+	.driver = {
+		.name = "max22531",
+		.of_match_table = max22531_spi_of_id,
+	},
+	.probe		= max22531_probe,
+	.id_table	= max22531_id,
+};
+module_spi_driver(max22531_driver);
+
+MODULE_AUTHOR("Abhinav Jain <jain.abhinav177@gmail.com>");
+MODULE_DESCRIPTION("MAX22531 ADC");
+MODULE_LICENSE("GPL");
-- 
2.34.1


