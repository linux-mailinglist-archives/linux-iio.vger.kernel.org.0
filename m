Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8261A6B6B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbgDMRhN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732872AbgDMRhK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 13:37:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D736C0A3BDC;
        Mon, 13 Apr 2020 10:37:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a81so10757784wmf.5;
        Mon, 13 Apr 2020 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BO8j8+pI9zWfHd4m+N2P9+Cu+wuRfUjALFzaXkqSsKs=;
        b=hy7G4xjWFAoDNa+zi76sYpqg+BRy8Hj/px8I40l/1J+piWfc2mYCUuSmEtTe0Phnfr
         uwVQI5TxZOHiI9MX6dsyKc3eovt+0epWWJDZQQwT2c6+bFp6LM7QTdrb/wsGdk7o92JT
         XW3miIyfOvKTAzK3SrP43x0IeyGc9slgLqTzPbU5pTeSGQPsT01LH1dDzKhrNGqLP9rS
         x7F5NUMwNimVdYO8oS6EpJf7JtrHkzW5KGENNYMVC0d/wbD7SvZaZz+4La06dx0I8f0M
         d+TjDurBWsUpM153SKIW4c1PpHlzZwu/F206tHoP99Q5U42QqWN0fnZOzBmp/3TDvW5S
         /foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BO8j8+pI9zWfHd4m+N2P9+Cu+wuRfUjALFzaXkqSsKs=;
        b=Dfrdz734yXSvbzQqiYAr0aIDd9lkVAJwOHK9PuA0fqgTn5rwS5fMLSByrV4Dk6JRGM
         XbAIAyNyfD58VUvdgoQdMxE75TaRab4+piBnHZL9acoB9l1YRtUGxhhmn6+ZY2/rP7p1
         bhIPm0VSiUdynE1EVfOXd16SV7+K59dw3Uil63sXyC5E/OOqolCb3kWl1GhL4Wf7LSMW
         FovmyT18LOlHKs0D600cPrPCpkYYAqyY4HApKW0QbYBN0oDjpHIlb/sAOrciG+LXwT+w
         4WvqflkkF0QVq7jEs9LYd9LMToXFWxiGahqA/vMf0GBTEqyBZNxINzIC4YCjtsoimx6D
         XORQ==
X-Gm-Message-State: AGi0PubKumar35lD7/+bGj9rRAHAFbN58g1PQX/0q6Oi9Px1d+ZbVak8
        niU16oXa8Slw3zDDv3UuKro=
X-Google-Smtp-Source: APiQypLzFR6DUlUhHaTp+fT1GiuoTnAy3w2Zj8lPGAimmu1p198uZDn4ws5SKX61XvWHzwaKO1GNyQ==
X-Received: by 2002:a1c:9a96:: with SMTP id c144mr19678718wme.84.1586799428849;
        Mon, 13 Apr 2020 10:37:08 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6AD5.dip0.t-ipconnect.de. [91.63.106.213])
        by smtp.gmail.com with ESMTPSA id a205sm11141465wmh.29.2020.04.13.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:37:08 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v8 3/6] iio: adc: mp2629: Add support for mp2629 ADC driver
Date:   Mon, 13 Apr 2020 19:36:53 +0200
Message-Id: <20200413173656.28522-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413173656.28522-1-sravanhome@gmail.com>
References: <20200413173656.28522-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for 8-bit resolution ADC readings for input power
supply and battery charging measurement. Provides voltage, current
readings to mp2629 power supply driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/iio/adc/Kconfig      |  10 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/mp2629_adc.c | 208 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/mp2629.h   |   9 ++
 4 files changed, 228 insertions(+)
 create mode 100644 drivers/iio/adc/mp2629_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 82e33082958c..ef0c0cd31855 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -680,6 +680,16 @@ config MESON_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called meson_saradc.
 
+config MP2629_ADC
+	tristate "Monolithic MP2629 ADC driver"
+	depends on MFD_MP2629
+	help
+	  Say yes to have support for battery charger IC MP2629 ADC device
+	  accessed over I2C.
+
+	  This driver provides ADC conversion of system, input power supply
+	  and battery voltage & current information.
+
 config NAU7802
 	tristate "Nuvoton NAU7802 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 919228900df9..f14416c245a6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_MCP3911) += mcp3911.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
+obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
 obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
