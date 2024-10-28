Return-Path: <linux-iio+bounces-11456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32C9B3025
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04642819AE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AA1DA0E3;
	Mon, 28 Oct 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="edufuw0S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9C1D7E3E;
	Mon, 28 Oct 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118406; cv=none; b=rQ8qOe0IbRzsNVQNI3XwQrlpAqFcjaioIjC6CLyBHFeyrgF1M8Avn7ywHXrK5sX8bNrMAufsWghppkriMJN6wAq7l7pX91rWbZL7H1KKTxckb1ihOe1MehPTA7yuQoAbIb6s1nS8z2bW/kJqM87U4aK8NhQr06udb/BuOaftSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118406; c=relaxed/simple;
	bh=kUy96+1YL6rY5dXABCogjeyQzUW6sTAqmeIQ7QIFqiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7dNuNMQO5llx3IfSW69r++SXxcWrqmgtslZnIvyL+U0uDmfBQW6otxsN+Oa7WRMdKwa5KcJwEXAdP4mv9A+CCmXLcDcpBOxfdGwOrB2qWncyd+0+fsUQMmBz9Hq9HkoKy5fuLICXWx1DanqfX2qFNRxnnkvdhcRjv9IMgGQeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=edufuw0S; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S7ilqw007167;
	Mon, 28 Oct 2024 08:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KEIGt
	63gUNqy4qOEW6D+0omjcXwU3bil/V7OxRs9hSQ=; b=edufuw0SwZHduGkdYFlfk
	6oSpHccI/4FFRXqWfYRLu4q53EIAoJzMk18c0qFWj6buvA4BVYAZVHRj2RovXSVy
	uEwEny9uLVWwLfwflMkexJxDa5MwcHZ9VkbIhrZZ65qMMta1RtRs46ouIP1G1IO9
	m78bUWeAxTup2LBHYM7x70lztxI+tbpQQzLqds6CSqSBNGF+7qeP0CrrEkjhlW/b
	QcgqSKV1CG/LSXIKpkXMlMc7Yf41Nra0UZagI40wRLWiwMVZk3+ZXEioV1YnzNK9
	NKWd1xUzVkCxTsjFj8xOTjLC8DzvV5SjKeF9GLxLM/LR+LPuRAPFJ6Ib3WNcKd0S
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42gwb2fy1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:26:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49SCQMGk024356
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 08:26:22 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Oct 2024 08:26:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Oct 2024 08:26:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Oct 2024 08:26:21 -0400
Received: from dell-precision-robert.ad.analog.com ([10.48.65.123])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49SCQ0aL026080;
	Mon, 28 Oct 2024 08:26:16 -0400
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jagath Jog J
	<jagathjog1996@gmail.com>,
        Robert Budai <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH 1/5] iio: imu: adis: Add custom ops struct
Date: Mon, 28 Oct 2024 14:25:33 +0200
Message-ID: <20241028122543.8078-2-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028122543.8078-1-robert.budai@analog.com>
References: <20241028122543.8078-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Ckl3cWzXg5XA_TkaFAt4KMMp8fvzZgTp
X-Proofpoint-GUID: Ckl3cWzXg5XA_TkaFAt4KMMp8fvzZgTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280100

From: Nuno Sá <nuno.sa@analog.com>

This patch introduces a custom ops struct letting users define
custom read and write functions. Some adis devices might define
a completely different spi protocol from the one used in the
default implementation.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis.c       | 21 ++++++++++++++++-----
 include/linux/iio/imu/adis.h | 30 +++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 99410733c1ca..504d18a36f90 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -223,13 +223,13 @@ int __adis_update_bits_base(struct adis *adis, unsigned int reg, const u32 mask,
 	int ret;
 	u32 __val;
 
-	ret = __adis_read_reg(adis, reg, &__val, size);
+	ret = adis->ops->read(adis, reg, &__val, size);
 	if (ret)
 		return ret;
 
 	__val = (__val & ~mask) | (val & mask);
 
-	return __adis_write_reg(adis, reg, __val, size);
+	return adis->ops->write(adis, reg, __val, size);
 }
 EXPORT_SYMBOL_NS_GPL(__adis_update_bits_base, IIO_ADISLIB);
 
