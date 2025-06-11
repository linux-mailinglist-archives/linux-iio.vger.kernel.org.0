Return-Path: <linux-iio+bounces-20425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007BAD54AA
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476FE189151D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B8283121;
	Wed, 11 Jun 2025 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HiXkNKHF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B928137F;
	Wed, 11 Jun 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642697; cv=none; b=gQb9N+8693vCtINt+t5MWuRNCCCMUZ6dc3r+mL7Z9D39YlEeAdSi9EYb3oGR7dB//5QTfoX7D7wZ7V1Z4S/cEXTqB/T793ERlhBYTED7roAK6iovXkNtQ9nF41a3WVaA1hMz9OT9S+cIgP/j2+CNvy9ksk+RQd4zX7mEax0tMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642697; c=relaxed/simple;
	bh=BSC50lpOoivkPaSGDcRFpttANVcJB79MBZ+dGAFt0ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX9sUx+iOG+hj64V54JcSiK+zA6KuNWpMEcIPpeR/oi1rnCL0G9z67uE5Lms4dKE5OWjJ6yVVOHwPkJR8G+cO+zShKMkkbFh1+klvaK3Cr2y4mW4xnITWibOeDhJj0PVFZJhlewocz4KhFygmgVBxgRRvluTDZRymT5JUNkEjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HiXkNKHF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B98djS022979;
	Wed, 11 Jun 2025 07:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Nl7Zj
	7KlAymin2lS04APH45xJsc/4n4nxMF1siEwbEw=; b=HiXkNKHFP+9NaabyHmybE
	5ExXgbf3kO6o6h7W+GbQgoaD6G7oqUEC7QUHfEThuiSiSeoZ9BrK2LjwfSP0a3XJ
	HO2g27FowDpKhxEjcnrFWA/cJqc+JdcnoyfYBnjmSkqQvbtyG35gnzGV51J2G64f
	MhNXtyWeczrKdmJYf8WLxoh+glcRRhRHQbObCLDxchYNqV57p/Jtu0YGcc8TqFy8
	lvdZWCJe4y+/8GA8XDAtKF2Oqa7WRpqBw5Rr1gGULDWGAOkFzK98HF50eteTD9s3
	xsSrXSz/K2LV4cxaG6DOq4QhgzWU5yWwfQPz1hLvAcYZGl+WjpWcEr5bM4mPysnC
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476n67xt1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 07:51:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55BBpSXj031642
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Jun 2025 07:51:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:51:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:51:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 07:51:27 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55BBpBHO008931;
	Wed, 11 Jun 2025 07:51:14 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v11 07/11] iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
Date: Wed, 11 Jun 2025 08:51:11 -0300
Message-ID: <08780fd4a59885f1f250759ce655420bd1dbb383.1749569957.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749569957.git.Jonathan.Santos@analog.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: o_U40BAKhVu7y9glFa3yGf5cGZnan1H8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwMSBTYWx0ZWRfX1EtkMvCxJTQb
 C4jjQSCpFk5yoIXjofnVLZz7bAKO+z5eZKCGVXwoJVUaspojm4Qnoy34B/uKRJqOi5PhmRcoitZ
 NxDtp/24KgFCGo44AwsRb8XN1uZVNKYgMP1P0tJENpKi79hQIob2GHQfYX45J3o74rMUi0NNqOG
 PEUqZqDT+QegV4PdP1ODKhg87kRYDgE2iHfODatZdz6UpbTh2PtppCilTSkc1hjO4lkyqISnRan
 h8g5umKxGbixGcnvDQnAMtjqrx2wW1pAxi7++y5ZbWU6xpipSbJKUM5B0uErCOzpTUB0DM3ECaQ
 TZooPiBbN8rghHWlqyxc1azUcu2Io81dpE0ma2V8sNlO8gx7gbTgc7MSoGCciQufnaj+BqKblYL
 V6+bb/cT5eOtmeBG2nMQh3XTHVGE12FiCwheYDAYBNVjuUAwoCmU9895haOyUayMjAlcL6lM
X-Proofpoint-ORIG-GUID: o_U40BAKhVu7y9glFa3yGf5cGZnan1H8
X-Authority-Analysis: v=2.4 cv=a/gw9VSF c=1 sm=1 tr=0 ts=68496dc1 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=uM-NTnSxQ297Tim-omgA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110101

