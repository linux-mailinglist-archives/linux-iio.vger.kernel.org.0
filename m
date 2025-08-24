Return-Path: <linux-iio+bounces-23173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D7B32D72
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 06:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D467B2929
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 04:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4181F8F04;
	Sun, 24 Aug 2025 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bw/eLHaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F31F582E;
	Sun, 24 Aug 2025 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756008627; cv=none; b=TjYZ7B39k9H+EH0h1YmlRzGjmJYvd8JZRnnHJh0MzIJ0qDXH3jfzUkH7zW2dmYt+Ci+kV4sseV+8mbKkKRlYS4gYQPyZpriRkEI8f7hPfQH/MCogDhC8VEQQWLkOIMaj/vmzjudnAFXHXJGumk72YxKM0aaD1wFQNX4E3kIKFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756008627; c=relaxed/simple;
	bh=OiAKHF/NT2xal1UYUoRwPnSy2+NIF0fA8iWBrqY9vvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ltK13++LudDgBq633atJ2GEovqOvkjtYuLLVtq/5UuPb9akPB8lVROgRLPvJTGZdd3ob1yrqN+khJvO3G40Al4YU2agvD1pw5nC7t6VpmbqgPLCIhXyIb/zPriENRnDYnwAobHnUq0/g2WG2AbU+GQZt05l07BrvY2xXKA5XX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bw/eLHaq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57NNENDN011106;
	Sun, 24 Aug 2025 00:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=YvIgFZ5zi1Kf2uEbpiBVR/uG4PT
	YylZ/4OKQsBMinpc=; b=bw/eLHaqr6/bB8b3iYC4dHB05QnwXK8iKOuihSNE1S1
	ZHH/95tw+ZG6ly40cSCZPfEyFWJGf9HbAVl2/Et9vjzFlXIupJyAQ+o3ERlNA8Mw
	VoRpC0MIN9ug9i2dOsKA8b+wTM1/QQaThJaEXLWEohqqUcsR/qx8X/CF5we1OTut
	h3afx2TdOLB9LOb8Kf2cqQt3fGWddlVctC5+u6mtAkI7rbGciKAlodjNt1bD4OX9
	JrBmx+BACZ/GgxihbnGsTuPHm7zKPALgG6Piunnr+yBaCWZLxmdlnZkuCLmql+dh
	iPU3Xg4K4EG5i4XTNm1irHvhyO456U7Haeg6g11dauA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48qaj2aw56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Aug 2025 00:10:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57O4A8KY043526
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Aug 2025 00:10:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 24 Aug
 2025 00:10:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 24 Aug 2025 00:10:07 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57O49stJ006320;
	Sun, 24 Aug 2025 00:09:56 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/4] iio: adc: ad7768-1: introduce chip info for future multidevice support
Date: Sun, 24 Aug 2025 01:09:53 -0300
Message-ID: <20250824040953.9547-1-Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA4NSBTYWx0ZWRfX65RZqDLkAA7i
 JMKQpz2PVk6PRPMmqMewxjcsfCdZ7VfVqoCNC1lNWA7NHsV2hwdChVdsitpJqLk+APXs3J8sI67
 1wfMuXvUkr/qHcP4GYpkvXFd9XGq3y1J13Hqc9pQg2Iui0oD2EbWZW87TDEXOfcL7e1VTAQRZ8p
 ZC46tpzGqi3G/xNy1buLoBSNGE0UfCVoMISrF50mhHlO2Caxoz2AjrcWhMVwX/3h82YHxQ/sCH0
 8dXwPWA21XP5tNh7pIDkxeB0F4zddK4TX8FSgx3uKJoWk7LasEPoP9CMC/0WQqVd8ZKRkYpreHf
 t0Jx/34U/Opy9Tbyh3+NZiZUgWMOTMvxgvPM05AM6gIGo3iC54JZ6VOZOCT/XNy/rPwNHS9d8So
 tIpdW2Yt
X-Proofpoint-GUID: khYrClNM7sa28JQ2IWGOWlyoga-NYy2Y
X-Proofpoint-ORIG-GUID: khYrClNM7sa28JQ2IWGOWlyoga-NYy2Y
X-Authority-Analysis: v=2.4 cv=UITdHDfy c=1 sm=1 tr=0 ts=68aa90a1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=PeubA13TOwIOKtPvs58A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230085

Add Chip info struct in SPI device to store channel information for
each supported part.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* removed AD7768_CHAN_INFO_NONE macro.
* reordered fields in ad7768_chip_info struct.
* removed trailing comma.
---
 drivers/iio/adc/ad7768-1.c | 75 ++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index a2e061f0cb08..83b0907b068d 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -213,6 +213,13 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 	},
 };
 
+struct ad7768_chip_info {
+	const char *name;
+	const unsigned long *available_masks;
+	const struct iio_chan_spec *channel_spec;
+	int num_channels;
+};
+
 struct ad7768_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -234,6 +241,7 @@ struct ad7768_state {
 	struct gpio_desc *gpio_reset;
 	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
+	const struct ad7768_chip_info *chip;
 	bool en_spi_sync;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -750,24 +758,27 @@ static const struct iio_chan_spec_ext_info ad7768_ext_info[] = {
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
+	AD7768_CHAN(0, 0),
 };
 
 static int ad7768_read_raw(struct iio_dev *indio_dev,
@@ -1334,6 +1345,18 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
 	return 0;
 }
 
+static const unsigned long ad7768_channel_masks[] = {
+	BIT(0),
+	0
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
@@ -1392,9 +1415,15 @@ static int ad7768_probe(struct spi_device *spi)
 
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
 
@@ -1411,7 +1440,7 @@ static int ad7768_probe(struct spi_device *spi)
 
 	init_completion(&st->completion);
 
-	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
+	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
 		return ret;
 
@@ -1430,13 +1459,13 @@ static int ad7768_probe(struct spi_device *spi)
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


