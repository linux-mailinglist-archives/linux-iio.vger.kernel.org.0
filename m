Return-Path: <linux-iio+bounces-14623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E617CA1D930
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3458218857AC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAA13B791;
	Mon, 27 Jan 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="y6mfP9fE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72313B5B6;
	Mon, 27 Jan 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990819; cv=none; b=AZVwr9F823bbFVEdcAqBbfmiobPHpKyNSwDRmcNAZYzayuo79TbLr+UULKAltdkRcTqidci94SBCJyQwK3VQxG1JA/YJXTrkFZY9J/fE0/2IAqlPthXGpD7r0mZEzAW0lGjr1Wke5N8l8skSGYzvL2XZ3OQ4/xY4vBuhK3bQuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990819; c=relaxed/simple;
	bh=I22clmVwyufQwEcNE2m05C3Vb5CThRV0Bf6o5dgQa2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sci2YKHNZJQPwbqvnB0KMTiEthFXqqwe0RcDfiP5qXqNw31oxx/K6Y4kA8U3HNTCha1woy8009TMxpIotu/txsPMIVrCixeJCnGyTFxrdO5RamSfdV8M6Jowg86i17todfXcEbvtIhx2GH2NLoxmtak0cmvCChNhBCpljFHbfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=y6mfP9fE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9qf6v005403;
	Mon, 27 Jan 2025 10:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4ebmO
	gvQRBzX5YjraOddcIxtsiSsI8MSGHond3auCXU=; b=y6mfP9fE4iK3o0hrbKR1w
	gPAfucPykiQINbDzAsvcaBq9ssN3pAfcCPFHoylUTYt4/VX43TbKSOz0J9BdBU7K
	GqYsEV7vRy3zPXphBepBsuoBiUHhB2m+pTSE3/hVhR6eMlZp8B+flcxXBf/c60aS
	hCXDNl46a/sH/StTl2OwSNemq6GW1N993O89oG8XV05NAoPLsFFOnMd9FgFDgbB7
	foSxequaKQAzGzvwbjXT0OLYubQXHCUPEGzw4WxDlPV5QFFm1TUoTB2fBqsGwBcy
	oKxg5EvXySpdGxT3SshKJigV3ajWEc+ZQ9LdDb2VWbS3xnBP26nLw1aCb3+KXZ/z
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e2n128d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:13:23 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFDMZf011064
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:13:22 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:13:22 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:13:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:13:22 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFD8AJ008439;
	Mon, 27 Jan 2025 10:13:11 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 09/16] iio: adc: ad7768-1: remove unnecessary locking
Date: Mon, 27 Jan 2025 12:13:08 -0300
Message-ID: <df331cd681feb756d06df4173f67f75ec655bfb2.1737985435.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: 8jY4s75ewN2vI22jjL35FRfYYGj7hL9C
X-Proofpoint-ORIG-GUID: 8jY4s75ewN2vI22jjL35FRfYYGj7hL9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=997
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

The current locking is only preventing a triggered buffer Transfer and a
debugfs register access from happening at the same time. If a register
access happens during a buffered read, the action is doomed to fail anyway,
since we need to write a magic value to exit continuous read mode.

Remove locking from the trigger handler and use
iio_device_claim_direct_mode() instead in the register access function.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* New patch in v2. It replaces the guard(mutex) patch. 
---
 drivers/iio/adc/ad7768-1.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 17a49bf74637..5e2093be9b92 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -271,16 +271,16 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
-	if (readval) {
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	if (readval)
 		ret = regmap_read(st->regmap, reg, readval);
-		if (ret)
-			goto err_unlock;
-	} else {
+	else
 		ret = regmap_write(st->regmap, reg, writeval);
-	}
-err_unlock:
-	mutex_unlock(&st->lock);
+
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -495,18 +495,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
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
-- 
2.34.1


