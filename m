Return-Path: <linux-iio+bounces-25967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC1C3B9A9
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 15:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644A81AA4E3A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678FF33FE29;
	Thu,  6 Nov 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LI9HEaQ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150F33CE9D;
	Thu,  6 Nov 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438326; cv=none; b=huSC+u8mIN82p3ieIWNazdg20MXtlDOjyr/RiITVR91lEEhS5XlbgfXgXKL1r5MqR7G/QGzJ2SpQRDsEX9fkpFDNkzHo07azMF0zKDFiL/88DkCKY7MLucJJfNCwbT76YdZicChxg6nFGx8MldI+Xyy/Pvjn3qmQ2oZf51qF+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438326; c=relaxed/simple;
	bh=tBrLnoN6fk+Xqnm3U9nOXSYuDRrAPCj1BStgPuNDt7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibl/LuJJTKjIqEQRcD8pfTwRd89MeBrFcXz9Si5YrYndb79SkId92EtfqUmUwZOrSEpgCGZRFG12YWhZqgyr0f07tyDjTADEzmT6ZfdEGTKdEm8SGOHlcWvTU8fl8zzpOGzp2Cb+qiT0ORU6lETzV3bl6YyMeZkfbTzOXX/WcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LI9HEaQ1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CCD4C1A18F5;
	Thu,  6 Nov 2025 14:12:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A24A96068C;
	Thu,  6 Nov 2025 14:12:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3D721185115B;
	Thu,  6 Nov 2025 15:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762438320; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZKeWFZxA04Nf3/9eL/Uw741y2vR3pCplWxqb3hcOC3s=;
	b=LI9HEaQ1i0wvEe68W/tfHeEZ/AHtRXpsEbeYhliUApXxyy47PLgV1dQcYu1x/8xCwx4oj+
	nMACmlmkv0j2aRLaR1CsAWJFUjcR6ewc69wIz+D0hslv/GDWGtOEFCEYUbfPIDtdZh8KT5
	jYjQZZ/mcAG4ToTMk+3ybnw3ogU5zg06bJf1Irwre8wknpb+Y3XX1RvEC5dc1zJpg/MhMZ
	A7juBUx4D4TpNO1ZmiKKCq8eKaOU9iv9NFo2fJWr+EOWqKmjdzHAuHpHDv1rDNc6LKlLak
	Z8Q606K7qiJHuCs9tLWYSxQg+wvSOPKIu+CamLVd2esyrbXMvOUjhvWhjR4mdA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 06 Nov 2025 15:11:50 +0100
Subject: [PATCH v3 5/5] regulator: ltm8054: Support output current limit
 control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ltm8054-driver-v3-5-fd1feae0f65a@bootlin.com>
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

The LTM8054 supports setting a fixed output current limit using a sense
resistor connected to a dedicated pin. This limit can then be lowered
dynamically by varying the voltage level of the CTL pin.

Support controlling the LTM8054's output current limit.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/regulator/Kconfig             |   1 +
 drivers/regulator/ltm8054-regulator.c | 273 +++++++++++++++++++++++++++++++++-
 2 files changed, 268 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index f5c6d4a21a88..aad8c523420a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -587,6 +587,7 @@ config REGULATOR_LTC3676
 
 config REGULATOR_LTM8054
 	tristate "LTM8054 Buck-Boost voltage regulator"
+	depends on IIO
 	help
 	  This driver provides support for the Analog Devices LTM8054
 	  Buck-Boost micromodule regulator. The LTM8054 has an adjustable
diff --git a/drivers/regulator/ltm8054-regulator.c b/drivers/regulator/ltm8054-regulator.c
index b5783f6629e3..38072231b8e4 100644
--- a/drivers/regulator/ltm8054-regulator.c
+++ b/drivers/regulator/ltm8054-regulator.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/device/devres.h>
 #include <linux/device/driver.h>
@@ -15,7 +16,11 @@
 #include <linux/errno.h>
 
 #include <linux/gpio/consumer.h>
+#include <linux/iio/consumer.h>
+#include <linux/jiffies.h>
+#include <linux/lockdep.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -26,10 +31,42 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/types.h>
 
+#include <linux/units.h>
+#include <linux/workqueue.h>
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
+#define LTM8054_CTL_RW_TIMEOUT msecs_to_jiffies(500)
+
+/* CTL pin read/write transaction */
+struct ltm8054_ctl_pin_work {
+	struct work_struct work;
+	unsigned int ctl_val;
+	bool write;
+	int ret;
+};
+
 struct ltm8054_priv {
+	struct device *dev;
+
+	struct iio_channel *ctl_dac;
+	struct ltm8054_ctl_pin_work ctl_work;
+	/* Lock for ctl_work. */
+	struct mutex ctl_work_lock;
+	struct completion ctl_rw_done;
+
+	int min_uA;
+	int max_uA;
+
 	struct regulator_desc rdesc;
 };
 
