Return-Path: <linux-iio+bounces-24434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D89B9F4B9
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDD8384589
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD285283CA7;
	Thu, 25 Sep 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tajFAysD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978A154423
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803883; cv=none; b=iGj+Y2YyCSIlu8otcO7CC+9O0Q5W5wkSi7agq0aeeJ4PseEfo8AFmPs5ZvNAXoO+h+W9vcyqZy32ImzkxeDS88wY33KVHknDf+4DYaHp+u57bqG7ORl0L13c3KWZdSUNDOmqMlNllydYnGDT3kCtzeynh8x+2HRmvxKNYh63cWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803883; c=relaxed/simple;
	bh=cE6dqP10Uu7Ap+7dTimu+BxM1SJYWWd/P7RXknWJ/Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6TACExJWfReQk+uaeVyZjK6jKRmDlpyg7ei0K3wOL3K6eAEhgYy1Db99EJdSZlASV7y8lhWbNOoCX+Fti7lQCRsohfW9BdURiFMvS9UeyENcyTp4FDlH+Ey7vqVFE3+R0itkZWWH9kMUYpDsPB0bf3LnN2GhC0i4pH9hvhKPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tajFAysD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 70FE41A0FCD;
	Thu, 25 Sep 2025 12:38:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40B526062C;
	Thu, 25 Sep 2025 12:38:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46B97102F1895;
	Thu, 25 Sep 2025 14:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758803879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DBmZYj9uOOiozLigWRqEkHlxIev9s38O1X01yQhnqPo=;
	b=tajFAysDfCgDA/mszBL8ZF2V0D7e+a1m4dYYsSJ1FVpFIiZbTMRPD9+VyCUyXTho5VrMem
	LumFryZdWz7lrpm2VFAG8tE55IjuHF8YyWtMEtyY8FAGmOOu9nzotDfu0bRTtQp59sVzTj
	/7aPegnI9Xel32kRu6XXtDIPRaj8tOL+H/eVk8sV75xzY/pBCpnn0yUmFF2aD1IwMffyKV
	7pVhjSOcTbrINdxYLgs8jsW45ghqUHqLYD1fg8rvFo0+m1FmREtFfua1YGW6QWOpukaObw
	AEXBv0k5gUk76QV7cCh9t7aGBEZwo1ki6zj971hi4BzFVkjuDjiezK1qPTP2vQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 25 Sep 2025 14:37:37 +0200
Subject: [PATCH v2 5/5] regulator: ltm8054: Support output current limit
 control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-ltm8054-driver-v2-5-bb61a401a0dc@bootlin.com>
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

The LTM8054 supports setting a fixed output current limit using a sense
resistor connected to a dedicated pin. This limit can then be lowered
dynamically by varying the voltage level of the CTL pin.

Support controlling the LTM8054's output current limit.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/regulator/Kconfig             |   1 +
 drivers/regulator/ltm8054-regulator.c | 113 +++++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c48b2af350974b3715a1ecf05dec656a92268294..e9ee6ed9fe3587c542223a6d6be78412e96797ee 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -579,6 +579,7 @@ config REGULATOR_LTC3676
 
 config REGULATOR_LTM8054
 	tristate "LTM8054 Buck-Boost voltage regulator"
+	depends on IIO
 	help
 	  This driver provides support for the Analog Devices LTM8054
 	  Buck-Boost micromodule regulator. The LTM8054 has an adjustable
diff --git a/drivers/regulator/ltm8054-regulator.c b/drivers/regulator/ltm8054-regulator.c
index bc8cf98b5a3b5663481d148330de70a8165e5981..172ec32c5a9517c6fb38ded8095ffc8e1acf55f0 100644
--- a/drivers/regulator/ltm8054-regulator.c
+++ b/drivers/regulator/ltm8054-regulator.c
@@ -17,6 +17,8 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iio/consumer.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -26,10 +28,25 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 
+#include <linux/units.h>
+
 /* The LTM8054 regulates its FB pin to 1.2V */
 #define LTM8054_FB_uV 1200000
 
