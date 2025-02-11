Return-Path: <linux-iio+bounces-15386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C489A319DE
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6AE168AD8
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD226F451;
	Tue, 11 Feb 2025 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1DExiZtz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A426A1B3;
	Tue, 11 Feb 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317766; cv=none; b=FJ8Y4QI50k9mKF4pMD3GMV8of6FHTe7hvDNTja6rDjuwdhzxKd5EdXEmj78CarLIWs67XaS68J4F05GQHSh+I8SapBq46Y++KixsGHRbr8M3nCrQ6kC/lDT1w1YWimhGAn2O3KZH6OJ4JDR9XB/JBbfitXZi9bGjSPs/0yQSFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317766; c=relaxed/simple;
	bh=6XjjrkoK4seWUs+a4YN+65OmE27zQAzS1qENkQdQ+JM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqpYeK0NlNKuz52/lbJCrU7IhE5IM0ZaZ+nWSQ0+RILm1pQWy1zTxy0fObZbVSj3fde062JfzGDXALgCQdgXhB8Y4J0vSX96KjfUwY/rhBHi9oLMbwCPaIwhdpTfzIp3935/Xp53aySW4WdiMVvtmVWlT4nbIRRT5F+LOMyxYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1DExiZtz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJP6Vx002767;
	Tue, 11 Feb 2025 18:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=fp5Rd9FGEylYNdr7+N2aMmL8xYJ
	ndXuvF6ApZUEzOCU=; b=1DExiZtzc8qY2PdxUks6F+83qXfEYTCPLEo09AqpCes
	Kkmvb+ymbqfg4viIdbf2xwADFuyGuMwcFLAch96c7/l4dHqnHv5W+udSbAhk7Dws
	RwuHDnLzTfOiaUz0GPchLbXHHRZaftTfcDfvNzE1tpXSlAyDVUH0w3XCjiq5jLpj
	q/IKbkbeSmLdIgaI41wGXfRCjp5lENr34p4lgmONkHNJtqXqlBnWgTikKQwWB3qK
	m2/T8Gq7xYWAtcc2Tje989V2PnNjjN9ubeRcGj+vT+Rdgfvt5f+pemPP/O2WHlwW
	A+Es0SK8pn92zIN3cbMfz7pgE9miV3eNGfFKXKOdG3A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44r857j5xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:49:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNn9oo017170
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:49:09 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:49:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:49:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:49:07 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNmsw2009921;
	Tue, 11 Feb 2025 18:48:57 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 13/17] iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
Date: Tue, 11 Feb 2025 20:48:54 -0300
Message-ID: <20250211234854.1009053-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: OM7DrV1xO1zTjD9bu0fTy4GUgEc00LAQ
X-Proofpoint-ORIG-GUID: OM7DrV1xO1zTjD9bu0fTy4GUgEc00LAQ
X-Authority-Analysis: v=2.4 cv=U5VoDfru c=1 sm=1 tr=0 ts=67abe1f6 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=TVenB2Com6UDTqQwcj8A:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

When the device is configured to Sinc5 filter and decimation x8,
output data is reduced to 16-bits in order to support 1 MHz of
sampling frequency due to clock limitation.

Use multiple scan types feature to enable the driver to switch
scan type in runtime, making possible to support both 24-bit and
16-bit resolution.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
index afcc8678cf83..c16149b395af 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,6 +142,15 @@ struct ad7768_clk_configuration {
 	enum ad7768_pwrmode pwrmode;
 };
 
+enum ad7768_scan_type {
+	AD7768_SCAN_TYPE_NORMAL,
+	AD7768_SCAN_TYPE_HIGH_SPEED,
+};
+
+static const int ad7768_mclk_div_rates[4] = {
+	16, 8, 4, 2,
+};
+
 static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
@@ -156,6 +165,22 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
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
@@ -165,13 +190,9 @@ static const struct iio_chan_spec ad7768_channels[] = {
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
 
@@ -184,6 +205,7 @@ struct ad7768_state {
 	struct clk *mclk;
 	struct gpio_chip gpiochip;
 	unsigned int mclk_freq;
+	unsigned int dec_rate;
 	unsigned int samp_freq;
 	struct completion completion;
 	struct iio_trigger *trig;
@@ -296,6 +318,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
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
@@ -514,6 +545,8 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	if (ret < 0)
 		return ret;
 
+	st->dec_rate = ad7768_clk_config[idx].clk_div /
+		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
 	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
 					  ad7768_clk_config[idx].clk_div);
 
@@ -547,8 +580,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
 		ret = iio_device_claim_direct_mode(indio_dev);
@@ -557,7 +595,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 		ret = ad7768_scan_direct(indio_dev);
 		if (ret >= 0)
-			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
+			*val = sign_extend32(ret, scan_type->realbits - 1);
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
@@ -571,7 +609,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return scale_uv;
 
 		*val = (scale_uv * 2) / 1000;
-		*val2 = chan->scan_type.realbits;
+		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -615,11 +653,21 @@ static const struct attribute_group ad7768_group = {
 	.attrs = ad7768_attributes,
 };
 
+static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
+		AD7768_SCAN_TYPE_NORMAL;
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
 
@@ -674,9 +722,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int ret;
 
-	ret = spi_read(st->spi, &st->data.scan.chan, 3);
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	ret = spi_read(st->spi, &st->data.scan.chan,
+		       BITS_TO_BYTES(scan_type->realbits));
 	if (ret < 0)
 		goto out;
 
-- 
2.34.1


