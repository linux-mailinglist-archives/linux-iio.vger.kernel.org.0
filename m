Return-Path: <linux-iio+bounces-14531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADC4A19279
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE0A3A6DC6
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC652139D7;
	Wed, 22 Jan 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erv3ndX5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF572139C9;
	Wed, 22 Jan 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552555; cv=none; b=mMtffIzwC5xAoLPBuizurF7y6DLLsLYNmT7eTY74bDKsxBBfclhNQDvcsYZUTdBEKS4pqD3I8RUGCoRoTH5JWd4xGcCgWlN0flw/stY4mJDQ2E599Gw0krRLd7vxszzEP40NnABEWJZ9HKrD/kPjrN+PArjR06FDq04n5fIeMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552555; c=relaxed/simple;
	bh=ql9MKMBhsPU7thmBJLnSPJMzd/AmebkfrkDwg+C5cLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxGxz56r16ihdG2HYqk3ml2IeRChixoAKlB9p4l3pL56+06pe0lJDhByx2nHyJbE45ZYFGvAlMBpX+H9WbM/TrKLOxa7Rx/2PGBHPddJ+nKSKLeKilTycdhcB3GQFYRpxr9yyetSWyHTnhi8tsxw4iDcEw/o3Wt0E1i/Z5agjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erv3ndX5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so584453f8f.0;
        Wed, 22 Jan 2025 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737552551; x=1738157351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3XJfkgeLGntL4rs5FH69AE1jX3hPZw2dVzWRJcepqQ=;
        b=Erv3ndX5ElNleVh4oMjT63I4ynVKwNhlHQP7EIYcqbXRvbetqqEikhGHyUcLrrohCv
         F5E4/xSv7qHrtI7HIHMxJprzCiZa4yoz2v8NsU+lABK98sSAGSM6ubKzf9Gg727io7bF
         3uLowYcMuAKCFbJDLbm6RXJGGAke0FhtyCA7X7UgsU5IRgGUntC/m1AhPxxeCpKggNBr
         Ktv8Ycua6dc7MGJNOJcuLvl+3qMOk37HAWMM+JvG9RaxeciyIErktPulY3Y85phmt8A2
         pg+NxovdoXxThkWXOGu8jffa9cZl+/ZQPZGI6igbPdocmUBG+GOkr+DaBZUxlo7Bja0Z
         he5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737552551; x=1738157351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3XJfkgeLGntL4rs5FH69AE1jX3hPZw2dVzWRJcepqQ=;
        b=I8/LNmiHU9aVog1CEa3bN2W/ef2G4WNHbQMNeaefNoVZYoozziZDf4B+OnSREyPXkM
         zTReSKd0euocgJvP/EDeoVnn3fpAr3vPq3ZLNbglUF+7YhWpy/nBl3bAPi5BhqHp+EXF
         6eCnEIwSSnbhtqMKstPd0OXF9xvA1T6S/C4QoT4ashlYO5DEUwfS3bTArcGvksONPpwj
         lwRAZyNC17FfpFvHWQq761/oCART8X+6MJPpwcDDSjQPERTuWOLenr3nmtg0IEeMJJcj
         6vKhsHdah7JNY8V3jokssnhGkQsYHloVLq7pSbAtmWQtDzO28xCux0m2ayLilmx3j9v3
         LDPw==
X-Forwarded-Encrypted: i=1; AJvYcCV0AdchZEU9cVeL0B0+o++sXqt02npfwumkFif4PCBhx4R4uV7gTyy4YPVeQMPS686mmo2EcK1B4KgWpfmM@vger.kernel.org, AJvYcCVLwQV38gtf+GW9Z217he/3KSzbSyxaEdUzkbxsJdTy5tWBcgB+0h+wE+2H8gEG3DOtXirnMyniqzeN@vger.kernel.org, AJvYcCWSbwj9YDFHEUrd43myg3nq43G3jbZHGMP0g70M4Ou5oQD5oic3x73L0dkSAFyuGGlsXq7yJBAGSGuEDA==@vger.kernel.org, AJvYcCWqidXfjc1lLLygIiHZuapVlCOrmh5D0KYwgjRLnSyj40BmWA4D9rJIFeXeGm9Hq1XYsx+R5xwx5LsB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0S/nWeqBJo8CHC6Pnl/c9Bvm3igVIcqvir+IM47hI5srw1Rv2
	3GF1TycPkbuzAbONV1uj4gKk4+dMQ6Ec3pfGwuUZwEDT/xTe3pXH
