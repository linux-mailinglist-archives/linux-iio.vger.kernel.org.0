Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4542EBA3
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhJOISr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:18:47 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55513 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbhJOISD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:18:03 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0A48920020;
        Fri, 15 Oct 2021 08:15:54 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 36/48] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader support
Date:   Fri, 15 Oct 2021 10:14:54 +0200
Message-Id: <20211015081506.933180-37-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce a new compatible that has another set of driver data,
targeting am437x SoCs with a magnetic reader instead of the
touchscreen and a more featureful set of registers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 37 ++++++++++++++++++++++------
 include/linux/mfd/ti_am335x_tscadc.h |  6 +++++
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index af22fd735933..7b6d18144e27 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -121,11 +121,11 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct mfd_cell *cell;
 	struct property *prop;
 	const __be32 *cur;
-	bool use_tsc = false;
+	bool use_tsc = false, use_mag = false;
 	u32 val;
 	int err;
 	int tscmag_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
-	int readouts = 0;
+	int readouts = 0, mag_tracks = 0;
 
 	/* Allocate memory for device */
 	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
@@ -148,6 +148,16 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		of_node_put(node);
 		if (tscmag_wires)
 			use_tsc = true;
+	} else {
+		/*
+		 * When adding support for the magnetic stripe reader, here is
+		 * the place to look for the number of tracks used from device
+		 * tree. Let's default to 0 for now.
+		 */
+		mag_tracks = 0;
+		tscmag_wires = mag_tracks * 2;
+		if (tscmag_wires)
+			use_mag = true;
 	}
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
@@ -209,8 +219,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	 * The TSC_ADC_Subsystem has 2 clock domains: OCP_CLK and ADC_CLK.
 	 * ADCs produce a 12-bit sample every 15 ADC_CLK cycles.
 	 * am33xx ADCs expect to capture 200ksps.
-	 * We need the ADC clocks to run at 3MHz.
-	 * This frequency is valid since TSC_ADC_SS controller design
+	 * am47xx ADCs expect to capture 867ksps.
+	 * We need ADC clocks respectively running at 3MHz and 13MHz.
+	 * These frequencies are valid since TSC_ADC_SS controller design
 	 * assumes the OCP clock is at least 6x faster than the ADC clock.
 	 */
 	clk = devm_clk_get(&pdev->dev, NULL);
@@ -238,6 +249,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 			else
 				tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
 		}
+	} else {
+		tscadc->ctrl |= CNTRLREG_MAG_PREAMP_PWRDOWN |
+				CNTRLREG_MAG_PREAMP_BYPASS;
 	}
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 
@@ -246,8 +260,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	/* Enable the TSC module enable bit */
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
 
-	/* TSC Cell */
-	if (tscmag_wires > 0) {
+	/* TSC or MAG Cell */
+	if (use_tsc || use_mag) {
 		cell = &tscadc->cells[cell_idx++];
 		cell->name = tscadc->data->secondary_feature_name;
 		cell->of_compatible = tscadc->data->secondary_feature_compatible;
@@ -340,8 +354,17 @@ static const struct ti_tscadc_data tscdata = {
 	.target_clk_rate = TSC_ADC_CLK,
 };
 
+static const struct ti_tscadc_data magdata = {
+	.adc_feature_name = "TI-am43xx-adc",
+	.adc_feature_compatible = "ti,am4372-adc",
+	.secondary_feature_name = "TI-am43xx-mag",
+	.secondary_feature_compatible = "ti,am4372-mag",
+	.target_clk_rate = MAG_ADC_CLK,
+};
+
 static const struct of_device_id ti_tscadc_dt_ids[] = {
 	{ .compatible = "ti,am3359-tscadc", .data = &tscdata },
+	{ .compatible = "ti,am4372-magadc", .data = &magdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
@@ -359,6 +382,6 @@ static struct platform_driver ti_tscadc_driver = {
 
 module_platform_driver(ti_tscadc_driver);
 
-MODULE_DESCRIPTION("TI touchscreen / ADC MFD controller driver");
+MODULE_DESCRIPTION("TI touchscreen/magnetic stripe reader/ADC MFD controller driver");
 MODULE_AUTHOR("Rachna Patil <rachna@ti.com>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index ee160b2036c1..5225e3fc194d 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -106,6 +106,11 @@
 #define CNTRLREG_TSC_8WIRE	CNTRLREG_TSC_AFE_CTRL(3)
 #define CNTRLREG_TSC_ENB	BIT(7)
 
+/*Control registers bitfields  for MAGADC IP */
+#define CNTRLREG_MAGADCENB      BIT(0)
+#define CNTRLREG_MAG_PREAMP_PWRDOWN BIT(5)
+#define CNTRLREG_MAG_PREAMP_BYPASS  BIT(6)
+
 /* FIFO READ Register */
 #define FIFOREAD_DATA_MASK	GENMASK(11, 0)
 #define FIFOREAD_CHNLID_MASK	GENMASK(19, 16)
@@ -119,6 +124,7 @@
 #define CHARGE_STEP		0x11
 
 #define TSC_ADC_CLK		(3 * HZ_PER_MHZ)
+#define MAG_ADC_CLK		(13 * HZ_PER_MHZ)
 #define TOTAL_STEPS		16
 #define TOTAL_CHANNELS		8
 #define FIFO1_THRESHOLD		19
-- 
2.27.0

