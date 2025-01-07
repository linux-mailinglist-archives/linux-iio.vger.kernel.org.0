Return-Path: <linux-iio+bounces-13980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA2A04469
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8252C1882927
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681C81F37DA;
	Tue,  7 Jan 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mXXInYdl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C41F2C3D;
	Tue,  7 Jan 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263655; cv=none; b=qDPeFVhUAsXvBRxVMy2BZwKuRyOhXqynltU7q0IS3C1/QO7RyIwIyqU8QbFiQ7EuZ8WzXBwIX9m4jFuG37w1jWWjpX21vUACFkGkHSgzD27DrMHc/8rfmG4JzE+2PCFLaJHSeQ0Hz8iJzslj/TOP/tRhriDAGokGH/l0D7aAJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263655; c=relaxed/simple;
	bh=YXqEk4aPWChwKTBIMT/2irZ6Up+zAGjNs5QESEtf2NQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXbB8Tbe/RkWfGyoCxtjKRzsx9Z67lD8KJkxbjivjbImV/TSaaQZfdmy1Zx5mfN7XL0JaEg4DoJN+ZzBELcJ7lTp87eCH3Zz6YLMoK/ye+pT1gvqPorHDvhx/u0SGKQ0ygswiSvzNMgeBI4xPNXaGxvhowQjdKFQvAykt6F8ujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mXXInYdl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvGOu013581;
	Tue, 7 Jan 2025 10:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=n5zWM
	Vdnc0IRCEpG/cfeZ+UJuA32koliXDITZdHZ7Eg=; b=mXXInYdlNjY56wwYP0BlE
	dudd/WhlxjVlBoD3PgCmDL7+ZLs52xbDy9dqnEBo0OKFy5HBxJDFme2G0duT4pKL
	1sW8XYz4r8y+81O//QlUwPzW+5qygXLHtqs9aGI/yvgjjzdsu3JlOtXcy0OxF9lJ
	qJv5GP46Z/ckO8KdQiBtrF2nSAgu+DOB2n0Dsxz9xeL1csFTtpHIppGv1jO7TRjn
	TmK0q2P6pyQUEGBDQt4iaM3Vli4K6eOv1+9fLB+f+IyXXTK1QIMxTofZ7xqxAPTg
	xPgTTQzAv6KE4joybOHiDT/aaA4kEHO9eE31ML4DQOyIxwn8s8zDbwcUSAUG8aPN
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gdpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:27:18 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FRHM9034201
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:27:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:27:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:27:16 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FR4Ln030355;
	Tue, 7 Jan 2025 10:27:06 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 14/15] iio: adc: ad7768-1: add support for Synchronization over SPI
Date: Tue, 7 Jan 2025 12:27:03 -0300
Message-ID: <0f9a15e6e2e6b7b2c82ef79d8cb883d9eb6c55dd.1736201898.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: ggKlIxymNY-OcA9FHT-alpdVGCNtTGHn
X-Proofpoint-GUID: ggKlIxymNY-OcA9FHT-alpdVGCNtTGHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070130

The synchronization method using GPIO requires the generated pulse to be
truly synchronous with the base MCLK signal. When it is not possible to
do that in hardware, the datasheet recommends using synchronization over
SPI, where the generated pulse is already synchronous with MCLK. This
requires the SYNC_OUT pin to be connected to SYNC_IN pin.

Add the option to handle device synchronization over SPI.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5e4e7d387f9a..0b0cb3b396ff 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -235,6 +235,7 @@ struct ad7768_state {
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
+	bool en_spi_sync;
 	int irq;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
@@ -295,6 +296,19 @@ static int ad7768_spi_reg_write_masked(struct ad7768_state *st,
 	return ad7768_spi_reg_write(st, addr, (reg_val & ~mask) | val);
 }
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	if (st->en_spi_sync)
+		return ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x00);
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
@@ -379,10 +393,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -697,11 +708,21 @@ static int ad7768_setup(struct ad7768_state *st)
 	if (ret)
 		return ret;
 
-	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
-					  GPIOD_OUT_LOW);
+	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_sync_in))
 		return PTR_ERR(st->gpio_sync_in);
 
+	if (device_property_present(&st->spi->dev, "adi,sync-in-spi"))
+		st->en_spi_sync = true;
+
+	/*
+	 * GPIO and SPI Synchronization are mutually exclusive.
+	 * Return error if both are enabled
+	 */
+	if (st->gpio_sync_in && st->en_spi_sync)
+		return -EINVAL;
+
 	ret = ad7768_gpio_init(st);
 	if (ret < 0)
 		return ret;
-- 
2.34.1


