Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736D42A50CE
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 21:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgKCUUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 15:20:22 -0500
Received: from aposti.net ([89.234.176.197]:51606 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgKCUUV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Nov 2020 15:20:21 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2020 15:20:21 EST
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     od@zcrc.me, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH] iio/adc: ingenic: Fix AUX/VBAT readings when touchscreen is used
Date:   Tue,  3 Nov 2020 20:12:38 +0000
Message-Id: <20201103201238.161083-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the command feature of the ADC is used, it is possible to program
the ADC, and specify at each step what input should be processed, and in
comparison to what reference.

This broke the AUX and battery readings when the touchscreen was
enabled, most likely because the CMD feature would change the VREF all
the time.

Now, when AUX or battery are read, we temporarily disable the CMD
feature, which means that we won't get touchscreen readings in that time
frame. But it now gives correct values for AUX / battery, and the
touchscreen isn't disabled for long enough to be an actual issue.

Fixes: b96952f498db ("IIO: Ingenic JZ47xx: Add touchscreen mode.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/ingenic-adc.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 92b25083e23f..ecaff6a9b716 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -177,13 +177,12 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
 	mutex_unlock(&adc->lock);
 }
 
-static void ingenic_adc_enable(struct ingenic_adc *adc,
-			       int engine,
-			       bool enabled)
+static void ingenic_adc_enable_unlocked(struct ingenic_adc *adc,
+					int engine,
+					bool enabled)
 {
 	u8 val;
 
-	mutex_lock(&adc->lock);
 	val = readb(adc->base + JZ_ADC_REG_ENABLE);
 
 	if (enabled)
@@ -192,20 +191,42 @@ static void ingenic_adc_enable(struct ingenic_adc *adc,
 		val &= ~BIT(engine);
 
 	writeb(val, adc->base + JZ_ADC_REG_ENABLE);
+}
+
+static void ingenic_adc_enable(struct ingenic_adc *adc,
+			       int engine,
+			       bool enabled)
+{
+	mutex_lock(&adc->lock);
+	ingenic_adc_enable_unlocked(adc, engine, enabled);
 	mutex_unlock(&adc->lock);
 }
 
 static int ingenic_adc_capture(struct ingenic_adc *adc,
 			       int engine)
 {
+	u32 cfg;
 	u8 val;
 	int ret;
 
-	ingenic_adc_enable(adc, engine, true);
+	/*
+	 * Disable CMD_SEL temporarily, because it causes wrong VBAT readings,
+	 * probably due to the switch of VREF. We must keep the lock here to
+	 * avoid races with the buffer enable/disable functions.
+	 */
+	mutex_lock(&adc->lock);
+	cfg = readl(adc->base + JZ_ADC_REG_CFG);
+	writel(cfg & ~JZ_ADC_REG_CFG_CMD_SEL, adc->base + JZ_ADC_REG_CFG);
+
+
+	ingenic_adc_enable_unlocked(adc, engine, true);
 	ret = readb_poll_timeout(adc->base + JZ_ADC_REG_ENABLE, val,
 				 !(val & BIT(engine)), 250, 1000);
 	if (ret)
-		ingenic_adc_enable(adc, engine, false);
+		ingenic_adc_enable_unlocked(adc, engine, false);
+
+	writel(cfg, adc->base + JZ_ADC_REG_CFG);
+	mutex_unlock(&adc->lock);
 
 	return ret;
 }
-- 
2.28.0

