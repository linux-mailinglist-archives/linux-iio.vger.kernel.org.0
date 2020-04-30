Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290A51C0112
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgD3P6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727047AbgD3P6W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 11:58:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D5C035494;
        Thu, 30 Apr 2020 08:58:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so2468308wmb.4;
        Thu, 30 Apr 2020 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nQ2ddjLlBkAtBwQbixHu3U6EPtVP9VADMtMpycnZHaw=;
        b=uMesZMTqwpF/kXGLstvkYU2tgW8IzsgE+3B0yMTa4k9InLZ/5dOu8LYTSTP4GekzOT
         3eZafGoNxuhvPBxaUZVaGroIEfjvrduBqNIza3mfBV/d9PG+5G5xW6QHfgCftNKd+MhG
         piJuMept7OHxWxf+uS7Dd7IXIcPRtxjh3J6TVOATOgmpb3zb6vc1hypqMQREOeuNScjx
         0t10LwwiWQPE6lJnqyHJL5KmGnz9SUoG/htY0WmHfrSvE9j6A2SE29+8guVw9slG9g81
         S0Q3dkq8MIHQguCNY0/l+2vqkNLrT07RWu27NPFkbuT4dDk+zFGAtheRY7yR0BJbEGSy
         gBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nQ2ddjLlBkAtBwQbixHu3U6EPtVP9VADMtMpycnZHaw=;
        b=iu2VKeAypZjqbY6ojs7D1jA70f+HPHEfOy1CZADvUuXVqES/WtB1Z9MFGHWYwFbjDA
         NSHyCE5sWWWjicy+PuICka0xzrHt9MAfDposr8SmZALIuHcq8RRwHCiQvCH0D1kpT61C
         AyiqP3Eko202AiPmA5JKdgqPzNsD8dh/UFNXy7/MyODge2WtSouVQD9B8H6FnNfULXEa
         /+fDrSximuDY2krLcS2EaGUbqhJ08A4j4Noxz4t5us37BtmTZWb1gvirZUl54ixf7hFO
         9A90YJ9YeBRJNlJP8CJxrZSEU4FklQTzw/M9PluapbDPiFp7P5FM+Iq2bTns0f3DIn/3
         apKA==
X-Gm-Message-State: AGi0Pub2sSkx7wxlorXIGFCj7aZf9JaCL1wA38X1iG1nB8Uw2jWufw2t
        ruQ+aE3bBvzH/5UESD2vx7g=
X-Google-Smtp-Source: APiQypKanavEYvqbbh9UvwSDEYoLz6Hd2PEJeIVlZ4CDZc5Gx+9KVrVspTa/s3lvNLx6vrAe3swxCw==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr3752993wma.89.1588262301193;
        Thu, 30 Apr 2020 08:58:21 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6E9D.dip0.t-ipconnect.de. [91.63.110.157])
        by smtp.gmail.com with ESMTPSA id w8sm265410wrs.25.2020.04.30.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:58:20 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v11 2/6] mfd: mp2629: Add support for mps battery charger
Date:   Thu, 30 Apr 2020 17:58:06 +0200
Message-Id: <20200430155810.21383-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155810.21383-1-sravanhome@gmail.com>
References: <20200430155810.21383-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mp2629 is a highly-integrated switching-mode battery charge management
device for single-cell Li-ion or Li-polymer battery.

Add MFD core enables chip access for ADC driver for battery readings,
and a power supply battery-charger driver

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/Kconfig        |  9 +++++
 drivers/mfd/Makefile       |  2 +
 drivers/mfd/mp2629.c       | 79 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mp2629.h | 17 ++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 include/linux/mfd/mp2629.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3c547ed575e6..fbf287098970 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MP2629
+	tristate "Monolithic Power Systems MP2629 ADC and Battery charger"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Select this option to enable support for Monolithic Power Systems
+	  battery charger. This provides ADC, thermal and battery charger power
+	  management functions.
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
index 000000000000..16840ec5fd1c
--- /dev/null
+++ b/drivers/mfd/mp2629.c
@@ -0,0 +1,79 @@
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
+static const struct mfd_cell mp2629_cell[] = {
+	{
+		.name = "mp2629_adc",
+		.of_compatible = "mps,mp2629_adc",
+	},
+	{
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
+	struct mp2629_data *ddata;
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
+		dev_err(ddata->dev, "Failed to allocate regmap\n");
+		return PTR_ERR(ddata->regmap);
+	}
+
+	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO, mp2629_cell,
+				   ARRAY_SIZE(mp2629_cell), NULL, 0, NULL);
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
index 000000000000..baaeeaf82949
--- /dev/null
+++ b/include/linux/mfd/mp2629.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020 Monolithic Power Systems, Inc
+ */
+
+#ifndef __MP2629_H__
+#define __MP2629_H__
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+struct mp2629_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif
-- 
2.17.1

