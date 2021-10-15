Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89142EB69
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhJOIRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:17:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45287 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbhJOIRc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:32 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 15C2D20002;
        Fri, 15 Oct 2021 08:15:23 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 12/48] mfd: ti_am335x_tscadc: Get rid of useless gotos
Date:   Fri, 15 Oct 2021 10:14:30 +0200
Message-Id: <20211015081506.933180-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
index 271960e7e9f0..e090fed89c6f 100644
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

