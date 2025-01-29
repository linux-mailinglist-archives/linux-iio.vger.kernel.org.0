Return-Path: <linux-iio+bounces-14708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9515A21F36
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D907A3A4C3F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E731DDC39;
	Wed, 29 Jan 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/8PNjTL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD632191F84;
	Wed, 29 Jan 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161078; cv=none; b=Dx4lwti68iuoNTK8qAXDi1nzeFlNdd9HBXJVY1CTvf/EugSQlmIrlvqDHHkI+MPFYpTrboiz1/ecAECfdOc/60uY+fE0nQJ9iHzpV0OS/A6W9pLRMkTA5yxI8nnUmXoMUEETgy32LAE0M5nerWFUfeeKsSsYmUKEMvZoJ4CjOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161078; c=relaxed/simple;
	bh=Fb+yBf1aSa554l7zfwFVAB+c1uRAEJ0K3RqrIgz27eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkGYNSLbna5R14aOR56txFu9Xl1t5IpDBqHCP43loHXgSeBOn9P8aCCoJQoSXzoVz7lVuOulWSrFSkSz6Ud8VOs+cUApry6q/N3SbvONK5F+J6gMF3OteV1uI9aGsLGKvIJYxygekKDxQFoKJ2jYIJcXSVcdM1InGZ1yGkzYVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/8PNjTL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863494591bso3826443f8f.1;
        Wed, 29 Jan 2025 06:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738161075; x=1738765875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/8c+q3/mTQbIEjld3OjFvTUMQilGCDIYvt1ArQeF2o=;
        b=S/8PNjTLngY8ZHBXnQgRDUzgXq0/qr4h+875OMI+5rcAS0NSjuOIGkOsjThpS4aQWQ
         DYj3lqH4PbMZVvY4klDTDRXMVgFEzqS+WZ2ZLkwTPMIdds8dOrdXx7IBrZrpiHjB2E58
         2ohx7rCqk7kmFRq0vDPqPxYzp0egtMi1trsRapgtznYbVITM2YOV7VWSue0ysCIcIuXU
         hoDb0s8NusyanylqFfz4sQ7x+UXJWZ7qBuYnLHtyn+fgdWW2ou4Pb/w8tB4w9R9/9qvZ
         fHz2yK1BTiPVL8zvTu5A2zBdIZaRNG3tSNGxfoOVl/0ClowHXqNAj40ZLZk8TLG+3/+8
         J4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161075; x=1738765875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/8c+q3/mTQbIEjld3OjFvTUMQilGCDIYvt1ArQeF2o=;
        b=h62hls3rm1Wq7WYFa+GXoO7tHIW3sxdI2fauXdtyy6wcdCxr38KuM5GUrbXq9oBS7L
         9ao+pzz6nSDvYffb2yw2TixVMM+gqmAk1E6yCmWFdQIPcqj/dcJyd86sExzVN/fSn/IY
         ucSdSZF7hWKKyqSdpMRA6IePf8MCrMUmpFGFJ1U+L9oBzD4tpyMOv/ig3ba0MqSzjyAo
         1Yfj6A9yxRp+Fmy1Ksanbz5AzpR4DmYdk2czPmoToi/qrQNqug4XkfPOkCMrMa26Dim+
         11HxmJTaUoA2BJ9iW6bu3k7uxLqOZaAXWKdQc1SIWnwcuIVGp3ypIaAUao+sNjrfHIcg
         Uqmw==
X-Forwarded-Encrypted: i=1; AJvYcCVLR4RwSlvzCVlurlSilRt+KKkWtKb/y7dy8OnvN0WiMbKPW2z+WHdAQlTmMBO2KBl55wD05LsGJD7L@vger.kernel.org, AJvYcCVhERI9YML/XVVq3RejWyRDr3BXBSJ5qMPu9mEt4ezWSb1tL3Jmr4IZU1dvLCN3Oa3CvFIokob0OYa1@vger.kernel.org, AJvYcCXJ8nrJWFUuF92duV59gMFke0RS9bLNoa3OJTMHoyFK0+8ELitWaPgpeM3r/MjM/55beX5xun0l+77b@vger.kernel.org, AJvYcCXbw28PR5UXFjp30uSyYdroyDDrJQVcjhm5dZkccihBK2dKh0/71I0nOBma9uc8HLf7aItmIGC39HbSVNh7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6UvLQgG1hkzC7Q5dyZy6uGu/aC5k0scwAhZT7Mc/X1ecJW4MR
	BIDKrCOzsemPGMVG+ZajwW9Ws5fGLTqaXXjXSW52NBaxk2S5YFkG
