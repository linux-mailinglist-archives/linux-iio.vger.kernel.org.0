Return-Path: <linux-iio+bounces-6481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B71490D2C5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BFF1F24536
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C098A14C5AA;
	Tue, 18 Jun 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wTi2rqOL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6D14A636
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717332; cv=none; b=Bs5YjWe1dJ/fGog6V7BX/N7pw86YyjPrHNVmFSHc69yiXSLsKh5dBNadCkEcnHW8P2ZmixfS/dfTjyJYRdMATt3FAoukJgh0og4TPACKCxN85O40YWcoiYc+LaIS8x2mVNqvPiZbmhndM+99e+8TT29srC7fP62VSlWAUCYxRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717332; c=relaxed/simple;
	bh=bPiyFzT1L+k2HGHGmdBgSmXMh5LVEZOHOGplK3IjmqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DiH9diY6HOKVi5frD4TfPY6ViZwx7C7YEfIFhZ47hCi6OFeXbHrc+kv4ppYQugLQcEnK9+4J70BU+6QxTQOrwXmtd69+VLoiEHLMjdyKcqhtW8KRHAiudbUG9ZYIuEZq+FCnACL5ihv9AkMj2l/lsyGS4eAQqAJvrGbMLsukG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wTi2rqOL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I99qYb006678;
	Tue, 18 Jun 2024 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=osbm3
	RrJa0hz5Qxm08vuIZzBA+/4DyuI9aoYAYrOt/8=; b=wTi2rqOLaPAtslzM76VM3
	mVcjl9F2wH+SmL/VEHCg83iQCRqGPkusGk3ydVRURRhFU2xjhHc4NQHJlooseQOH
	DOhuQugzVxGsipM8O2QEZdoc0f9M14LyjtYnKoamNc4JVeAhAgP70Az2gJYfHx71
	9vWOZouRqYbQP2x2kMtfCRPDUqMwiu61up6gmXGg7EgnizVqQHoDkuHqzVT5CcCZ
	Rj7m0KbyiFrZbyOCKR04ypboBd9VjSl4UeAC/RfNJu0TTfFrLqeGTlZmltH2+If4
	AbzogE2ImF00xxcSi3nXfsiMgXjQnD9gAFNjGLlqNzLrnDRYTlLCzEzwQxhTLEOs
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys4t33by5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSaCd062012
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Jun
 2024 09:28:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:35 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWM025769;
	Tue, 18 Jun 2024 09:28:27 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:05 +0200
Subject: [PATCH 2/9] iio: imu: adis: move to the cleanup magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-2-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=5144;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=bPiyFzT1L+k2HGHGmdBgSmXMh5LVEZOHOGplK3IjmqM=;
 b=AGcp6Ol4cgGSCHZo1tcg/M0QuTncICf4BS/FYik+HGM50S0vl9s7oVzecm4ZmjDOf4+vVFCFR
 McTvMNeGP9DA+I7EC4f77k+zEFPvnerFyd1O8FK2uiK8ztjzSzFulRP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: h1Re6TPsbBLTK3r0dsBY7nrFrcMqpMlN
X-Proofpoint-ORIG-GUID: h1Re6TPsbBLTK3r0dsBY7nrFrcMqpMlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=585 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

This makes locking and handling error paths simpler.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis.c        | 11 ++++-----
 drivers/iio/imu/adis_buffer.c |  8 ++-----
 include/linux/iio/imu/adis.h  | 54 +++++++++++--------------------------------
 3 files changed, 19 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 495caf4ce87a..876848b42f69 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -466,17 +466,17 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	unsigned int uval;
 	int ret;
 
-	mutex_lock(&adis->state_lock);
+	guard(mutex)(&adis->state_lock);
 
 	ret = __adis_read_reg(adis, chan->address, &uval,
 			      chan->scan_type.storagebits / 8);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	if (uval & error_mask) {
 		ret = __adis_check_status(adis);
 		if (ret)
-			goto err_unlock;
+			return ret;
 	}
 
 	if (chan->scan_type.sign == 's')
@@ -484,10 +484,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	else
 		*val = uval & ((1 << chan->scan_type.realbits) - 1);
 
