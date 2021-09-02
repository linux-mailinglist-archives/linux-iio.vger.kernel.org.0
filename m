Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7223FF638
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347735AbhIBVx3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:29 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38923 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347708AbhIBVxZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:53:25 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1F24224000A;
        Thu,  2 Sep 2021 21:52:24 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 19/46] mfd: ti_am335x_tscadc: Drop useless variables from the driver structure
Date:   Thu,  2 Sep 2021 23:51:17 +0200
Message-Id: <20210902215144.507243-20-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
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
---
 drivers/mfd/ti_am335x_tscadc.c       | 15 ++++-----------
 include/linux/mfd/ti_am335x_tscadc.h |  3 ---
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 0dcc2151ac1f..4a24fc1141cf 100644
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
@@ -237,14 +237,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
 		cell->name = tscadc->data->name_tscmag;
 		cell->of_compatible = tscadc->data->compat_tscmag;
 		cell->platform_data = &tscadc;
@@ -253,8 +248,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* ADC Cell */
 	if (adc_channels > 0) {
-		tscadc->adc_cell = tscadc->used_cells;
-		cell = &tscadc->cells[tscadc->used_cells++];
+		cell = &tscadc->cells[cell_idx++];
 		cell->name = tscadc->data->name_adc;
 		cell->of_compatible = tscadc->data->compat_adc;
 		cell->platform_data = &tscadc;
@@ -262,8 +256,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	}
 
 	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
-			      tscadc->cells, tscadc->used_cells, NULL,
-			      0, NULL);
+			      tscadc->cells, cell_idx, NULL, 0, NULL);
 	if (err < 0)
 		goto err_disable_clk;
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 0f581c15d95a..e734fb97dff8 100644
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

