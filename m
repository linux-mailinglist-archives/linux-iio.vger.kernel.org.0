Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1340C95E
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbhIOQBR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:01:17 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35983 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbhIOQBO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:14 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 056141BF20B;
        Wed, 15 Sep 2021 15:59:52 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 22/47] mfd: ti_am335x_tscadc: Gather the ctrl register logic in one place
Date:   Wed, 15 Sep 2021 17:58:43 +0200
Message-Id: <20210915155908.476767-23-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of deriving in the probe and in the resume path the value of the
ctrl register, let's do it only once in the probe, save the value of
this register (all but the subsystem enable bit) in the driver's
structure and use it from the resume callback.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 39 ++++++++++------------------
 include/linux/mfd/ti_am335x_tscadc.h |  2 +-
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 951734801139..f627405d16f0 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -121,7 +121,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct property *prop;
 	const __be32 *cur;
 	u32 val;
-	int err, ctrl;
+	int err;
 	int tsc_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
 	int readouts = 0;
 
@@ -217,22 +217,25 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
-	/* Set the control register bits */
-	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
+	/*
+	 * Set the control register bits. tscadc->ctrl stores the configuration
+	 * of the CTRL register but not the subsystem enable bit which must be
+	 * added manually when timely.
+	 */
+	tscadc->ctrl = CNTRLREG_STEPCONFIGWRT | CNTRLREG_STEPID;
 	if (tsc_wires > 0) {
-		tscadc->tsc_wires = tsc_wires;
+		tscadc->ctrl |= CNTRLREG_TSCENB;
 		if (tsc_wires == 5)
-			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
+			tscadc->ctrl |= CNTRLREG_5WIRE;
 		else
-			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
+			tscadc->ctrl |= CNTRLREG_4WIRE;
 	}
-	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 
 	tscadc_idle_config(tscadc);
 
 	/* Enable the TSC module enable bit */
-	ctrl |= CNTRLREG_TSCSSENB;
-	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);
 
 	/* TSC Cell */
 	if (tsc_wires > 0) {
@@ -307,27 +310,13 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 static int __maybe_unused tscadc_resume(struct device *dev)
 {
 	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
-	u32 ctrl;
 
 	pm_runtime_get_sync(dev);
 
-	/* context restore */
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
-
-	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
-	if (tscadc->tsc_wires > 0) {
-		if (tscadc->tsc_wires == 5)
-			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
-		else
-			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
-	}
-
-	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
-
+	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 	tscadc_idle_config(tscadc);
-
-	ctrl |= CNTRLREG_TSCSSENB;
-	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);
 
 	return 0;
 }
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index e734fb97dff8..02963b6ebbac 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -177,8 +177,8 @@ struct ti_tscadc_dev {
 	phys_addr_t tscadc_phys_base;
 	const struct ti_tscadc_data *data;
 	int irq;
-	int tsc_wires;
 	struct mfd_cell cells[TSCADC_CELLS];
+	u32 ctrl;
 	u32 reg_se_cache;
 	bool adc_waiting;
 	bool adc_in_use;
-- 
2.27.0