X-Gm-Gg: ASbGnctVGnKi4/9fkNtwS1owDD6fe8ExNzr2ObuhBHBYZ0o9xVwGBaBTkBvyq4cu2T4
	02JPal1XQNzp5CmM9ynEZWeEA/ymAZwMA656HCu/DYMw2we1kZrtS1PQDgM1SnR8MhPa8LmdQUz
	LRioV8QbLpJ2AtNrhaJAsGyweW/8Amntj1Lr6wz0ThGL7iWSl+w/XJXG+mACHovatfWsOpzJVSe
	BvRHeJuSpsOyeRmtRD5V8ouZbr9lLmhNjWIQ3sLxqbCG604CkfnJle4IjK2IE0D
X-Google-Smtp-Source: AGHT+IEMUmV8Mfo3dJxc72aHrdLZoejJc1A2amPuAsB8UVibkRmODIGCWM/7NwssJ9YqrBERfQCmMw==
X-Received: by 2002:a5d:6da7:0:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-38bf5ac66camr19196192f8f.5.1737552551046;
        Wed, 22 Jan 2025 05:29:11 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf328847esm16481241f8f.98.2025.01.22.05.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:29:10 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/2] iio: adc: ad7191: add AD7191
Date: Wed, 22 Jan 2025 15:20:40 +0200
Message-ID: <20250122132821.126600-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122132821.126600-1-alisa.roman@analog.com>
References: <20250122132821.126600-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
designed for precision bridge sensor measurements. It features two
differential analog input channels, selectable output rates,
programmable gain, internal temperature sensor and simultaneous
50Hz/60Hz rejection.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  10 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7191.c | 570 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 582 insertions(+)
 create mode 100644 drivers/iio/adc/ad7191.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 262beced3143..1340c27d9e5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1308,6 +1308,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
+F:	drivers/iio/adc/ad7191.c
 
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alisa-Dariana Roman <alisa.roman@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..70a662846aa2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -112,6 +112,16 @@ config AD7173
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7173.
 
+config AD7191
+	tristate "Analog Devices AD7191 ADC driver"
+	depends on SPI
+	select AD_SIGMA_DELTA
+	help
+	  Say yes here to build support for Analog Devices AD7191.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7191.
+
 config AD7192
 	tristate "Analog Devices AD7192 and similar ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7..54335c613988 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AD7091R5) += ad7091r5.o
 obj-$(CONFIG_AD7091R8) += ad7091r8.o
 obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7173) += ad7173.o
