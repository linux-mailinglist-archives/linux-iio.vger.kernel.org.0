Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31D416E0F
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbhIXIhd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Sep 2021 04:37:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57402 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244832AbhIXIhZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Sep 2021 04:37:25 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O845fv016823;
        Fri, 24 Sep 2021 10:35:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=3fSR3qMOod9QWJZway9dv7IwrtjmBkdyby7QSHnymE4=;
 b=ijitgW1UUSBomy6FmjWeG9DKTPPL9FVBD5VYpMkhshAqV7YjRsMSZzna3aB0Tf9/DBNJ
 AmAooK3q59dqfechqymZTsmXkxdY2cP+Tvdr0hPTy5rQgFXPX5mJDkUM9wlsfuNz6Ppt
 M+P6q/KhG+xBbh8ehC+Cua15A6FUKuDiK3DNxY/wjFN3SM0kVkZ0Nw4K9zmLi5HDnnN8
 Q1JjGJ8MBk9QwdqQcT8sKADmsh+8zjZwa1NIXse+aMOPqnJb+4NzOwZkZlEd6xbIxdJ8
 ka9955OEIlu8eRyKP/FXmaZYmB8wKNm41Avlqdj1VSHiceVOzINvICBkvRS2RB6vbGBk Aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b93dv2dxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 10:35:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E9465100034;
        Fri, 24 Sep 2021 10:35:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0163226FB1;
        Fri, 24 Sep 2021 10:35:35 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 24 Sep 2021 10:35:32
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
Subject: [PATCH v3 7/7] iio: adc: stm32-adc: use generic binding for sample-time
Date:   Fri, 24 Sep 2021 10:34:10 +0200
Message-ID: <20210924083410.12332-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210924083410.12332-1-olivier.moysan@foss.st.com>
References: <20210924083410.12332-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_02,2021-09-23_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add st,min-sample-time-nsecs to channel generic binding.
Sample time can be defined par channel node. If a channel
is configured as differential, the same sample time applies
for both inputs.
Keep support of legacy st,min-sample-time-nsecs property
for backward compatibility.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 70 ++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index d89115809b37..3f1739b0a7b6 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1809,6 +1809,13 @@ static void stm32_adc_smpr_init(struct stm32_adc *adc, int channel, u32 smp_ns)
 	u32 period_ns, shift = smpr->shift, mask = smpr->mask;
 	unsigned int smp, r = smpr->reg;
 
+	/*
+	 * For vrefint channel, ensure that the sampling time cannot
+	 * be lower than the one specified in the datasheet
+	 */
+	if (channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT])
+		smp_ns = max(smp_ns, adc->cfg->ts_vrefint_ns);
+
 	/* Determine sampling time (ADC clock cycles) */
 	period_ns = NSEC_PER_SEC / adc->common->rate;
 	for (smp = 0; smp <= STM32_ADC_MAX_SMP; smp++)
@@ -1885,6 +1892,13 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 		num_channels += ret;
 	}
 
+	/* Optional sample time is provided either for each, or all channels */
+	ret = of_property_count_u32_elems(node, "st,min-sample-time-nsecs");
+	if (ret > 1 && ret != num_channels) {
+		dev_err(&indio_dev->dev, "Invalid st,min-sample-time-nsecs\n");
+		return -EINVAL;
+	}
+
 	return num_channels;
 }
 
@@ -1900,6 +1914,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 	int scan_index = 0, val, ret, i;
 	struct property *prop;
 	const __be32 *cur;
+	u32 smp = 0;
 
 	if (num_diff) {
 		ret = of_property_read_u32_array(node, "st,adc-diff-channels",
@@ -1942,6 +1957,19 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 		scan_index++;
 	}
 
+	for (i = 0; i < scan_index; i++) {
+		/*
+		 * Using of_property_read_u32_index(), smp value will only be
+		 * modified if valid u32 value can be decoded. This allows to
+		 * get either no value, 1 shared value for all indexes, or one
+		 * value per channel.
+		 */
+		of_property_read_u32_index(node, "st,min-sample-time-nsecs", i, &smp);
+
+		/* Prepare sampling time settings */
+		stm32_adc_smpr_init(adc, channels[i].channel, smp);
+	}
+
 	return scan_index;
 }
 
@@ -2034,6 +2062,19 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
 					vin[1], scan_index, differential);
+
+		ret = of_property_read_u32(child, "st,min-sample-time-nsecs", &val);
+		/* st,min-sample-time-nsecs is optional */
+		if (!ret) {
+			stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
+			if (differential)
+				stm32_adc_smpr_init(adc, vin[1], val);
+		} else if (ret != -EINVAL) {
+			dev_err(&indio_dev->dev, "Invalid st,min-sample-time-nsecs property %d\n",
+				ret);
+			goto err;
+		}
+
 		scan_index++;
 	}
 
@@ -2052,7 +2093,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct iio_chan_spec *channels;
 	int scan_index = 0, num_channels = 0, ret, i;
-	u32 smp = 0;
 	bool legacy = false;
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
@@ -2080,13 +2120,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 		return -EINVAL;
 	}
 
-	/* Optional sample time is provided either for each, or all channels */
-	ret = of_property_count_u32_elems(node, "st,min-sample-time-nsecs");
-	if (ret > 1 && ret != num_channels) {
-		dev_err(&indio_dev->dev, "Invalid st,min-sample-time-nsecs\n");
-		return -EINVAL;
-	}
-
 	if (timestamping)
 		num_channels++;
 
@@ -2103,27 +2136,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 		return ret;
 	scan_index = ret;
 
-	for (i = 0; i < scan_index; i++) {
-		/*
-		 * Using of_property_read_u32_index(), smp value will only be
-		 * modified if valid u32 value can be decoded. This allows to
-		 * get either no value, 1 shared value for all indexes, or one
-		 * value per channel.
-		 */
-		of_property_read_u32_index(node, "st,min-sample-time-nsecs",
-					   i, &smp);
-
-		/*
-		 * For vrefint channel, ensure that the sampling time cannot
-		 * be lower than the one specified in the datasheet
-		 */
-		if (channels[i].channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT])
-			smp = max(smp, adc->cfg->ts_vrefint_ns);
-
-		/* Prepare sampling time settings */
-		stm32_adc_smpr_init(adc, channels[i].channel, smp);
-	}
-
 	if (timestamping) {
 		struct iio_chan_spec *timestamp = &channels[scan_index];
 
-- 
2.17.1

