Return-Path: <linux-iio+bounces-14983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1288A2774C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F2D188620A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D9215F41;
	Tue,  4 Feb 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0OsaNonB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD728215774;
	Tue,  4 Feb 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687088; cv=none; b=PFSLrcbDhbewIi9iHGfni/5P9yDVYE0BwvPwbXN1+PABvq+rRZV7pI0zHuEXZJPjCzirD7qga7zGwBXAH8zLZfOFL+Ef269i5XlS2XYQwqgExwx3MlU5a3O/zYvJeXCd0QbqHv9a+CyWvXTqG2qHJEkM5MLuVeg4BSTFUW3azPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687088; c=relaxed/simple;
	bh=YpeZaIgbE5/cgqfAItvWdJWgGfO0M1D6I9IXBbIxi54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niQhBMTiVNrHWi29zx9bee3TaYqHPl8Ne583sSo16DoauxELepjux8o80eWyt6SqDdXVQwHO0ubhB93HRzWArLJTlWwYnqvWHC4LpSl6pCkVZfeAf4D2QS+Md3gL+ckqbUgH8iRpXliJ+H5n0Q/+N1s3X9IOf3jC+eyqGRC3++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0OsaNonB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GLphE002559;
	Tue, 4 Feb 2025 11:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l8yrz
	dO1GnBdIzo4UI1KLVX0x+20aanSog7xa9uLpec=; b=0OsaNonBiU3yfrci7q5Ja
	WV4v+BJPqElbeY+tHvHZGmnCUAedv8T3xfYM/jLlkzafYfEdzX176GDzO+zolMzc
	CvRFSpammhp+I2d8SDI+pdZLYTPSDKxKg8h++w3ILrgERCfUVc6x2RpwLS63j2gm
	48bjFaQ+lypVVfciepGLSMWP/QKKCFJwKlM2P8i7iBQwdCf0Pj/5tv4FyG3dg8c1
	DSOHXYEY5w9aa6QwRcLaao/tAWrX8ufFwNNv2vMMmGIv+UFeHTNOBRcDRDNkNcoJ
	tjnIz3Xz0bDknePV8hrUwtUaBR7gu/AiwF8Z6ZnUMZQUIMDvvjrfN30nKr4+j9k/
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44kpbmg23x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 11:37:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 514Gblfg029216
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 11:37:47 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 11:37:47 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 11:37:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 11:37:47 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514GbMFG009577;
	Tue, 4 Feb 2025 11:37:40 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        "Paul
 Cercueil" <paul@crapouillou.net>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        "Robert
 Budai" <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v6 1/6] iio: imu: adis: Add custom ops struct
Date: Tue, 4 Feb 2025 16:36:05 +0200
Message-ID: <20250204143612.85939-2-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204143612.85939-1-robert.budai@analog.com>
References: <20250204143612.85939-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: NQbYEG06fav_fWk4YVHa56YvoMFPeiWM
X-Proofpoint-ORIG-GUID: NQbYEG06fav_fWk4YVHa56YvoMFPeiWM
X-Authority-Analysis: v=2.4 cv=A5OWP7WG c=1 sm=1 tr=0 ts=67a2425c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=qOkh5lLOyeuKFvdS4fwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040127

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

v6:
- commit message wrapped at 75 characters

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
index e6a75356567a..04140b36712a 100644
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
@@ -102,6 +114,7 @@ struct adis_data {
  * @burst: ADIS burst transfer information
  * @burst_extra_len: Burst extra length. Should only be used by devices that can
  *		     dynamically change their burst mode length.
+ * @ops: ops struct for custom read and write functions
  * @state_lock: Lock used by the device to protect state
  * @msg: SPI message object
  * @xfer: SPI transfer objects to be used for a @msg
@@ -117,6 +130,7 @@ struct adis {
 
 	const struct adis_data	*data;
 	unsigned int		burst_extra_len;
+	const struct adis_ops	*ops;
 	/**
 	 * The state_lock is meant to be used during operations that require
 	 * a sequence of SPI R/W in order to protect the SPI transfer
@@ -169,7 +183,7 @@ int __adis_read_reg(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
 				     u8 val)
 {
-	return __adis_write_reg(adis, reg, val, 1);
+	return adis->ops->write(adis, reg, val, 1);
 }
 
 /**
@@ -181,7 +195,7 @@ static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
 				      u16 val)
 {
-	return __adis_write_reg(adis, reg, val, 2);
+	return adis->ops->write(adis, reg, val, 2);
 }
 
 /**
@@ -193,7 +207,7 @@ static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
 static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
 				      u32 val)
 {
-	return __adis_write_reg(adis, reg, val, 4);
+	return adis->ops->write(adis, reg, val, 4);
 }
 
 /**
@@ -208,7 +222,7 @@ static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
 	unsigned int tmp;
 	int ret;
 
-	ret = __adis_read_reg(adis, reg, &tmp, 2);
+	ret = adis->ops->read(adis, reg, &tmp, 2);
 	if (ret == 0)
 		*val = tmp;
 
@@ -227,7 +241,7 @@ static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
 	unsigned int tmp;
 	int ret;
 
-	ret = __adis_read_reg(adis, reg, &tmp, 4);
+	ret = adis->ops->read(adis, reg, &tmp, 4);
 	if (ret == 0)
 		*val = tmp;
 
@@ -245,7 +259,7 @@ static inline int adis_write_reg(struct adis *adis, unsigned int reg,
 				 unsigned int val, unsigned int size)
 {
 	guard(mutex)(&adis->state_lock);
-	return __adis_write_reg(adis, reg, val, size);
+	return adis->ops->write(adis, reg, val, size);
 }
 
 /**
@@ -259,7 +273,7 @@ static int adis_read_reg(struct adis *adis, unsigned int reg,
 			 unsigned int *val, unsigned int size)
 {
 	guard(mutex)(&adis->state_lock);
-	return __adis_read_reg(adis, reg, val, size);
+	return adis->ops->read(adis, reg, val, size);
 }
 
 /**
-- 
2.39.5


