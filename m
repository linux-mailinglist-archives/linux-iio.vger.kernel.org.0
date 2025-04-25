Return-Path: <linux-iio+bounces-18673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790EA9D53A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 00:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF7F17A56B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A807233151;
	Fri, 25 Apr 2025 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1+hCgQU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF91221DAA;
	Fri, 25 Apr 2025 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619158; cv=none; b=mb0h/XTzSiShpG8r9Sw125OKSrZM2oIrbOg+qZobl5UP293a47uAUJOzLlqEoPPKuNZsNJRmJRl0/SkfOFl9+UpB6CGetJSTfsidL4msBErdjUGnJwsNQ+ZFdjEucDsDVF6XnsuVTp1jLTKxHI5x+ZXVrVQnakHW2P50JhUhiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619158; c=relaxed/simple;
	bh=HaxWlJXEnqP0Q4kS337DhcjmtUk5/l/0PzKWe0VaGAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5pMjYmrSczL9oqOHjPr6wtWasiOHuCA20DNiokXix8Bv4S/WbjURwOWjRVBr1aqEawSDCypLwB0HaGsJo+q1yK5WiDHqeAfqjK0jDyWSSS79cNNoRawOQktz7xIy+xEoGXSuhq+od6jH07Ax8nA3s1CjD++FJcNKouyUdMJPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1+hCgQU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af523f4511fso2687176a12.0;
        Fri, 25 Apr 2025 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745619156; x=1746223956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itqstrdmH5Is3gaSpYc42q1IBkOIt522nr0sdqw5g0w=;
        b=Z1+hCgQURfO/ysYR/GjlK76eBcu3WC1VxBRpAOjMcr778omKGRApo05QlhodByhsFN
         Jtk2QTdTO6ymlgNSxsAmVJ/BP6vdmdimuVHn2ezxGLcKVS5oYcSn1rdTWniMHNUMMnaA
         7BOm2XWx9KTmffZSgYy/dbUeTkWo6E/JnwHe3tySPqiqYSGfIB4H24dpFz97ysSfK/Lb
         HBt/4WX1P8POBH3wzycMrJaeenhR5qEWEf1ocjiRBcmAn2oZz6RsLX/pUi6WhM4xwLdk
         eJ++PwZL03gcXjxO+7hjYj86TCN7LTyWyxNyDzF9dsFJCrl9Bzih1MsivVCR0xQTwqn8
         8EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745619156; x=1746223956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itqstrdmH5Is3gaSpYc42q1IBkOIt522nr0sdqw5g0w=;
        b=ZDOhbcNuHJKdsWIAsnRQ26CwQf5+2YO0zluddEVV2/TnRDhafm1WjVXBSYrMjezYsl
         ZaPIcp4b4PBzoLTj0hRglGOftx0aeEGyD3Vp70Mg4Us16ydLtDLwiD9uxRtnT+u6DIlV
         yXl2QUEBj29/8B/uhjLfBSDuCnEhOg00B5NBUpo7216hoC/IXmp9Qc7NNRvqk0i0gl91
         5OYWQuDbEYqf2nZlBwhe/t+qpSLXyf1F2Kzt8LjukH0jmC6RFyOaNu5vkFmzYRIr7s/p
         FZ2+3NIwgLsm5XBItzV3R8PvSW7DsJWe3cy+2UN1q1EntGXeISJhMl0L1n1UWTA9L+Go
         ajrw==
X-Forwarded-Encrypted: i=1; AJvYcCUbnBAP63PgcRHLsTMhOmPPSdeLHBqCZSrQH45GTEag8mpAsI/hxSKLsCHC+8wIu3/dtzYZinfEDdQ=@vger.kernel.org, AJvYcCUrMtt7U4dDCG1OA2reghxxULsmcNCdEotit+6YPlNKMRBBNnw09TzhA1NhhuQNbOaRccZufAsVkv6VQgme@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsNT4P3EfkXkeAvLjD/lBvT5gn5pfpLG6J9jkZ8gqNKffEmMx
	ZEHsSA0c1PDNOS0iDzZA8KdMfAA5gv23cS6THphC4pjxgdA0TItI
