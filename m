Return-Path: <linux-iio+bounces-23785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50DB45D19
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE5218861AF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290931D756;
	Fri,  5 Sep 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KG6T35Cm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6031D745;
	Fri,  5 Sep 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087622; cv=none; b=k7rn+Uc1YO+E/WDaIBz1z6CdE+YZZDTPNsEp+WYe0RVAU9081N4BGL8tNUDukbJn1O25FVZwjS4cCNOsf0dBylYnPbFu0qduRFZKwN8awXZP/BvAe+BiXm1O2UG2Rqkt74CF8PIqLTgmxEW2uW/XPrKoidCt0EQZNqPIa5R090c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087622; c=relaxed/simple;
	bh=TLKT09BjzvRCZufRPTQtZCqvV5dph92aNE6SkMjUpYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+Xxm6NR6VklUewB3VLuF7NSAFSDFxwwSK4H2Tl98Qt2JvRaYOjGZMKyw9zIlyMK+3vTER+SgkGg/E1zeEfPQZimyuXEC5JjEpHr5Go0kK9+aG2z8/fxS4xAgpzq2FVqbaRmQPnUjsgiuuEEtKlBy/J+0V/jgNSgHlYK3kP6BW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KG6T35Cm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585EFTmL031284;
	Fri, 5 Sep 2025 11:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3h+nn
	te5McwUB6UGC/KpMo1eWY5+TS6RUVTAz7oMKAo=; b=KG6T35CmSyvkFFiIvEf3h
	PkIkTfMCvdq2UuaQajmh6HfIq8AZCj7NfR1ut6XucsM3k8FeDJxjwAgmv92UBpdv
	4mxq5QGwHeGFGr7LCooHMShfYOryn3n3C5JJDuwhczULQgT229/Hvw/Q7XiaIBiu
	avM4BWd5axKce7A/utpWN07oxJY+Wo+67aRSflx8yUB3l8tzxuXboRz1IT4ZyPUr
	46nVdYgS1haaW4BvTAHWHh0Uc8BYwNjqC7Fsf3uO5LUJXJY+oJbaHfomawaPfr8O
	WebDHsATZHyWSK9mkbcYwSMBVvA0wzxs4LJefGb6MUgIwXtICWOQTQJddZT6lrMs
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48ypq4up9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 11:53:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 585FrOj3053263
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Sep 2025 11:53:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 5 Sep 2025 11:53:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 5 Sep 2025 11:53:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Sep 2025 11:53:24 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 585FrA5D020484;
	Fri, 5 Sep 2025 11:53:13 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <jonath4nns@gmail.com>
Subject: [PATCH v3 2/4] iio: adc: ad7768-1: introduce chip info for future multidevice support
Date: Fri, 5 Sep 2025 06:49:21 -0300
Message-ID: <098a8b2556ea95fdce5f81cbac98983f91ca1a9d.1757001160.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757001160.git.Jonathan.Santos@analog.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ZgnJVHFKKNt9ri1eskqsGkNg_7a3sNy0
X-Proofpoint-GUID: ZgnJVHFKKNt9ri1eskqsGkNg_7a3sNy0
X-Authority-Analysis: v=2.4 cv=LrKSymdc c=1 sm=1 tr=0 ts=68bb0775 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=sPhFOdlt40sM3mM_3ZMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDAxNiBTYWx0ZWRfX7F93Xh3NeXNz
 NOYvvOs/wv4lswkDbSiGGyT9Qp4TBfWtltgHkubJJ45d1rlAiEk+Gd47DJMoWK7k70Z398Z/gQf
 ljvyisR1iNUUlPgPH3cjly737Q3FEdWMqivO3YAzHguMVSdBvOVSWWCd3fGrHpxf87Y9b8KeiKP
 J8em9w3PIy4Y2ZOBlpKOaMcMNUD5n+LlwoEf83OlsKkjuHj14TCZ2QLHnCkCnFz/M8uM1XgItCP
 bIpHx3VxjszVuIEeLR2PA7I75XLWTB6G8S35+qn3IvjWTu479pAnjFcoO7TSx2jACv3o47e1AyZ
 v+CencsMUqh6sagvrWEu1Qg1mCroW5VmpxufbFctlkhzb/TC0vPkfhhYslBcDitZ/VOVhFZvF6l
 9C7Xr34j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509050016

Add Chip info struct in SPI device to store channel information for
each supported part.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
 drivers/iio/adc/ad7768-1.c | 67 +++++++++++++++++++++++++-------------
1 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 872c88d0c86c..000d294c616c 100644
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
@@ -748,24 +755,27 @@ static const struct iio_chan_spec_ext_info ad7768_ext_info[] = {
 	{ }
 };
 
+#define AD7768_CHAN(_idx, _msk_avail) { \
+	.type = IIO_VOLTAGE, \
+	.info_mask_separate_available = _msk_avail, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
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
@@ -1321,6 +1331,12 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
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
@@ -1371,9 +1387,14 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->mclk_freq = clk_get_rate(st->mclk);
 
-	indio_dev->channels = ad7768_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-	indio_dev->name = spi_get_device_id(spi)->name;
+	st->chip = spi_get_device_match_data(spi);
+	if (!st->chip)
+		return dev_err_probe(&spi->dev, -ENODEV,
+				     "Could not find chip info data\n");
+
+	indio_dev->channels = st->chip->channel_spec;
+	indio_dev->num_channels = st->chip->num_channels;
+	indio_dev->name = st->chip->name;
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -1390,7 +1411,7 @@ static int ad7768_probe(struct spi_device *spi)
 
 	init_completion(&st->completion);
 
-	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
+	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
 		return ret;
 
@@ -1409,13 +1430,13 @@ static int ad7768_probe(struct spi_device *spi)
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


