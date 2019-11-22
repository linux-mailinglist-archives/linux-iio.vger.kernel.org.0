Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225C4107492
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 16:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKVPJw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 10:09:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbfKVPJw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 10:09:52 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMF7wYc020482;
        Fri, 22 Nov 2019 16:09:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=MJxLlMpkLwVBG7NqhYGIo7Hw2zbfifhhyH7WA1YqF4g=;
 b=llpDGCROJQ+hykPjdrR5b6ESI5LHfDcB5g288dqaJtCv1Sf2fsO8yenoXkYT3IM8zP4O
 m60PtaRg/m9hw4s6BNYPPIV/tMt2xpCSxo5wsBWlX1ke+xZpSKfFjJxESeqkUF/b6X7S
 DS+G6LxqCre2TcpkrDjBBAr+SJsLO/tGefQXZeIbxLMW/wnOIGtmeD89eeHwY4F7mEGo
 UO0GKwIx4kjwbyXM7XI0o1ZKq50Br/Te5ALWpBcbqcA4KkM+598/O6osj+DBnMuBllOo
 OH4yhGyxPp8EKetK8GOudVHWYWlyn4QxxgXgAK0LorQ5p0fpV50iSXpmGroc1FfZBPZ9 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9uphww3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 16:09:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3387710002A;
        Fri, 22 Nov 2019 16:09:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EDB362C38C5;
        Fri, 22 Nov 2019 16:09:23 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov 2019 16:09:23
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32-adc: Add check on overrun interrupt
Date:   Fri, 22 Nov 2019 16:08:14 +0100
Message-ID: <1574435294-19510-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable overrun interrupt on STM32 ADC. In case data register hasn't been
read (by CPU or DMA), overrun condition is detected when there's new
conversion data available. Stop grabbing data and log an error message.
Use a threaded irq to avoid printing the error message from hard irq
context.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 14 +++++------
 drivers/iio/adc/stm32-adc-core.h |  9 +++++++
 drivers/iio/adc/stm32-adc.c      | 53 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 6537f4f..97655d7 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -280,21 +280,21 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
 	.csr = STM32F4_ADC_CSR,
 	.ccr = STM32F4_ADC_CCR,
-	.eoc1_msk = STM32F4_EOC1,
-	.eoc2_msk = STM32F4_EOC2,
-	.eoc3_msk = STM32F4_EOC3,
+	.eoc1_msk = STM32F4_EOC1 | STM32F4_OVR1,
+	.eoc2_msk = STM32F4_EOC2 | STM32F4_OVR2,
+	.eoc3_msk = STM32F4_EOC3 | STM32F4_OVR3,
 	.ier = STM32F4_ADC_CR1,
