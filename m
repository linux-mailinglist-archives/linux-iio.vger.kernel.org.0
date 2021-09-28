Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB44441B066
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbhI1NeT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:34:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49909 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbhI1NeS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:18 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D35846000F;
        Tue, 28 Sep 2021 13:32:35 +0000 (UTC)
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
Subject: [PATCH v4 19/48] mfd: ti_am335x_tscadc: Drop useless variables from the driver structure
Date:   Tue, 28 Sep 2021 15:31:14 +0200
Message-Id: <20210928133143.157329-20-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Keeping the count of tsc_cells and adc_cells is completely redundant, we
can derive this information from other variables. Plus, these variables
are not used anywhere else now. Let's get rid of them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 15 ++++-----------
 include/linux/mfd/ti_am335x_tscadc.h |  3 ---
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index d9c0b16d8d0d..9ce1a3e34c1e 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -122,7 +122,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	const __be32 *cur;
 	u32 val;
 	int err, ctrl;
-	int tsc_wires = 0, adc_channels = 0, total_channels;
+	int tsc_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
 	int readouts = 0;
 
 	/* Allocate memory for device */
@@ -235,14 +235,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	ctrl |= CNTRLREG_TSCSSENB;
 	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
-	tscadc->used_cells = 0;
-	tscadc->tsc_cell = -1;
-	tscadc->adc_cell = -1;
-
 	/* TSC Cell */
 	if (tsc_wires > 0) {
-		tscadc->tsc_cell = tscadc->used_cells;
-		cell = &tscadc->cells[tscadc->used_cells++];
+		cell = &tscadc->cells[cell_idx++];
 		cell->name = tscadc->data->secondary_feature_name;
 		cell->of_compatible = tscadc->data->secondary_feature_compatible;
 		cell->platform_data = &tscadc;
@@ -251,8 +246,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* ADC Cell */
 	if (adc_channels > 0) {
-		tscadc->adc_cell = tscadc->used_cells;
-		cell = &tscadc->cells[tscadc->used_cells++];
+		cell = &tscadc->cells[cell_idx++];
 		cell->name = tscadc->data->adc_feature_name;
 		cell->of_compatible = tscadc->data->adc_feature_compatible;
 		cell->platform_data = &tscadc;
@@ -260,8 +254,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	}
 
 	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
-			      tscadc->cells, tscadc->used_cells, NULL,
-			      0, NULL);
+			      tscadc->cells, cell_idx, NULL, 0, NULL);
 	if (err < 0)
 		goto err_disable_clk;
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index bb3b56ade3fb..23442059d271 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -177,10 +177,7 @@ struct ti_tscadc_dev {
 	phys_addr_t tscadc_phys_base;
 	const struct ti_tscadc_data *data;
 	int irq;
-	int used_cells;	/* 1-2 */
 	int tsc_wires;
-	int tsc_cell;	/* -1 if not used */
-	int adc_cell;	/* -1 if not used */
 	struct mfd_cell cells[TSCADC_CELLS];
 	u32 reg_se_cache;
 	bool adc_waiting;
-- 
2.27.0

