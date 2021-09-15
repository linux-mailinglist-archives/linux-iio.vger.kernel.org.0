Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D303440C982
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhIOQB7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:01:59 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41463 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbhIOQBk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:40 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 9DE001BF210;
        Wed, 15 Sep 2021 16:00:18 +0000 (UTC)
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
Subject: [PATCH v3 34/47] mfd: ti_am335x_tscadc: Introduce has_tsc
Date:   Wed, 15 Sep 2021 17:58:55 +0200
Message-Id: <20210915155908.476767-35-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 37 +++++++++++++++++-----------
 include/linux/mfd/ti_am335x_tscadc.h |  1 +
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index ab6c0e82d389..65c0fa735a71 100644
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
@@ -140,12 +141,14 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	tscadc->data = of_device_get_match_data(&pdev->dev);
 
-	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
-	of_property_read_u32(node, "ti,wires", &tscmag_wires);
-	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
-	of_node_put(node);
-	if (tscmag_wires)
-		use_tsc = true;
+	if (tscadc->data->has_tsc) {
+		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
+		of_property_read_u32(node, "ti,wires", &tscmag_wires);
+		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
+		of_node_put(node);
+		if (tscmag_wires)
+			use_tsc = true;
+	}
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
@@ -225,13 +228,16 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	 * of the CTRL register but not the subsystem enable bit which must be
 	 * added manually when timely.
 	 */
-	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
-	if (use_tsc) {
-		tscadc->ctrl |= CNTRLREG_TSC_ENB;
-		if (tscmag_wires == 5)
-			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
-		else
-			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
+	tscadc->ctrl = CNTRLREG_STEPID;
+	if (tscadc->data->has_tsc) {
+		tscadc->ctrl |= CNTRLREG_TSC_STEPCONFIGWRT;
+		if (use_tsc) {
+			tscadc->ctrl |= CNTRLREG_TSC_ENB;
+			if (tscmag_wires == 5)
+				tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
+			else
+				tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
+		}
 	}
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 
@@ -327,6 +333,7 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
 
 static const struct ti_tscadc_data tscdata = {
+	.has_tsc = true,
 	.name_tscmag = "TI-am335x-tsc",
 	.compat_tscmag = "ti,am3359-tsc",
 	.name_adc = "TI-am335x-adc",
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 26f3055635ac..467b3bec4335 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -140,6 +140,7 @@
 #define TSCADC_CELLS		2
 
 struct ti_tscadc_data {
+	bool has_tsc;
 	char *name_tscmag;
 	char *compat_tscmag;
 	char *name_adc;
-- 
2.27.0

