Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61CB3F78DB
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbhHYPfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:40 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:56745 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhHYPfg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:36 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 6186DC4170;
        Wed, 25 Aug 2021 15:26:35 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0D8FAC0011;
        Wed, 25 Aug 2021 15:26:11 +0000 (UTC)
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
Subject: [PATCH 25/40] mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a touchscreen
Date:   Wed, 25 Aug 2021 17:25:03 +0200
Message-Id: <20210825152518.379386-26-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just checking the number of wires will soon not be enough, add a boolean
to indicated the actual use or not of the touchscreen.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 2f934fd2154a..30f53cdb41f8 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -121,6 +121,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	const __be32 *cur;
 	struct clk *clk;
 	u32 val;
+	bool use_tsc = false;
 	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
 	int total_channels, err;
 
@@ -141,6 +142,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 	of_property_read_u32(node, "ti,wires", &tscmag_wires);
 	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
+	if (tscmag_wires)
+		use_tsc = true;
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
@@ -163,7 +166,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (readouts * 2 + 2 + adc_channels > 16) {
+	if (use_tsc && (readouts * 2 + 2 + adc_channels > 16)) {
 		dev_err(&pdev->dev, "Too many step configurations requested\n");
 		return -EINVAL;
 	}
@@ -218,7 +221,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 
-	if (tscmag_wires > 0) {
+	if (use_tsc) {
 		tscadc->ctrl |= CNTRLREG_TSC_ENB;
 		if (tscmag_wires == 5)
 			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
-- 
2.27.0

