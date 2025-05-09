Return-Path: <linux-iio+bounces-19362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918EDAB111A
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF13A6168
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B328ECF3;
	Fri,  9 May 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ArURH5+r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050D277011;
	Fri,  9 May 2025 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787837; cv=none; b=o72u8oP28X68dk6oazo13gZSIMvrz3yQT5q26DNE1K95ZWhgzNn2kwk216veRsb4Z3IUANufTrejryFlKMmyxhUs4lD8tH0OpOiVvpcqv6Iyd32j+xsFRoaKgj3CrOBeZIy4kJ5P50avxAgap1Ztq4HGpK+ov8meaBDb+X19e8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787837; c=relaxed/simple;
	bh=0LnLMM7ZSpxIAl176l49BO40JYgTC7tvxuudQMVRAho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWEuBM4Z+kCp7KgWd810LsOw/UcjqsdnzsuTY9P8ra+pyPZVfDQHp5RwKLWoL0ErPkqHkD8mSwE0qD9rzqHu1Zwj5cc3pMXKyozjNaEI+gjaNsRzZPjlDvExFQyUmFibrOc1oaNpgm0AAhzaW83WEPJiz9KW5Rx2DHG/qr24sKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ArURH5+r; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499kWbZ007760;
	Fri, 9 May 2025 06:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iAohu
	5IKrekHiJlCzDDoLY3yt5EnB4XZ3CrJJ/vRpDE=; b=ArURH5+rtS49YoL2Op6vm
	62EQKFFyC6iYcCnhXvjvChZLJbK8K3coNPfLHL7V0CSFTESnCcRWV9+1dkrcvQYH
	DK/2HT1XaRiQTQqW76dyJEri+LZiQq0UKoRnG6e+uExi79vsdDlrtedg/Wm8l7Z4
	q/K18RfboOCLFMwp5lUYK+sq1l6QOpqzFHFfThDUZSPOfpPrOF3tYq2aETIeDU4+
	eFt7Wz+GZefnXThHH37dwjzmbQLIfDV9p3CzZgwt4rN/2yP9jhiMWND0PGgLvxmv
	zCPFQjwZbETiyIjqfmwN5gFqTngBiYsqmw4KCcY6HLDDynnjQC1Q2tTuR2pLv7b3
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46hc2yh8v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AoVha049021
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:31 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK12014223;
	Fri, 9 May 2025 06:50:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 02/10] iio: backend: add support for data alignment
Date: Fri, 9 May 2025 13:50:11 +0300
Message-ID: <20250509105019.8887-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMyBTYWx0ZWRfX0O5c5q4nCBQv
 jCM4iIt0sXKe3Lq80+oWkjon9S1y/tp1NAH5kZcTmvdSQyJ1KfMbs7YkWjT7IUwjP44FCOkklAd
 zVndLkkCRcxgkWVi4vtjZqv3f97yJCRLV59XykF7E85W+zhnu4LTJhZPHlYpbsDuGxOWDhdZCVK
 yT12rMU5UqgisWd8ZOlOt+4GArh/eCq1JQGb9Gw2+TTw77LaIL5A72JJrcnDDCYwRXSLDHUUJkI
 yJs38SHEWzIvqMhWNSDre6BuwONYeoU+mQ3pruJqEzyJ8EJevb5RWdpOBxZHnfwaJ9Zn+Ljop7c
 jRz/vqqGJTOIJ8IlW5inTlrs6GQqn/tWbthO7w+LiJbn78IFw8kId2H8olG5iLe0F4qn7wyBWCL
 6vFkMQFVwHY3Z5KOS3386gRHOyjrNJDa8q71+NNGpLHQ+2Wf2yqu7L2+ITvBxpVn1NENsVRu
X-Proofpoint-ORIG-GUID: -s2HypZq5C5EZYdK8KbNeZSK2G1vzLiV
X-Authority-Analysis: v=2.4 cv=UJbdHDfy c=1 sm=1 tr=0 ts=681dddf9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=LieQXdaOVuYbdPten0EA:9
X-Proofpoint-GUID: -s2HypZq5C5EZYdK8KbNeZSK2G1vzLiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090103

Add backend support for staring the capture synchronization.
When activated, it initates a proccess that aligns the sample's most
significant bit (MSB) based solely on the captured data, without
considering any other external signals.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v5:
 - add description for data_align function
 - add suffix for timeout parameter.
 drivers/iio/industrialio-backend.c | 23 +++++++++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 038c9e1e2857..545923310f1f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -796,6 +796,29 @@ int iio_backend_filter_type_set(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_data_align - Perform the data alignment process.
+ * @back: Backend device
+ * @timeout_us: Timeout value in us.
+ *
+ * When activated, it initates a proccess that aligns the sample's most
+ * significant bit (MSB) based solely on the captured data, without
+ * considering any other external signals.
+ *
+ * The timeout_us value must be greater than 0.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us)
+{
+	if (!timeout_us)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, interface_data_align, timeout_us);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 5526800f5d4a..a971a83121b7 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -109,6 +109,7 @@ enum iio_backend_filter_type {
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
  * @filter_type_set: Set filter type.
+ * @interface_data_align: Perform the data alignment process.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -161,6 +162,7 @@ struct iio_backend_ops {
 				  unsigned int writeval, unsigned int *readval);
 	int (*filter_type_set)(struct iio_backend *back,
 			       enum iio_backend_filter_type type);
+	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -203,6 +205,7 @@ int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_dev *indio_dev);
 int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
+int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


