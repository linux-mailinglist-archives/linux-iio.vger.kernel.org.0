Return-Path: <linux-iio+bounces-14984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD12A27750
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 17:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A8A1884C77
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8AF215F73;
	Tue,  4 Feb 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kEzUYKd3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CC2153F7;
	Tue,  4 Feb 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687090; cv=none; b=SyrrlAG4LiGI/E7LrINHlKwKRb/2aItM0RnwJnWOSwLRDyp2R8b3uHilYd6NO/5yc994Ajh2/y74gg7KnWxUpuOD77D8t0bWj6XJVbuqRtCp2eLz9AA/MmRFgX3uFMqpBJMJmbwtZYGzmIjle/bWipaQOwmhhph8U6Eb4M8LSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687090; c=relaxed/simple;
	bh=sd/ogEjAUZrl/OosQkElJFJOctgCOdU44JwovafESWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/5C+vGjGrzEjcj/cUbtOcXdjIeDSH9m3HGVVgvxkYSg+ofNzMPgQSgIkCnKxFOY3JqgikWuYZlWsK+QF2/5ZNWInJUONXr+HSLzyh+37EfE+pR7LOvTvnrUTLuz0QsqQpnaXHfsVN+hfCZ+eGjG0mCFs5xucrxz/vDmuYnxEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kEzUYKd3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GLmeG002548;
	Tue, 4 Feb 2025 11:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=29I7X
	FMK/NKdy2dr1EVGO86uP3BP1WGlgdjuTRa7Mu4=; b=kEzUYKd3O/KgTvNTYHcVS
	ShNUdY1bxnrGOEEoqeWORt+etUTOvhnSUgH6JJB90vLozX+km7k4alsIWTZeRt9T
	Qs2DwfYC1OtQhRVYxE4Ua6htMta5RKV2yIFeOgKnNpytQ9u9P72dEUSKzGEZ5cya
	HgbmIMQiEYz7MGNPV0yfvg/KNYHoFWOOrdQ6Waph9dNRY62nN31rrLUhoGpGAIxs
	IvI4pELPt5DAPb3KtoJYlmBSQl2RdvH8p69uNfsvt17pAv0pB6I+V/OdWdBh2PxQ
	q1a7fDk3v60KFnedsAitLlPyo5euT/ZnO/vWVQQNdbUsZSGA4GKMFgEJqjsb5lqM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44kpbmg244-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 11:37:53 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 514GbqHm047806
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 11:37:52 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Feb 2025
 11:37:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 11:37:52 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514GbMFH009577;
	Tue, 4 Feb 2025 11:37:45 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        David Lechner <dlechner@baylibre.com>,
        Marcelo
 Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v6 2/6] iio: imu: adis: Add reset to custom ops
Date: Tue, 4 Feb 2025 16:36:06 +0200
Message-ID: <20250204143612.85939-3-robert.budai@analog.com>
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
X-Proofpoint-GUID: nXwJ8oafpa-ds_UB-q1KOsXeJVN0BItX
X-Proofpoint-ORIG-GUID: nXwJ8oafpa-ds_UB-q1KOsXeJVN0BItX
X-Authority-Analysis: v=2.4 cv=A5OWP7WG c=1 sm=1 tr=0 ts=67a24261 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=4VcHVMtglg5oYjl6rakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Lq0aAXxcDe89wZWtTDul:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040127

This patch allows the custom definition of reset functionality for adis object.
It is useful in cases where the driver does not need to sleep after the reset
since it is handled by the library.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v6:
-commit message wrapped at 75 characters

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
2.39.5


