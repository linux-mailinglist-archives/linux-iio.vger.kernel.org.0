Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949953F78D3
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbhHYPfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:36 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:48211 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241897AbhHYPfg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:36 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id BC2E0CBBA4;
        Wed, 25 Aug 2021 15:26:31 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1559CC000A;
        Wed, 25 Aug 2021 15:26:07 +0000 (UTC)
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
Subject: [PATCH 23/40] mfd: ti_am335x_tscadc: Rename a variable
Date:   Wed, 25 Aug 2021 17:25:01 +0200
Message-Id: <20210825152518.379386-24-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
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
---
 drivers/mfd/ti_am335x_tscadc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 02477ce827d0..047426a74a2e 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -121,7 +121,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	const __be32 *cur;
 	struct clk *clk;
 	u32 val;
-	int tsc_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
+	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
 	int total_channels, err;
 
 	/* Allocate memory for device */
@@ -139,7 +139,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc->data = of_device_get_match_data(&pdev->dev);
 
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
-	of_property_read_u32(node, "ti,wires", &tsc_wires);
+	of_property_read_u32(node, "ti,wires", &tscmag_wires);
 	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
@@ -152,7 +152,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	total_channels = tsc_wires + adc_channels;
+	total_channels = tscmag_wires + adc_channels;
 	if (total_channels > 8) {
 		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
 		return -EINVAL;
@@ -218,9 +218,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 
-	if (tsc_wires > 0) {
+	if (tscmag_wires > 0) {
 		tscadc->ctrl |= CNTRLREG_TSC_ENB;
-		if (tsc_wires == 5)
+		if (tscmag_wires == 5)
 			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
 		else
 			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
@@ -232,7 +232,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
 
 	/* TSC Cell */
-	if (tsc_wires > 0) {
+	if (tscmag_wires > 0) {
 		cell = &tscadc->cells[cell_idx++];
 		cell->name = tscadc->data->name_tscmag;
 		cell->of_compatible = tscadc->data->compat_tscmag;
-- 
2.27.0

