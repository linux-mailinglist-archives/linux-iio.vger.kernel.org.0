Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01D440C972
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhIOQBb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:01:31 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38409 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbhIOQBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:30 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AB4501BF212;
        Wed, 15 Sep 2021 16:00:08 +0000 (UTC)
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
Subject: [PATCH v3 29/47] mfd: ti_am335x_tscadc: Rename the subsystem enable macro
Date:   Wed, 15 Sep 2021 17:58:50 +0200
Message-Id: <20210915155908.476767-30-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This bit is common to all devices (ADC, Touchscreen, Magnetic reader) so
make it clear that it can be used from any location by operating a
mechanical rename:
s/CNTRLREG_TSCSSENB/CNTRLREG_SSENB/

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c      | 6 +++---
 drivers/mfd/ti_am335x_tscadc.c       | 6 +++---
 include/linux/mfd/ti_am335x_tscadc.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index a241e6fa3564..1cc2efbb2875 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -184,7 +184,7 @@ static irqreturn_t tiadc_irq_h(int irq, void *private)
 	if (status & IRQENB_FIFO1OVRRUN) {
 		/* FIFO Overrun. Clear flag. Disable/Enable ADC to recover */
 		config = tiadc_readl(adc_dev, REG_CTRL);
-		config &= ~(CNTRLREG_TSCSSENB);
+		config &= ~(CNTRLREG_SSENB);
 		tiadc_writel(adc_dev, REG_CTRL, config);
 		tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1OVRRUN
 				| IRQENB_FIFO1UNDRFLW | IRQENB_FIFO1THRES);
@@ -197,7 +197,7 @@ static irqreturn_t tiadc_irq_h(int irq, void *private)
 			adc_fsm = tiadc_readl(adc_dev, REG_ADCFSM);
 		} while (adc_fsm != 0x10 && count++ < 100);
 
-		tiadc_writel(adc_dev, REG_CTRL, (config | CNTRLREG_TSCSSENB));
+		tiadc_writel(adc_dev, REG_CTRL, (config | CNTRLREG_SSENB));
 		return IRQ_HANDLED;
 	} else if (status & IRQENB_FIFO1THRES) {
 		/* Disable irq and wake worker thread */
@@ -671,7 +671,7 @@ static int __maybe_unused tiadc_suspend(struct device *dev)
 	unsigned int idle;
 
 	idle = tiadc_readl(adc_dev, REG_CTRL);
-	idle &= ~(CNTRLREG_TSCSSENB);
+	idle &= ~(CNTRLREG_SSENB);
 	tiadc_writel(adc_dev, REG_CTRL, (idle |
 			CNTRLREG_POWERDOWN));
 
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index f627405d16f0..53a6686a4c5d 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -235,7 +235,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc_idle_config(tscadc);
 
 	/* Enable the TSC module enable bit */
-	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);
+	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
 
 	/* TSC Cell */
 	if (tsc_wires > 0) {
@@ -299,7 +299,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 
 		regmap_read(tscadc->regmap, REG_CTRL, &ctrl);
 		ctrl &= ~(CNTRLREG_POWERDOWN);
-		ctrl |= CNTRLREG_TSCSSENB;
+		ctrl |= CNTRLREG_SSENB;
 		regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 	}
 	pm_runtime_put_sync(dev);
@@ -316,7 +316,7 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 	tscadc_idle_config(tscadc);
-	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);
+	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
 
 	return 0;
 }
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 32b26e56eebb..5546a779e6ad 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -96,7 +96,7 @@
 #define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0x400)
 
 /* Control register */
-#define CNTRLREG_TSCSSENB	BIT(0)
+#define CNTRLREG_SSENB		BIT(0)
 #define CNTRLREG_STEPID		BIT(1)
 #define CNTRLREG_STEPCONFIGWRT	BIT(2)
 #define CNTRLREG_POWERDOWN	BIT(4)
-- 
2.27.0

