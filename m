Return-Path: <linux-iio+bounces-5792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD458FBF36
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0131C253B4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A714614D281;
	Tue,  4 Jun 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="K3n3iQBJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447414D280;
	Tue,  4 Jun 2024 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541042; cv=none; b=a5YX3qPIrCWWw1KFe07xxJdW1LxcvIhwlKV8hGCqt0dPePgrUbDAGsJnRVZ4qJuvqvsmTOPvmnzYVxv1POsPNNLg/4zrrW2E+/MYGQMmzpfUjcAPlupr2srpwGJuA3b7/M+5XES5WLO7WGgJtX+oBNQ8bsIpEgKfv2yRvAQGAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541042; c=relaxed/simple;
	bh=KPLFsuxbLJbSe0NAlvozvC6hvGT606LETzi95E7ckN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEly8k49AZa9MBtb04Qo+/s3WA393o7zvlA74ezockd+9hUuuF8l/OriVn4NQvSgsf3UsOKQSMsLoQ+2aG33aSLrAZkg5C8Yeh5vtUgx4Iv+kwVP9Ke2OQg19wrZ4/x1D/hcs8TAMhpufx1v56I7lQD3jVEFYmRsbV2x91hgdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=K3n3iQBJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454KLAH2030415;
	Tue, 4 Jun 2024 18:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xL97q
	+jQ4u3SlwDZQenxOlqwGsbI4/Nn3jT75ZtbLBc=; b=K3n3iQBJbCiS91Xgl4Md1
	VGkMo1ptAjteIFj1cUoxqvoOb80ufaYxBMFpTyx4Mhk4OqJEe2SAmntKpkWS6s+l
	BxwylUrBbLLCN0kzSw/fIQd18ee67bYdmXbeTt8PDri8ZQJtf9rWhXtE1KUL6Js9
	QGOBs7SPI1HSkfYIM5fd+A68l24ARaP6neBYkbiGSMnvdLBsZ0M+VarHwGu1iCzG
	fkaPwskLVJsDkyn/XNKChHrw06Sp50FdfESpP90Qg2x2lmyqUCW+XGJszSsc/Wmi
	Vfb8dKq36/VJ/+B4i9PYsJ0R4No99qwGUSwgqNf5QXe8cUafzvj75kKUtV7BMs/X
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yg0j1ms3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:43:45 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 454Mhiun025156
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 18:43:44 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Jun 2024 18:43:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Jun 2024 18:43:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Jun 2024 18:43:43 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 454MhRj4001211;
	Tue, 4 Jun 2024 18:43:30 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
Date: Tue, 4 Jun 2024 19:43:26 -0300
Message-ID: <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: TLJyh7FPKCr0rAg9zbE8pTozA5fyhcd_
X-Proofpoint-GUID: TLJyh7FPKCr0rAg9zbE8pTozA5fyhcd_
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
 drivers/spi/spi-axi-spi-engine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 0aa31d745734..549f03069d0e 100644
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
@@ -645,7 +650,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return ret;
 
 	host->dev.of_node = pdev->dev.of_node;
-	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE | SPI_MOSI_IDLE_LOW
+			  | SPI_MOSI_IDLE_HIGH;
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
 	host->transfer_one_message = spi_engine_transfer_one_message;
-- 
2.43.0


