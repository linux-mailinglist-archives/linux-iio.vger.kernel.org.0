Return-Path: <linux-iio+bounces-17936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6BA85D64
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECC417BB28
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93FD2C3777;
	Fri, 11 Apr 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Nj8784AE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D429C34E;
	Fri, 11 Apr 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375014; cv=none; b=P7NENKpwJ+G4f3zkb8NMQNo/zgxYxPipicK6Fve3fVP6PPy+GJ1gVq3piz7W/WTTmm9ST0D9jR5XSy4TiALcXEMOXHMAE2b95xOQjYq6+OPZNYkflW9bqkCopB7W25YkXhs0pzk79zAoPtnYOOSJrnMk+KskhQXrGRNTC+208LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375014; c=relaxed/simple;
	bh=YTkU4rAINoOahjJmEFwEOjlFi4jeDrUbQdaBqIkrFMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ny9AS00XJnIBsMvG0pjEKK1LOJVwat08hyX23MG3a/r8G8mRsnkwRlDnz4tBODVxcGydEQMMoblhj8RBdpKUP411SZRmIZ1+Zs8kzX+x64Kf0AonSWZvNzAAfpSvRu/2+CZV/uXMDCL5QM8YNzz3PsVWT0ZtW4NTnY0tH7+Nzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Nj8784AE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9dgHC002014;
	Fri, 11 Apr 2025 08:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AAAmh
	eovz8Oxvkpjk6FH+dRrDjLC2j/2ZVv/XggDBQg=; b=Nj8784AEBd73DwnXIsNkC
	KnxB1p//0j6oOAxa/NRmfVqoktI8Etwa99ANJsmMfjBF4V+UPUBNhh/Xa6Mo2/+Z
	Dhm5hO9BN74NJY9GOl9kuZ2DU28AL9cf8hhAkMvcAdbRRs/vExDfOe5xAA5c+YMr
	pfLDHo44s5Y4myeMQET9kO5563GN+c7026lTe2A/1lWQEawd6P2jI4QWBizpQxsO
	mXKGQB+8WU1Tv2nvLTK6v80Uc9YNKlyXhAg72XCnAsQYLR3cVzfQVu1RmnDdNMYy
	2R4IlalIhaT5Ajsez1iu34T5o0yhW0Oy3NG3EZtLQcRTm0VWp+uKgQ0P8HLsV9zM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp0brd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53BCagOu005155
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
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPP006015;
	Fri, 11 Apr 2025 08:36:39 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 05/13] iio: backend: add support for number of lanes
Date: Fri, 11 Apr 2025 15:36:19 +0300
Message-ID: <20250411123627.6114-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 2UBErUX5Fra2sR1RG4qwD0Oq3v8KPlHW
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f90cdb cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=H8EI4ztkfVKdpxAkIpYA:9
X-Proofpoint-GUID: 2UBErUX5Fra2sR1RG4qwD0Oq3v8KPlHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add iio backend support for number of lanes to be enabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 0b27f88d6c27..85cb8b0d2f09 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -874,6 +874,23 @@ int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_sync_status_get, "IIO_BACKEND");
 
+/**
+ * iio_backend_num_lanes_set - Number of lanes enabled.
+ * @back: Backend device
+ * @num_lanes: Number of lanes.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes)
+{
+	if (!num_lanes)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, num_lanes_set, num_lanes);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_num_lanes_set, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 9bf03181c5c1..cdd39c97ba1a 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -107,6 +107,7 @@ enum iio_backend_interface_type {
  * @self_sync_enable: Enable the self sync data capture.
  * @self_sync_disable: Disable the self sync data capture.
  * @sync_status_get: Get the syncronization status (enabled/disabled).
+ * @num_lanes_set: Set the number of lanes enabled.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -164,6 +165,7 @@ struct iio_backend_ops {
 	int (*self_sync_enable)(struct iio_backend *back);
 	int (*self_sync_disable)(struct iio_backend *back);
 	int (*sync_status_get)(struct iio_backend *back, bool *sync_en);
+	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -211,6 +213,7 @@ int iio_backend_data_alignment_disable(struct iio_backend *back);
 int iio_backend_self_sync_enable(struct iio_backend *back);
 int iio_backend_self_sync_disable(struct iio_backend *back);
 int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en);
+int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


