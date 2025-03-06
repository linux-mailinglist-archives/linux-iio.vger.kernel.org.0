Return-Path: <linux-iio+bounces-16498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96330A55820
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CDA7A8F32
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9427815A;
	Thu,  6 Mar 2025 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="N+gnyVjc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477B27701D;
	Thu,  6 Mar 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294954; cv=none; b=qfOEkYdRJtP9g2P6R771IEtNjz+thihj9D0yYuo3f+FdMz0oDerxK3OT8sVmPcNV08FZcURNQ3CThmKDNOCHgHvBAw709IOwtxuiT8H4V9ecXNZeLcy4iKzSPAKZxoESdxJG+CxJBgeZpj6dgtQfw9LOZhxKRrQgsqzuWAmsRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294954; c=relaxed/simple;
	bh=qJGgYPaJ8eZ5mXSJIpB0nbyygaKDgZbULIHM5oK4rGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdu7g6MkWGDSD3YbKuuTcnlHNfe8KsDUSiw4h23ncyCZGqvWNjrqeNSOVMntj16RdJ74lTQsqkIoB9hx8YgieC6A7yoY4D4pU2bLIuiOONFtdWl7rhPWTvDACf9mZVMw4RFcBb3S/VMlDI+Yg5T7DczAHZDP28u7RxP6NxmCFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=N+gnyVjc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfeGc032520;
	Thu, 6 Mar 2025 16:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mRBie
	yVgsay9GlcSCxytXnDjHv9W34faqG0WSal8uWs=; b=N+gnyVjc/c/YfG7SRdK5H
	X/d4Gf3JWmMFSFHt0FCrpxy0OT4loyxrIMXb7BNYHeyS8YvYeJRArChkeIVUOdC8
	FYHnCvESsIFdjbOxUaduhiL80PF9er2kI5oU2izwZYt9wyZ5XbsKf9F51LtwctNP
	jPBHhi+mxBGAMYO5hVeZlrKQ9l4JotuU7SMsyZp3xe5EE5auS6+HiXfUz+OSKNRT
	T6p7qqL4QcNuulwcEECfKJXi3LLi3dA+k1ZvQ+3XN+fEOX5fKyuEc7bddUVgvwzu
	xdZoVc8orHLbnE5BvZ4DXknXFcG8q2ZWLJ+ISx3OWG4v7cgh6CJE+05IwCTcFZrU
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 457d6x1t2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:02:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526L290q034917
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:02:09 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:02:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:02:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:02:08 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L1qVI011510;
	Thu, 6 Mar 2025 16:01:54 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 07/17] iio: adc: ad7768-1: remove unnecessary locking
Date: Thu, 6 Mar 2025 18:01:51 -0300
Message-ID: <d0450b7c5d8467e54913ef905f6147baa2b866b3.1741268122.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: 2XHgFoqEQ0PJ5UHhy0kVqwuQ-NmtFO90
X-Proofpoint-ORIG-GUID: 2XHgFoqEQ0PJ5UHhy0kVqwuQ-NmtFO90
X-Authority-Analysis: v=2.4 cv=E4w3pbdl c=1 sm=1 tr=0 ts=67ca0d52 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=YKUZDo64jDh34TQBkAoA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

The current locking is only preventing a triggered buffer Transfer and a
debugfs register access from happening at the same time. If a register
access happens during a buffered read, the action is doomed to fail anyway,
since we need to write a magic value to exit continuous read mode.

Remove locking from the trigger handler and use
iio_device_claim_direct_mode() instead in the register access function.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* None.

v3 Changes:
* Also removed the mutex_init and lock variable.

v2 Changes:
* New patch in v2. It replaces the guard(mutex) patch. 
---
 drivers/iio/adc/ad7768-1.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 2e2d50ccb744..f5509a0a36ab 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -154,7 +154,6 @@ static const struct iio_chan_spec ad7768_channels[] = {
 struct ad7768_state {
 	struct spi_device *spi;
 	struct regulator *vref;
-	struct mutex lock;
 	struct clk *mclk;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
@@ -256,18 +255,21 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
 	if (readval) {
 		ret = ad7768_spi_reg_read(st, reg, 1);
 		if (ret < 0)
-			goto err_unlock;
+			goto err_release;
 		*readval = ret;
 		ret = 0;
 	} else {
 		ret = ad7768_spi_reg_write(st, reg, writeval);
 	}
-err_unlock:
-	mutex_unlock(&st->lock);
+err_release:
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -471,18 +473,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
-
 	ret = spi_read(st->spi, &st->data.scan.chan, 3);
 	if (ret < 0)
-		goto err_unlock;
+		goto out;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
 					   iio_get_time_ns(indio_dev));
 
-err_unlock:
+out:
 	iio_trigger_notify_done(indio_dev->trig);
-	mutex_unlock(&st->lock);
 
 	return IRQ_HANDLED;
 }
@@ -611,8 +610,6 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->mclk_freq = clk_get_rate(st->mclk);
 
-	mutex_init(&st->lock);
-
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
-- 
2.34.1


