Return-Path: <linux-iio+bounces-15382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5F4A319CD
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645131887D17
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2926A0E0;
	Tue, 11 Feb 2025 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iABHboz6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64C26A0D9;
	Tue, 11 Feb 2025 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317714; cv=none; b=uurh3rWhSj5xgxlDNp2wZZWbJJ9WR6y7V3aUodL4K9AD5nDjAttfIEMwExw2OircFuUECR+gPRExaSF8748Raj8+cPtzSwpHAi5cOTlVa7GC53ILnTasb6SmAAxalj0PJGB1Xuib5Zw1ujeNisZ5uX1j5bNb5wW8IdmCdzcaDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317714; c=relaxed/simple;
	bh=6yh6sIDpTeelx0pGMYkqBdEzrGTT4jpixUibIkEdsTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWQyjpG6L2ULeuBhraGQZsvM6oIn5/i7BpDe9bTlJ9nXDn2N8+pPCUSFx3lpd2ol6YgX+HTT6juZrddnpXOpVHcPRfnuBWyiZWQG0zL2U8QxHnOSY3vMt9yPTLW3xWeUXCXQXDddjxEBiYMEBikKWILYYWks0QV9oQ4fQ4vEuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iABHboz6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BKmuUI014057;
	Tue, 11 Feb 2025 18:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=/5/RVsozl6dPVyR4qc7R6bfCqeA
	1USMCMGt+cmpIcr4=; b=iABHboz6CuCMYn28Cy5ZjqfdVt4Gt4p5ii80+SEiH8f
	lRt3xeMBh8aGQ97H7IauXysZ9+kE3G16o0i3CJ8XbYf7sLrEyl5buwTFG2YjQb7l
	sdSgK7hzjlyaX1at+C6EQR99cKL73erKJ7FyPBuZMWYSnlhF9Upo3Pm4EGM9TlSz
	b5o4nTcxlAQu1Ev3IgFcl4i6oDcL9aB0djKT9ROCcsjew/5w0Q0q5B8kLh6TcJ4d
	tAwU7hCShL1rYWNJHd3JAJrAsTvlimr0lyzwpIC4wynQpRP8VpecN9th0d9YM3Z3
	EARoK9kC3QAKkdISC7dp4cAxEXH3lla4WK9cD1CRbJA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p529y7wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:48:18 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51BNmHZr055626
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:48:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 18:48:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:48:17 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNm3I7009900;
	Tue, 11 Feb 2025 18:48:05 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, David Lechner <dlechner@baylibre.com>,
        Jonathan Santos
	<Jonathan.Santos@analog.com>
Subject: [PATCH v3 09/17] iio: adc: ad7768-1: Add reset gpio
Date: Tue, 11 Feb 2025 20:48:02 -0300
Message-ID: <20250211234803.1008689-1-Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: N8B9z1eoCDF29dJ_RW9BI8_XaRLrj0I0
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67abe1c2 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=AMVuJT6RiP1W9vSWcgYA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: N8B9z1eoCDF29dJ_RW9BI8_XaRLrj0I0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=943 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Depending on the controller, the default state of a gpio can vary. This
change excludes the probability that the dafult state of the ADC reset
gpio will be HIGH if it will be passed as reference in the devicetree.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
index 64d123b52b02..5ee29f9813ce 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -166,6 +166,7 @@ struct ad7768_state {
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
+	struct gpio_desc *gpio_reset;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -486,19 +487,30 @@ static int ad7768_setup(struct ad7768_state *st)
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


