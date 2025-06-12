Return-Path: <linux-iio+bounces-20536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1362EAD6D19
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4524B1888B9D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE8232392;
	Thu, 12 Jun 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxdtk5Et"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4223183A;
	Thu, 12 Jun 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722945; cv=none; b=Mm+ca+ZaggETXpykacrk7RHt7PTthIwNY9fqzxeNID9B39CqzLMHpftt/GN+UsD9/gRdSWYelOWn2xNrr0YP/vBtM8iFU2VZzfUPQFbrWqimjL6EPhIpkkLtpl7Ksx9u5isj+ISzv6yLRN+MuUruEVdXNEBEVUyUni9zxzEQeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722945; c=relaxed/simple;
	bh=f7oHRJcj57ZuowpE2v7Li+TXZhWIkKVI+TglYi4dxPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzOpf15W9QTwuxD332Xx6GF8rh6cP/R9fA4M6ml2T1Q3BV5ymnh+qSzsjTHYGP0L/FXxNCjeS38di1DmlDBgkzOIzIDZY8PktBRXvoNgET1bv5FIofQGEpuJXGteYhJLEh/V8lkdIz3YxnNaIoLbklBcPzyHbXEb8cuE4Mhz+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxdtk5Et; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso706544a91.2;
        Thu, 12 Jun 2025 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749722943; x=1750327743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+pe9nHdu3Pur38A2ExM5dkEncqLXlC7kh5yGMIL2UM=;
        b=Rxdtk5EtT8iDcD82Z69jXelBXnYrFxrmHadMEdygnq2dOLnz1RieFfTkFHMWcr68rj
         h302Hxj7whXfwmYsY7dOsQeBGDidzvDvbLCRynMH7ArdA/ew3oYw4TExpGIkBDSLl+2X
         zlhv1PSIipBSKhoi/yODOL1o3JT0uB5rblqe7dfDcccIQuyo5Ia2T8SvH9O675rUTpyq
         iHZYIMTIYRKZYFeNjLLIZbevH8QntMf8jC1344q4aav3RqYdmiKzR/6gOyV3Utwg6UEt
         4NWkX3g2XLZLmQ++DXuOntpKak4DU1ofyOGdU2JmDqqVumQZeg20+T3tfzxclDXXHltk
         4Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749722943; x=1750327743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+pe9nHdu3Pur38A2ExM5dkEncqLXlC7kh5yGMIL2UM=;
        b=t63wYsQ22Vu/qZOnAzYYRxadevUDu19dDeU2iBsXZt6MiRkj3UofgUZLhI37QKW7w8
         YwKTJoOz57ZBafBIP06a2P1JOmOcA37nB7FDF6lRd/rYLzobYd9RMKfazu9kUL+xB7q1
         akA+nXnzZdV1qOr62ZWLN8iP9nxCk8SxvFtsuEKg8c32KslLl+dAFPNcGgIKcQF9+gAQ
         thEQ0SGnRakgn/q4lpovj+NK923Y0DvE5kLeUv4iJ4PR6RCGA0av1Wz7TEdSoshnJYrJ
         GZunPiNULy5LAUuiPDrNzB3BDFU+Qb7xOGtN7Xz/jF8LydA23dBeHwJbpLoxlT5rDMd0
         ExUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+BFCdBVrjqxbV3rbL4B4MiXxIwFa6YisVlYV3f0RiE7a+q+BNu5Je1jbX1WqwHHcvEO3URjj9q31F5J5F@vger.kernel.org, AJvYcCXM4PPwa6J+y2yCQvo6J93rlNLP/FQekvy4XxhIU/rTjGbHST/IcSxvV9QnaOJP6Vxj/t8IEI/aUBqg@vger.kernel.org, AJvYcCXUisuYCJHQiL2SylVP1DVuzuZFYx4H2sCV6Nxz45r4Mxn9nxBYHocbWf8WdtHRbo6YZNgLU7t8fNXS@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqraVW22zVE/s6Uw4h5fHafAviFhSspJU6E1k9VBjPrm+Jnlw
	DRhiqkoHTgLhKlq3YhO+YLRU80FceARYNJ6jPs5fD98PJVFn9dCI31sQ
