Return-Path: <linux-iio+bounces-24150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FBAB593AC
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603FC1BC7782
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A04305E3E;
	Tue, 16 Sep 2025 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0WpEc2FM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544133054CE
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018264; cv=none; b=CPz4zCPbpXDVmqeGGOZle8SjTL1XqEOAtGZng06ebIbTwAIDytiAWrpESaC5Ilp8MtMY87YEyTMlTgV2VKdrLvUuMpujSWOvYujpDKqR2JuI80g/gWiWWlnckQoVBylrheyaOXZEj5oJsvaHIQb9dZzDXCOVdYS+VAK+U2wJ4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018264; c=relaxed/simple;
	bh=vC6bak3vajHp/KdZeZhz8m7Ms2hMvoLFBwxuzDF7oJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q11TJ+GySVFxBNFthChkit0UbWdV1FnGc9RAaKgkk03LuJrlhsnAamXBdNo8HbIpWHfIHYxCp3rOqhDyR1GIsq3ILVuZnHlftYID4PAcfjGUZBipLb8uvBH8TKx2RJDIuGGNFidmgZ4SorCNiP70BWOOdaU1Br7cHa4qfaViSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0WpEc2FM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 072461A0C11;
	Tue, 16 Sep 2025 10:24:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D132F6061E;
	Tue, 16 Sep 2025 10:24:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 082BA102F16D4;
	Tue, 16 Sep 2025 12:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758018259; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=odLlbEbxIjN2irzHQdkofES+um0xswwNXAgaifLMN0M=;
	b=0WpEc2FMItr0WO4B17EGk9jPpbGZnPISnz+SSyYUsRY+e/jLbibtu+PeRMqIZgDuoq+W0/
	4qoY0m1CWU+2CLNT78XdXz1/c9YC8/IccoKZDXj6NcPOHQ8V8VTFd1ynLpkC/k1/N0A0lr
	LvegIVF973yvQx4OGv51W0lb3cBe92i7oUfgslzGR6lKjmWIBdk0XwmGGyRBUXCw9zoDz0
	lAF4zUoLWvoWVKtNYh1/jvbHoXDfYptSjfhP1m5jEcWkIoiRSfQcIg/kkmx/IgOi4fYj+R
	F/1LxPTChO4hSoBv1Y8JyhLQ8GiyY56lGQhSRqnVo154l+tIq4O4ioTTpCMqIQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 16 Sep 2025 12:24:08 +0200
Subject: [PATCH 3/4] regulator: Support the LTM8054 voltage regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ltm8054-driver-v1-3-fd4e781d33b9@bootlin.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
In-Reply-To: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
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
 drivers/regulator/ltm8054-regulator.c | 120 ++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7160179e6bf9d45a241582c1b6df8c0ebf6c3641..4bc1a0e4c087060295a927da02f56c332269035f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14521,6 +14521,7 @@ LTM8054 REGULATOR DRIVER
 M:	Romain Gantois <romain.gantois@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml
+F:	drivers/regulator/ltm8054-regulator.c
 
 LTP (Linux Test Project)
 M:	Andrea Cervesato <andrea.cervesato@suse.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eaa6df1c9f806652a21942bcb48084ba63f942d9..15fb71193b67d0b2daa631b69778dde9323aedd2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -577,6 +577,14 @@ config REGULATOR_LTC3676
 	  This enables support for the LTC3676
 	  8-output regulators controlled via I2C.
 
+config REGULATOR_LTM8054
+	tristate "LTM8054 Buck-Boost voltage regulator"
+	help
+	  This driver provides support for the Linear Technology LTM8054
+	  Buck-Boost micromodule regulator. The LTM8054 has an adjustable
+	  output current limitation and a feedback pin for setting the
+	  output voltage level.
+
 config REGULATOR_MAX14577
 	tristate "Maxim 14577/77836 regulator"
 	depends on MFD_MAX14577
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index be98b29d6675d8be1ca984c2d137bdfc4ba2de87..0e61ef826c08f64ea638d19bf10e69abf1526aa7 100644
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
index 0000000000000000000000000000000000000000..e41bd95da55fb87912e2cdf70bae231133c25745
--- /dev/null
+++ b/drivers/regulator/ltm8054-regulator.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Linear Technology LTM8054 Buck-Boost regulator driver
+ *
+ * Copyright (C) 2025 Bootlin
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+
+/* The LTM8054 regulates its FB pin to 1.2V */
+#define LTM8054_FB_V 1200000
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
+	return uV + (unsigned int)tmp;
+}
+
+static const struct regulator_ops ltm8054_regulator_ops = {
+};
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
+	ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider", r, 2);
+	if (ret) {
+		dev_err(dev, "Failed to parse voltage divider\n");
+		return ret;
+	}
+
+	priv->rdesc.fixed_uV = ltm8054_scale(LTM8054_FB_V, r[0], r[1]);
+	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
+	priv->rdesc.n_voltages = 1;
+
+	config->init_data = of_get_regulator_init_data(dev,
+						       np,
+						       &priv->rdesc);
+	if (!config->init_data) {
+		dev_err(dev, "failed to parse init data\n");
+		return -EINVAL;
+	}
+
+	config->ena_gpiod = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(config->ena_gpiod)) {
+		dev_err(dev, "unable to acquire enable gpio\n");
+		return PTR_ERR(config->ena_gpiod);
+	}
+
+	return 0;
+}
+
+static int ltm8054_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = { 0 };
+	struct regulator_dev *rdev;
+	struct ltm8054_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->rdesc.name = "ltm8054-regulator",
+	priv->rdesc.ops = &ltm8054_regulator_ops,
+	priv->rdesc.type = REGULATOR_VOLTAGE,
+	priv->rdesc.owner = THIS_MODULE,
+
+	config.dev = &pdev->dev;
+	config.driver_data = priv;
+
+	ret = ltm8054_of_parse(&pdev->dev, priv, &config);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to parse device tree\n");
+
+	rdev = devm_regulator_register(&pdev->dev, &priv->rdesc, &config);
+	if (IS_ERR(rdev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rdev), "failed to register regulator\n");
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused ltm8054_of_match[] = {
+	{ .compatible = "lltc,ltm8054", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltm8054_of_match);
+
+static struct platform_driver ltm8054_driver = {
+	.probe = ltm8054_probe,
+	.driver = {
+		.name  = "ltm8054",
+		.of_match_table = of_match_ptr(ltm8054_of_match),
+	},
+};
+
+module_platform_driver(ltm8054_driver);
+
+MODULE_DESCRIPTION("LTM8054 regulator driver");
+MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.51.0


