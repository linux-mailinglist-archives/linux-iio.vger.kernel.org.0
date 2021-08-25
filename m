Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC63F7894
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbhHYPd2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:33:28 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:37153 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbhHYPd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:33:27 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id EF4BFCAD92;
        Wed, 25 Aug 2021 15:26:10 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 758A3C001B;
        Wed, 25 Aug 2021 15:25:47 +0000 (UTC)
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
Subject: [PATCH 13/40] mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
Date:   Wed, 25 Aug 2021 17:24:51 +0200
Message-Id: <20210825152518.379386-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
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
---
 drivers/mfd/ti_am335x_tscadc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 0fef35e1e64b..3afe22680973 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -195,12 +195,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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

