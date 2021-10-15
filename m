Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D381942EB62
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhJOIRl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:17:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58511 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbhJOIR3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:29 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A10D820008;
        Fri, 15 Oct 2021 08:15:21 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 10/48] mfd: ti_am335x_tscadc: Fix style
Date:   Fri, 15 Oct 2021 10:14:28 +0200
Message-Id: <20211015081506.933180-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These are mostly deffects reported by checkpatch.pl.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index bf14fd3677fe..274f2d805442 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -141,7 +141,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		adc_channels++;
 		if (val > 7) {
 			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
-					val);
+				val);
 			of_node_put(node);
 			return -EINVAL;
 		}
@@ -154,6 +154,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
 		return -EINVAL;
 	}
+
 	if (total_channels == 0) {
 		dev_err(&pdev->dev, "Need at least one channel.\n");
 		return -EINVAL;
@@ -184,7 +185,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	tscadc->tscadc_phys_base = res->start;
 	tscadc->regmap = devm_regmap_init_mmio(&pdev->dev,
-			tscadc->tscadc_base, &tscadc_regmap_config);
+					       tscadc->tscadc_base,
+					       &tscadc_regmap_config);
 	if (IS_ERR(tscadc->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		err = PTR_ERR(tscadc->regmap);
-- 
2.27.0

