Return-Path: <linux-iio+bounces-12947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A99E0465
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E0A2826FD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65A20371B;
	Mon,  2 Dec 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qomyLNB2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E922036E9;
	Mon,  2 Dec 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148514; cv=none; b=lFYh+GmfEV9QIVvmv2P80evao4vaUZifgYe4JHm2fLG+MIPLxefDGHmwAaJybnv++sKHr/u08RuAG6jx7pwf/OZTEr19WitNMluvE6KlNEpzQtV35xrcmT6gjsXUbqt5y2USENCsaUpCcG6rxspm1VDngXNEXQVOkFf/K4Bf9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148514; c=relaxed/simple;
	bh=29wiYghw2GXDqsF6WbKs6EnlCUSgrnWVDiiitj6UvJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuyHR9A97tAjW/CqVn3oRZKNn+L+y273cwXKHORUBcSH52+gWPDRq59iYdFr1cWXSvWEc2Wf9Y13gI8IT9y2JtVKSQ/N9b7BXri3TOoi+T5NQMO2OY3FjlOB2QIv6kttBoyWpLtJOtii8lLxO11okLhW8Lj14RMgBjyxcFxJnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qomyLNB2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2CGruV004517;
	Mon, 2 Dec 2024 09:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=L5U0x
	rMYZ2aLLmgJ6S+BBdmjP/zQo2s1cefRfc8GZig=; b=qomyLNB2vIM68tRqio0/A
	MeisV24wzbpIAvSM11D/UklI5S63DlbCs7WoZ/MawDeXmjNZpaOG50TJgs5c8wBL
	cb+ELt1q2m7u2fRSVgxF39my577bPohpS9OBMTRjZOQd33ETXsYGVAuKHTvFYa1v
	0zkIqPRgjkb8UmYM+qeH5Ila5YbYzYDV6wImtg1Xx039+vX9/D6dcAwQq5PmkzAW
	jLI4WfIzLCFtAWByInB0Rv+CBC1Ru8KqcMJOMJMTiDz65cnMt0V0C8/YiW3tw3+T
	TNQaJR689d0LN+ad2JvIJ++9ePRVAePxxtiJhB595/JiXVwLoznvFkl1AMvqB4RW
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 437we78jqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 09:08:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B2E8DXW006732
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 09:08:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 2 Dec 2024
 09:08:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 2 Dec 2024 09:08:13 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B2E7wHt027774;
	Mon, 2 Dec 2024 09:08:00 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v6 2/4] iio: adc: ad4000: Add timestamp channel
Date: Mon, 2 Dec 2024 11:07:56 -0300
Message-ID: <d1f1bb1b726b90a3a7c1148c65d2f7fe073e2b15.1733147444.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1733147443.git.marcelo.schmitt@analog.com>
References: <cover.1733147443.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JoB6k_CeQOYWU8TYDSGGbkIiSdkslvj2
X-Proofpoint-GUID: JoB6k_CeQOYWU8TYDSGGbkIiSdkslvj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020122

The ADC data is pushed to the IIO buffer along with timestamp but no
timestamp channel was provided to retried the time data.
Add a timestamp channel to provide sample capture time.

Suggested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6
- Added commas at the end of channel lists in macros.

 drivers/iio/adc/ad4000.c | 98 +++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index b3b82535f5c1..e73c285b3438 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -49,6 +49,7 @@
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
 			      BIT(IIO_CHAN_INFO_SCALE),				\
 	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
