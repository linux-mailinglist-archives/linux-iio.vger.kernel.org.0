Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4541B070
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbhI1Neb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:34:31 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48071 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbhI1NeU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:20 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1DA4D60013;
        Tue, 28 Sep 2021 13:32:38 +0000 (UTC)
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
Subject: [PATCH v4 20/48] mfd: ti_am335x_tscadc: Always provide an idle configuration
Date:   Tue, 28 Sep 2021 15:31:15 +0200
Message-Id: <20210928133143.157329-21-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
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
index 9ce1a3e34c1e..d1f70224e457 100644
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

