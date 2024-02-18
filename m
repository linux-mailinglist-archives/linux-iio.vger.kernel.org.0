Return-Path: <linux-iio+bounces-2728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F25859823
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFE6281649
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DE06EB67;
	Sun, 18 Feb 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7v3ZSAh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FEEE57E
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277268; cv=none; b=tQcckT0T0sr8FdY9lXmoEl39/joI4isTEU5sipSLVfK75xJSI3LiL/V6omNF6xO/1bY8+1kS2KKFOM07A6B2B6VzmZigP3zndK+5AmZppftxbefaeRinac1ofX7Qv5rvP2f4IVo0oQ6xOunuieK0doRgR4a6XT0r/KnuJN/m1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277268; c=relaxed/simple;
	bh=o1lLh65GUtfa9hxkj8+eltRC+aj0rZTrXzAplf0lXyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul6Z9MTlZl6TV4eslSEn+hxO+mxYcqbfCdwUR/uBNRhJpmXKCz8yNTVQ81NQF96pzMjkftrV00g0eYpiTnm8e6OeBEWgFFLvPlZgZeur9ZPsyxUouTrm3gvF98KBShKsWIDnZsXr3sCC/6+I7StwzQqYismvHJV7yiX/XCPQDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7v3ZSAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1C1C43390;
	Sun, 18 Feb 2024 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277267;
	bh=o1lLh65GUtfa9hxkj8+eltRC+aj0rZTrXzAplf0lXyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7v3ZSAhLr+tFfdzIBUY9apjRyIcZpprOlSr8qdFvKSgEAWRpTSdlHgOjcK3mU31e
	 vwWFLJYDqiQG04drBR55ET6ZDXErOEGCwhZUkZOb8y2Ffx84OhEx/wVfzUumZxBkir
	 fuEezQOWHorlcuWkjn1kdgBbzcxthEkNLHjhA+AkEtXLtRA5xRJAeEqpqjFeJGom77
	 M2nrgEjOnN3XJbz7F0BdtqS8MFLj5J3PheS0RDQ43+sqPWxzw77lGCIX9sCE4T7Gma
	 DakUePne4b8pR+NaCOYFuj10+1jlCP1nXJjkk/b65Zi15TFcMhBmyhrHEMefCHd6UG
	 imVJPk0/rUrmw==
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
Subject: [PATCH 1/8] iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode based.
Date: Sun, 18 Feb 2024 17:27:24 +0000
Message-ID: <20240218172731.1023367-2-jic23@kernel.org>
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

Using the generic firmware data access functions from property.h
provides a number of advantages:
1) Works with different firmware types.
2) Doesn't provide a 'bad' example for new IIO drivers.
3) Lets us use the new _scoped() loops with automatic reference count
   cleanup for fwnode_handle

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 54 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 68c813de0605..534e73a24eb4 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -12,8 +12,9 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/imx25-tsadc.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -198,8 +199,6 @@ static int mx25_gcq_ext_regulator_setup(struct device *dev,
 static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			       struct mx25_gcq_priv *priv)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	struct device *dev = &pdev->dev;
 	int ret, i;
 
@@ -216,37 +215,30 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			     MX25_ADCQ_CFG_IN(i) |
 			     MX25_ADCQ_CFG_REFN_NGND2);
 
-	for_each_child_of_node(np, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		u32 reg;
 		u32 refp = MX25_ADCQ_CFG_REFP_INT;
 		u32 refn = MX25_ADCQ_CFG_REFN_NGND2;
 
-		ret = of_property_read_u32(child, "reg", &reg);
-		if (ret) {
-			dev_err(dev, "Failed to get reg property\n");
-			of_node_put(child);
-			return ret;
-		}
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to get reg property\n");
 
-		if (reg >= MX25_NUM_CFGS) {
-			dev_err(dev,
+		if (reg >= MX25_NUM_CFGS)
+			return dev_err_probe(dev, -EINVAL,
 				"reg value is greater than the number of available configuration registers\n");
-			of_node_put(child);
-			return -EINVAL;
-		}
 
-		of_property_read_u32(child, "fsl,adc-refp", &refp);
-		of_property_read_u32(child, "fsl,adc-refn", &refn);
+		fwnode_property_read_u32(child, "fsl,adc-refp", &refp);
+		fwnode_property_read_u32(child, "fsl,adc-refn", &refn);
 
 		switch (refp) {
 		case MX25_ADC_REFP_EXT:
 		case MX25_ADC_REFP_XP:
 		case MX25_ADC_REFP_YP:
 			ret = mx25_gcq_ext_regulator_setup(&pdev->dev, priv, refp);
-			if (ret) {
-				of_node_put(child);
+			if (ret)
 				return ret;
-			}
 			priv->channel_vref_mv[reg] =
 				regulator_get_voltage(priv->vref[refp]);
 			/* Conversion from uV to mV */
@@ -256,9 +248,8 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			priv->channel_vref_mv[reg] = 2500;
 			break;
 		default:
-			dev_err(dev, "Invalid positive reference %d\n", refp);
-			of_node_put(child);
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid positive reference %d\n", refp);
 		}
 
 		/*
@@ -268,16 +259,13 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 		refp = MX25_ADCQ_CFG_REFP(refp);
 		refn = MX25_ADCQ_CFG_REFN(refn);
 
-		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
-			dev_err(dev, "Invalid fsl,adc-refp property value\n");
-			of_node_put(child);
-			return -EINVAL;
-		}
-		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
-			dev_err(dev, "Invalid fsl,adc-refn property value\n");
-			of_node_put(child);
-			return -EINVAL;
-		}
+		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid fsl,adc-refp property value\n");
+
+		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid fsl,adc-refn property value\n");
 
 		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
 				   MX25_ADCQ_CFG_REFP_MASK |
-- 
2.43.2


