Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA13F78B0
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbhHYPe0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:34:26 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:46939 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbhHYPeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:34:25 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5BF73CA647;
        Wed, 25 Aug 2021 15:26:21 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7A81BC0007;
        Wed, 25 Aug 2021 15:25:57 +0000 (UTC)
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
Subject: [PATCH 18/40] mfd: ti_am335x_tscadc: Drop useless variables from the driver structure
Date:   Wed, 25 Aug 2021 17:24:56 +0200
Message-Id: <20210825152518.379386-19-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
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
index c25c7f5c101b..258199be4c6a 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -121,7 +121,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	const __be32 *cur;
 	struct clk *clk;
 	u32 val;
-	int tsc_wires = 0, adc_channels = 0, readouts = 0;
+	int tsc_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
 	int total_channels, ctrl, err;
 
 	/* Allocate memory for device */
@@ -232,14 +232,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
@@ -248,8 +243,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* ADC Cell */
 	if (adc_channels > 0) {
-		tscadc->adc_cell = tscadc->used_cells;
-		cell = &tscadc->cells[tscadc->used_cells++];
+		cell = &tscadc->cells[cell_idx++];
 		cell->name = tscadc->data->name_adc;
 		cell->of_compatible = tscadc->data->compat_adc;
 		cell->platform_data = &tscadc;
@@ -257,8 +251,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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

