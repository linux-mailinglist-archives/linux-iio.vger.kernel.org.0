Return-Path: <linux-iio+bounces-18631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB228A9C778
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21DD4E19BC
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF709242D91;
	Fri, 25 Apr 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ps8Uyq0Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D0244670;
	Fri, 25 Apr 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580363; cv=none; b=nG2GDLfOLyGAuW5jw+7lmyAQaRxKJ8Ujmx9eQnEHZ6vHgXJqz/QU2dBxvGU6dmrzsk+RDCSJmQcnNTwzVKAA4Ch3/rAxSHRTbTrswN5LRlysxH7pziHfr3HjNPNHCv76QQ3kzcrPfqSqlXdoDRqJ2KhDv5ZeV+WYwn//LWYPX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580363; c=relaxed/simple;
	bh=Xis74W/y46yl5FV3DUVOoe3qzLOou2I+XeCWpOdvZ5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2nSdhjYvVGmCGrfJQSkTmZxoCB+Te22az2C8SxOWXH4WwIcZBNdLcSfBUj7QwPyet+2Oay2xg6SDFULi0Z/z1yBcSw5cjNix5IbB7aTkNJFFIjXSsP7YVeRD+KYAg2s6aKXLLGDS0XGjdj8qlwNTqNNKhHm7NyklEd37odnKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ps8Uyq0Z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8nTrt016645;
	Fri, 25 Apr 2025 07:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=81/Tj
	aNLvdT8nbcpDEyAHoglrZeW/WGIiJ4EPCsz5ek=; b=ps8Uyq0ZntWzCdssrvq/D
	iTrai0demK31Z9+2qemyonLpe7/Olbi8ul87wJLj64eBmdlsiHGbpX54dY772Vh+
	ExLVvwcEl7woNq999ZgEObQafoKuVPGooDepRkQaXFBHYz8vObQ+1p1j0iBlsR3d
	qc8qKVbyyTFQAIQCOJO55UHHh/Jls504UvizejMsfFk628mDZ2onkBVprZZX/GZR
	aJBotmZww2mhuQsAnxkbwDcW2alNtWIk2OWKn19uq0iex814gzribKu6j/O4fPFk
	qoCGATQDLp4e5htbRhbB82AhfJ8R/a+KU7lPGQSmZXCAy3ay2UNxJD7CexYCHX0d
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46833j9qtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:25:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBPwpv049218
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:25:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 07:25:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:25:57 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbu003881;
	Fri, 25 Apr 2025 07:25:54 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 04/11] iio: backend: add support for number of lanes
Date: Fri, 25 Apr 2025 14:25:31 +0300
Message-ID: <20250425112538.59792-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425112538.59792-1-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: usRtVPNQMYev-BhaFXbB1K30H4ZPUp-R
X-Proofpoint-GUID: usRtVPNQMYev-BhaFXbB1K30H4ZPUp-R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX9ejcfEzQWtE3 BRNeoOJG+MYlYSPV4nE2BOgvvNBxxfQTbB9WA8OAf7iFXYiimFWsATXbKvgMDfesoAKkuERmssb 5qxir4FkLOWQck9mlmFlUJPzdiE5HsS+hqX05FgGAuVASAjlRSBGMnGNQHEdpWfxQlCUvNJvP08
 LNU9d4cQTWXZmqUyHan0DbqoZYJtuU+phrYyBwKVffXjsU+RvLk20PbMzl6Kzp/K2pL3+sdCkmz V4b91NDzzTELfzQi4c/o8mK9yzbsgaWgeBoK8aD6HQTe307wVxEZqPeJGdgfebJt182BEmHwDdP 4J7tQrc50J9cXAboKqFPG300cRDVfDP1PO1vJM9XVhN7SBK+OMb79LhXAcMlYpLYJ1svp2qKFRc
 1rsFqTVwvFyMvZCKSJivTd1tvfYxwqjfyrf8pSTES32X8zgGAGwQpVNLcMW+dcFZzCDOE87+
X-Authority-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=680b7147 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=XGXJvG3QnRm3y18W1eIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add iio backend support for number of lanes to be enabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v3.
 drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f7c8167a248d..1063935cd808 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -833,6 +833,23 @@ int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en)
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
index e93d1a98e066..c8bcfe96c542 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -112,6 +112,7 @@ enum iio_backend_filter_type {
  * @data_alignment_enable: Enable sync process.
  * @data_alignment_disable: Disable sync process.
  * @sync_status_get: Get the syncronization status (enabled/disabled).
+ * @num_lanes_set: Set the number of lanes enabled.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -167,6 +168,7 @@ struct iio_backend_ops {
 	int (*data_alignment_enable)(struct iio_backend *back);
 	int (*data_alignment_disable)(struct iio_backend *back);
 	int (*sync_status_get)(struct iio_backend *back, bool *sync_en);
+	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -212,6 +214,7 @@ int iio_backend_filter_type_set(struct iio_backend *back,
 int iio_backend_data_alignment_enable(struct iio_backend *back);
 int iio_backend_data_alignment_disable(struct iio_backend *back);
 int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en);
+int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


