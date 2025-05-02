Return-Path: <linux-iio+bounces-18961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E3AA6D3C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63683AA2E0
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511822C35B;
	Fri,  2 May 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nuAhJU2F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5822616C;
	Fri,  2 May 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176381; cv=none; b=frIaeS+LJCik5doqjvTX/p4lf1ipnQUADBYeCOsgNSbI8+Q0xPl0+xpTGBiAGuqDYk2/WA/Ak6bnvhGNyg7GaQrE1ALWnva9rw+vblPuVf2KRi1TrjiBbWQsU9HlrVeKapXC7AfQKMxzPyAyJNrxGOmZAm6jvlhYvKYyWRQQZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176381; c=relaxed/simple;
	bh=WVpV3q0OYwMN+CjVI1AHM/Qbbb3lfPm8ySSP6xgS8o4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKRDDeYdW/t6ziXtIA6ak/6IhX9l7hzP2RrbkuyGLfy1cur6OLVqRBqQCIGH1q7+kEaYIFb+EFrc/5vBpWCAEy7g/9UQ8Zs37KIaJxLAZue8NRUvsMminXtoBl7SfALRB/+M/7lYGv568+I5gFAnS9vjyj4hEQsFyS5QVak1qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nuAhJU2F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5428JKRo008742;
	Fri, 2 May 2025 04:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Kfh1I
	fHw0hy2pIBIku8y2ysi5iu0CKzYyyDT7gUbX1U=; b=nuAhJU2FTVOMopVsBNcTj
	Yu6+qZnE6kFu+1vtmG54NTA53bW1v8pj4Mc+YuLnYPI3YCuRsh7jJOY14yM3UoSC
	TfpbB9xUv07/woFTuyyaEfx0X3idGO5TePgkApTBqy0eslGGXZEDKBgx+apN0502
	3fxNXjNDLgqZB6KsJfEGenC4JnCWVsRdnUAOe7dvQIdeFYu+Dfa22rGKqOr4e04j
	MwcwQJJqAdIsk3CcNSjBL8kK8ORTUf12luxMXfHakkfMEW/VYf07UX5aX4MlfzSo
	UR1A5s8lk+sGSBp7efbDtWvuliZEax7b2MJoipg9iJwa8fPrMK2GsMHFlinrZzQw
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46b6u1kww6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5428xUsJ029942
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:29 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7K015723;
	Fri, 2 May 2025 04:59:26 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v4 01/10] iio: backend: add support for filter config
Date: Fri, 2 May 2025 11:58:56 +0300
Message-ID: <20250502085905.24926-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RuDFLDmK c=1 sm=1 tr=0 ts=68148973 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=UD3WkZFi8vOiteFn2FEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LYlJPj8-SlyFvvS0nUBNUil8boUXJL8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX5+d/R3Wv7PsS +lxz7pV17a8MThKzUwqS1tQWCzFRmZXIGpXisJHyM16cSCr33v331RQ05O9S7Ub0dEQ5R/DrdPl i5NWet/o6bTN3NyKm1J2pjFN6b8f3aPrwLh/C2QDaU1VzpiH86bmKT1EPCMDP5Hk4aCk+Y/s+pg
 PfBljXEZew8dVtjhFtpj5F6UpGgwL7DckKUkJP4o3/PSkDqLM2XfekqYP1PKZ8IDGX8A36zrpqz lqeKHrpn39cziDnd2lGpZiG6VMP9TSuRZDks9vV0ydk6m0vNQ9xt55zZFdjzQdgW1Ge5l2MfNWO ZUWMbjEe0Y+vA2e8UQ05socAXtTP1cYWT3VU095p1hTme8xW22vzKLST6GHwdzQhBiflK7yvXQ9
 6S5fW58Yg/6wZ3N3wmhw1WoC8kV7BnKBonV5ohUiEQu6ybGYBcDGtJw2nl4OuqOIaTjHC1Yy
X-Proofpoint-ORIG-GUID: LYlJPj8-SlyFvvS0nUBNUil8boUXJL8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add backend support for digital filter type selection.

This setting can be adjusted within the IP cores interfacing devices.

The IP core can be configured based on the state of the actual
digital filter configuration of the part.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v4.
 drivers/iio/industrialio-backend.c | 18 ++++++++++++++++++
 include/linux/iio/backend.h        | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index d4ad36f54090..038c9e1e2857 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -778,6 +778,24 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
 	return 0;
 }
 
+/**
+ * iio_backend_filter_type_set - Set filter type
+ * @back: Backend device
+ * @type: Filter type.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_filter_type_set(struct iio_backend *back,
+				enum iio_backend_filter_type type)
+{
+	if (type >= IIO_BACKEND_FILTER_TYPE_MAX)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, filter_type_set, type);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index e45b7dfbec35..5526800f5d4a 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -76,6 +76,14 @@ enum iio_backend_interface_type {
 	IIO_BACKEND_INTERFACE_MAX
 };
 
+enum iio_backend_filter_type {
+	IIO_BACKEND_FILTER_TYPE_DISABLED,
+	IIO_BACKEND_FILTER_TYPE_SINC1,
+	IIO_BACKEND_FILTER_TYPE_SINC5,
+	IIO_BACKEND_FILTER_TYPE_SINC5_PLUS_COMP,
+	IIO_BACKEND_FILTER_TYPE_MAX
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -100,6 +108,7 @@ enum iio_backend_interface_type {
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
+ * @filter_type_set: Set filter type.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -150,6 +159,8 @@ struct iio_backend_ops {
 					 size_t len);
 	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
 				  unsigned int writeval, unsigned int *readval);
+	int (*filter_type_set)(struct iio_backend *back,
+			       enum iio_backend_filter_type type);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -190,6 +201,8 @@ int iio_backend_data_sample_trigger(struct iio_backend *back,
 int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_backend *back,
 				    struct iio_dev *indio_dev);
+int iio_backend_filter_type_set(struct iio_backend *back,
+				enum iio_backend_filter_type type);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


