Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA883FF611
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbhIBVxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:12 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:52569 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbhIBVxJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:53:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6BC8324000E;
        Thu,  2 Sep 2021 21:52:07 +0000 (UTC)
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
Subject: [PATCH v2 10/46] mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack variables
Date:   Thu,  2 Sep 2021 23:51:08 +0200
Message-Id: <20210902215144.507243-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
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
---
 drivers/mfd/ti_am335x_tscadc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 540c6dcef541..858bd22c60f0 100644
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
@@ -278,7 +278,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 static int ti_tscadc_remove(struct platform_device *pdev)
 {
-	struct ti_tscadc_dev	*tscadc = platform_get_drvdata(pdev);
+	struct ti_tscadc_dev *tscadc = platform_get_drvdata(pdev);
 
 	regmap_write(tscadc->regmap, REG_SE, 0x00);
 
@@ -297,7 +297,7 @@ static int __maybe_unused ti_tscadc_can_wakeup(struct device *dev, void *data)
 
 static int __maybe_unused tscadc_suspend(struct device *dev)
 {
-	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
+	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 
 	regmap_write(tscadc->regmap, REG_SE, 0x00);
 	if (device_for_each_child(dev, NULL, ti_tscadc_can_wakeup)) {
@@ -315,7 +315,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 
 static int __maybe_unused tscadc_resume(struct device *dev)
 {
-	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
+	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 	u32 ctrl;
 
 	pm_runtime_get_sync(dev);
-- 
2.27.0

