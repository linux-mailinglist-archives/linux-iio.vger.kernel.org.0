Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E2C41B04C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbhI1NeG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:34:06 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40171 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241116AbhI1Nd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:33:56 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6D6FA60019;
        Tue, 28 Sep 2021 13:32:14 +0000 (UTC)
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
Subject: [PATCH v4 11/48] mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack variables
Date:   Tue, 28 Sep 2021 15:31:06 +0200
Message-Id: <20210928133143.157329-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Many variables will be updated (renamed, dropped, added) in the upcoming
changes, so let's simplify the style to avoid messing with spaces over
and over again.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 00428d12e6b8..07da4059d7f7 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -113,18 +113,18 @@ static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
 
 static	int ti_tscadc_probe(struct platform_device *pdev)
 {
-	struct ti_tscadc_dev	*tscadc;
-	struct resource		*res;
-	struct clk		*clk;
-	struct device_node	*node;
-	struct mfd_cell		*cell;
-	struct property         *prop;
-	const __be32            *cur;
-	u32			val;
-	int			err, ctrl;
-	int			clock_rate;
-	int			tsc_wires = 0, adc_channels = 0, total_channels;
-	int			readouts = 0;
+	struct ti_tscadc_dev *tscadc;
+	struct resource *res;
+	struct clk *clk;
+	struct device_node *node;
+	struct mfd_cell *cell;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	int err, ctrl;
+	int clock_rate;
+	int tsc_wires = 0, adc_channels = 0, total_channels;
+	int readouts = 0;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -280,7 +280,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 static int ti_tscadc_remove(struct platform_device *pdev)
 {
-	struct ti_tscadc_dev	*tscadc = platform_get_drvdata(pdev);
+	struct ti_tscadc_dev *tscadc = platform_get_drvdata(pdev);
 
 	regmap_write(tscadc->regmap, REG_SE, 0x00);
 
@@ -299,7 +299,7 @@ static int __maybe_unused ti_tscadc_can_wakeup(struct device *dev, void *data)
 
 static int __maybe_unused tscadc_suspend(struct device *dev)
 {
-	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
+	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 
 	regmap_write(tscadc->regmap, REG_SE, 0x00);
 	if (device_for_each_child(dev, NULL, ti_tscadc_can_wakeup)) {
@@ -317,7 +317,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 
 static int __maybe_unused tscadc_resume(struct device *dev)
 {
-	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
+	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 	u32 ctrl;
 
 	pm_runtime_get_sync(dev);
-- 
2.27.0

