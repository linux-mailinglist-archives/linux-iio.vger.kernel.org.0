Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4320442A578
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhJLNYi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 09:24:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44288 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236696AbhJLNYi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 09:24:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CAv40s013415;
        Tue, 12 Oct 2021 15:22:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=9hocvB1muvDE3PylS5Zr2JEMzczhWRz/fOa3ks/+RL4=;
 b=b9U9lD6Q2vTBjBUsZyfePh08DBW9SOTwAVaL78XOUaBZrDvbssZJ3Z6PMeqScU/MODzQ
 EpKMg8irX7MiTRQMIL1XG+FMfqQ5p0Vt3Lf+yXJ3GnZgaiNUwIS8WHW0BkxiELDCia6T
 LVcC4wjDuVXuya8f/h4hj9cwAZ0F4ExrPLJeEv7uX+TB/H+2bdpYt1ehxuK8HtKTLoLh
 ytytLWUw32mZA4n+OROa2MvaBsGSO2zuVWdunMIm9eehF0YpQVWG/buQsjzoxAroetak
 zkSTDQL+ZONQfKE3zdnVMrswjvG/NPXj5vnu3a6Eowk025aUY0Nw3g8qG7CAzZ3H6Wq/ sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bn7qv9caq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 15:22:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5574810002A;
        Tue, 12 Oct 2021 15:22:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4B64C2291AC;
        Tue, 12 Oct 2021 15:22:17 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 12 Oct 2021 15:22:16
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v4 5/7] iio: adc: stm32-adc: add support of internal channels
Date:   Tue, 12 Oct 2021 15:19:22 +0200
Message-ID: <20211012131924.31952-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012131924.31952-1-olivier.moysan@foss.st.com>
References: <20211012131924.31952-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support of ADC2 internal channels VDDCORE, VREFINT and VBAT.
The reserved label name "vddcore", "vrefint" and "vbat" must
be used in Device Tree channel node, to enable the corresponding
internal channel.

