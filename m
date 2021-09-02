Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64113FF62D
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347721AbhIBVx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:27 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:39245 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347692AbhIBVxW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:53:22 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 53BA4240003;
        Thu,  2 Sep 2021 21:52:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 17/46] mfd: ti_am335x_tscadc: Use driver data
Date:   Thu,  2 Sep 2021 23:51:15 +0200
Message-Id: <20210902215144.507243-18-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
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
 drivers/mfd/ti_am335x_tscadc.c       | 25 +++++++++++++++++++------
 include/linux/mfd/ti_am335x_tscadc.h |  9 +++++++++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index ea52d8523524..3424befb0d29 100644
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
@@ -214,7 +216,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
+	tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
 	/* Set the control register bits */
@@ -243,8 +245,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (tsc_wires > 0) {
 		tscadc->tsc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "TI-am335x-tsc";
-		cell->of_compatible = "ti,am3359-tsc";
+		cell->name = tscadc->data->name_tscmag;
+		cell->of_compatible = tscadc->data->compat_tscmag;
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
 	}
@@ -253,8 +255,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (adc_channels > 0) {
 		tscadc->adc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "TI-am335x-adc";
-		cell->of_compatible = "ti,am3359-adc";
+		cell->name = tscadc->data->name_adc;
+		cell->of_compatible = tscadc->data->compat_adc;
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
 	}
@@ -340,8 +342,19 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
 
+static const struct ti_tscadc_data tscdata = {
+	.name_tscmag = "TI-am335x-tsc",
+	.compat_tscmag = "ti,am3359-tsc",
+	.name_adc = "TI-am335x-adc",
+	.compat_adc = "ti,am3359-adc",
+	.target_clk_rate = ADC_CLK,
+};
+
 static const struct of_device_id ti_tscadc_dt_ids[] = {
-	{ .compatible = "ti,am3359-tscadc", },
+	{
+		.compatible = "ti,am3359-tscadc",
+		.data = &tscdata,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index ffc091b77633..0f581c15d95a 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -162,11 +162,20 @@
 
 #define TSCADC_CELLS		2
 
+struct ti_tscadc_data {
+	char *name_tscmag;
+	char *compat_tscmag;
+	char *name_adc;
+	char *compat_adc;
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

