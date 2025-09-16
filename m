Return-Path: <linux-iio+bounces-24151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7FB593B0
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 12:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D521889512
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144B315D3B;
	Tue, 16 Sep 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="afZ84qiZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03812305E28
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018266; cv=none; b=Qn88cOvqhvb2HIm37orZjYIC8D0Yb8EsimP+NLt+BCGIh035htua6FVSmOWvxfROEgDhCBasjq4ImvlOgJVs1FJCQwwOZrBWR1UfP6/sMgTTf1kMaY9epwuJ5EFAXK9MXPliSKzdiBl4Ma2Sp9pN5Tz8gRAbjncZR5o0YadRGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018266; c=relaxed/simple;
	bh=eno6mobSsV0Vz477n004Idm38KpAYuuVSri+PQ/cVmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xq29JxtJrm/5uA5aRNrQ4RWzS9/Bu4zhX8AZmHTh8Ll2l7x+e/gAPcRDP/tzyT13SIQqc2gvQPu3Piuc/bp08y+XpzR/+erDtZEqp5TCMMOP79ln5BX3Q98iP4qa/5UqYPMOpg4MQ5Ag98zAO4dbMcGfAR9+SJ4wWGC1a2w+Pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=afZ84qiZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 744064E40BDF;
	Tue, 16 Sep 2025 10:24:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A5086061E;
	Tue, 16 Sep 2025 10:24:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 448C1102F16DF;
	Tue, 16 Sep 2025 12:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758018261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7xH/6o5AG/ZkEV08qqD3o809y7CCiNGJ+1iwApjb1E0=;
	b=afZ84qiZvW+v0wFW+c7lZHQr3eOyRJFuW33zqsqor6rzpbz0wu0WoiaUVuu31jPiZ14wyZ
	jhuYm6fA8xj6+Wo02YvtK/AC/UKyuBzkwUXRu9+uQyqtyPQJdYKoLqTrN5VmXNsQajDT4Q
	NqCEpj6nf6xR6/nC7oRPRlGiUEhDyAmcCOOcUPLyIP0K8DrBmSRsJ+TmEGj/QO7A9K1CoB
	KicgAyHT5zpr3B4YH+sXkIh8E0fHV0wOY8fXdnL4m304OGEJy71MtKXgtbmdtKlh+bGGA7
	EfGEuGYQfT4LzEfNNhxwamxwKcaG/o6z7sTtLttsE8UuQKDnENZuuWNDFrlzag==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 16 Sep 2025 12:24:09 +0200
Subject: [PATCH 4/4] regulator: ltm8054: Support output current limit
 control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ltm8054-driver-v1-4-fd4e781d33b9@bootlin.com>
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

The LTM8054 supports setting a fixed output current limit using a sense
resistor connected to a dedicated pin. This limit can then be lowered
dynamically by varying the voltage level of the CTL pin.

Support controlling the LTM8054's output current limit.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/regulator/Kconfig             |   1 +
 drivers/regulator/ltm8054-regulator.c | 109 ++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 15fb71193b67d0b2daa631b69778dde9323aedd2..22cf0e980351f21e3ef5b6611a39cb48aeb503ea 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -579,6 +579,7 @@ config REGULATOR_LTC3676
 
 config REGULATOR_LTM8054
 	tristate "LTM8054 Buck-Boost voltage regulator"
+	depends on IIO
 	help
 	  This driver provides support for the Linear Technology LTM8054
 	  Buck-Boost micromodule regulator. The LTM8054 has an adjustable
diff --git a/drivers/regulator/ltm8054-regulator.c b/drivers/regulator/ltm8054-regulator.c
index e41bd95da55fb87912e2cdf70bae231133c25745..3b7b826e29cfb37415a7fb7cab678cc33494d184 100644
--- a/drivers/regulator/ltm8054-regulator.c
+++ b/drivers/regulator/ltm8054-regulator.c
@@ -11,12 +11,27 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/types.h>
 #include <linux/gpio/consumer.h>
 
+/* Threshold voltage between the Vout and Iout pins which triggers current
+ * limiting, in microvolts
+ */
+#define LTM8054_VOUT_IOUT_MAX 58000
+
+#define LTM8054_MAX_CTL_V 1200000
+#define LTM8054_MIN_CTL_V 50000
+
 /* The LTM8054 regulates its FB pin to 1.2V */
 #define LTM8054_FB_V 1200000
 
 struct ltm8054_priv {
+	struct iio_channel *ctl_dac;
+
+	int min_uA;
+	int max_uA;
+
 	struct regulator_desc rdesc;
 };
 
