Return-Path: <linux-iio+bounces-2729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22187859824
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22A8281746
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FECD6EB66;
	Sun, 18 Feb 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS0kptlQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D8E57E
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277271; cv=none; b=swyezxjusguCYjjTM3XFG7z+p7LLrSaehCpd08tP5AyaDyF2g5eBgMYn+Jzccl/DNYDeuitYf2jBHehK8sfRA3QWMm5apJ7t/ZZN/zCScMXzeLDKyqx+MAsJQobHr+6GO9E3FOvq0gRUxec2WJ0k2tG4hR4nEUUVfyxfwbdgIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277271; c=relaxed/simple;
	bh=z4DTzHGJHbs7Lxr/ITF+XsPRqfQa9jv7ILlO7XJNliE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6PNV9edG7E74UiHyEiY351UPKIh366i8e+vk77eFcHbyJ/WONaKpEJisnm/SuVKnTEIZ6eVQN+FkkU2U0Xjru66IEWm1R+f8szPL7WMTKDpDBuV9s4gWjjCDphMisU9dX0nycon3omIJ+WrUp8sQfiJh0po+Wbxx7Yll3QExEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS0kptlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBE9C433F1;
	Sun, 18 Feb 2024 17:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277270;
	bh=z4DTzHGJHbs7Lxr/ITF+XsPRqfQa9jv7ILlO7XJNliE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qS0kptlQeF+oQwRhzzIJkF00F7Ug10tQHtdJ+Xjc/jdWWQWG/T1futjy1q+hn/hNZ
	 e6OSURkLLAIzUTNs2ACnfJS08kn8nm0ANmZWMFAtiWJ8wkarOq0fAbaHutRIjD5zij
	 shEqwW5lHsLc+s4kZ7WYjqPdfEnd2YlmwgoDKVJnJAu9JVyPk1gxW+iyfnGSvNozsE
	 LM9azwFI0F22j/sqfuFAwpWaGwVhFTajx/0fohjDwUReJi1mnol5yC43dwJ395djFC
	 2y/9FW2XUhkZGYhkR+8K6e/erBIcXD6xmePNEjcwIPbZRPZu4nkrQ+bTrpBvrbEmtt
	 Ir2Xwq9RwsDwg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/8] iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify probe
Date: Sun, 18 Feb 2024 17:27:25 +0000
Message-ID: <20240218172731.1023367-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Custom callbacks are need for regulators (so there is a handle to read
the voltage from) and the clk because it is retrieved from the parent
rather than directly from firmware description.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 86 ++++++++++++++-------------------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 534e73a24eb4..394396b91630 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -282,6 +282,17 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 	return 0;
 }
 
+static void mx25_gcq_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+/* Custom handling needed as this driver doesn't own the clock */
+static void mx25_gcq_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
 static int mx25_gcq_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -303,10 +314,9 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 		return PTR_ERR(mem);
 
 	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
-	if (IS_ERR(priv->regs)) {
-		dev_err(dev, "Failed to initialize regmap\n");
-		return PTR_ERR(priv->regs);
-	}
+	if (IS_ERR(priv->regs))
+		return dev_err_probe(dev, PTR_ERR(priv->regs),
+				     "Failed to initialize regmap\n");
 
 	mutex_init(&priv->lock);
 
@@ -322,69 +332,44 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 
 		ret = regulator_enable(priv->vref[i]);
 		if (ret)
-			goto err_regulator_disable;
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, mx25_gcq_reg_disable,
+					       priv->vref[i]);
+		if (ret)
+			return ret;
 	}
 
 	priv->clk = tsadc->clk;
 	ret = clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable clock\n");
-		goto err_vref_disable;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clock\n");
+
+	ret = devm_add_action_or_reset(dev, mx25_gcq_clk_disable,
+				       priv->clk);
+	if (ret)
+		return ret;
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_clk_unprepare;
+		return ret;
 
 	priv->irq = ret;
-	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
-	if (ret) {
-		dev_err(dev, "Failed requesting IRQ\n");
-		goto err_clk_unprepare;
-	}
+	ret = devm_request_irq(dev, priv->irq, mx25_gcq_irq, 0, pdev->name,
+			       priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed requesting IRQ\n");
 
 	indio_dev->channels = mx25_gcq_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
 	indio_dev->info = &mx25_gcq_iio_info;
 	indio_dev->name = driver_name;
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(dev, "Failed to register iio device\n");
-		goto err_irq_free;
-	}
-
-	platform_set_drvdata(pdev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register iio device\n");
 
 	return 0;
-
-err_irq_free:
-	free_irq(priv->irq, priv);
-err_clk_unprepare:
-	clk_disable_unprepare(priv->clk);
-err_vref_disable:
-	i = 4;
-err_regulator_disable:
-	for (; i-- > 0;) {
-		if (priv->vref[i])
-			regulator_disable(priv->vref[i]);
-	}
-	return ret;
-}
-
-static void mx25_gcq_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct mx25_gcq_priv *priv = iio_priv(indio_dev);
-	int i;
-
-	iio_device_unregister(indio_dev);
-	free_irq(priv->irq, priv);
-	clk_disable_unprepare(priv->clk);
-	for (i = 4; i-- > 0;) {
-		if (priv->vref[i])
-			regulator_disable(priv->vref[i]);
-	}
 }
 
 static const struct of_device_id mx25_gcq_ids[] = {
@@ -399,7 +384,6 @@ static struct platform_driver mx25_gcq_driver = {
 		.of_match_table = mx25_gcq_ids,
 	},
 	.probe		= mx25_gcq_probe,
-	.remove_new	= mx25_gcq_remove,
 };
 module_platform_driver(mx25_gcq_driver);
 
-- 
2.43.2


