Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3125C18377C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCLR1Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 13:27:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43982 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgCLR1Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 13:27:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so2315688wrj.10;
        Thu, 12 Mar 2020 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aSwNDFQneEe0GWbx0WUZtPO+BBYiLHWJ9fdYhGeWcHg=;
        b=JIvN/tq1VBv8eBFXXQWNelsn+01Pkhpj+S6IZszgX8we4dl+cmFsDhTTNruDbSNcEF
         bdE+ttWjAfjzJ7gDms38rXHj4fMBMl5eJoSBOEHsg3SvW/WGiqFNKBWzacoNpKjrm3i7
         2YVvfZ737BHlnCSOv2Lir+q/luDaY97Dpk6fCBOgw4p9vagdI78oSCMw1Ovftc6aPldI
         lR4/4u5/XpYq+P93lISWMsS6nn7xSUU3YbkgUXed72uvsnNI6yJb3R6oqXokxghoF4QS
         rgAYg4T9Jqq4u2HLHrqC4h/MRP5T2YaMtqJ3ptn5sRFbDzsi0op0cIsWYjWQSlIkks2p
         VBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aSwNDFQneEe0GWbx0WUZtPO+BBYiLHWJ9fdYhGeWcHg=;
        b=WD4ZloOdBeVsAoPMA6mSzJfRZxdep0QepodBIu/3pCpxUrwgYlHbGoSdH61hDK2Wjl
         175nEcmJBgCzleH8tTW0fJt2Ob8vLfTl9nj/p0blcnVBBLZGbpJanRLn+9318XTneCSQ
         cifeXjs5i2IE/D+r/76vmhMjCUU/mML5MB4k9RX38rNGOZu1QrMy6160rTuyaanf1OHO
         jE4Pfz4uO3rgaQ9kTc/Z3y62gkPdMJNzhFB7YqYwge7yDCjGjZZm6UzybQjwzlhF0+Nb
         GysnDbsa9LWl9VbpDLrX//AbwSHdRaGcR+bHJdnL7VrH8eUrpt3yILEWb4xPM79jxcqR
         llsg==
X-Gm-Message-State: ANhLgQ1l0Bv3KJmXQmkU0wuxDtEUgnmQWhT0Ib8W2pVM2Jv+GJiBOLip
        m7sd2W4qZsccA8wiujfEO5KJFJvw9Eo=
X-Google-Smtp-Source: ADFU+vuIzwnoJVMPBg0IrFr1yYKV794Cmcj/65oIvJPuF+GcrZVhqq69puGT4SviA8lxs9np3Xhd1A==
X-Received: by 2002:a5d:660d:: with SMTP id n13mr11544586wru.383.1584034031952;
        Thu, 12 Mar 2020 10:27:11 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6C4B.dip0.t-ipconnect.de. [91.63.108.75])
        by smtp.gmail.com with ESMTPSA id c11sm76254500wrp.51.2020.03.12.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:27:11 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        fabrice.gasnier@st.com, beniamin.bia@analog.com,
        linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
        fabrizio.castro@bp.renesas.com, info@metux.net,
        hancock@sedsystems.ca, gregory.clement@bootlin.com,
        renatogeh@gmail.com, plr.vincent@gmail.com,
        miquel.raynal@bootlin.com, marcelo.schmitt1@gmail.com,
        paul@crapouillou.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 3/5] iio: adc: mp2629: Add support for mp2629 ADC driver
Date:   Thu, 12 Mar 2020 18:26:47 +0100
Message-Id: <20200312172649.13702-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312172649.13702-1-sravanhome@gmail.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
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
 drivers/iio/adc/mp2629_adc.c | 211 +++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
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
index 000000000000..11210b4349fb
--- /dev/null
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MP2629 Driver for ADC
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
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
+#define MP2629_ADC_CONTINUOUS		BIT(6)
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
+static struct iio_chan_spec mp2629_channels[] = {
+	MP2629_ADC_CHAN(BATT_VOLT, IIO_VOLTAGE),
+	MP2629_ADC_CHAN(SYSTEM_VOLT, IIO_VOLTAGE),
+	MP2629_ADC_CHAN(INPUT_VOLT, IIO_VOLTAGE),
+	MP2629_ADC_CHAN(BATT_CURRENT, IIO_CURRENT),
+	MP2629_ADC_CHAN(INPUT_CURRENT, IIO_CURRENT)
+};
+
+struct mp2629_adc {
+	struct mp2629_info *info;
+	struct device *dev;
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
+	struct mp2629_adc *adc_info = iio_priv(indio_dev);
+	struct mp2629_info *info = adc_info->info;
+	unsigned int rval;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mp2629_get_value(info->regmap, chan->address, &rval);
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
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info mp2629_adc_info = {
+	.read_raw = &mp2629_read_raw,
+};
+
+static int mp2629_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mp2629_info *info = dev_get_drvdata(dev->parent);
+	struct mp2629_adc *adc_info;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc_info = iio_priv(indio_dev);
+	platform_set_drvdata(pdev, indio_dev);
+	adc_info->info = info;
+	adc_info->dev = dev;
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
+	ret = mp2629_set_value(info->regmap, MP2629_REG_ADC_CTRL,
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
+		goto fail_unmap;
+	}
+
+	return 0;
+
+fail_unmap:
+	iio_map_array_unregister(indio_dev);
+	return ret;
+}
+
+static int mp2629_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct mp2629_adc *adc_info = iio_priv(indio_dev);
+	struct mp2629_info *info = adc_info->info;
+
+	mp2629_set_value(info->regmap, MP2629_REG_ADC_CTRL,
+					 MP2629_ADC_CONTINUOUS, 0);
+	mp2629_set_value(info->regmap, MP2629_REG_ADC_CTRL,
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
+	{},
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
-- 
2.17.1

