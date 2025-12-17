Return-Path: <linux-iio+bounces-27147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42649CC7AAC
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B9CD30024B2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C753570DB;
	Wed, 17 Dec 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UWeTK8GN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713133570C0;
	Wed, 17 Dec 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975405; cv=none; b=fYIO5KGrfBj2wLYrqtUeEB1dG05IvLAI27iSjEmIwkA6MgxsvZG1fcJbDX6ywF/Y56ggsfQKH00OkmSAzEXXJjMKUKQWyUmsZKhkDN/AfYC0ehR485IflcGbJ0Z74p5qirgTmqwBuqVrH5h7AMYqQeDvjLa09NOBAo9cPoqEoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975405; c=relaxed/simple;
	bh=vild5W58wjr/HCfT8ps9jqFvXMpSBWENAZ/uweQR1oY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1b17R+KbNia+6X5c0gTbis7PXL8LiyQ5ONFznKdolQfE7WtJWM1HzgOTlxFZAzEhccS6pN8Y668K3sI0t+JsoeqhdcEVvq3LTjB6R7OlmQcDJV18lz0hgxSdKEZJxeDPbPSuDCfBAXQUIoi3LmPGz7gRkhDQDuD+CIgW3gz8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UWeTK8GN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH9aYvc964276;
	Wed, 17 Dec 2025 07:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iSW5i
	BzcbvE4f9LbdEnCUDs/v16Kg5ijNbbVzyM+mmI=; b=UWeTK8GNxa/ulLn2VQuoZ
	xqaU06VQm38lTRUp83BmvMjf2LhniGalOOjwOeNzAmDso2XIGVIqWsjA9LSqkdwy
	us0+elt1F08W/HOKHxMZWdI5GXjGRUJvo8kISZSAwty2OljIKi9A7/m4RjDYTKkP
	6Oql4EBasYd3Uu8fNCsVxMhlRv1ooag4ZJJxDsQJEPDl2WdC/KhVjswLc/JKDjJ5
	xidqznAMVhYWCAxZ2xAkxvcvrAj3e4sZGEN/N1cJTqSygKl8cQHv/T7CKwmCjQeV
	HHdrKYqeDIglwshL8JgLKaXZcjylKRNT4BvNHuQ7ocvtaIkEGvEYrNDqYKHTLyou
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jt2tn7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:43:07 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCh6Og043084
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:43:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 17 Dec
 2025 07:43:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:43:06 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCgprE015891;
	Wed, 17 Dec 2025 07:42:53 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v5 2/5] iio: adc: ad7768-1: introduce chip info for future multidevice support
Date: Wed, 17 Dec 2025 02:52:35 -0300
Message-ID: <46fea141a6be1adfc30c8fb51eb6e60f6455b9de.1765900411.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1765900411.git.Jonathan.Santos@analog.com>
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hvD1CtfwanUau_q7dqFz0xhrxNekrMjO
X-Authority-Analysis: v=2.4 cv=Ct6ys34D c=1 sm=1 tr=0 ts=6942a55c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=52dTr-yYBLopz0kQKhgA:9
X-Proofpoint-GUID: hvD1CtfwanUau_q7dqFz0xhrxNekrMjO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OCBTYWx0ZWRfXzSbdxNmuWYZu
 BCPQZROenDYid6bqXIdLRvhgfS+ZJvqngsGPHU4/3OtPH+ohHCjGN2gQ3UTz0FNKDh9J5Fia63R
 NDHUSZztHEXihFzm93+Abaxy6q/m+lLaRyxleCG7YP+KmbCJcfq4OIVHGfdHSQBZGWUT9QFUl2O
 Dtl979EnTXFGpZlee7tcRBy0qkRA/Ly5XLFSCmU9p2C93GHc3j4fZisVg6MQ7fRuwlP+RD8c5q0
 4qxZWFITnY+Za+sx/jwJlSffvLeolNDV85dmILIjyDGPhw3VFuUnWyHCUljJ/Lnu37izO3l5pjk
 NWumtznZklDz6W3ygpvq8dO9kSb9vGvM9+kQLhcpDnIjKC7Q1NexZ49+CShd9aMU5lymfavjChR
 YxSRHSJ1jj7FcDas7K9K0m4FfPER6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170098

Add Chip info struct in SPI device to store channel information for
each supported part.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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


