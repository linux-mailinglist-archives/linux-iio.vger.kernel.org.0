Return-Path: <linux-iio+bounces-5789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E400B8FBF25
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984251F21C13
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743214C58A;
	Tue,  4 Jun 2024 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fHO6d+0D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026E146D78;
	Tue,  4 Jun 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540947; cv=none; b=uViDPWVRlwrBYmsOlQSX9tqzXX7hLInZua+QKgSUmzB1S5+oxxZg61Hc5ohXQVo48bGbVZe0pS87gKCLLgL3P8z3Ep84en09+IndFmj9wQEkJq1tz49gl9y9XEWMg89cmQcuXd/CnBIH26HU3tN9PBui7qdm/4Xa962f1d57ZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540947; c=relaxed/simple;
	bh=tPM2gR/fRiqfWScjHlUDfJRBNYSA6t7GX+yS+5VX99c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWXDSvXXmWJYhLMBntJVrbk80Naqs4bs8Z0Df1e1ge0ZpnKhogaYYsSEqJFUZ+LI1XcUZqIKSOcVrA4+NkV8ssmTop8Rqj36Opc9TKN6B3eURgAtSsvpS1Ow2qK/s8CK3WlEcbXt6bl/sdvUEtAOV8Z/WOh3a6/JHlYOQi97ALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fHO6d+0D; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454ItsG2030377;
	Tue, 4 Jun 2024 18:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=f8sF5
	eYr6TUBHybAnubDqM770OQZifscgvyjnnqCi1U=; b=fHO6d+0DD+NAA/XTfL80g
	32xWFo0TjV2rHrNdHthy4tuCwka1hgPl15xELfpJbSqel54Wj3inDvruRcm18Pp2
	JKmbNC6ZaUH0H8kFRTQsQV4OfQLf2LqL2da6iykDGbECsKu2dxOUcluu4+o71qH3
	Yq71SqMV34FmCofIzcfBcfStYQw7/BnTYBGBl3/T53uX1TYIeP0PhW2sov4/VEzf
	/MxRMNExxoyWRPrbrvg3MF0vNou7hDfJmRP8yx5+UidMH68HXQnog6xyefrvdb45
	WWM1EzmXKkFoiMD1foto5AEN9oLgt5g6C++/jpAZpEpkgFJ3kr7w0yvnTG5LDYRg
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yg0j1mryn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:42:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 454Mg5RZ010947
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 18:42:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Jun 2024
 18:42:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Jun 2024 18:42:04 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 454MfnSI001178;
	Tue, 4 Jun 2024 18:41:51 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state configuration
Date: Tue, 4 Jun 2024 19:41:47 -0300
Message-ID: <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: J3ZZmvyMtaD4KKJIAji8lRmcVa1x7xHH
X-Proofpoint-GUID: J3ZZmvyMtaD4KKJIAji8lRmcVa1x7xHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406040183

The behavior of an SPI controller data output line (SDO or MOSI or COPI
(Controller Output Peripheral Input) for disambiguation) is not specified
when the controller is not clocking out data on SCLK edges. However, there
exist SPI peripherals that require specific COPI line state when data is
not being clocked out of the controller.
Add SPI mode bit to allow pheripherals to request explicit COPI idle
behavior when needed.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi.c            | 6 ++++++
 include/uapi/linux/spi/spi.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 289feccca376..6072b6e93bef 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3921,6 +3921,12 @@ int spi_setup(struct spi_device *spi)
 		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 		return -EINVAL;
+	/* Check against conflicting MOSI idle configuration */
+	if ((spi->mode & SPI_MOSI_IDLE_LOW) && (spi->mode & SPI_MOSI_IDLE_HIGH)) {
+		dev_warn(&spi->dev,
+			 "setup: erratic MOSI idle configuration. Set to idle low\n");
+		spi->mode &= ~SPI_MOSI_IDLE_HIGH;
+	}
 	/*
 	 * Help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller.
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index ca56e477d161..ba9adba25927 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -29,6 +29,7 @@
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
 #define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
+#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave mosi line high when idle */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -38,6 +39,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(19) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.43.0


