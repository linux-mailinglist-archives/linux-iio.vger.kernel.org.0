Return-Path: <linux-iio+bounces-15862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E7A3DBE2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD673BDCFA
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAFE1FECAC;
	Thu, 20 Feb 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vb+w5U5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A31FCF45;
	Thu, 20 Feb 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059780; cv=none; b=UqKCi+uKNng0xGpuimb7MuzU2BFeVZ4W5150dsWdCbstotJPKLaB++5zQtCtsK+TSElir/7RtkhfyGBB351jJ4hPMC7T+4ByNdvAPETbWp/7zJ7NEqgVrMY8gGaP4CIgYGLVVKdj0jq1rGLV6ztijSrPH/jJ8/LfPYteXTBYS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059780; c=relaxed/simple;
	bh=gMJtHRGrtpp+0AEvHlDl4VX+l6vX3rxzdSdznLBFXNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fX3E7CN3cNG7N1TyhhXtpHJ6FmHF/uN47SoRyhHsHrVyBmp1MYwfdBGbB9alJFDMU6M7p9UZn3HUj9CtS97ZsO3aM8VQKGeCZJyja8IY9feGkM5VSpGg4tuVMCprZicRz/LMWxnwzGwDNy3Vi5yR7fyPlIquRn8ruCbupf0or84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vb+w5U5h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBM5Xo023834;
	Thu, 20 Feb 2025 08:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6v5SA
	y9Q1NxTpdSgjdeqtE9v28o5AfMN+l2Nqx9SCXU=; b=vb+w5U5h7SSi6VUiA3iph
	vaTw0oTEAIHOdY5hNIiWU/lpidWdayf6KP5jaHHX5xXAihIeGfcOnsazyEudIqtv
	+k476kv+B1VzxzDwe9yyj2XtnLcAI3jzInp9CWU9oz3IrdzF0Sv+Km6gqFCF4EHm
	N3VejAmkccSly5sd42sgxJ9w6AaZaZJ515zzb3YhLltI0oZCeSRincvOWBJ+zCJ/
	PmXNW2JpOdyTPeLZgksGxXx+3l0/xk7FS/uAnkM+Vy1H/fR0WZGJSyOyqiFAAwmt
	0+gjs/N8DhHViDSRPq/CnSuQiRwLyPO/eAlkJez7IDX/u+4g30oEYMupwdxVjv9k
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44x3f40hdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuEva054134
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:56:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:14 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqr008409;
	Thu, 20 Feb 2025 08:56:08 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 04/14] iio: backend: add support for sync status
Date: Thu, 20 Feb 2025 15:54:14 +0200
Message-ID: <20250220135429.8615-5-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: lwhqwMtc1IPAtt4ix0_BTCJJiDSVqpMi
X-Proofpoint-GUID: lwhqwMtc1IPAtt4ix0_BTCJJiDSVqpMi
X-Authority-Analysis: v=2.4 cv=DuKs+H/+ c=1 sm=1 tr=0 ts=67b7347f cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=XpakW2QAsv3AO3mn8AYA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add iio backend support for synchronization status read.
The return value is a boolean stating if the synchronization is enabled
or disabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/industrialio-backend.c | 14 ++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index a81780f569e3..99c46b79e373 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -860,6 +860,20 @@ int iio_backend_self_sync_disable(struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_self_sync_disable, "IIO_BACKEND");
 
+/**
+ * iio_backend_sync_status_get - Read the syncronization status
+ * @back: Backend device
+ * @sync_en: Synchronization status returned (enabled or disabled)
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en)
+{
+	return iio_backend_op_call(back, sync_status_get, sync_en);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_sync_status_get, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 8e663c838974..38322e808ee2 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -106,6 +106,7 @@ enum iio_backend_interface_type {
  * @bitslip_disable: Disable sync process.
  * @self_sync_enable: Enable the self sync data capture.
  * @self_sync_disable: Disable the self sync data capture.
+ * @sync_status_get: Get the syncronization status (enabled/disabled).
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -162,6 +163,7 @@ struct iio_backend_ops {
 	int (*bitslip_disable)(struct iio_backend *back);
 	int (*self_sync_enable)(struct iio_backend *back);
 	int (*self_sync_disable)(struct iio_backend *back);
+	int (*sync_status_get)(struct iio_backend *back, bool *sync_en);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -208,6 +210,7 @@ int iio_backend_bitslip_enable(struct iio_backend *back);
 int iio_backend_bitslip_disable(struct iio_backend *back);
 int iio_backend_self_sync_enable(struct iio_backend *back);
 int iio_backend_self_sync_disable(struct iio_backend *back);
+int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.48.1


