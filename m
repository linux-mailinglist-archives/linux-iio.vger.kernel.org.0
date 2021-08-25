Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E13F78CE
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241882AbhHYPfc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:32 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:40165 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhHYPfb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:31 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 77868CDD3D;
        Wed, 25 Aug 2021 15:26:29 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0FB0AC0010;
        Wed, 25 Aug 2021 15:26:05 +0000 (UTC)
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
Subject: [PATCH 22/40] mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
Date:   Wed, 25 Aug 2021 17:25:00 +0200
Message-Id: <20210825152518.379386-23-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While the register list (and names) between ADC0 and ADC1 are pretty
close, the bits inside changed a little bit. To avoid any future
confusion, let's add the TSC prefix when some bits are in a register
that is common to both revisions of the ADC, but are specific to the
am33xx hardware.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c       | 10 +++++-----
 include/linux/mfd/ti_am335x_tscadc.h | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index dd303523f9a3..02477ce827d0 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -215,15 +215,15 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
 	/* Set the control register bits */
-	tscadc->ctrl = CNTRLREG_STEPCONFIGWRT | CNTRLREG_STEPID;
+	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 
 	if (tsc_wires > 0) {
-		tscadc->ctrl |= CNTRLREG_TSCENB;
+		tscadc->ctrl |= CNTRLREG_TSC_ENB;
 		if (tsc_wires == 5)
-			tscadc->ctrl |= CNTRLREG_5WIRE;
+			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
 		else
-			tscadc->ctrl |= CNTRLREG_4WIRE;
+			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
 	}
 
 	tscadc_idle_config(tscadc);
@@ -322,7 +322,7 @@ static const struct ti_tscadc_data tscdata = {
 	.compat_tscmag = "ti,am3359-tsc",
 	.name_adc = "TI-am335x-adc",
 	.compat_adc = "ti,am3359-adc",
-	.target_clk_rate = ADC_CLK,
+	.target_clk_rate = TSC_ADC_CLK,
 };
 
 static const struct of_device_id ti_tscadc_dt_ids[] = {
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index a900fae8354c..d5e2ff8dc84a 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -120,14 +120,14 @@
 /* Control register */
 #define CNTRLREG_SSENB		BIT(0)
 #define CNTRLREG_STEPID		BIT(1)
-#define CNTRLREG_STEPCONFIGWRT	BIT(2)
+#define CNTRLREG_TSC_STEPCONFIGWRT BIT(2)
 #define CNTRLREG_POWERDOWN	BIT(4)
-#define CNTRLREG_AFE_CTRL_MASK	(3 << 5)
-#define CNTRLREG_AFE_CTRL(val)	((val) << 5)
-#define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
-#define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
-#define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
-#define CNTRLREG_TSCENB		BIT(7)
+#define CNTRLREG_TSC_AFE_CTRL_MASK (3 << 5)
+#define CNTRLREG_TSC_AFE_CTRL(val) ((val) << 5)
+#define CNTRLREG_TSC_4WIRE	CNTRLREG_TSC_AFE_CTRL(1)
+#define CNTRLREG_TSC_5WIRE	CNTRLREG_TSC_AFE_CTRL(2)
+#define CNTRLREG_TSC_8WIRE	CNTRLREG_TSC_AFE_CTRL(3)
+#define CNTRLREG_TSC_ENB	BIT(7)
 
 /* FIFO READ Register */
 #define FIFOREAD_DATA_MASK (0xfff << 0)
@@ -141,7 +141,7 @@
 #define SEQ_STATUS BIT(5)
 #define CHARGE_STEP		0x11
 
-#define ADC_CLK			3000000
+#define TSC_ADC_CLK		3000000
 #define TOTAL_STEPS		16
 #define TOTAL_CHANNELS		8
 #define FIFO1_THRESHOLD		19
-- 
2.27.0

