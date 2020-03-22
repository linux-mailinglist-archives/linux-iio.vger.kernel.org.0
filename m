Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03F18ED24
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCVWql (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:46:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35399 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCVWqk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:46:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so2338011wrn.2;
        Sun, 22 Mar 2020 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7L2CBqTjvM9wYs+Z3QFtVjHPDIhyV3wfUCu4c1Jf0Nc=;
        b=PbOLnQNHoY6uUvdV9CDM8U9fHgVry4lyji4XWFx7qOLyl8c1HLpHkj3bF3RV4IPIUV
         lwMZcMeq0yLBiIed7JZ4anHBFw7jjx3HBxldaQfzKiE1wXsbJzntovUIs3SY7uCGzKcQ
         mYV99muBc+U1Ntnr0LoLi6FGAvdLJSQ4VT9NdE5O+miiC0oKn0mq61RRHVOgHCZQYiNI
         wLv5n2XWUJLPSBNwQ4PMB2W6dCiB6Vn7fw5r/d7BsBPdu0xCLFeNHSRCYJbDDGSoYJnJ
         sAsLtwGsuZw0a38QowTuhZVp5CTmGbjBh29k6PMlmB7r+uJQrs31CBv0IUAE+eaJ1ymV
         AtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7L2CBqTjvM9wYs+Z3QFtVjHPDIhyV3wfUCu4c1Jf0Nc=;
        b=hFvEL+UVYF/v+Cf6XkXyjBXNXFKe4+i7c2oi7M8fusE893WUWtADzvTyZNVlCETGrA
         H+zCrTSqxetUZtoVA/BJgCF8dz/sGy3r3YYAFqeJOjvEMJLtusSJCBSuRpXyU1WzG+l7
         IXo+zbjJuX8InoJsYAxJsPIOqsGqjsIDinrUl3VzpH1t+nFvo60v/VH5yZrBzmR3DHfZ
         Dg1+DCDPlf2ThCEt2UzIdmesGrvLf3QEFaM7lawf4Vmwk0hP8LvrqnEMCYeecoVf7kUK
         U77v2usEKlJd/9OX4a77+8i4YjpTh2PcamrKTeHBasmAJ0crY4e3m/UXDl4MouwVoTAQ
         kGnQ==
X-Gm-Message-State: ANhLgQ07duVPUhAHdWqec4FGN5BadVVeLj9ohIkAponPHsVHupa8Fl0J
        1jG6WkYmhs5GmU2PSYVisQo=
X-Google-Smtp-Source: ADFU+vt1NlLuYBZapiOMecPQcCS5B95HZ2/byiBlED3pyVC5zcj6rJs1PwonnDuWSnxAX95ciTIvDg==
X-Received: by 2002:adf:e891:: with SMTP id d17mr25775108wrm.348.1584917196599;
        Sun, 22 Mar 2020 15:46:36 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id r9sm19158549wma.47.2020.03.22.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:46:35 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
Date:   Sun, 22 Mar 2020 23:46:23 +0100
Message-Id: <20200322224626.13160-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322224626.13160-1-sravanhome@gmail.com>
References: <20200322224626.13160-1-sravanhome@gmail.com>
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
 drivers/mfd/Kconfig        |   9 +++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mp2629.h |  22 +++++++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 include/linux/mfd/mp2629.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3c547ed575e6..6614e5cff881 100644
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
+	  Select this option to enable support for monolithic power system
+	  battery charger. This provides ADC, thermal, battery charger power
+	  management functions on the systems.
+
 config MFD_MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f935d10cbf0f..d6c210f96d02 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -170,6 +170,8 @@ obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
 obj-$(CONFIG_MFD_MAX8997)	+= max8997.o max8997-irq.o
 obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
 
+obj-$(CONFIG_MFD_MP2629)	+= mp2629.o
+
 pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
 obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
 obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
new file mode 100644
index 000000000000..41a4082387ce
--- /dev/null
+++ b/drivers/mfd/mp2629.c
@@ -0,0 +1,116 @@
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
+static struct resource mp2629_irq_rsrc[] = {
+	{
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell mp2629mfd[] = {
+	[MP2629_MFD_ADC] = {
+		.name = "mp2629_adc",
+		.of_compatible = "mps,mp2629_adc",
+	},
+	[MP2629_MFD_CHARGER] = {
+		.name = "mp2629_charger",
+		.of_compatible = "mps,mp2629_charger",
+		.resources = mp2629_irq_rsrc,
+		.num_resources = ARRAY_SIZE(mp2629_irq_rsrc),
+	}
+};
+
+static const struct regmap_config mp2629_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x17,
+};
+
+static int mp2629_probe(struct i2c_client *client)
+{
+	struct mp2629_info *info;
+	struct resource	*resources;
+	int ret;
+	int i;
+
+	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = &client->dev;
+	i2c_set_clientdata(client, info);
+
+	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		dev_err(info->dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(info->regmap);
+	}
+
+	for (i = 0; i < MP2629_MFD_MAX; i++) {
+		mp2629mfd[i].platform_data = &info->regmap;
+		mp2629mfd[i].pdata_size = sizeof(info->regmap);
+
+		resources = (struct resource *)mp2629mfd[i].resources;
+		if (resources) {
+			resources[0].start = client->irq;
+			resources[0].end = client->irq;
+		}
+	}
+
+	ret = devm_mfd_add_devices(info->dev, PLATFORM_DEVID_NONE, mp2629mfd,
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
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mp2629_of_match);
+
+static const struct i2c_device_id mp2629_id[] = {
+	{ "mp2629", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mp2629_id);
+
+static struct i2c_driver mp2629_driver = {
+	.driver = {
+		.name = "mp2629",
+		.of_match_table = mp2629_of_match,
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
index 000000000000..371e44330ba8
--- /dev/null
+++ b/include/linux/mfd/mp2629.h
@@ -0,0 +1,22 @@
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
+#include <linux/types.h>
+
+struct device;
+struct regmap;
+
+struct mp2629_info {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif
-- 
2.17.1

