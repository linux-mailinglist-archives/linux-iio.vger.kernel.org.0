Return-Path: <linux-iio+bounces-27777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA48D1EEA0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C6230954C1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14860396D1E;
	Wed, 14 Jan 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XaeCnoDQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427602FBDED;
	Wed, 14 Jan 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394857; cv=none; b=cIlf+JuY6QMN5FmhjMvYzRKiXhiC//r0c2sHleVIn6jaYtKXMuYkvfnh5yxFDzVuB9tK7RBvrGVqKiG0/uRCcjZ1J+KgcGo8DItil+n0QBuccssHgL0h9Ye0LfBlyuSpGTupyqKcizYr+8oO5Vx0tqBp3JZnMUnRh8C9PA+0Jqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394857; c=relaxed/simple;
	bh=N/11nlZzOdockDQaFZW5Rdr4vtB/arlHCIpSQ+MWE78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsWxs+NVFBJEEGQw+H29yhp0NTOPyrzw9oPiddmw6eyK3HBMxl7zDoUn+AngLeUux1OV4R8SreWEiPBk29332UcUYcSBPaM0Djd8Kkim1hGSXXBhKsxFRtJ0nSRl2ujwkjHY1VCO4T+NAzHVRhwBBHHmhnIuH14h3P1ebQ0H6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XaeCnoDQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EC4qjR3765808;
	Wed, 14 Jan 2026 07:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DXV1a
	QaDqn5yaYi4yvFFKZs+mfBl6Wh0rlvHoChQFH8=; b=XaeCnoDQXDMED7nBnRP6/
	rrqpbGtKYFAcv36Z9BfpYA4GIYJfZhbExpTliu4vOfHhgXgdsLdkmGDuBTxoymDX
	AYMW7H+Wd7EHPzHmIb0B4C1INPQjaMfFaTyJfK0zQoUmxWSrdiXNrq3xKWyRc9zS
	BZrPrBL/2ZyKF6MlSUvZU9mYl0qO8rGLCh35MFI1X5czqhKNLGC6eB6d8A9zrAIm
	qYwm1vE3rgdbHWiXj88qzBL4uyjSOoWU0OqIsy1Q+byzR0QqRvTLkdhTGUvphdXV
	SMjLFRSD6bf8dEuuoPfTNLKtkN4ynG1u36XGrN8YK6ZroHjR2DewCPoAzPUFE1FH
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau08gr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:47:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60EClIFN061478
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 07:47:18 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 14 Jan
 2026 07:47:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 07:47:18 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60ECl4E0001737;
	Wed, 14 Jan 2026 07:47:07 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v6 2/5] iio: adc: ad7768-1: introduce chip info for future multidevice support
Date: Wed, 14 Jan 2026 06:26:52 -0300
Message-ID: <1db015b432fc7473c55f888875af30cc6b241405.1768350772.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768350772.git.Jonathan.Santos@analog.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwNiBTYWx0ZWRfX5qzrNf5+n26x
 WhzvJ0o8PECePyRRjyxIevzkN58PZpwvotKDFlw7+WzRtiuw1AdcPs2JaO7sYHJnNcq0Ez/zEue
 8TaCIR3gFYHlPvBm6qiMXKxF64UzrYWRclEYUpEbYYj3mRCfrbz5KDcpkbRPL1Z8q0kJTug6smT
 pnHeCWW2ndC66zd3FXxY9lC9iog7oBOjCrEIw4FcVkd6KsbuVfRNLGRW1IEwbcxAcMCO5TRtNxX
 XP15nte9/TLfHaRZukEae4vcdacL+uSNpBdZ/gOBHqasprp3GZtSnRc0a8siVPpP90ZgnvnBiXq
 ClVC9xBZ+++epm2QAZM6DTwQUH86GYl9o3jeS9HEvYe2nppaDhEhkCl82ctkcECuwFWwNu8eBRS
 LWBRZiUOsVXxyxRGfb6sXO5KgL/qGCBKJoQzzSd/TtTDFR75l1w/LS67HXT1KcVcsRifp2OQ94x
 W+SDsD4RlPoJr3VjZlA==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=69679057 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=52dTr-yYBLopz0kQKhgA:9
X-Proofpoint-ORIG-GUID: jrSIeQ56iXocgoz_faa7I8-x2dd1RgRq
X-Proofpoint-GUID: jrSIeQ56iXocgoz_faa7I8-x2dd1RgRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140106

Add Chip info struct in SPI device to store channel information for
each supported part.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v6 Changes:
* None.

v5 Changes:
* None.

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