X-Gm-Gg: ASbGncsDWjNtLNWsqSMt2V0ckRf9sh8n2JaL3YiKYAJyfR8iR0SpsOPh5w4wwmMY5Kc
	x8oi9gvmwitB+pHdzS0UIb7sdHEUEqCs7djTuY7+ub2505Okkj+4+DOFFN2FW6fSpEjPH/Ob6lf
	ote0K4eYFl/8jY8wlanq5Bwf/hhE9jwWZXLfCNzcBqEJgzQSMt1jMlWrHwfuVLYnN2w/j08HA54
	e6PbjmzPWTPPVcppiJ+84h6hBPC03K4Pur5oqCcFLT0csYSD8J8Rb8ZcMrsN9k5acQoGm2nWxNx
	mjjrTnJrlXAayOdUicmb9g==
X-Google-Smtp-Source: AGHT+IENr46sXSabP3z9Zk5ivOV4fT8960s1ruKvrtNBKEYVCmmPg5IXrZgGNsgFmdFeNsgZ6K0wCQ==
X-Received: by 2002:a5d:6daf:0:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38c520a383emr3201952f8f.39.1738161074534;
        Wed, 29 Jan 2025 06:31:14 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188c28sm17596201f8f.54.2025.01.29.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:31:14 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 2/3] iio: adc: ad7191: add AD7191
