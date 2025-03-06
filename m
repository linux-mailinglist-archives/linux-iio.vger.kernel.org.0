Return-Path: <linux-iio+bounces-16493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04EEA55807
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BA16D680
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE827291C;
	Thu,  6 Mar 2025 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="U1CouIeU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E630207E00;
	Thu,  6 Mar 2025 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294885; cv=none; b=m84l/ce6V3CnsFLDc0eUH9W9gt2dIfesDYQNPOdC2xYdwDHbOzKr9+Z4bvGjuHJdiq9n0UagAineXDHQ/p7T1ZhE69uZuTXFyY9Oph0TwonmL4PnBlEirlayj9TVE2dCUmHxjTXsABjsVtYJKILnXYK3n4wgg8M/lwc/yRc89Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294885; c=relaxed/simple;
	bh=kGZfpJDbO2J1BM3sYh7KXV2ALbildeR9iQVCOOvLG9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjEx10umGTlW92cLUA5e8Ll2vXCUap8NAPewHhiKAvEN9kxhCLABnenjkTmCGFtDAvDfsgyhU+4sC7bmxeqiksLiUhN37n5dCuslYlILbJ7843YxhbpovW1XwpPMEgAsncXaUOmQ561Hq6Enu3ullgF6TfCT8u8RJIGoz1rEGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=U1CouIeU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfbQc002962;
	Thu, 6 Mar 2025 16:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mtD1A
	kqVVK0ZCZdy8pI+QB1o62lbWLXkQOc0ljf0wSo=; b=U1CouIeUjJznVOH915CfH
	Ro63xzZbNwuMajLVgJDRjygfxlGJgfjQnUNs+4EAu3A0I2yx3rlKoo6z9ZzPc4sB
	9K0XaIhdtaimIQbAFRwza72Hihin4XqnIlNTDeFu8asEKjV1RN8jlCaZqq6bIJBX
	X0RSapITMnRPuMXAhv2UDBUGot1l6ADAPsucREUvqawroAUr0L30p3Yz3jzCS2q0
	o+n6VunqPNTOHex5q5XE6BLcmvHVnC00D3YT198xV3Hsfrx77NL0oNe0DzVBolH2
	6K0QOnp30BKW04OaspdbVNh6Y9TZ/sM3zS8h9RQVau8cOTYRgANWEMCqs7OcuEx6
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 455wnuf8eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:01:04 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526L12F2034760
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:01:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:01:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:01:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:01:02 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L0hxc011453;
	Thu, 6 Mar 2025 16:00:46 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 02/17] iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset
Date: Thu, 6 Mar 2025 18:00:43 -0300
Message-ID: <c2a2b0f3d54829079763a5511359a1fa80516cfb.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: G7uyCLKeAEoW2P7k_-9HXw_gDuM7iHQ6
X-Proofpoint-ORIG-GUID: G7uyCLKeAEoW2P7k_-9HXw_gDuM7iHQ6
X-Authority-Analysis: v=2.4 cv=VNcnn8PX c=1 sm=1 tr=0 ts=67ca0d10 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=x-s49S57KS4xq0-Af7kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

Datasheet recommends Setting the MOSI idle state to high in order to
prevent accidental reset of the device when SCLK is free running.
This happens when the controller clocks out a 1 followed by 63 zeros
while the CS is held low.

Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* None.

v3 Changes:
* Patch moved closer to the start of the patch set.

v2 Changes:
* Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
  continues the same. I realized that using bits_per_word does not avoid the problem that
  MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
  during a transfer, nothing happens.
---
 drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c3cf04311c40..2e2d50ccb744 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -574,6 +574,21 @@ static int ad7768_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	/*
+	 * Datasheet recommends SDI line to be kept high when data is not being
+	 * clocked out of the controller and the spi clock is free running,
+	 * to prevent accidental reset.
+	 * Since many controllers do not support the SPI_MOSI_IDLE_HIGH flag
+	 * yet, only request the MOSI idle state to enable if the controller
+	 * supports it.
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


