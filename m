Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A263FF614
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347701AbhIBVxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:14 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38673 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347698AbhIBVxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:53:13 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1C49A240007;
        Thu,  2 Sep 2021 21:52:11 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 12/46] mfd: ti_am335x_tscadc: Get rid of useless gotos
Date:   Thu,  2 Sep 2021 23:51:10 +0200
Message-Id: <20210902215144.507243-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Gotos jumping to a return statement are not really useful, drop them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 763bbc33fc3f..984206521eca 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -175,7 +175,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	err = platform_get_irq(pdev, 0);
 	if (err < 0) {
 		dev_err(&pdev->dev, "no irq ID is specified.\n");
-		goto ret;
+		return err;
 	} else {
 		tscadc->irq = err;
 	}
@@ -191,8 +191,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 					       &tscadc_regmap_config);
 	if (IS_ERR(tscadc->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
-		err = PTR_ERR(tscadc->regmap);
-		goto ret;
+		return PTR_ERR(tscadc->regmap);
 	}
 
 	spin_lock_init(&tscadc->reg_lock);
@@ -276,7 +275,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 err_disable_clk:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-ret:
+
 	return err;
 }
 
-- 
2.27.0

