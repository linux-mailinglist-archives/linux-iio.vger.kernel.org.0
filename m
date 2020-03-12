Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED0183776
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCLR1Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 13:27:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55230 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCLR1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 13:27:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so6991643wmc.4;
        Thu, 12 Mar 2020 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oNGVMDOPRbAbYoKmM972KNt6YajuuF7xd8b8CChfBTE=;
        b=lBDlzavSxgbe9DCqa4fB1dKmsbbUHdJQbvya9pcpqoOTZRxuaaHKhG/q21NZNHvtuK
         vtx78kdnG5nFY/BQXuW4RzqOoTVDba9hGJIjbdv/NfXmaOifeVv7vOCnnHLrf5uij05g
         XBa3fH77pzbFuL5a1vwJORmzkIkemN+XTkASs2M1xzJgqSVw76L8g/zDFTt4UUz10fDP
         Gsp95EGMihAbEQrFm7sHu1aIgT10Hrt2ixux5mvvyS4aCgZZt9T3Ue/711xQCh/hKiNd
         7Vu3FHzR2TzEjK9wjV7JD43nx3Ht+cI8aVP/AlVUuL09VZ1Tz+IKdoermnzWjY4TNv+J
         K/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oNGVMDOPRbAbYoKmM972KNt6YajuuF7xd8b8CChfBTE=;
        b=SDbN96gaTT03zDI7GOm6fScSIM94gEMlHO19t6L6nzM3JCwh7HFFOax2GlBfTC6t8f
         EUsp1cX+0jV25ibT5dnqQcxiLEzjIzmXLOxTHv8xvhY+9WGo4oq5mMBUHZ4nr+g6V77g
         2gqzjvS7mKh4+XxImGlDoUQiCUYpMijv5l3wjLp7Q20ayK3T5/p2qDKrCPEU+9DFLyNa
         UurE0nbj5gIUwOpnfJ7F3mgAFtZfX4hcSM3+IGnWKvGZtbCZ2WWAy6FkPhSK91Ip6aS1
         Ze7Ha1gfH73aCYvIrXIXw8GJcjnR8totj5Uk5jKcLgQ9R0+zwLhmRje+4HkE0hbncyr4
         G1og==
X-Gm-Message-State: ANhLgQ3cNE9FkgSeMffMtbOEt8XTj/zXj2UwEX6LdxjihnYYgP9/1/iP
        aK3wwUsVGhK1vvHe79oOGIg=
X-Google-Smtp-Source: ADFU+vuLNEWWmZo5uAB+dWDfQj0rPjm78sazHIFjIl0xllAyuIlFnnJ9kmzVN8eLO8Vr+uoBwFwDjA==
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr5763448wmg.186.1584034030295;
        Thu, 12 Mar 2020 10:27:10 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6C4B.dip0.t-ipconnect.de. [91.63.108.75])
        by smtp.gmail.com with ESMTPSA id c11sm76254500wrp.51.2020.03.12.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:27:09 -0700 (PDT)
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
Subject: [PATCH 2/5] mfd: mp2629: Add support for mps battery charger
Date:   Thu, 12 Mar 2020 18:26:46 +0100
Message-Id: <20200312172649.13702-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312172649.13702-1-sravanhome@gmail.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mp2629 is a highly-integrated switching-mode battery charge management
device for single-cell Li-ion or Li-polymer battery.

Add MFD core enables chip access for ADC driver for battery readings,
and a power supply battery-charger driver

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/mfd/Kconfig        |  43 +++++----------
 drivers/mfd/Makefile       |   4 +-
 drivers/mfd/mp2629.c       | 109 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mp2629.h |  34 ++++++++++++
 4 files changed, 158 insertions(+), 32 deletions(-)
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 include/linux/mfd/mp2629.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3c547ed575e6..6371ffb33a81 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MP2629
+	bool "Monolithic power system MP2629 ADC and Battery charger"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Select this option to enable support for Monolithic power system
+	  Battery charger. This provides ADC, thermal, Battery charger power
+	  management functions on the systems.
+
 config MFD_MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS || COMPILE_TEST