Note: This patch does not provide support of internal channels
for F4 and H7.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c |   1 +
 drivers/iio/adc/stm32-adc-core.h |  10 +++
 drivers/iio/adc/stm32-adc.c      | 138 ++++++++++++++++++++++++++++++-
 3 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index c088cb990193..b6e18eb101f7 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -659,6 +659,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	priv->cfg = (const struct stm32_adc_priv_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
+	spin_lock_init(&priv->common.lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->common.base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 2322809bfd2f..faedf7a49555 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -102,6 +102,9 @@
 #define STM32H7_ADC_CALFACT		0xC4
 #define STM32H7_ADC_CALFACT2		0xC8
 
+/* STM32MP1 - ADC2 instance option register */
+#define STM32MP1_ADC2_OR		0xD0
+
 /* STM32H7 - common registers for all ADC instances */
 #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
 #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
@@ -168,23 +171,30 @@ enum stm32h7_adc_dmngt {
 #define STM32H7_EOC_MST			BIT(2)
 
 /* STM32H7_ADC_CCR - bit fields */
+#define STM32H7_VBATEN			BIT(24)
+#define STM32H7_VREFEN			BIT(22)
 #define STM32H7_PRESC_SHIFT		18
 #define STM32H7_PRESC_MASK		GENMASK(21, 18)
 #define STM32H7_CKMODE_SHIFT		16
 #define STM32H7_CKMODE_MASK		GENMASK(17, 16)
 
+/* STM32MP1_ADC2_OR - bit fields */
+#define STM32MP1_VDDCOREEN		BIT(0)
+
 /**
  * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
  * @base:		control registers base cpu addr
  * @phys_base:		control registers base physical addr
  * @rate:		clock rate used for analog circuitry
  * @vref_mv:		vref voltage (mv)
+ * @lock:		spinlock
  */
 struct stm32_adc_common {
 	void __iomem			*base;
 	phys_addr_t			phys_base;
 	unsigned long			rate;
 	int				vref_mv;
+	spinlock_t			lock;		/* lock for common register */
 };
 
 #endif
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 85d09cbd41ae..943ca03f4d31 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -77,6 +77,30 @@ enum stm32_adc_extsel {
 	STM32_EXT20,
 };
 
+enum stm32_adc_int_ch {
+	STM32_ADC_INT_CH_NONE = -1,
+	STM32_ADC_INT_CH_VDDCORE,
+	STM32_ADC_INT_CH_VREFINT,
+	STM32_ADC_INT_CH_VBAT,
+	STM32_ADC_INT_CH_NB,
+};
+
+/**
+ * struct stm32_adc_ic - ADC internal channels
+ * @name:	name of the internal channel
+ * @idx:	internal channel enum index
+ */
+struct stm32_adc_ic {
+	const char *name;
+	u32 idx;
+};
+
+static const struct stm32_adc_ic stm32_adc_ic[STM32_ADC_INT_CH_NB] = {
+	{ "vddcore", STM32_ADC_INT_CH_VDDCORE },
+	{ "vrefint", STM32_ADC_INT_CH_VREFINT },
+	{ "vbat", STM32_ADC_INT_CH_VBAT },
+};
+
 /**
  * struct stm32_adc_trig_info - ADC trigger info
  * @name:		name of the trigger, corresponding to its source
@@ -126,6 +150,9 @@ struct stm32_adc_regs {
  * @res:		resolution selection register & bitfield
  * @smpr:		smpr1 & smpr2 registers offset array
  * @smp_bits:		smpr1 & smpr2 index and bitfields
+ * @or_vdd:		option register & vddcore bitfield
+ * @ccr_vbat:		common register & vbat bitfield
+ * @ccr_vref:		common register & vrefint bitfield
  */
 struct stm32_adc_regspec {
 	const u32 dr;
@@ -139,6 +166,9 @@ struct stm32_adc_regspec {
 	const struct stm32_adc_regs res;
 	const u32 smpr[2];
 	const struct stm32_adc_regs *smp_bits;
+	const struct stm32_adc_regs or_vdd;
+	const struct stm32_adc_regs ccr_vbat;
+	const struct stm32_adc_regs ccr_vref;
 };
 
 struct stm32_adc;
@@ -195,6 +225,7 @@ struct stm32_adc_cfg {
  * @cal:		optional calibration data on some devices
  * @chan_name:		channel name array
  * @num_diff:		number of differential channels
+ * @int_ch:		internal channel indexes array
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -219,6 +250,7 @@ struct stm32_adc {
 	struct stm32_adc_calib	cal;
 	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
 	u32			num_diff;
+	int			int_ch[STM32_ADC_INT_CH_NB];
 };
 
 struct stm32_adc_diff_channel {
@@ -451,6 +483,24 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 };
 
+static const struct stm32_adc_regspec stm32mp1_adc_regspec = {
+	.dr = STM32H7_ADC_DR,
+	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
+	.ier_ovr = { STM32H7_ADC_IER, STM32H7_OVRIE },
+	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
+	.isr_ovr = { STM32H7_ADC_ISR, STM32H7_OVR },
+	.sqr = stm32h7_sq,
+	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
+	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
+		    STM32H7_EXTSEL_SHIFT },
+	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
+	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
+	.smp_bits = stm32h7_smp_bits,
+	.or_vdd = { STM32MP1_ADC2_OR, STM32MP1_VDDCOREEN },
+	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
+	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
+};
+
 /*
  * STM32 ADC registers access routines
  * @adc: stm32 adc instance
@@ -489,6 +539,14 @@ static void stm32_adc_set_bits(struct stm32_adc *adc, u32 reg, u32 bits)
 	spin_unlock_irqrestore(&adc->lock, flags);
 }
 
+static void stm32_adc_set_bits_common(struct stm32_adc *adc, u32 reg, u32 bits)
+{
+	spin_lock(&adc->common->lock);
+	writel_relaxed(readl_relaxed(adc->common->base + reg) | bits,
+		       adc->common->base + reg);
+	spin_unlock(&adc->common->lock);
+}
+
 static void stm32_adc_clr_bits(struct stm32_adc *adc, u32 reg, u32 bits)
 {
 	unsigned long flags;
@@ -498,6 +556,14 @@ static void stm32_adc_clr_bits(struct stm32_adc *adc, u32 reg, u32 bits)
 	spin_unlock_irqrestore(&adc->lock, flags);
 }
 
+static void stm32_adc_clr_bits_common(struct stm32_adc *adc, u32 reg, u32 bits)
+{
+	spin_lock(&adc->common->lock);
+	writel_relaxed(readl_relaxed(adc->common->base + reg) & ~bits,
+		       adc->common->base + reg);
+	spin_unlock(&adc->common->lock);
+}
+
 /**
  * stm32_adc_conv_irq_enable() - Enable end of conversion interrupt
  * @adc: stm32 adc instance
@@ -579,6 +645,60 @@ static int stm32_adc_hw_start(struct device *dev)
 	return ret;
 }
 
+static void stm32_adc_int_ch_enable(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 i;
+
+	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
+		if (adc->int_ch[i] == STM32_ADC_INT_CH_NONE)
+			continue;
+
+		switch (i) {
+		case STM32_ADC_INT_CH_VDDCORE:
+			dev_dbg(&indio_dev->dev, "Enable VDDCore\n");
+			stm32_adc_set_bits(adc, adc->cfg->regs->or_vdd.reg,
+					   adc->cfg->regs->or_vdd.mask);
+			break;
+		case STM32_ADC_INT_CH_VREFINT:
+			dev_dbg(&indio_dev->dev, "Enable VREFInt\n");
+			stm32_adc_set_bits_common(adc, adc->cfg->regs->ccr_vref.reg,
+						  adc->cfg->regs->ccr_vref.mask);
+			break;
+		case STM32_ADC_INT_CH_VBAT:
+			dev_dbg(&indio_dev->dev, "Enable VBAT\n");
+			stm32_adc_set_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
+						  adc->cfg->regs->ccr_vbat.mask);
+			break;
+		}
+	}
+}
+
+static void stm32_adc_int_ch_disable(struct stm32_adc *adc)
+{
+	u32 i;
+
+	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
+		if (adc->int_ch[i] == STM32_ADC_INT_CH_NONE)
+			continue;
+
+		switch (i) {
+		case STM32_ADC_INT_CH_VDDCORE:
+			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vdd.reg,
+					   adc->cfg->regs->or_vdd.mask);
+			break;
+		case STM32_ADC_INT_CH_VREFINT:
+			stm32_adc_clr_bits_common(adc, adc->cfg->regs->ccr_vref.reg,
+						  adc->cfg->regs->ccr_vref.mask);
+			break;
+		case STM32_ADC_INT_CH_VBAT:
+			stm32_adc_clr_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
+						  adc->cfg->regs->ccr_vbat.mask);
+			break;
+		}
+	}
+}
+
 /**
  * stm32f4_adc_start_conv() - Start conversions for regular channels.
  * @indio_dev: IIO device instance
@@ -947,11 +1067,13 @@ static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
 		goto pwr_dwn;
 	calib = ret;
 
+	stm32_adc_int_ch_enable(indio_dev);
+
 	stm32_adc_writel(adc, STM32H7_ADC_DIFSEL, adc->difsel);
 
 	ret = stm32h7_adc_enable(indio_dev);
 	if (ret)
-		goto pwr_dwn;
+		goto ch_disable;
 
 	/* Either restore or read calibration result for future reference */
 	if (calib)
@@ -967,6 +1089,8 @@ static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
 
 disable:
 	stm32h7_adc_disable(indio_dev);
+ch_disable:
+	stm32_adc_int_ch_disable(adc);
 pwr_dwn:
 	stm32h7_adc_enter_pwr_down(adc);
 
@@ -978,6 +1102,7 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
 	struct stm32_adc *adc = iio_priv(indio_dev);
 
 	stm32h7_adc_disable(indio_dev);
+	stm32_adc_int_ch_disable(adc);
 	stm32h7_adc_enter_pwr_down(adc);
 }
 
@@ -1800,7 +1925,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct device_node *child;
 	const char *name;
-	int val, scan_index = 0, ret;
+	int val, scan_index = 0, ret, i;
 	bool differential;
 	u32 vin[2];
 
@@ -1820,6 +1945,10 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				return -EINVAL;
 			}
 			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
+			for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
+				if (!strncmp(stm32_adc_ic[i].name, name, STM32_ADC_CH_SZ))
+					adc->int_ch[i] = val;
+			}
 		} else if (ret != -EINVAL) {
 			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
 			goto err;
@@ -1869,6 +1998,9 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 	u32 smp = 0;
 	bool legacy = false;
 
+	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
+		adc->int_ch[i] = STM32_ADC_INT_CH_NONE;
+
 	num_channels = of_get_available_child_count(node);
 	/* If no channels have been found, fallback to channels legacy properties. */
 	if (!num_channels) {
@@ -2219,7 +2351,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 };
 
 static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
-	.regs = &stm32h7_adc_regspec,
+	.regs = &stm32mp1_adc_regspec,
 	.adc_info = &stm32h7_adc_info,
 	.trigs = stm32h7_adc_trigs,
 	.has_vregready = true,
-- 
2.17.1

