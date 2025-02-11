Return-Path: <linux-iio+bounces-15383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C7A319D7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D263A8AD9
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A626A1C4;
	Tue, 11 Feb 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GIsXmzaE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70826A0CB;
	Tue, 11 Feb 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317731; cv=none; b=qymHfcwY3kCs6/i4NBjvWVhU81DY4jOcOORQRy1EPxIiBQQic0LGnFsRqBHsYNGIvuz6xTRRpUJJsCT7KtZQK/C3wtJ9QUvayCBNRz2AoNE9r30je30fHyGnfvpwM5blm45d01RT6xSjvQZ4RquaJZr5oL+FhY7bq7z5q5goeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317731; c=relaxed/simple;
	bh=Lq8NnCjIjCNUEajzrtRjsCYvKlCIlc4mjhIhL6vpkNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Psf0y0iM+8vQ1pn/ll20zF2Ri2nurrOZy0+cQe3KhOVW5o68jOK8Sc/bKGXzZhoUcAPwQmYSBHKx2fFOQW6KTokkM3cbA6R7goDTbHi6JX8JRET9kbvW5QsZOmGaezeVVIICfcam1i1rLnlHw6BhlO/JRtMFhvK5ToF8HDAnB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GIsXmzaE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BId1Yn029428;
	Tue, 11 Feb 2025 18:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=kobpE+nfQOAOZCTakwt07iybo6q
	TTrsQ7C6TG5FANGc=; b=GIsXmzaE0mWfk0ubXucM75/X9j/5hWMclvkXqZvVHG2
	9sTP5jPVMwvsdholEl/mAMOBck+AuQaVM7GEVtJzBO2aO9PnmkjzqS6kejTxz6bs
	FQWoiYbajojN5i5bBywmAQjnPko8bj9/WrusDbT+zOJvzCrBkuSqzR4FRuNwvEuO
	QOlp3nMU6XrSy73t8UN55+4iUcxXfsAzzYmpaauTmXISrl5xCSbKmIUxralfelK1
	55XoayLY4sdFqMa6dDBNGzETzxyAehRiL6mqRQEep0pv4cXMcoilNdCnJDagLRLU
	09JHMRDYKO7AI4DWKbEb0cOL+FqvSeYyir0/NwtILtw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p209yst8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:48:35 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNmYYr017128
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:48:34 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:48:34 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:48:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:48:34 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNmK8r009908;
	Tue, 11 Feb 2025 18:48:23 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH v3 10/17] iio: adc: ad7768-1: Move buffer allocation to a separate function
Date: Tue, 11 Feb 2025 20:48:18 -0300
Message-ID: <20250211234818.1008765-1-Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: 7a8_z1Ee5dhMc-eXo1poqaXG5HSbrUv0
X-Proofpoint-GUID: 7a8_z1Ee5dhMc-eXo1poqaXG5HSbrUv0
X-Authority-Analysis: v=2.4 cv=VPInn8PX c=1 sm=1 tr=0 ts=67abe1d3 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=bQp4CLlzSgFOj8itWtUA:9 a=cZ_F8w-WQ4q-ELucWn4u:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=959 phishscore=0 adultscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

This change moves the buffer allocation in a separate function, making
space for adding another type of iio buffer if needed.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Added missing SoB.

v2 Changes:
* Interrupt and completion moved out from ad7768_triggered_buffer_alloc(). 
---
 drivers/iio/adc/ad7768-1.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5ee29f9813ce..378245bce199 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -618,6 +618,31 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
+					  indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad7768_trigger_ops;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+					       &iio_pollfunc_store_time,
+					       &ad7768_trigger_handler,
+					       &ad7768_buffer_ops);
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -688,20 +713,6 @@ static int ad7768_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
-					  indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->ops = &ad7768_trigger_ops;
-	iio_trigger_set_drvdata(st->trig, indio_dev);
-	ret = devm_iio_trigger_register(&spi->dev, st->trig);
-	if (ret)
-		return ret;
-
-	indio_dev->trig = iio_trigger_get(st->trig);
-
 	init_completion(&st->completion);
 
 	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
@@ -715,10 +726,7 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad7768_trigger_handler,
-					      &ad7768_buffer_ops);
+	ret = ad7768_triggered_buffer_alloc(indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1


