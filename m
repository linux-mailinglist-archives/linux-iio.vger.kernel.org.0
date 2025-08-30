Return-Path: <linux-iio+bounces-23420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F302B3C6B9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6BD179144
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866F21CC63;
	Sat, 30 Aug 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xY0Bl3OY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511D1A9FBC;
	Sat, 30 Aug 2025 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514785; cv=none; b=s60r0CVX1P8SqbXUoTDfq8wyBrOMgfo6RlNaD4FBcztOwFhXjyfBBYTIvtYdPQDp5POgQ14jbr4Qk3CKgLJoYVD7IS5KLObSJCT+OwnW7j/GhhkdQzPgDoi1zt6J9ZRs86KJLsKxTokjb1jyHGlf5ZXP6+IubOrm+eWqPmbPQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514785; c=relaxed/simple;
	bh=4O0V+tYCk7xQI2ZdRS24rFazLaeWjXB5o107mGuS9fM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoSCPMZMsGAcLvurIhMmRZv7G83n/SGkxs3q+mTlA6A+YYw3PHG/HDMK+8CJ1wvcd60kzBYhR+zZtDZG/yFSiQCGINw3qSWGVx/LaEi8kxAxjc2ozdgWyWIHFU9NVrcgkgmQNcJTV2l/Z1kIUDD83Q0klYd06x1Alsee90TqjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xY0Bl3OY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0FCCT013290;
	Fri, 29 Aug 2025 20:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U6dij
	1m2xN8sb2bbhD+R+fPZsbcin0oa4hGZatNiRQU=; b=xY0Bl3OYl8ZlnIScjeXlm
	N30JymUzDRgF5zRc3mLvd/ywi/YpHk9LPdA+Qikh679qErsSzlx93EGCOZ/Bhal7
	oHqfiRP31WOKpvgQgbdQgG8uQzlzbCBjYJ9ge9X6imHzo7LARNcMhIdh/vY+HzL8
	nfpaidNRzhOt6sCVrTnPdqdtbdil14k9umRMbkizbVL6SsyZ7C3OSmXOLxzXSOSL
	LlWC4Gagjd3+T/YRYoqf9T5s+twfOhb02V1byqdNQhDF5w93vMBp/1gKxV4W34Nz
	KMjHAxb0uTWJWhyv7NcDy55pmk6gX8vqmgWIW/9kUNmq4F1WweIwJWrE4fcFwlKY
	A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966uty4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:46:18 -0400 (EDT)
Received: from m0375855.ppops.net (m0375855.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0kIkj002925;
	Fri, 29 Aug 2025 20:46:18 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966uty0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:46:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57U0kHOh041321
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:46:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:46:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:46:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:46:16 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0jvOU005067;
	Fri, 29 Aug 2025 20:46:00 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 15/15] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
Date: Fri, 29 Aug 2025 21:45:57 -0300
Message-ID: <006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: urwDvlekNiOMsZzj0SMr2y9-IhLE3iMg
X-Proofpoint-ORIG-GUID: YfI7W-u0nKIXm0TCrYVYq9AC8d8ipRJ4
X-Authority-Analysis: v=2.4 cv=J6Wq7BnS c=1 sm=1 tr=0 ts=68b249da cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=9XtCXr9kHfidp3qlRtUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA3NCBTYWx0ZWRfX6YxFuGVbkPlZ
 2jxxAlMmRl4Khx3HZwF+/2oo4ptm6+JqkA/J6AJ3xg56qiyX6FpVXtUvHp4VZpkvbmObs4QCsrJ
 4/cqkpbE9YTFy9V2WyKqN9Xi/9GSyT66c9BQmXOsxM3O6H7g8q25qByx3xigsqryQUVDmj33hPB
 tXPJ8de4iNC7h7NNlAFqyO860G3Tx0/vik+9eCWgSzpHd9p/pmj3leGYWjWWbabIoc5X0jzUkyU
 q8iPZoWn/T2TYdv+qoIYVLtXDvriSKpYNRNU+HkYCK6pHdL49NvMtIk+IITD+Jz+L4V7v3Jh04H
 s60HA/dWXQVzz0J9T1NajmZ7SbUjHPeDmMS0mEJZv/exGWh7hXF1yOxZTtMbfp/OLrcZsTcxby/
 fgVgoaKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508290074

ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
that scales the analog input signal prior to it reaching the ADC. The PGA
is controlled through a pair of pins (A0 and A1) whose state define the
gain that is applied to the input signal.

Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
through the IIO device channel scale available interface and enable control
of the PGA through the channel scale interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 239 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 235 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 37ba00097efe..32157b3a0420 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -21,6 +21,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/log2.h>
+#include <linux/minmax.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -42,6 +43,8 @@
 #define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
 #define     AD4030_REG_CHIP_GRADE_AD4632_16_GRADE	0x05
 #define     AD4030_REG_CHIP_GRADE_AD4632_24_GRADE	0x02
