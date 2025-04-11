Return-Path: <linux-iio+bounces-17963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A1A8629B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1501BC301E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897021B18C;
	Fri, 11 Apr 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RQH2dCkl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F40214A94;
	Fri, 11 Apr 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387071; cv=none; b=J0OxuQcBCPp4a+6Gj62/vwnG/bTe8XTvPqlhijLFt2/PT7Aw0oNzowJ+Eo2xUmHVtC3vg5vaOkI9g8rgt8IhkwVpO1m+W++bn1iVyRhvRkX/uv1hkoQmgfZsrrtN8Sc1Q33Rv677F0KNnpAr9qYmH16EzPs7zQW57l83e3yyjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387071; c=relaxed/simple;
	bh=PhG9wea49rcanBhbkvl15/DZOU7HEVCYGzVp3DqpHCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqPHwsXyXXVYP2MshNZLqOPhovejyPRM/Dam3+EzTVm3G5BXSwJeK/K6Opxqy4ERYHpJMTCMX+/lvNfVysDnfDZoOTW9NtimZZSyrRwld4pqbCMhZCQSWWWBqliB7tkj3EQk+y5EDtQq03Z/kLHuTKT3ej0D4AEZ9lmxF2DWdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RQH2dCkl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BDnQ4A001977;
	Fri, 11 Apr 2025 11:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FACW5
	MwctLcUUgc6nSKVw0EHVohpyfDZR8l0kLWzDJA=; b=RQH2dCkl8CZmrR4ElGk4L
	912Amow5/IYkO0+LEk5lEGa51Z4ZI8pgKHXpSjJkC5/bzpHwoOAlCfg8fbHuNcW3
	V73SFfu33EUPiP2aklsfaAu1LrDQ9zATSOg82qLJ6axdI7RLTjhOkZGbBpIWVQIj
	TeQztuVH9UH7MM7wTMZQ9O6+1M851yERJT8Hf0Rb+sCvo1sq5KRsixEqu0Korc5/
	f3p+SRl3MZR5cqhazHUBsNKTHWe62MzQ6kUQZuuVfJuo3Wwgt+pEhwlLF9Vn9Dm7
	CLzB6swaoB5LmVuPr0jpJsUufHFs6NQsAMgE8E9/aFP0QK07joKzinFa+gyks7V+
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp16x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:57:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFvSOq022275
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:57:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:57:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:57:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:57:27 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFvBMn015455;
	Fri, 11 Apr 2025 11:57:13 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH v5 06/14] iio: adc: ad7768-1: Add reset gpio
Date: Fri, 11 Apr 2025 12:57:09 -0300
Message-ID: <25a413babeddf29583f1c26abf4234dfd606a595.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: YjB8MnRLJv7rxJzTHD8FAiHelK2bQcZc
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f93be9 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=AMVuJT6RiP1W9vSWcgYA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: YjB8MnRLJv7rxJzTHD8FAiHelK2bQcZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Implement asynchronous hardware reset GPIO.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v5 Changes:
* simplified commit message.

v4 Changes:
* None.

v3 Changes:
* fixed SoB order.
* increased delay after finishing the reset action to 200us, as the
  datasheet recommends.

v2 Changes:
* Replaced usleep_range() for fsleep() and gpiod_direction_output() for 
  gpiod_set_value_cansleep().
* Reset via SPI register is performed if the Reset GPIO is not defined. 
---
 drivers/iio/adc/ad7768-1.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 017d24d0bcd8..34712d3756e2 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -163,6 +163,7 @@ struct ad7768_state {
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
+	struct gpio_desc *gpio_reset;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -487,19 +488,30 @@ static int ad7768_setup(struct ad7768_state *st)
 {
 	int ret;
 
-	/*
-	 * Two writes to the SPI_RESET[1:0] bits are required to initiate
-	 * a software reset. The bits must first be set to 11, and then
-	 * to 10. When the sequence is detected, the reset occurs.
-	 * See the datasheet, page 70.
-	 */
-	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
-	if (ret)
-		return ret;
+	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
 
-	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
-	if (ret)
-		return ret;
+	if (st->gpio_reset) {
+		fsleep(10);
+		gpiod_set_value_cansleep(st->gpio_reset, 0);
+		fsleep(200);
+	} else {
+		/*
+		 * Two writes to the SPI_RESET[1:0] bits are required to initiate
+		 * a software reset. The bits must first be set to 11, and then
+		 * to 10. When the sequence is detected, the reset occurs.
+		 * See the datasheet, page 70.
+		 */
+		ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
+		if (ret)
+			return ret;
+	}
 
 	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
 					  GPIOD_OUT_LOW);
-- 
2.34.1