@@ -642,19 +651,6 @@ config MFD_IPAQ_MICRO
 	  AT90LS8535 microcontroller flashed with a special iPAQ
 	  firmware using the custom protocol implemented in this driver.
 
-config MFD_IQS62X
-	tristate "Azoteq IQS620A/621/622/624/625 core support"
-	depends on I2C
-	select MFD_CORE
-	select REGMAP_I2C
-	help
-	  Say Y here if you want to build core support for the Azoteq IQS620A,
-	  IQS621, IQS622, IQS624 and IQS625 multi-function sensors. Additional
-	  options must be selected to enable device-specific functions.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called iqs62x.
-
 config MFD_JANZ_CMODIO
 	tristate "Janz CMOD-IO PCI MODULbus Carrier Board"
 	select MFD_CORE
@@ -906,7 +902,6 @@ config MFD_CPCAP
 	tristate "Support for Motorola CPCAP"
 	depends on SPI
 	depends on OF || COMPILE_TEST
-	select MFD_CORE
 	select REGMAP_SPI
 	select REGMAP_IRQ
 	help
@@ -1215,7 +1210,7 @@ config AB8500_CORE
 	  chip. This connects to U8500 either on the SSP/SPI bus (deprecated
 	  since hardware version v1.0) or the I2C bus via PRCMU. It also adds
 	  the irq_chip parts for handling the Mixed Signal chip events.
-	  This chip embeds various other multimedia functionalities as well.
+	  This chip embeds various other multimedia funtionalities as well.
 
 config AB8500_DEBUG
 	bool "Enable debug info via debugfs"
@@ -1865,7 +1860,7 @@ config MFD_WM8994
 	  has on board GPIO and regulator functionality which is
 	  supported via the relevant subsystems.  This driver provides
 	  core support for the WM8994, in order to use the actual
-	  functionality of the device other drivers must be enabled.
+	  functionaltiy of the device other drivers must be enabled.
 
 config MFD_WM97xx
 	tristate "Wolfson Microelectronics WM97xx"
@@ -1878,7 +1873,7 @@ config MFD_WM97xx
 	  designed for smartphone applications.  As well as audio functionality
 	  it has on board GPIO and a touchscreen functionality which is
 	  supported via the relevant subsystems.  This driver provides core
-	  support for the WM97xx, in order to use the actual functionality of
+	  support for the WM97xx, in order to use the actual functionaltiy of
 	  the device other drivers must be enabled.
 
 config MFD_STW481X
@@ -1971,7 +1966,7 @@ config MFD_STPMIC1
 	  Support for ST Microelectronics STPMIC1 PMIC. STPMIC1 has power on
 	  key, watchdog and regulator functionalities which are supported via
 	  the relevant subsystems. This driver provides core support for the
-	  STPMIC1. In order to use the actual functionality of the device other
+	  STPMIC1. In order to use the actual functionaltiy of the device other
 	  drivers must be enabled.
 
 	  To compile this driver as a module, choose M here: the
@@ -1990,18 +1985,6 @@ config MFD_STMFX
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
-config MFD_WCD934X
-	tristate "Support for WCD9340/WCD9341 Codec"
-	depends on SLIMBUS
-	select REGMAP
-	select REGMAP_SLIMBUS
-	select REGMAP_IRQ
-	select MFD_CORE
-	help
-	  Support for the Qualcomm WCD9340/WCD9341 Codec.
-	  This driver provides common support WCD934x audio codec and its
-	  associated Pin Controller, Soundwire Controller and Audio codec.
-
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f935d10cbf0f..b91db03d041a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -58,7 +58,6 @@ endif
 ifeq ($(CONFIG_MFD_CS47L24),y)
 obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
 endif
-obj-$(CONFIG_MFD_WCD934X)	+= wcd934x.o
 obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
 wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
 wm831x-objs			+= wm831x-auxadc.o
