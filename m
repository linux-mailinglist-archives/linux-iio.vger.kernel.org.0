Return-Path: <linux-iio+bounces-5791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893ED8FBF2D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5052C284F7B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C358214C591;
	Tue,  4 Jun 2024 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SVUi8TNr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B9A5F;
	Tue,  4 Jun 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541016; cv=none; b=L5VT1dIH7h9vlUipsm0Sd9rkyCOpFDUbYaJEh6M7Dv2dk34R787FE1Uq2ay92ENzasbLixzZzElz4U6TDO8SCRGAGmQhDKUkNRfq9u5mNXRY5zDQvbXpm+MtMCWlXMvw7qiQzdPUcUvS1eanxOS0Y2T4nNzmo6QcDAaiw/I6Wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541016; c=relaxed/simple;
	bh=xd9W2Uaq28uqseaO7Rty9ETXeULI54L/WJ0WeG+zeIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceLDvIQzr46hFOCMMiKovPCFA5B6rDDGYuyIvhF7OQPWbCWz7wDcOWBIDmMUQvZAJMvIo0+Glg4u4bHUuftB/XBpSEhWJc1YuO3Tj2VPX7udwtnJtp9HfTOJZtVgZ9UVOMj7zh2afu0hHOCsuQARXvOAdLvLBAClMm/VA5aEBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SVUi8TNr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454KwV4w030387;
	Tue, 4 Jun 2024 18:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=74Jf2
	frvsqaSsOeTHOKorXh3HH5oIkv3eucaR50gD3A=; b=SVUi8TNrMtXapbBYjEgOC
	iWetApcliMJT1xABgH1LyY5iHLOHA4LXbXQoQKBoSzoSBGDAlHzV6EtTzURZubne
	qcPK6iwtMI51BK13gDTEFpXEoEAA6ShefluTByW8rP9O49bdOCo/h28Rb07GSPn+
	jf50HfFi+5JsoVLjbohMfYsWPGXTsFkO5MiJ3HY5iEy+B9G9Hz6bI2WbcqsQydic
	zozJKU+aJLAz7ENC92KgtB3q7A+/pUXXZlU+rW/ONQqvbX9rZvU2cScJ2Jt4XxvH
	7HYT9GMiKCinQw1ODxPYGH9qGspeP/uoPjNkgb2KARya6Q/JkDk5qdVtQMMCaBdT
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yg0j1ms2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:43:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 454MhJBL011092
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 18:43:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Jun 2024
 18:43:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Jun 2024 18:43:18 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 454Mh0Ut001195;
	Tue, 4 Jun 2024 18:43:02 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] spi: spi-gpio: Add support for MOSI idle state configuration
Date: Tue, 4 Jun 2024 19:42:58 -0300
Message-ID: <8dcce41a69a89cb8ace2587ca7ddb1c665f2d1cb.1717539384.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ysfdGX-dEfld29ZsW-GV6nDUznLZ9Php
X-Proofpoint-GUID: ysfdGX-dEfld29ZsW-GV6nDUznLZ9Php
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406040183

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

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


