Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9663141B0AE
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbhI1NfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:35:23 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39029 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbhI1Nez (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:55 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2D75760015;
        Tue, 28 Sep 2021 13:33:12 +0000 (UTC)
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
Subject: [PATCH v4 35/48] mfd: ti_am335x_tscadc: Introduce a helper to deal with the type of hardware
Date:   Tue, 28 Sep 2021 15:31:30 +0200
Message-Id: <20210928133143.157329-36-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One way of knowing which hardware we are dealing with is to check the
compatible string. When this must be done at several places, it's best
and certainly more clear to use a helper for that.

Introduce ti_adc_with_touchscreen() to indicate if there is a touchscreen
controller available (meaning it's an am33xx-like ADC). This helper does
not indicate if it is actually used (that is the purpose of the use_tsc
boolean).

Introducing this helper helps making a difference in the code between
what is generic to both types of ADCs and what is specific to the am33xx
hardware before introducing support for the am437x hardware.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 36 ++++++++++++++++------------
 include/linux/mfd/ti_am335x_tscadc.h |  6 +++++
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index f7cfe2016bbc..4f76b5498077 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -105,8 +105,9 @@ static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
 {
 	unsigned int idleconfig;
 
-	idleconfig = STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
-			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
+	idleconfig = STEPCONFIG_INM_ADCREFM | STEPCONFIG_INP_ADCREFM;
+	if (ti_adc_with_touchscreen(tscadc))
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
+	if (ti_adc_with_touchscreen(tscadc)) {
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
+	if (ti_adc_with_touchscreen(tscadc)) {
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
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index cc6de9258455..ee160b2036c1 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -177,6 +177,12 @@ static inline struct ti_tscadc_dev *ti_tscadc_dev_get(struct platform_device *p)
 	return *tscadc_dev;
 }
 
+static inline bool ti_adc_with_touchscreen(struct ti_tscadc_dev *tscadc)
+{
+	return of_device_is_compatible(tscadc->dev->of_node,
+				       "ti,am3359-tscadc");
+}
+
 void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val);
 void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val);
 void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val);
-- 
2.27.0

