Return-Path: <linux-iio+bounces-13542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FC9F3395
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 15:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394B1163DFD
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838931482E1;
	Mon, 16 Dec 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zUeNqJYw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75386252;
	Mon, 16 Dec 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360566; cv=none; b=Fjh+Bkm6XjlJwV+qPgTEoUYLQ8ieSuHXxKbp/O+Xa0svBScfcwm2nObxmB6dxHZNNGmzXH4DafKYKr2gJKwYZzHCF/5VU4BHjIWT3YNTEfBd7QYfo24e+cLk+blxDD35Rg0Lqp1/Y1BcDWlE0WqEnRgto+QBst9iXRH6m2n5yIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360566; c=relaxed/simple;
	bh=hGLwBbB1fDrrfIjq+ccdqunWxPxxbShZlL/gl0hSllQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJXTM2KMIby5BiafFA3xAKVwq95JiSNbuIQM1k8QuAK+3Hl3/CJEO0dEfM7W/ch3RcQcVJhb0FUlHtguQmHG6EZTzkZ3ZT//pLNo7KnkEfiqDKmJZvVcCKl54FBBuHI5E0D1XJPKCo9Hb2Jk54Am6JxtaS4dmdoB+u/J/2IMwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zUeNqJYw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9pulK018613;
	Mon, 16 Dec 2024 09:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9gVwe
	QXgUuXzztMBSRCKsgzi6GPTuxwFBgdrf2yFUtU=; b=zUeNqJYwxw0OLUMS2gutv
	ZOo0FlqC5drKxWvQn81pOdIrQoMUUHXxVntiB6YWNQYTUn0WGPh4n0mX0MkgtOlg
	yN/2SD3g6pI00bxIHIZXkyyz2WXKlE++/8uhiTo4SqpaVIGBGrSbjO30QBSm8QE2
	8hOKfGGzgU0OEjlGtEKSuxaQasVNAagmpNr8GtmSGh6uhnnFPM3MhFR0+grbcDyl
	iU30eNTzvgXRAiZwQVhy1VrWQ27zmpK0D+1k8sYbYdrbqpUw74XEuUd6n+VJFL+m
	3sVtmTkobXb+fKinhW4gDAX5hjjwkEnkQCJJbrXp4oxbyn4g2fKY0x59qrnoCL53
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43jhxvh1dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:49:08 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BGEn78F044451
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 09:49:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 16 Dec
 2024 09:49:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 16 Dec 2024 09:49:06 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BGEmKdk018405;
	Mon, 16 Dec 2024 09:49:01 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alex Lanzano
	<lanzano.alex@gmail.com>,
        Shen Jianping <Jianping.Shen@de.bosch.com>,
        Robert
 Budai <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH v3 3/7] iio: imu: adis: Add reset to custom ops
Date: Mon, 16 Dec 2024 16:48:09 +0200
Message-ID: <20241216144818.25344-4-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216144818.25344-1-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SieHWgp0FZGDo8nbsRHO1R305W1vjOZP
X-Proofpoint-ORIG-GUID: SieHWgp0FZGDo8nbsRHO1R305W1vjOZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412160124

This patch allows the custom definition of reset funcitonality
for adis object. It is useful in cases where the reset does not
need to sleep after the reset since it is handled by the library.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v3:
- added reset to default ops and used the allowed custom ops definition in case all read/write and reset are defined

 drivers/iio/imu/adis.c       | 7 ++++---
 include/linux/iio/imu/adis.h | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 54915c7a3e76..9e4113473dc4 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -340,7 +340,7 @@ int __adis_reset(struct adis *adis)
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
 	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
-				 ADIS_GLOB_CMD_SW_RESET);
+					 ADIS_GLOB_CMD_SW_RESET);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
 		return ret;
@@ -491,6 +491,7 @@ EXPORT_SYMBOL_NS_GPL(adis_single_conversion, "IIO_ADISLIB");
 static const struct adis_ops adis_default_ops = {
 	.read = __adis_read_reg,
 	.write = __adis_write_reg,
+	.reset = __adis_reset,
 };
 
 /**
@@ -522,9 +523,9 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 
 	adis->spi = spi;
 	adis->data = data;
-	if (!adis->ops->write && !adis->ops->read)
+	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
 		adis->ops = &adis_default_ops;
-	else if (!adis->ops->write || !adis->ops->read)
+	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
 		return -EINVAL;
 
 	iio_device_set_drvdata(indio_dev, adis);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 89cfa75ae9ea..52652f51db2e 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -98,12 +98,15 @@ struct adis_data {
  * struct adis_ops: Custom ops for adis devices.
  * @write: Custom spi write implementation.
  * @read: Custom spi read implementation.
+ * @reset: Custom sw reset implementation. The custom implementation does not
+ *	   need to sleep after the reset. It's done by the library already.
  */
 struct adis_ops {
 	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
 		     unsigned int size);
 	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
 		    unsigned int size);
+	int (*reset)(struct adis *adis);
 };
 
 /**
-- 
2.34.1


