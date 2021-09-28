Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC041B09F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbhI1NfF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:35:05 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50685 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbhI1Nep (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:45 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1D13060014;
        Tue, 28 Sep 2021 13:33:03 +0000 (UTC)
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
Subject: [PATCH v4 31/48] mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
Date:   Tue, 28 Sep 2021 15:31:26 +0200
Message-Id: <20210928133143.157329-32-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While the register list (and names) between ADC0 and ADC1 are pretty
close, the bits inside changed a little bit. To avoid any future
confusion, let's add the TSC prefix when some bits are in a register
that is common to both revisions of the ADC, but are specific to the
am33xx hardware.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 10 +++++-----
 include/linux/mfd/ti_am335x_tscadc.h | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index a34ca378e82c..ffd52e021c2c 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -222,13 +222,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	 * of the CTRL register but not the subsystem enable bit which must be
 	 * added manually when timely.
 	 */
-	tscadc->ctrl = CNTRLREG_STEPCONFIGWRT | CNTRLREG_STEPID;
+	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
 	if (tsc_wires > 0) {
-		tscadc->ctrl |= CNTRLREG_TSCENB;
+		tscadc->ctrl |= CNTRLREG_TSC_ENB;
 		if (tsc_wires == 5)
-			tscadc->ctrl |= CNTRLREG_5WIRE;
+			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
 		else
-			tscadc->ctrl |= CNTRLREG_4WIRE;
+			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
 	}
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 
@@ -328,7 +328,7 @@ static const struct ti_tscadc_data tscdata = {
 	.adc_feature_compatible = "ti,am3359-adc",
 	.secondary_feature_name = "TI-am335x-tsc",
 	.secondary_feature_compatible = "ti,am3359-tsc",
-	.target_clk_rate = ADC_CLK,
+	.target_clk_rate = TSC_ADC_CLK,
 };
 
 static const struct of_device_id ti_tscadc_dt_ids[] = {
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 860289ae8516..cc6de9258455 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -98,13 +98,13 @@
 /* Control register */
 #define CNTRLREG_SSENB		BIT(0)
 #define CNTRLREG_STEPID		BIT(1)
-#define CNTRLREG_STEPCONFIGWRT	BIT(2)
+#define CNTRLREG_TSC_STEPCONFIGWRT BIT(2)
 #define CNTRLREG_POWERDOWN	BIT(4)
-#define CNTRLREG_AFE_CTRL(val)	FIELD_PREP(GENMASK(6, 5), (val))
-#define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
-#define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
-#define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
-#define CNTRLREG_TSCENB		BIT(7)
+#define CNTRLREG_TSC_AFE_CTRL(val) FIELD_PREP(GENMASK(6, 5), (val))
+#define CNTRLREG_TSC_4WIRE	CNTRLREG_TSC_AFE_CTRL(1)
+#define CNTRLREG_TSC_5WIRE	CNTRLREG_TSC_AFE_CTRL(2)
+#define CNTRLREG_TSC_8WIRE	CNTRLREG_TSC_AFE_CTRL(3)
+#define CNTRLREG_TSC_ENB	BIT(7)
 
 /* FIFO READ Register */
 #define FIFOREAD_DATA_MASK	GENMASK(11, 0)
@@ -118,7 +118,7 @@
 #define SEQ_STATUS		BIT(5)
 #define CHARGE_STEP		0x11
 
-#define ADC_CLK			(3 * HZ_PER_MHZ)
+#define TSC_ADC_CLK		(3 * HZ_PER_MHZ)
 #define TOTAL_STEPS		16
 #define TOTAL_CHANNELS		8
 #define FIFO1_THRESHOLD		19
-- 
2.27.0

