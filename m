Return-Path: <linux-iio+bounces-22640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0764B23E7D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 04:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C681F3B7E75
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB7271450;
	Wed, 13 Aug 2025 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qXYDMw30"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D8271444;
	Wed, 13 Aug 2025 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053356; cv=none; b=HWHHQAbi9QeNU3sukpSimVWAIzR7sAXUEkkgeiZROM2LQpBPaMwzBGbfyWhHVcqQzLARVqpIKJURfrMTqSkBzeywZ/Hq55ERxpQLXe4BQjnD5hlDLxQTQ78zDTouko0Q1thvSYRgCQkOar+nhof7lzUCnFtWDTECzd9wmTI7zBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053356; c=relaxed/simple;
	bh=PiycfbDvXE2q6c6Xu8oqwc2HiG9XPuKyK7EQkmf6b+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSORXSmP7XfS4dv1ooFC65zhTT7LiCfVS2axi6drvYLmZjosU9h6GZ6O5xTwRe/VGvQwmsdIR04D/nrYisvINTxlQDw1AXsV6f1TO9iAdIbMWLlWTeSvXgrl3YQL67Jwztgd9DVH4bW7DQloGg/gf3hDTJllvRAJwUeE9wpC84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qXYDMw30; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CN1Spn001672;
	Tue, 12 Aug 2025 22:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nPuLQ
	8wJsWv4ympiHFG8doyFqmgI7CLStiovvpHpdUY=; b=qXYDMw30HKAscuPLNRrKV
	WRBdP7AjGcRFeRx6QdrQc2X5o8R67f2gzdSUc+mLOJhHj9ZiERC6piOfRsjepyM+
	JyaosOQQEG2nxkNSvokh7qJzoeuVcwqOR6kvutI7ajEYXyRweoj6Tjc/YLfLkAl9
	hifVCwngoFWpQs6LrUnYNDgTIlaUkrcp3fZy1Nv/HbImP5rXVQsmoT/Jix1jx63p
	/0iyV7ZP2sa4rpLF0RavHukleyQNUlwIhKit299hKBBgkberfLJpzV9vsuo+xvE5
	+quurM5UwSTsYCl5NCWeedULcDx+BwR62+8chfLVSWFrRb2GBskH9D4WP4ysXcWD
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48fjxk8943-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 22:49:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57D2n9Zp050841
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Aug 2025 22:49:09 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 22:49:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 22:49:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 22:49:09 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57D2mv12032758;
	Tue, 12 Aug 2025 22:49:00 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH 2/4] iio: adc: ad7768-1: introduce chip info for future multidevice support
Date: Tue, 12 Aug 2025 23:48:57 -0300
Message-ID: <22ea35425827176a842ea0e523040acd20e27bcc.1754617360.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX66EDTM2s7FdN
 Q2IO2Ob2llKYbRmq520BJ4955YjWDQMjDP3oyq0Zfuz9vkthAozjuqNyEPlg5NyFghjj3iiFRKt
 qaT7uJf+0CNGVNUtBkS7QbJQO0MhlfO2y0fMZJl3v4Db3kDCLNux2XKz+bVo9OI2izBo+DrLPvo
 A8XFZquuQaYyiR5t4fh4khub6j3Vc62ZHxSyxvSpdl9+luaBJa/y/shgFJFkVxhlHu/NPVNX00K
 QT/6YUAZBY99+7Wp/pOJkZnK1zVCDIIVMUQESBR/UA9JuDnE9RqcGu9AeoykX174EBJ7WS9VWf9
 o9reUmbhjuf48ZxBbCwKCzuZCAfI1KBZjWPWXJTk3ewlcK7hhzjlwf8wZF2/rOay8WiUDwNbwi/
 v+wlTAvP
X-Proofpoint-ORIG-GUID: Aouw8WZfeAiW5wTkKvrVBJa5pJjVMDor
X-Authority-Analysis: v=2.4 cv=IMMCChvG c=1 sm=1 tr=0 ts=689bfd26 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=PeubA13TOwIOKtPvs58A:9
X-Proofpoint-GUID: Aouw8WZfeAiW5wTkKvrVBJa5pJjVMDor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

Add Chip info struct in SPI device to store channel information for
each supported part.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 76 ++++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index a2e061f0cb08..36ba208fc119 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -106,6 +106,7 @@
 #define AD7768_GPIO_READ_MSK		GENMASK(3, 0)
 
 #define AD7768_VCM_OFF			0x07
+#define AD7768_CHAN_INFO_NONE		0
 
 #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
 
@@ -213,6 +214,13 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 	},
 };
 
+struct ad7768_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channel_spec;
+	const unsigned long *available_masks;
+	int num_channels;
+};
+
 struct ad7768_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -234,6 +242,7 @@ struct ad7768_state {
 	struct gpio_desc *gpio_reset;
 	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
+	const struct ad7768_chip_info *chip;
 	bool en_spi_sync;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -750,24 +759,27 @@ static const struct iio_chan_spec_ext_info ad7768_ext_info[] = {
 	{ }
 };
 
+#define AD7768_CHAN(_idx, _msk_avail) {	\
+	.type = IIO_VOLTAGE,\
+	.info_mask_separate_available = _msk_avail,\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+	.ext_info = ad7768_ext_info,\
+	.indexed = 1,\
+	.channel = _idx,\
+	.scan_index = _idx,\
+	.has_ext_scan_type = 1,\
+	.ext_scan_type = ad7768_scan_type,\
+	.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),\
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
+	AD7768_CHAN(0, AD7768_CHAN_INFO_NONE),
 };
 
 static int ad7768_read_raw(struct iio_dev *indio_dev,
@@ -1334,6 +1346,18 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
 	return 0;
 }
 
+static const unsigned long ad7768_channel_masks[] = {
+	BIT(0),
+	0,
+};
+
+static const struct ad7768_chip_info ad7768_chip_info = {
+	.name = "ad7768-1",
+	.channel_spec = ad7768_channels,
+	.num_channels = ARRAY_SIZE(ad7768_channels),
+	.available_masks = ad7768_channel_masks,
+};
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -1392,9 +1416,15 @@ static int ad7768_probe(struct spi_device *spi)
 
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
+	indio_dev->available_scan_masks = st->chip->available_masks;
+	indio_dev->name = st->chip->name;
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -1411,7 +1441,7 @@ static int ad7768_probe(struct spi_device *spi)
 
 	init_completion(&st->completion);
 
-	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
+	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
 		return ret;
 
@@ -1430,13 +1460,13 @@ static int ad7768_probe(struct spi_device *spi)
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