Date: Wed, 29 Jan 2025 16:29:03 +0200
Message-ID: <20250129143054.225322-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129143054.225322-1-alisa.roman@analog.com>
References: <20250129143054.225322-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AD7191 is a pin-programmable, ultra-low noise 24-bit sigma-delta ADC
designed for precision bridge sensor measurements. It features two
differential analog input channels, selectable output rates,
programmable gain, internal temperature sensor and simultaneous
50Hz/60Hz rejection.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  10 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7191.c | 539 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 551 insertions(+)
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
index 000000000000..b6c1d5c25783
--- /dev/null
+++ b/drivers/iio/adc/ad7191.c
@@ -0,0 +1,539 @@
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
+#include <linux/iio/adc/ad_sigma_delta.h>
+#include <linux/iio/iio.h>
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
+enum ad7191_channel {
+	AD7191_CH_AIN1_AIN2,
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
+ *
+ * The SPI controller's chip select must be connected to the PDOWN pin
+ * of the ADC. When CS (PDOWN) is high, it powers down the device and
+ * resets the internal circuitry.
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
+
+	u16				int_vref_mv;
+	u32				pga_index;
+	u32				scale_avail[4][2];
+	u32				odr_index;
+	u32				samp_freq_avail[4];
+
+	struct clk			*mclk;
+};
+
+static int ad7191_set_channel(struct ad_sigma_delta *sd, unsigned int address)
+{
+	struct ad7191_state *st = ad_sigma_delta_to_ad7191(sd);
+	u8 temp_gpio_val, chan_gpio_val;
+
+	if (!FIELD_FIT(AD7191_CHAN_MASK | AD7191_TEMP_MASK, address))
+		return -EINVAL;
+
+	chan_gpio_val = FIELD_GET(AD7191_CHAN_MASK, address);
+	temp_gpio_val = FIELD_GET(AD7191_TEMP_MASK, address);
+
+	gpiod_set_value(st->chan_gpio, chan_gpio_val);
+	gpiod_set_value(st->temp_gpio, temp_gpio_val);
+
+	return 0;
+}
+
+static int ad7191_set_cs(struct ad_sigma_delta *sigma_delta, int assert)
+{
+	struct spi_transfer t = {
+		.len = 0,
+		.cs_change = assert,
+	};
+	struct spi_message m;
+
+	spi_message_init_with_transfers(&m, &t, 1);
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
+		return ad7191_set_cs(&st->sd, 1);
+	case AD_SD_MODE_IDLE:
+		return ad7191_set_cs(&st->sd, 0);
+	default:
+		return -EINVAL;
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
+static int ad7191_config_setup(struct iio_dev *indio_dev)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
+	/* Sampling frequencies in Hz, see Table 5 */
+	const int samp_freq[4] = {120, 60, 50, 10};
+	/* Gain options, see Table 7 */
+	const int gain[4] = {1, 8, 64, 128};
+	int odr_value, pga_value, i, ret;
+	u64 scale_uv;
+
+	st->odr_index = 0;
+	st->pga_index = 0;
+
+	ret = device_property_read_u32(dev, "adi,odr-value", &odr_value);
+	if (ret == EINVAL) {
+		st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
+		if (IS_ERR(st->odr_gpios))
+			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
+					     "Failed to get odr gpios.\n");
+	} else {
+		for (i = 0; i < ARRAY_SIZE(samp_freq); i++) {
+			if (odr_value != samp_freq[i])
+				continue;
+			st->odr_index = i;
+		}
+		st->odr_gpios = NULL;
+	}
+
+	ret = device_property_read_u32(dev, "adi,pga-value", &pga_value);
+	if (ret == EINVAL) {
+		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
+		if (IS_ERR(st->pga_gpios))
+			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
+					     "Failed to get pga gpios.\n");
+	} else {
+		for (i = 0; i < ARRAY_SIZE(gain); i++) {
+			if (pga_value != gain[i])
+				continue;
+			st->pga_index = i;
+		}
+		st->pga_gpios = NULL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(samp_freq); i++)
+		st->samp_freq_avail[i] = samp_freq[i];
+
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+		scale_uv = ((u64)st->int_vref_mv * NANO) >>
+			   (indio_dev->channels[0].scan_type.realbits - 1);
+		do_div(scale_uv, gain[i]);
+		st->scale_avail[i][1] = do_div(scale_uv, NANO);
+		st->scale_avail[i][0] = scale_uv;
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
+
+	st->mclk = devm_clk_get_optional_enabled(dev, "mclk");
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(dev, PTR_ERR(st->mclk),
+				     "Failed to get mclk.\n");
+
+	return 0;
+}
+
+static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)
+{
+	struct ad7191_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad7191_init_regulators(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7191_config_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7191_clock_setup(st);
+	if (ret)
+		return ret;
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
+		case IIO_VOLTAGE: {
+			guard(mutex)(&st->lock);
+			*val = st->scale_avail[st->pga_index][0];
+			*val2 = st->scale_avail[st->pga_index][1];
+			return IIO_VAL_INT_PLUS_NANO;
+		}
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
+		*val = st->samp_freq_avail[st->odr_index];
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
+	st->pga_index = gain_index;
+
+	return gpiod_set_array_value_cansleep(st->pga_gpios->ndescs,
+					      st->pga_gpios->desc,
+					      st->pga_gpios->info, &value);
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
+	st->odr_index = samp_freq_index;
+
+	return gpiod_set_array_value_cansleep(st->odr_gpios->ndescs,
+					      st->odr_gpios->desc,
+					      st->odr_gpios->info, &value);
+}
+
+static int __ad7191_write_raw(struct ad7191_state *st,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+			if (val2 != st->scale_avail[i][1])
+				continue;
+			return ad7191_set_gain(st, i);
+		}
+		return -EINVAL;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(st->samp_freq_avail); i++) {
+			if (val != st->samp_freq_avail[i])
+				continue;
+			return ad7191_set_samp_freq(st, i);
+		}
+		return -EINVAL;
+	}
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
+			.storagebits = 32,
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
+			.storagebits = 32,
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
+			.storagebits = 32,
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
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7191_sigma_delta_info);
+	if (ret)
+		return ret;
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
+	{ "ad7191" },
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
+	.id_table = ad7191_id_table,
+};
+module_spi_driver(ad7191_driver);
+
+MODULE_AUTHOR("Alisa-Dariana Roman <alisa.roman@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7191 ADC");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.43.0


