Return-Path: <linux-iio+bounces-13972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8CA04443
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252A03A62EB
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96E1F37B8;
	Tue,  7 Jan 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dpPAexGq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520161F190C;
	Tue,  7 Jan 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263561; cv=none; b=eBRllXO+kD+exoadGb7Lvoe0UvFWVEE9+CJlgxrTh9TBw7tp9kJG4yLfEQWE2INUkXi1fJg7RDvJVZwhbVDkB15Jgg/teUDFj7MUJDK+qILg2r34Y1PtudomCzJCApT6+Mx0GG2bHzS4J1akWK8XEfoAa4SZs0D1dHyJxhtIdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263561; c=relaxed/simple;
	bh=D60CphW+4yarrSLxjEtDLE8yxxsrl4ornikiB0hukBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5Pa9AN5Zf0rBwdb9e0ATLloVBS0YT9PQX4LtkxwH1gfR33WR+oTpMttZ1j5Fj2WFqb1yBG/8BGcwMMhOTchJYlPY6krlgieIu04N2wwyKt/QwtPe0yJ/KD17KFzoTn+TjazWMQMcLUIhisANzJXwKX2Jqp81xYdDzT85rx6fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dpPAexGq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvDdk013537;
	Tue, 7 Jan 2025 10:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NcSeo
	6wXL0mSEGeBOAe/W1aNYRGXXddLxndNtVcBiMI=; b=dpPAexGqQ6PxiSBW4CvlI
	KM6VM3AVkbkY3qOec4eG8/Z5fM1J5bj8CqTt1SE4U6injqf/pPT+CRGfQgVOAKZG
	SZEqLlzBthwSI03zmPlQRQozcgA+bqPUexhPD/Q5/MjwaQRSqAh5GPR9U7B1KGFd
	5uD9lE00nMj+ct9ya+uh5KQuic9Ibd5h4j+wSJ/LFNarkVE2hB0VAZOiZ9fgCHma
	bAs3TBduJaNxuKrK0MyWG6/wjltpT6vWfEYdX+tKM5rdNl+Vnm1ABm8ZwsXGZb+2
	K2/gyHE8yseyycg8IMDRDNqHxv2kaFbNX3bqm/vXg3jMvY10n970/fmFTdU/PCxU
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gdgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:25:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FPf2n034085
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:25:42 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:25:41 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:25:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:25:41 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FPUSA030316;
	Tue, 7 Jan 2025 10:25:32 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 06/15] iio: adc: ad7768-1: Update reg_read function
Date: Tue, 7 Jan 2025 12:25:30 -0300
Message-ID: <4c2d06b873def8a9c3c1d4c8dbc829b655218eca.1736201898.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: IahLJD8IixJSBedbPvwOpS6Wbs3g4-lL
X-Proofpoint-GUID: IahLJD8IixJSBedbPvwOpS6Wbs3g4-lL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070129

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

This patch adds an additional parameter to the register read function.
By passing the data pointer to the function, the returned value will used
only for status check.
With this change, the status check won't be confused with a register value
check:

ret = ad7768_spi_reg_read()
if (ret){}

Also this change removes the probability to interpret a negative value as
a return code (the ADC is a differential one)."

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 463a28d09c2e..881446462ff5 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -177,7 +177,7 @@ struct ad7768_state {
 };
 
 static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
-			       unsigned int len)
+			       unsigned int *data, unsigned int len)
 {
 	unsigned int shift;
 	int ret;
@@ -190,7 +190,9 @@ static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
 	if (ret < 0)
 		return ret;
 
-	return (be32_to_cpu(st->data.d32) >> shift);
+	*data = (be32_to_cpu(st->data.d32) >> shift);
+
+	return ret;
 }
 
 static int ad7768_spi_reg_write(struct ad7768_state *st,
@@ -206,11 +208,11 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
-	int regval;
+	int ret, regval;
 
-	regval = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
-	if (regval < 0)
-		return regval;
+	ret = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, &regval, 1);
+	if (ret < 0)
+		return ret;
 
 	regval &= ~AD7768_CONV_MODE_MSK;
 	regval |= AD7768_CONV_MODE(mode);
@@ -234,9 +236,9 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (!ret)
 		return -ETIMEDOUT;
 
-	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
-	if (readval < 0)
-		return readval;
+	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, &readval, 3);
+	if (ret < 0)
+		return ret;
 	/*
 	 * Any SPI configuration of the AD7768-1 can only be
 	 * performed in continuous conversion mode.
@@ -258,11 +260,9 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->lock);
 	if (readval) {
-		ret = ad7768_spi_reg_read(st, reg, 1);
+		ret = ad7768_spi_reg_read(st, reg, readval, 1);
 		if (ret < 0)
 			goto err_unlock;
-		*readval = ret;
-		ret = 0;
 	} else {
 		ret = ad7768_spi_reg_write(st, reg, writeval);
 	}
@@ -515,12 +515,13 @@ static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
 static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int regval;
 
 	/*
 	 * To exit continuous read mode, perform a single read of the ADC_DATA
 	 * reg (0x2C), which allows further configuration of the device.
 	 */
-	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
+	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, &regval, 3);
 }
 
 static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
-- 
2.34.1


