Return-Path: <linux-iio+bounces-15638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1AAA382AB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E0116E944
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7821A92F;
	Mon, 17 Feb 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="d251JMds"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DB21A446;
	Mon, 17 Feb 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794448; cv=none; b=VLhafR/PjvPZEQ05FfYyy4byCn7d61uYxpg66p9SsP8nFPFBVClU6xzibBoDJsBuo61UqtZXcBxaELrDOAED/O7SSJob2EFQErfW0bd1gyihNOUP/CGBMz6muicRsa/x53QeIzH+KvgiuT9xtjI/Mw6z+IydeehuS82W0bDGIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794448; c=relaxed/simple;
	bh=gKnlqQwIWJydWcBvvCzlxzqh+wDTqZotubKJ/avoCj0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goPSHe4MsKiVMLq8VGuFSVxSCByrx53bI4xBqNbmMJXgJZ628Oi1U2yuTQQUfEKkSlx2rvo5G4FGchxeGu3w0SvZ6i/t6i/ukctZI4df4pi7ef3JA7ifMT7CCnEQpn1fQlarw0pjkuVbeNF8ZtheaWSD0bon3E+0y4DG8cMUBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=d251JMds; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HA0DjF030486;
	Mon, 17 Feb 2025 07:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DO0RJ
	Ba+JtpP1ssvnbbKsJvDUrfYqFTUgk+0lGXSgRk=; b=d251JMdsEnE0jh8wk0FpZ
	tc2SX7f1Yf2Mmzpl7/lyARU2wx209jYbgYxXO/ovxqwBstXzyhyPqlU0IfPBikMv
	AaAE4hz6066r0lWdIPecFVzhmZ9YuA+n2SKgt3nlxjiF67B3zETCoCXFaSn0PoPV
	KM9WzmnGpY0r9PoopiwI58mB6Ak/QVClcmZ6PeTb/2RAy9pqCiRtpKrjjsBSZMBg
	KxPEGkJOrv6uGOhKyILrHjOTCURV4MJ4qtWa+Z6s5YqitZh3GyaqFCHzkc5Gcece
	xJa/WHt/NNsTRwYqO9ajGKWXBjMRW9zlRyxHYjzPIZ1lI0wXjeEXlfnP5WzkKDfG
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44v2ysrfg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 07:13:53 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51HCDqFn017784
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Feb 2025 07:13:52 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 17 Feb
 2025 07:13:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Feb 2025 07:13:51 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51HCDZMP016764;
	Mon, 17 Feb 2025 07:13:47 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 1/6] iio: imu: adis: Add custom ops struct
Date: Mon, 17 Feb 2025 12:12:14 +0200
Message-ID: <20250217101221.600898-2-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217101221.600898-1-robert.budai@analog.com>
References: <20250217101221.600898-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: l4jN13N7vwnaKdkBIbSJbmFdFJ_NEUcr
X-Proofpoint-ORIG-GUID: l4jN13N7vwnaKdkBIbSJbmFdFJ_NEUcr
X-Authority-Analysis: v=2.4 cv=ELj800ZC c=1 sm=1 tr=0 ts=67b32801 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=8Sk9WFORyD1BVUOr6f4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=993
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170107

This patch introduces a custom ops struct letting users define custom read and
write functions. Some adis devices might define a completely different spi
protocol from the one used in the default implementation.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v8:
- no changes

 drivers/iio/imu/adis.c       | 16 +++++++++++++---
 include/linux/iio/imu/adis.h | 28 +++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 494171844..54915c7a3 100644
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
 EXPORT_SYMBOL_NS_GPL(__adis_update_bits_base, "IIO_ADISLIB");
 
@@ -468,7 +468,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 
 	guard(mutex)(&adis->state_lock);
 
