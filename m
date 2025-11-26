Return-Path: <linux-iio+bounces-26501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA19C8C1FD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 954FC35088F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266AF334C17;
	Wed, 26 Nov 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CZmBPXac"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2C2DC35C;
	Wed, 26 Nov 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194191; cv=none; b=dKFgLePzy3UYU6H0Slno67rioDngIXcXKUmwaTG+ZiVew8QlTjRwZezmlcEMuaN6O2AcTUPw9htgbTsRDuxuj9d/A4apf3pRTSj/YvkLtxRDGNJb/twezaT4OzN+wk+72ssnwIoo3Wk8zOpw2MBZio4LB3ieh8AFACYZKhk9gq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194191; c=relaxed/simple;
	bh=LgHk61xe55fJJxUBDrmTC4BmteIRUDhdYfYBROiGhhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRxIYe23F26soYqMJGZHljKV2dfwUW9Ovnp75BKe2Pv0WGeYDd3Cvnu7sXk/vXCHggc/HkwZmj7jxiN56mDF+NCeb6pgR56+rma/UFza5aGiWYWnGO5wDmaScc85aZeoINFvq5vaku8LJ7g1M0+p4uomeuAPxUjxZA+rwYz7Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CZmBPXac; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQHck1u3402619;
	Wed, 26 Nov 2025 16:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ycdb7
	CnbScFsGuAoIASyU7Rt62Ua/O31gENRYBBojMg=; b=CZmBPXacl8zSXLubtqARh
	RPEqTc0Tu+b6OfY13QJCExQ0afpVVPqTkvgQTExN8m8HaBiOm0erdeOjqBXc0JHE
	12lB3ZkN/YaeQcqxbuKK75DXXza2E4KcxNDauRf22ShHZw3zuzr9Jk2O8y4oD6Ze
	1Up3Mx7WUSGQgbvVZSO4dPc9FQeoQipQJb0hdMmD0t9EJq5aJRrrHSWmjYdnH/GA
	jv3tpW64ERdwNVmptoz6xKR6D13QHTMR5xv4DzNspXqQiie90CAhpbYM0rjeoGS6
	EcLR2VYN6KGefKxoenG8tL4AIn1u07klVVWNwzwpSdVqd2BqXNMzy4I3BVNJpUxD
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4anmrux8y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:56:26 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AQLuPEH024341
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Nov 2025 16:56:25 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 26 Nov 2025 16:56:25 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 26 Nov 2025 16:56:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 26 Nov 2025 16:56:24 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AQLuDBa002847;
	Wed, 26 Nov 2025 16:56:16 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt@analog.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 2/4] iio: adc: ad7768-1: introduce chip info for future multidevice support
Date: Wed, 26 Nov 2025 18:56:13 -0300
Message-ID: <f5d1f8492aabfe968679708b1115aed02f717d39.1764101647.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1764101647.git.Jonathan.Santos@analog.com>
References: <cover.1764101647.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE3OCBTYWx0ZWRfX2+Jn0/cAKU3a
 ckhgrhSpMtjVqmqrnviwBkPszFT+9YY3DFMhodTi6Q2+52LLB314hoYYBlRyYbp76MqmQE7djaW
 tRffDmFlpmrkIYHu5dLDKHfx1pmGLGLaudXVpVd7dtHlHEiWyMoGtqFih87JTnYOWKb4mn98AOR
 WFKHe6CGFMxKGQ4TP+ygakT8WxOkDYSE2nu4XEsYeuyCeYJ1adzKebxBiELrB9/barsCvXuQxzN
 4P3SveuaXN4MzRzdJCv8VdtyRblov9UzQrGrxPY0u2LFtROkWz5Zm2aWnkBDZ4Ew/2RqEpq8hyU
 TaPeJq3IL5hvu5VEy8F8XfObKnEeGk8o8bqT5LsWGBLezxRWYAIJwuKIuPy9h1SJx1a8824greg
 5GuBVHqIRpSoAm9GLEi99WAiBBNMvg==
