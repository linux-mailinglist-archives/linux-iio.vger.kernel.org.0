Return-Path: <linux-iio+bounces-13971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1089BA0443E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321043A646B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0ED1F2C50;
	Tue,  7 Jan 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PXmG3DvB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD421E47D6;
	Tue,  7 Jan 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263554; cv=none; b=M1dZOU4WNnPK1J4B7LAGBZta4B5iDvzcMLdbON19vp3ca4cihoWwtRnT5OQmBsG09xkkfBymWVO171gzU4zCLBN8GUHVvn8Aw1rnZBLFoFRopBFjCFk9H9sAv9DIE90XqCztXzzL7qv/HpKIRc2BjPqN9yZJ/Y0j45RiDAYsJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263554; c=relaxed/simple;
	bh=JwCzk8Rlk+ym28VPpkoEug0whLayBrbAHITACw2FhYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7Oo58GnlTykSTikdr50uSz2kWkLrEP4AIb9JK9fMD2kKLGGuvvgpCm76EHQ5gADz8fDXkHAbUiA7JLzSj4JZNawXbFikER7Uy/OTz0wauZoyEkVWlDKt6QpPN7LFJh6FhpYV2TPKS6gcNEEmR+BdFzZhxMJYsY2sbXQrtPd66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PXmG3DvB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvCw4008000;
	Tue, 7 Jan 2025 10:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aK73x
	yHIAgC3pdLXh0QKw1geKtLg/maEgtwWzLqx/e4=; b=PXmG3DvBBW0Pb8M9T9LaY
	LKp/fZB5TwiJsN8ikOgYVtRdG1Dp1Xn3VGBpuZFwHrOHNOQDUZ6JGZai5YPqLy5X
	QmUiwh0JLlbpzt9YIcOnMq7dHHY+Jz9M1g34VjFWG+Rn3780In8uSKji7DbaLV+X
	kj7YhW2pGJhV9FF2LljWFZWclJIiNOT+WVZJ7jkQN7eXMbpbZ1LYp8HSJWtzu6Is
	f11LgrXoj76FDJKJbwqISsqc8XVYJElGO5rVIN9evtu5S4eA5zWkDKr6F+w/VSZA
	OSeYQrQl+DUw70zF7yqo9Ty3AD26PySqL0uTeFyIopArHXJlvJf7GcXkRfC+4jzg
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4410d0sr5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:25:36 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FPZ2S034073
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:25:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:25:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:25:34 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FPJWY030310;
	Tue, 7 Jan 2025 10:25:22 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 05/15] iio: adc: ad7768-1: set MOSI idle state to high
Date: Tue, 7 Jan 2025 12:25:19 -0300
Message-ID: <714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oRhyEW2oLvOUPhK3-XGZCKQ4SQUO8YFF
X-Proofpoint-GUID: oRhyEW2oLvOUPhK3-XGZCKQ4SQUO8YFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=910 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070129

All supported parts require that the MOSI line stays high
while in idle.

Configure SPI controller to set MOSI idle state to high.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c3cf04311c40..463a28d09c2e 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -574,6 +574,15 @@ static int ad7768_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	/*
+	 * The ADC SDI line must be kept high when
+	 * data is not being clocked out of the controller.
+	 * Request the SPI controller to make MOSI idle high.
+	 */
+	spi->mode |= SPI_MOSI_IDLE_HIGH;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
 	st->spi = spi;
 
 	st->vref = devm_regulator_get(&spi->dev, "vref");
-- 
2.34.1