When the device is configured to decimation x8, only possible in the
sinc5 filter, output data is reduced to 16 bits in order to support
1 MHz of sampling frequency due to clock limitation.

Use multiple scan types feature to enable the driver to switch
scan type at runtime, making it possible to support both 24-bit and
16-bit resolution.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v11 Changes:
* Typo in the commit message: "16-bits" -> "16 bits".

v10 Changes:
* None.

v9 Changes:
* Addressed indentation issue.

v8 Changes:
* Fixed typo in David's Email.
* Removed TODO comment related to the spi_bpw_to_bytes() function.

v7 Changes:
* Added TODO comment to use spi_bpw_to_bytes() helper function.
* Minor commit description changes.

v6 Changes:
* None.

v5 Changes:
* None.

v4 Changes:
* None.

v3 Changes:
* Decreased storagebits to 16 for AD7768_SCAN_TYPE_HIGH_SPEED
  scan type.

v2 Changes:
* Included the ".shift" value back to scan_type.
* Changed the number of bytes from regmap_read instead of shifting the
  ADC sample value when the word size is lower (16-bits).
---
 drivers/iio/adc/ad7768-1.c | 74 ++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 6efecb0e88b6..55913763313d 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -140,6 +140,15 @@ struct ad7768_clk_configuration {
 	enum ad7768_pwrmode pwrmode;
 };
 
+enum ad7768_scan_type {
+	AD7768_SCAN_TYPE_NORMAL,
+	AD7768_SCAN_TYPE_HIGH_SPEED,
+};
+
+static const int ad7768_mclk_div_rates[] = {
+	16, 8, 4, 2,
+};
+
 static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
@@ -154,6 +163,22 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
 };
 
+static const struct iio_scan_type ad7768_scan_type[] = {
+	[AD7768_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_BE,
+	},
+};
+
 static const struct iio_chan_spec ad7768_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -163,13 +188,9 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 24,
-			.storagebits = 32,
-			.shift = 8,
-			.endianness = IIO_BE,
-		},
+		.has_ext_scan_type = 1,
+		.ext_scan_type = ad7768_scan_type,
+		.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),
 	},
 };
 
@@ -182,6 +203,7 @@ struct ad7768_state {
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
 	unsigned int mclk_freq;
+	unsigned int dec_rate;
 	unsigned int samp_freq;
 	struct completion completion;
 	struct iio_trigger *trig;
@@ -319,6 +341,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * When the decimation rate is set to x8, the ADC data precision is
+	 * reduced from 24 bits to 16 bits. Since the AD7768_REG_ADC_DATA
+	 * register provides 24-bit data, the precision is reduced by
+	 * right-shifting the read value by 8 bits.
+	 */
+	if (st->dec_rate == 8)
+		readval >>= 8;
+
 	/*
 	 * Any SPI configuration of the AD7768-1 can only be
 	 * performed in continuous conversion mode.
@@ -532,6 +563,8 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	if (ret < 0)
 		return ret;
 
+	st->dec_rate = ad7768_clk_config[idx].clk_div /
+		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
 	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
 					  ad7768_clk_config[idx].clk_div);
 
@@ -565,8 +598,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int scale_uv, ret;
 
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
@@ -577,7 +615,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
-		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
+		*val = sign_extend32(ret, scan_type->realbits - 1);
 
 		return IIO_VAL_INT;
 
@@ -587,7 +625,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return scale_uv;
 
 		*val = (scale_uv * 2) / 1000;
-		*val2 = chan->scan_type.realbits;
+		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -631,11 +669,21 @@ static const struct attribute_group ad7768_group = {
 	.attrs = ad7768_attributes,
 };
 
+static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	return st->dec_rate == 8 ?
+	       AD7768_SCAN_TYPE_HIGH_SPEED : AD7768_SCAN_TYPE_NORMAL;
+}
+
 static const struct iio_info ad7768_info = {
 	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
 	.write_raw = &ad7768_write_raw,
 	.read_label = ad7768_read_label,
+	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
@@ -690,9 +738,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int ret;
 
-	ret = spi_read(st->spi, &st->data.scan.chan, 3);
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		goto out;
+
+	ret = spi_read(st->spi, &st->data.scan.chan,
+		       BITS_TO_BYTES(scan_type->realbits));
 	if (ret < 0)
 		goto out;
 
-- 
2.34.1


