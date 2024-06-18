Return-Path: <linux-iio+bounces-6538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7A90DFA2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 01:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4E1F24075
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 23:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1F7185E4F;
	Tue, 18 Jun 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YIL7wLjX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB201849F5;
	Tue, 18 Jun 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752307; cv=none; b=QkvLsTDno0DkQMAQatCgiYuDxLaoO5Y74QM/yXSl6tYjxGAksVUR9JsQ4F1eOSn4uJT5tv7Dj1WhYE0Yy+tw7C4wXIp/ZBVQyPTOXA3jnJIUZRIU9vqCX6ROfYl1IBf4rs4W4KDCoAGQ+y2MtBviiZ7wwJE0BJJMuFjLf+vq/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752307; c=relaxed/simple;
	bh=E0sPRQPXNtzkxzbOXNlwqNxDuZqt39oR9j6pBw9J1VM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORQGM/2NMbkoXhvE7KtUrcY0L6l+0DGrFnDxYOJTp3qzy8yVLiNMzL4gwU2mcRJPlds3nTpGidqCPGkhmS57mluEIMmq3RNcLX1z7VNYj+ipSOPaMQYtsYoICofcoNfNYaAJjY64I+d1693WzFwRrNeBe+Alu4c4+Ri9Dt/Cl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YIL7wLjX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILXeSv028439;
	Tue, 18 Jun 2024 19:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j3giX
	IuN1pEHqX/58arefb4dOJNQT5mHyXJpGx+yV70=; b=YIL7wLjXXMnj72DGDXKSb
	f6wQqOFwZL+R/awbGlAux2R+ZQsWYVt8XbqfTZARs25LH2wsyWBh/2kLDWYaUia+
	p8Kc+s5WIFdcZ9428EoTaamTGWG3ougHWMmuexkj5eOodMSlNj0hdw4dC/V18cgo
	skiXZqJqh5AgKUPOsOQg6t6+W830wsglOk+3hReBA9bWTUDST1oLZ/1VwKl5jcqU
	3to04W2ggmNU1o4fjfQONvY0HxmovgpOcRflm2OHPMZ2hmMAD92KFPmlszSYmE7S
	1QkpISDDt86FU6RTiCBmavGSbAc4XKFn++otbqbZS6XvBzb818VvoJVP5/LR9T8W
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yuj8s87vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 19:11:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45INBSEg005870
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 19:11:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Jun
 2024 19:11:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 19:11:27 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45INBAXK021747;
	Tue, 18 Jun 2024 19:11:12 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] spi: bitbang: Implement support for MOSI idle state configuration
Date: Tue, 18 Jun 2024 20:11:08 -0300
Message-ID: <c768f76f1d590b2c3c11fe6addcc0f68be850daf.1718749981.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: Qd1fkdthYYpqKBWdKGvns3ofJN1Yjiuf
X-Proofpoint-ORIG-GUID: Qd1fkdthYYpqKBWdKGvns3ofJN1Yjiuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180169

Some SPI peripherals may require strict MOSI line state when the controller
is not clocking out data.
Implement support for MOSI idle state configuration (low or high) by
setting the data output line level on controller setup and after transfers.
Bitbang operations now call controller specific set_mosi_idle() call back
to set MOSI to its idle state.
The MOSI line is kept at its idle state if no tx buffer is provided.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-bitbang.c       | 24 ++++++++++++++++++++++++
 include/linux/spi/spi_bitbang.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index ca5cc67555c5..8cc522bf444c 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -63,21 +63,28 @@ static unsigned bitbang_txrx_8(
 	unsigned flags
 )
 {
+	struct spi_bitbang	*bitbang;
 	unsigned		bits = t->bits_per_word;
 	unsigned		count = t->len;
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
 
@@ -92,21 +99,28 @@ static unsigned bitbang_txrx_16(
 	unsigned flags
 )
 {
+	struct spi_bitbang	*bitbang;
 	unsigned		bits = t->bits_per_word;
 	unsigned		count = t->len;
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
 
@@ -121,21 +135,28 @@ static unsigned bitbang_txrx_32(
 	unsigned flags
 )
 {
+	struct spi_bitbang	*bitbang;
 	unsigned		bits = t->bits_per_word;
 	unsigned		count = t->len;
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
 
@@ -211,6 +232,9 @@ int spi_bitbang_setup(struct spi_device *spi)
 			goto err_free;
 	}
 
+	if (bitbang->set_mosi_idle)
+		bitbang->set_mosi_idle(spi);
+
 	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
 	return 0;
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index b930eca2ef7b..1a54b593c691 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -22,6 +22,7 @@ struct spi_bitbang {
 #define	BITBANG_CS_ACTIVE	1	/* normally nCS, active low */
 #define	BITBANG_CS_INACTIVE	0
 
+	void	(*set_mosi_idle)(struct spi_device *spi);
 	/* txrx_bufs() may handle dma mapping for transfers that don't
 	 * already have one (transfer.{tx,rx}_dma is zero), or use PIO
 	 */
-- 
2.43.0


