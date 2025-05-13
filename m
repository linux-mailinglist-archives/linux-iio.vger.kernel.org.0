Return-Path: <linux-iio+bounces-19490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA62AB54E8
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FBD1B453C8
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458828DF0E;
	Tue, 13 May 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZZRjlRKf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B328DB63;
	Tue, 13 May 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139744; cv=none; b=tSkVAuLgoWamXrrfIjN9rNnQJ102R1u+mPiDBDUdibCPQwQQtTMwb5zZyINgd/CjVzenFgnGNhlNeyCB/OaccXB9bc45LmBWJkbiQpjGxS750NY3MvTA5ueN0p4m+ucDEerXGgVerDwvpG2p3wCnUZPBGz4qjwnUcC7e8nzTuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139744; c=relaxed/simple;
	bh=8i0mdMGfoV+X/otgRrlZNfCU3lN6XK+bfU0RN4b5sK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4sbUwq5Ucgg/nRmUWw+iLYkKtHS56KK653/6vCvJmW6bGaG1OQTsGw/itVg07qmDakC+L+vLz9BTWBkyYTbguB7Zn+F2B/LCjHX4lowlcEycgd8KLoI2XZuLOwuoMJ36zAVETfujJJf/xWa6sMtnauntkU8a5O3i/RUEc3407w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZZRjlRKf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9mUiX024893;
	Tue, 13 May 2025 08:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=z8poM
	TgfgJpehm0CCKfPj8e7T093AIjwyYHgvo/BO88=; b=ZZRjlRKfOhPUFxOsrHdDx
	fyYWk1TdyKAeQXCyDGAYr3s+sa+VO9wq64WoiE8jwwHKazWCMmmmwVenBMBZD5YQ
	A4hAKNwkkLN21RS2tnFO3rFjRyZUmTt5bIrndvOyei0JQqAEEi7NnOTpZPupAtXK
	/JqfSqO15mGd/7D24YC2tpfMucYdIawUmmssZAiVHGlEsJpZ+E2677aqe5NrAs15
	JQx6dBtFIiYH4BrpMwhdp3qfBA4uoif9lSJ3fQ2MQgU8wVFt99i4HziDIv+bGLRb
	A9tTBaN4SjMP3nu4Bv+zobyJrdv7Fp1Gb2C8yrEiZX9xFlP5YL0RjhEnAPolmKWg
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46m3s98sr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:35:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCZLH7041126
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:35:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:35:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:35:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:35:21 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCZ4sH007517;
	Tue, 13 May 2025 08:35:07 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 05/10] iio: adc: ad4170: Add digital filter and sample frequency config support
Date: Tue, 13 May 2025 09:35:03 -0300
Message-ID: <c61fc067989f7ceda8ab38d38805839b9912c82e.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: sWZ6MJWJqfHI8fPQzF6Q5Dv2TL1kCTBy
X-Authority-Analysis: v=2.4 cv=ZaUdNtVA c=1 sm=1 tr=0 ts=68233c8a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=EmSbnTKpHicewLe-UmcA:9
X-Proofpoint-GUID: sWZ6MJWJqfHI8fPQzF6Q5Dv2TL1kCTBy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExNyBTYWx0ZWRfX+sHzHAvCyTfv
 WccJqfOY2JZ88YittuYCG0qnVSD9LrQz3FsHdH6iAKpMU0XGMJ0AzhYTKSiQPAHEH7eOKDrPQGF
 O/ie0HFBAMEZidmzjfU58Vz/BBNLwaNwGhGVrsjhkiYnDCD2QjVhjAX2j3GzKhY7Jca/Z5r9OfC
 yNJ90YfRycxySnajVwGASC9ycw4JP0qvyH7rd+hl2GXE2bTnMyvRJ+5fBq0EattRXRF8lLtGVKp
 ekVZUZpnYA0ykoXKNjl4qgO1AtFfP0ZOmQFaGVzTSzZvlUQXFHUA0fFF5sY3dr+9iSYi7ojkL+D
 kP/EyeQfwXQnctV45nob70fMpXGa6G8zKzq5O9c+E5dBrCocNR/GulcW+mSNj80k+AO2SmUSw1z
 LHwXokxYLNNmYclL2z8l9i4NyKNMtF1+C0TagnLG/ZkYCwuG9nkamE//gRklIQ7XIxro9uOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130117