+#define     AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE	0x1E
+#define     AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE	0x1C
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -121,6 +124,10 @@
 /* Datasheet says 9.8ns, so use the closest integer value */
 #define AD4030_TQUIET_CNV_DELAY_NS	10
 
+/* HARDWARE_GAIN */
+#define ADAQ4616_PGA_PINS		2
+#define ADAQ4616_GAIN_MAX_NANO		6666666667
+
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
 	AD4030_OUT_DATA_MD_16_DIFF_8_COM,
@@ -149,6 +156,20 @@ enum {
 	AD4030_OFFLOAD_SCAN_TYPE_AVG,
 };
 
+/*
+ * Gains computed as fractions of 1000 so they can be expressed by integers.
+ */
+static const int ad4030_hw_gains[] = {
+	333, 556, 2222, 6667,
+};
+
+static const int ad4030_hw_gains_frac[4][2] = {
+	{ 1, 3 },  /* 1/3 gain */
+	{ 5, 9 },  /* 5/9 gain */
+	{ 20, 9 }, /* 20/9 gain */
+	{ 20, 3 }, /* 20/3 gain */
+};
+
 struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
@@ -160,6 +181,7 @@ struct ad4030_chip_info {
 	int num_voltage_inputs;
 	unsigned int tcyc_ns;
 	unsigned int max_sample_rate_hz;
+	unsigned int num_pga_pins;
 };
 
 struct ad4030_state {
@@ -183,6 +205,10 @@ struct ad4030_state {
 	struct spi_offload *offload;
 	struct spi_offload_trigger *offload_trigger;
 	struct spi_offload_trigger_config offload_trigger_config;
+	struct gpio_descs *pga_gpios;
+	int pga_index;
+	unsigned int scale_avail[ARRAY_SIZE(ad4030_hw_gains)][2];
+	size_t scale_avail_size;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -239,7 +265,7 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
+#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload, _pga) {		\
 	.info_mask_shared_by_all =					\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_shared_by_all_available =				\
@@ -250,6 +276,7 @@ struct ad4030_state {
 		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
 		BIT(IIO_CHAN_INFO_RAW),					\
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
+		(_pga ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
 		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
@@ -264,10 +291,16 @@ struct ad4030_state {
 }
 
 #define AD4030_CHAN_DIFF(_idx, _scan_type)				\
-	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0, 0)
 
 #define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
-	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1, 0)
+
+#define ADAQ4216_CHAN_DIFF(_idx, _scan_type)				\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0, 1)
+
+#define ADAQ4216_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1, 1)
 
 static const int ad4030_rx_bus_width[] = {
 	1, 2, 4, 8,
@@ -429,6 +462,74 @@ static const struct regmap_config ad4030_regmap_config = {
 	.max_register = AD4030_REG_DIG_ERR,
 };
 
+static void ad4030_fill_scale_avail(struct ad4030_state *st)
+{
+	unsigned int mag_bits, tmp0, tmp1, i;
+	u64 range;
+
+	/*
+	 * The maximum precision of differential channels is retrieved from the
+	 * chip properties. The output code of differential channels is in two's
+	 * complement format (i.e. signed), so the MSB is the sign bit and only
+	 * (precision_bits - 1) bits express voltage magnitude.
+	 */
+	mag_bits = st->chip->precision_bits - 1;
+
+	for (i = 0; i < ARRAY_SIZE(ad4030_hw_gains); i++) {
+		range = mult_frac(st->vref_uv, ad4030_hw_gains_frac[i][1],
+				  ad4030_hw_gains_frac[i][0]);
+		/*
+		 * If range were in mV, we would multiply it by NANO below.
+		 * Though, range is in µV so multiply it by MICRO only so the
+		 * result after right shift and division scales output codes to
+		 * millivolts.
+		 */
+		tmp0 = div_u64_rem(((u64)range * MICRO) >> mag_bits, NANO, &tmp1);
+		st->scale_avail[i][0] = tmp0; /* Integer part */
+		st->scale_avail[i][1] = tmp1; /* Fractional part */
+	}
+}
+
+static int ad4030_set_pga_gain(struct ad4030_state *st)
+{
+	DECLARE_BITMAP(bitmap, ADAQ4616_PGA_PINS) = { };
+
+	bitmap_write(bitmap, st->pga_index, 0, 2);
+
+	return gpiod_multi_set_value_cansleep(st->pga_gpios, bitmap);
+}
+
+static int ad4030_set_pga(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int gain_int,
+			  int gain_fract)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	unsigned int mag_bits;
+	u64 gain_nano, tmp;
+
+	if (!st->pga_gpios)
+		return -EINVAL;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (scan_type->sign == 's')
+		mag_bits = st->chip->precision_bits - 1;
+	else
+		mag_bits = st->chip->precision_bits;
+
+	gain_nano = gain_int * NANO + gain_fract;
+
+	if (!in_range(gain_nano, 0, ADAQ4616_GAIN_MAX_NANO))
+		return -EINVAL;
+
+	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << mag_bits, NANO);
+	gain_nano = DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
+	st->pga_index = find_closest(gain_nano, ad4030_hw_gains,
+				     ARRAY_SIZE(ad4030_hw_gains));
+
+	return ad4030_set_pga_gain(st);
+}
+
 static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan,
 				 int *val,
@@ -455,7 +556,14 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	*val2 = scan_type->realbits == 30 ? st->chip->precision_bits
 					  : scan_type->realbits;
 
-	return IIO_VAL_FRACTIONAL_LOG2;
+	/* The LSB of the 8-bit common-mode data is always vref/256. */
+	if (scan_type->realbits == 8 || !st->chip->num_pga_pins)
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	*val = st->scale_avail[st->pga_index][0];
+	*val2 = st->scale_avail[st->pga_index][1];
+
+	return IIO_VAL_INT_PLUS_NANO;
 }
 
 static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
