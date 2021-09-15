Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0676840C93F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbhIOQA7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:00:59 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59723 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbhIOQA7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:00:59 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A1ECF1BF20F;
        Wed, 15 Sep 2021 15:59:37 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 14/47] mfd: ti_am335x_tscadc: Don't search the tree for our clock
Date:   Wed, 15 Sep 2021 17:58:35 +0200
Message-Id: <20210915155908.476767-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is a single clock available in our node, which is named
"fck". The clock handler then points to adc_tsc_fck but no need to point
directly to it and do a full tree search.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 7aeabac37990..7f7b8e79a7bf 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -206,7 +206,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	 * This frequency is valid since TSC_ADC_SS controller design
 	 * assumes the OCP clock is at least 6x faster than the ADC clock.
 	 */
-	clk = devm_clk_get(&pdev->dev, "adc_tsc_fck");
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get TSC fck\n");
 		err = PTR_ERR(clk);
-- 
2.27.0

