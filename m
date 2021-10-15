Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5159342EB81
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhJOISS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:18:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42021 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhJOIRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:44 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1493920007;
        Fri, 15 Oct 2021 08:15:36 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 21/48] mfd: ti_am335x_tscadc: Reorder the initialization steps
Date:   Fri, 15 Oct 2021 10:14:39 +0200
Message-Id: <20211015081506.933180-22-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

TI AM335X TRM [1] states that most of the configuration should be set in
the control register in the first place, before actually enabling the
hardware with the subsystem enable bit.

So far only half of the configuration was made in the first step (before
enabling the "subsystem"), which does not make really sense. Also, the
probe and the resume patch were acting differently. Let's harmonize all
this by following these steps:
1/ Configure the CLKDIV register
2/ Configure the CTRL register
3/ Configure the idle configuration
4/ Really enable the device by rewriting the CTRL register with the
   subsystem enable bit set.

[1] https://www.ti.com/lit/pdf/spruh73

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 82cee764acc8..45f80834cabd 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -219,8 +219,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* Set the control register bits */
 	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
-	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
-
 	if (tsc_wires > 0) {
 		tscadc->tsc_wires = tsc_wires;
 		if (tsc_wires == 5)
@@ -228,6 +226,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		else
 			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
 	}
+	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
 	tscadc_idle_config(tscadc);
 
@@ -313,9 +312,9 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 	pm_runtime_get_sync(dev);
 
 	/* context restore */
-	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
-	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
+	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
 	if (tscadc->tsc_wires > 0) {
 		if (tscadc->tsc_wires == 5)
 			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
@@ -323,13 +322,13 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
 	}
 
+	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
+
 	tscadc_idle_config(tscadc);
 
 	ctrl |= CNTRLREG_TSCSSENB;
 	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
-	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
-
 	return 0;
 }
 
-- 
2.27.0

