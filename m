Return-Path: <linux-iio+bounces-13741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08DD9FA18B
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 17:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4DB188E539
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C054176AA1;
	Sat, 21 Dec 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNglucNA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8E1714BF;
	Sat, 21 Dec 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734796792; cv=none; b=gg9q8CsoLEOS0GA4lTW5BZ4rqrr7/GjcSHmyozoEaX0GIvf8ZADUgUUdnqe5Nr4Xn2AXITIwXfkSMcjul8lWuEjO2VkXqnqtiOUsE0bWZAqVjFA4F48T6Md6uFPghxBdFqbTkKv8CMnCjF6WjYSZ92g8bRyP9YTf6yQaUG+fG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734796792; c=relaxed/simple;
	bh=/ZD5e6oK2LehOID8qtWlCaHfEvonkLcieVSWIXLDOwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2RUfLrOI66Up8sgVN/pUc9P0/eYGmG/ulumBdLIQ51axbZmSZzFcsLwfGxcCutEM9Ii06pIlQsGQ96KS82l7DmNL50Qu6IHLJLU1QUEVESLfJUPQe2gbckWJB8kRGiuU4mQD9nDdyqL2nvereu/7YhG+SCCsIhTwVsUy0WLcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNglucNA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso20992085e9.1;
        Sat, 21 Dec 2024 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734796789; x=1735401589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCAwJBOtc0qPt38oBijxaF81J5VQndfefd2rjiDc9LU=;
        b=BNglucNAwp4RpR/UcWK3bzi6TBE8OsyQjEbsFENQn3ylS0YaLOvEIWEcRNBORhgvYy
         EbnM7f21LjKhm8Su/dwDfihAVMbt6T1S9Cfp6CpZaQbndlm80ZVvGOIb4Hh4Ka+9WXil
         7qlZw2atwJhAQog+YCUBLR9uDDvMg4fgP+63vMPTxgb62PxAvl+SbPcK+zemIQUgeeeU
         9em1jyBVb0I31w16EQYaEWKP1zg+jVThtKiEF+1qPyGIZfnP0JleKpqDazkrX9PDTv7v
         nSKN/c35MGx1RltOAG23jg+rkFekd2sw/9MFYZlt9E+JpzNW+C0TNF4HLj8sYyY4m2SK
         F0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734796789; x=1735401589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCAwJBOtc0qPt38oBijxaF81J5VQndfefd2rjiDc9LU=;
        b=HRzs5Ak3uOJ1Dt2xCOl8DEIiCVP5IdWEzKAo/nfYEc/zMNan7iLgjhL1tFa6Srri3Z
         njrjRHcw2Ea5fIoDb49rHIQ0Pr6kT7eqJcMOcyehuKQjNjgK58z7RiowVGyxdH19j++4
         yZuhBmYNyGqaN7PagCvTc0sUakFixxkkt9zMSXN8y5fy4ieqmOYJA4kChWOm6fPb6czl
         I8I8fxqef1nmi2YaXr/qaiPcMksD93uwbcucR93N5MnfYW8VnS8fhLHl0cN5XyHMfj+i
         6j6HuwDBMbXRFz3/pZbOxcU98QgW+4xK7iHwmv3FEYBCuUCp05baqSRQxfCepW9XW7wO
         9t0A==
X-Forwarded-Encrypted: i=1; AJvYcCU7CK+2DKHhvbl8xDN6Kwv2AVsmb8HjyeUrs3MXIbplY++atGMbjnOqPaMKMoq8Q/8LTbdfbm9TQLBXnThG@vger.kernel.org, AJvYcCUH3xqKdyczmQEu9WG2GlQgerLythLflTnfpfX0iHfAdapH5MFPaol7rAru54/bBHkyW8INJm3quTby@vger.kernel.org, AJvYcCUdXqt/3YeaUq08Ll+wevxvr8BuclcYjg7h6JhO4eR1q6+4hof7xOEBfe4HMGOkOSl0ovCeRdRUJyqU@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTIdpgn95OpmeFUWPiZQR6rNCyDf42GzRBbnPozbTC1Rr3Mo3
	9bZKB1eXbGlBYTge+caFL9lIBeknrkf0gcq6I+taPpvGNQ/nTApJ
