Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DAE414D2B
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhIVPgt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 11:36:49 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58316 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236478AbhIVPgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 11:36:47 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MEwxVD010644;
        Wed, 22 Sep 2021 17:34:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=eWiZ+qIWck3FZln70Bqn5T8FOCd+msmgnu+lQOU02zE=;
 b=2d1OR9QYGHbO/eRHZJ3Whb+YI9M0YyCplS/VAKilY+yAog2hN8WBiWHHS2zl32gvqI/H
 6doUtMhJ5JvACBx3BcEwkliRWG4QZ3aCAV03kZoaZD+jw+h48uv2JKLiTE18QHV9f5Y/
 TUlI6duZCIK/VxLRU6PLdX0zL7+FwjMcgitRzx9Uu66AcTvh4NvSSm8JemLYyyJ3JJvF
 sUtspvO7JUVgl5I+sNcbIBRwoR+eQ402GX4xBBNZQc4ZyHKBmTEHBG2NIfKQO+vzNsxm
 cf0D2efwyOZzqZI+JtpUbtC9OCrpx/SfJGVwC8w4+VJAh68Ur30nkg1Cj7VoocsSIwK+ IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b825p225u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 17:34:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2FEE100034;
        Wed, 22 Sep 2021 17:34:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA5B924187A;
        Wed, 22 Sep 2021 17:34:58 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep 2021 17:34:58
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
Subject: [PATCH v2 7/7] iio: adc: stm32-adc: use generic binding for sample-time
Date:   Wed, 22 Sep 2021 17:34:18 +0200
Message-ID: <20210922153418.21033-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922153418.21033-1-olivier.moysan@foss.st.com>
References: <20210922153418.21033-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_05,2021-09-22_01,2020-04-07_01
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
 drivers/iio/adc/stm32-adc.c | 70 +++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c427e439bf4a..cfd11ff0cf36 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1809,6 +1809,11 @@ static void stm32_adc_smpr_init(struct stm32_adc *adc, int channel, u32 smp_ns)
 	u32 period_ns, shift = smpr->shift, mask = smpr->mask;
 	unsigned int smp, r = smpr->reg;
 
+	/*
+	 * For vrefint channel, ensure that the sampling time cannot
+	 * be lower than the one specified in the datasheet
+	 */
+
 	/* Determine sampling time (ADC clock cycles) */
 	period_ns = NSEC_PER_SEC / adc->common->rate;
 	for (smp = 0; smp <= STM32_ADC_MAX_SMP; smp++)
@@ -1885,6 +1890,13 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
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
 
@@ -1900,6 +1912,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 	int scan_index = 0, val, ret, i;
 	struct property *prop;
 	const __be32 *cur;
+	u32 smp = 0;
 
 	if (num_diff) {
 		ret = of_property_read_u32_array(node, "st,adc-diff-channels",
@@ -1942,6 +1955,19 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
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
 
@@ -2034,6 +2060,19 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 
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
 
@@ -2052,7 +2091,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct iio_chan_spec *channels;
 	int scan_index = 0, num_channels = 0, ret, i;
-	u32 smp = 0;
 	bool legacy = false;
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
@@ -2080,13 +2118,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
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
 
@@ -2103,29 +2134,6 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
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
-		if (channels[i].channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT] &&
-		    smp < adc->cfg->ts_vrefint_ns) {
-			smp = adc->cfg->ts_vrefint_ns;
-		}
-
-		/* Prepare sampling time settings */
-		stm32_adc_smpr_init(adc, channels[i].channel, smp);
-	}
-
 	if (timestamping) {
 		struct iio_chan_spec *timestamp = &channels[scan_index];
 
-- 
2.17.1

