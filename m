Return-Path: <linux-iio+bounces-14620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E3FA1D927
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A84E3A63C3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BF413B797;
	Mon, 27 Jan 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Jd/ooIb3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF413AA2F;
	Mon, 27 Jan 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990776; cv=none; b=TQ7JVt9w/fvmd3lEsp1PBA61JLEjLh0oWhm8o93zONJHBQ4Ak6bZTMEMCYNCVZF3BLXeRQ0uW+uozWkm1wgk01IrvZAaY108a0PeRfdGfUjbqNm4hTfvt0NkllUbq9R/xqtVRI5vAMgMCMcL0Cu1oKJAmD08q6NEUiEudB/Bduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990776; c=relaxed/simple;
	bh=ugqbL3AecmC6+IRRHbRWvqcsVAYrqJ6MT0kD1fpO/RA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quhhMNHM9fpHR3ecy/ILdeoJyLsICFBruuGeLXfjFuI+U6nPP+LyEJCh4FyZecuMT8imntcTBdJcfmRuEDgfIHNSnsSbam3hyI/DVVQQqpW+z8zkWTH4SIgcotxhWDKOwluQDazRcpsV52GmsKzsB8SOYeuMEh1ENeoBVdHhtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Jd/ooIb3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWCNI005712;
	Mon, 27 Jan 2025 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dfYaX
	kTAZKlNT/r/a59TwNeiHGJi1sCbyyC+KSweAKk=; b=Jd/ooIb3szOpQU4y/zbuU
	OVUCla8P4uUKY3sl/lXajkjXU1SWvpULG3XBRVQOWjMwIbGXXvXHVKCdydfXhsK3
	F8zdQ8Mo0eDz4+35Rjx1QLWBB5i6Issl43WmthPCVkSdjs8dMbEJLBEEmBD3WGGj
	GrnnBZ5Bfjxe6RxLpW/0BZoHFy86gPwiApzCsGnLPqwXoQ59YbZo3FztS5smhcmG
	3KbFXNfRPSrZXC7fCUshpL8ImnLR98os9qPZhQz84nLZCf3HIlst1WuxbI8DCHR3
	BMG5uahsrHpRsqibIdByNDB/BoelWho72f9EpMboE9hhQTPN9dXrTGQUq8VdRKn/
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:12:42 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFCfOk011040
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:12:41 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:12:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:12:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:12:40 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFCThn008411;
	Mon, 27 Jan 2025 10:12:32 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 06/16] iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset
Date: Mon, 27 Jan 2025 12:12:29 -0300
Message-ID: <b99ec75a9f8a47df72a0e8cf126d7e9312ce59c1.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: RU-F9FZJ5HaHDCGbpOvY-t2wMaH0LSA0
X-Proofpoint-GUID: RU-F9FZJ5HaHDCGbpOvY-t2wMaH0LSA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=994 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

Datasheet recommends Setting the MOSI idle state to high in order to
prevent accidental reset of the device when SCLK is free running.
This happens when the controller clocks out a 1 followed by 63 zeros
while the CS is held low.

Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
  continues the same. I realized that using bits_per_word does not avoid the problem that
  MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
  during a transfer, nothing happens.
---
 drivers/iio/adc/ad7768-1.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c3cf04311c40..95ba89435652 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -574,6 +574,22 @@ static int ad7768_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	/*
+	 * Datasheet recommends SDI line to be kept high when
+	 * data is not being clocked out of the controller
+	 * and the spi clock is free running, to prevent
+	 * accidental reset.
+	 * Since many controllers do not support the
+	 * SPI_MOSI_IDLE_HIGH flag yet, only request the MOSI
+	 * idle state to enable if the controller supports it.
+	 */
+	if (spi->controller->mode_bits & SPI_MOSI_IDLE_HIGH) {
+		spi->mode |= SPI_MOSI_IDLE_HIGH;
+		ret = spi_setup(spi);
+		if (ret < 0)
+			return ret;
+	}
+
 	st->spi = spi;
 
 	st->vref = devm_regulator_get(&spi->dev, "vref");
-- 
2.34.1


