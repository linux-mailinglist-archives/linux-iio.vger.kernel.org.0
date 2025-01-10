Return-Path: <linux-iio+bounces-14071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC90A08945
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 08:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B03D188C2FC
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A8207E00;
	Fri, 10 Jan 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zfzdCWgK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3D207A30;
	Fri, 10 Jan 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736495015; cv=none; b=t8r4A1YkLRnpCXp8GQpDvdJQ9v5U47NadbL2OVpYUL5gmgPwsqr3B/VFl4xEVDZ5GMD0OZPmWOlh2Hmr16ZgnPF2CE9YKOTUA/7RbmJRgyvV63hIl98jdfKyM1vo6/Ip3tFkSI4OyfKNIfmoon8dL2Gh/7/wCnWaVN9837ve5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736495015; c=relaxed/simple;
	bh=rd3FXGgAqTwR+g3lj+s2ypG6Iy9AFw7q9eKkIy/O/60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC6h5HsGMyzEx/3YReKz/xg+x7tKhEWAF9KENzDSEYb4smKbaIHjaLSGpqf9Bf+DdZ8B4+uOz6Gd1c9/Ghpk/Psfq+Ul2QkfkRlN+wWGaZK4mzETkCgGKX3o43SVd31CsVp08rEhGPzKH8t0U3ZJeJBTgUSlckT/xez9nf4zwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zfzdCWgK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A7PF9l010261;
	Fri, 10 Jan 2025 02:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3mMnW
	e4HdFkiy7CS2hRme26jqMY3as/Po58pX1Geves=; b=zfzdCWgKwkCi/CozgL1lj
	lvQ+TWo2a/8/vldzh4eikq89G9s4Q3R8o8Kn3sWV5W2xSb79nlVBFhtiw2ZfRNuu
	pGD81IkiLc0Hm4LdVZg8XEc0RaOSzN6L2IIsedmaxmsMIkCDKTOUlV3G5DrgkHsq
	XCr505Dk1I+WqUDlO5U/t+6K2SB3f9evm6dJlBpyQ/H9ZIyuSHMPAJjDG4riMct6
	0MAPDZjBAbQjMl+vPhnqLSpp3JcUfYqFsnoLtkMYxhCBZxS5FK5R9W+r/W8WKOGa
	rexPkVogVZGlzyyRzOsJz+82VwP4A7Qv4A5naVKzlf99HfMsiUlcicn80FvHR2zg
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 442y55828t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 02:43:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50A7hE07051816
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 02:43:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jan 2025 02:43:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jan 2025 02:43:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jan 2025 02:43:14 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50A7gvoq032122;
	Fri, 10 Jan 2025 02:43:06 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>,
        Alex Lanzano <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v4 1/6] iio: imu: adis: Add custom ops struct
Date: Fri, 10 Jan 2025 09:42:49 +0200
Message-ID: <20250110074254.38966-2-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110074254.38966-1-robert.budai@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 2HJDSIj9Ia_3uOrFId5pjkZqR9no8ao2
X-Proofpoint-GUID: 2HJDSIj9Ia_3uOrFId5pjkZqR9no8ao2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100063

This patch introduces a custom ops struct letting users define
custom read and write functions. Some adis devices might define
a completely different spi protocol from the one used in the
default implementation.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---
 drivers/iio/imu/adis.c       | 16 +++++++++++++---
 include/linux/iio/imu/adis.h | 28 +++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 494171844812..54915c7a3e76 100644
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
index 4bb98d9731de..89cfa75ae9ea 100644
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