@@ -30,18 +45,105 @@ static int ltm8054_scale(unsigned int uV, u32 r1, u32 r2)
 	return uV + (unsigned int)tmp;
 }
 
+static int ltm8054_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_uA)
+{
+	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
+	u64 vdac_uV;
+
+	min_uA = clamp_t(int, min_uA, priv->min_uA, priv->max_uA);
+
+	/* adjusted current limit = Rsense current limit * CTL pin voltage / max CTL pin voltage */
+	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_V;
+	do_div(vdac_uV, priv->max_uA);
+
+	dev_dbg(&rdev->dev,
+		"Setting current limit to %duA, CTL pin to %duV\n", min_uA, (int)vdac_uV);
+
+	/* Standard IIO voltage unit is mV, scale accordingly. */
+	return iio_write_channel_processed_scale(priv->ctl_dac, vdac_uV, 1000);
+}
+
+static int ltm8054_get_current_limit(struct regulator_dev *rdev)
+{
+	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
+	int ret, vdac_uv;
+	u64 uA;
+
+	ret = iio_read_channel_processed_scale(priv->ctl_dac, &vdac_uv, 1000);
+	if (ret < 0) {
+		dev_err(&rdev->dev, "failed to read CTL DAC voltage, err %d\n", ret);
+		return ret;
+	}
+
+	uA = (u64)vdac_uv * priv->max_uA;
+	do_div(uA, LTM8054_MAX_CTL_V);
+
+	return uA;
+}
+
 static const struct regulator_ops ltm8054_regulator_ops = {
+	.set_current_limit = ltm8054_set_current_limit,
+	.get_current_limit = ltm8054_get_current_limit,
 };
 
+static int ltm8054_init_ctl_dac(struct platform_device *pdev, struct ltm8054_priv *priv)
+{
+	struct iio_channel *ctl_dac;
+	enum iio_chan_type type;
+	int ret;
+
+	ctl_dac = devm_iio_channel_get(&pdev->dev, "ctl");
+	if (IS_ERR(ctl_dac))
+		return PTR_ERR(ctl_dac);
+
+	ret = iio_get_channel_type(ctl_dac, &type);
+	if (ret < 0)
+		return ret;
+
+	if (type != IIO_VOLTAGE)
+		return -EINVAL;
+
+	priv->ctl_dac = ctl_dac;
+
+	return 0;
+}
+
 static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
 			    struct regulator_config *config)
 {
 	struct device_node *np = dev->of_node;
+	u32 rsense;
 	u32 r[2];
+	u64 tmp;
 	int ret;
 
 	config->of_node = np;
 
+	ret = of_property_read_u32(np, "lltc,iout-rsense-micro-ohms", &rsense);
+	if (ret < 0) {
+		dev_err(dev, "failed to get sense resistor value\n");
+		return ret;
+	}
+
+	if (rsense == 0) {
+		dev_err(dev, "invalid value zero for sense resistor\n");
+		return -EINVAL;
+	}
+
+	/* The maximum output current limit is the one set by the Rsense resistor */
+	tmp = 1000000 * (u64)LTM8054_VOUT_IOUT_MAX;
+	do_div(tmp, rsense);
+	priv->max_uA = tmp;
+
+	/* Applying a voltage below LTM8054_MAX_CTL_V on the CTL pin reduces
+	 * the output current limit. If this level drops below
+	 * LTM8054_MIN_CTL_V the regulator stops switching
+	 */
+
+	tmp = LTM8054_MIN_CTL_V * (u64)priv->max_uA;
+	do_div(tmp, (u32)LTM8054_MAX_CTL_V);
+	priv->min_uA = tmp;
+
 	ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider", r, 2);
 	if (ret) {
 		dev_err(dev, "Failed to parse voltage divider\n");
@@ -52,6 +154,9 @@ static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
 	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
 	priv->rdesc.n_voltages = 1;
 
+	dev_dbg(dev, "max_uA: %d min_uA: %d fixed_uV: %d\n",
+		priv->max_uA, priv->min_uA, priv->rdesc.fixed_uV);
+
 	config->init_data = of_get_regulator_init_data(dev,
 						       np,
 						       &priv->rdesc);
@@ -92,6 +197,10 @@ static int ltm8054_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to parse device tree\n");
 
+	ret = ltm8054_init_ctl_dac(pdev, priv);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to initialize CTL DAC\n");
+
 	rdev = devm_regulator_register(&pdev->dev, &priv->rdesc, &config);
 	if (IS_ERR(rdev))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rdev), "failed to register regulator\n");

-- 
2.51.0