X-Proofpoint-GUID: i2cVzmOJRyoS5KhzcTEsHTTjLF6uOmvh
X-Authority-Analysis: v=2.4 cv=Qehrf8bv c=1 sm=1 tr=0 ts=6927778a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=52dTr-yYBLopz0kQKhgA:9
X-Proofpoint-ORIG-GUID: i2cVzmOJRyoS5KhzcTEsHTTjLF6uOmvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260178

Add Chip info struct in SPI device to store channel information for
each supported part.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* Dropped chip info check and moved the st->chip assignment early in the
  probe function.
* Addressed indentation inconsistencies in AD7768_CHAN macro.

v3 Changes:
* ad7768_channel_masks removed along with available_masks element in
  ad7768_chip_info struct. It does not add anything for single channels,
  so not needed, at least for now.
* fixed inconsistency in spaces before \ in AD7768_CHAN macro.

v2 Changes:
* removed AD7768_CHAN_INFO_NONE macro.
* reordered fields in ad7768_chip_info struct.
* removed trailing comma.
---
 drivers/iio/adc/ad7768-1.c | 64 ++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index d96802b7847a..89b0ca8f584c 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -213,6 +213,12 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 	},
 };
 
+struct ad7768_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channel_spec;
+	int num_channels;
+};
+
 struct ad7768_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -234,6 +240,7 @@ struct ad7768_state {
 	struct gpio_desc *gpio_reset;
 	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
+	const struct ad7768_chip_info *chip;
 	bool en_spi_sync;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -748,24 +755,28 @@ static const struct iio_chan_spec_ext_info ad7768_ext_info[] = {
 	{ }
 };
 
+#define AD7768_CHAN(_idx, _msk_avail) \
+{ \
+	.type = IIO_VOLTAGE, \
+	.info_mask_separate_available = _msk_avail, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+				    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.ext_info = ad7768_ext_info, \
+	.indexed = 1, \
+	.channel = _idx, \
+	.scan_index = _idx, \
+	.has_ext_scan_type = 1, \
+	.ext_scan_type = ad7768_scan_type, \
+	.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type), \
+}
+
 static const struct iio_chan_spec ad7768_channels[] = {
-	{
-		.type = IIO_VOLTAGE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
-					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
-					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.ext_info = ad7768_ext_info,
-		.indexed = 1,
-		.channel = 0,
-		.scan_index = 0,
-		.has_ext_scan_type = 1,
-		.ext_scan_type = ad7768_scan_type,
-		.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),
-	},
+	AD7768_CHAN(0, 0),
 };
 
 static int ad7768_read_raw(struct iio_dev *indio_dev,
@@ -1321,6 +1332,12 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
 	return 0;
 }
 
+static const struct ad7768_chip_info ad7768_chip_info = {
+	.name = "ad7768-1",
+	.channel_spec = ad7768_channels,
+	.num_channels = ARRAY_SIZE(ad7768_channels),
+};
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -1347,6 +1364,7 @@ static int ad7768_probe(struct spi_device *spi)
 			return ret;
 	}
 
+	st->chip = spi_get_device_match_data(spi);
 	st->spi = spi;
 
 	st->regmap = devm_regmap_init_spi(spi, &ad7768_regmap_config);
@@ -1371,9 +1389,9 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->mclk_freq = clk_get_rate(st->mclk);
 
-	indio_dev->channels = ad7768_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->channels = st->chip->channel_spec;
+	indio_dev->num_channels = st->chip->num_channels;
+	indio_dev->name = st->chip->name;
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -1390,7 +1408,7 @@ static int ad7768_probe(struct spi_device *spi)
 
 	init_completion(&st->completion);
 
-	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
+	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
 		return ret;
 
@@ -1409,13 +1427,13 @@ static int ad7768_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7768_id_table[] = {
-	{ "ad7768-1", 0 },
+	{ "ad7768-1", (kernel_ulong_t)&ad7768_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7768_id_table);
 
 static const struct of_device_id ad7768_of_match[] = {
-	{ .compatible = "adi,ad7768-1" },
+	{ .compatible = "adi,ad7768-1", .data = &ad7768_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7768_of_match);
-- 
2.34.1


