Return-Path: <linux-iio+bounces-21425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF2AFB551
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304CF1894706
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02E2951BD;
	Mon,  7 Jul 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fvsdNoVR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D68A145348;
	Mon,  7 Jul 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896386; cv=none; b=KJGAaeRkugyS5sA4b3u+RHqVpbgpdez7QD+uk0SX5HvaxCRX8DCpi0lD0JYnAqp7jSlmk2qIxC0/i3i8tJbOe28XxtyZROWIzYsVURxRBQfrhDEub6+N5ntat2Da01WT/RtSZaJcYGCt6PaQnIpCF/1WBJ067vESx2F0SXrSzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896386; c=relaxed/simple;
	bh=vofCS4prh1SDr1fM5Rojlfay8Prd6x05IJFladfGJKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm0BMpR3jLFrnOVSCKWV9apgNacYjtkGP+nhFkouy/rGXgsP81mzVODvIip8x0MbUnN48JcT/F1Yt3y9lNKjkVVe8aWjuEmgX6a/IQBGowRFL3xi8OnygFswBuV1Rh8NA9igocct0ybAeKIi862FS4QD+3tJ80D6319R/T3K8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fvsdNoVR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567D3Djn004668;
	Mon, 7 Jul 2025 09:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2Ddb2
	L9bCY47L5TlLOfB10PX085quCjWpCh5vtXV/c0=; b=fvsdNoVRYSH6p/UpMSgdW
	XUDp8sNFdn2DsxIcVl9d0TH4HtUTxISECeBlX4ifZVIShQ3P3INomNdU3eNBVNeX
	f0HUIBKEmwX0dWfGFIOOVdUB7R1IdSn27PoKlnTWp2V6xhyLt2K/5ZYzz6i4QYL4
	qYvSgqwF4d1Y40I3I72LUR3x23NnbRXNkpDlM5BqMjGFb5FCbN89RRmuzAjDrC0z
	ut3wlhpqSxAPxIHUp/PIQPzfM12GR9szZ7iFy247wj5VwFzdQOR1pN63l6us+yir
	MoMxxfBmi/cqWBNbyxG0+qESIEJAoICN06ag6FbQyuQapujphhtqwL5ctI+Bw7sl
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47r7trj3wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:52:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 567DqjeN011640
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:52:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 09:52:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 09:52:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:52:44 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567DqQqx016166;
	Mon, 7 Jul 2025 09:52:28 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 06/12] iio: adc: ad4170-4: Add digital filter and sample frequency config support
Date: Mon, 7 Jul 2025 10:52:25 -0300
Message-ID: <31f4226b4172b0bbb26daa054b74b25b1966c7b2.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: gYPYFGCYx96FbbN7Dc9RdJsaQMvr_wxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MSBTYWx0ZWRfX0TyyXYnZAUSH
 eL6sNaq74IZh7IMH30ay7p1aJuVKz+INOfwjMN/ooH9Gm0nPb1/mAknlPATN8gK1VRtJxig632u
 oejNZtb0WHcgQXe/d31j5s2pjIDqtgWww4JzdML9ONOSyugkp4eHTGxSYd6ak4ZuHOE9y4T0QUF
 zccgfnyvjMYGykZZ4/LyYS4IrKNI74Ny4ENuYLH1133t6JYEo4jSkE/hIv8wzvjyb/Cf3zNRmCK
 GjDgGHelhIEgif05FGV+wOYcuWllieiKgENi/f6jfK6MjNKjjPu8Ey/ZMFWUPzIeUOuLFHszZNz
 XkTFSMv15okYsoi6yE2jzQf7b4kXjuY+GYGC71hJRerzAvy6XV/zQ5sem24EyjbJUpO2Ome7R+6
 cX8CCbArJ2fE3n7/Rhz8k48np5OJgPmsXPujFtwAA48x2KJPnhUAGVkDPlECin8FlI9XjwgC
X-Proofpoint-GUID: gYPYFGCYx96FbbN7Dc9RdJsaQMvr_wxK
X-Authority-Analysis: v=2.4 cv=S8fZwJsP c=1 sm=1 tr=0 ts=686bd12e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=EmSbnTKpHicewLe-UmcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070081

Add support for sinc3, sinc5, and averaged sinc5 digital filters along with
sample frequency configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v7.

 drivers/iio/adc/ad4170-4.c | 263 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 261 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 3b880d7a7ed0..6ad4637f9829 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -90,6 +91,9 @@
 #define AD4170_AFE_BIPOLAR_MSK				BIT(4)
 #define AD4170_AFE_PGA_GAIN_MSK				GENMASK(3, 0)
 
+/* AD4170_FILTER_REG */
+#define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
+
 /* AD4170 register constants */
 
 /* AD4170_CHAN_MAP_REG constants */
@@ -115,6 +119,11 @@
 #define AD4170_ADC_CTRL_MODE_SINGLE			0x4
 #define AD4170_ADC_CTRL_MODE_IDLE			0x7
 
+/* AD4170_FILTER_REG constants */
+#define AD4170_FILTER_FILTER_TYPE_SINC5_AVG		0x0
+#define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
+#define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
+
 /* Device properties and auxiliary constants */
 
 #define AD4170_NUM_ANALOG_PINS				9