+	.scan_index = 0,							\
 	.scan_type = {								\
 		.sign = _sign,							\
 		.realbits = _real_bits,						\
@@ -62,6 +63,12 @@
 	__AD4000_DIFF_CHANNEL((_sign), (_real_bits),				\
 				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
 
+#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access)			\
+{										\
+	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access),			\
+	IIO_CHAN_SOFT_TIMESTAMP(1),						\
+}
+
 #define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)\
 {										\
 	.type = IIO_VOLTAGE,							\
@@ -71,6 +78,7 @@
 			      BIT(IIO_CHAN_INFO_SCALE) |			\
 			      BIT(IIO_CHAN_INFO_OFFSET),			\
 	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
+	.scan_index = 0,							\
 	.scan_type = {								\
 		.sign = _sign,							\
 		.realbits = _real_bits,						\
@@ -84,6 +92,12 @@
 	__AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_real_bits),			\
 				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
 
+#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access)		\
+{										\
+	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access),		\
+	IIO_CHAN_SOFT_TIMESTAMP(1),						\
+}
+
 static const char * const ad4000_power_supplies[] = {
 	"vdd", "vio"
 };
@@ -110,106 +124,106 @@ static const int ad4000_gains[] = {
 
 struct ad4000_chip_info {
 	const char *dev_name;
-	struct iio_chan_spec chan_spec;
-	struct iio_chan_spec reg_access_chan_spec;
+	struct iio_chan_spec chan_spec[2];
+	struct iio_chan_spec reg_access_chan_spec[2];
 	bool has_hardware_gain;
 };
 
 static const struct ad4000_chip_info ad4000_chip_info = {
 	.dev_name = "ad4000",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
 };
 
 static const struct ad4000_chip_info ad4001_chip_info = {
 	.dev_name = "ad4001",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
 };
 
 static const struct ad4000_chip_info ad4002_chip_info = {
 	.dev_name = "ad4002",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
 };
 
 static const struct ad4000_chip_info ad4003_chip_info = {
 	.dev_name = "ad4003",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
 };
 
 static const struct ad4000_chip_info ad4004_chip_info = {
 	.dev_name = "ad4004",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
 };
 
 static const struct ad4000_chip_info ad4005_chip_info = {
 	.dev_name = "ad4005",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
 };
 
 static const struct ad4000_chip_info ad4006_chip_info = {
 	.dev_name = "ad4006",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
 };
 
 static const struct ad4000_chip_info ad4007_chip_info = {
 	.dev_name = "ad4007",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
 };
 
 static const struct ad4000_chip_info ad4008_chip_info = {
 	.dev_name = "ad4008",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
 };
 
 static const struct ad4000_chip_info ad4010_chip_info = {
 	.dev_name = "ad4010",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
 };
 
 static const struct ad4000_chip_info ad4011_chip_info = {
 	.dev_name = "ad4011",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
 };
 
 static const struct ad4000_chip_info ad4020_chip_info = {
 	.dev_name = "ad4020",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
 };
 
 static const struct ad4000_chip_info ad4021_chip_info = {
 	.dev_name = "ad4021",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
 };
 
 static const struct ad4000_chip_info ad4022_chip_info = {
 	.dev_name = "ad4022",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
 };
 
 static const struct ad4000_chip_info adaq4001_chip_info = {
 	.dev_name = "adaq4001",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
 	.has_hardware_gain = true,
 };
 
 static const struct ad4000_chip_info adaq4003_chip_info = {
 	.dev_name = "adaq4003",
-	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
 	.has_hardware_gain = true,
 };
 
@@ -591,7 +605,7 @@ static int ad4000_probe(struct spi_device *spi)
 	switch (st->sdi_pin) {
 	case AD4000_SDI_MOSI:
 		indio_dev->info = &ad4000_reg_access_info;
-		indio_dev->channels = &chip->reg_access_chan_spec;
+		indio_dev->channels = chip->reg_access_chan_spec;
 
 		/*
 		 * In "3-wire mode", the ADC SDI line must be kept high when
@@ -603,7 +617,7 @@ static int ad4000_probe(struct spi_device *spi)
 		if (ret < 0)
 			return ret;
 
-		ret = ad4000_prepare_3wire_mode_message(st, indio_dev->channels);
+		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
 		if (ret)
 			return ret;
 
@@ -614,16 +628,16 @@ static int ad4000_probe(struct spi_device *spi)
 		break;
 	case AD4000_SDI_VIO:
 		indio_dev->info = &ad4000_info;
-		indio_dev->channels = &chip->chan_spec;
-		ret = ad4000_prepare_3wire_mode_message(st, indio_dev->channels);
+		indio_dev->channels = chip->chan_spec;
+		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
 		if (ret)
 			return ret;
 
 		break;
 	case AD4000_SDI_CS:
 		indio_dev->info = &ad4000_info;
-		indio_dev->channels = &chip->chan_spec;
-		ret = ad4000_prepare_4wire_mode_message(st, indio_dev->channels);
+		indio_dev->channels = chip->chan_spec;
+		ret = ad4000_prepare_4wire_mode_message(st, &indio_dev->channels[0]);
 		if (ret)
 			return ret;
 
@@ -637,7 +651,7 @@ static int ad4000_probe(struct spi_device *spi)
 	}
 
 	indio_dev->name = chip->dev_name;
-	indio_dev->num_channels = 1;
+	indio_dev->num_channels = 2;
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
@@ -658,7 +672,7 @@ static int ad4000_probe(struct spi_device *spi)
 		}
 	}
 
-	ad4000_fill_scale_tbl(st, indio_dev->channels);
+	ad4000_fill_scale_tbl(st, &indio_dev->channels[0]);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
-- 
2.45.2


