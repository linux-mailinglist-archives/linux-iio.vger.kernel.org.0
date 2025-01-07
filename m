Return-Path: <linux-iio+bounces-13973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA9A04444
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E52188774A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA001F37A6;
	Tue,  7 Jan 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RRTSRG66"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009D433AD;
	Tue,  7 Jan 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263574; cv=none; b=hxKJrUrqGRoaC4VNVvjNko1T7t/ifzLqLj2zPzDdQbW/P9sG55zZ4smfM0lVXF32eRkzspReGRwPfA3ZO3EDrPSBclwf1CyUBinsbQsGfkyLMx51px6eUaISHMtF7A4MM0MjITEPI5oqK1f9DE6a/XZPWCQWH3fIzmujFADkxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263574; c=relaxed/simple;
	bh=yi4zNSuGBVAecXTmBE59Y1FvH4TaE4hmsX4DPCNB/rI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VigmYcu0w395QVSQJQMqkv1q0B87GHP5OSn5oxWhql5F4HGAMz73AXkNipmVCFn6WPfSQYjAqf6U7KWFXHyZ3HaFikaRDZ7LMCQ0yO0ddnOM6LTaQuNfmBpWqSW3goz/oKbg6AqV9BBYOWyn/rLAUESQ8NHl4tR0ntFezS8yYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RRTSRG66; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvPXr008623;
	Tue, 7 Jan 2025 10:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wUFbE
	JF5dDzNDrUxxXz5tytyYl5iaHvRSxJlwCvaS1w=; b=RRTSRG66HFujt0myoofqB
	QUqEziMScZ8hoc4jA0iQfYGpBP756OGGGNGbt4VUO9GqU5osN6IZrc7pTz/SD55i
	EMGohoIulCnDzfJXXwdqEV9NnmAIFU+JT1yy0T3DIAI7AFB5P6apfyHwnUvIJ/X4
	Q33O3XxWG8+UpcA2rTMAVZN8DLCjQH70ufvXKBrls3mWk9JyLOLIYByDjvsc4AuF
	bEX9yHciamGb7LqCSLCYF95L8Zarmq9gu8IREQYfrFQWyENf6egTxvGB6YZxw8sw
	EvN2hnW1f2lUWwVObD2HS+q4JaP4RqWmCv6hVxFGbpTqCr/xKD0N8hmsj2CxGpkA
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4410d0sr78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:25:56 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FPsDM034114
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:25:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:25:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:25:54 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FPhUJ030322;
	Tue, 7 Jan 2025 10:25:46 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 07/15] iio: adc: ad7768-1: Add reset gpio
Date: Tue, 7 Jan 2025 12:25:41 -0300
Message-ID: <45cfd15501384a183a97d871b6848fb79fdb7b39.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: nU8_VnvUeg5aqdSo72N2Zft2Gs_jzfTR
X-Proofpoint-GUID: nU8_VnvUeg5aqdSo72N2Zft2Gs_jzfTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070129

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Depending on the controller, the default state of a gpio can vary. This
change excludes the probability that the dafult state of the ADC reset
gpio will be HIGH if it will be passed as reference in the deivcetree.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 881446462ff5..f73b9aec8b0f 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -161,6 +161,7 @@ struct ad7768_state {
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
+	struct gpio_desc *gpio_reset;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -441,6 +442,18 @@ static int ad7768_setup(struct ad7768_state *st)
 {
 	int ret;
 
+	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
+	if (st->gpio_reset) {
+		gpiod_direction_output(st->gpio_reset, 1);
+		usleep_range(10, 15);
+		gpiod_direction_output(st->gpio_reset, 0);
+		usleep_range(10, 15);
+	}
+
 	/*
 	 * Two writes to the SPI_RESET[1:0] bits are required to initiate
 	 * a software reset. The bits must first be set to 11, and then
-- 
2.34.1


