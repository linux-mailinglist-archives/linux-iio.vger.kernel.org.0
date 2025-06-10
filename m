Return-Path: <linux-iio+bounces-20377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F827AD43D6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866CD189591D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC2265CBB;
	Tue, 10 Jun 2025 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UC3W0f0W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A2264A86;
	Tue, 10 Jun 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587584; cv=none; b=iU4J/eaGtmGju5YMbuoMJExR24VvxpJ+mAm99oaeE2XV2V8MuFrmTQ5wFWJuLiPR2I4u29Kk0zc+qYNoOWbFNetHqPj8U4B2pcsW8aO7lJpsC3+8ZcrBnwZ5wLUvjRVDtGnTFDGKDcbrw0GtvJNG3S5iwVv5Xy5Z4TDAP0XXrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587584; c=relaxed/simple;
	bh=d8OxNXfbqNrKSJOAxpgZ9/bw83OQHB1EGSre9tA93UY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpMFS7DVM7c3FVOZlnSQjQmJDQ0olTMp2MrzPqbbrLU54GdLcRQ6VdowVM8ZnvzbClPIdijkKU/5e9qBHn2KPEjKgAC9seSRYSRWB550Cfg7Y9Ox/U2oSw6T3mRM55cm67xuvi3mCoplH+ku5uFLd4ku5EmbHTn2ZnGpYHP9Ruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UC3W0f0W; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIBxLw012591;
	Tue, 10 Jun 2025 16:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F9s4M
	T3jwPyjHQ2OfCz85QEooRzFDglzElgtXeupeVI=; b=UC3W0f0W/1qUxEWHu77b1
	mO5GutO23rGYUXfhW/3lgo5hwPvMf7vO/mRiv5PIsppEf3LaJExZyxF6Cnt0PW+f
	diUJLHHaTGbAdpoyHOfvMJ8HSiAxaKjrAjg0mWqo0roQtveeWSpLqJh7zs3LwApi
	NKKDTIDQg15dAforxeKQ/saMQMb75NWxLlsEQpGyQZZIYMgNYsy7KplvrvIP0Po0
	uxQ2ezrf5W651e1Z+/QlAKX2gwyakLobdVi//6CJrFqboBY1JjYVBRRca2kAOjHf
	uyLdzkhm8Ddkk1PKv+szHF+EYjgluecIquG3Cp7oJBescQJfpP9AgONHVfw+0c7d
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476hwsbkec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:32:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55AKWhIC040218
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:32:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:32:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:32:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:32:43 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKWOxL019917;
	Tue, 10 Jun 2025 16:32:27 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 05/11] iio: adc: ad4170: Add digital filter and sample frequency config support
Date: Tue, 10 Jun 2025 17:32:24 -0300
Message-ID: <dd8a615936dfebb6cd7c8110db2fbe0b81776608.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: G6_lppxU4JB8uocR2oUj7GDNaQZ3oF9v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX2vAzrx+25XbJ
 zjwUBjG40aP0EZpI02vLUgd5Hgme6wLzqNg3iy1PYMyx8D8SUF3dC1PMIkXuEwoPXHOMSz/gaXt
 DQJGxwFqIMmkfxnjSCs4wHCmPoisWXifT0wD/fhtTjivNwcmkjlkgBd+FjL6StePw/+QM4AnITl
 ioSsucUa1pnniPtFukK+EpsZa+fBY1G48aGkY66RULpl/uhhJ2Y11LUHQWhQwFemjacoJ98wa7K
 fpx1/VbZXS1TDYQjTz+Guzh/oDzNuvAgd6K+RS3YAqYLAioUnmfiqmis1ATbSyZ8pvoYgYZ+yKa
 460+/XRiT3UWcSMS2O0l20FW0v9eebkaq9xMJYrjD2B1YKK0kQBzBC3KfUtcCSwisN/YsORBswN
 OWLE8yjcIuOb7495c6xoOQz3TWH2dAZeXRecOfks18IyvDS8dGBRCI39NpJwU0Yu1/zFraW1
