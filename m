Return-Path: <linux-iio+bounces-15466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C20A32E67
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD2F188B6D4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B625EFA6;
	Wed, 12 Feb 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="n1hRdZSC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229E20E02A;
	Wed, 12 Feb 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384281; cv=none; b=mZTEZGa+OWAffXtetjmxrMS899v5IqM35pl7wFgn7Vngc7+bG1wUebq3F83E2D5KzwR6qUr2RBmNOr58BmtpSGZ4KSmj4AdTwp1yprdUN8quzxLIiV7bXqj3r5AbDcyyq285B3Bn24r0Lmw3uumqzpcRnBdQuQVO7Ty/co4KvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384281; c=relaxed/simple;
	bh=6yh6sIDpTeelx0pGMYkqBdEzrGTT4jpixUibIkEdsTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxDEWKKZCMw6jI5KvUlpcQnyKMK9P93rVGD9K5Hz3kzCBctR2MO+Dss99UHniKJ6dTWgGUbaP/Ee4Z5MjAmsycNsD0BMIH+1O38hBfJw9SEcF6oSbx3C+s9rPKkhzu5/qqiEbOZImvdB+RZ98UQR5nkikeYP7LFev4GDI4iMIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=n1hRdZSC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CGx0WQ014280;
	Wed, 12 Feb 2025 13:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/5/RV
	sozl6dPVyR4qc7R6bfCqeA1USMCMGt+cmpIcr4=; b=n1hRdZSCamjR8zhOFKdXD
	ndtx8tc6PDX1E6xiJXpphzQnUh688MwmxMtG7QvD6s7twB4ZHN2X2a1s6U184xaY
	RstYMeMgD5OPoVN+/UzGK4632nPa0MooeLpVw4LJDI3sn0fJQj61QEDn4BIxYPxI
	EadQ9SFpZtkG1waufXU7Ni8s299q2WActRqyut8GNVcjyJgMIIc9HkV3ME9xoovE
	NKW60SVsUvz8PFhh4CprdTBh/N3Umzp6mrkTYlmcRNJs/+vgUjwUPybi/zQf7oB5
	r62hu4NKO/tlOuSlRQ+Mb8f+eOvZIfcstFdFxy7h6z1UXUMmPOeXZOqZt1It553x
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p52a3nbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:17:44 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51CIHhGq041132
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:17:43 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:17:43 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:17:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:17:42 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIHR6J017484;
	Wed, 12 Feb 2025 13:17:29 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH RESEND v3 09/17] iio: adc: ad7768-1: Add reset gpio
Date: Wed, 12 Feb 2025 15:17:27 -0300
Message-ID: <9562e1a999ae3e7523a618f100b809a70ead17fa.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6nqAgi4u29CYYqIU9G3a72RFJgZHCmmI
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67ace5c8 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=AMVuJT6RiP1W9vSWcgYA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 6nqAgi4u29CYYqIU9G3a72RFJgZHCmmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=963 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

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


