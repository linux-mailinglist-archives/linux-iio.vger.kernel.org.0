Return-Path: <linux-iio+bounces-13974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788DA04449
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A202D1887D13
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6B1F2C5B;
	Tue,  7 Jan 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XiN9jICc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590691F2C5C;
	Tue,  7 Jan 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263583; cv=none; b=ImuYjuUqDqGaoYvpQ4enrIxzWfIv3//R6IQxmk7dZEhTTp1F972kRKLX5Z7fsDxbcKdpPs38tpHXI/Hu+9sBJWY1+sgLTAj/orRU0SbtpVoaDdMcOG/I1VLXzAV56oF2yPgpgyCASQe+7B1LfB30S+IuAEjLx9y0yN5xgTXTIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263583; c=relaxed/simple;
	bh=uvreyaRFtATecQwzX+B3aWbnYMOJICETGlSVhmuPhFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBpGFMRZKIyFJiwS/6OTLOguBIp+Oc0rlYDgkO7V9U4GiHW4xnKhaPfAUc4pTROM3AUuJYjOvjMjQE5QelzkkfD/ZS/MQmlRenUKlEYSisLWiDJC01uG/myTrCXGLhwSJVKO+w4koJoaCSjFqGX22CsZ1P/UkpFjnESfhPoHH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XiN9jICc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvDkB013534;
	Tue, 7 Jan 2025 10:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J02GL
	Q1ndy2kqxzkYgt1EGsDeF04uTOSF4FUNv/2LDs=; b=XiN9jICcemtwZUrrrA78F
	QYnB0AEj4tFxheeQ2V1xqi60oluBUExs6L7I1DYrlP17tobQm7GWV6cWNf+3O0C5
	ZC/Bip4JjPlZUakPVxALUUODDh9MjSw2szwk/EbYSh1sH3FA5c5w8066BA1cGNvA
	MTwLHT0YZdZM0So+tIWbK1RpKqYo7OJOxGzELNzaVP8gG90Pvl5exQh+3+nregk8
	pdgjnk2Z1DOa+DGt/HWC3fgbfsraF41YsTTTursXdHu0T4mX+3kBJonxU4cU3rBx
	zRWFFgBIXFHBL3zK67lxesX8mjZ+xRkfplKz9wSQsVFP7kyyPSn3FtndxHlh+1Py
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gdkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:26:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FQ79h034123
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:26:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:26:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:26:07 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FPstS030327;
	Tue, 7 Jan 2025 10:25:56 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 08/15] iio: adc: ad7768-1: use guard(mutex) to simplify code
Date: Tue, 7 Jan 2025 12:25:53 -0300
Message-ID: <245cce4d379d225ab6794fc3326d95f88d2abf1a.1736201898.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: wT2uPtP26k5tpIiYzo2FTuLy54G5pDUF
X-Proofpoint-GUID: wT2uPtP26k5tpIiYzo2FTuLy54G5pDUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=940 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070129

Use guard(mutex) from cleanup.h to remove most of the gotos and to make
the code simpler and less likely to fail due to forgetting to unlock
the resources.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index f73b9aec8b0f..cd1b08053105 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -5,6 +5,7 @@
  * Copyright 2017 Analog Devices Inc.
  */
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -257,20 +258,12 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 			     unsigned int *readval)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
-	if (readval) {
-		ret = ad7768_spi_reg_read(st, reg, readval, 1);
-		if (ret < 0)
-			goto err_unlock;
-	} else {
-		ret = ad7768_spi_reg_write(st, reg, writeval);
-	}
-err_unlock:
-	mutex_unlock(&st->lock);
+	guard(mutex)(&st->lock);
+	if (readval)
+		return ad7768_spi_reg_read(st, reg, readval, 1);
 
-	return ret;
+	return ad7768_spi_reg_write(st, reg, writeval);
 }
 
 static int ad7768_set_dig_fil(struct ad7768_state *st,
@@ -484,7 +477,7 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = spi_read(st->spi, &st->data.scan.chan, 3);
 	if (ret < 0)
@@ -495,7 +488,6 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 
 err_unlock:
 	iio_trigger_notify_done(indio_dev->trig);
-	mutex_unlock(&st->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.34.1


