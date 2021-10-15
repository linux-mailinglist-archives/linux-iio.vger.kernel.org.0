Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBF642EB7D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhJOISI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:18:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51299 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbhJOIRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2C5E720011;
        Fri, 15 Oct 2021 08:15:32 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 19/48] mfd: ti_am335x_tscadc: Drop useless variables from the driver structure
Date:   Fri, 15 Oct 2021 10:14:37 +0200
Message-Id: <20211015081506.933180-20-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
index d340ecc4cafb..67c30e4e8250 100644
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

