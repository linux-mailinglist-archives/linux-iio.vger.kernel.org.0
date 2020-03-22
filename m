Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52E18ECF8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgCVWac (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:30:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgCVWac (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:30:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id d5so2304267wrn.2;
        Sun, 22 Mar 2020 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9H8A2HbY1w0LSOhr2nvKesIOJNJPWZKH+LxS/vDPtSo=;
        b=ZkeDixSN1LLIudqWE3IqQzSdF8EeTM0MCN4AGOjdQ+uVV0Vsrji3WdWgEaLhu8rvyq
         EMd/dj3uBSl1gscAqz5u2KJsC/kOH5ummiwPmzanhF9re9rNaTR2Ku+p1fEiu+5Cocg0
         rtMN+p6/0QxFmlhDsfwdusDAh7rY445hJOOR3HS+D5ViLjy5D8/Dv492FGgyX2kOct6E
         7BQpnGfG0MJVtGQkSujsFOBi2k1wOtUhMLoEqoAM/lqD2ymv0BWxar6Q9OM3bmhOpmpf
         zlpN9HZPxqgVbmq5qSy6jVGJH7YWENFrSB74Q3WLlW8gndokRuOcBGR19fWNnGN/VvA+
         5LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9H8A2HbY1w0LSOhr2nvKesIOJNJPWZKH+LxS/vDPtSo=;
        b=i/Yu0RkrkWiL9Ipz1X/SLSh467tzEwQcyYCP+o4RxU0KEOs+beymAmwYQ8UioPwHkY
         YlP9MS7IpixJ+6e2ZW1sxdnThet4Y8KxoKFaMEDS9UeMPYStzx3nd9vwX9UmwYk/EFLF
         CEs2m7zDzelru5kIyNOUWmwioutGTsnQI3v99QdpzDOMfSd64rCJ4n4y/6ATpknorh7L
         Xkbiu9fhk6KNyC+r3qHeRxkBhYQpp+R01pV9Q+uC6ISjEjR8LrSAGx1F9odxiGDXhkhG
         IyFS7GujgEdsLw4eLaKLyjK4/RKwZ5gsXuaV85oQEflBuEgLyjF5LNZMfUYL3Ihql1nD
         Gb8w==
X-Gm-Message-State: ANhLgQ1ZD6A0BluyOq9a2GBpu7XbJ/Ov/cgPrTq/daChtnMcazXJYDL9
        GNFWkYqA7O6SXMslO6XDjNQ=
X-Google-Smtp-Source: ADFU+vucbMbDD74GrEvC265qJXP7d/+ar4v4kAb4eXXvldYBxEJ9/YSToy4oEDke2kk19YZJDeNdUw==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr26712868wrw.313.1584916229399;
        Sun, 22 Mar 2020 15:30:29 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id p13sm8060517wru.3.2020.03.22.15.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:30:28 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 3/5] iio: adc: mp2629: Add support for mp2629 ADC driver
Date:   Sun, 22 Mar 2020 23:30:14 +0100
Message-Id: <20200322223016.11509-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322223016.11509-1-sravanhome@gmail.com>
References: <20200322223016.11509-1-sravanhome@gmail.com>
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
 drivers/iio/adc/mp2629_adc.c | 214 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/mp2629.h   |   9 ++
 4 files changed, 234 insertions(+)
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
index 000000000000..6967c695d177
--- /dev/null
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MP2629 Driver for ADC
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
+#include <linux/mfd/mp2629.h>
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
+		if (ret < 0)
+			return ret;
+
+		if (chan->address == MP2629_INPUT_VOLT)
+			rval &= 0x7f;
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
+
+	return 0;
+}
+
+static const struct iio_info mp2629_adc_info = {
+	.read_raw = &mp2629_read_raw,
+};
+
+static int mp2629_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void **pdata = pdev->dev.platform_data;
+	struct mp2629_adc *info;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	info->regmap = *pdata;
+	info->dev = dev;
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = iio_map_array_register(indio_dev, mp2629_adc_maps);
+	if (ret) {
+		dev_err(dev, "IIO maps register fail: %d\n", ret);
+		return ret;
+	}
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->channels = mp2629_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mp2629_adc_info;
+
+	ret = regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
+				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
+				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
+	if (ret) {
+		dev_err(dev, "adc enable fail: %d\n", ret);
+		goto fail_unmap;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "IIO device register fail: %d\n", ret);
+		goto fail_disable;
+	}
+
+	return 0;
+
+fail_disable:
+	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_CONTINUOUS, 0);
+	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_START, 0);
+
+fail_unmap:
+	iio_map_array_unregister(indio_dev);
+
+	return ret;
+}
+
+static int mp2629_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct mp2629_adc *info = iio_priv(indio_dev);
+
+	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_CONTINUOUS, 0);
+	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_START, 0);
+
+	iio_map_array_unregister(indio_dev);
+	iio_device_unregister(indio_dev);
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
index 371e44330ba8..8b9c717e1fb0 100644
--- a/include/linux/mfd/mp2629.h
+++ b/include/linux/mfd/mp2629.h
@@ -19,4 +19,13 @@ struct mp2629_info {
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