Add support for sinc3, sinc5, and averaged sinc5 digital filters along with
sample frequency configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- New patch spun out of the base driver patch.

 drivers/iio/adc/ad4170.c | 273 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 270 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index b02fdd25b4c8..218f768042fe 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -84,6 +85,9 @@
 #define AD4170_AFE_BIPOLAR_MSK				BIT(4)
 #define AD4170_AFE_PGA_GAIN_MSK				GENMASK(3, 0)
 
+/* AD4170_FILTER_REG */
+#define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
+
 /* AD4170 register constants */
 
 /* AD4170_CHAN_MAP_REG constants */
@@ -109,6 +113,11 @@
 #define AD4170_ADC_CTRL_MODE_SINGLE			0x4
 #define AD4170_ADC_CTRL_MODE_IDLE			0x7
 
+/* AD4170_FILTER_REG constants */
+#define AD4170_FILTER_FILTER_TYPE_SINC5_AVG		0x0
+#define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
+#define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
+
 /* Device properties and auxiliary constants */
 
 #define AD4170_NUM_ANALOG_PINS				9
@@ -117,6 +126,7 @@
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
 #define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_DEFAULT_SAMP_RATE			(125 * HZ_PER_KHZ)
 
 #define AD4170_INT_REF_2_5V				2500000
 
@@ -125,6 +135,12 @@
 
 #define AD4170_NUM_PGA_OPTIONS				10
 
+/* Digital filter properties */
+#define AD4170_SINC3_MIN_FS				4
+#define AD4170_SINC3_MAX_FS				65532
+#define AD4170_SINC5_MIN_FS				1
+#define AD4170_SINC5_MAX_FS				256
+
 #define AD4170_GAIN_REG_DEFAULT				0x555555
 
 /* Analog pin functions  */
@@ -181,6 +197,12 @@ enum ad4170_ref_select {
 	AD4170_REF_AVDD
 };
 
+enum ad4170_filter_type {
+	AD4170_SINC5_AVG,
+	AD4170_SINC5,
+	AD4170_SINC3,
+};
+
 enum ad4170_regulator {
 	AD4170_AVDD_SUP,
 	AD4170_AVSS_SUP,
@@ -202,6 +224,18 @@ static const char * const ad4170_int_pin_names[] = {
 	[AD4170_INT_PIN_DIG_AUX1] = "dig_aux1",
 };
 
+static const unsigned int ad4170_sinc3_filt_fs_tbl[] = {
+	4, 8, 12, 16, 20, 40, 48, 80,			/*  0 -  7 */
+	100, 256, 500, 1000, 5000, 8332, 10000, 25000,	/*  8 - 15 */
+	50000, 65532,					/* 16 - 17 */
+};
+
+#define AD4170_MAX_FS_TBL_SIZE		ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl)
+
+static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
+	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256,
+};
+
 struct ad4170_chip_info {
 	const char *name;
 };
@@ -259,6 +293,12 @@ struct ad4170_chan_info {
 	bool enabled;
 };
 
