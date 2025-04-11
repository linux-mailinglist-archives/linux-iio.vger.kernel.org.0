Return-Path: <linux-iio+bounces-17938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42281A85D4D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3ED7B7594
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C32D1F5B;
	Fri, 11 Apr 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jNn5Uvif"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FA2BF3F0;
	Fri, 11 Apr 2025 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375015; cv=none; b=WjcV2NgJtjgjxm+vMWqUjrwP+aMgzDq+n1XCT+9NfcK+BL/gWo1srbZTKS0W72cBpUS6m7LtYC7CGBfgsgkxvtmAZSeag9G6Q1Ltv0Ve3J4l6cOvCp66FDRJD/r98xVr6Tw72IkJmF+6Kjh6jeIckV6+rPzJjz4mjhg6RALj7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375015; c=relaxed/simple;
	bh=uLv+jZVIylIH0VV0KD57hcrEwlYUJVcBTcr0iSVMHQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqVai3hGMvmbhTx0zpp1X0d9n3YUkcWvQJFGW/yer+i4VB6r6r8n661gITzPVq5Us1eHkoM0rUkx5tjBxTM6SSvVMH04tGElrFEtR/0SCo3p8IY5jEupPCmTVxgqOI8JfAMdxk9EJH+sy/kVcDItShUABsXblhW7vam0cpTpptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jNn5Uvif; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9CJrp015243;
	Fri, 11 Apr 2025 08:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=01F42
	s9TJklF2DMaHuP3FLwj+p8Agg9m1Rgn87wyq9s=; b=jNn5UvifTn1HCoc1CTRxq
	Ph8ZtGZtTSMQ/InHKdeixBsOMQhiq12LGQFunuFQN7XBVXrbCh6paZKbi2o70Vd2
	lFu3OEzCZDcUxmq7k15KR692Nbf4pJiFP5NtTEKRmzr46fE4TfVCwA5NEfuLvGDO
	WXHFv7BiHiU+gV2766gMfSVo6dgJr+xMmGiOZjG8K+KaNSNYmDmxWtLjnsScE30I
	nsv/TbckC6xwgy6P7lpBu9T/FCp1T+QlBNYRGJijAM8Ak43ct/qWwqOOy4HR/MnB
	bKEhxs/rwreJRJtMQjdofJ8Aa7rZ7wVRl6HH9dpR4jLdx/dAjeehpHW3FQ8PYuOy
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6u55g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53BCagDE005152
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 11 Apr
 2025 08:36:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:42 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPN006015;
	Fri, 11 Apr 2025 08:36:37 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 03/13] iio: backend: add support for self sync
Date: Fri, 11 Apr 2025 15:36:17 +0300
Message-ID: <20250411123627.6114-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411123627.6114-1-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xi4EhDRDXENvO0rCTdBA_2L6llpHvonq
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f90cdb cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=YZcm-HbQskwjXeElZPUA:9
X-Proofpoint-GUID: xi4EhDRDXENvO0rCTdBA_2L6llpHvonq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add iio backend support for self sync enable/disable.
When disabled data capture synchronization is done
through CNV signal, otherwise through bit-slip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/industrialio-backend.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 60578267643d..cb23433b22c6 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -830,6 +830,36 @@ int iio_backend_data_alignment_disable(struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_alignment_disable, "IIO_BACKEND");
 
+/**
+ * iio_backend_self_sync_enable - Enable the self sync data capture.
+ * @back: Backend device
+ *
+ * Data capture synchronization is done through bit-slip.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_self_sync_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, self_sync_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_self_sync_enable, "IIO_BACKEND");
+
+/**
+ * iio_backend_self_sync_disable - Disable the self sync data capture.
+ * @back: Backend device
+ *
+ * Data capture synchronization is done through CNV signal.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_self_sync_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, self_sync_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_self_sync_disable, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index beff66d18151..6d006cb0da5a 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -104,6 +104,8 @@ enum iio_backend_interface_type {
  * @filter_disable: Disable filter.
  * @data_alignment_enable: Enable sync process.
  * @data_alignment_disable: Disable sync process.
+ * @self_sync_enable: Enable the self sync data capture.
+ * @self_sync_disable: Disable the self sync data capture.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -158,6 +160,8 @@ struct iio_backend_ops {
 	int (*filter_disable)(struct iio_backend *back);
 	int (*data_alignment_enable)(struct iio_backend *back);
 	int (*data_alignment_disable)(struct iio_backend *back);
+	int (*self_sync_enable)(struct iio_backend *back);
+	int (*self_sync_disable)(struct iio_backend *back);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -202,6 +206,8 @@ int iio_backend_filter_enable(struct iio_backend *back);
 int iio_backend_filter_disable(struct iio_backend *back);
 int iio_backend_data_alignment_enable(struct iio_backend *back);
 int iio_backend_data_alignment_disable(struct iio_backend *back);
+int iio_backend_self_sync_enable(struct iio_backend *back);
+int iio_backend_self_sync_disable(struct iio_backend *back);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


