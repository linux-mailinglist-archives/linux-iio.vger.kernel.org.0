Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989FE42EB7F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhJOISS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:18:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34997 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbhJOIRm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D383220018;
        Fri, 15 Oct 2021 08:15:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 20/48] mfd: ti_am335x_tscadc: Always provide an idle configuration
Date:   Fri, 15 Oct 2021 10:14:38 +0200
Message-Id: <20211015081506.933180-21-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The idle register is valid no matter if the touchscreen is used or not,
let's always configure it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 67c30e4e8250..82cee764acc8 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -221,16 +221,16 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
 	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
-	/* Set register bits for Idle Config Mode */
 	if (tsc_wires > 0) {
 		tscadc->tsc_wires = tsc_wires;
 		if (tsc_wires == 5)
 			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
 		else
 			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
-		tscadc_idle_config(tscadc);
 	}
 
+	tscadc_idle_config(tscadc);
+
 	/* Enable the TSC module enable bit */
 	ctrl |= CNTRLREG_TSCSSENB;
 	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
@@ -321,8 +321,10 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
 		else
 			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
-		tscadc_idle_config(tscadc);
 	}
+
+	tscadc_idle_config(tscadc);
+
 	ctrl |= CNTRLREG_TSCSSENB;
 	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
-- 
2.27.0

