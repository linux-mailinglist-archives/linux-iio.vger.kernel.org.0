Return-Path: <linux-iio+bounces-14622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2939A1D92E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142733A5620
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B213D8B2;
	Mon, 27 Jan 2025 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hKqxHuV+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540813C809;
	Mon, 27 Jan 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990808; cv=none; b=bbkfeGix5nZ+7qHN+Gbol7/Ahx6tdsTsb9hfg++XQFTER7jZRpfblxj3izUcpParlIV7li1eCV7es9RYf6FiLYITnbyr6okBX5nuvL9Z8E/vDU8u2988VDKYMrdQM2flB5YyBDVq8gp8/vk9NHzw+ZiGYcrvCFm7maTE5Bq5V38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990808; c=relaxed/simple;
	bh=A9xvZU/I2tK+jSG5ZVimNoB76kj9Xwjwvwh8OGMlo6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXTGCm2jNlQtPJEm2BNkjLeWAHvIPr6yERwv6VfuO8yhVDqAveCSpRxI9tIGEWaOZgB2R4PMwkzQ+H8TZQ5oea3otLvaSU2/JOmklgRS5piWfmL9Zap4UN6J5ITHgQjYC77SkzKCo9O9LrRsNh6EW4UKN/f8kFEAVtq6e1N3vgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hKqxHuV+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RD2QJi005709;
	Mon, 27 Jan 2025 10:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XFHEV
	SSenAyPGWik/IjZ39kq4lMCNQj0hVlfsY1s2VI=; b=hKqxHuV+FOEYoulLl/pov
	22x2csgHyduqp+rzwZVmDmHpyv/VYzZ0Ugbu26iJ+S79MAJVkbPjXZA1SFJOB9F+
	yhPV/yHL+1idB2Jcb0RLRg2xjGc4URl14MUJPM/xpgUKT6SQROX4iIk+l87WMWnc
	SqnvCIGxEjy2c90TmcjOq+/qkRXQ6SiBdnLI8Uu2nPNJCERTsa4jrPNLp0i1Rd0Z
	l1cZKJd2V2PATbtZG3+pc0PwhRJFwRDW5vXmTzydz4vGzHTvJQD8yEp1d30q4VD6
	w8u5EVCj8xRNAJWb+jg9yH/UcPTpIXNLnDBbKVUhzVuZFaaUODwCvupo1QaO++sV
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e0qwjqea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:13:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFDBC9011055
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:13:11 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:13:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:13:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:13:10 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFCvM5008432;
	Mon, 27 Jan 2025 10:12:59 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 08/16] iio: adc: ad7768-1: Add reset gpio
Date: Mon, 27 Jan 2025 12:12:55 -0300
Message-ID: <722340b0efff3ed22a763ce6581c96ca403316d8.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Vxwje_A1d_3SoSpnHvu-qlJ0MEzXETzo
X-Proofpoint-ORIG-GUID: Vxwje_A1d_3SoSpnHvu-qlJ0MEzXETzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Depending on the controller, the default state of a gpio can vary. This
change excludes the probability that the dafult state of the ADC reset
gpio will be HIGH if it will be passed as reference in the devicetree.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
v2 Changes:
* Replaced usleep_range() for fsleep() and gpiod_direction_output() for 
  gpiod_set_value_cansleep().
* Reset via SPI register is performed if the Reset GPIO is not defined. 
---
 drivers/iio/adc/ad7768-1.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fb8d6fae5f8a..17a49bf74637 100644
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
@@ -453,19 +454,30 @@ static int ad7768_setup(struct ad7768_state *st)
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
+		fsleep(10);
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


