Return-Path: <linux-iio+bounces-14624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD840A1D934
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AAF3A6A89
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4301527B4;
	Mon, 27 Jan 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pNUNnfCg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5B1459EA;
	Mon, 27 Jan 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990830; cv=none; b=fUMWVXnIyTrCu3giZUnNT/CEhQ+f+1PNLvoqPTw1SWWKeoSeZxh5AN2+gK0sXR7LwXC6myCd1lOvNHq37sdkAVJ62hKnLFotHdNJf64wrwkbcVdx3RbKeo+pD4DGm7UmPlxcvWJQ+7sbRuzqAZZRMLTqf17ZqgXPg4TKy2vXlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990830; c=relaxed/simple;
	bh=sfSFG1mIvvGCrmpLtzLP0iNgsVeQH9Rj3MrsUHkwf2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UD8b7b/KsoZ3yfQXU0nuSLMzwbObLj52XbO/8Z+w6C8r8+8ZEweWNhupTjVqf6YKNl/2VNXF0SxxkE0dwqcPAk2r9uUQfUpKL6dr+d9n/e7Yu0EF4fQBmykDASSHh50MXtGUM09/UpKx0mGf91i2qb1tGHaUF0yfOHuHeqiIfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pNUNnfCg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWC1C005706;
	Mon, 27 Jan 2025 10:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aWWkt
	ta/iDz0tox3nfpUU8OtKDPOnChM112KjqJdg5U=; b=pNUNnfCg/mCiHepCILEjk
	Q3UqZ3F0oqLtCp+NmoKj+2zfsyAO6jtYmnhEAxH88szRRED/FZdCCO4bZKaXGdlJ
	NGVHXbziPEHR9CE0r2jUZX2d9TCcvmPyQpQA/rODU5ypl7CdRhypvmIh1tKnmKdL
	THahnqWmdHDQrqH6Xv72p/0lttu0UUs55Q9sUfawgghOmEzVAAj+hEJYTnIsFr1G
	FlqZpbpQLJq7WyHhJVrVHn315oq7m9t8yW9yfJtBsA0JuXXH1oXXd9plvZLvTsZb
	BzJnTbRSBldryWAD2UgOTbQhpHGhxduZVxHgeLUzJredS/mCryOyPc9IozRlWjdr
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:13:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RFDXDn038615
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:13:33 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:13:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:13:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:13:33 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFDKd5008445;
	Mon, 27 Jan 2025 10:13:22 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 10/16] iio: adc: ad7768-1: Move buffer allocation to a separate function
Date: Mon, 27 Jan 2025 12:13:19 -0300
Message-ID: <e39115cee88524f05c8a628b0d3836928c6cc190.1737985435.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: 4L8S55vDS4sHJR5uE6uznT0L5Nr82OAw
X-Proofpoint-GUID: 4L8S55vDS4sHJR5uE6uznT0L5Nr82OAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

This change moves the buffer allocation in a separate function, making
space for adding another type of iio buffer if needed.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
v2 Changes:
* Interrupt and completion moved out from ad7768_triggered_buffer_alloc(). 
---
 drivers/iio/adc/ad7768-1.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5e2093be9b92..8487b9a06609 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -599,6 +599,31 @@ static const struct regmap_config ad7768_regmap_config = {
 	.max_register = AD7768_REG_MCLK_COUNTER,
 };
 
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
@@ -669,20 +694,6 @@ static int ad7768_probe(struct spi_device *spi)
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
@@ -696,10 +707,7 @@ static int ad7768_probe(struct spi_device *spi)
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


