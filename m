Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3458B3F78A1
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbhHYPdq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:33:46 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:46667 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbhHYPdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:33:46 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id D3CA9CB5DF;
        Wed, 25 Aug 2021 15:26:14 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 64E1FC0002;
        Wed, 25 Aug 2021 15:25:51 +0000 (UTC)
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
Subject: [PATCH 15/40] mfd: ti_am335x_tscadc: Simplify divisor calculation
Date:   Wed, 25 Aug 2021 17:24:53 +0200
Message-Id: <20210825152518.379386-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Let's rewrite this on a single line, it does not hurt the readability
and saves a useless temporary variable.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index d27f8917272d..3231ccbbad02 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -122,7 +122,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct clk *clk;
 	u32 val;
 	int tsc_wires = 0, adc_channels = 0, readouts = 0;
-	int total_channels, clock_rate, ctrl, err;
+	int total_channels, ctrl, err;
 
 	/* Allocate memory for device */
 	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
@@ -208,11 +208,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		err = PTR_ERR(clk);
 		goto err_disable_clk;
 	}
-	clock_rate = clk_get_rate(clk);
-	tscadc->clk_div = clock_rate / ADC_CLK;
 
-	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
-	tscadc->clk_div--;
+	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
 	/* Set the control register bits */
-- 
2.27.0

