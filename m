Return-Path: <linux-iio+bounces-6540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD81290DFAC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 01:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CB21C225BB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E391849D9;
	Tue, 18 Jun 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="weiCZmBM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A617CA1D;
	Tue, 18 Jun 2024 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752353; cv=none; b=iVhVzHPuDFgnm4n0rbtzPTYehZ0AzShXI2TuOcLC7VvpoHXbfPPup3D4y9CXDviK+zZaxdor8wljICloiwVVfHyaL51VrrwYxlgAwI5EdlLMSKHBDpP1nspgfbYkr3gUrlUH3TEisAl9R5e/5xffq9aDeHqknYbGwiaDzxqpkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752353; c=relaxed/simple;
	bh=+nuwZS8xIDRA6JRVLzp1Z91RspR/qQfSOH5Zk3EbrWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1rj21RQ4RBeHsBRYby78lyAFon9wWVYz+WTYYOYOzdbDfkaNgo+pU5Hyq0+qZDL9xgtLfcIa6gMpKl3rk2ahSLP7UKmkycqWy9y112IgYAHYVpVUZAlERuVmG8CkeaD8nZtYD1+D82W5Y4AezEifeiVwJf5qV1zuHLWcKUPvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=weiCZmBM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILXQq1005213;
	Tue, 18 Jun 2024 19:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KAjlO
	cBZ5BtOzcL6suyMXrlzwR2PJb5xVGk6f2tdRDs=; b=weiCZmBM6o1Rv0kSOw9va
	tLp0xcZdJtHv2siVWBw0lB4LzwTy3vic5roKCDWKYN4GwIo1TypoTAJuX6SSH4SU
	Noy38QizbdjrhG4al7mFzPWbC5wgtK6u92MoRKmBUlJymfSvtFpB9MDsRBtVwPNO
	zwyt0lph7gZ9CqgdbjZxLoFeqyybPiMNm3Ud7elJxjB9YBcah+VCnocCBLyDyN2O
	fB1B6UiYAvnnIJrb4Jzqk86TRUsbwToQC46MpC7YIcaazkFYp5xm+WqKrClcIC23
	OXgDl+X1s8yJUaGkCI1og0Bo38gCitNTFXTAz3g6iB99t5r1ZjbYZ4koMUC9LNno
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yuj8qg8hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 19:12:17 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45INCGgs017565
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 19:12:16 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 19:12:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 19:12:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 19:12:15 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45INBv1t021773;
	Tue, 18 Jun 2024 19:12:00 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/6] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
Date: Tue, 18 Jun 2024 20:11:56 -0300
Message-ID: <ead669c15db7cfad4034df1d743fd4088f1c2253.1718749981.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1718749981.git.marcelo.schmitt@analog.com>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Ouz3DQHVKg4qSCfKXuB1dcKq3Q5edNUC
X-Proofpoint-GUID: Ouz3DQHVKg4qSCfKXuB1dcKq3Q5edNUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180169

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 0aa31d745734..787e22ae80c0 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -41,6 +41,7 @@
 #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
 #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
 #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
+#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)
 
 #define SPI_ENGINE_INST_TRANSFER		0x0
 #define SPI_ENGINE_INST_ASSERT			0x1
@@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
 		config |= SPI_ENGINE_CONFIG_CPHA;
 	if (spi->mode & SPI_3WIRE)
 		config |= SPI_ENGINE_CONFIG_3WIRE;
+	if (spi->mode & SPI_MOSI_IDLE_HIGH)
+		config |= SPI_ENGINE_CONFIG_SDO_IDLE;
+	if (spi->mode & SPI_MOSI_IDLE_LOW)
+		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE;
 
 	return config;
 }
@@ -646,6 +651,9 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	host->dev.of_node = pdev->dev.of_node;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
+	if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1 &&
+	    ADI_AXI_PCORE_VER_MINOR(version) >= 3)
+		host->mode_bits |=  SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
 	host->transfer_one_message = spi_engine_transfer_one_message;
-- 
2.43.0


