Return-Path: <linux-iio+bounces-15857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A19A3DBCD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE7517CAA5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECF1FAC25;
	Thu, 20 Feb 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zvTlDqrc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFF1F63F5;
	Thu, 20 Feb 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059775; cv=none; b=O68C76d1SbvaWBbO9IQOOHItrAHq9mrwcsqMcradA+cxXqiu2aogX+KjTBTExDE/tIs6tLN+qY2iUcWNwgPMe8Dpny4TO+aOirzHeGeD34cDv7a5TZ4EIcYPib9YLo4yEpEgMBqkcWBxQF9qgD03BkNhvCYlYSENaSC2rmW79zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059775; c=relaxed/simple;
	bh=zTsEgOQqLtLC/mV6kE1mPx2B+opvcGPfjItVTTLrRT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9KdQC3UjIKdh2M12q9+n0uKup34o/SKJQrgyy/kYcEd6FHROShcc1mT6c5PMqioxMGIPhtuzuVdasao+eWt1sYx4aaPVwUU8ZGDGChulzX4tTKZrk6U72QD609OL960nuwhePf9taNJ7yJS2pbYdrGl6jEaMqY6j1PonTsghNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zvTlDqrc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBRDZE005631;
	Thu, 20 Feb 2025 08:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2NDbR
	rwuUYPHgeYfi8g5m7iiDKcVCLyM9TH8WuSjy/M=; b=zvTlDqrcaJJTr1UApDbB1
	5aRHELIoBEthR1BJiTmFl2lRfEgZoLbQLZtdxS+fHVivCCE7lMUnB8STgQJ8lNEq
	iT8EvMe8muDgxcfRNFCQ7vLEJE2K13EcWE7C8rAiAy18PerDN23geAC5Ep9GJxCL
	8w6CBOLhHyWZbUu/P5/MjjAJOIqCQp/4c/swPWOMEYQmDfRz8Ojf9qysy6gn9Qun
	qbHMVlI5jYR0LjdwwdntmPF4sGlRKxyOcWYLWYqvwxOUCiE6gAzh+HL6RHqI8L9k
	rSN5UPr5hBGxtJb6RfwVW/L2AZoS0e43UMGkPwug7kbiXSu9E0ltAqlaUNUqyYl2
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x3hj0gyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:11 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDu9oR054113
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:56:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:09 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqp008409;
	Thu, 20 Feb 2025 08:56:06 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 02/14] iio: backend: add support for sync process
Date: Thu, 20 Feb 2025 15:54:12 +0200
Message-ID: <20250220135429.8615-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220135429.8615-1-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: mJzUfnNbuuxcPpPfHz1H2UdWCA0rfCss
X-Proofpoint-GUID: mJzUfnNbuuxcPpPfHz1H2UdWCA0rfCss
X-Authority-Analysis: v=2.4 cv=OJvd3TaB c=1 sm=1 tr=0 ts=67b7347b cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=ag49dgL6vxe8RoD30bgA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add backend support for enabling/disabling the sync process.
This setting can be adjusted within the IP cores interfacing devices.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index ffafe7c73508..b01db8a65b1c 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -804,6 +804,32 @@ int iio_backend_filter_disable(struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_filter_disable, "IIO_BACKEND");
 
+/**
+ * iio_backend_bitslip_enable - Enable the sync process.
+ * @back: Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_bitslip_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, bitslip_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_bitslip_enable, "IIO_BACKEND");
+
+/**
+ * iio_backend_bitslip_disable - Disable the sync process.
+ * @back: Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_bitslip_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, bitslip_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_bitslip_disable, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 7987d9f1cdb3..c7b4631b524c 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -102,6 +102,8 @@ enum iio_backend_interface_type {
  * @debugfs_reg_access: Read or write register value of backend.
  * @filter_enable: Enable filter.
  * @filter_disable: Disable filter.
+ * @bitslip_enable: Enable sync process.
+ * @bitslip_disable: Disable sync process.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -154,6 +156,8 @@ struct iio_backend_ops {
 				  unsigned int writeval, unsigned int *readval);
 	int (*filter_enable)(struct iio_backend *back);
 	int (*filter_disable)(struct iio_backend *back);
+	int (*bitslip_enable)(struct iio_backend *back);
+	int (*bitslip_disable)(struct iio_backend *back);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -196,6 +200,8 @@ int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_dev *indio_dev);
 int iio_backend_filter_enable(struct iio_backend *back);
 int iio_backend_filter_disable(struct iio_backend *back);
+int iio_backend_bitslip_enable(struct iio_backend *back);
+int iio_backend_bitslip_disable(struct iio_backend *back);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.48.1


