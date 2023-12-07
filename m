Return-Path: <linux-iio+bounces-731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C480903C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 19:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B321C2095D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595F4E62D;
	Thu,  7 Dec 2023 18:42:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011F171F;
	Thu,  7 Dec 2023 10:42:27 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7HfS4X032199;
	Thu, 7 Dec 2023 13:42:09 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uujny881w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 13:42:08 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3B7Ig7C2056403
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Dec 2023 13:42:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Dec 2023
 13:42:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:42:06 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IfmLu015389;
	Thu, 7 Dec 2023 13:41:50 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/13] iio: adc: ad7091r: Add chip_info callback to get conversion result channel
Date: Thu, 7 Dec 2023 15:41:47 -0300
Message-ID: <3ebc1e28f806bedc00f603881450af5de411e78b.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: m3IoyOqCUKN1ScmACjvcAkH0ANn2eDtd
X-Proofpoint-ORIG-GUID: m3IoyOqCUKN1ScmACjvcAkH0ANn2eDtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312070156

AD7091R-5 and AD7091R-2/-4/-8 have slightly different register field
layout and due to that require different masks for getting the index of
the channel associated with each read.
Add a callback function so the base driver can get correct channel ID
for each chip variant.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 6 +-----
 drivers/iio/adc/ad7091r-base.h | 6 ++++++
 drivers/iio/adc/ad7091r5.c     | 7 +++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 59a7ec44955d..5a7046f6f0ce 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -15,10 +15,6 @@
 
 #include "ad7091r-base.h"
 
-/* AD7091R_REG_RESULT */
-#define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
-#define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
-
 const struct iio_event_spec ad7091r_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -73,7 +69,7 @@ static int ad7091r_read_one(struct iio_dev *iio_dev,
 	if (ret)
 		return ret;
 
-	if (AD7091R_REG_RESULT_CH_ID(val) != channel)
+	if (st->chip_info->ad7091r_reg_result_chan_id(val) != channel)
 		return -EIO;
 
 	*read_val = AD7091R_REG_RESULT_CONV_RESULT(val);
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index e153c2d7deb5..c554f04e7448 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -19,6 +19,11 @@
 #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
 #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
 
+/* AD7091R_REG_RESULT */
+#define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
+#define AD7091R8_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x7)
+#define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
+
 /* AD7091R_REG_CONF */
 #define AD7091R_REG_CONF_INT_VREF	BIT(0)
 #define AD7091R_REG_CONF_ALERT_EN	BIT(4)
@@ -61,6 +66,7 @@ struct ad7091r_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
+	unsigned int (*ad7091r_reg_result_chan_id)(unsigned int val);
 	int (*ad7091r_set_mode)(struct ad7091r_state *st, enum ad7091r_mode mode);
 };
 
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index ed5e00cc82e2..53a3f74f6452 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -54,11 +54,17 @@ static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
 	return 0;
 }
 
+static unsigned int ad7091r5_reg_result_chan_id(unsigned int val)
+{
+	return AD7091R5_REG_RESULT_CH_ID(val);
+}
+
 static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
 	.name = "ad7091r-5",
 	.channels = ad7091r5_channels_irq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
 	.vref_mV = 2500,
+	.ad7091r_reg_result_chan_id = &ad7091r5_reg_result_chan_id,
 	.ad7091r_set_mode = &ad7091r_set_mode,
 };
 
@@ -67,6 +73,7 @@ static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
 	.channels = ad7091r5_channels_noirq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
 	.vref_mV = 2500,
+	.ad7091r_reg_result_chan_id = &ad7091r5_reg_result_chan_id,
 	.ad7091r_set_mode = &ad7091r_set_mode,
 };
 
-- 
2.42.0