+obj-$(CONFIG_AD7191) += ad7191.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7280) += ad7280a.o
diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
new file mode 100644
index 000000000000..dd8151ad3f3f
--- /dev/null
+++ b/drivers/iio/adc/ad7191.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD7191 ADC driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/adc/ad_sigma_delta.h>
+
+#define ad_sigma_delta_to_ad7191(sigmad)	container_of((sigmad), struct ad7191_state, sd)
+
+#define AD7191_TEMP_CODES_PER_DEGREE	2815
+
+#define AD7191_EXT_CLK_ENABLE		0
+#define AD7191_INT_CLK_ENABLE		1
+
+#define AD7191_CHAN_MASK		BIT(0)
+#define AD7191_TEMP_MASK		BIT(1)
+
+#define AD7191_MAX_ODR_STATE		3
+#define AD7191_MAX_PGA_STATE		3
+
+enum ad7191_channel {
+	AD7191_CH_AIN1_AIN2 = 0,
+	AD7191_CH_AIN3_AIN4,
+	AD7191_CH_TEMP
+};
+
+/*
+ * NOTE:
+ * The AD7191 features a dual-use data out ready DOUT/RDY output.
+ * In order to avoid contentions on the SPI bus, it's therefore necessary
+ * to use SPI bus locking.
+ *
+ * The DOUT/RDY output must also be wired to an interrupt-capable GPIO.
+ */
+
+struct ad7191_state {
+	struct ad_sigma_delta		sd;
+	struct mutex			lock; // to protect sensor state
+
+	struct gpio_descs		*odr_gpios;
+	struct gpio_descs		*pga_gpios;
+	struct gpio_desc		*temp_gpio;
+	struct gpio_desc		*chan_gpio;
+	struct gpio_desc		*clksel_gpio;
+
+	u16				int_vref_mv;
+	u32				pga_state;
+	u32				scale_avail[4][2];
+	u32				odr_state;
+	u32				samp_freq_avail[4];
+
+	struct clk			*mclk;
+	u32				clksel_state;
+};
+
+static int ad7191_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
+{
+	struct ad7191_state *st = ad_sigma_delta_to_ad7191(sd);
+	u8 temp_gpio_val, chan_gpio_val;
+
+	if (!FIELD_FIT(AD7191_CHAN_MASK | AD7191_TEMP_MASK, channel))
+		return -EINVAL;
+
+	chan_gpio_val = FIELD_GET(AD7191_CHAN_MASK, channel);
+	temp_gpio_val = FIELD_GET(AD7191_TEMP_MASK, channel);
+
+	gpiod_set_value(st->chan_gpio, chan_gpio_val);
+	gpiod_set_value(st->temp_gpio, temp_gpio_val);
+
+	return 0;
+}
+
+static int set_cs(struct ad_sigma_delta *sigma_delta, int pull_down)
+{
+	struct spi_transfer t = {
+		.len = 0,
+		.cs_change = pull_down,
+	};
+	struct spi_message m;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	return spi_sync_locked(sigma_delta->spi, &m);
+}
+
+static int ad7191_set_mode(struct ad_sigma_delta *sd,
+			   enum ad_sigma_delta_mode mode)
+{
+	struct ad7191_state *st = ad_sigma_delta_to_ad7191(sd);
+
+	switch (mode) {
+	case AD_SD_MODE_CONTINUOUS:
+	case AD_SD_MODE_SINGLE:
+		return set_cs(&st->sd, 1);
+	case AD_SD_MODE_IDLE:
+		return set_cs(&st->sd, 0);
+	default:
+		return 0;
+	}
+}
+
+static const struct ad_sigma_delta_info ad7191_sigma_delta_info = {
+	.set_channel = ad7191_set_channel,
+	.set_mode = ad7191_set_mode,
+	.has_registers = false,
+};
+
+static int ad7191_init_regulators(struct iio_dev *indio_dev)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
+	int ret;
+
+	ret = devm_regulator_get_enable(dev, "avdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable specified AVdd supply\n");
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable specified DVdd supply\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get Vref voltage\n");
+
+	st->int_vref_mv = ret / 1000;
+
+	return 0;
+}
+
+static int ad7191_gpio_setup(struct iio_dev *indio_dev)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
+
+	if (device_property_read_u32(dev, "adi,odr-state", &st->odr_state) == 0) {
+		if (st->odr_state > AD7191_MAX_ODR_STATE)
+			return dev_err_probe(dev, -EINVAL, "Invalid ODR state.\n");
+
+		dev_info(dev, "ODR is pin-strapped to %d\n", st->odr_state);
+		st->odr_gpios = NULL;
+	} else {
+		st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
+		if (IS_ERR(st->odr_gpios))
+			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
+					     "Failed to get odr gpios.\n");
+	}
+
+	if (device_property_read_u32(dev, "adi,pga-state", &st->pga_state) == 0) {
+		if (st->odr_state > AD7191_MAX_PGA_STATE)
+			return dev_err_probe(dev, -EINVAL, "Invalid PGA state.\n");
+
+		dev_info(dev, "PGA is pin-strapped to %d\n", st->pga_state);
+		st->pga_gpios = NULL;
+	} else {
+		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
+		if (IS_ERR(st->pga_gpios))
+			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
+					     "Failed to get pga gpios.\n");
+	}
+
+	if (device_property_read_u32(dev, "adi,clksel-state", &st->clksel_state) == 0) {
+		dev_info(dev, "CLKSEL is pin-strapped to %d\n", st->clksel_state);
+		st->clksel_gpio = NULL;
+	} else {
+		st->clksel_gpio = devm_gpiod_get(dev, "clksel", GPIOD_OUT_HIGH);
+		if (IS_ERR(st->clksel_gpio))
+			return dev_err_probe(dev, PTR_ERR(st->clksel_gpio),
+					     "Failed to get clksel gpio.\n");
+	}
+
+	st->temp_gpio = devm_gpiod_get(dev, "temp", GPIOD_OUT_LOW);
+	if (IS_ERR(st->temp_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->temp_gpio),
+				     "Failed to get temp gpio.\n");
+
+	st->chan_gpio = devm_gpiod_get(dev, "chan", GPIOD_OUT_LOW);
+	if (IS_ERR(st->chan_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->chan_gpio),
+				     "Failed to get chan gpio.\n");
+
+	return 0;
+}
+
+static int ad7191_clock_setup(struct ad7191_state *st)
+{
+	struct device *dev = &st->sd.spi->dev;
+	u8 clksel_value;
+
+	st->mclk = devm_clk_get_enabled(dev, "mclk");
+	if (IS_ERR(st->mclk)) {
+		if (PTR_ERR(st->mclk) != -ENOENT)
+			return dev_err_probe(dev, PTR_ERR(st->mclk),
+					     "Failed to get mclk.\n");
+
+		/*
+		 * No external clock found, default to internal clock.
+		 */
+		clksel_value = AD7191_INT_CLK_ENABLE;
+		if (!st->clksel_gpio && st->clksel_state != AD7191_INT_CLK_ENABLE)
+			return dev_err_probe(dev, -EINVAL,
+				"Invalid CLKSEL state. To use the internal clock, CLKSEL must be high.\n");
+
+		dev_info(dev, "Using internal clock.\n");
+	} else {
+		clksel_value = AD7191_EXT_CLK_ENABLE;
+		if (!st->clksel_gpio && st->clksel_state != AD7191_EXT_CLK_ENABLE)
+			return dev_err_probe(dev, -EINVAL,
+				"Invalid CLKSEL state. To use the external clock, CLKSEL must be low.\n");
+
+		dev_info(dev, "Using external clock.\n");
+	}
+
+	if (st->clksel_gpio)
+		gpiod_set_value(st->clksel_gpio, clksel_value);
+
+	return 0;
+}
+
+static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	u64 scale_uv;
+	const int gain[4] = {1, 8, 64, 128};
+	int i, ret;
+
+	ret = ad7191_init_regulators(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7191_gpio_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7191_clock_setup(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * Sampling frequencies in Hz, available in the documentation, Table 5.
+	 */
+	st->samp_freq_avail[0] = 120;
+	st->samp_freq_avail[1] = 60;
+	st->samp_freq_avail[2] = 50;
+	st->samp_freq_avail[3] = 10;
+
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+		scale_uv = ((u64)st->int_vref_mv * NANO) >>
+			   (indio_dev->channels[0].scan_type.realbits - 1);
+		do_div(scale_uv, gain[i]);
+		st->scale_avail[i][1] = do_div(scale_uv, NANO);
+		st->scale_avail[i][0] = scale_uv;
+	}
+
+	return 0;
+}
+
+static int ad7191_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long m)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			guard(mutex)(&st->lock);
+			*val = st->scale_avail[st->pga_state][0];
+			*val2 = st->scale_avail[st->pga_state][1];
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = NANO / AD7191_TEMP_CODES_PER_DEGREE;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -(1 << (chan->scan_type.realbits - 1));
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val -= 273 * AD7191_TEMP_CODES_PER_DEGREE;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->samp_freq_avail[st->odr_state];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7191_set_gain(struct ad7191_state *st, int gain_index)
+{
+	unsigned long value = gain_index;
+
+	if (!st->pga_gpios)
+		return -EPERM;
+
+	st->pga_state = gain_index;
+
+	return gpiod_set_array_value(2, st->pga_gpios->desc,
+				     st->pga_gpios->info, &value);
+
+	return 0;
+}
+
+static int ad7191_set_samp_freq(struct ad7191_state *st, int samp_freq_index)
+{
+	unsigned long value = samp_freq_index;
+
+	if (!st->odr_gpios)
+		return -EPERM;
+
+	st->odr_state = samp_freq_index;
+
+	return gpiod_set_array_value(2, st->odr_gpios->desc,
+				     st->odr_gpios->info, &value);
+}
+
+static int __ad7191_write_raw(struct ad7191_state *st,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		guard(mutex)(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+			if (val2 != st->scale_avail[i][1])
+				continue;
+			return ad7191_set_gain(st, i);
+		}
+		return -EINVAL;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!val)
+			return -EINVAL;
+
+		guard(mutex)(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(st->samp_freq_avail); i++) {
+			if (val != st->samp_freq_avail[i])
+				continue;
+			return ad7191_set_samp_freq(st, i);
+		}
+		return -EINVAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7191_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = __ad7191_write_raw(st, chan, val, val2, mask);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int ad7191_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7191_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, const int **vals,
+			     int *type, int *length, long mask)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(st->scale_avail) * 2;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)st->samp_freq_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(st->samp_freq_avail);
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info ad7191_info = {
+	.read_raw = ad7191_read_raw,
+	.write_raw = ad7191_write_raw,
+	.write_raw_get_fmt = ad7191_write_raw_get_fmt,
+	.read_avail = ad7191_read_avail,
+	.validate_trigger = ad_sd_validate_trigger,
+};
+
+static const struct iio_chan_spec ad7191_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.address = AD7191_CH_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 24,
+			.endianness = IIO_BE,
+		},
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.differential = 1,
+		.indexed = 1,
+		.channel = 1,
+		.channel2 = 2,
+		.address = AD7191_CH_AIN1_AIN2,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 24,
+			.endianness = IIO_BE,
+		},
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.differential = 1,
+		.indexed = 1,
+		.channel = 3,
+		.channel2 = 4,
+		.address = AD7191_CH_AIN3_AIN4,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 24,
+			.endianness = IIO_BE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static int ad7191_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ad7191_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (!spi->irq) {
+		dev_err(dev, "no IRQ?\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "ad7191";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad7191_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7191_channels);
+	indio_dev->info = &ad7191_info;
+
+	ad_sd_init(&st->sd, indio_dev, spi, &ad7191_sigma_delta_info);
+
+	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7191_setup(indio_dev, dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad7191_of_match[] = {
+	{
+		.compatible = "adi,ad7191",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7191_of_match);
+
+static const struct spi_device_id ad7191_id_table[] = {
+	{ "ad7191", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7191_id_table);
+
+static struct spi_driver ad7191_driver = {
+	.driver = {
+		.name = "ad7191",
+		.of_match_table = ad7191_of_match,
+	},
+	.probe = ad7191_probe,
+};
+module_spi_driver(ad7191_driver);
+
+MODULE_AUTHOR("Alisa-Dariana Roman <alisa.roman@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7191 ADC");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.43.0