@@ -43,14 +80,190 @@ static int ltm8054_scale(unsigned int uV, u32 r1, u32 r2)
 	return uV + tmp;
 }
 
-static const struct regulator_ops ltm8054_regulator_ops = { };
+static void ltm8054_do_ctl_work(struct work_struct *work)
+{
+	struct ltm8054_ctl_pin_work *ctl_work = container_of_const(work,
+								   struct ltm8054_ctl_pin_work,
+								   work);
+	struct ltm8054_priv *priv = container_of_const(ctl_work,
+						       struct ltm8054_priv,
+						       ctl_work);
+	unsigned int val;
+	bool write;
+	int ret;
+
+	lockdep_assert_not_held(&priv->ctl_work_lock);
+
+	mutex_lock(&priv->ctl_work_lock);
+	val = ctl_work->ctl_val;
+	write = ctl_work->write;
+	mutex_unlock(&priv->ctl_work_lock);
+
+	/* Standard IIO voltage unit is mV, scale accordingly. */
+	if (write)
+		ret = iio_write_channel_processed_scale(priv->ctl_dac,
+							val, 1000);
+	else
+		ret = iio_read_channel_processed_scale(priv->ctl_dac,
+						       &val, 1000);
+
+	pr_debug("LTM8054: %s CTL IO channel, val: %duV\n", write ? "wrote" : "reading", val);
+
+	mutex_lock(&priv->ctl_work_lock);
+	ctl_work->ret = ret;
+	ctl_work->ctl_val = val;
+	mutex_unlock(&priv->ctl_work_lock);
+
+	complete(&priv->ctl_rw_done);
+}
+
+static int ltm8054_ctl_pin_rw(struct ltm8054_priv *priv, bool write, unsigned int *ctl_val)
+{
+	struct ltm8054_ctl_pin_work *ctl_work = &priv->ctl_work;
+	int ret = 0;
+
+	lockdep_assert_not_held(&priv->ctl_work_lock);
+
+	/* The get/set_current_limit() callbacks have an active regulator core
+	 * reservation ID (obtained with ww_acquire_init()).
+	 *
+	 * Or, the IO channel driver may call something like
+	 * regulator_enable(), meaning this thread would acquire a new
+	 * regulator core reservation ID before the current one is dropped
+	 * (using ww_acquire_fini()). This is forbidden.
+	 *
+	 * Thus, perform the IO channel read/write in a different thread, and
+	 * wait for it to complete, with a timeout to avoid deadlocking.
+	 */
+
+	scoped_guard(mutex, &priv->ctl_work_lock) {
+		if (work_busy(&ctl_work->work))
+			return -EBUSY;
+
+		if (write) {
+			ctl_work->ctl_val = *ctl_val;
+			ctl_work->write = 1;
+		} else {
+			ctl_work->write = 0;
+		}
+
+		schedule_work(&ctl_work->work);
+	}
+
+	ret = wait_for_completion_timeout(&priv->ctl_rw_done, LTM8054_CTL_RW_TIMEOUT);
+	reinit_completion(&priv->ctl_rw_done);
+
+	if (unlikely(!ret))
+		return -ETIMEDOUT;
+
+	scoped_guard(mutex, &priv->ctl_work_lock) {
+		ret = ctl_work->ret;
+
+		if (!ret && !write)
+			*ctl_val = ctl_work->ctl_val;
+	}
+
+	return ret;
+}
+
+static int ltm8054_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_uA)
+{
+	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
+	unsigned int ctl_val;
+	u64 vdac_uV;
+
+	min_uA = clamp_t(int, min_uA, priv->min_uA, priv->max_uA);
+
+	/* adjusted current limit = Rsense current limit * CTL pin voltage / max CTL pin voltage */
+	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_uV;
+	do_div(vdac_uV, priv->max_uA);
+
+	dev_dbg(&rdev->dev,
+		"Setting current limit to %duA, CTL pin to %lluuV\n", min_uA, vdac_uV);
+
+	ctl_val = vdac_uV;
+
+	return ltm8054_ctl_pin_rw(priv, 1, &ctl_val);
+}
+
+static int ltm8054_get_current_limit(struct regulator_dev *rdev)
+{
+	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
+	unsigned int ctl_val;
+	int ret;
+	u64 uA;
+
+	ret = ltm8054_ctl_pin_rw(priv, 0, &ctl_val);
+	if (ret)
+		return ret;
+
+	uA = (u64)ctl_val * priv->max_uA;
+	do_div(uA, LTM8054_MAX_CTL_uV);
+
+	return uA;
+}
+
+static const struct regulator_ops ltm8054_no_ctl_ops = { };
+
+static const struct regulator_ops ltm8054_ctl_ops = {
+	.set_current_limit = ltm8054_set_current_limit,
+	.get_current_limit = ltm8054_get_current_limit,
+};
+
+static struct iio_channel *ltm8054_init_ctl_dac(struct platform_device *pdev)
+{
+	struct iio_channel *ctl_dac;
+	enum iio_chan_type type;
+	int ret;
+
+	ctl_dac = devm_iio_channel_get(&pdev->dev, "ctl");
+	if (IS_ERR(ctl_dac)) {
+		if (PTR_ERR(ctl_dac) == -ENODEV)
+			return ERR_PTR(-EPROBE_DEFER);
+
+		return ctl_dac;
+	}
+
+	ret = iio_get_channel_type(ctl_dac, &type);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (type != IIO_VOLTAGE)
+		return ERR_PTR(-EINVAL);
+
+	return ctl_dac;
+}
 
 static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
 			    struct regulator_config *config)
 {
+	u32 rsense;
 	u32 r[2];
+	u64 tmp;
 	int ret;
 
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
 	ret = device_property_read_u32_array(dev, "regulator-fb-voltage-divider-ohms",
 					     r, ARRAY_SIZE(r));
 	if (ret)
@@ -60,6 +273,9 @@ static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
 	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
 	priv->rdesc.n_voltages = 1;
 
+	dev_dbg(dev, "max_uA: %d min_uA: %d fixed_uV: %d\n",
+		priv->max_uA, priv->min_uA, priv->rdesc.fixed_uV);
+
 	config->of_node = dev_of_node(dev);
 	config->init_data = of_get_regulator_init_data(dev,
 						       config->of_node,
@@ -77,32 +293,76 @@ static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
 static int ltm8054_probe(struct platform_device *pdev)
 {
 	struct regulator_config config = { };
+	struct iio_channel *ctl_dac = NULL;
 	struct device *dev = &pdev->dev;
 	struct regulator_dev *rdev;
 	struct ltm8054_priv *priv;
 	int ret;
 
+	/* Do this first, as it might defer. */
+	if (device_property_match_string(dev, "io-channel-names", "ctl") >= 0) {
+		ctl_dac = ltm8054_init_ctl_dac(pdev);
+		if (IS_ERR(ctl_dac))
+			return dev_err_probe(dev, PTR_ERR(ctl_dac),
+					     "failed to initialize CTL DAC\n");
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, priv);
+
+	priv->dev = dev;
 	priv->rdesc.name = "ltm8054-regulator";
-	priv->rdesc.ops = &ltm8054_regulator_ops;
+	priv->rdesc.ops = &ltm8054_no_ctl_ops;
 	priv->rdesc.type = REGULATOR_VOLTAGE;
 	priv->rdesc.owner = THIS_MODULE;
 
+	if (ctl_dac) {
+		priv->ctl_dac = ctl_dac;
+
+		INIT_WORK(&priv->ctl_work.work, ltm8054_do_ctl_work);
+		init_completion(&priv->ctl_rw_done);
+		mutex_init(&priv->ctl_work_lock);
+
+		priv->rdesc.ops = &ltm8054_ctl_ops;
+	}
+
 	config.dev = dev;
 	config.driver_data = priv;
 
 	ret = ltm8054_of_parse(dev, priv, &config);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to parse device tree\n");
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "failed to parse device tree\n");
+		goto out_err;
+	}
 
 	rdev = devm_regulator_register(dev, &priv->rdesc, &config);
-	if (IS_ERR(rdev))
-		return dev_err_probe(dev, PTR_ERR(rdev), "failed to register regulator\n");
+	if (IS_ERR(rdev)) {
+		ret = dev_err_probe(dev, PTR_ERR(rdev), "failed to register regulator\n");
+		goto out_err;
+	}
 
 	return 0;
+
+out_err:
+	if (ctl_dac) {
+		cancel_work_sync(&priv->ctl_work.work);
+		mutex_destroy(&priv->ctl_work_lock);
+	}
+
+	return ret;
+}
+
+static void ltm8054_remove(struct platform_device *pdev)
+{
+	struct ltm8054_priv *priv = platform_get_drvdata(pdev);
+
+	if (priv->ctl_dac) {
+		cancel_work_sync(&priv->ctl_work.work);
+		mutex_destroy(&priv->ctl_work_lock);
+	}
 }
 
 static const struct of_device_id ltm8054_of_match[] = {
@@ -113,6 +373,7 @@ MODULE_DEVICE_TABLE(of, ltm8054_of_match);
 
 static struct platform_driver ltm8054_driver = {
 	.probe = ltm8054_probe,
+	.remove = ltm8054_remove,
 	.driver = {
 		.name  = "ltm8054",
 		.of_match_table = ltm8054_of_match,

-- 
2.51.2


