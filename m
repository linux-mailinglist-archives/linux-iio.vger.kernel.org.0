Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE57C42A57D
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhJLNYp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 09:24:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44310 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236738AbhJLNYk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 09:24:40 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CAv4j6013459;
        Tue, 12 Oct 2021 15:22:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=YPYrwvAiX914U8uW0f9AIFwRwTu5lxAhkXAMOfZgYGw=;
 b=0IMapOYCBGmviqV1NJeGHOYWe5mQkYefLtwFoh3kkjx/XriFZzR9aftG8N0IG39r6uHL
 DX5GCcqMIZPiwpcZpbGbstYAt8/NRdhakL66/UXFg0B7qVFnhxWK3W2XohRy+F304lz6
 7hNOuhyTz/PBcu5fgaFprRITs+80kHSa6g/ISKbSndirnpG9zHiXpYzS1b/Zts6Sd8xs
 X3+Y2kzONKnpWQiJB/d9mqW2+0OPouqhqktldiBL6xoRZp7IEOSOqdL32poPb8a+5VdH
 cPIc086sAHkzUKHCSAF+hcAO4Q8gJagwUpQhIHxZ5KfEYM2+N5nJEpuk+LOt64GI6kY0 pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bn7qv9cb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 15:22:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2062110002A;
        Tue, 12 Oct 2021 15:22:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 155D82291AC;
        Tue, 12 Oct 2021 15:22:20 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 12 Oct 2021 15:22:19
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
Subject: [PATCH v4 7/7] iio: adc: stm32-adc: use generic binding for sample-time
Date:   Tue, 12 Oct 2021 15:19:24 +0200
Message-ID: <20211012131924.31952-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012131924.31952-1-olivier.moysan@foss.st.com>
References: <20211012131924.31952-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
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
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 70 ++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5269bb87d094..6245434f8377 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1805,6 +1805,13 @@ static void stm32_adc_smpr_init(struct stm32_adc *adc, int channel, u32 smp_ns)
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
@@ -1881,6 +1888,13 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
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
 
@@ -1896,6 +1910,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 	int scan_index = 0, val, ret, i;
 	struct property *prop;
 	const __be32 *cur;
+	u32 smp = 0;
 
 	if (num_diff) {
 		ret = of_property_read_u32_array(node, "st,adc-diff-channels",
@@ -1938,6 +1953,19 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
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
 
@@ -2030,6 +2058,19 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
 					vin[1], scan_index, differential);
+
+		ret = of_property_read_u32(child, "st,min-sample-time-ns", &val);
+		/* st,min-sample-time-ns is optional */
+		if (!ret) {
+			stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
+			if (differential)
+				stm32_adc_smpr_init(adc, vin[1], val);
+		} else if (ret != -EINVAL) {
+			dev_err(&indio_dev->dev, "Invalid st,min-sample-time-ns property %d\n",
+				ret);
+			goto err;
+		}
+
 		scan_index++;
 	}
 
@@ -2048,7 +2089,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct iio_chan_spec *channels;
 	int scan_index = 0, num_channels = 0, ret, i;
-	u32 smp = 0;
 	bool legacy = false;
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
@@ -2076,13 +2116,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
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
 
@@ -2099,27 +2132,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
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

