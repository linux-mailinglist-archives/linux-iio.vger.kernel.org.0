Return-Path: <linux-iio+bounces-13975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED3A04451
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030C23A66E2
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7944E1F3D50;
	Tue,  7 Jan 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uKl1doig"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4B1F3D47;
	Tue,  7 Jan 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263595; cv=none; b=o9VdEm2NY055n+eW+k9ZfYUdc5wiK3OqwpdpCQpZwMAxXIlki/PHTt//U07nrF2WTxCV4dw1Y1hN3apwKvFnZPyUGl2VNgMBq+SjyY63szwkAKIc6+MSFYBKlMNSeIJX+6Yh5UDNKFm2KY0TtpYlpNk4Uf8PPKtp/xc8f3N9atQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263595; c=relaxed/simple;
	bh=//YhO1vHDFcJnecO+j1i3SYnVgoxp/L5AtQKqvD8RoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyn5loqrBxa/CRVCEMclrcsQtaJ95vvbq0mXbsrdsKZd8QvopBucgXHo7KVqsWR9VK0qKfrm80FBsfo2cF3vUrVhwHYN4lIWqRxmOFKRXHSxwojVKNoGjZQ9K/4YqktXJiwfMdyirWBu8zxqe6JaC2EcC+qcNmECIVXP0Sez0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uKl1doig; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507FMD9A006478;
	Tue, 7 Jan 2025 10:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7FKwE
	pQ6Gqrgldo6YeTYW5LzkBBXRkYMO7MVcv+jW5U=; b=uKl1doig4BKK7lqWelgxr
	3K4OvCALdnJBmoXUvqU9RsINbLYVwjce238Tvnac1745GzmcpWr3jql2moWU6PU5
	CYzEOYwqpSbrELaGwIXkIcQ5iC/jDnkm0tWXo+kGmpWNU7dNXRTQYGgxSAqNlO2F
	zgeWs234O5GtXbNfWO+FpHjlQkA8360VVXkhyA2RLLHxPY1SdKQWfp5M1klmpXdH
	K8qRlpsvqv8UmP3TSFaFeVF+EXuwURAm+9zdnILDeXOJek6IFLzbZoVh95dG6VaP
	GBSg9QrwM74WLTu3LpYIUWLBJsnXoCURCeRPYWm9reO9DYCVXXD0/Q0wqgdHzPec
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4416uq00fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:26:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FQGX2034132
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:26:16 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:26:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:26:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:26:16 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FQ5A7030330;
	Tue, 7 Jan 2025 10:26:07 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 09/15] iio: adc: ad7768-1: Move buffer allocation to a separate function
Date: Tue, 7 Jan 2025 12:26:05 -0300
Message-ID: <319a685855eb4b942e05e456a37319d3f73f7cd4.1736201898.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: yZihgdy-52SDcHAa39eePCOSx1adu3RK
X-Proofpoint-GUID: yZihgdy-52SDcHAa39eePCOSx1adu3RK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070129

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

This change moves the buffer allocation in a separate function, making
space for adding another type of iio buffer if needed.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 64 ++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index cd1b08053105..eaa9a12737ac 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -163,6 +163,7 @@ struct ad7768_state {
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
+	int irq;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -569,6 +570,40 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
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
+	init_completion(&st->completion);
+
+	ret = devm_request_irq(indio_dev->dev.parent, st->irq,
+			       &ad7768_interrupt,
+			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			       indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
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
@@ -610,6 +645,7 @@ static int ad7768_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->mclk_freq = clk_get_rate(st->mclk);
+	st->irq = spi->irq;
 
 	mutex_init(&st->lock);
 
@@ -625,37 +661,11 @@ static int ad7768_probe(struct spi_device *spi)
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
-	init_completion(&st->completion);
-
 	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq,
-			       &ad7768_interrupt,
-			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-			       indio_dev->name, indio_dev);
-	if (ret)
-		return ret;
-
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad7768_trigger_handler,
-					      &ad7768_buffer_ops);
+	ret = ad7768_triggered_buffer_alloc(indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1


