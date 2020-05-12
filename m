Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF71F1CF5C8
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgELN1p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 09:27:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9574 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbgELN1n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 09:27:43 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CDMIfc025657;
        Tue, 12 May 2020 15:27:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=+QVbU7pKjwzPGFYYPGKUWMEDgUaEdm0KEavReVltEBo=;
 b=jE6drnut+pDhoj5a0iOHjZNlYrBKoU2KqGec8sjwv6QP9/V9fI924spx58KBmr+glQ6n
 g/Q5mLrb0U+2idE/ZpEfWe2PzqKSsCIrbr2Rfd79CJ0OC8y0HuJYL8Z/9Ef5Ylpzdkns
 1mWYzn5vyj02ohs8sBIlpTPG4UtfA5nReA2r35eW0LAg9RT/aNiJwhQsl8jcllYsSswK
 w5HPWbDlF3gETOMTpiH/9Mt2ScIcSMn+X939sJaND0HL47V5G+MgMeHcswDu7KDw88sy
 uqlC1gAv+pbSQjUMcy2i4PABy2PfysrUtZhcmsdPOSvQ/4QsLdOQ9b+Lg0Iook36HAbE yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30wj9wgrnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 15:27:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2FDB100038;
        Tue, 12 May 2020 15:27:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A60FB2C38D2;
        Tue, 12 May 2020 15:27:30 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 May 2020 15:27:30
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32-adc: fix a wrong error message when probing interrupts
Date:   Tue, 12 May 2020 15:27:05 +0200
Message-ID: <1589290025-23857-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_03:2020-05-11,2020-05-12 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A wrong error message is printed out currently, like on STM32MP15:
- stm32-adc-core 48003000.adc: IRQ index 2 not found.

This is seen since commit 7723f4c5ecdb ("driver core: platform: Add an
error message to platform_get_irq*()").
The STM32 ADC core driver wrongly requests up to 3 interrupt lines. It
should request only the necessary IRQs, based on the compatible:
- stm32f4/h7 ADCs share a common interrupt
- stm32mp1, has one interrupt line per ADC.
So add the number of required interrupts to the compatible data.

Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index ebe5dbc..3586369 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -65,12 +65,14 @@ struct stm32_adc_priv;
  * @clk_sel:	clock selection routine
  * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
  * @has_syscfg: SYSCFG capability flags
+ * @num_irqs:	number of interrupt lines
  */
 struct stm32_adc_priv_cfg {
 	const struct stm32_adc_common_regs *regs;
 	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
 	u32 max_clk_rate_hz;
 	unsigned int has_syscfg;
+	unsigned int num_irqs;
 };
 
 /**
@@ -375,21 +377,15 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	unsigned int i;
 
-	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
+	/*
+	 * Interrupt(s) must be provided, depending on the compatible:
+	 * - stm32f4/h7 shares a common interrupt line.
+	 * - stm32mp1, has one line per ADC
+	 */
+	for (i = 0; i < priv->cfg->num_irqs; i++) {
 		priv->irq[i] = platform_get_irq(pdev, i);
-		if (priv->irq[i] < 0) {
-			/*
-			 * At least one interrupt must be provided, make others
-			 * optional:
-			 * - stm32f4/h7 shares a common interrupt.
-			 * - stm32mp1, has one line per ADC (either for ADC1,
-			 *   ADC2 or both).
-			 */
-			if (i && priv->irq[i] == -ENXIO)
-				continue;
-
+		if (priv->irq[i] < 0)
 			return priv->irq[i];
-		}
 	}
 
 	priv->domain = irq_domain_add_simple(np, STM32_ADC_MAX_ADCS, 0,
@@ -400,9 +396,7 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
-		if (priv->irq[i] < 0)
-			continue;
+	for (i = 0; i < priv->cfg->num_irqs; i++) {
 		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
 		irq_set_handler_data(priv->irq[i], priv);
 	}
@@ -420,11 +414,8 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
 	irq_domain_remove(priv->domain);
 
-	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
-		if (priv->irq[i] < 0)
-			continue;
+	for (i = 0; i < priv->cfg->num_irqs; i++)
 		irq_set_chained_handler(priv->irq[i], NULL);
-	}
 }
 
 static int stm32_adc_core_switches_supply_en(struct stm32_adc_priv *priv,
@@ -824,6 +815,7 @@ static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.regs = &stm32f4_adc_common_regs,
 	.clk_sel = stm32f4_adc_clk_sel,
 	.max_clk_rate_hz = 36000000,
+	.num_irqs = 1,
 };
 
 static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
@@ -831,6 +823,7 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
 	.clk_sel = stm32h7_adc_clk_sel,
 	.max_clk_rate_hz = 36000000,
 	.has_syscfg = HAS_VBOOSTER,
+	.num_irqs = 1,
 };
 
 static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
@@ -838,6 +831,7 @@ static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
 	.clk_sel = stm32h7_adc_clk_sel,
 	.max_clk_rate_hz = 40000000,
 	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
+	.num_irqs = 2,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
2.7.4