@@ -124,6 +133,7 @@
 #define AD4170_INVALID_SETUP				9
 #define AD4170_SPI_INST_PHASE_LEN			2
 #define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_DEFAULT_SAMP_RATE			(125 * HZ_PER_KHZ)
 
 #define AD4170_INT_REF_2_5V				2500000
 
@@ -132,6 +142,12 @@
 
 #define AD4170_NUM_PGA_OPTIONS				10
 
+/* Digital filter properties */
+#define AD4170_SINC3_MIN_FS				4
+#define AD4170_SINC3_MAX_FS				65532
+#define AD4170_SINC5_MIN_FS				1
+#define AD4170_SINC5_MAX_FS				256
+
 #define AD4170_GAIN_REG_DEFAULT				0x555555
 
 static const unsigned int ad4170_reg_size[] = {
@@ -192,6 +208,12 @@ enum ad4170_ref_select {
 	AD4170_REF_AVDD,
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
@@ -213,6 +235,18 @@ static const char * const ad4170_int_pin_names[] = {
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
 enum ad4170_sensor_enum {
 	AD4170_ADC_SENSOR = 0,
 };
@@ -274,6 +308,12 @@ struct ad4170_chan_info {
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
@@ -284,6 +324,7 @@ struct ad4170_state {
 	struct iio_chan_spec chans[AD4170_MAX_ADC_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
+	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	unsigned int pins_fn[AD4170_NUM_ANALOG_PINS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -292,6 +333,38 @@ struct ad4170_state {
 	u8 rx_buf[4] __aligned(IIO_DMA_MINALIGN);
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
@@ -620,6 +693,100 @@ static int ad4170_set_channel_enable(struct ad4170_state *st,
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
+	unsigned int filter_type_conf;
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
+	/*
+	 * The filters provide the same ODR for a given filter_fs value but
+	 * there are different minimum and maximum filter_fs limits for each
+	 * filter. The filter_fs value will be adjusted if the current filter_fs
+	 * is out of the limits of the just requested filter. Since the
+	 * filter_fs value affects the ODR (sampling_frequency), changing the
+	 * filter may lead to a change in the sampling frequency.
+	 */
+	scoped_guard(mutex, &st->lock) {
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
+			setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
+						 AD4170_SINC3_MAX_FS);
+		else
+			setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
+						 AD4170_SINC5_MAX_FS);
+
+		setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
+		setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,
+					    filter_type_conf);
+
+		ret = ad4170_write_channel_setup(st, chan->address, false);
+		iio_device_release_direct(indio_dev);
+	}
+
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
@@ -628,8 +795,11 @@ static const struct iio_chan_spec ad4170_channel_template = {
 			      BIT(IIO_CHAN_INFO_SCALE) |
 			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			      BIT(IIO_CHAN_INFO_OFFSET),
-	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.ext_info = ad4170_filter_type_ext_info,
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
@@ -924,7 +1094,8 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
 	struct ad4170_setup *setup = &chan_info->setup;
-	unsigned int pga;
+	enum ad4170_filter_type f_type;
+	unsigned int pga, fs_idx;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -950,6 +1121,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
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
@@ -1035,6 +1227,7 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
 {
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	enum ad4170_filter_type f_type;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
@@ -1042,6 +1235,24 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
 		*type = IIO_VAL_INT_PLUS_NANO;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		f_type = ad4170_get_filter_type(indio_dev, chan);
+		switch (f_type) {
+		case AD4170_SINC5_AVG:
+		case AD4170_SINC3:
+			/* Read sps_tbl here to ensure in bounds array access */
+			*vals = (int *)st->sps_tbl[f_type];
+			*length = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl) * 2;
+			return IIO_AVAIL_LIST;
+		case AD4170_SINC5:
+			/* Read sps_tbl here to ensure in bounds array access */
+			*vals = (int *)st->sps_tbl[f_type];
+			*length = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl) * 2;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1070,6 +1281,42 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return ad4170_write_channel_setup(st, chan->address, false);
 }
 
+static int ad4170_set_channel_freq(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan, int val,
+				   int val2)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	enum ad4170_filter_type f_type = __ad4170_get_filter_type(setup->filter);
+	unsigned int filt_fs_tbl_size, i;
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
+	if (f_type == AD4170_SINC5)
+		setup->filter_fs = ad4170_sinc5_filt_fs_tbl[i];
+	else
+		setup->filter_fs = ad4170_sinc3_filt_fs_tbl[i];
+
+	return ad4170_write_channel_setup(st, chan->address, false);
+}
+
 static int ad4170_set_calib_offset(struct ad4170_state *st,
 				   struct iio_chan_spec const *chan, int val)
 {
@@ -1103,6 +1350,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4170_set_channel_freq(st, chan, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -1133,6 +1382,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
@@ -1387,6 +1638,8 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 	unsigned int i;
 	int ret;
 
+	ad4170_fill_sps_tbl(st);
+
 	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
 				 AD4170_ADC_CTRL_MODE_MSK,
 				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
@@ -1419,6 +1672,12 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
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


