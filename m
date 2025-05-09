Return-Path: <linux-iio+bounces-19364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F0AB111F
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8591D4C4C55
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD37F28F925;
	Fri,  9 May 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IRHpVBPz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056F27FD57;
	Fri,  9 May 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787838; cv=none; b=ZYVH2rLRuO4Hm0cakMyOn3WgQakJ4ne7IosxjRTBw+rwrVlbGXE81bnY3L5mdiOFilnkFKVOy6etOMLc3Gf/qQ1ZBwlP/MG549NEmLcstiXg1T8iOn09FzmTqzTqvFUo2Y+JdAa+La12U1gL6fwBw1Us0ZkwfEs9VoQ1BdYZNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787838; c=relaxed/simple;
	bh=IEERG63gXQe94bittVS9xdanrcENrDhQ6k8v/4TXsvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jofJqOgGJ7uanBI1gYHn8YXpgJmpWpvvq2Qw4lNEmcdKZ8Lgw4iOfjVMnxqoBwUCl9cf/dhWlzppHavJnl4P1YBNSIcbY+UFD20AdVNbp9Pp9t4WPz7201cDznKyUQjihYi9+vAuKhefSOTMF76RJb/YswZO48R2S01OkdtqOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IRHpVBPz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AeilC016280;
	Fri, 9 May 2025 06:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fLpHJ
	DVLW1PfTiN3b+5rAAz1M7n+0Gte7lbq9BSS5N4=; b=IRHpVBPzvlIWvvJkH6/ib
	jiQS5h4yrstvsDYfQq9mN6m0/NuBzRRkjAFRkWn8UYTLaOqvbpgg26vmWz15VyR5
	Ks/aGpwHBy86Li+CA1KaanqgMv5FSwqLwIODUHdiAhV8QIm0ZwIGD5cDVxSasUTw
	QR7LMuGz9rGnszn4I5iy4Sb8c8WTnepXG0b5yNS5dwdP4zHqF6EqnCsZq2mf5hhB
	v1ZcVYlE/XAQfHIvO2Y2lo6Bn6r2paBGn3sqxTIh51qQem+Xky3VoDPC9XL4Bqa1
	zaYQw3Qb+D7RmLMCPDa0JFJ/m2MSICjNIRI5cGX+X0LPrf+8X+kBge8Q0ZxWD62H
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46hg5tg0vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AoUZe049007
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 May 2025
 06:50:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:29 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK11014223;
	Fri, 9 May 2025 06:50:26 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v5 01/10] iio: backend: add support for filter config
Date: Fri, 9 May 2025 13:50:10 +0300
Message-ID: <20250509105019.8887-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: xRiavBCegWuQXSsJgixGPmI7KuBSJV_z
X-Proofpoint-ORIG-GUID: xRiavBCegWuQXSsJgixGPmI7KuBSJV_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNCBTYWx0ZWRfX7ZmkUifPvbJn
 31FbgzbUmuLpt4o89fKB+VoVZniXV3ZOvPH8LYl7DTwGQ2q2+f8KPcSLQjEYV5vgvPlGn3No18L
 iWIDbAAASDMg62VZfUyWTxYIszi3UsI5MLKTP8HMvYjNQ6XGmH62YwqkRvxlyHM+ASiS+tL5B6Q
 CgSn27ZvWJoPQ7WWxjbubnEc4ZE4zg97D+pOJOvKCxZwLF42Y+cQxAjwgqk9W89VxeuBif8/PHU
 +nqV2WpHRqTa1MkqxkKxVgLS4aD32JAzgxb2weHI65w+cezTby6xZRYZwEbslp9uJEKwf05QI/e
 1IFOWET6J3q4+zNN64YfSKGab3EWouwtSlWVEBKiqNX4Gc+8A61ICzK3c/7LsJkK6PKHS/PWVLJ
 ebuBySclPF/UrUOSfj4+7oN5y2UhDd+2HS3fmqV2xDjGINxFFX1KO+MVCdrqd9FHEuJpkeHy
X-Authority-Analysis: v=2.4 cv=eeE9f6EH c=1 sm=1 tr=0 ts=681dddf7 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=UD3WkZFi8vOiteFn2FEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090104

Add backend support for digital filter type selection.

This setting can be adjusted within the IP cores interfacing devices.

The IP core can be configured based on the state of the actual
digital filter configuration of the part.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
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