X-Gm-Gg: ASbGncvnG7TyK9o498iwsA4gQ3j9J03vNkDWS5gdOHvHt93wJvVIz6bjdzogetjR/lM
	G4DEUe7gsiJHZ4tNMIyBo6ivIeYcKO2X6pgcg/YL36itsjM6/Q8OZO7jmYuxjjC5CZnCujls/ol
	gar12+AfZDVt779Z7MhN+Tx5Kls9La+YN050tni+aPes0UwgTIMW1I6vTUdBKU/QbVYjnkM1FAg
	yo4x6xg2XD6AdmMJOmLIjMTpsFfRNuVhXAXziwrrqK7KIkfIZGsMSv/IIf2Uq7Igl/KUXdrJmUy
	a4zlunWHqRwcxyZV9jOgupLst2osmBzXsYlZ/M1BFDwSGhCD7F/LHPMYf3DIty/TphEGTEYPO/e
	f4i7L8P5G
X-Google-Smtp-Source: AGHT+IGDwlA0oQD8XV1qwpOnsgc4anpm3QGG/DxOXkT4HjLkGoEUfzBboTaGbLHGE47cNvkuoA6fYw==
X-Received: by 2002:a17:90b:274a:b0:312:e1ec:de44 with SMTP id 98e67ed59e1d1-313af1f4a63mr8605553a91.27.1749722942559;
        Thu, 12 Jun 2025 03:09:02 -0700 (PDT)
Received: from localhost ([2409:4071:4d30:50e6:899a:ff8f:cff5:9bba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6f9b89sm10199075ad.159.2025.06.12.03.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:09:02 -0700 (PDT)
From: surajsonawane0215@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com
Subject: [PATCH v2 3/3] iio: chemical: Add driver for Sharp GP2Y1010AU0F
Date: Thu, 12 Jun 2025 15:37:46 +0530
Message-ID: <20250612100758.13241-4-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612100758.13241-1-surajsonawane0215@gmail.com>
References: <20250612100758.13241-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

Implement support for the Sharp GP2Y1010AU0F optical dust sensor which
measures particulate matter concentration using infrared scattering.
The sensor requires precise 320μs LED pulses with ADC sampling at 280μs
after LED activation (as specified in datasheet section 6-1).

The driver provides:
- Raw density readings via IIO_DENSITY channel type
- Hardware-agnostic operation via GPIO and IIO ADC interfaces
- Power management through regulator framework
- Device Tree binding support

Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1: https://lore.kernel.org/lkml/20250425221214.50255-1-surajsonawane0215@gmail.com/ 
V2:
- Added `reg` property for multi-sensor support
- Moved datasheet reference to tags block
- Hardware interface improvements:
  * Used devm_regulator_get_enable() for power management
  * Consolidated LED ON timing into a single delay block
  * Improved error handling in the ADC read sequence
- Dropped IIO_BUFFER dependencies
- Alphabetized Makefile entry and #includes
- Replaced `extend_name` with proper label callback
- Standardized device logs using `pdev->dev`
- Adopted IIO formatting conventions (brace spacing)
- Switched channel type from IIO_VOLTAGE to IIO_DENSITY
- Adjusted timing values to match datasheet specs

 MAINTAINERS                     |   7 ++
 drivers/iio/chemical/Kconfig    |  10 +++
 drivers/iio/chemical/Makefile   |   1 +
 drivers/iio/chemical/gp2y1010.c | 126 ++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/iio/chemical/gp2y1010.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fff..ed239b60d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22568,6 +22568,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
 F:	Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
 F:	drivers/iio/light/gp2ap002.c
 
+SHARP GP2Y1010AU0F DUST SENSOR DRIVER
+M:	Suraj Sonawane <surajsonawane0215@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
+F:	drivers/iio/chemical/gp2y1010.c
+
 SHARP RJ54N1CB0C SENSOR DRIVER
 M:	Jacopo Mondi <jacopo@jmondi.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index b22afa1f6..35c126836 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -129,6 +129,16 @@ config PMS7003
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called pms7003.
+
+config GP2Y1010AU0F
+	tristate "Sharp GP2Y1010AU0F optical dust sensor"
+	depends on IIO
+	help
+	  Say Y here to build support for Sharp GP2Y1010AU0F optical dust sensor
+	  that measures particulate matter concentration in air.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gp2y1010au0f.
 
 config SCD30_CORE
 	tristate "SCD30 carbon dioxide sensor driver"
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 2287a00a6..f1d932ab0 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CCS811)		+= ccs811.o
 obj-$(CONFIG_ENS160) += ens160_core.o
 obj-$(CONFIG_ENS160_I2C) += ens160_i2c.o
 obj-$(CONFIG_ENS160_SPI) += ens160_spi.o
+obj-$(CONFIG_GP2Y1010AU0F) += gp2y1010.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_MHZ19B) += mhz19b.o
 obj-$(CONFIG_PMS7003) += pms7003.o
