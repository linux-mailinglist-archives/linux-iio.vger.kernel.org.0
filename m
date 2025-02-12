Return-Path: <linux-iio+bounces-15467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05859A32E68
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19811637C9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC882627EB;
	Wed, 12 Feb 2025 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HfEIvTzn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCE25D54F;
	Wed, 12 Feb 2025 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384294; cv=none; b=W4RuU9d1Bg+BGWlMOWIIzg2TN+R/95LwDLTDcC25TYtlo9XSbLOd3f3FsJkN2VFWCWFB7LooxRz6z+BxA3aC+jMoNJkoE0agYhywU53cXzxv+fOyeqolPIHGpwh6bxFG0ygjAp5Ob7ObURsqeWBmvCrPsCfMxXhdl9ueiHBW5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384294; c=relaxed/simple;
	bh=Lq8NnCjIjCNUEajzrtRjsCYvKlCIlc4mjhIhL6vpkNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUU7Mm82ZZCTK1IICiq0SR99vn9a0erYFqDmEWczFZNqIlOuPFVVYShOXUG5ZRjX4UrBwDC3+t6y46lTixk2l9Q6mj3C3sor49QL+Ui6GM3l40Sx+3n25PJAkraVGSnLIpTBEdbKXCrRwdBOpGKyfAYUtG+ExrXnhME5RX0MhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HfEIvTzn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFWvfr023417;
	Wed, 12 Feb 2025 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kobpE
	+nfQOAOZCTakwt07iybo6qTTrsQ7C6TG5FANGc=; b=HfEIvTznY/RcC1/+UYUMY
	bTv43lV+jI3wjrZQfUpKkOKVE8Ugaf5DxEEU3N11PAu1IudDNMyrta8vEH6qIMGv
	1hJWqjXIQMxv+8OD9Bq6k2oMMtAeMsQuwu1sUiIi4TkQaQb3RFCzPjHzjsIQu6eC
	0wD15Wbb/i+DpdRVLglaRcgPggti1yu4Dp4UgY/hZMgrPo5MXjTiQ8z6sNv1Sb6y
	KzrwkJpS4J74bSqZi1Ezz2CBMzTISh6zPX8Tt0pj2vVDuONjxVPjTzbbzhlWvR+e
	bWcb+CqM2r2xzbT1zpzHrDeFwDJ0abO28XDnlZbRnzpL0YMoGGlRK7BxVBtMOWuf
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44rnspk2rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:17:56 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51CIHtab046510
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:17:55 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Feb
 2025 13:17:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:17:55 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIHd9B017489;
	Wed, 12 Feb 2025 13:17:42 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH RESEND v3 10/17] iio: adc: ad7768-1: Move buffer allocation to a separate function
Date: Wed, 12 Feb 2025 15:17:39 -0300
Message-ID: <d78aba0d188119bdfde7cb91041229ba16e8eeea.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RZxqC0tv c=1 sm=1 tr=0 ts=67ace5d4 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=bQp4CLlzSgFOj8itWtUA:9 a=cZ_F8w-WQ4q-ELucWn4u:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: dLuHzo0309wB4FQvujO1C5weOkBlCvoL
X-Proofpoint-ORIG-GUID: dLuHzo0309wB4FQvujO1C5weOkBlCvoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

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


