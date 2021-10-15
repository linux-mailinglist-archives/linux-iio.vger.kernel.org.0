Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3305E42EB70
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbhJOIRu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:17:50 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55275 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbhJOIRf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:35 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8EEA82001A;
        Fri, 15 Oct 2021 08:15:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 15/48] mfd: ti_am335x_tscadc: Simplify divisor calculation
Date:   Fri, 15 Oct 2021 10:14:33 +0200
Message-Id: <20211015081506.933180-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
index 8af44c08d925..53749a0a5722 100644
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

