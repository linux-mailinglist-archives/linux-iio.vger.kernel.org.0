Return-Path: <linux-iio+bounces-7568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C342B9300D8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 21:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A50F28299B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4C02C853;
	Fri, 12 Jul 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pZZUUuv8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B82233B;
	Fri, 12 Jul 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812121; cv=none; b=sMNJjMrmRSbw0m5PQdwPMms6/cnPBUXtDuqz0vwg3XNPDn78GAEMOnPluJKUJZuqHT7GEF5BE6pFdquyFCrPz85KjrstjgNom1xHrP3fpEn8jmqKpUBlsf585k0upQwX/fXXj8Ml76Xpn6cnj8+KSKfnaaShzuOZ7h/bZu04my4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812121; c=relaxed/simple;
	bh=CgQqA4ICYS53Rv15rsxmT8HG2x4vMsZc/m80H5tCym8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DytkgDRhpKPirgh29BaqIPUc6lx69OrZgUwpLfekS4nLcUmUfG0dJs8X7K2gs6k/DSJ8igGjNxXklWWa+PUMYg5mtGvBlbqQhOVLx+WlOPR9CTGsRRwgL0k7jfF8JgmwLuWykEMvjgz93kkHDQQicrwcfmiO8r/MwrTRAZjk22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pZZUUuv8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CFSd0j029863;
	Fri, 12 Jul 2024 15:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Xh12B
	mq9WJFlVsVvwFpX9vTYhwoLptLPLR0BNYHo8K4=; b=pZZUUuv8o0mJWBXgqo2o1
	SEL8I6SGuAJjd3jFwxrYJAF3ZBbDlpJOkeYIeYKJKlW5FenKVYLnf7Jo4t6VR5dC
	gL3aEJGnWEAxA1PYQe+yGmfJTBKlMBNSBhULeD1xfFZPRkABZx4pOqDBxHmErPGo
	kGLsfmA+q3AlsSSdRhtYRQJ+3xrwB/5BW7mBFPwDej+D0BohlVH8JDEt5zOs7WUA
	uts1Q47q2b+BkoZC4Q6bdSB9+49fWf14yQySmQXD8Lvmh8b3VZmF9llAivwaw9Ab
	5FPcGFGk57flxslffVWpLfGmbfc8VEiCD0aAi1w/H90ZNvcHUss6tyz1aPEj8XQ4
	A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy4j8se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:21:44 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46CJG7ax015440;
	Fri, 12 Jul 2024 15:21:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy4j8sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:21:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46CJLgIQ009426
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 15:21:42 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 Jul 2024 15:21:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 Jul 2024 15:21:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 12 Jul 2024 15:21:41 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46CJLNCD004356;
	Fri, 12 Jul 2024 15:21:26 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 3/7] spi: spi-gpio: Add support for MOSI idle state configuration
Date: Fri, 12 Jul 2024 16:21:23 -0300
Message-ID: <629c55a10005ba26825c3a6a19184372ef81b3e1.1720810545.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1720810545.git.marcelo.schmitt@analog.com>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mP51hQzfsSERdNkxTrC4u5lYazF8odaz
X-Proofpoint-ORIG-GUID: mG9cKM1tkfAghRGkhIsWh-PEMUth2Gky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120130

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-gpio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 909cce109bba..d3b8c99f0cb4 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -236,6 +236,14 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 	}
 }
 
+static void spi_gpio_set_mosi_idle(struct spi_device *spi)
+{
+	struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
+
+	gpiod_set_value_cansleep(spi_gpio->mosi,
+				 !!(spi->mode & SPI_MOSI_IDLE_HIGH));
+}
+
 static int spi_gpio_setup(struct spi_device *spi)
 {
 	struct gpio_desc	*cs;
@@ -411,7 +419,8 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	host->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
-			    SPI_CS_HIGH | SPI_LSB_FIRST;
+			  SPI_CS_HIGH | SPI_LSB_FIRST | SPI_MOSI_IDLE_LOW |
+			  SPI_MOSI_IDLE_HIGH;
 	if (!spi_gpio->mosi) {
 		/* HW configuration without MOSI pin
 		 *
@@ -436,6 +445,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	host->flags |= SPI_CONTROLLER_GPIO_SS;
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
+	bb->set_mosi_idle = spi_gpio_set_mosi_idle;
 
 	if (host->flags & SPI_CONTROLLER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
-- 
2.43.0


