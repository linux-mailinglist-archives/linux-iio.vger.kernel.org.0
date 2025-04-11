Return-Path: <linux-iio+bounces-17964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD7A8629E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF081BC3833
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2D21A451;
	Fri, 11 Apr 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VMn6NZh8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4E5211A15;
	Fri, 11 Apr 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387082; cv=none; b=YUfHhEO7Aj7R7lNlvIQY11vdZOTvCV1pTV0C1R3oBlMy4hPYkaOayO5JZ8wR5EBTgkWqCuYy+nZX68CmT3ft7sLIyZou//dr+zh4WSAA09F8k7K9rbO4tTLogeNmp0vGSpasyxlCZWv6b0WpLLbyNWHAFXIPvh7pPk4m+oyPGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387082; c=relaxed/simple;
	bh=nyEkozhjfcZa5PRocazay7Uf8cQv5RSqC5XQAn7WlBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kM8w+hsBp7Btn9RyM1OZEr4/YT/INSVoYAL2lY3E4jRYEeOWKhUUeOIK6EfrezrsU3KbsE1aWYzG5qkPhrYveaswb0hLIkLezxBauRsp18AdGJ9cE1rUbsWKdfVyLxLlBOTpxQUN2X2jpLK4Kq4zBs/yd4UXImMbBOTWfbag504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VMn6NZh8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BDePY7015243;
	Fri, 11 Apr 2025 11:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=E9qMM
	oH6bhaj7QRhYtQMQfRp+qfxAP6mJTdN8IQn1DU=; b=VMn6NZh8zf3D6/08YUorB
	hPKyHWj4BsFdPrp1Gzna0Lp/uLpzg8ozEKVhQU1b7mLQvD4PY4GpABdGGW5ANbX9
	HG1+kKuhhe053BnKcXBVCQwMANqC7houZbMp84/Ph/MQx0GoLGZqivxAgzzeidhY
	/Y3aa0RnsQFZpDK65Hp4ijqd0EHaZt4aarpxJbf0k+ncJ8FVAmfeO49+pb39HxvQ
	H1m84bApjGV0ozhlITDD+LL+KCjy6qeNQqWhbJzI/rlV3NdM0f14fheYmD0NWcI2
	9XfUQPBfXU0rFcodmLKGIC0lLQiR1dE2bDNxkxUsOwtKySCnrOPk0anhoFj65vkv
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6uymc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:57:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFvgvg022293
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:57:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 11 Apr
 2025 11:57:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:57:42 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFvN6f015621;
	Fri, 11 Apr 2025 11:57:26 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH v5 07/14] iio: adc: ad7768-1: Move buffer allocation to a separate function
Date: Fri, 11 Apr 2025 12:57:23 -0300
Message-ID: <11c1777b406875ce1a7216dc4b094ff99af8da7f.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4AY1pLk9pZNJ_4BXlX_AM8tdMQod3vLH
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f93bf7 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=l9GLs7LQBT_n29Jb_ZMA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 4AY1pLk9pZNJ_4BXlX_AM8tdMQod3vLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

This change moves the buffer allocation and related trigger allocation
in a separate function, making space for adding another type of iio
buffer if needed.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v5 Changes:
* mentioned trigger allocation in the commit message.

v4 Changes:
* None.

v3 Changes:
* Added missing SoB.

v2 Changes:
* Interrupt and completion moved out from ad7768_triggered_buffer_alloc(). 
---
 drivers/iio/adc/ad7768-1.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 34712d3756e2..66087fabe181 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -619,6 +619,31 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
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
@@ -689,20 +714,6 @@ static int ad7768_probe(struct spi_device *spi)
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
@@ -716,10 +727,7 @@ static int ad7768_probe(struct spi_device *spi)
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


