Return-Path: <linux-iio+bounces-24433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81423B9F4B0
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C71BC035D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA740280334;
	Thu, 25 Sep 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kk5xQ80b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5126058D;
	Thu, 25 Sep 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803882; cv=none; b=MVjTljv6KAL4twJVHT6JAZsjz8+EHdMYSzCAvjIMUjoAwowzcb59quegtRwpLgA5iFuXHDKTXO5IXNJoaeoY/G6P5IaX6OCo2KYfRAj3Wv7xPZUAlUkk82hTI/y/5zP5pe3TIWGWXmmAFtQ6Dhy636PONs7kjPVm5yCfQgUi/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803882; c=relaxed/simple;
	bh=ww5ZuNFiVaKq48nt0LtjEQM7n2gmuZ7VXoE0sIeFjJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umxYNCJnFezcyT+YRVLdzc7sS6HpfF8glB90g5XQ+CBdR+ez8aTx4FM4FLq/0OyqcjgybBFTVH9SezPp+rcnGuZrMXoAvGwmnaYAMuvqjdROWf0+vNsuRtsQ3MfducmSowCj3bSy0gT1RvrCnP9vLgC1/FNDm/NGp5QAyUj2BsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kk5xQ80b; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F2F81A0FCC;
	Thu, 25 Sep 2025 12:37:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D9F716062C;
	Thu, 25 Sep 2025 12:37:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96311102F189D;
	Thu, 25 Sep 2025 14:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758803877; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zzaArUK40mxLPZyXfgdMYo6ReXlBpF/NnUC2885MlQY=;
	b=kk5xQ80b4hbjGDwHEzMDeS1rItinFDUJ9E0pbTOZmuWmwqaQI5rO8yNpGaQKRT6Fw1tRbN
	YtKoy4YUmaN6x2OSdRh2J+n3nsPK8s+5ZEZzuYGPEa21fijeK3OwF9UujvWPe2UAO+RxK6
	68WjvE5/ONWQD0husG8XEWBnEYOCY/RukZLCKdj2wF9iJ4tXRDOyjyrzHk9BL7Exk71ScW
	803+brgpA1uX3jvpQEU2z08HhvIHNc16VEvuEd6APWpKJme+rrogi9FM50l7n4DUo840mp
	MnWr14Q0tatcfqgqlRqEaYhYg8snihjdSjjykepx7EA+4/Daj4j5ZiCNuIDFGQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 25 Sep 2025 14:37:36 +0200
Subject: [PATCH v2 4/5] regulator: Support the LTM8054 voltage regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-ltm8054-driver-v2-4-bb61a401a0dc@bootlin.com>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
In-Reply-To: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
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
X-Mailer: b4 0.14.2
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
 drivers/regulator/ltm8054-regulator.c | 126 ++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69bcba82808bb815af436232fab50f70713fd533..310dac4f60ab1e6e82e4dd667482f46723964992 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14538,6 +14538,7 @@ LTM8054 REGULATOR DRIVER
 M:	Romain Gantois <romain.gantois@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
+F:	drivers/regulator/ltm8054-regulator.c
 
 LTP (Linux Test Project)
 M:	Andrea Cervesato <andrea.cervesato@suse.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e252bb11ae6615dc9154908bc237905b97e739e5..c48b2af350974b3715a1ecf05dec656a92268294 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -577,6 +577,14 @@ config REGULATOR_LTC3676
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
index 76b02d12b758c607028d2c8879017afc6d1b244e..afcc9ffcc72f268a9e999a185e3024d67261249a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_REGULATOR_LP8788) += lp8788-ldo.o
 obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
 obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
+obj-$(CONFIG_REGULATOR_LTM8054) += ltm8054-regulator.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX5970) += max5970-regulator.o
diff --git a/drivers/regulator/ltm8054-regulator.c b/drivers/regulator/ltm8054-regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..bc8cf98b5a3b5663481d148330de70a8165e5981
--- /dev/null
+++ b/drivers/regulator/ltm8054-regulator.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices LTM8054 Buck-Boost regulator driver
+ *
+ * Copyright (C) 2025 Bootlin
+ */
+
+#include <asm/div64.h>
+
+#include <linux/array_size.h>
+
+#include <linux/device.h>
+#include <linux/device/devres.h>
+#include <linux/device/driver.h>
+
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
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
+	struct device_node *np = dev->of_node;
+	u32 r[2];
+	int ret;
+
+	config->of_node = np;
+
+	ret = device_property_read_u32_array(dev, "lltc,fb-voltage-divider", r, ARRAY_SIZE(r));
+	if (ret)
+		return ret;
+
+	priv->rdesc.fixed_uV = ltm8054_scale(LTM8054_FB_uV, r[0], r[1]);
+	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
+	priv->rdesc.n_voltages = 1;
+
+	config->init_data = of_get_regulator_init_data(dev,
+						       np,
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
+	priv->rdesc.name = "ltm8054-regulator",
+	priv->rdesc.ops = &ltm8054_regulator_ops,
+	priv->rdesc.type = REGULATOR_VOLTAGE,
+	priv->rdesc.owner = THIS_MODULE,
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
2.51.0


