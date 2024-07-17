Return-Path: <linux-iio+bounces-7652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5069339E3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 11:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013CEB21C9C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F05482D7;
	Wed, 17 Jul 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O56nTSQf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7C45BEF;
	Wed, 17 Jul 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208691; cv=none; b=qjZ3MM0WbXQBPDVivz6vm1E70R9GHM07khC7DWXbn3SLkNcWjwosJzk114fcuibGclrL1cbR+G36I4Uw1cpgWJ7V2FIGq0s7wiSk61zlaD/mxCz4Opd1Z9UzqRz3DTwM1yr2ZoWLzsmisBoNjPEO/pn0Kq3KCluxJNeKCYap4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208691; c=relaxed/simple;
	bh=WSdYPYouR8KY7V5bnXs9tlXYukaGhxhDOfiqHrBTS54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDNJGC+IVj9gaZju+sVcv5Bomnr8pm9UoT4uk5KczBoU9kfD85uO95pYxTlAAS4r5C2yIPPmkHBQxtQnvF/jo7iKQ7VFxK8ELmMkjGxynrRIgrjtXDz6WUDY7MEUjpF0NaOUDGeo4MH932Tt+LuNe1E8UPSaGjmVAesQ/COkKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O56nTSQf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H75J9H023192;
	Wed, 17 Jul 2024 05:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Uj2Y5
	4xiOPizy8MH0a9JbpiMvt64IFo2hB+OSN8aojE=; b=O56nTSQf5ItXHKfQ1rghE
	19a44wMaNee9oWWemBhiE16eSIiiCLDHxc1f7QexYV3AJyU2kbn/tqyE6mV9J6Ej
	nO3eX002Oh8h8NMblB0hSYfcTQyoKEw15daIH0Y+oDI38oVcL9gpJmBZatMnSbZ1
	/Ao4X31QBl9Mpul2VPD2wz83GW4Os9MiZ87ceb609GIKADIh5OMfpplqsfA5gRPp
	qtLqsP1M8D3MH0hVDY69xe6yFxKZUMqNa1CLLfNgZSI9Tluc8Qz3KgAygQITQGCg
	4G2IBslrl8sRNibVAPNkcRPOp/WUXdV0dtOXqkDaCnpFX+e0Vgy6I2SFlWqt6A/l
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40dwer2ma1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 05:31:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46H9V9di039722
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jul 2024 05:31:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 17 Jul 2024 05:31:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 17 Jul 2024 05:31:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jul 2024 05:31:08 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.170])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46H9Upnu010792;
	Wed, 17 Jul 2024 05:30:58 -0400
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
Subject: [PATCH 2/2] iio: frequency: adf4377: add adf4378 support
Date: Wed, 17 Jul 2024 12:30:32 +0300
Message-ID: <20240717093034.9221-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717093034.9221-1-antoniu.miclaus@analog.com>
References: <20240717093034.9221-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: dVMkNFMqtPxCVbPwAc1xRvlQaQivyF-w
X-Proofpoint-ORIG-GUID: dVMkNFMqtPxCVbPwAc1xRvlQaQivyF-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170072

Add separate handling for adf4378 within the driver.

The main difference between adf4377 and adf4378 is that adf4378 has only
one output which is handled by only one gpio.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4377.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 9284c13f1abb..e02298a8b47f 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -387,6 +387,11 @@
 #define ADF4377_FREQ_PFD_250MHZ			(250 * HZ_PER_MHZ)
 #define ADF4377_FREQ_PFD_320MHZ			(320 * HZ_PER_MHZ)
 
+enum adf4377_dev_type {
+	ADF4377,
+	ADF4378,
+};
+
 enum {
 	ADF4377_FREQ,
 };
@@ -402,6 +407,7 @@ enum muxout_select_mode {
 
 struct adf4377_state {
 	struct spi_device	*spi;
+	enum adf4377_dev_type	type;
 	struct regmap		*regmap;
 	struct clk		*clkin;
 	/* Protect against concurrent accesses to the device and data content */
@@ -687,7 +693,7 @@ static void adf4377_gpio_init(struct adf4377_state *st)
 	if (st->gpio_enclk1)
 		gpiod_set_value(st->gpio_enclk1, 1);
 
-	if (st->gpio_enclk2)
+	if (st->gpio_enclk2 && st->type == ADF4377)
 		gpiod_set_value(st->gpio_enclk2, 1);
 }
 
@@ -889,11 +895,13 @@ static int adf4377_properties_parse(struct adf4377_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
 				     "failed to get the CE GPIO\n");
 
-	st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
-						  GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_enclk2))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
-				     "failed to get the CE GPIO\n");
+	if (st->type == ADF4377) {
+		st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
+							  GPIOD_OUT_LOW);
+		if (IS_ERR(st->gpio_enclk2))
+			return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
+					"failed to get the CE GPIO\n");
+	}
 
 	ret = device_property_match_property_string(&spi->dev, "adi,muxout-select",
 						    adf4377_muxout_modes,
@@ -945,6 +953,7 @@ static int adf4377_probe(struct spi_device *spi)
 
 	st->regmap = regmap;
 	st->spi = spi;
+	st->type = spi_get_device_id(spi)->driver_data;
 	mutex_init(&st->lock);
 
 	ret = adf4377_properties_parse(st);
@@ -964,13 +973,15 @@ static int adf4377_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adf4377_id[] = {
-	{ "adf4377", 0 },
+	{ "adf4377", ADF4377 },
+	{ "adf4378", ADF4378 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, adf4377_id);
 
 static const struct of_device_id adf4377_of_match[] = {
 	{ .compatible = "adi,adf4377" },
+	{ .compatible = "adi,adf4378" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, adf4377_of_match);
-- 
2.45.2