X-Gm-Gg: ASbGncvoMzubIrP5xxEr+7XRZHJF59DfQqqAl2QdCZbQtOhCR6Igi5FMxG8faBlu073
	e3F7dubvO7VtUVxGkoxqoJ3cFhe4lOFg68p9odhQDbRv1QQ5Kxu7U7seDddN2Gcj2jBDE5x+5sg
	KtUW+DAxvVL3SsL2Lw1MdZKsqDug0zf5dDlcGe4fHyML6GAv6xMMPcsp+qM9l7pVMJOTi4v19cZ
	Oo3mvmAYgoBh4YOFqy/cUMwyHcwB8w/JkBDwjFUlkwWdIsLv3QYtMiK0yVblvXJJQDdxZDlGuLM
	yW7aFCYIt/hiq2VPl5QVDv17z/8h41rwN4Z0IIUcXm0m7GpDwtsA
X-Google-Smtp-Source: AGHT+IH3qpqOK2uxGDQZffLdVAEEi8AwAo34+R4Rkt53YWiRe9qAKgdmKldV3ZhM4CYecPfSjt+07A==
X-Received: by 2002:a05:6a20:c707:b0:201:85f4:ade6 with SMTP id adf61e73a8af0-2045b999cf3mr5202978637.27.1745619155779;
        Fri, 25 Apr 2025 15:12:35 -0700 (PDT)
