Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3843F787F
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbhHYPcn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:32:43 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:55557 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbhHYPcm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:32:42 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 73F43CA51B;
        Wed, 25 Aug 2021 15:26:03 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 53F77C000A;
        Wed, 25 Aug 2021 15:25:39 +0000 (UTC)
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
Subject: [PATCH 09/40] mfd: ti_am335x_tscadc: Fix style
Date:   Wed, 25 Aug 2021 17:24:47 +0200
Message-Id: <20210825152518.379386-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These are mostly deffects reported by checkpatch.pl.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 45262ca7734a..540c6dcef541 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -140,15 +140,17 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		adc_channels++;
 		if (val > 7) {
 			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
-					val);
+				val);
 			return -EINVAL;
 		}
 	}
+
 	total_channels = tsc_wires + adc_channels;
 	if (total_channels > 8) {
 		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
 		return -EINVAL;
 	}
+
 	if (total_channels == 0) {
 		dev_err(&pdev->dev, "Need atleast one channel.\n");
 		return -EINVAL;
@@ -170,8 +172,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "no irq ID is specified.\n");
 		goto ret;
-	} else
+	} else {
 		tscadc->irq = err;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tscadc->tscadc_base = devm_ioremap_resource(&pdev->dev, res);
@@ -180,7 +183,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
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