-	.eocie_msk = STM32F4_EOCIE,
+	.eocie_msk = STM32F4_EOCIE | STM32F4_OVRIE,
 };
 
 /* STM32H7 common registers definitions */
 static const struct stm32_adc_common_regs stm32h7_adc_common_regs = {
 	.csr = STM32H7_ADC_CSR,
 	.ccr = STM32H7_ADC_CCR,
-	.eoc1_msk = STM32H7_EOC_MST,
-	.eoc2_msk = STM32H7_EOC_SLV,
+	.eoc1_msk = STM32H7_EOC_MST | STM32H7_OVR_MST,
+	.eoc2_msk = STM32H7_EOC_SLV | STM32H7_OVR_SLV,
 	.ier = STM32H7_ADC_IER,
-	.eocie_msk = STM32H7_EOCIE,
+	.eocie_msk = STM32H7_EOCIE | STM32H7_OVRIE,
 };
 
 static const unsigned int stm32_adc_offset[STM32_ADC_MAX_ADCS] = {
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 2579d51..2322809 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -51,10 +51,12 @@
 #define STM32F4_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x04)
 
 /* STM32F4_ADC_SR - bit fields */
+#define STM32F4_OVR			BIT(5)
 #define STM32F4_STRT			BIT(4)
 #define STM32F4_EOC			BIT(1)
 
 /* STM32F4_ADC_CR1 - bit fields */
+#define STM32F4_OVRIE			BIT(26)
 #define STM32F4_RES_SHIFT		24
 #define STM32F4_RES_MASK		GENMASK(25, 24)
 #define STM32F4_SCAN			BIT(8)
@@ -72,8 +74,11 @@
 #define STM32F4_ADON			BIT(0)
 
 /* STM32F4_ADC_CSR - bit fields */
+#define STM32F4_OVR3			BIT(21)
 #define STM32F4_EOC3			BIT(17)
+#define STM32F4_OVR2			BIT(13)
 #define STM32F4_EOC2			BIT(9)
+#define STM32F4_OVR1			BIT(5)
 #define STM32F4_EOC1			BIT(1)
 
 /* STM32F4_ADC_CCR - bit fields */
@@ -103,10 +108,12 @@
 
 /* STM32H7_ADC_ISR - bit fields */
 #define STM32MP1_VREGREADY		BIT(12)
+#define STM32H7_OVR			BIT(4)
 #define STM32H7_EOC			BIT(2)
 #define STM32H7_ADRDY			BIT(0)
 
 /* STM32H7_ADC_IER - bit fields */
+#define STM32H7_OVRIE			STM32H7_OVR
 #define STM32H7_EOCIE			STM32H7_EOC
 
 /* STM32H7_ADC_CR - bit fields */
@@ -155,7 +162,9 @@ enum stm32h7_adc_dmngt {
 #define STM32H7_LINCALFACT_MASK		GENMASK(29, 0)
 
 /* STM32H7_ADC_CSR - bit fields */
+#define STM32H7_OVR_SLV			BIT(20)
 #define STM32H7_EOC_SLV			BIT(18)
+#define STM32H7_OVR_MST			BIT(4)
 #define STM32H7_EOC_MST			BIT(2)
 
 /* STM32H7_ADC_CCR - bit fields */
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 3b291d7..9361f92 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -117,7 +117,9 @@ struct stm32_adc_regs {
  * struct stm32_adc_regspec - stm32 registers definition
  * @dr:			data register offset
  * @ier_eoc:		interrupt enable register & eocie bitfield
+ * @ier_ovr:		interrupt enable register & overrun bitfield
  * @isr_eoc:		interrupt status register & eoc bitfield
+ * @isr_ovr:		interrupt status register & overrun bitfield
  * @sqr:		reference to sequence registers array
  * @exten:		trigger control register & bitfield
  * @extsel:		trigger selection register & bitfield
@@ -128,7 +130,9 @@ struct stm32_adc_regs {
 struct stm32_adc_regspec {
 	const u32 dr;
 	const struct stm32_adc_regs ier_eoc;
+	const struct stm32_adc_regs ier_ovr;
 	const struct stm32_adc_regs isr_eoc;
+	const struct stm32_adc_regs isr_ovr;
 	const struct stm32_adc_regs *sqr;
 	const struct stm32_adc_regs exten;
 	const struct stm32_adc_regs extsel;
@@ -337,7 +341,9 @@ static const unsigned int stm32f4_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
 static const struct stm32_adc_regspec stm32f4_adc_regspec = {
 	.dr = STM32F4_ADC_DR,
 	.ier_eoc = { STM32F4_ADC_CR1, STM32F4_EOCIE },
+	.ier_ovr = { STM32F4_ADC_CR1, STM32F4_OVRIE },
 	.isr_eoc = { STM32F4_ADC_SR, STM32F4_EOC },
+	.isr_ovr = { STM32F4_ADC_SR, STM32F4_OVR },
 	.sqr = stm32f4_sq,
 	.exten = { STM32F4_ADC_CR2, STM32F4_EXTEN_MASK, STM32F4_EXTEN_SHIFT },
 	.extsel = { STM32F4_ADC_CR2, STM32F4_EXTSEL_MASK,
@@ -429,7 +435,9 @@ static const unsigned int stm32h7_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
 static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.dr = STM32H7_ADC_DR,
 	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
+	.ier_ovr = { STM32H7_ADC_IER, STM32H7_OVRIE },
 	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
+	.isr_ovr = { STM32H7_ADC_ISR, STM32H7_OVR },
 	.sqr = stm32h7_sq,
 	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
 	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
@@ -506,6 +514,18 @@ static void stm32_adc_conv_irq_disable(struct stm32_adc *adc)
 			   adc->cfg->regs->ier_eoc.mask);
 }
 
+static void stm32_adc_ovr_irq_enable(struct stm32_adc *adc)
+{
+	stm32_adc_set_bits(adc, adc->cfg->regs->ier_ovr.reg,
+			   adc->cfg->regs->ier_ovr.mask);
+}
+
+static void stm32_adc_ovr_irq_disable(struct stm32_adc *adc)
+{
+	stm32_adc_clr_bits(adc, adc->cfg->regs->ier_ovr.reg,
+			   adc->cfg->regs->ier_ovr.mask);
+}
+
 static void stm32_adc_set_res(struct stm32_adc *adc)
 {
 	const struct stm32_adc_regs *res = &adc->cfg->regs->res;
@@ -1205,6 +1225,19 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
+{
+	struct stm32_adc *adc = data;
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	const struct stm32_adc_regspec *regs = adc->cfg->regs;
+	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
+
+	if (status & regs->isr_ovr.mask)
+		dev_err(&indio_dev->dev, "Overrun interrupt, stopping.\n");
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t stm32_adc_isr(int irq, void *data)
 {
 	struct stm32_adc *adc = data;
@@ -1212,6 +1245,17 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
 	const struct stm32_adc_regspec *regs = adc->cfg->regs;
 	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
 
+	if (status & regs->isr_ovr.mask) {
+		/*
+		 * Overrun occurred on regular conversions: data for wrong
+		 * channel may be read. Unconditionally disable interrupts
+		 * to stop processing data and print error message.
+		 */
+		stm32_adc_ovr_irq_disable(adc);
+		stm32_adc_conv_irq_disable(adc);
+		return IRQ_WAKE_THREAD;
+	}
+
 	if (status & regs->isr_eoc.mask) {
 		/* Reading DR also clears EOC status flag */
 		adc->buffer[adc->bufi] = stm32_adc_readw(adc, regs->dr);
@@ -1441,6 +1485,8 @@ static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 	/* Reset adc buffer index */
 	adc->bufi = 0;
 
+	stm32_adc_ovr_irq_enable(adc);
+
 	if (!adc->dma_chan)
 		stm32_adc_conv_irq_enable(adc);
 
@@ -1481,6 +1527,8 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (!adc->dma_chan)
 		stm32_adc_conv_irq_disable(adc);
 
+	stm32_adc_ovr_irq_disable(adc);
+
 	if (adc->dma_chan)
 		dmaengine_terminate_sync(adc->dma_chan);
 
@@ -1818,8 +1866,9 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (adc->irq < 0)
 		return adc->irq;
 
-	ret = devm_request_irq(&pdev->dev, adc->irq, stm32_adc_isr,
-			       0, pdev->name, adc);
+	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
+					stm32_adc_threaded_isr,
+					0, pdev->name, adc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
 		return ret;
-- 
2.7.4