-	ret = IIO_VAL_INT;
-err_unlock:
-	mutex_unlock(&adis->state_lock);
-	return ret;
+	return IIO_VAL_INT;
 }
 EXPORT_SYMBOL_NS_GPL(adis_single_conversion, IIO_ADISLIB);
 
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index d1d1e4f512b9..29cd8564cd32 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -130,24 +130,20 @@ static int adis_paging_trigger_handler(struct adis *adis)
 {
 	int ret;
 
-	mutex_lock(&adis->state_lock);
+	guard(mutex)(&adis->state_lock);
 	if (adis->current_page != 0) {
 		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
 		adis->tx[1] = 0;
 		ret = spi_write(adis->spi, adis->tx, 2);
 		if (ret) {
 			dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
-			mutex_unlock(&adis->state_lock);
 			return ret;
 		}
 
 		adis->current_page = 0;
 	}
 
-	ret = spi_sync(adis->spi, &adis->msg);
-	mutex_unlock(&adis->state_lock);
-
-	return ret;
+	return spi_sync(adis->spi, &adis->msg);
 }
 
 static irqreturn_t adis_trigger_handler(int irq, void *p)
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 4bb0a53cf7ea..93dad627378f 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -9,6 +9,7 @@
 #ifndef __IIO_ADIS_H__
 #define __IIO_ADIS_H__
 
+#include <linux/cleanup.h>
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/iio/iio.h>
@@ -150,13 +151,8 @@ int __adis_reset(struct adis *adis);
  */
 static inline int adis_reset(struct adis *adis)
 {
-	int ret;
-
-	mutex_lock(&adis->state_lock);
-	ret = __adis_reset(adis);
-	mutex_unlock(&adis->state_lock);
-
-	return ret;
+	guard(mutex)(&adis->state_lock);
+	return __adis_reset(adis);
 }
 
 int __adis_write_reg(struct adis *adis, unsigned int reg,
@@ -248,13 +244,8 @@ static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
 static inline int adis_write_reg(struct adis *adis, unsigned int reg,
 				 unsigned int val, unsigned int size)
 {
-	int ret;
-
-	mutex_lock(&adis->state_lock);
-	ret = __adis_write_reg(adis, reg, val, size);
-	mutex_unlock(&adis->state_lock);
-
-	return ret;
+	guard(mutex)(&adis->state_lock);
+	return __adis_write_reg(adis, reg, val, size);
 }
 
 /**
@@ -267,13 +258,8 @@ static inline int adis_write_reg(struct adis *adis, unsigned int reg,
 static int adis_read_reg(struct adis *adis, unsigned int reg,
 			 unsigned int *val, unsigned int size)
 {
-	int ret;
-
-	mutex_lock(&adis->state_lock);
-	ret = __adis_read_reg(adis, reg, val, size);
-	mutex_unlock(&adis->state_lock);
-
-	return ret;
+	guard(mutex)(&adis->state_lock);
+	return __adis_read_reg(adis, reg, val, size);
 }
 
 /**
@@ -365,12 +351,8 @@ int __adis_update_bits_base(struct adis *adis, unsigned int reg, const u32 mask,
 static inline int adis_update_bits_base(struct adis *adis, unsigned int reg,
 					const u32 mask, const u32 val, u8 size)
 {
-	int ret;
-
-	mutex_lock(&adis->state_lock);
-	ret = __adis_update_bits_base(adis, reg, mask, val, size);
-	mutex_unlock(&adis->state_lock);
-	return ret;
+	guard(mutex)(&adis->state_lock);
+	return __adis_update_bits_base(adis, reg, mask, val, size);
 }
 
 /**
@@ -411,24 +393,14 @@ int __adis_enable_irq(struct adis *adis, bool enable);
 
 static inline int adis_enable_irq(struct adis *adis, bool enable)
 {
-	int ret;
-
-	mutex_lock(&adis->state_lock);
-	ret = __adis_enable_irq(adis, enable);
-	mutex_unlock(&adis->state_lock);
-
-	return ret;
+	guard(mutex)(&adis->state_lock);
+	return __adis_enable_irq(adis, enable);
 }
 
 static inline int adis_check_status(struct adis *adis)
 {
-	int ret;
-
-	mutex_lock(&adis->state_lock);
-	ret = __adis_check_status(adis);
-	mutex_unlock(&adis->state_lock);
-
-	return ret;
+	guard(mutex)(&adis->state_lock);
+	return __adis_check_status(adis);
 }
 
 static inline void adis_dev_lock(struct adis *adis)

-- 
2.45.2


