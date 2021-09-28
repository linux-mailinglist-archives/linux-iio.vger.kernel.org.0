Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1AC41B062
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbhI1NeQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:34:16 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60213 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbhI1NeO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:14 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C815660009;
        Tue, 28 Sep 2021 13:32:30 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 17/48] mfd: ti_am335x_tscadc: Use driver data
Date:   Tue, 28 Sep 2021 15:31:12 +0200
Message-Id: <20210928133143.157329-18-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

So far every sub-cell parameter in this driver was hardcoded: cell name,
cell compatible, specific clock name and desired clock frequency.

As we are about to introduce support for ADC1/magnetic reader, we need a
bit of flexibility. Let's add a driver data structure which will contain
these information.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 22 ++++++++++++++++------
 include/linux/mfd/ti_am335x_tscadc.h |  9 +++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index ba821109e98b..69b0eff1a55e 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -137,6 +137,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	tscadc->data = of_device_get_match_data(&pdev->dev);
+
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 	of_property_read_u32(node, "ti,wires", &tsc_wires);
 	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
@@ -212,7 +214,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
+	tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
 	/* Set the control register bits */
@@ -241,8 +243,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (tsc_wires > 0) {
 		tscadc->tsc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "TI-am335x-tsc";
-		cell->of_compatible = "ti,am3359-tsc";
+		cell->name = tscadc->data->secondary_feature_name;
+		cell->of_compatible = tscadc->data->secondary_feature_compatible;
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
 	}
@@ -251,8 +253,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (adc_channels > 0) {
 		tscadc->adc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "TI-am335x-adc";
-		cell->of_compatible = "ti,am3359-adc";
+		cell->name = tscadc->data->adc_feature_name;
+		cell->of_compatible = tscadc->data->adc_feature_compatible;
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
 	}
@@ -338,8 +340,16 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
 
+static const struct ti_tscadc_data tscdata = {
+	.adc_feature_name = "TI-am335x-adc",
+	.adc_feature_compatible = "ti,am3359-adc",
+	.secondary_feature_name = "TI-am335x-tsc",
+	.secondary_feature_compatible = "ti,am3359-tsc",
+	.target_clk_rate = ADC_CLK,
+};
+
 static const struct of_device_id ti_tscadc_dt_ids[] = {
-	{ .compatible = "ti,am3359-tscadc", },
+	{ .compatible = "ti,am3359-tscadc", .data = &tscdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index ffc091b77633..bb3b56ade3fb 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -162,11 +162,20 @@
 
 #define TSCADC_CELLS		2
 
+struct ti_tscadc_data {
+	char *adc_feature_name;
+	char *adc_feature_compatible;
+	char *secondary_feature_name;
+	char *secondary_feature_compatible;
+	unsigned int target_clk_rate;
+};
+
 struct ti_tscadc_dev {
 	struct device *dev;
 	struct regmap *regmap;
 	void __iomem *tscadc_base;
 	phys_addr_t tscadc_phys_base;
+	const struct ti_tscadc_data *data;
 	int irq;
 	int used_cells;	/* 1-2 */
 	int tsc_wires;
-- 
2.27.0