X-Gm-Gg: ASbGnctr8dgVJaIzxyNHT+k2pjb4NEGd3a3AMy5Jv30YK3lj9jClx9DhHeulJW09y/5
	zg7VNpJQ6Xr5s9oTR0haRG9DVLQyeRM7iJ+6BHi/apNeF1Ypdk2LIXrD8OL7SNZar7VLPK524xd
	L5vXfXVG5RER4RFuVSTtD9lEb/T3ZetWC3zVg5mgFqoqRBZBoNpY2hR3k1qVfzhi7+PzXX2mZG/
	KeP02Xzvr/8hDHSDSJKsrI5qOkDn7GbiiMfpldb2fSVaivVbszofhHA
X-Google-Smtp-Source: AGHT+IGH2fVXtzP/ZVzXuotreitnREOUWa+EKYuSyb0b+sqXtv063TMW5bm2ZmHGLmCYKeH3e7Prhg==
X-Received: by 2002:a5d:5f4a:0:b0:385:fdc2:1808 with SMTP id ffacd0b85a97d-38a223f7172mr7145431f8f.40.1734796788566;
        Sat, 21 Dec 2024 07:59:48 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:604:8900:a4e6:d95:2e66:864e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8b874asm6751081f8f.109.2024.12.21.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 07:59:48 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v1 3/3] iio: adc: ad7191: add AD7191
Date: Sat, 21 Dec 2024 17:56:02 +0200
Message-ID: <20241221155926.81954-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241221155926.81954-1-alisa.roman@analog.com>
References: <20241221155926.81954-1-alisa.roman@analog.com>
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
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7191.c | 513 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 526 insertions(+)
 create mode 100644 drivers/iio/adc/ad7191.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 254fbfe6144f..caaf1960ac85 100644
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
index 849c90203071..434610af3d39 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -112,6 +112,17 @@ config AD7173
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7173.
 
