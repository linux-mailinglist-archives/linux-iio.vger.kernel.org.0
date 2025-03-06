Return-Path: <linux-iio+bounces-16500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E04CA55836
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838BC3AC256
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2050F279351;
	Thu,  6 Mar 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yZoZSUro"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF9205505;
	Thu,  6 Mar 2025 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294996; cv=none; b=qUfONPHMU21nr8lGNmEO7FOn5gQYnuSVsPr+7hfj3Hf5xNHdDQqLe+h++5CX7SBEDYBZfleJXrXPgYE0JYLwh8ghqlaYRy7y6KEUJwpUE4yDJKHp9OOHf5Sh2GCMeleE6vKDIlJoEFpnFXN8aaLiDAwci7Dpl19RhzP2ia9jq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294996; c=relaxed/simple;
	bh=31uJ+k+k/xzLmragtmsIy3h0BZKJXRlrPvpAAq5q1GM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSc8d21PVL1e2UycoqS358B9EVFlv9TRTpYNFF86JmT5PBjEyAKz6Mx2ClcsNtthLZE2BoXjCGJ0R3+nS4KPO4CQuaVtbvQBUxrJKizxc04IhPylmcmEr3ZQ3Or2Gb6gbEOU+DNm6jfCGJkSTEOHhqGe3Tp6OkdQMAOiLixVQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yZoZSUro; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfdnO031381;
	Thu, 6 Mar 2025 16:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7hWd0
	b70H6WBhqv1H20CywkC29RclfE1d4t4izzXx+E=; b=yZoZSUromZstOEyjfzueF
	3lKdzirqzfsyatfOdo2ckpYMovXlzaCZuPpLXbsYBBCVICe2WfHvFo1HnDtdmeM7
	89NRTnUWH2ufXINUkGvdTsmN2CtKK7O/hziglMZCHy2HQ2ANjlGkXg6+VcWGoZD0
	FcrLjO4Yp7afI4Hk6AqGHTfO3W+KzmDjnjzI4jCEmMXKnh7rs/WmTICLZ5PWC969
	v+NYjI+KRlbo1L755WbDAod6gAQXWA7qS89TEyjLue4lbtra2g7rZidia/5itcqu
	m0rw7Bc9aNUYmrDHfjuYIN9Nn0ES+BPOqz6amjvbKanwNVAFh8Y3tEYN7QTgo8aO
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 456j6dhm1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:02:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 526L2qep031279
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:02:52 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 16:02:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:02:52 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L2YYH011526;
	Thu, 6 Mar 2025 16:02:36 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>,
        Jonathan Santos
	<Jonathan.Santos@analog.com>
Subject: [PATCH v4 09/17] iio: adc: ad7768-1: Add reset gpio
Date: Thu, 6 Mar 2025 18:02:34 -0300
Message-ID: <305f0bb4a90aba547de6b46d4c9dcf04a2a4db72.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R+r5GcRX c=1 sm=1 tr=0 ts=67ca0d7e cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=AMVuJT6RiP1W9vSWcgYA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: QAsOEz-_ggPSkeaZDzN78-CoVEbggYst
X-Proofpoint-GUID: QAsOEz-_ggPSkeaZDzN78-CoVEbggYst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=980 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

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
index 04a26e5b7d5c..86f44d28c478 100644
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


