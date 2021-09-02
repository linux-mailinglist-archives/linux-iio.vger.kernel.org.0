Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63B13FF63B
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347707AbhIBVxb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:31 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37395 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347717AbhIBVx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:53:27 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D5289240008;
        Thu,  2 Sep 2021 21:52:25 +0000 (UTC)
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
Subject: [PATCH v2 20/46] mfd: ti_am335x_tscadc: Always provide an idle configuration
Date:   Thu,  2 Sep 2021 23:51:18 +0200
Message-Id: <20210902215144.507243-21-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The idle register is valid no matter if the touchscreen is used or not,
let's always configure it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 4a24fc1141cf..5f189da99468 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -223,16 +223,16 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
@@ -323,8 +323,10 @@ static int __maybe_unused tscadc_resume(struct device *dev)
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