+static const char * const ad4170_filt_names[] = {
+	[AD4170_SINC5_AVG] = "sinc5+avg",
+	[AD4170_SINC5] = "sinc5",
+	[AD4170_SINC3] = "sinc3",
+};
+
 struct ad4170_state {
 	struct mutex lock; /* Protect read-modify-write and multi write sequences */
 	int vrefs_uv[AD4170_MAX_SUP];
@@ -268,6 +308,7 @@ struct ad4170_state {
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
+	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
 	struct completion completion;
@@ -279,6 +320,38 @@ struct ad4170_state {
 	u8 rx_buf[4];
 };
 
+static void ad4170_fill_sps_tbl(struct ad4170_state *st)
+{
+	unsigned int tmp0, tmp1, i;
+
+	/*
+	 * The ODR can be calculated the same way for sinc5+avg, sinc5, and
+	 * sinc3 filter types with the exception that sinc5 filter has a
+	 * narrowed range of allowed FILTER_FS values.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl); i++) {
+		tmp0 = div_u64_rem(st->mclk_hz, 32 * ad4170_sinc3_filt_fs_tbl[i],
+				   &tmp1);
+		tmp1 = mult_frac(tmp1, MICRO, 32 * ad4170_sinc3_filt_fs_tbl[i]);
+		/* Fill sinc5+avg filter SPS table */
+		st->sps_tbl[AD4170_SINC5_AVG][i][0] = tmp0; /* Integer part */
+		st->sps_tbl[AD4170_SINC5_AVG][i][1] = tmp1; /* Fractional part */
+
+		/* Fill sinc3 filter SPS table */
+		st->sps_tbl[AD4170_SINC3][i][0] = tmp0; /* Integer part */
+		st->sps_tbl[AD4170_SINC3][i][1] = tmp1; /* Fractional part */
+	}
+	/* Sinc5 filter ODR doesn't use all FILTER_FS bits */
+	for (i = 0; i < ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl); i++) {
+		tmp0 = div_u64_rem(st->mclk_hz, 32 * ad4170_sinc5_filt_fs_tbl[i],
+				   &tmp1);
+		tmp1 = mult_frac(tmp1, MICRO, 32 * ad4170_sinc5_filt_fs_tbl[i]);
+		/* Fill sinc5 filter SPS table */
+		st->sps_tbl[AD4170_SINC5][i][0] = tmp0; /* Integer part */
+		st->sps_tbl[AD4170_SINC5][i][1] = tmp1; /* Fractional part */
+	}
+}
+
 static int ad4170_debugfs_reg_access(struct iio_dev *indio_dev,
 				     unsigned int reg, unsigned int writeval,
 				     unsigned int *readval)
@@ -636,6 +709,105 @@ static int ad4170_set_channel_enable(struct ad4170_state *st,
 	return 0;
 }
 
