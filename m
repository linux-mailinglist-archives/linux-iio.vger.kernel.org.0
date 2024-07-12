Return-Path: <linux-iio+bounces-7569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CDA9300DD
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 21:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AB01C20FBE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F029F2E634;
	Fri, 12 Jul 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tEfOlHgB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DE28DCB;
	Fri, 12 Jul 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812142; cv=none; b=EnJYSau0oS1VGNtfxVUYeNoRgal7K/ROiUzcT/sXrW7ZvQMBXAepeUsCRr4VT5Lbjbz9BMeY8XRL1P+FIImyjkKLOFeLhMVUGIQJafA6YAJZBq/8u9FnICw8hxFCmgYlc8CnwtRgc336X2ghn+GCtIYQPgCKKzVD2VxWHo3ck+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812142; c=relaxed/simple;
	bh=xDaJxQUqs9I8DKYeTu8ibImd69Yl++WJqkcGkDBNDhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH7G7jkt3tg1GzaacJWz5uecw9gOaPBgTC2V3UB3ckWOkoxZu+zaugzjhtp1zYSfO7VYH/9FB2PqPVWZmsSh9sVBjeES5ub6RQz05BVoITbfnYxfNSE2AviYVY6Gv5LJ186LAjD+0Vxj+dxWWD5SmBKlCgYL/8LqrRKyaQ28QwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tEfOlHgB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CGZ0HQ007159;
	Fri, 12 Jul 2024 15:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TlgIG
	LpYd/ATt3MaFkVgju8Psl37EFRLQIeCVV6MeAE=; b=tEfOlHgBHEss1GPfysAov
	Av52XcTZcKeKEF3v61/o3PKoEpfB5kSASextcNfyatqWvu3jS6sNH29gHEx3YgxT
	SM0Lqs7iBwi8O2EBw52nV4fMvrk1W3RJiU70PqoQ3xO36fSnKO5P/YQu/RTl23Uo
	LT1ADS3YUxQM2hYaLj2Otir7m3kwL0OH80C+3WMAEwspHVvbuCJNMmOj8w/mW4kC
	1p5FRQakqnMR2EYLA7U/fUglBHqg01TS/h6SglwNWkyhP/GI5tiS1q7UDbIJr40P
	isMVu0lY2xrtsl46K7UYK0w55BQhj0FPRoCav5Tqj9/RN9/ertsjRdD+L0yN/GVu
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40b2qp1h16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:22:05 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46CJM460044386
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 15:22:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 Jul 2024 15:22:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 Jul 2024 15:22:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 12 Jul 2024 15:22:03 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46CJLlAY004363;
	Fri, 12 Jul 2024 15:21:50 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
Date: Fri, 12 Jul 2024 16:21:47 -0300
Message-ID: <f237166c7bbe0a1cdabce243b97484bf2f428143.1720810545.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: 8A1iR-agoQRVrU_hifX8zKFv5cEpqPBX
X-Proofpoint-ORIG-GUID: 8A1iR-agoQRVrU_hifX8zKFv5cEpqPBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120130

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3231f67ae265..e2042d7368bd 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -41,6 +41,7 @@
 #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
 #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
 #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
+#define SPI_ENGINE_CONFIG_SDO_IDLE_HIGH		BIT(3)
 
 #define SPI_ENGINE_INST_TRANSFER		0x0
 #define SPI_ENGINE_INST_ASSERT			0x1
@@ -137,6 +138,10 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
 		config |= SPI_ENGINE_CONFIG_CPHA;
 	if (spi->mode & SPI_3WIRE)
 		config |= SPI_ENGINE_CONFIG_3WIRE;
+	if (spi->mode & SPI_MOSI_IDLE_HIGH)
+		config |= SPI_ENGINE_CONFIG_SDO_IDLE_HIGH;
+	if (spi->mode & SPI_MOSI_IDLE_LOW)
+		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE_HIGH;
 
 	return config;
 }
@@ -682,9 +687,13 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->num_chipselect = 8;
 
 	/* Some features depend of the IP core version. */
-	if (ADI_AXI_PCORE_VER_MINOR(version) >= 2) {
-		host->mode_bits |= SPI_CS_HIGH;
-		host->setup = spi_engine_setup;
+	if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1) {
+		if (ADI_AXI_PCORE_VER_MINOR(version) >= 2) {
+			host->mode_bits |= SPI_CS_HIGH;
+			host->setup = spi_engine_setup;
+		}
+		if (ADI_AXI_PCORE_VER_MINOR(version) >= 3)
+			host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
 	}
 
 	if (host->max_speed_hz == 0)
-- 
2.43.0


