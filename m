Return-Path: <linux-iio+bounces-7784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAF9390C3
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6E31C2133F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308816D4EF;
	Mon, 22 Jul 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="REaeCjLQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570FF9FE;
	Mon, 22 Jul 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659039; cv=none; b=p4nftBm1Uvj5hG88Rn/VXYo6jUvBwnJSk2EVxJBwt0xJZZmgmHvARIsVTwYVNtewSlcXFq2PqiUE2ArYTwe6CduEYMsRTd/YCq7xx7tYewcWW8nOSesmGVsYCKP+Sgj8t6lpMF1JL9gkpGPcyymdo9DVezcgXeoDv7OjANKv/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659039; c=relaxed/simple;
	bh=jFV16UmVCI6fxImUzE1wTiJZxB/8UcM+LYPVCkYuhX4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbGlMNsTUqT7pZY1i7JAU589Mq900bBrOOEnxU9Ib16XpSDaEc0m2kpty8Y2n8EjmAngShzM0mt8KGI6UAYQ2sTETpDfkxl0X8u6EJcpTcTh7Xh2Q+3paZH/T5HBIhVTmA1WBHUcou3KBBbTUeEByAAhd3BKOCSmLgEEsavmf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=REaeCjLQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC4wb5025513;
	Mon, 22 Jul 2024 09:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FB2/W
	eqXqRX1phygT/WXuafr1de4oPqjPnsJDOqdkZ4=; b=REaeCjLQF6BFnLr7YYLM7
	TMnKSBaEn3QycdzBWvRbLbgk+UJBbPKmmFSlWPXTbdUoaWhjgX0mxBErD548m2K0
	TMcU1iadgQIggv9FwtE1am4ASuzEOLmH4Pz5pjgSLVhoPvSvLpnhtsPgVB1CqHWk
	OoPwimqT1WzWnQ4uh3eDVglAt2zeyW4My5e61YAqBBDi7B+mBbZ2eEDB9r0H3W+Y
	lW00CWkKI6jMmY0Mof5nhc7DqOwYjmCT+BJMXKMRsiwDGDhEV/oZJFOSjQy4i/sl
	ovOS3JAJlNuQ5KKbSaxWjES494mcGpYAzhNqaRwlXf3Nn/maDraD2KtzVz2ll1mb
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40hj2b9d74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:45:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46MDja0S025940
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jul 2024 09:45:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 22 Jul 2024 09:45:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 22 Jul 2024 09:45:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 22 Jul 2024 09:45:35 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46MDjH9K016251;
	Mon, 22 Jul 2024 09:45:24 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: frequency: adf4377: add adf4378 support
Date: Mon, 22 Jul 2024 16:45:06 +0300
Message-ID: <20240722134508.25234-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722134508.25234-1-antoniu.miclaus@analog.com>
References: <20240722134508.25234-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tUrVznoMtNlT3vH_U7XWk4k2fRHVSLa3
X-Proofpoint-GUID: tUrVznoMtNlT3vH_U7XWk4k2fRHVSLa3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_09,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220103

Add separate handling for adf4378 within the driver.

The main difference between adf4377 and adf4378 is that adf4378 has only
one output which is handled by only one gpio.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - use chip_info structure to handle new added part (adf4378)
 - use spi_get_device_match_data
 - drop redundant check in if statement.
 drivers/iio/frequency/adf4377.c | 36 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 9284c13f1abb..82374f5d2695 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -400,7 +400,13 @@ enum muxout_select_mode {
 	ADF4377_MUXOUT_HIGH = 0x8,
 };
 
+struct adf4377_chip_info {
+	const char *name;
+	bool has_gpio_enclk2;
+};
+
 struct adf4377_state {
+	const struct adf4377_chip_info	*chip_info;
 	struct spi_device	*spi;
 	struct regmap		*regmap;
 	struct clk		*clkin;
@@ -889,11 +895,13 @@ static int adf4377_properties_parse(struct adf4377_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
 				     "failed to get the CE GPIO\n");
 
-	st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
-						  GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_enclk2))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
-				     "failed to get the CE GPIO\n");
+	if (st->chip_info->has_gpio_enclk2) {
+		st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
+							  GPIOD_OUT_LOW);
+		if (IS_ERR(st->gpio_enclk2))
+			return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
+					"failed to get the CE GPIO\n");
+	}
 
 	ret = device_property_match_property_string(&spi->dev, "adi,muxout-select",
 						    adf4377_muxout_modes,
@@ -921,6 +929,17 @@ static int adf4377_freq_change(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_OK;
 }
 
+static const struct adf4377_chip_info adf4377_chip_info_tbl[] = {
+	{
+		.name = "adf4377",
+		.has_gpio_enclk2 = true,
+	},
+	{
+		.name = "adf4378",
+		.has_gpio_enclk2 = false,
+	},
+};
+
 static int adf4377_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -945,6 +964,7 @@ static int adf4377_probe(struct spi_device *spi)
 
 	st->regmap = regmap;
 	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
 	mutex_init(&st->lock);
 
 	ret = adf4377_properties_parse(st);
@@ -964,13 +984,15 @@ static int adf4377_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adf4377_id[] = {
-	{ "adf4377", 0 },
+	{ "adf4377", (kernel_ulong_t)&adf4377_chip_info_tbl[0] },
+	{ "adf4378", (kernel_ulong_t)&adf4377_chip_info_tbl[1] },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, adf4377_id);
 
 static const struct of_device_id adf4377_of_match[] = {
-	{ .compatible = "adi,adf4377" },
+	{ .compatible = "adi,adf4377", .data = &adf4377_chip_info_tbl[0] },
+	{ .compatible = "adi,adf4378", .data = &adf4377_chip_info_tbl[1]},
 	{}
 };
 MODULE_DEVICE_TABLE(of, adf4377_of_match);
-- 
2.45.2