X-Authority-Analysis: v=2.4 cv=daWA3WXe c=1 sm=1 tr=0 ts=6848966c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=EmSbnTKpHicewLe-UmcA:9
X-Proofpoint-GUID: G6_lppxU4JB8uocR2oUj7GDNaQZ3oF9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100166

Add support for sinc3, sinc5, and averaged sinc5 digital filters along with
sample frequency configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes from v4.

 drivers/iio/adc/ad4170.c | 262 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index d0482f3b6f01..eecd223cda44 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -88,6 +89,9 @@
 #define AD4170_AFE_BIPOLAR_MSK				BIT(4)
 #define AD4170_AFE_PGA_GAIN_MSK				GENMASK(3, 0)
 
+/* AD4170_FILTER_REG */
+#define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
+
 /* AD4170 register constants */
 
 /* AD4170_CHAN_MAP_REG constants */
@@ -113,6 +117,11 @@
 #define AD4170_ADC_CTRL_MODE_SINGLE			0x4
 #define AD4170_ADC_CTRL_MODE_IDLE			0x7
 
+/* AD4170_FILTER_REG constants */
+#define AD4170_FILTER_FILTER_TYPE_SINC5_AVG		0x0
+#define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
+#define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
+
 /* Device properties and auxiliary constants */
 
 #define AD4170_NUM_ANALOG_PINS				9
@@ -121,6 +130,7 @@
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
 #define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_DEFAULT_SAMP_RATE			(125 * HZ_PER_KHZ)
 
 #define AD4170_INT_REF_2_5V				2500000
 
@@ -129,6 +139,12 @@
 
 #define AD4170_NUM_PGA_OPTIONS				10
 
+/* Digital filter properties */
+#define AD4170_SINC3_MIN_FS				4
+#define AD4170_SINC3_MAX_FS				65532
+#define AD4170_SINC5_MIN_FS				1
+#define AD4170_SINC5_MAX_FS				256
+
 #define AD4170_GAIN_REG_DEFAULT				0x555555
 
 static const unsigned int ad4170_reg_size[] = {
@@ -182,6 +198,12 @@ enum ad4170_ref_select {
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
@@ -203,6 +225,18 @@ static const char * const ad4170_int_pin_names[] = {
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
@@ -260,6 +294,12 @@ struct ad4170_chan_info {
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
@@ -269,6 +309,7 @@ struct ad4170_state {
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
+	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	struct completion completion;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
@@ -280,6 +321,38 @@ struct ad4170_state {
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
@@ -630,6 +703,100 @@ static int ad4170_set_channel_enable(struct ad4170_state *st,
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
@@ -638,8 +805,11 @@ static const struct iio_chan_spec ad4170_channel_template = {
 			      BIT(IIO_CHAN_INFO_SCALE) |
 			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
-			      BIT(IIO_CHAN_INFO_OFFSET),
-	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.ext_info = ad4170_filter_type_ext_info,
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
@@ -931,7 +1101,8 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
 	struct ad4170_setup *setup = &chan_info->setup;
-	unsigned int pga;
+	enum ad4170_filter_type f_type;
+	unsigned int pga, fs_idx;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -952,6 +1123,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
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
@@ -1037,6 +1229,7 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
 {
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	enum ad4170_filter_type f_type;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
@@ -1044,6 +1237,21 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
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
@@ -1072,6 +1280,42 @@ static int ad4170_set_pga(struct ad4170_state *st,
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
@@ -1105,6 +1349,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4170_set_channel_freq(st, chan, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -1135,6 +1381,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
@@ -1364,6 +1612,8 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 	unsigned int i;
 	int ret;
 
+	ad4170_fill_sps_tbl(st);
+
 	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
 				 AD4170_ADC_CTRL_MODE_MSK,
 				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
@@ -1396,6 +1646,12 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
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