diff --git a/drivers/iio/chemical/gp2y1010.c b/drivers/iio/chemical/gp2y1010.c
new file mode 100644
index 000000000..3a8657035
--- /dev/null
+++ b/drivers/iio/chemical/gp2y1010.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Suraj Sonawane <surajsonawane0215@gmail.com>
+ * Sharp GP2Y1010AU0F Dust Sensor Driver
+ * Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+/* Timings based on GP2Y1010AU0F datasheet Section 6-1 */
+#define GP2Y1010_LED_PULSE_US     320  /* Total LED ON time (0.32 ms) */
+#define GP2Y1010_SAMPLE_DELAY_US  280  /* ADC sampling after LED ON (0.28 ms) */
+
+struct gp2y1010_data {
+	struct gpio_desc *led_gpio;
+	struct iio_channel *adc_chan;
+	int v_clean;  /* Calibration: voltage in clean air (mV) */
+};
+
+static int gp2y1010_read_raw(struct iio_dev *indio_dev,
+							 struct iio_chan_spec const *chan,
+							 int *val, int *val2, long mask)
+{
+	struct gp2y1010_data *data = iio_priv(indio_dev);
+	int ret, voltage_mv;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	gpiod_set_value(data->led_gpio, 1);
+	udelay(GP2Y1010_SAMPLE_DELAY_US);
+
+	ret = iio_read_channel_processed(data->adc_chan, &voltage_mv);
+
+	/* Wait remaining time to complete 320 µs total LED pulse width */
+	udelay(GP2Y1010_LED_PULSE_US - GP2Y1010_SAMPLE_DELAY_US);
+	gpiod_set_value(data->led_gpio, 0);
+
+	if (ret < 0)
+		return ret;
+
+	*val = voltage_mv;
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info gp2y1010_info = {
+	.read_raw = gp2y1010_read_raw,
+};
+
+static const struct iio_chan_spec gp2y1010_channels[] = {
+	{
+		.type = IIO_DENSITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+static int gp2y1010_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct gp2y1010_data *data;
+	enum iio_chan_type ch_type;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->v_clean = 900;
+
+	data->led_gpio = devm_gpiod_get(dev, "led", GPIOD_OUT_LOW);
+	if (IS_ERR(data->led_gpio))
+		return dev_err_probe(dev, PTR_ERR(data->led_gpio), "Failed to get LED GPIO\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return ret;
+	udelay(100);
+
+	data->adc_chan = devm_iio_channel_get(dev, "dust");
+	if (IS_ERR(data->adc_chan))
+		return dev_err_probe(dev, PTR_ERR(data->adc_chan), "Failed to get ADC channel\n");
+
+	ret = iio_get_channel_type(data->adc_chan, &ch_type);
+	if (ret < 0)
+		return ret;
+	if (ch_type != IIO_DENSITY)
+		return dev_err_probe(dev, -EINVAL, "ADC channel is not density type\n");
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &gp2y1010_info;
+	indio_dev->channels = gp2y1010_channels;
+	indio_dev->num_channels = ARRAY_SIZE(gp2y1010_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id gp2y1010_of_match[] = {
+	{ .compatible = "sharp,gp2y1010au0f" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gp2y1010_of_match);
+
+static struct platform_driver gp2y1010_driver = {
+	.driver = {
+		.name = "gp2y1010",
+		.of_match_table = gp2y1010_of_match,
+	},
+	.probe = gp2y1010_probe,
+};
+module_platform_driver(gp2y1010_driver);
+
+MODULE_AUTHOR("Suraj Sonawane <surajsonawane0215@gmail.com>");
+MODULE_DESCRIPTION("Sharp GP2Y1010AU0F Dust Sensor Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