@@ -339,8 +339,11 @@ int __adis_reset(struct adis *adis)
 	int ret;
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
-	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
-				 ADIS_GLOB_CMD_SW_RESET);
+	if (adis->ops->reset)
+		ret = adis->ops->reset(adis);
+	else
+		ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
+					 ADIS_GLOB_CMD_SW_RESET);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
 		return ret;
@@ -468,7 +471,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 
 	guard(mutex)(&adis->state_lock);
 
-	ret = __adis_read_reg(adis, chan->address, &uval,
+	ret = adis->ops->read(adis, chan->address, &uval,
 			      chan->scan_type.storagebits / 8);
 	if (ret)
 		return ret;
@@ -488,6 +491,11 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_NS_GPL(adis_single_conversion, IIO_ADISLIB);
 
+static const struct adis_ops adis_default_ops = {
+	.read = __adis_read_reg,
+	.write = __adis_write_reg,
+};
+
 /**
  * adis_init() - Initialize adis device structure
  * @adis:	The adis device
@@ -517,6 +525,9 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 
 	adis->spi = spi;
 	adis->data = data;
+	if (!adis->ops->write || !adis->ops->read)
+		adis->ops = &adis_default_ops;
+
 	iio_device_set_drvdata(indio_dev, adis);
 
 	if (data->has_paging) {
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index e6a75356567a..7b589cc83380 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -94,6 +94,21 @@ struct adis_data {
 	unsigned int burst_max_speed_hz;
 };
 
+/**
+ * struct adis_ops: Custom ops for adis devices.
+ * @write: Custom spi write implementation.
+ * @read: Custom spi read implementation.
+ * @reset: Custom sw reset implementation. The custom implementation does not
+ *	   need to sleep after the reset. It's done by the library already.
+ */
+struct adis_ops {
+	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
+		     unsigned int size);
+	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
+		    unsigned int size);
+	int (*reset)(struct adis *adis);
+};
+
 /**
  * struct adis - ADIS device instance data
  * @spi: Reference to SPI device which owns this ADIS IIO device
@@ -117,6 +132,7 @@ struct adis {
 
 	const struct adis_data	*data;
 	unsigned int		burst_extra_len;
+	const struct adis_ops	*ops;
 	/**
 	 * The state_lock is meant to be used during operations that require
 	 * a sequence of SPI R/W in order to protect the SPI transfer
@@ -169,7 +185,7 @@ int __adis_read_reg(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
 				     u8 val)
 {
-	return __adis_write_reg(adis, reg, val, 1);
+	return adis->ops->write(adis, reg, val, 1);
 }
 
 /**
@@ -181,7 +197,7 @@ static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
 				      u16 val)
 {
-	return __adis_write_reg(adis, reg, val, 2);
+	return adis->ops->write(adis, reg, val, 2);
 }
 
 /**
@@ -193,7 +209,7 @@ static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
 				      u32 val)
 {
-	return __adis_write_reg(adis, reg, val, 4);
+	return adis->ops->write(adis, reg, val, 4);
 }
 
 /**
@@ -208,7 +224,7 @@ static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
 	unsigned int tmp;
 	int ret;
 
-	ret = __adis_read_reg(adis, reg, &tmp, 2);
+	ret = adis->ops->read(adis, reg, &tmp, 2);
 	if (ret == 0)
 		*val = tmp;
 
@@ -227,7 +243,7 @@ static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
 	unsigned int tmp;
 	int ret;
 
-	ret = __adis_read_reg(adis, reg, &tmp, 4);
+	ret = adis->ops->read(adis, reg, &tmp, 4);
 	if (ret == 0)
 		*val = tmp;
 
@@ -245,7 +261,7 @@ static inline int adis_write_reg(struct adis *adis, unsigned int reg,
 				 unsigned int val, unsigned int size)
 {
 	guard(mutex)(&adis->state_lock);
-	return __adis_write_reg(adis, reg, val, size);
+	return adis->ops->write(adis, reg, val, size);
 }
 
 /**
@@ -259,7 +275,7 @@ static int adis_read_reg(struct adis *adis, unsigned int reg,
 			 unsigned int *val, unsigned int size)
 {
 	guard(mutex)(&adis->state_lock);
-	return __adis_read_reg(adis, reg, val, size);
+	return adis->ops->read(adis, reg, val, size);
 }
 
 /**
-- 
2.34.1