new file mode 100644
index 000000000000..faf389f32729
--- /dev/null
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MP2629 Driver for ADC
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/machine.h>
+#include <linux/mfd/mp2629.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define	MP2629_REG_ADC_CTRL		0x03
+#define	MP2629_REG_BATT_VOLT		0x0e
+#define	MP2629_REG_SYSTEM_VOLT		0x0f
+#define	MP2629_REG_INPUT_VOLT		0x11
+#define	MP2629_REG_BATT_CURRENT		0x12
+#define	MP2629_REG_INPUT_CURRENT	0x13
+
+#define	MP2629_ADC_START		BIT(7)
+#define	MP2629_ADC_CONTINUOUS		BIT(6)
+
+#define MP2629_MAP(_mp, _mpc) IIO_MAP(#_mp, "mp2629_charger", "mp2629-"_mpc)
+
+#define MP2629_ADC_CHAN(_ch, _type) {				\
+	.type = _type,						\
+	.indexed = 1,						\
+	.datasheet_name = #_ch,					\
+	.channel = MP2629_ ## _ch,				\
+	.address = MP2629_REG_ ## _ch,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+struct mp2629_adc {
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+static struct iio_chan_spec mp2629_channels[] = {
+	MP2629_ADC_CHAN(BATT_VOLT, IIO_VOLTAGE),
+	MP2629_ADC_CHAN(SYSTEM_VOLT, IIO_VOLTAGE),
+	MP2629_ADC_CHAN(INPUT_VOLT, IIO_VOLTAGE),
+	MP2629_ADC_CHAN(BATT_CURRENT, IIO_CURRENT),
+	MP2629_ADC_CHAN(INPUT_CURRENT, IIO_CURRENT)
+};
+
+static struct iio_map mp2629_adc_maps[] = {
+	MP2629_MAP(BATT_VOLT, "batt-volt"),
+	MP2629_MAP(SYSTEM_VOLT, "system-volt"),
+	MP2629_MAP(INPUT_VOLT, "input-volt"),
+	MP2629_MAP(BATT_CURRENT, "batt-current"),
+	MP2629_MAP(INPUT_CURRENT, "input-current")
+};
+
+static int mp2629_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct mp2629_adc *info = iio_priv(indio_dev);
+	unsigned int rval;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(info->regmap, chan->address, &rval);
+		if (ret)
+			return ret;
+
+		if (chan->address == MP2629_INPUT_VOLT)
+			rval &= GENMASK(6, 0);
+		*val = rval;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case MP2629_BATT_VOLT:
+		case MP2629_SYSTEM_VOLT:
+			*val = 20;
+			return IIO_VAL_INT;
+
+		case MP2629_INPUT_VOLT:
+			*val = 60;
+			return IIO_VAL_INT;
+
+		case MP2629_BATT_CURRENT:
+			*val = 175;
+			*val2 = 10;
+			return IIO_VAL_FRACTIONAL;
+
+		case MP2629_INPUT_CURRENT:
+			*val = 133;
+			*val2 = 10;
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mp2629_adc_info = {
+	.read_raw = &mp2629_read_raw,
+};
+
+static int mp2629_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mp2629_info *ddata = dev_get_drvdata(dev->parent);
+	struct mp2629_adc *info;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	info->regmap = ddata->regmap;
+	info->dev = dev;
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
+				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
+				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
+	if (ret) {
+		dev_err(dev, "adc enable fail: %d\n", ret);
+		return ret;
+	}
+
+	ret = iio_map_array_register(indio_dev, mp2629_adc_maps);
+	if (ret) {
+		dev_err(dev, "IIO maps register fail: %d\n", ret);
+		goto fail_disable;
+	}
+
+	indio_dev->name = "mp2629-adc";
+	indio_dev->dev.parent = dev;
+	indio_dev->channels = mp2629_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mp2629_adc_info;
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "IIO device register fail: %d\n", ret);
+		goto fail_map_unregister;
+	}
+
+	return 0;
+
+fail_map_unregister:
+	iio_map_array_unregister(indio_dev);
+
+fail_disable:
+	regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_CONTINUOUS, 0);
+	regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_START, 0);
+
+	return ret;
+}
+
+static int mp2629_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct mp2629_adc *info = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	iio_map_array_unregister(indio_dev);
+
+	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_CONTINUOUS, 0);
+	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_START, 0);
+
+	return 0;
+}
+
+static const struct of_device_id mp2629_adc_of_match[] = {
+	{ .compatible = "mps,mp2629_adc"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp2629_adc_of_match);
+
+static struct platform_driver mp2629_adc_driver = {
+	.driver = {
+		.name = "mp2629_adc",
+		.of_match_table = mp2629_adc_of_match,
+	},
+	.probe		= mp2629_adc_probe,
+	.remove		= mp2629_adc_remove,
+};
+module_platform_driver(mp2629_adc_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
+MODULE_DESCRIPTION("MP2629 ADC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
index 06985e41fc6f..83ebfab41691 100644
--- a/include/linux/mfd/mp2629.h
+++ b/include/linux/mfd/mp2629.h
@@ -16,4 +16,13 @@ struct mp2629_info {
 	struct regmap *regmap;
 };
 
+enum mp2629_adc_chan {
+	MP2629_BATT_VOLT,
+	MP2629_SYSTEM_VOLT,
+	MP2629_INPUT_VOLT,
+	MP2629_BATT_CURRENT,
+	MP2629_INPUT_CURRENT,
+	MP2629_ADC_CHAN_END
+};
+
 #endif
-- 
2.17.1

