Return-Path: <linux-iio+bounces-7063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232A91CEBB
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B8C1C20DD8
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2C139CEF;
	Sat, 29 Jun 2024 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IixniW34"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FC139CE9;
	Sat, 29 Jun 2024 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719688001; cv=none; b=SKv2AXFKZ5ex3zqY84yj4phmDDL7KksqghXZLxZETTJEONSWeu9fugSi83cGmZhJHLEGLmrAElD6SX0te9ElT1G360TyXCWA1nOAWlD23QpjosVsGAYrsasTUk8vI7eDuoN5RtMD1arIiCZ9VU4k64m3/KJTK0+BcLIrE91sG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719688001; c=relaxed/simple;
	bh=BRJtHYkbUY3hENAqVJB0Y5CcxO7XL4s8tco31coBK9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jzu4SOYSeulPzy0HMSHMECpq8dHQzuKonbD+6qcmpDvuzhl3h4cDbuDW89HfEGdb0w4SACYKGIp/kr4QZ9gyvoukD8gyR86yHyR2Klkxcn2z0JUFsvZguuuPGrnPROtkcXuBIDYSmU0Ntz48o21K2RihMKDsw9WDy9ZuRR0Zb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IixniW34; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TI4RvW002067;
	Sat, 29 Jun 2024 15:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MYD4G
	a+erRqA+4bEyKtPuhA+1OqkaChVg+7W6hCUehA=; b=IixniW34KGDiFvTaSZPrK
	j3vzTbKHXjD0OKvLebaTAU5OgzFUwods2uAsusp4H2Z0y8qKNQEtuofcWEZFhp1E
	/Ho2vJMk0MKpEGJRjPF/+87iIL4VaP25OVA5rew7hhcICIt+NQCaWPkAE8j/tDTC
	jkk4dkZI4i8P61mMHgULmmMNL3sg5e2/rGeGpo2+7oJlqaREzIqh3qmz+gwfoGBr
	uQoTzOj90xTKAFzWNjd9zwFXWG5GKcwP3C7sZa4t9SxxswqG5mGt7tDneUPqfDc+
	XErJETQeJjRy34U9Te8mw/OvaRMcnbKFpEom0f5hxMzj4nkQ818GTC0O2KvY3QWh
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402c43hatb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 15:06:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45TJ6MX5046851
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 15:06:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 29 Jun
 2024 15:06:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 29 Jun 2024 15:06:21 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45TJ648S001392;
	Sat, 29 Jun 2024 15:06:07 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
Date: Sat, 29 Jun 2024 16:06:03 -0300
Message-ID: <31954175e7dae887602647d83930c9032be7f774.1719686465.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: cQ5B0dA48X0Qngg8G-RzqM4FWpD6160u
X-Proofpoint-GUID: cQ5B0dA48X0Qngg8G-RzqM4FWpD6160u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290138

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 03588fac9215..9e8f2108e279 100644
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


