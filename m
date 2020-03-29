Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D9B196D58
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgC2MbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 08:31:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45042 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgC2MbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 08:31:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so17519023wrw.11;
        Sun, 29 Mar 2020 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6JHVvWyjCIClbMe3qA+hwkoKr1pqM/u0MjtagCuJzWg=;
        b=GS2coSV0Ia+k6CEHUACGbbzNV1WJJflWMxQTfHSjwgORxyoNy0KYjKAxsEcecnO4uI
         7nGhTjjZDUro1ijSYdY3+qhko/j0DCjHoS3DoJjTn6BRENXbCqyOJYNLkASahpP44D/c
         zEA+9TsbS+X6Txay9o78DmlSSJQv0hcRIGFJkg2WQQozBJURZm/qUBRuNXEFREUtaVYb
         F6qr3sSgJmDieoxEcc8yy7bA0n4QYhQYAefeCTu+FopQNylgu3BoRUpF/kjRJvV82W3X
         p3oqKxxurPLnTe8OPTJEzUoFdn3gDE+q4UliIGfhJ4DyagDY9S5wN9OeIvTOzZUoJVpd
         eaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6JHVvWyjCIClbMe3qA+hwkoKr1pqM/u0MjtagCuJzWg=;
        b=D6mWLxTV7badflBfq6o4rCFfFJeDQRoOwjYYeUU4ViRVdQgNbozNCd0ON6i1bbm6yM
         AWsX/z4iIZaNf81bzngewyKJn76xJvRgF6TeE51o2sPKLwYnMGKwLAIrHgO+9ryIW4Ps
         fJO0y4HIfY7wVOdEWupt90qvAf4lz3oyKcm4rpmlXrFVm4IQM58KWAjX2jKsdfGp2vB7
         DfwVLx0cDmPGwjUeUqXOmyD72FmlVjcrv20VcyyT2C6cH45UZDrChohleZbA8wfb7IAR
         9yva0Fm28j303WhyoWnaEsw3ch2pivpNWme19Wg1oTRpFxeOV2Q0pDcvLCmjq/rT0dC2
         1K1w==
X-Gm-Message-State: ANhLgQ2bzkmtNvvC9CXr69qpPVxdXvn8L/wioXn/4RsSK8rddku1zDS5
        ozNc6P9BnIeiQb0G9gc1ZTQ=
X-Google-Smtp-Source: ADFU+vtASPaBoA0ZlG0D4yOABB50aEuSguJWuKm66wTqqbZky5lB2QXy+ktUPr/nbOzDaTyeB0lbrw==
X-Received: by 2002:a05:6000:1090:: with SMTP id y16mr9124165wrw.281.1585485080148;
        Sun, 29 Mar 2020 05:31:20 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6BD9.dip0.t-ipconnect.de. [91.63.107.217])
        by smtp.gmail.com with ESMTPSA id f9sm17259108wrc.71.2020.03.29.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 05:31:19 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 2/5] mfd: mp2629: Add support for mps battery charger
Date:   Sun, 29 Mar 2020 14:31:07 +0200
Message-Id: <20200329123110.26482-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329123110.26482-1-sravanhome@gmail.com>
References: <20200329123110.26482-1-sravanhome@gmail.com>
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
 drivers/mfd/Kconfig        |  9 ++++
 drivers/mfd/Makefile       |  2 +
 drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mp2629.h | 19 +++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 include/linux/mfd/mp2629.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3c547ed575e6..85be799795aa 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MP2629
+	tristate "Monolithic power system MP2629 ADC and Battery charger"
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
index 000000000000..46242b1cdf24
--- /dev/null
+++ b/drivers/mfd/mp2629.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MP2629 parent driver for ADC and battery charger
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mp2629.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
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
+static int mp2629_probe(struct i2c_client *client)
+{
+	struct mp2629_info *ddata;
+	int ret;
+
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->dev = &client->dev;
+	i2c_set_clientdata(client, ddata);
+
+	ddata->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		dev_err(ddata->dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(ddata->regmap);
+	}
+
+	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_NONE, mp2629mfd,
+				ARRAY_SIZE(mp2629mfd), NULL,
+				0, NULL);
+	if (ret)
+		dev_err(ddata->dev, "Failed to register sub-devices %d\n", ret);
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
+static struct i2c_driver mp2629_driver = {
+	.driver = {
+		.name = "mp2629",
+		.of_match_table = mp2629_of_match,
+	},
+	.probe_new	= mp2629_probe,
+};
+module_i2c_driver(mp2629_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
+MODULE_DESCRIPTION("MP2629 Battery charger parent driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
new file mode 100644
index 000000000000..06985e41fc6f
--- /dev/null
+++ b/include/linux/mfd/mp2629.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * register definitions for MP2629 charger
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ */
+
+#ifndef __MP2629_H__
+#define __MP2629_H__
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+struct mp2629_info {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif
-- 
2.17.1

