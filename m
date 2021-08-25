Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C585F3F7885
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbhHYPdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:33:03 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:38145 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbhHYPdC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:33:02 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 6FFF5C88D6;
        Wed, 25 Aug 2021 15:26:07 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4DB48C0013;
        Wed, 25 Aug 2021 15:25:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 10/40] mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack variables
Date:   Wed, 25 Aug 2021 17:24:48 +0200
Message-Id: <20210825152518.379386-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
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
 drivers/mfd/ti_am335x_tscadc.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 540c6dcef541..f0824732badf 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -113,18 +113,16 @@ static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
 
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
+	struct device_node *node;
+	struct property *prop;
+	struct mfd_cell *cell;
+	struct resource *res;
+	const __be32 *cur;
+	struct clk *clk;
+	u32 val;
+	int tsc_wires = 0, adc_channels = 0, readouts = 0;
+	int total_channels, clock_rate, ctrl, err;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -278,7 +276,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 static int ti_tscadc_remove(struct platform_device *pdev)
 {
-	struct ti_tscadc_dev	*tscadc = platform_get_drvdata(pdev);
+	struct ti_tscadc_dev *tscadc = platform_get_drvdata(pdev);
 
 	regmap_write(tscadc->regmap, REG_SE, 0x00);
 
@@ -297,7 +295,7 @@ static int __maybe_unused ti_tscadc_can_wakeup(struct device *dev, void *data)
 
 static int __maybe_unused tscadc_suspend(struct device *dev)
 {
-	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
+	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 
 	regmap_write(tscadc->regmap, REG_SE, 0x00);
 	if (device_for_each_child(dev, NULL, ti_tscadc_can_wakeup)) {
@@ -315,7 +313,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 
 static int __maybe_unused tscadc_resume(struct device *dev)
 {
-	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
+	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 	u32 ctrl;
 
 	pm_runtime_get_sync(dev);
-- 
2.27.0

