Return-Path: <linux-iio+bounces-15471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFDCA32E77
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B681884C2B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E5262151;
	Wed, 12 Feb 2025 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vVh4dXvP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF426138B;
	Wed, 12 Feb 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384348; cv=none; b=qezPQms2x2YOxLMU04ML0NEsDDhFDOXwMTj1+xCUx+5krgUrd6Gp/zLmy+ODslpp5L79YdUvR6au53IJPW3pfowFPZJBc42MNzTfAxvRnUgbwVVfX8DDio4YMc67SYBoZYPYGe5/YoJ+4kQhiGl+e+Ni4pVbUlWlw9DsqWSdWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384348; c=relaxed/simple;
	bh=EufJXLTjR7TGBzXzNQ0sekWy9K3jFG96dXPKhc+/PxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDpdaSeKEB8IExplEnigqG2sx4hkGLlZqMzizxFLiUAf7KVFgyKQYQqaVKRFIH/s2oa8NsLz5YpDTbKqcnZXOFi8NnizPYWBQA9B/6twYrNhgbDxZmxrByAEjprlROa6IHWhy3ZporiVPVJJyU68X1uyXSrPO5CRcjxYyuOGUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vVh4dXvP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CHQMN2012586;
	Wed, 12 Feb 2025 13:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kXDd4
	2Z21l6GUrXo2VG7ZIbWvvAHJvFK3jT3kVR3cA8=; b=vVh4dXvPxTjepxWbWESu5
	LWiTm7XlsDbVZNcQQssgsKZtuZKi4jF2Be+2sYlSvSBTNt+2evkazFyVHcYBwBFH
	vahDKQ6Hob0SyaVJGbS+QkksOCi9nL4G0foOZ/ZLxrIed6a1KJtDZby3qHA+BCS/
	7f+0BsQD5iOZb58Nves1Git/p9TiVQMFCjPIdAr3TagY5MYHBKypwUwdAs7jWCkR
	xBe1MR3t84hCxtDIXy6ZSMu+aUjbL6P8Yqn6DQZDbCD4rnklCin3zhFn+okQtMmb
	aUXijOjZlck9eTvbNObfQCx+lLzefOWAcoWf6KLtY2ei4fcob27YJlPw97uLFoPY
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p52a3nh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:18:52 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51CIIpLQ046585
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:18:51 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:18:51 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:18:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:18:50 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIIbqr017524;
	Wed, 12 Feb 2025 13:18:39 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 14/17] iio: adc: ad7768-1: add support for Synchronization over SPI
Date: Wed, 12 Feb 2025 15:18:37 -0300
Message-ID: <abed578466a7c944987beba01de2be1108cd6ab6.1739368121.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: hNjRUYdCiDo_58-KEIJlJJNV3snNTX2R
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67ace60c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=GG6iHBmmjjhrLsviHDgA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: hNjRUYdCiDo_58-KEIJlJJNV3snNTX2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

The synchronization method using GPIO requires the generated pulse to be
truly synchronous with the base MCLK signal. When it is not possible to
do that in hardware, the datasheet recommends using synchronization over
SPI, where the generated pulse is already synchronous with MCLK. This
requires the SYNC_OUT pin to be connected to SYNC_IN pin.

Use trigger-sources property to enable device synchronization over SPI.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Fixed args.fwnode leakage in the trigger-sources parsing.
* Synchronization over spi is enabled when the trigger-sources
  references the own device.
* Synchronization is kept within the device, and return error if the
  gpio is not defined and the trigger-sources reference does not match
  the current device. 

v2 Changes:
* Synchronization via SPI is enabled when the Sync GPIO is not defined.
* now trigger-sources property indicates the synchronization provider or
  main device. The main device will be used to drive the SYNC_IN when
  requested (via GPIO or SPI).
---
 drivers/iio/adc/ad7768-1.c | 80 ++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c16149b395af..716cf3582577 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -211,6 +211,7 @@ struct ad7768_state {
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
+	bool en_spi_sync;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -291,6 +292,19 @@ static const struct regmap_config ad7768_regmap24_config = {
 	.max_register = AD7768_REG_COEFF_DATA,
 };
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	if (st->en_spi_sync)
+		return regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x00);
+
+	if (st->gpio_sync_in) {
+		gpiod_set_value_cansleep(st->gpio_sync_in, 1);
+		gpiod_set_value_cansleep(st->gpio_sync_in, 0);
+	}
+
+	return 0;
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -387,10 +401,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -671,6 +682,60 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
+static int ad7768_setup_spi_sync(struct device *dev, struct ad7768_state *st)
+{
+	struct fwnode_reference_args args;
+	int ret;
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
+						 "trigger-sources",
+						 "#trigger-source-cells",
+						 0, 0, &args);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get trigger-sources reference\n");
+
+	/*
+	 * Currently, the driver supports SPI-based synchronization only for
+	 * single-device setups, where the device's own SYNC_OUT is looped back
+	 * to its SYNC_IN. Only enable this feature if the trigger-sources
+	 * references the current device.
+	 */
+	st->en_spi_sync = args.fwnode->dev == dev;
+	fwnode_handle_put(args.fwnode);
+
+	return st->en_spi_sync ? 0 : -EOPNOTSUPP;
+}
+
+static int ad7768_set_sync_source(struct device *dev, struct ad7768_state *st)
+{
+	int ret;
+
+	/*
+	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
+	 * to synchronize one or more devices:
+	 * 1. Using a GPIO to directly drive the SYNC_IN pin.
+	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
+	 *    synchronization pulse that loops back to the SYNC_IN pin.
+	 */
+	st->gpio_sync_in = devm_gpiod_get_optional(dev, "adi,sync-in",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_sync_in))
+		return PTR_ERR(st->gpio_sync_in);
+
+	/*
+	 * If the SYNC_IN GPIO is not defined, fall back to synchronization
+	 * over SPI.
+	 */
+	if (!st->gpio_sync_in) {
+		ret = ad7768_setup_spi_sync(dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					      "No valid synchronization source provided\n");
+	}
+
+	return 0;
+}
+
 static int ad7768_setup(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -701,10 +766,9 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
-					  GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_sync_in))
-		return PTR_ERR(st->gpio_sync_in);
+	ret = ad7768_set_sync_source(&st->spi->dev, st);
+	if (ret)
+		return ret;
 
 	/* Only create a Chip GPIO if flagged for it */
 	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
-- 
2.34.1


