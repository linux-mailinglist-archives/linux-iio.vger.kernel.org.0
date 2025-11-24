Return-Path: <linux-iio+bounces-26425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA9EC8125E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BCC64E7CA8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67658313527;
	Mon, 24 Nov 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZwCjZDzH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF22D4B6D;
	Mon, 24 Nov 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995737; cv=none; b=QRqwX5wv1Q8Qi/akudIHkD0dJfpZpIPDHMRIushbsjnEC7DOGUIsr5ZwkrlyN+FayK2N60WgxfhxvkLz3ijCzoJ4dLN98O70eXvXyESRrMjrnQJ8Q/skKyl7nrG9e13L0YW2FKux39JRJUm2Bhw9BMLTDmLCYB7NdzlxPvCw8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995737; c=relaxed/simple;
	bh=0XXtFH5JTRu9GjlvApke3LBXNZd41+3sp9DO1muAbzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISUiL2XKAMDtL6o0ddRAfuG1a0mGLqthEXGV88bqgT/8FkE0vJJgBtrelw5eCGFWLJooYnJMlfEVDNjVj/sGUxNoFpBkqWYUoDeON+WqFE1GorKB8WW5Me4vWQ6U1SEVU6WlgA31hPSPyyclUQ5b4FvT+bwKaQvbMZme0TRmlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZwCjZDzH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B3081C139B1;
	Mon, 24 Nov 2025 14:48:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 542B6606FC;
	Mon, 24 Nov 2025 14:48:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0988510371DA2;
	Mon, 24 Nov 2025 15:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763995732; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=61cfthlfsbdCdnzz/AbceXADf0E+18fSp8Ri+Oo2Qb0=;
	b=ZwCjZDzHomN+kRis1qXgWgXS/wKCVUhmF9RxzHi6SbeGZ308ZLdEG8Z58JRAF6LTW+4rzC
	nNbI5pN3SFjTG688OxB4xbfzgxNlH/8BStO37d0UuiSNaKhu1zdxKbQheLXGwXpOvynxqv
	ScW31K84CtB9lo9zFT8AimxCFgsndhGDU3ujN9oCXoMsVstu8dUoH1hwc3Pkc5D4xfYh7C
	OgnZXsiX8z33AX2eWEuCpXPzv7nWcUNwSZbrMlp+cDW8+uPRNgbCCvK0p6Lm0C/aMhXPA5
	WVtiIqh5eGOrTdF/jCaBuozn+5VefavhuI/ylol1DZQL8fjhdhPVCJvK2jW0yw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 24 Nov 2025 15:48:09 +0100
Subject: [PATCH v4 5/6] regulator: Support the LTM8054 voltage regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-ltm8054-driver-v4-5-107a8a814abe@bootlin.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
In-Reply-To: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add a stub driver for the  Linear Technology LTM8054 Buck-Boost voltage
regulator. This version only supports enabling/disabling the regulator via
a GPIO, and reporting the output voltage level from the resistor divider
values given in the device tree.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 MAINTAINERS                           |   1 +
 drivers/regulator/Kconfig             |   8 +++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/ltm8054-regulator.c | 123 ++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01949aab8240..f8dfa965c11b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14794,6 +14794,7 @@ LTM8054 REGULATOR DRIVER
 M:	Romain Gantois <romain.gantois@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
+F:	drivers/regulator/ltm8054-regulator.c
 
 LTP (Linux Test Project)
 M:	Andrea Cervesato <andrea.cervesato@suse.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 0b2dac6f66ad..ab97025c8f94 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -595,6 +595,14 @@ config REGULATOR_LTC3676
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
index 316a84ea92d4..f494a963e5de 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_REGULATOR_LP8788) += lp8788-ldo.o
 obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
 obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
+obj-$(CONFIG_REGULATOR_LTM8054) += ltm8054-regulator.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX5970) += max5970-regulator.o
diff --git a/drivers/regulator/ltm8054-regulator.c b/drivers/regulator/ltm8054-regulator.c
new file mode 100644
index 000000000000..c432b00d75a4
--- /dev/null
+++ b/drivers/regulator/ltm8054-regulator.c
@@ -0,0 +1,123 @@
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
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
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


