Return-Path: <linux-iio+bounces-15375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C6FA319B4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3603A7E73
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0C26A08C;
	Tue, 11 Feb 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ue5/nvR/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5B1F2367;
	Tue, 11 Feb 2025 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317621; cv=none; b=BC2SB5F9DUwisWnpIxGUXn1AL56piEcHlrqe7b5SJDa0/yKL+GubvCVw699oR9dqBRyVRr8TELWBJePoAFa4PDvpWOWGxj7FZfA5KgYOE0EEqxZKprahE/pfzfENo7ff/ZatR+/gT/BY3Gu4PnwFmkufSFUYkRAtHQn8UDWJvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317621; c=relaxed/simple;
	bh=Ga0huOWxWjUQlMAL8oU5F00smsqeGn0hTk19j6Epg70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l4dxGteMFbwpDRs/FtWsJQDsAh4zkMslUCjw0YW0f55Djne+2TN7I7ltG+GvXh8J+HQudAEjLyEwVciyp47zZnyh9QojBc4J8Hg7BYmdOcCNAg8CzEa/AZ5w/e5xrZUtnoiZm5ithU9T5rqcnz1RRzRuqf72+ryxLPKyaivciGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ue5/nvR/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BI3PIr028462;
	Tue, 11 Feb 2025 18:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=CBghFaVWFqOKBz5j1EtpZjKD6/Y
	EwAO5k1qmX5x/kMI=; b=Ue5/nvR/2Rqm5Qj6msv63qp2+9NACrwNrSVct9V+j+W
	nvlnMHjOFleDO7noI3l+Wwak86P25SngYDNwy6YfCkxF/vbsWrE6luJlygHT7AcD
	WGX4IjkeohIyqZDZNpYK/CG8kcKluig4DTZpa8gBwUjDdgez882xjZXggrXBXg+2
	3U1Lb86V2P4J6F+rGvSVsupdeI+vl7WVuojEoCticxSKw0zTHCjrKHU8IxwVNbSY
	voN2931B1OuWW77emBm1Wq+zOXiKbQWskcbNnokWpCtfFbN4z4pzucJR3pYcaOoC
	f7n1Lm1rRswka62o8DqkdUDJ2AfCHZZoj7aKy3O1T8A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p209yskg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:46:45 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNkiHp016965
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:46:44 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 18:46:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:46:44 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNkXAl009863;
	Tue, 11 Feb 2025 18:46:35 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 02/17] iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset
Date: Tue, 11 Feb 2025 20:46:30 -0300
Message-ID: <20250211234630.1007989-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: MDcFvKKOP3YI3htj5VmP1Q1yAF9Cbep3
X-Proofpoint-GUID: MDcFvKKOP3YI3htj5VmP1Q1yAF9Cbep3
X-Authority-Analysis: v=2.4 cv=VPInn8PX c=1 sm=1 tr=0 ts=67abe165 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=x-s49S57KS4xq0-Af7kA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=916 phishscore=0 adultscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

Datasheet recommends Setting the MOSI idle state to high in order to
prevent accidental reset of the device when SCLK is free running.
This happens when the controller clocks out a 1 followed by 63 zeros
while the CS is held low.

Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Patch moved closer to start of the patch set.

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


