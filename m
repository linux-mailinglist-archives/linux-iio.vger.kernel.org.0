Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE313F78DC
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbhHYPfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:40 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:48081 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbhHYPfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:37 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4D604C42B1;
        Wed, 25 Aug 2021 15:26:37 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F3E76C0012;
        Wed, 25 Aug 2021 15:26:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 26/40] mfd: ti_am335x_tscadc: Introduce has_tsc
Date:   Wed, 25 Aug 2021 17:25:04 +0200
Message-Id: <20210825152518.379386-27-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One way of knowing which hardware we are dealing with is to check its
compatible. When this must be done at several places, it's best to use a
proper boolean for that. ->has_tsc indicates if there is a touchscreen
controller available (meaning it's a am33xx-like ADC) or not but does
not indicate if it is actually used (that is the purpose of the use_tsc
boolean in the probe).

Introducing this boolean helps making a difference in the code between
what is generic to both types of ADCs and what is specific to the am33xx
hardware before introducing support for the am437x hardware.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 37 +++++++++++++++++-----------
 include/linux/mfd/ti_am335x_tscadc.h |  1 +
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 30f53cdb41f8..a40091830cea 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -105,8 +105,9 @@ static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
 {
 	unsigned int idleconfig;
 
-	idleconfig = STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
-			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
+	idleconfig = STEPCONFIG_INM_ADCREFM | STEPCONFIG_INP_ADCREFM;
+	if (tscadc->data->has_tsc)
+		idleconfig |= STEPCONFIG_YNN | STEPCONFIG_YPN;
 
 	regmap_write(tscadc->regmap, REG_IDLECONFIG, idleconfig);
 }
@@ -139,11 +140,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	tscadc->data = of_device_get_match_data(&pdev->dev);
 
-	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
-	of_property_read_u32(node, "ti,wires", &tscmag_wires);
-	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
-	if (tscmag_wires)
-		use_tsc = true;
+	if (tscadc->data->has_tsc) {
+		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
+		of_property_read_u32(node, "ti,wires", &tscmag_wires);
+		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
+		if (tscmag_wires)
+			use_tsc = true;
+	}
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
@@ -218,15 +221,18 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
 	/* Set the control register bits */
-	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
-	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
+	tscadc->ctrl = CNTRLREG_STEPID;
+	if (tscadc->data->has_tsc) {
+		tscadc->ctrl |= CNTRLREG_TSC_STEPCONFIGWRT;
+		regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
+		if (use_tsc) {
+			tscadc->ctrl |= CNTRLREG_TSC_ENB;
+			if (tscmag_wires == 5)
+				tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
+			else
+				tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
+		}
 
-	if (use_tsc) {
-		tscadc->ctrl |= CNTRLREG_TSC_ENB;
-		if (tscmag_wires == 5)
-			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
-		else
-			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
 	}
 
 	tscadc_idle_config(tscadc);
@@ -321,6 +327,7 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
 
 static const struct ti_tscadc_data tscdata = {
+	.has_tsc = true,
 	.name_tscmag = "TI-am335x-tsc",
 	.compat_tscmag = "ti,am3359-tsc",
 	.name_adc = "TI-am335x-adc",
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index d5e2ff8dc84a..082b2af94263 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -163,6 +163,7 @@
 #define TSCADC_CELLS		2
 
 struct ti_tscadc_data {
+	bool has_tsc;
 	char *name_tscmag;
 	char *compat_tscmag;
 	char *name_adc;
-- 
2.27.0

