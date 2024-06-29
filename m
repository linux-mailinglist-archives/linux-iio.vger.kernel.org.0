Return-Path: <linux-iio+bounces-7062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D90F91CEB6
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E091C20D03
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36844139CEF;
	Sat, 29 Jun 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Qiq2m34N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98E86636;
	Sat, 29 Jun 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719687971; cv=none; b=GG46R4R/yRTGp4GgTE0ZqX3OC6jb9AQTLsBjw0XhWf6oAYT++f+yupQad09JinlOv7NczGhHTJXoxVvmYDccnMZbbs7RSvsu1hqOAg6ajBI7ScC7RGoku6llld2ySTZiuQjXe405jghnaDcWU8+02BUTcNza0D1skSxuutns030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719687971; c=relaxed/simple;
	bh=4v1Bdd0y2MQOdgWOszZifarz9J0BRnZSeRd+J1+vVMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4CPlFHfoAREBNHf0S1Wvlkv2JewFyVJ3RGHHWqeYl9RE8ryPa+XvvyqpN6c+yEApbjuqhS2fdTWIFgMsGdZVmzgpUfOs00+m+A23tWeeAklyt1yrqBTW61fpLOZEOQi/8CCEOOr/Llt8kPPYqa1usH0zxdNJ5BrF7XtDx9s7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Qiq2m34N; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T92fRf003640;
	Sat, 29 Jun 2024 15:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mOJWT
	rWdsA3xr3kLjI4EjjAIhYzwUxkq5ouHGjfJzH4=; b=Qiq2m34N+7wHR9ChQKm8P
	vRCTY9qxX8QJo35Od6JDE/kA9rcMoPPPSid/yUdqGUB9QexnhRWlr0Rn8NNwOQsQ
	N+j8CFzcuqrspMUi6ONP+0tK9+VYCEfYyqZhlSSUUAg5iQzrXwszrml6D6VXQSms
	Ch4zG0v3RTHR/SQiGcpgy17dFkfWtNe08Jc66KYkT+kjSA6OWwlIua0Q0hf7qJ8D
	YsTA8+GbCecOrGLs+8Ro/0hSJNpqXaoY5QTQdPIkev+T1va31FBdwyyShxOmlMU5
	Tm9UWA70pryaELWzG+oPhDozeugObZp2YHrUdfNKQYl0tqowwRo0QZfSRa5FcXvT
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 402f9u0yp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 15:05:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45TJ5rpl046845
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 15:05:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 29 Jun
 2024 15:05:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 29 Jun 2024 15:05:51 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45TJ5Y5i001376;
	Sat, 29 Jun 2024 15:05:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/7] spi: spi-gpio: Add support for MOSI idle state configuration
Date: Sat, 29 Jun 2024 16:05:33 -0300
Message-ID: <02a6d235b75d79eb227f0927c5a4614d4b34007b.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8OtVtIjLs9irke5_40yIJqmncYtwa6dR
X-Proofpoint-GUID: 8OtVtIjLs9irke5_40yIJqmncYtwa6dR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290138

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
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