Received: from localhost ([2409:40c0:2025:2c31:c6a3:5653:2e03:8d7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a99454sm3674492b3a.124.2025.04.25.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:12:35 -0700 (PDT)
From: surajsonawane0215@gmail.com
To: jic23@kernel.org
Cc: lars@metafoo.de,
	surajsonawane0215@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: chemical: Add driver for Sharp GP2Y1010AU0F dust sensor
Date: Sat, 26 Apr 2025 03:42:14 +0530
Message-Id: <20250425221214.50255-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

Implement support for the Sharp GP2Y1010AU0F optical dust sensor which
measures particulate matter concentration using infrared scattering. The
sensor requires precise 280us LED pulses with ADC sampling at 200us after
LED activation.

The driver provides:
- Raw voltage readings through IIO interface
- Hardware-agnostic operation via GPIO and IIO ADC interfaces
- Power management through regulator framework
- Device Tree binding support

Device operation:
1. Activate IR LED for 280us
2. Wait 40us after LED activation
3. Sample analog output at 200us (peak sensitivity)
4. Convert voltage to dust density via calibration parameters

Tested on BeagleBone Black with:
- P8_12 (GPIO_44) for LED control
- P9_39 (AIN0) for analog output

Datasheet:
https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 MAINTAINERS                     |   7 ++
 drivers/iio/chemical/Kconfig    |  12 +++
 drivers/iio/chemical/Makefile   |   1 +
 drivers/iio/chemical/gp2y1010.c | 183 ++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 drivers/iio/chemical/gp2y1010.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f31aeb6b4..54e0f67e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21974,6 +21974,13 @@ F:	drivers/iio/chemical/sps30.c
 F:	drivers/iio/chemical/sps30_i2c.c
 F:	drivers/iio/chemical/sps30_serial.c
 
+SHARP GP2Y1010AU0F DUST SENSOR DRIVER
+M:	Suraj Sonawane <surajsonawane0215@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
+F:	drivers/iio/chemical/gp2y1010.c
+
 SERIAL DEVICE BUS
 M:	Rob Herring <robh@kernel.org>
 L:	linux-serial@vger.kernel.org
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 330fe0af9..119c6e6d8 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -100,6 +100,18 @@ config ENS160_SPI
 	tristate
 	select REGMAP_SPI
 
+config GP2Y1010AU0F
+	tristate "Sharp GP2Y1010AU0F optical dust sensor"
+	depends on IIO
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build support for Sharp GP2Y1010AU0F optical dust sensor
+	  that measures particulate matter concentration in air.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gp2y1010au0f.
+
 config IAQCORE
 	tristate "AMS iAQ-Core VOC sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 4866db06b..296bbc0d0 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ENS160) += ens160_core.o
 obj-$(CONFIG_ENS160_I2C) += ens160_i2c.o
 obj-$(CONFIG_ENS160_SPI) += ens160_spi.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
+obj-$(CONFIG_GP2Y1010AU0F) += gp2y1010.o
 obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
diff --git a/drivers/iio/chemical/gp2y1010.c b/drivers/iio/chemical/gp2y1010.c
new file mode 100644
index 000000000..19c09e0e3
--- /dev/null
+++ b/drivers/iio/chemical/gp2y1010.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Suraj Sonawane <surajsonawane0215@gmail.com>
+ *
+ * Sharp GP2Y1010AU0F Dust Sensor Driver
+ *
+ * Datasheet:
+ * https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/consumer.h>
+#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+
+#define GP2Y1010_LED_PULSE_US    280  /* LED on-time (280us) */
+#define GP2Y1010_SAMPLE_DELAY_US  40  /* Wait 40us after LED on */
+#define GP2Y1010_MEASUREMENT_US  200  /* Measure 200us after LED on */
+
+struct gp2y1010_data {
+	struct gpio_desc *led_gpio;
+	struct iio_dev *indio_dev;
+	struct iio_channel *adc_chan;
+	struct regulator *vdd;
+	int v_clean;  /* Calibration: voltage in clean air (mV) */
+};
+
+static int gp2y1010_power_on(struct gp2y1010_data *data)
+{
+	int ret;
+
+	ret = regulator_enable(data->vdd);
+	if (ret) {
+		dev_err(&data->indio_dev->dev, "Failed to enable vdd regulator\n");
+		return ret;
+	}
+
+	udelay(100); /* Short delay for regulator stability */
+	return 0;
+}
+
+static void gp2y1010_power_off(struct gp2y1010_data *data)
+{
+	regulator_disable(data->vdd);
+}
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
+    /* Turn on LED */
+	gpiod_set_value(data->led_gpio, 1);
+
+    /* Wait 40us (datasheet: delay after LED on) */
+	udelay(GP2Y1010_SAMPLE_DELAY_US);
+
+    /* Read ADC at 200us (peak sensitivity) */
+	udelay(GP2Y1010_MEASUREMENT_US - GP2Y1010_SAMPLE_DELAY_US);
+	ret = iio_read_channel_processed(data->adc_chan, &voltage_mv);
+	if (ret < 0) {
+		gpiod_set_value(data->led_gpio, 0);
+		return ret;
+	}
+
+    /* Turn off LED (total pulse width = 280us) */
+	gpiod_set_value(data->led_gpio, 0);
+
+    /* Store raw voltage (for debugging) */
+	*val = voltage_mv;
+
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info gp2y1010_info = {
+	.read_raw = gp2y1010_read_raw,
+};
+
+static const struct iio_chan_spec gp2y1010_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.extend_name = "dust",
+	},
+};
+
+static int gp2y1010_probe(struct platform_device *pdev)
+{
+	struct gp2y1010_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->indio_dev = indio_dev;
+	data->v_clean = 900;  /* Default calibration (adjust per sensor) */
+
+	/* Get LED GPIO */
+	data->led_gpio = devm_gpiod_get(&pdev->dev, "led", GPIOD_OUT_LOW);
+	if (IS_ERR(data->led_gpio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->led_gpio),
+							"Failed to get LED GPIO\n");
+
+    /* Get regulator */
+	data->vdd = devm_regulator_get(&pdev->dev, "vdd");
+	if (IS_ERR(data->vdd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->vdd),
+							"Failed to get regulator\n");
+
+    /* Power on sensor */
+	ret = gp2y1010_power_on(data);
+	if (ret)
+		return ret;
+
+    /* Get ADC channel */
+	data->adc_chan = devm_iio_channel_get(&pdev->dev, "dust");
+	if (IS_ERR(data->adc_chan)) {
+		gp2y1010_power_off(data);
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->adc_chan),
+							"Failed to get ADC channel\n");
+	}
+
+	/* Setup IIO device */
+	indio_dev->name = "gp2y1010";
+	indio_dev->info = &gp2y1010_info;
+	indio_dev->channels = gp2y1010_channels;
+	indio_dev->num_channels = ARRAY_SIZE(gp2y1010_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret) {
+		gp2y1010_power_off(data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void gp2y1010_remove(struct platform_device *pdev)
+{
+	struct gp2y1010_data *data = platform_get_drvdata(pdev);
+
+	gp2y1010_power_off(data);
+}
+
+static const struct of_device_id gp2y1010_of_match[] = {
+	{ .compatible = "sharp,gp2y1010au0f", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gp2y1010_of_match);
+
+static struct platform_driver gp2y1010_driver = {
+	.driver = {
+		.name = "gp2y1010",
+		.of_match_table = gp2y1010_of_match,
+	},
+	.probe = gp2y1010_probe,
+	.remove = gp2y1010_remove,
+};
+
+module_platform_driver(gp2y1010_driver);
+
+MODULE_AUTHOR("Suraj Sonawane <surajsonawane0215@gmail.com>");
+MODULE_DESCRIPTION("Sharp GP2Y1010AU0F Dust Sensor Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


