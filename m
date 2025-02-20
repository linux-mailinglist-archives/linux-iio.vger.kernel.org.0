Return-Path: <linux-iio+bounces-15860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39103A3DBD7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58F617DFCB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C91FDA7B;
	Thu, 20 Feb 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dOP7+bK2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DC1F91E3;
	Thu, 20 Feb 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059779; cv=none; b=eSInZdajJIt5UgoacOyeB1cpr5aqCfI6I6X8Lb2KNOS24J3PYEreWXIQymsk5brHQc7f0n2Hl0PyfDxb5eNerYm0j4bZh3TASgRBna81egabQIB/lUTp9JZ6WzwBEXn5RHEmcguhTMv/4WocYOP61poT437RtuJ8WPb2SlHgHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059779; c=relaxed/simple;
	bh=h6Vi12ca9VC+v9WINw11kw7R2bDBPBrHy+8ZwSvogsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaNj+MeUuFZxOewGEzkxRti1AVRO+BAUk11QUhUWNaI5/V1HNcKUVYJhpoZlvXNPvQSoeLqLotGWs/TYVlkk/X8h78o8wO8k1OJTD2Io3rYqI5k4qbCDJjKIqY1FE7/6900u9hMASeZ3uC4UixGt4+2Z1cheY11QJT9/ijEuLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dOP7+bK2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBRHnX005675;
	Thu, 20 Feb 2025 08:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=E6TGV
	EZAULTwoxo+VNOwsMcjr0ZX4edl0XE/MW0dHe8=; b=dOP7+bK2uueRA+IBZou1W
	rZ+HCx2Wc30SFI8pZfeFyLM0tuV7sNRoqCG8vj/oNx8p7KshhotJzVby0H/2vToN
	ZpTVJbvxP7Z+7pY7iQjRppP/kqtVETWvwVn9C3o2bJ+3aoa1mJcDt3xlS1E0kuG+
	tqz8E2iBoABh+DjOafVOpXdSi4LdBy2ITulqOyalWusTNxxyZl72QkkYnwNTCRmi
	Ruh2VxRV7kWfAoEcnpCYj6YUwXi5/TwVtUIsHKmAkm+JFb2gpY5DWWxhhiIUj9JR
	Qk37cvdhfybCTtbFflWZsVWQLDUIdLNDnRqXHq1JCS4I4/HrNFmPEKw9h9IXdI98
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x3hj0h02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuEvo054131
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:13 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqs008409;
	Thu, 20 Feb 2025 08:56:09 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 05/14] iio: backend: add support for number of lanes
Date: Thu, 20 Feb 2025 15:54:15 +0200
Message-ID: <20250220135429.8615-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: dhcceT-P-kNHiHHolSRynINRnwIHKivQ
X-Proofpoint-GUID: dhcceT-P-kNHiHHolSRynINRnwIHKivQ
X-Authority-Analysis: v=2.4 cv=OJvd3TaB c=1 sm=1 tr=0 ts=67b7347f cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=EQBjZkpt2u5JWN5EroAA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=964
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add iio backend support for number of lanes to be enabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 99c46b79e373..64ac3c6d9eb4 100644
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
index 38322e808ee2..67e062cabbea 100644
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
@@ -211,6 +213,7 @@ int iio_backend_bitslip_disable(struct iio_backend *back);
 int iio_backend_self_sync_enable(struct iio_backend *back);
 int iio_backend_self_sync_disable(struct iio_backend *back);
 int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en);
+int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.48.1


