Return-Path: <linux-iio+bounces-244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E887D7F3866
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 22:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA962818C9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25568584EF;
	Tue, 21 Nov 2023 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00EDF4;
	Tue, 21 Nov 2023 13:35:51 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALIokBc013729;
	Tue, 21 Nov 2023 16:35:38 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uh26h0hvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 16:35:38 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ALLZbY2057043
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Nov 2023 16:35:37 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Nov 2023 16:35:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Nov 2023 16:35:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Nov 2023 16:35:36 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ALLZOBS019992;
	Tue, 21 Nov 2023 16:35:27 -0500
From: <marcelo.schmitt@analog.com>
To: <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: Marcelo Schmitt <marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] iio: adc: ad7091r: Move defines to header file
Date: Tue, 21 Nov 2023 18:35:24 -0300
Message-ID: <8aa859817e86408733a81cf31b932f0efa273c71.1700595310.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
References: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: t_u_dO_EdpMSSk5hFVbD_gKFHzO5nlGF
X-Proofpoint-GUID: t_u_dO_EdpMSSk5hFVbD_gKFHzO5nlGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210169

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Move AD7091R register, channel and event definitions to the header file
so other AD7091R device drivers may use those declaration in follow up
patches.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 14 +++--------
 drivers/iio/adc/ad7091r-base.h | 45 ++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r5.c     | 39 +++--------------------------
 3 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 3ecac3164446..ebf1c8cca25c 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -15,14 +15,6 @@
 
 #include "ad7091r-base.h"
 
-#define AD7091R_REG_RESULT  0
-#define AD7091R_REG_CHANNEL 1
-#define AD7091R_REG_CONF    2
-#define AD7091R_REG_ALERT   3
-#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
-#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
-#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
-
 /* AD7091R_REG_RESULT */
 #define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
@@ -270,7 +262,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
-static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
+bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -280,8 +272,9 @@ static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, IIO_AD7091R);
 
-static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
+bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -291,6 +284,7 @@ static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, IIO_AD7091R);
 
 const struct regmap_config ad7091r_regmap_config = {
 	.reg_bits = 8,
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 509748aef9b1..2efed8ddc59a 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,6 +8,27 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+#define AD7091R_REG_RESULT  0
+#define AD7091R_REG_CHANNEL 1
+#define AD7091R_REG_CONF    2
+#define AD7091R_REG_ALERT   3
+
+#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
+#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
+#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
+
+#define AD7091R_CHANNEL(idx, bits, ev, num_ev) {			\
+	.type = IIO_VOLTAGE,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.indexed = 1,							\
+	.channel = idx,							\
+	.event_spec = ev,						\
+	.num_event_specs = num_ev,					\
+	.scan_type.storagebits = 16,					\
+	.scan_type.realbits = bits,					\
+}
+
 struct device;
 struct ad7091r_state;
 
@@ -17,10 +38,34 @@ struct ad7091r_chip_info {
 	unsigned int vref_mV;
 };
 
+static const struct iio_event_spec ad7091r_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
 extern const struct regmap_config ad7091r_regmap_config;
 
 int ad7091r_probe(struct device *dev, const char *name,
 		const struct ad7091r_chip_info *chip_info,
 		struct regmap *map, int irq);
 
+bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
+
+bool ad7091r_writeable_reg(struct device *dev, unsigned int reg);
+
 #endif /* __DRIVERS_IIO_ADC_AD7091R_BASE_H__ */
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 2f048527b7b7..9d3ccfca94ec 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -12,42 +12,11 @@
 
 #include "ad7091r-base.h"
 
-static const struct iio_event_spec ad7091r5_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
-	},
-};
-
-#define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
-	.type = IIO_VOLTAGE, \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-	.indexed = 1, \
-	.channel = idx, \
-	.event_spec = ev, \
-	.num_event_specs = num_ev, \
-	.scan_type.storagebits = 16, \
-	.scan_type.realbits = bits, \
-}
 static const struct iio_chan_spec ad7091r5_channels_irq[] = {
-	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
 };
 
 static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
-- 
2.42.0