@@ -654,6 +762,19 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 				 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
 }
 
+static int ad4030_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
+
 static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 {
 	struct ad4030_state *st = iio_priv(dev);
@@ -891,6 +1012,15 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(ad4030_average_modes);
 		return IIO_AVAIL_LIST;
 
+	case IIO_CHAN_INFO_SCALE:
+		if (!st->pga_gpios)
+			*vals = (int *)st->scale_avail[st->pga_index];
+		else
+			*vals = (int *)st->scale_avail;
+		*length = st->scale_avail_size * 2; /* print int and nano part */
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+
 	default:
 		return -EINVAL;
 	}
@@ -966,6 +1096,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4030_set_sampling_freq(indio_dev, val);
 
+	case IIO_CHAN_INFO_SCALE:
+		return ad4030_set_pga(indio_dev, chan, val, val2);
+
 	default:
 		return -EINVAL;
 	}
@@ -1037,6 +1170,7 @@ static const struct iio_info ad4030_iio_info = {
 	.read_avail = ad4030_read_avail,
 	.read_raw = ad4030_read_raw,
 	.write_raw = ad4030_write_raw,
+	.write_raw_get_fmt = &ad4030_write_raw_get_fmt,
 	.debugfs_reg_access = ad4030_reg_access,
 	.read_label = ad4030_read_label,
 	.get_current_scan_type = ad4030_get_current_scan_type,
@@ -1318,6 +1452,51 @@ static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
 							   IIO_BUFFER_DIRECTION_IN);
 }
 
