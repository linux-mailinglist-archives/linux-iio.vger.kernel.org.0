Return-Path: <linux-iio+bounces-7567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70ED9300D3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BE9282A29
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489F2941C;
	Fri, 12 Jul 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zW+CEXpo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B86BE65;
	Fri, 12 Jul 2024 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812103; cv=none; b=sPaT0EZJ3PU43o+mNva/Q26myDmdO4TQZOm5UkiGwSL5j3tzFHfafGzLoDBYOBsjvcSOPdjaqQO/Vt3r0qSemZqO8UYaIKeCaXlEcEAzCe8feYQG9zsXA3Fv2mcIegau5bWPOMSAYyepuFife1//HM3osCI6ENH3TRSFaRraQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812103; c=relaxed/simple;
	bh=jGQ2PoYUvkHflH8SIUqzwB3UTXc5MSqu8wv5S/itOP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5L1taxQlQMSDv8gDJkaT/Fq36YzMno6APb/G1Dfs3nC7LVyow2tNM01+P2nROqamZW8EuJSftCiZ9RELnaCPwbfzYzpwmK1+hpGbw6SYXWWVXK91bYvweZWF8au2TO3zK3CC1Xwsu7e+BI1oEuj00zhzGcksOLUATz4fHioqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zW+CEXpo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CH32f6007173;
	Fri, 12 Jul 2024 15:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6ZKph
	/ow5XwUSajbaQGjDr92jQ2XCC56XscUu9U9ivE=; b=zW+CEXpoI+MZHeehqcU4A
	04lRpMiG+tFOnsMPN9MHk62yAMHLNmGEVPW0n6luWUvqPgMMmJPp/8Kfc9sFPyOZ
	KWHuf69GXtsrEebcGweU4nuzhajfZFuB14n1Lu8qEqo1+bxusrfcunCAC4BZxtAC
	K1dXi8MfEssJFkPFsArCN3hIhjs5VOioAwOy5rH+HPBoe/1HkpYNxvaEtO7GCbSI
	v/O3FNwJ2TgslCCqzMG9IZNKLDjtBFiJoGoniPhmzLUbmxMOmtKmC1Clx42FAyZF
	WL6qWChJKnk9rHx0CsXfxic+j2coL5ZCb6V32mXZhKDuyk4Lh2OgFdpN0xtROdNW
	g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40b2qp1gyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:21:25 -0400 (EDT)
Received: from m0375855.ppops.net (m0375855.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46CJLPfq013500;
	Fri, 12 Jul 2024 15:21:25 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40b2qp1gyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:21:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46CJLNKt044345
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 15:21:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 12 Jul
 2024 15:21:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 12 Jul 2024 15:21:22 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46CJL4Bh004350;
	Fri, 12 Jul 2024 15:21:06 -0400
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
Subject: [PATCH v7 2/7] spi: bitbang: Implement support for MOSI idle state configuration
Date: Fri, 12 Jul 2024 16:21:03 -0300
Message-ID: <de61a600b56ed9cb714d5ea87afa88948e70041e.1720810545.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: b4ChGGmM4Glof_MXU2qEbTt2T3Tp-2FQ
X-Proofpoint-ORIG-GUID: 0kb4vWOzwuWNYZ-qlFKgVnrDATUEcZFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120130

Some SPI peripherals may require strict MOSI line state when the controller
is not clocking out data. Implement support for MOSI idle state
configuration (low or high) by setting the data output line level on
controller setup and after transfers. Bitbang operations now call
controller specific set_mosi_idle() callback to set MOSI to its idle state.
The MOSI line is kept at its idle state if no tx buffer is provided.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-bitbang.c       | 24 ++++++++++++++++++++++++
 include/linux/spi/spi_bitbang.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index afb1b1105ec2..ebe18f0b5d23 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -54,21 +54,28 @@ static unsigned int bitbang_txrx_8(struct spi_device *spi,
 	struct spi_transfer	*t,
 	unsigned int flags)
 {
+	struct spi_bitbang	*bitbang;
 	unsigned int		bits = t->bits_per_word;
 	unsigned int		count = t->len;
 	const u8		*tx = t->tx_buf;
 	u8			*rx = t->rx_buf;
 
+	bitbang = spi_controller_get_devdata(spi->controller);
 	while (likely(count > 0)) {
 		u8		word = 0;
 
 		if (tx)
 			word = *tx++;
+		else
+			word = spi->mode & SPI_MOSI_IDLE_HIGH ? 0xFF : 0;
 		word = txrx_word(spi, ns, word, bits, flags);
 		if (rx)
 			*rx++ = word;
 		count -= 1;
 	}
+	if (bitbang->set_mosi_idle)
+		bitbang->set_mosi_idle(spi);
+
 	return t->len - count;
 }
 
@@ -78,21 +85,28 @@ static unsigned int bitbang_txrx_16(struct spi_device *spi,
 	struct spi_transfer	*t,
 	unsigned int flags)
 {
+	struct spi_bitbang	*bitbang;
 	unsigned int		bits = t->bits_per_word;
 	unsigned int		count = t->len;
 	const u16		*tx = t->tx_buf;
 	u16			*rx = t->rx_buf;
 
+	bitbang = spi_controller_get_devdata(spi->controller);
 	while (likely(count > 1)) {
 		u16		word = 0;
 
 		if (tx)
 			word = *tx++;
+		else
+			word = spi->mode & SPI_MOSI_IDLE_HIGH ? 0xFFFF : 0;
 		word = txrx_word(spi, ns, word, bits, flags);
 		if (rx)
 			*rx++ = word;
 		count -= 2;
 	}
+	if (bitbang->set_mosi_idle)
+		bitbang->set_mosi_idle(spi);
+
 	return t->len - count;
 }
 
@@ -102,21 +116,28 @@ static unsigned int bitbang_txrx_32(struct spi_device *spi,
 	struct spi_transfer	*t,
 	unsigned int flags)
 {
+	struct spi_bitbang	*bitbang;
 	unsigned int		bits = t->bits_per_word;
 	unsigned int		count = t->len;
 	const u32		*tx = t->tx_buf;
 	u32			*rx = t->rx_buf;
 
+	bitbang = spi_controller_get_devdata(spi->controller);
 	while (likely(count > 3)) {
 		u32		word = 0;
 
 		if (tx)
 			word = *tx++;
+		else
+			word = spi->mode & SPI_MOSI_IDLE_HIGH ? 0xFFFFFFFF : 0;
 		word = txrx_word(spi, ns, word, bits, flags);
 		if (rx)
 			*rx++ = word;
 		count -= 4;
 	}
+	if (bitbang->set_mosi_idle)
+		bitbang->set_mosi_idle(spi);
+
 	return t->len - count;
 }
 
@@ -192,6 +213,9 @@ int spi_bitbang_setup(struct spi_device *spi)
 			goto err_free;
 	}
 
+	if (bitbang->set_mosi_idle)
+		bitbang->set_mosi_idle(spi);
+
 	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
 	return 0;
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 7ca08b430ed5..9bbbefef30dc 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -24,6 +24,7 @@ struct spi_bitbang {
 #define	BITBANG_CS_ACTIVE	1	/* normally nCS, active low */
 #define	BITBANG_CS_INACTIVE	0
 
+	void	(*set_mosi_idle)(struct spi_device *spi);
 	/* txrx_bufs() may handle dma mapping for transfers that don't
 	 * already have one (transfer.{tx,rx}_dma is zero), or use PIO
 	 */
-- 
2.43.0


