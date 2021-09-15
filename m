Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC440C93D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhIOQA6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:00:58 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36989 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbhIOQA5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:00:57 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AE7A41BF212;
        Wed, 15 Sep 2021 15:59:35 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 13/47] mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
Date:   Wed, 15 Sep 2021 17:58:34 +0200
Message-Id: <20210915155908.476767-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The comment misses the main information which is that we assume that a
sample takes 15 ADC clock cycles to be generated. Let's take the
occasion to rework a little bit this comment.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index a211b35ad106..7aeabac37990 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -199,12 +199,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	/*
-	 * The TSC_ADC_Subsystem has 2 clock domains
-	 * OCP_CLK and ADC_CLK.
-	 * The ADC clock is expected to run at target of 3MHz,
-	 * and expected to capture 12-bit data at a rate of 200 KSPS.
-	 * The TSC_ADC_SS controller design assumes the OCP clock is
-	 * at least 6x faster than the ADC clock.
+	 * The TSC_ADC_Subsystem has 2 clock domains: OCP_CLK and ADC_CLK.
+	 * ADCs produce a 12-bit sample every 15 ADC_CLK cycles.
+	 * am33xx ADCs expect to capture 200ksps.
+	 * We need the ADC clocks to run at 3MHz.
+	 * This frequency is valid since TSC_ADC_SS controller design
+	 * assumes the OCP clock is at least 6x faster than the ADC clock.
 	 */
 	clk = devm_clk_get(&pdev->dev, "adc_tsc_fck");
 	if (IS_ERR(clk)) {
-- 
2.27.0

