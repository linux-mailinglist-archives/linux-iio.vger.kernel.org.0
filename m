Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2741B050
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbhI1NeI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:34:08 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51361 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241144AbhI1NeA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:00 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E0C9D60009;
        Tue, 28 Sep 2021 13:32:16 +0000 (UTC)
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
Subject: [PATCH v4 12/48] mfd: ti_am335x_tscadc: Get rid of useless gotos
Date:   Tue, 28 Sep 2021 15:31:07 +0200
Message-Id: <20210928133143.157329-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Goto's jumping to a return statement are not really useful, drop them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 07da4059d7f7..a211b35ad106 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -174,7 +174,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	err = platform_get_irq(pdev, 0);
 	if (err < 0)
-		goto ret;
+		return err;
 	else
 		tscadc->irq = err;
 
@@ -189,8 +189,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 					       &tscadc_regmap_config);
 	if (IS_ERR(tscadc->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
-		err = PTR_ERR(tscadc->regmap);
-		goto ret;
+		return PTR_ERR(tscadc->regmap);
 	}
 
 	spin_lock_init(&tscadc->reg_lock);
@@ -274,7 +273,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 err_disable_clk:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-ret:
+
 	return err;
 }
 
-- 
2.27.0

