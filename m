Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762C254E59
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgH0T2R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0T2Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 15:28:16 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15172087E;
        Thu, 27 Aug 2020 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598556495;
        bh=07+0q+YYLs1trEpL5eelKIee9jlu59Bsvp/F9bfhCHY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=flUvr+FnIxKzKGiBqDQy6OCgcKelc+2My9EALku4cNKEIkTx+VTk++FJbBeH3V9Gs
         ZoQ2hkc2Mbq0Ma70b+Rssnowv3CUI5FAly+OVqZvRxWOI3qf+OW2GaRxCQK89dRp3t
         Q12EwsveA7rTnqAXeSNt5xkatEB75uaz6Hhw9/HM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 08/18] iio: adc: stm32: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 21:26:32 +0200
Message-Id: <20200827192642.1725-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827192642.1725-1-krzk@kernel.org>
References: <20200827192642.1725-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Convert to devm_clk_get_optional
2. Update also stm32-dfsdm-core and stm32-dac-core.
3. Wrap around 100 characters (accepted by checkpatch).
---
 drivers/iio/adc/stm32-adc-core.c   | 67 +++++++++---------------------
 drivers/iio/adc/stm32-adc.c        |  9 +---
 drivers/iio/adc/stm32-dfsdm-adc.c  |  9 +---
 drivers/iio/adc/stm32-dfsdm-core.c |  8 +---
 drivers/iio/dac/stm32-dac-core.c   |  5 +--
 5 files changed, 26 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 0e2068ec068b..707c85dab7df 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -582,11 +582,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
 	priv->syscfg = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(priv->syscfg)) {
 		ret = PTR_ERR(priv->syscfg);
-		if (ret != -ENODEV) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Can't probe syscfg: %d\n", ret);
-			return ret;
-		}
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret, "Can't probe syscfg\n");
+
 		priv->syscfg = NULL;
 	}
 
@@ -596,12 +594,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
 		priv->booster = devm_regulator_get_optional(dev, "booster");
 		if (IS_ERR(priv->booster)) {
 			ret = PTR_ERR(priv->booster);
-			if (ret != -ENODEV) {
-				if (ret != -EPROBE_DEFER)
-					dev_err(dev, "can't get booster %d\n",
-						ret);
-				return ret;
-			}
+			if (ret != -ENODEV)
+				dev_err_probe(dev, ret, "can't get booster\n");
+
 			priv->booster = NULL;
 		}
 	}
@@ -612,11 +607,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
 		priv->vdd = devm_regulator_get_optional(dev, "vdd");
 		if (IS_ERR(priv->vdd)) {
 			ret = PTR_ERR(priv->vdd);
-			if (ret != -ENODEV) {
-				if (ret != -EPROBE_DEFER)
-					dev_err(dev, "can't get vdd %d\n", ret);
-				return ret;
-			}
+			if (ret != -ENODEV)
+				return dev_err_probe(dev, ret, "can't get vdd\n");
+
 			priv->vdd = NULL;
 		}
 	}
@@ -669,42 +662,20 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	priv->common.phys_base = res->start;
 
 	priv->vdda = devm_regulator_get(&pdev->dev, "vdda");
-	if (IS_ERR(priv->vdda)) {
-		ret = PTR_ERR(priv->vdda);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "vdda get failed, %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->vdda))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->vdda), "vdda get failed\n");
 
 	priv->vref = devm_regulator_get(&pdev->dev, "vref");
-	if (IS_ERR(priv->vref)) {
-		ret = PTR_ERR(priv->vref);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "vref get failed, %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->vref))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->vref), "vref get failed\n");
 
-	priv->aclk = devm_clk_get(&pdev->dev, "adc");
-	if (IS_ERR(priv->aclk)) {
-		ret = PTR_ERR(priv->aclk);
-		if (ret != -ENOENT) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get 'adc' clock\n");
-			return ret;
-		}
-		priv->aclk = NULL;
-	}
+	priv->aclk = devm_clk_get_optional(&pdev->dev, "adc");
+	if (IS_ERR(priv->aclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->aclk), "Can't get 'adc' clock\n");
 
-	priv->bclk = devm_clk_get(&pdev->dev, "bus");
-	if (IS_ERR(priv->bclk)) {
-		ret = PTR_ERR(priv->bclk);
-		if (ret != -ENOENT) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get 'bus' clock\n");
-			return ret;
-		}
-		priv->bclk = NULL;
-	}
+	priv->bclk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(priv->bclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->bclk), "Can't get 'bus' clock\n");
 
 	ret = stm32_adc_core_switches_probe(dev, priv);
 	if (ret)
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 3eb9ebe8372f..b8e764ca54a6 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1805,13 +1805,8 @@ static int stm32_adc_dma_request(struct device *dev, struct iio_dev *indio_dev)
 	adc->dma_chan = dma_request_chan(dev, "rx");
 	if (IS_ERR(adc->dma_chan)) {
 		ret = PTR_ERR(adc->dma_chan);
-		if (ret != -ENODEV) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev,
-					"DMA channel request failed with %d\n",
-					ret);
-			return ret;
-		}
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret, "DMA channel request failed with\n");
 
 		/* DMA is optional: fall back to IRQ mode */
 		adc->dma_chan = NULL;
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 5e10fb4f3704..12c951078c1f 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1473,13 +1473,8 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 	/* Optionally request DMA */
 	ret = stm32_dfsdm_dma_request(dev, indio_dev);
 	if (ret) {
-		if (ret != -ENODEV) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev,
-					"DMA channel request failed with %d\n",
-					ret);
-			return ret;
-		}
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret, "DMA channel request failed with\n");
 
 		dev_dbg(dev, "No DMA support\n");
 		return 0;
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 26e2011c5868..34e4e6e59acf 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -243,12 +243,8 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 	 * on use case.
 	 */
 	priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
-	if (IS_ERR(priv->clk)) {
-		ret = PTR_ERR(priv->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get clock (%d)\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), "Failed to get clock\n");
 
 	priv->aclk = devm_clk_get(&pdev->dev, "audio");
 	if (IS_ERR(priv->aclk))
diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 7e5809ba0dee..906436780347 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -150,10 +150,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (rst) {
 		if (IS_ERR(rst)) {
-			ret = PTR_ERR(rst);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "reset get failed, %d\n", ret);
-
+			ret = dev_err_probe(dev, PTR_ERR(rst), "reset get failed\n");
 			goto err_hw_stop;
 		}
 
-- 
2.17.1

