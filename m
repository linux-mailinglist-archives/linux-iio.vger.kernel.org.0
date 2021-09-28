Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8341B05C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbhI1NeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:34:15 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49909 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbhI1NeJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 521FE60011;
        Tue, 28 Sep 2021 13:32:26 +0000 (UTC)
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
Subject: [PATCH v4 15/48] mfd: ti_am335x_tscadc: Simplify divisor calculation
Date:   Tue, 28 Sep 2021 15:31:10 +0200
Message-Id: <20210928133143.157329-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Let's rewrite this on a single line, it does not hurt the readability
and saves a useless temporary variable.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 7f7b8e79a7bf..20d8ddee27fe 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -122,7 +122,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	const __be32 *cur;
 	u32 val;
 	int err, ctrl;
-	int clock_rate;
 	int tsc_wires = 0, adc_channels = 0, total_channels;
 	int readouts = 0;
 
@@ -212,11 +211,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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

