Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDFB414D29
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhIVPgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 11:36:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60088 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236473AbhIVPgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 11:36:47 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MDUPFo022772;
        Wed, 22 Sep 2021 17:34:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=W8XXkKBm0rhuV3yFT8B+PPX99+Xhb2iTk0d2aJwB2XQ=;
 b=hNHG4zuZPqSMd74fqUgoemy89KEBsU7/SeTtuRIW7w1EndnXasPZK9+rdoq+KFg5t3Ix
 a2Pls1dKAOIPCeufobBChAhCg4VBCGRooDaLTuUFqPHcArPKwMEegc9t/GdWZM50Nxad
 98s69CjC2L3xtFbeZB8pg2rSlQ+mAkzOjYzRfixlVN+aMv6tIwcts7ZWjjqP7WstkFNr
 JEkS644uRcKQAQ4b50hNCUPCcMYIFKqoUfbxobqUju506HCHppd8bTTs60p/CBsK9JOp
 1w6J08GqUGb8S+IOocTkghWAC14n22ZKxolVqhVY6A6J2z7+9tl/zkInL+AOXzD0g7p9 +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b81h0akve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 17:34:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E039E10002A;
        Wed, 22 Sep 2021 17:34:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6B2D24187A;
        Wed, 22 Sep 2021 17:34:57 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep 2021 17:34:57
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 6/7] iio: adc: stm32-adc: add vrefint calibration support
Date:   Wed, 22 Sep 2021 17:34:17 +0200
Message-ID: <20210922153418.21033-7-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922153418.21033-1-olivier.moysan@foss.st.com>
References: <20210922153418.21033-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_05,2021-09-22_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support of vrefint calibration.
If a channel is labeled as vrefint, get vrefint calibration
from non volatile memory for this channel.
vrefint channel is exposed as a processed channel returning
the actual value of vrefp:
vrefp = 3.3 x vrefint_cal / vrefint_data

A conversion on vrefint channel allows to update scale
factor according to vrefint deviation, compared to vrefint
calibration value.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 76 ++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5a7ac45a0725..c427e439bf4a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
@@ -41,6 +42,7 @@
 #define STM32_ADC_TIMEOUT_US		100000
 #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
 #define STM32_ADC_HW_STOP_DELAY_MS	100
+#define STM32_ADC_VREFINT_VOLTAGE	3300
 
 #define STM32_DMA_BUFFER_SIZE		PAGE_SIZE
 
@@ -137,6 +139,16 @@ struct stm32_adc_regs {
 	int shift;
 };
 
+/**
+ * struct stm32_adc_vrefint - stm32 ADC internal reference voltage data
+ * @vrefint_cal:	vrefint calibration value from nvmem
+ * @vrefint_data:	vrefint actual value
+ */
+struct stm32_adc_vrefint {
+	u32 vrefint_cal;
+	u32 vrefint_data;
+};
+
 /**
  * struct stm32_adc_regspec - stm32 registers definition
  * @dr:			data register offset
@@ -186,6 +198,7 @@ struct stm32_adc;
  * @unprepare:		optional unprepare routine (disable, power-down)
  * @irq_clear:		routine to clear irqs
  * @smp_cycles:		programmable sampling time (ADC clock cycles)
+ * @ts_vrefint_ns:	vrefint minimum sampling time in ns
  */
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
@@ -199,6 +212,7 @@ struct stm32_adc_cfg {
 	void (*unprepare)(struct iio_dev *);
 	void (*irq_clear)(struct iio_dev *indio_dev, u32 msk);
 	const unsigned int *smp_cycles;
+	const unsigned int ts_vrefint_ns;
 };
 
 /**
@@ -223,6 +237,7 @@ struct stm32_adc_cfg {
  * @pcsel:		bitmask to preselect channels on some devices
  * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
  * @cal:		optional calibration data on some devices
+ * @vrefint:		internal reference voltage data
  * @chan_name:		channel name array
  * @num_diff:		number of differential channels
  * @int_ch:		internal channel indexes array
@@ -248,6 +263,7 @@ struct stm32_adc {
 	u32			pcsel;
 	u32			smpr_val[2];
 	struct stm32_adc_calib	cal;
+	struct stm32_adc_vrefint vrefint;
 	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
 	u32			num_diff;
 	int			int_ch[STM32_ADC_INT_CH_NB];
@@ -1343,6 +1359,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
@@ -1350,6 +1367,10 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			ret = stm32_adc_single_conv(indio_dev, chan, val);
 		else
 			ret = -EINVAL;
+
+		if (mask == IIO_CHAN_INFO_PROCESSED && adc->vrefint.vrefint_cal)
+			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 
@@ -1819,7 +1840,10 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	chan->datasheet_name = name;
 	chan->scan_index = scan_index;
 	chan->indexed = 1;
-	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	if (chan->channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT])
+		chan->info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED);
+	else
+		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
 					 BIT(IIO_CHAN_INFO_OFFSET);
 	chan->scan_type.sign = 'u';
@@ -1921,6 +1945,36 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 	return scan_index;
 }
 
+static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_name,
+				     int chan)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u16 vrefint;
+	int i, ret;
+
+	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
+		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
+			adc->int_ch[i] = chan;
+
+			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT)
+				continue;
+
+			/* Get calibration data for vrefint channel */
+			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
+			if (ret && ret != -ENOENT && ret != -EOPNOTSUPP) {
+				dev_err(&indio_dev->dev, "nvmem access error %d\n", ret);
+				return ret;
+			}
+			if (ret == -ENOENT)
+				dev_dbg(&indio_dev->dev, "vrefint calibration not found\n");
+			else
+				adc->vrefint.vrefint_cal = vrefint;
+		}
+	}
+
+	return 0;
+}
+
 static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				       struct stm32_adc *adc,
 				       struct iio_chan_spec *channels)
@@ -1929,7 +1983,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct device_node *child;
 	const char *name;
-	int val, scan_index = 0, ret, i;
+	int val, scan_index = 0, ret;
 	bool differential;
 	u32 vin[2];
 
@@ -1949,10 +2003,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				return -EINVAL;
 			}
 			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
-			for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
-				if (!strncmp(stm32_adc_ic[i].name, name, STM32_ADC_CH_SZ))
-					adc->int_ch[i] = val;
-			}
+			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
+			if (ret)
+				goto err;
 		} else if (ret != -EINVAL) {
 			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
 			goto err;
@@ -2059,6 +2112,16 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 		 */
 		of_property_read_u32_index(node, "st,min-sample-time-nsecs",
 					   i, &smp);
+
+		/*
+		 * For vrefint channel, ensure that the sampling time cannot
+		 * be lower than the one specified in the datasheet
+		 */
+		if (channels[i].channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT] &&
+		    smp < adc->cfg->ts_vrefint_ns) {
+			smp = adc->cfg->ts_vrefint_ns;
+		}
+
 		/* Prepare sampling time settings */
 		stm32_adc_smpr_init(adc, channels[i].channel, smp);
 	}
@@ -2365,6 +2428,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.unprepare = stm32h7_adc_unprepare,
 	.smp_cycles = stm32h7_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
+	.ts_vrefint_ns = 4300,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
2.17.1

