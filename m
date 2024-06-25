Return-Path: <linux-iio+bounces-6925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B779173CA
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8121F23409
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F0117E8E8;
	Tue, 25 Jun 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tWuSMyF3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34517D8A5;
	Tue, 25 Jun 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352485; cv=none; b=ZP9auM59p6EICWlpLqAHs1nZJVChilIdbUQNaaYCQPP7EO/J4TT+leM4rKxzm2MUb1/6YIKqkogFyg7VQUW0wlXVPGvbJC+2GX5Td/13GH5FrX28jC+s/Ai02foczQ7HRkrJ1eWD5DhYlgZkj0ah20wJHDm6w/1rpC0KR4TQWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352485; c=relaxed/simple;
	bh=d4UMz3/NmqSZwoZcng9pkrOofWTSaljvfAfmh0pObGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj82LqZcHO9CMx1GfwA7zv95xCb4vq4eDV3FeATWjsXjjbwCm/QXeJ0npRc9ujdAD0R5LqjlvDb3WlNn8Z1EaTVO7yixpjOOIWAHt4IpZ5NnvCWMLzVGhJXbHvX4NfMj49UfNpn8DQnu1rHDkEmyn2UHvuhf1f+XHKJLHuOlt/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tWuSMyF3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PJJrvH019578;
	Tue, 25 Jun 2024 17:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/w/IY
	NpPZz5IHAh8QoRFFZ3VV7ooZlu3hgDtTg8Vy68=; b=tWuSMyF3K8dBag1KENvsC
	7rW+UjFcXo0PwV8D3DZSr4uuWTe3VyfCikIzOrGV6+/3B+vU9pq2IydpGiVs+AF4
	BwAqiqLCcNEu6iN4+bJkjo6zV56cz9fKfd6DVuafkAI/D2+Ab+WRyyxabQKTbQja
	Q+tlkTrhgLmRcb48w4YPPu4gujGHkw2k6JAvIvr/GuZrszRcXT9ZAhYLFudPzfwf
	MYqp28f0XTHRiQbyzai4sCoC+nfE6tD5+i6RoTxYvXfJ7EPN7TAwhDVeAnFrrL6S
	9UTmUfH54CqBdizjIiumYxmlbkE+qOTDnG0T/VIvf/yHpj/rPsIOaZI4L9WTXIqL
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ywrf3mpae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:54:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45PLsRuE007051
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 17:54:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:54:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:54:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Jun 2024 17:54:26 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45PLs8is013814;
	Tue, 25 Jun 2024 17:54:11 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/7] spi: spi-gpio: Add support for MOSI idle state configuration
Date: Tue, 25 Jun 2024 18:54:07 -0300
Message-ID: <92582952136a5f289086dd009354c73dee868837.1719351923.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6KqJmrHOKQXLqqi1Q0bQR4Z61EabW9Mp
X-Proofpoint-GUID: 6KqJmrHOKQXLqqi1Q0bQR4Z61EabW9Mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250163

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

Acked-by: Nuno Sa <nuno.sa@analog.com>
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


