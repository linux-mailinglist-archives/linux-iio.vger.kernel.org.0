Return-Path: <linux-iio+bounces-8016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF693F1E0
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 11:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F19FB22A05
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBEF144D0F;
	Mon, 29 Jul 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mjgyZYUl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D73144D13;
	Mon, 29 Jul 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246699; cv=none; b=ElMIMbt+0OCImS8AjHnic2Ukwdneea+ze41tiLTm5ESqptRvbDIk4vOVuqPNIthKvN7meDCnb3hBjI/Be80cFdB0iRcAAC5FCcGsMoXVnX077kKQBwHWn5WkQEO6+OCioaYOm9ZOMswmWObqS11PipB7MAMfBPSIJnmdNGaWvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246699; c=relaxed/simple;
	bh=ZQBJlZKEMk+AYWhncHwgqFpngNybTw1NKUfDgxDKNls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kn5kL1goM/jdeC4zbADj2cFrM3t6Im4mg6yfQs8BUD5nq16+g2UnEn2F56ZVAfxpgMYrM7GlYTQ9AarpSwBchEuTqZqkc+Q/t9INvEDXTsBeQnmryn1S5NMPpWHv7exaN5kt4V5sPcm1wf3C9pIiOAWTI3J7/UvJHlCJDmD6iVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mjgyZYUl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8oYGQ023433;
	Mon, 29 Jul 2024 05:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YeAz9
	rtRZtBb7CVIIm3qK4b4pOOAYtv3k4NsjFl+pts=; b=mjgyZYUlwAQNEv/PDhxLq
	G2wsrhmqQ0XSNndoPh+zq30WwFm2k3t52m0+bkZftn6HWy3OMMZXssWqwbemes6r
	5Ho9VkySWU5YehaisQTd3oQcnct7LMGd8Maz4yfHjgJw0pxVt86csnd+r0ysymTR
	m34bNWmxAdDmGYUz2FH8UgNZz39qCSExSthpOohhQ0QPmZDE8quLg7lz/5oX9w3s
	PzhRHqnpvJjn3fyJtMB52Y92LaWZVVCM/sy1/E5XNkGM+BEyD1T82vekYXWtqGsi
	fo0O1Z7NSBtoc0aZRVGV6q31DowMT6mS/Wc4Sxr2z84a2DjgmrNi4NQo83dZheiJ
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40neb9upgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 05:51:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46T9pCJn015976
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 05:51:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Jul
 2024 05:51:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Jul 2024 05:51:10 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.170])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46T9orqX024934;
	Mon, 29 Jul 2024 05:51:03 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] iio: frequency: adf4377: add adf4378 support
Date: Mon, 29 Jul 2024 12:50:44 +0300
Message-ID: <20240729095047.25040-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729095047.25040-1-antoniu.miclaus@analog.com>
References: <20240729095047.25040-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ZfIRsLsbQzKYyYEa3JlxCcViGtf0A1Gs
X-Proofpoint-GUID: ZfIRsLsbQzKYyYEa3JlxCcViGtf0A1Gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407290066

Add separate handling for adf4378 within the driver.

The main difference between adf4377 and adf4378 is that adf4378 has only
one output which is handled by only one gpio.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - use separate structures for chip_info instead of array.
 drivers/iio/frequency/adf4377.c | 35 ++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 9284c13f1abb..5613d524deaa 100644
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
@@ -921,6 +929,16 @@ static int adf4377_freq_change(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_OK;
 }
 
+static const struct adf4377_chip_info adf4377_chip_info = {
+	.name = "adf4377",
+	.has_gpio_enclk2 = true,
+};
+
+static const struct adf4377_chip_info adf4378_chip_info = {
+	.name = "adf4378",
+	.has_gpio_enclk2 = false,
+};
+
 static int adf4377_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -945,6 +963,7 @@ static int adf4377_probe(struct spi_device *spi)
 
 	st->regmap = regmap;
 	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
 	mutex_init(&st->lock);
 
 	ret = adf4377_properties_parse(st);
@@ -964,13 +983,15 @@ static int adf4377_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adf4377_id[] = {
-	{ "adf4377", 0 },
+	{ "adf4377", (kernel_ulong_t)&adf4377_chip_info },
+	{ "adf4378", (kernel_ulong_t)&adf4378_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, adf4377_id);
 
 static const struct of_device_id adf4377_of_match[] = {
-	{ .compatible = "adi,adf4377" },
+	{ .compatible = "adi,adf4377", .data = &adf4377_chip_info },
+	{ .compatible = "adi,adf4378", .data = &adf4378_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, adf4377_of_match);
-- 
2.45.2


