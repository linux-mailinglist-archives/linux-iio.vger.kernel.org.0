Return-Path: <linux-iio+bounces-14687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE681A218DC
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C851188558A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F719E97F;
	Wed, 29 Jan 2025 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UG2XFVy5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14279190072;
	Wed, 29 Jan 2025 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138892; cv=none; b=u0StFt4vI9KtpVh9PhPBjvHe8e0CsUOfjXkg3Vp9RPqAsnuRj9yWQrCYHgQcL7HNtW9ZsvHsR+OaAWCUB5uRQarZY3iJUIuMjfToWyk1HGmlQ/vkZ50bKmO8G09ZzdUbmbxeZRIu97sU2ryVsZOIc5JFQTEFyPCNZsLjTHDUshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138892; c=relaxed/simple;
	bh=rPk25iDaZ4X8fo2GVSY1BZKgAHUB3rXD5Mu49tm9rhQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0pOexY2cj74u0FKxyuOLZ9JzwkdpB1vCAaaV0OHqqhZg5soQlHF8uPqlSCIpKdap0gxNILmjkV3rPtKPBrs2MDHxhgMk9qXkmbxmt0bd+3QWCa5d9S3COc5MLszvGPZjvcNBJTfw6i7vVSEIfXGqmHUfFfjt7szNF8laRGqrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UG2XFVy5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T5ndd2004820;
	Wed, 29 Jan 2025 03:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2I48q
	mhfdCFzzyD11sTqosHqQ8RlPdhZHTjlbolCEp0=; b=UG2XFVy5apCh03wwmeyw2
	FE73IxjT1KPmyQNVC8BOAyvTd0ro5kcW1r9j13K4S/AvFfwsJGpJCVuWrNJH5k8j
	l/QWSoPtWjERXfrPYgheIuB1Y2di00n/j2AXT9RAlj/zWm+lJ65CoGjzhhyfpanm
	5yNzsRbW52dS+oX78PjnUHA0AfjxjCksyXqBMOiDQzQ6k+b4svFqYt2wzlZZ/EqR
	bfSZMjxX9DYTS2I64ohXw/s5J/M1yhEUPq4RaMe+jM3G/pMAZOds7syk6QMkc3uG
	gvKcLPq36DM2V0wdGfKmsHBaHiCGxfEUNqSwTS5XZjrGvBvFxxGrLNDLtVAMocEt
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44feh7ge8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 03:21:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50T8LEgn028237
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jan 2025 03:21:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 29 Jan 2025 03:21:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 29 Jan 2025 03:21:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 29 Jan 2025 03:21:14 -0500
Received: from robi-Precision-5540.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50T8KtHI025874;
	Wed, 29 Jan 2025 03:21:07 -0500
From: Robert Budai <robert.budai@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lanzano.alex@gmail.com>,
        <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v5 2/6] iio: imu: adis: Add reset to custom ops
Date: Wed, 29 Jan 2025 10:20:42 +0200
Message-ID: <20250129082053.19077-3-robert.budai@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129082053.19077-1-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vnmnV7gpoulKY8EgFSSIEyQtTEFX5BUd
X-Proofpoint-ORIG-GUID: vnmnV7gpoulKY8EgFSSIEyQtTEFX5BUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290067

This patch allows the custom definition of reset functionality
for adis object. It is useful in cases where the driver does not
need to sleep after the reset since it is handled by the library.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v5:
- fixed format issue

 drivers/iio/imu/adis.c       | 5 +++--
 include/linux/iio/imu/adis.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 54915c7a3e76..84344f052fb7 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
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
index 04140b36712a..13beb6a7317b 100644
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
2.43.0


