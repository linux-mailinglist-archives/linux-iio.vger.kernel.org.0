Return-Path: <linux-iio+bounces-25966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38597C3B988
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2D91345026
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 14:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA533F8A2;
	Thu,  6 Nov 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dt7rl4Fk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2BD33E357
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438323; cv=none; b=PmnzKOE78V8U2n6sMYEsXiWAoqnekoNPL+zaTmW8+e+9h4pzV017wCJntJRL1MO1WlJScL3C4HNj0QPxuexOC1k/DqckWYjFxgL7/nMqjqjTaA6njoH3R/n02Tr60azmwiA07McUqLqOszMj87GebeJIqqOfQr371tcKuK6C9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438323; c=relaxed/simple;
	bh=FpxVQB1INbV+80OzoaW6i4u58HK/pggkqM01al2Kpa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qurhlBCAdXCxtJGutndnYySNN6ITj40Sd3DuABrX9rmxXpdC6uDbZ+pcRgO+EjrlrDPuKtkgLisqf8RLTVHDjAtbe/cA6pAwzMDgzgNANDa3X+KIqtCLMwII3UG31ftvMZlQHpWkMdiLqAp7fPUGDQAPd21CVuP6Wps6/HTBVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dt7rl4Fk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 72DCD4E41569;
	Thu,  6 Nov 2025 14:12:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 476596068C;
	Thu,  6 Nov 2025 14:12:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 244C911851155;
	Thu,  6 Nov 2025 15:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762438319; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BHpWHfNsMm/O8uvLkpHCGYuFYP58PxmK8ahqwS8SU9M=;
	b=dt7rl4Fk419ka+j4AXX9FMZqTqMU3K2cmZos153TfZQZY6snNfBZsh0TI5VILosd98ZCio
	WiacUqgVCXvePcc7z3Wsjv4R2W9UMAy5pyApK1njA2jk2O3v8BH7BmX6W2/TRYb6CdN9oy
	P1pI/G8iCjvKqa9+sZmO7lYN0yhr0XP6NqzlAqAq04CG8snqFX3fTBnGExDOgVOCelxwYY
	30WxBuw1FXJaDzUCTleR/UzFPLTzzk8WdeGbINchTQzcmYZmX8fH57I07adi9XpuQdrx3f
	5qR3eHJU3+1WfpJMA3+fI3L1YeTnAjbLM+izJdh+nQEn8L1O4F2lxDeNu908IA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 06 Nov 2025 15:11:49 +0100
Subject: [PATCH v3 4/5] regulator: Support the LTM8054 voltage regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ltm8054-driver-v3-4-fd1feae0f65a@bootlin.com>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
In-Reply-To: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add a stub driver for the  Linear Technology LTM8054 Buck-Boost voltage
regulator. This version only supports enabling/disabling the regulator via
a GPIO, and reporting the output voltage level from the resistor divider
values given in the device tree.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 MAINTAINERS                           |   1 +
 drivers/regulator/Kconfig             |   8 +++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/ltm8054-regulator.c | 125 ++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96552be2fcdd..45906509508d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14789,6 +14789,7 @@ LTM8054 REGULATOR DRIVER
 M:	Romain Gantois <romain.gantois@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
+F:	drivers/regulator/ltm8054-regulator.c
 
 LTP (Linux Test Project)
 M:	Andrea Cervesato <andrea.cervesato@suse.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 403890a76070..f5c6d4a21a88 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -585,6 +585,14 @@ config REGULATOR_LTC3676
 	  This enables support for the LTC3676
 	  8-output regulators controlled via I2C.
 
+config REGULATOR_LTM8054
+	tristate "LTM8054 Buck-Boost voltage regulator"
+	help
+	  This driver provides support for the Analog Devices LTM8054
+	  Buck-Boost micromodule regulator. The LTM8054 has an adjustable
+	  output current limitation and a feedback pin for setting the
+	  output voltage level.
+
 config REGULATOR_MAX14577
 	tristate "Maxim 14577/77836 regulator"
 	depends on MFD_MAX14577
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b3101376029d..f2687755c291 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_REGULATOR_LP8788) += lp8788-ldo.o
 obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
 obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
+obj-$(CONFIG_REGULATOR_LTM8054) += ltm8054-regulator.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX5970) += max5970-regulator.o
diff --git a/drivers/regulator/ltm8054-regulator.c b/drivers/regulator/ltm8054-regulator.c
new file mode 100644
index 000000000000..b5783f6629e3
--- /dev/null
+++ b/drivers/regulator/ltm8054-regulator.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices LTM8054 Buck-Boost regulator driver
+ *
+ * Copyright (C) 2025 Bootlin
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/device/devres.h>
+#include <linux/device/driver.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+
+#include <linux/errno.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/types.h>
+
+/* The LTM8054 regulates its FB pin to 1.2V */
+#define LTM8054_FB_uV 1200000
+
+struct ltm8054_priv {
+	struct regulator_desc rdesc;
+};
+
+static int ltm8054_scale(unsigned int uV, u32 r1, u32 r2)
+{
+	u64 tmp;
+
+	tmp = (u64)uV * r1;
+	do_div(tmp, r2);
+
+	return uV + tmp;
+}
+
+static const struct regulator_ops ltm8054_regulator_ops = { };
+
+static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
+			    struct regulator_config *config)
+{
+	u32 r[2];
+	int ret;
+
+	ret = device_property_read_u32_array(dev, "regulator-fb-voltage-divider-ohms",
+					     r, ARRAY_SIZE(r));
+	if (ret)
+		return ret;
+
+	priv->rdesc.fixed_uV = ltm8054_scale(LTM8054_FB_uV, r[0], r[1]);
+	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
+	priv->rdesc.n_voltages = 1;
+
+	config->of_node = dev_of_node(dev);
+	config->init_data = of_get_regulator_init_data(dev,
+						       config->of_node,
+						       &priv->rdesc);
+	if (!config->init_data)
+		return -EINVAL;
+
+	config->ena_gpiod = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(config->ena_gpiod))
+		return PTR_ERR(config->ena_gpiod);
+
+	return 0;
+}
+
+static int ltm8054_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = { };
+	struct device *dev = &pdev->dev;
+	struct regulator_dev *rdev;
+	struct ltm8054_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->rdesc.name = "ltm8054-regulator";
+	priv->rdesc.ops = &ltm8054_regulator_ops;
+	priv->rdesc.type = REGULATOR_VOLTAGE;
+	priv->rdesc.owner = THIS_MODULE;
+
+	config.dev = dev;
+	config.driver_data = priv;
+
+	ret = ltm8054_of_parse(dev, priv, &config);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to parse device tree\n");
+
+	rdev = devm_regulator_register(dev, &priv->rdesc, &config);
+	if (IS_ERR(rdev))
+		return dev_err_probe(dev, PTR_ERR(rdev), "failed to register regulator\n");
+
+	return 0;
+}
+
+static const struct of_device_id ltm8054_of_match[] = {
+	{ .compatible = "adi,ltm8054" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ltm8054_of_match);
+
+static struct platform_driver ltm8054_driver = {
+	.probe = ltm8054_probe,
+	.driver = {
+		.name  = "ltm8054",
+		.of_match_table = ltm8054_of_match,
+	},
+};
+module_platform_driver(ltm8054_driver);
+
+MODULE_DESCRIPTION("LTM8054 regulator driver");
+MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.51.2


