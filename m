Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7851E40C978
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhIOQBf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:01:35 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53133 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbhIOQBf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:35 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C67BD1BF20F;
        Wed, 15 Sep 2021 16:00:12 +0000 (UTC)
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
Subject: [PATCH v3 31/47] mfd: ti_am335x_tscadc: Rename a variable
Date:   Wed, 15 Sep 2021 17:58:52 +0200
Message-Id: <20210915155908.476767-32-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to retrieve the number of wires used by the "secondary" device
(the touchscreen or the magnetic reader). Let's rename tsc_wires to
become tscmag_wires to clarify the fact that this variable can be used
in both situations.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5242857993bc..7ab3a8328861 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -122,7 +122,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	const __be32 *cur;
 	u32 val;
 	int err;
-	int tsc_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
+	int tscmag_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
 	int readouts = 0;
 
 	/* Allocate memory for device */
@@ -140,7 +140,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc->data = of_device_get_match_data(&pdev->dev);
 
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
-	of_property_read_u32(node, "ti,wires", &tsc_wires);
+	of_property_read_u32(node, "ti,wires", &tscmag_wires);
 	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
 	of_node_put(node);
 
@@ -157,7 +157,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	of_node_put(node);
 
-	total_channels = tsc_wires + adc_channels;
+	total_channels = tscmag_wires + adc_channels;
 	if (total_channels > 8) {
 		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
 		return -EINVAL;
@@ -223,9 +223,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	 * added manually when timely.
 	 */
 	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
-	if (tsc_wires > 0) {
+	if (tscmag_wires > 0) {
 		tscadc->ctrl |= CNTRLREG_TSC_ENB;
-		if (tsc_wires == 5)
+		if (tscmag_wires == 5)
 			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
 		else
 			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
@@ -238,7 +238,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
 
 	/* TSC Cell */
-	if (tsc_wires > 0) {
+	if (tscmag_wires > 0) {
 		cell = &tscadc->cells[cell_idx++];
 		cell->name = tscadc->data->name_tscmag;
 		cell->of_compatible = tscadc->data->compat_tscmag;
-- 
2.27.0

