Return-Path: <linux-iio+bounces-983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C58815ADB
	for <lists+linux-iio@lfdr.de>; Sat, 16 Dec 2023 18:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37451F210B7
	for <lists+linux-iio@lfdr.de>; Sat, 16 Dec 2023 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94231A89;
	Sat, 16 Dec 2023 17:50:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC431A6B;
	Sat, 16 Dec 2023 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGFjvmh010372;
	Sat, 16 Dec 2023 12:49:49 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v1etvg8ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 12:49:49 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BGHnm1i029598
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 16 Dec 2023 12:49:48 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 16 Dec 2023 12:49:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 16 Dec 2023 12:49:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 16 Dec 2023 12:49:47 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BGHnULJ015851;
	Sat, 16 Dec 2023 12:49:33 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 10/15] iio: adc: ad7091r: Add chip_info callback to get conversion result channel
Date: Sat, 16 Dec 2023 14:49:27 -0300
Message-ID: <9a5784d528278a07a52a834409862033354fa64b.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iogOKTA2AVBoGYDb6OgaVpzPWugU1B9I
X-Proofpoint-ORIG-GUID: iogOKTA2AVBoGYDb6OgaVpzPWugU1B9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160137

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
index 9d0b489966f5..a30dc587ce45 100644
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
+	if (st->chip_info->reg_result_chan_id(val) != channel)
 		return -EIO;
 
 	*read_val = AD7091R_REG_RESULT_CONV_RESULT(val);
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 9cfb362a00a4..2b4e25e766c8 100644
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
@@ -62,6 +67,7 @@ struct ad7091r_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
+	unsigned int (*reg_result_chan_id)(unsigned int val);
 	int (*set_mode)(struct ad7091r_state *st, enum ad7091r_mode mode);
 };
 
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 08f4b9717329..09d7cd6aeed7 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -54,11 +54,17 @@ static int ad7091r5_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
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
+	.reg_result_chan_id = &ad7091r5_reg_result_chan_id,
 	.set_mode = &ad7091r5_set_mode,
 };
 
@@ -67,6 +73,7 @@ static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
 	.channels = ad7091r5_channels_noirq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
 	.vref_mV = 2500,
+	.reg_result_chan_id = &ad7091r5_reg_result_chan_id,
 	.set_mode = &ad7091r5_set_mode,
 };
 
-- 
2.42.0