@@ -170,6 +169,8 @@ obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
 obj-$(CONFIG_MFD_MAX8997)	+= max8997.o max8997-irq.o
 obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
 
+obj-$(CONFIG_MFD_MP2629)	+= mp2629.o
+
 pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
 obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
 obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
@@ -226,7 +227,6 @@ obj-$(CONFIG_MFD_AS3711)	+= as3711.o
 obj-$(CONFIG_MFD_AS3722)	+= as3722.o
 obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
 obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
-obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
 obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
new file mode 100644
index 000000000000..6b7a11555760
--- /dev/null
+++ b/drivers/mfd/mp2629.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MP2629 MFD Driver for ADC and battery charger
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mp2629.h>
+
+enum {
+	MP2629_MFD_ADC,
+	MP2629_MFD_CHARGER,
+	MP2629_MFD_MAX
+};
+
+static const struct mfd_cell mp2629mfd[] = {
+	[MP2629_MFD_ADC] = {
+		.name = "mp2629_adc",
+		.of_compatible = "mps,mp2629_adc",
+	},
+	[MP2629_MFD_CHARGER] = {
+		.name = "mp2629_charger",
+		.of_compatible = "mps,mp2629_charger",
+	}
+};
+
+static const struct regmap_config mp2629_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x17,
+};
+
+int mp2629_set_value(struct regmap *map, u8 reg, u8 mask, unsigned int val)
+{
+	return regmap_update_bits(map, reg, mask, val);
+}
+EXPORT_SYMBOL(mp2629_set_value);
+
+int mp2629_get_value(struct regmap *map, u8 reg, unsigned int *val)
+{
+	return regmap_read(map, reg, val);
+}
+EXPORT_SYMBOL(mp2629_get_value);
+
+static int mp2629_probe(struct i2c_client *client)
+{
+	struct mp2629_info *info;
+	int ret;
+
+	info = devm_kzalloc(&client->dev, sizeof(struct mp2629_info),
+					 GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = &client->dev;
+	info->irq = client->irq;
+	i2c_set_clientdata(client, info);
+
+	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		dev_err(info->dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(info->regmap);
+	}
+
+	ret = devm_mfd_add_devices(info->dev, -1, mp2629mfd,
+				ARRAY_SIZE(mp2629mfd), NULL,
+				0, NULL);
+	if (ret)
+		dev_err(info->dev, "Failed to add mfd %d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id mp2629_of_match[] = {
+	{ .compatible = "mps,mp2629"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mp2629_of_match);
+
+static const struct i2c_device_id mp2629_id[] = {
+	{ "mp2629", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mp2629_id);
+
+static struct i2c_driver mp2629_driver = {
+	.driver = {
+		.name = "mp2629",
+		.of_match_table = of_match_ptr(mp2629_of_match),
+	},
+	.probe_new	= mp2629_probe,
+	.id_table	= mp2629_id,
+};
+module_i2c_driver(mp2629_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
+MODULE_DESCRIPTION("MP2629 Battery charger mfd driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
new file mode 100644
index 000000000000..4af9defd0c45
--- /dev/null
+++ b/include/linux/mfd/mp2629.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * mp2629.h  - register definitions for mp2629 charger
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ */
+
+#ifndef __MP2629_H__
+#define __MP2629_H__
+
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+struct mp2629_info {
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
+};
+
+enum mp2629_adc_chan {
+	MP2629_BATT_VOLT,
+	MP2629_SYSTEM_VOLT,
+	MP2629_INPUT_VOLT,
+	MP2629_BATT_CURRENT,
+	MP2629_INPUT_CURRENT,
+	MP2629_ADC_CHAN_END
+};
+
+int mp2629_set_value(struct regmap *map, u8 reg, u8 mask, unsigned int val);
+int mp2629_get_value(struct regmap *map, u8 reg, unsigned int *val);
+
+#endif
-- 
2.17.1

