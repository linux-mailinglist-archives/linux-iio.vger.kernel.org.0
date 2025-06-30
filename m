Return-Path: <linux-iio+bounces-21159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A48AEDFEC
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1797D17A5AE
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94728B513;
	Mon, 30 Jun 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qei3NAz8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2527FB0D;
	Mon, 30 Jun 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292035; cv=none; b=FYxtjuPQI3KqJl5gLNTDo88gIZAI+iqkp+59nmXO/i23dkYKCIi6ShFz5DIpqQ2cB2ZBBHzomkHN/vTWhTjFkTeBT90pN1vspjqZ3fMBgwlYHD485Q6pkshExKk2QkeqLMka+E3Tmz0al2WmT9cFsP3Z3I4ZXCUYdxUurxcHsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292035; c=relaxed/simple;
	bh=Cfx9J9AUjay76OwEICbRBGpcoVk02dxjMPOhh6oOGJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEAYdlzGo23V4ycySqEvoUxoz7uPOcZW7b1JDD6aVuhYgQlAwm6mB5cG6ukLVQbNlxZ3hu/0MvFtPxFnsdQQReiak1WsxJoANlwNMyInrbdXs3aRzCYOVw52byxySC4U2yG0ZuijEQz0gY6K2/H4TeCM5+cgxJMC/LGUYp/A0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qei3NAz8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDllDp026511;
	Mon, 30 Jun 2025 10:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EChWG
	jF7OAJlwXNQgfy8xZ/yXbwXYfVmWlE5VjlBIT0=; b=qei3NAz8EN3TDI49vT9ex
	GL7WmBda2DDyTP2DkoAXKCi5Sa/OzKvy69DDUsaZaRJV9H4lwvjzPkyjFekjJ+4/
	JMj7cFkAHdbUvMsClpQkazn2G2AjQaLJb9/0NXdDQnFu4lHZS3meMiUJiOzzrPWQ
	Nfba3pdxCm2WG2mkshZuPaPTToMPvqWeHshTdpnG4AWGpaSuqERNR1uSbnKyU4tA
	SPSeSUy2a5moCaXx11vAUqM7+SaWTcNyST278x7PuggfLfqTtR912u53a+ByZpel
	E4fGkxHdZFlhSUnoEJYd04HYy6GFpcwfmLYFbW6ykzp1SVqecwcFD9aypVZYQfZh
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47krqa10bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:00:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55UE0BjX039524
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 10:00:11 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:00:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:00:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 10:00:11 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UDxstK008284;
	Mon, 30 Jun 2025 09:59:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 06/12] iio: adc: ad4170-4: Add digital filter and sample frequency config support
Date: Mon, 30 Jun 2025 10:59:53 -0300
Message-ID: <2157e21a54d0f69fafbf92c0faded5e9f830d9c2.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfX1ZbLQH9JON/x
 d3bEChICoCSyKzaQs1vSOJE2QiVd4R0FZUxauaYZ9JH0KBAqelCoOXWsXLSvxSlSt6LzAP9zkBZ
 qdJvPSi+/hYZcQJtWHxFnVXexFgKRt734iyQIYZERolafKqywjSahsc+vvJ/+GpGSf3PfPbvavB
 2eWQKREgc+l/gp9VlunjeFLRMyOAUgb/0qyDpDoV47FyHEQFUXuetAxumfEn6SahYot69IUBkhR
 BJbN/Y89rR7lF/QLMplEvpIxwjep/NpEjnM6ZxRmQreTfQKQZ4Pcw8OFqL3Uusb12gjvuco/LEF
 vo8TV/g4ttt6ZIMbDuMv6x4Ru8YByjuoGVkXgHM1qivQ77vi6RaDIhZ/k9oE9WI9z9ERGDUbgp2
 BTGD4t+vPAtKcCPzH20srEQjvZ/gvfZvghNrRmkahebEzyXe2+EKtRh/482YTFQ3v5wNNkhH
X-Proofpoint-GUID: tfxUl917s5kgxEAl9_WP9i4MEjaEnxly
X-Proofpoint-ORIG-GUID: tfxUl917s5kgxEAl9_WP9i4MEjaEnxly
X-Authority-Analysis: v=2.4 cv=U8+SDfru c=1 sm=1 tr=0 ts=6862986c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=EmSbnTKpHicewLe-UmcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

Add support for sinc3, sinc5, and averaged sinc5 digital filters along with
sample frequency configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- Now reading SPS table within filter type switch to ensure in bounds array access.
- Squeezed info_mask_separate additions to reduce change diff.

 drivers/iio/adc/ad4170-4.c | 263 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 261 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 216dc844cc62..abd8a292625b 100644
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
 struct ad4170_chip_info {
 	const char *name;
 };
@@ -270,6 +304,12 @@ struct ad4170_chan_info {
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
@@ -279,6 +319,7 @@ struct ad4170_state {
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
+	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	struct completion completion;
 	unsigned int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
@@ -289,6 +330,38 @@ struct ad4170_state {
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
@@ -617,6 +690,100 @@ static int ad4170_set_channel_enable(struct ad4170_state *st,
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
@@ -625,8 +792,11 @@ static const struct iio_chan_spec ad4170_channel_template = {
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
@@ -921,7 +1091,8 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
 	struct ad4170_setup *setup = &chan_info->setup;
-	unsigned int pga;
+	enum ad4170_filter_type f_type;
+	unsigned int pga, fs_idx;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -942,6 +1113,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
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
@@ -1027,6 +1219,7 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
 {
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	enum ad4170_filter_type f_type;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
@@ -1034,6 +1227,24 @@ static int ad4170_read_avail(struct iio_dev *indio_dev,
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
@@ -1062,6 +1273,42 @@ static int ad4170_set_pga(struct ad4170_state *st,
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
@@ -1095,6 +1342,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4170_set_channel_freq(st, chan, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -1125,6 +1374,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
@@ -1370,6 +1621,8 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 	unsigned int i;
 	int ret;
 
+	ad4170_fill_sps_tbl(st);
+
 	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
 				 AD4170_ADC_CTRL_MODE_MSK,
 				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
@@ -1402,6 +1655,12 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
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