+config AD7191
+	tristate "Analog Devices AD7191 ADC driver"
+	depends on SPI
+	select AD_SIGMA_DELTA
+	help
+	  Say yes here to build support for Analog Devices AD7191.
+	  If unsure, say N (but it's safe to say "Y").
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
index 000000000000..6509e974072a
--- /dev/null
+++ b/drivers/iio/adc/ad7191.c
@@ -0,0 +1,513 @@
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
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/adc/ad_sigma_delta.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#define AD7191_NAME			"ad7191"
+
+#define AD7191_TEMP_CODES_PER_DEGREE	2815
+
+#define AD7191_EXT_FREQ_HZ_MIN		2457600
+#define AD7191_EXT_FREQ_HZ_MAX		5120000
+#define AD7191_INT_FREQ_HZ		4915200
+
+#define AD7191_CHAN_MASK		BIT(0)
+#define AD7191_TEMP_MASK		BIT(1)
+
+#define AD7191_PGA1_MASK		BIT(0)
+#define AD7191_PGA2_MASK		BIT(1)
+
+#define AD7191_ODR1_MASK		BIT(0)
+#define AD7191_ODR2_MASK		BIT(1)
+
+#define AD7191_CH_AIN1_AIN2		0
+#define AD7191_CH_AIN3_AIN4		1
+#define AD7191_CH_TEMP			2
+
+/* NOTE:
+ * The AD7191 features a dual use data out ready DOUT/RDY output.
+ * In order to avoid contentions on the SPI bus, it's therefore necessary
+ * to use spi bus locking.
+ *
+ * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
+ */
+
+struct ad7191_state {
+	struct ad_sigma_delta		sd;
+	struct mutex			lock; // to protect sensor state
+
+	struct gpio_desc		*odr1_gpio;
+	struct gpio_desc		*odr2_gpio;
+	struct gpio_desc		*pga1_gpio;
+	struct gpio_desc		*pga2_gpio;
+	struct gpio_desc		*temp_gpio;
+	struct gpio_desc		*chan_gpio;
+	struct gpio_desc		*clksel_gpio;
+
+	u16				int_vref_mv;
+	u8				gain_index;
+	u32				scale_avail[4][2];
+	u8				samp_freq_index;
+	u32				samp_freq_avail[4];
+
+	struct clk			*mclk;
+	u32				fclk;
+};
+
+static struct ad7191_state *ad_sigma_delta_to_ad7191(struct ad_sigma_delta *sd)
+{
+	return container_of(sd, struct ad7191_state, sd);
+}
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
+static int ad7191_set_mode(struct ad_sigma_delta *sd,
+			   enum ad_sigma_delta_mode mode)
+{
+	struct ad7191_state *st = ad_sigma_delta_to_ad7191(sd);
+
+	return ad_sd_assert_cs(&st->sd);
+}
+
+static const struct ad_sigma_delta_info ad7191_sigma_delta_info = {
+	.set_channel = ad7191_set_channel,
+	.set_mode = ad7191_set_mode,
+	.has_registers = false,
+	.irq_flags = IRQF_TRIGGER_FALLING,
+};
+
+static inline bool ad7191_valid_external_frequency(u32 freq)
+{
+	return (freq >= AD7191_EXT_FREQ_HZ_MIN &&
+		freq <= AD7191_EXT_FREQ_HZ_MAX);
+}
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
+static int ad7191_init_gpios(struct iio_dev *indio_dev)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
+
+	st->odr1_gpio = devm_gpiod_get(dev, "odr1", GPIOD_OUT_LOW);
+	if (IS_ERR(st->odr1_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->odr1_gpio),
+				     "Failed to get odr1 gpio.\n");
+
+	st->odr2_gpio = devm_gpiod_get(dev, "odr2", GPIOD_OUT_LOW);
+	if (IS_ERR(st->odr2_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->odr2_gpio),
+				     "Failed to get odr2 gpio.\n");
+
+	st->pga1_gpio = devm_gpiod_get(dev, "pga1", GPIOD_OUT_LOW);
+	if (IS_ERR(st->pga1_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->pga1_gpio),
+				     "Failed to get pga1 gpio.\n");
+
+	st->pga2_gpio = devm_gpiod_get(dev, "pga2", GPIOD_OUT_LOW);
+	if (IS_ERR(st->pga2_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->pga2_gpio),
+				     "Failed to get pga2 gpio.\n");
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
+	st->clksel_gpio = devm_gpiod_get(dev, "clksel", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->clksel_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->clksel_gpio),
+				     "Failed to get clksel gpio.\n");
+
+	return 0;
+}
+
+static int ad7191_clock_setup(struct ad7191_state *st)
+{
+	struct device *dev = &st->sd.spi->dev;
+
+	if (!device_property_present(dev, "mclk")) {
+		gpiod_set_value(st->clksel_gpio, 1);
+		st->fclk = AD7191_INT_FREQ_HZ;
+		return 0;
+	}
+
+	gpiod_set_value(st->clksel_gpio, 0);
+
+	st->mclk = devm_clk_get_enabled(dev, "mclk");
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(dev, PTR_ERR(st->mclk),
+				     "Failed to get clock source\n");
+
+	st->fclk = clk_get_rate(st->mclk);
+	if (!ad7191_valid_external_frequency(st->fclk))
+		return dev_err_probe(dev, -EINVAL,
+				     "External clock frequency out of bounds\n");
+
+	return 0;
+}
+
+static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	u64 scale_uv;
+	int gain[4] = {1, 8, 64, 128};
+	int i;
+	int ret;
+
+	ret = ad7191_init_regulators(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7191_init_gpios(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7191_clock_setup(st);
+	if (ret)
+		return ret;
+
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
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			mutex_lock(&st->lock);
+			*val = st->scale_avail[st->gain_index][0];
+			*val2 = st->scale_avail[st->gain_index][1];
+			mutex_unlock(&st->lock);
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
+		*val = st->samp_freq_avail[st->samp_freq_index];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7191_set_gain(struct ad7191_state *st, u8 gain_index)
+{
+	u8 pga1_gpio_val, pga2_gpio_val;
+
+	if (!FIELD_FIT(AD7191_PGA1_MASK | AD7191_PGA2_MASK, gain_index))
+		return -EINVAL;
+
+	st->gain_index = gain_index;
+
+	pga1_gpio_val = FIELD_GET(AD7191_PGA1_MASK, gain_index);
+	pga2_gpio_val = FIELD_GET(AD7191_PGA2_MASK, gain_index);
+
+	gpiod_set_value(st->pga1_gpio, pga1_gpio_val);
+	gpiod_set_value(st->pga2_gpio, pga2_gpio_val);
+
+	return 0;
+}
+
+static int ad7191_set_samp_freq(struct ad7191_state *st, u8 samp_freq_index)
+{
+	u8 odr1_gpio_val, odr2_gpio_val;
+
+	if (!FIELD_FIT(AD7191_ODR1_MASK | AD7191_ODR2_MASK, samp_freq_index))
+		return -EINVAL;
+
+	st->samp_freq_index = samp_freq_index;
+
+	odr1_gpio_val = FIELD_GET(AD7191_ODR1_MASK, samp_freq_index);
+	odr2_gpio_val = FIELD_GET(AD7191_ODR2_MASK, samp_freq_index);
+
+	gpiod_set_value(st->odr1_gpio, odr1_gpio_val);
+	gpiod_set_value(st->odr2_gpio, odr2_gpio_val);
+
+	return 0;
+}
+
+static int ad7191_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	int ret, i;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = -EINVAL;
+		mutex_lock(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
+			if (val2 == st->scale_avail[i][1]) {
+				ret = ad7191_set_gain(st, i);
+				break;
+			}
+		mutex_unlock(&st->lock);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!val) {
+			ret = -EINVAL;
+			break;
+		}
+		mutex_lock(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(st->samp_freq_avail); i++)
+			if (val == st->samp_freq_avail[i]) {
+				ret = ad7191_set_samp_freq(st, i);
+				break;
+			}
+		mutex_unlock(&st->lock);
+		break;
+	default:
+		ret = -EINVAL;
+	}
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
+#define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _type, \
+	_differential, _mask_type_av) \
+	{ \
+		.type = (_type), \
+		.differential = _differential, \
+		.indexed = 1, \
+		.channel = (_channel1), \
+		.channel2 = (_channel2), \
+		.address = (_address), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_OFFSET), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_type_available = (_mask_type_av), \
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.scan_index = (_si), \
+		.scan_type = { \
+			.sign = 'u', \
+			.realbits = 24, \
+			.storagebits = 24, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define AD719x_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
+	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, IIO_VOLTAGE, 1, \
+		BIT(IIO_CHAN_INFO_SCALE))
+
+#define AD719x_TEMP_CHANNEL(_si, _address) \
+	__AD719x_CHANNEL(_si, 0, -1, _address, IIO_TEMP, 0, 0)
+
+static const struct iio_chan_spec ad7191_channels[] = {
+	AD719x_TEMP_CHANNEL(0, AD7191_CH_TEMP),
+	AD719x_DIFF_CHANNEL(1, 1, 2, AD7191_CH_AIN1_AIN2),
+	AD719x_DIFF_CHANNEL(2, 3, 4, AD7191_CH_AIN3_AIN4),
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
+	mutex_init(&st->lock);
+
+	indio_dev->name = AD7191_NAME;
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
+static struct spi_driver ad7191_driver = {
+	.driver = {
+		.name	= AD7191_NAME,
+		.of_match_table = ad7191_of_match,
+	},
+	.probe		= ad7191_probe,
+};
+module_spi_driver(ad7191_driver);
+
+MODULE_AUTHOR("Alisa-Dariana Roman <alisa.roman@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7191 ADC");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.43.0