-	ret = __adis_read_reg(adis, chan->address, &uval,
+	ret = adis->ops->read(adis, chan->address, &uval,
 			      chan->scan_type.storagebits / 8);
 	if (ret)
 		return ret;
@@ -488,6 +488,11 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_NS_GPL(adis_single_conversion, "IIO_ADISLIB");
 
+static const struct adis_ops adis_default_ops = {
+	.read = __adis_read_reg,
+	.write = __adis_write_reg,
+};
+
 /**
  * adis_init() - Initialize adis device structure
  * @adis:	The adis device
@@ -517,6 +522,11 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 
 	adis->spi = spi;
 	adis->data = data;
+	if (!adis->ops->write && !adis->ops->read)
+		adis->ops = &adis_default_ops;
+	else if (!adis->ops->write || !adis->ops->read)
+		return -EINVAL;
+
 	iio_device_set_drvdata(indio_dev, adis);
 
 	if (data->has_paging) {
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 4bb98d973..89cfa75ae 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -94,6 +94,18 @@ struct adis_data {
 	unsigned int burst_max_speed_hz;
 };
 
+/**
+ * struct adis_ops: Custom ops for adis devices.
+ * @write: Custom spi write implementation.
+ * @read: Custom spi read implementation.
+ */
+struct adis_ops {
+	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
+		     unsigned int size);
+	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
+		    unsigned int size);
+};
+
 /**
  * struct adis - ADIS device instance data
  * @spi: Reference to SPI device which owns this ADIS IIO device
@@ -101,6 +113,7 @@ struct adis_data {
  * @data: ADIS chip variant specific data
  * @burst_extra_len: Burst extra length. Should only be used by devices that can
  *		     dynamically change their burst mode length.
+ * @ops: ops struct for custom read and write functions
  * @state_lock: Lock used by the device to protect state
  * @msg: SPI message object
  * @xfer: SPI transfer objects to be used for a @msg
@@ -116,6 +129,7 @@ struct adis {
 
 	const struct adis_data	*data;
 	unsigned int		burst_extra_len;
+	const struct adis_ops	*ops;
 	/**
 	 * The state_lock is meant to be used during operations that require
 	 * a sequence of SPI R/W in order to protect the SPI transfer
@@ -168,7 +182,7 @@ int __adis_read_reg(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
 				     u8 val)
 {
-	return __adis_write_reg(adis, reg, val, 1);
+	return adis->ops->write(adis, reg, val, 1);
 }
 
 /**
@@ -180,7 +194,7 @@ static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
 				      u16 val)
 {
-	return __adis_write_reg(adis, reg, val, 2);
+	return adis->ops->write(adis, reg, val, 2);
 }
 
 /**
@@ -192,7 +206,7 @@ static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
 				      u32 val)
 {
-	return __adis_write_reg(adis, reg, val, 4);
+	return adis->ops->write(adis, reg, val, 4);
 }
 
 /**
@@ -207,7 +221,7 @@ static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
 	unsigned int tmp;
 	int ret;
 
-	ret = __adis_read_reg(adis, reg, &tmp, 2);
+	ret = adis->ops->read(adis, reg, &tmp, 2);
 	if (ret == 0)
 		*val = tmp;
 
@@ -226,7 +240,7 @@ static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
 	unsigned int tmp;
 	int ret;
 
-	ret = __adis_read_reg(adis, reg, &tmp, 4);
+	ret = adis->ops->read(adis, reg, &tmp, 4);
 	if (ret == 0)
 		*val = tmp;
 
@@ -244,7 +258,7 @@ static inline int adis_write_reg(struct adis *adis, unsigned int reg,
 				 unsigned int val, unsigned int size)
 {
 	guard(mutex)(&adis->state_lock);
-	return __adis_write_reg(adis, reg, val, size);
+	return adis->ops->write(adis, reg, val, size);
 }
 
 /**
@@ -258,7 +272,7 @@ static int adis_read_reg(struct adis *adis, unsigned int reg,
 			 unsigned int *val, unsigned int size)
 {
 	guard(mutex)(&adis->state_lock);
-	return __adis_read_reg(adis, reg, val, size);
+	return adis->ops->read(adis, reg, val, size);
 }
 
 /**
-- 
2.34.1