+static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
+			    struct ad4030_state *st)
+{
+	unsigned int i;
+	int pga_value;
+	int ret;
+
+	ret = device_property_read_u32(dev, "adi,pga-value", &pga_value);
+	if (ret && ret != -EINVAL)
+		return dev_err_probe(dev, ret, "Failed to get PGA value.\n");
+
+	if (ret == -EINVAL) {
+		/* Setup GPIOs for PGA control */
+		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
+		if (IS_ERR(st->pga_gpios))
+			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
+					     "Failed to get PGA gpios.\n");
+
+		if (st->pga_gpios->ndescs != 2)
+			return dev_err_probe(dev, -EINVAL,
+					     "Expected 2 GPIOs for PGA control.\n");
+
+		st->scale_avail_size = ARRAY_SIZE(ad4030_hw_gains);
+		st->pga_index = 0;
+		return ad4030_set_pga_gain(st);
+	}
+
+	/* Set ADC driver to handle pin-strapped PGA pins setup */
+	for (i = 0; i < ARRAY_SIZE(ad4030_hw_gains); i++) {
+		if (pga_value != ad4030_hw_gains[i])
+			continue;
+
+		st->pga_index = i;
+		break;
+	}
+	if (i == ARRAY_SIZE(ad4030_hw_gains))
+		return dev_err_probe(dev, -EINVAL, "Invalid PGA value: %d.\n",
+				     pga_value);
+
+	st->scale_avail_size = 1;
+	st->pga_gpios = NULL;
+
+	return 0;
+}
+
 static int ad4030_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1360,6 +1539,14 @@ static int ad4030_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	if (st->chip->num_pga_pins > 0) {
+		ret = ad4030_setup_pga(dev, indio_dev, st);
+		if (ret)
+			return ret;
+
+		ad4030_fill_scale_avail(st);
+	}
+
 	ret = ad4030_config(st);
 	if (ret)
 		return ret;
@@ -1611,12 +1798,54 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 	.max_sample_rate_hz = 500 * KILO,
 };
 
+static const struct ad4030_chip_info adaq4216_chip_info = {
+	.name = "adaq4216",
+	.available_masks = ad4030_channel_masks,
+	.channels = {
+		ADAQ4216_CHAN_DIFF(0, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+		IIO_CHAN_SOFT_TIMESTAMP(2),
+	},
+	.offload_channels = {
+		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE,
+	.precision_bits = 16,
+	.num_voltage_inputs = 1,
+	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * MEGA,
+	.num_pga_pins = ADAQ4616_PGA_PINS,
+};
+
+static const struct ad4030_chip_info adaq4224_chip_info = {
+	.name = "adaq4224",
+	.available_masks = ad4030_channel_masks,
+	.channels = {
+		ADAQ4216_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+		IIO_CHAN_SOFT_TIMESTAMP(2),
+	},
+	.offload_channels = {
+		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE,
+	.precision_bits = 24,
+	.num_voltage_inputs = 1,
+	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * MEGA,
+	.num_pga_pins = ADAQ4616_PGA_PINS,
+};
+
 static const struct spi_device_id ad4030_id_table[] = {
 	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
 	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
 	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
 	{ "ad4632-16", (kernel_ulong_t)&ad4632_16_chip_info },
 	{ "ad4632-24", (kernel_ulong_t)&ad4632_24_chip_info },
+	{ "adaq4216", (kernel_ulong_t)&adaq4216_chip_info },
+	{ "adaq4224", (kernel_ulong_t)&adaq4224_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4030_id_table);
@@ -1627,6 +1856,8 @@ static const struct of_device_id ad4030_of_match[] = {
 	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
 	{ .compatible = "adi,ad4632-16", .data = &ad4632_16_chip_info },
 	{ .compatible = "adi,ad4632-24", .data = &ad4632_24_chip_info },
+	{ .compatible = "adi,adaq4216", .data = &adaq4216_chip_info },
+	{ .compatible = "adi,adaq4224", .data = &adaq4224_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4030_of_match);
-- 
2.39.2


