Return-Path: <linux-iio+bounces-19577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB79AB97A0
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175EE1BC2EA0
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E622FF35;
	Fri, 16 May 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h4I9sFdc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4C22F76B;
	Fri, 16 May 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384019; cv=none; b=icLpSZZeF1E/igxzr3OE4i6bbEaki/77IpWhssUGH9iSIy+kqhInjyY6ok7NtNw3pZ4Su8SJr4P9aN+tenQ3UPW9rYO+OXMVY/H35TDUxN3v9lXKz5x8GF3qmqJv+wL/XUj/nzu+GQzyJxuCCM5qnqsOh5q8KKLuk9Vk1MDlga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384019; c=relaxed/simple;
	bh=lib1A3fpAPB6sNPrna+P3DEECD5SGvBlQArEINqypvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoZpqK3AmLn/Agw8HPMqlOESixrXyQp+to+F6z5QAmka5IpD/Wl1DbF1URJJQr8+j8PuUjq2FpYFrtw42r2EonHswIO0Vv407eah7AV0YUtpBgwaGMcSncX7hwRy3HRbuK9OrHLT68QM99QBQGibNCH5Rcd4AW/fJM8kw3AowU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h4I9sFdc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5JnqG001902;
	Fri, 16 May 2025 04:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=G5SC+
	iL8EE9QF2Yd6uESGIy2p4vjU9Xlu1NE0m7I33g=; b=h4I9sFdcVRyDk2H9Hj857
	IG5UUqzJl/DxQt7oK3HoWS8oX0rhOMh0SLWHwhkFtqOuIdJc485e46S3tK+eMRGz
	9yjkHAHD3y+IrCb7eAtKB4TfV81dwdPLYVr2K3LPboiD9qRvmOIUE2acd/MS/NNN
	ULW80FwilYAyA6Q5fcC8esDD/03/+3T8WkIBco/9Kfa87lhzYNVlOMTegL5sH00k
	JC9BIaPsMK1imy8qq2tzJsiE9Mfrvn5RInGyo1VVyT7lCODWa2MN7wHvVH03nAAo
	Fta5SEzkrx3UMv2LNa/guZKUoDs2rTp9AO1ODfxFwMx3h1RAMVAq8K77zfkofKYD
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ny4a8qjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8Qj2e033591
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:45 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:44 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwf031549;
	Fri, 16 May 2025 04:26:41 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v6 01/10] iio: backend: add support for filter config
Date: Fri, 16 May 2025 11:26:21 +0300
Message-ID: <20250516082630.8236-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZEwQJPnMMDhudPuepJHY8H6IDgyyXH0C
X-Authority-Analysis: v=2.4 cv=MvdS63ae c=1 sm=1 tr=0 ts=6826f6ce cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=UD3WkZFi8vOiteFn2FEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZEwQJPnMMDhudPuepJHY8H6IDgyyXH0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX82jYdgsLeHZA
 v7qoYJpPoUQzXaVkGq0ADoNaDz8r90c1L8dmrH5FtdVNl/PG6JTlfh0vm9gJkK6GiPvKk8bj61p
 RjPYvrN5Wuee/RoB19m7RcErCgMA5zI3WSoqrtM/3uNIpGpZd5viU1fSoW3N2IJXA0CRa3ENZ2I
 Foqn2JYdQ/H8JS7rNSZsY0Xxdz71NGTTe/+81qwrnZU46cnt6sGkcbaIRIhDMTnouPKQvtN5rzQ
 AFhFoyDGW/KbATV7ZB8znR6eYd1dX62xDjgvX79RmwOamwLgu4zvUKKTR+ZofFG+C+57KIImF4b
 drjq4XF+tZcRx3LTbE1BvcFO13F9Cr5JGYT5+dnU0J2B6uWG4N7GxufULWMxUAhnoLwExAahw3L
 yVMhpPy4DFcbqMgkFyPGQBY5KDkFx4cOv6uHADe7BhLuE1ymtc4AzHsd7ViJ/4j5WsLkYuYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160079

Add backend support for digital filter type selection.

This setting can be adjusted within the IP cores interfacing devices.

The IP core can be configured based on the state of the actual
digital filter configuration of the part.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
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