+static int __ad4170_get_filter_type(unsigned int filter)
+{
+	u16 f_conf = FIELD_GET(AD4170_FILTER_FILTER_TYPE_MSK, filter);
+
+	switch (f_conf) {
+	case AD4170_FILTER_FILTER_TYPE_SINC5_AVG:
+		return AD4170_SINC5_AVG;
+	case AD4170_FILTER_FILTER_TYPE_SINC5:
+		return AD4170_SINC5;
+	case AD4170_FILTER_FILTER_TYPE_SINC3:
+		return AD4170_SINC3;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4170_set_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  unsigned int val)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	unsigned int old_filter_fs, old_filter, filter_type_conf;
+	int ret;
+
+	switch (val) {
+	case AD4170_SINC5_AVG:
+		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC5_AVG;
+		break;
+	case AD4170_SINC5:
+		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC5;
+		break;
+	case AD4170_SINC3:
+		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+	/*
+	 * The filters provide the same ODR for a given filter_fs value but
+	 * there are different minimum and maximum filter_fs limits for each
+	 * filter. The filter_fs value will be adjusted if the current filter_fs
+	 * is out of the limits of the just requested filter. Since the
+	 * filter_fs value affects the ODR (sampling_frequency), changing the
+	 * filter may lead to a change in the sampling frequency.
+	 */
+	old_filter = setup->filter;
+	old_filter_fs = setup->filter_fs;
+	if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
+		setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
+					 AD4170_SINC3_MAX_FS);
+	else
+		setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
+					 AD4170_SINC5_MAX_FS);
+
+	setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
+	setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,
+				    filter_type_conf);
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret) {
+		setup->filter = old_filter;
+		setup->filter_fs = old_filter_fs;
+	}
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4170_get_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+
+	return __ad4170_get_filter_type(setup->filter);
+}
+
+static const struct iio_enum ad4170_filter_type_enum = {
+	.items = ad4170_filt_names,
+	.num_items = ARRAY_SIZE(ad4170_filt_names),
+	.get = ad4170_get_filter_type,
+	.set = ad4170_set_filter_type,
+};
+
+static const struct iio_chan_spec_ext_info ad4170_filter_type_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4170_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
+			   &ad4170_filter_type_enum),
+	{ }
+};
+
 static const struct iio_chan_spec ad4170_channel_template = {
 	.type = IIO_VOLTAGE,
 	.indexed = 1,
@@ -644,8 +816,11 @@ static const struct iio_chan_spec ad4170_channel_template = {
 			      BIT(IIO_CHAN_INFO_SCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET) |
 			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
-			      BIT(IIO_CHAN_INFO_CALIBSCALE),
-	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.ext_info = ad4170_filter_type_ext_info,
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
@@ -935,7 +1110,8 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
 	struct ad4170_setup *setup = &chan_info->setup;
-	unsigned int pga;
+	enum ad4170_filter_type f_type;
+	unsigned int pga, fs_idx;
 	int ret;
 
 	switch (info) {
@@ -955,6 +1131,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		f_type = __ad4170_get_filter_type(setup->filter);
+		switch (f_type) {
+		case AD4170_SINC5_AVG:
+		case AD4170_SINC3:
+			fs_idx = find_closest(setup->filter_fs,
+					      ad4170_sinc3_filt_fs_tbl,
+					      ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl));
+			*val = st->sps_tbl[f_type][fs_idx][0];
+			*val2 = st->sps_tbl[f_type][fs_idx][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		case AD4170_SINC5:
+			fs_idx = find_closest(setup->filter_fs,
+					      ad4170_sinc5_filt_fs_tbl,
+					      ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl));
+			*val = st->sps_tbl[f_type][fs_idx][0];
+			*val2 = st->sps_tbl[f_type][fs_idx][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_CALIBBIAS:
 		*val = setup->offset;
 		return IIO_VAL_INT;
@@ -1040,6 +1237,7 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
 {
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	enum ad4170_filter_type f_type;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
@@ -1047,6 +1245,21 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
 		*type = IIO_VAL_INT_PLUS_NANO;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		f_type = ad4170_get_filter_type(indio_dev, chan);
+		*vals = (int *)st->sps_tbl[f_type];
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		switch (f_type) {
+		case AD4170_SINC5_AVG:
+		case AD4170_SINC3:
+			*length = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl) * 2;
+			return IIO_AVAIL_LIST;
+		case AD4170_SINC5:
+			*length = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl) * 2;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1087,6 +1300,48 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return 0;
 }
 
+static int ad4170_set_channel_freq(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan, int val,
+				   int val2)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	enum ad4170_filter_type f_type = __ad4170_get_filter_type(setup->filter);
+	unsigned int old_filter_fs, i;
+	int filt_fs_tbl_size, ret;
+
+	switch (f_type) {
+	case AD4170_SINC5_AVG:
+	case AD4170_SINC3:
+		filt_fs_tbl_size = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl);
+		break;
+	case AD4170_SINC5:
+		filt_fs_tbl_size = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl);
+		break;
+	}
+
+	for (i = 0; i < filt_fs_tbl_size; i++) {
+		if (st->sps_tbl[f_type][i][0] == val &&
+		    st->sps_tbl[f_type][i][1] == val2)
+			break;
+	}
+	if (i == filt_fs_tbl_size)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	old_filter_fs = setup->filter_fs;
+	if (f_type == AD4170_SINC5)
+		setup->filter_fs = ad4170_sinc5_filt_fs_tbl[i];
+	else
+		setup->filter_fs = ad4170_sinc3_filt_fs_tbl[i];
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret)
+		setup->filter_fs = old_filter_fs;
+
+	return ret;
+}
+
 static int ad4170_set_calib_offset(struct ad4170_state *st,
 				   struct iio_chan_spec const *chan, int val)
 {
@@ -1134,6 +1389,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4170_set_channel_freq(st, chan, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -1164,6 +1421,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
@@ -1398,6 +1657,8 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 	unsigned int i;
 	int ret;
 
+	ad4170_fill_sps_tbl(st);
+
 	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -1427,6 +1688,12 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 			return dev_err_probe(dev, ret,
 					     "Failed to write CHAN_MAP_REG\n");
 
+		ret = ad4170_set_channel_freq(st, chan,
+					      AD4170_DEFAULT_SAMP_RATE, 0);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set channel freq\n");
+
 		ret = ad4170_fill_scale_tbl(indio_dev, chan);
 		if (ret)
 			return dev_err_probe(dev, ret,
-- 
2.47.2