+/* Threshold voltage between the Vout and Iout pins which triggers current
+ * limiting.
+ */
+#define LTM8054_VOUT_IOUT_MAX_uV 58000
+
+#define LTM8054_MAX_CTL_uV 1200000
+#define LTM8054_MIN_CTL_uV 50000
+
 struct ltm8054_priv {
+	struct iio_channel *ctl_dac;
+
+	int min_uA;
+	int max_uA;
+
 	struct regulator_desc rdesc;
 };
 
@@ -43,18 +60,103 @@ static int ltm8054_scale(unsigned int uV, u32 r1, u32 r2)
 	return uV + tmp;
 }
 
-static const struct regulator_ops ltm8054_regulator_ops = { };
+static int ltm8054_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_uA)
+{
+	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
+	u64 vdac_uV;
+
+	min_uA = clamp_t(int, min_uA, priv->min_uA, priv->max_uA);
+
+	/* adjusted current limit = Rsense current limit * CTL pin voltage / max CTL pin voltage */
+	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_uV;
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
+	do_div(uA, LTM8054_MAX_CTL_uV);
+
+	return uA;
+}
+
+static const struct regulator_ops ltm8054_regulator_ops = {
+	.set_current_limit = ltm8054_set_current_limit,
+	.get_current_limit = ltm8054_get_current_limit,
+};
+
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
+	if (ret)
+		return ret;
+
+	if (type != IIO_VOLTAGE)
+		return -EINVAL;
+
+	priv->ctl_dac = ctl_dac;
+
+	return 0;
+}
 
 static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
 			    struct regulator_config *config)
 {
 	struct device_node *np = dev->of_node;
+	u32 rsense;
 	u32 r[2];
+	u64 tmp;
 	int ret;
 
 	config->of_node = np;
 
-	ret = device_property_read_u32_array(dev, "lltc,fb-voltage-divider", r, ARRAY_SIZE(r));
+	ret = device_property_read_u32(dev, "adi,iout-rsense-micro-ohms", &rsense);
+	if (ret)
+		return ret;
+
+	if (rsense == 0)
+		return -EINVAL;
+
+	/* The maximum output current limit is the one set by the Rsense resistor */
+	tmp = (u64)LTM8054_VOUT_IOUT_MAX_uV * MICRO;
+	do_div(tmp, rsense);
+	priv->max_uA = tmp;
+
+	/*
+	 * Applying a voltage below LTM8054_MAX_CTL_uV on the CTL pin reduces
+	 * the output current limit. If this level drops below
+	 * LTM8054_MIN_CTL_uV the regulator stops switching.
+	 */
+
+	tmp = (u64)priv->max_uA * LTM8054_MIN_CTL_uV;
+	do_div(tmp, LTM8054_MAX_CTL_uV);
+	priv->min_uA = tmp;
+
+	ret = device_property_read_u32_array(dev, "lltc,fb-voltage-divider", r, 2);
 	if (ret)
 		return ret;
 
@@ -62,6 +164,9 @@ static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
 	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
 	priv->rdesc.n_voltages = 1;
 
+	dev_dbg(dev, "max_uA: %d min_uA: %d fixed_uV: %d\n",
+		priv->max_uA, priv->min_uA, priv->rdesc.fixed_uV);
+
 	config->init_data = of_get_regulator_init_data(dev,
 						       np,
 						       &priv->rdesc);
@@ -99,6 +204,10 @@ static int ltm8054_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to parse device tree\n");
 
+	ret = ltm8054_init_ctl_dac(pdev, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize CTL DAC\n");
+
 	rdev = devm_regulator_register(dev, &priv->rdesc, &config);
 	if (IS_ERR(rdev))
 		return dev_err_probe(dev, PTR_ERR(rdev), "failed to register regulator\n");

-- 
2.51.0


