Return-Path: <linux-iio+bounces-6926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B069173D0
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E721F2338C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71F17E8E4;
	Tue, 25 Jun 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KBbzQzFI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD617E47B;
	Tue, 25 Jun 2024 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352515; cv=none; b=RdtL6b4CwS3bZl2psH0KYmhT81R3/5OWaOPavHb6uSNKwDZaEY4dnSCWqbMKw/0jWPbgHpb32BN9+P8/GWKgcYRCUsqaA5z2m6kZXOoTTRttdGVm7Oxu/Dn4MjXfw6dFBjptnSDi36o9seWLNXiBp8SwRnZPYV3FR4MdF5nq64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352515; c=relaxed/simple;
	bh=rrynkdeLz0DR/A47xR9FBRWLl63w8pB0QxcERiUtfSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8AuFJholsa3eCBBgyDGCyWwt7f0iu+JwjPkA8ghmJKCfHvhfaRGR3oNIqeBxu6XyIaZsPeOE7m9HU0eQn3F17Zv4+zzLNL6SF111LNvXrhBbiNKI08Y6Y1wkfuvW2BLWaQ7SWmaV2SuvMuwZcDVEjIEqhs+RYMGH0ELT/T7HeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KBbzQzFI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PL5cN0011726;
	Tue, 25 Jun 2024 17:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=StqHt
	6GvFMeL48gtt2x6fIg8lhPFR3ysTVcH8mMm70k=; b=KBbzQzFICyWCkjYvv3Fw9
	1EEnBMRcnh9SUbI9gw99V2JqxuFfottR+MeWAUJqAmBCs5vAbRjRebc6aMr9ItjH
	4iWlgoFzzD7f9LtJFZ30vDPYAZiuVJnGYm9ObiopRPjjD6WZY1PfcrzmhKW0Bjva
	+aH9N4DaFo+FluZ8eVJMik1XquYMivzQN/vm/IQQoXBGuBLdqBbpoQq+Bp2lUxcd
	Tn2gfZDXxMjIsya5kYKpXuU4eSx01f3SxmkKHYArYGqMGbh0/3UCvr/QMHroTDC6
	oCar+0qzPmE3iIpodLl2adwRqHbsjkj1LZ1MZPj2Fnc1f/lYa7E9NOsMCi4ry3mp
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yyum1aa6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:54:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45PLsvtm007082
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 17:54:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 25 Jun
 2024 17:54:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Jun 2024 17:54:56 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45PLsb6N013828;
	Tue, 25 Jun 2024 17:54:39 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
Date: Tue, 25 Jun 2024 18:54:36 -0300
Message-ID: <072d74af9fc624490b84a1d001039424e572e827.1719351923.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: c7LbqhxYSxP3XkF59K-YnzdCiuLnR46b
X-Proofpoint-ORIG-GUID: c7LbqhxYSxP3XkF59K-YnzdCiuLnR46b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250163

Implement MOSI idle low and MOSI idle high to better support peripherals
that request specific MOSI behavior.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 0aa31d745734..5a88d31ca758 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -41,6 +41,7 @@
 #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
 #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
 #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
+#define SPI_ENGINE_CONFIG_SDO_IDLE_HIGH		BIT(3)
 
 #define SPI_ENGINE_INST_TRANSFER		0x0
 #define SPI_ENGINE_INST_ASSERT			0x1
@@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
 		config |= SPI_ENGINE_CONFIG_CPHA;
 	if (spi->mode & SPI_3WIRE)
 		config |= SPI_ENGINE_CONFIG_3WIRE;
+	if (spi->mode & SPI_MOSI_IDLE_HIGH)
+		config |= SPI_ENGINE_CONFIG_SDO_IDLE_HIGH;
+	if (spi->mode & SPI_MOSI_IDLE_LOW)
+		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE_HIGH;
 
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


