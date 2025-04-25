Return-Path: <linux-iio+bounces-18629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA556A9C777
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056DC3B379F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229D24337B;
	Fri, 25 Apr 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wVl4u873"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DE241CB7;
	Fri, 25 Apr 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580361; cv=none; b=EY7e2niBWXu7JV0mqFQe6Qt9hH4tsjKLajVDMNv1xg04P0baxnebkj2HGV+xh9QwLBe3uzVvEc4+mzySFevcmRcJ1SY+NX9BOF4xECTlnCo2C5lu6ePh26ja78Wyh8AryDgR4rTei07muhJ2hldw/Dk1/M1yP79SZVMt1qStHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580361; c=relaxed/simple;
	bh=Gm0S+KY5uY5IASM26sJYnBEQnvLbZkNSih5Hc8ek1HY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWafNjzYrjvwAuq4HZoCORPK2LXDtALGKYo8j6i2EWkpnFeICm8Unu9SqoL2oU0BI96VZ3tsam3dcU9EtTWlwnHQZz0+4VCO87xkBgQM+QaUCG3FXoQ3a454Dp1/faAWRhAFRly7xa/ln49hOSwA4ovnWY2WGpnOfTkasCWXN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wVl4u873; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9ocmL014720;
	Fri, 25 Apr 2025 07:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lEImt
	4P6enOMzldO7z1W0hEuG/eFHH+4/RPwUMQ5tls=; b=wVl4u873HF5vTFCKELEcT
	XUJY1ZHLuvxHf1wqFhvFQEGhEbPkb+xQk18VfltgsLOVmfTPYI1uUV8kYPGYMaC2
	Dp5UNujvz6MLLc5i9exe+ApwpM+X61dL4oRqwKAQq0WYvFjycM6l2Bu+sZKmVizw
	1/vUaxapIGaao2gEo3lVe9bVZ8sxrOKih/F3VnP/Em8n7JG5QjP/9EQzZHqywq71
	tLTvBWCS1c0V6uWWwY1FgYFfpgW0Cr4Gy/1LbctjVteg4LVPvtir/zrmOv54sOIq
	7zth2t9JpDxnx5Q4rr9N2k7gJA2ONFr9RztF/D2I7OMvSdvRgPhi6sga1fRY4pJb
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjwf1fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:25:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBPtOE049197
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:25:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 07:25:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:25:55 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbs003881;
	Fri, 25 Apr 2025 07:25:52 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 02/11] iio: backend: add support for data alignment
Date: Fri, 25 Apr 2025 14:25:29 +0300
Message-ID: <20250425112538.59792-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: uXfURWZaERKBeyj9xsKYN6iGqot6ZFHx
X-Authority-Analysis: v=2.4 cv=JMU7s9Kb c=1 sm=1 tr=0 ts=680b7144 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=AWommT912SskAef1OWUA:9
X-Proofpoint-ORIG-GUID: uXfURWZaERKBeyj9xsKYN6iGqot6ZFHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX/z7ag8jgtSLS +ItiPNcMqNebUK+yX9JWl2tg7T79UxtRWQerwDDQV01JlzNKCntxIZChACcESgsHD+8vnG6Hagz BnaQvcbqHEcqWgbjLiZGI5f7nb9cLJpTsRM5mdhllU00PAIWu2jceBshD367ZJUF0mucHy/T6T1
 +Q6LvTxVD8RNRRcZmLsXhZZ/SbIq2ckPLmdp1MuDa+AmuKFZlbIzJvUakZAAIpatPsmg8gC1ptz bvHjWAFI5H9zoInmrrle4VJ44a8QS3OB58pYZdwx7IBvf+pMgo5P6pc+jLqAyKP2/Blcw51Mpe6 fDqJaA0JLzsfPuMZym/niZ6nJr7gTYBJePLQnPwa7UT2ei61ScdzHzG+gNIVRGAgvIjuzGdagby
 rsuX+XqBTLeolt5S1IUN+2WoULE4bY5cU/k3bC6hyr2dyuBLSPo2gmOTv+QRkUq+zlKJq40z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add backend support for enabling/disabling the capture synchronization.
When activated, it initates a proccess that aligns the sample's most
significant bit (MSB) based solely on the captured data, without
considering any other external signals.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - update commit description and align with the new hdl changes.
 drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 2d28eabb1607..b77a31b16aa5 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -793,6 +793,32 @@ int iio_backend_filter_type_set(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_data_alignment_enable - Enable the sync process.
+ * @back: Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_alignment_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, data_alignment_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_alignment_enable, "IIO_BACKEND");
+
+/**
+ * iio_backend_data_alignment_disable - Disable the sync process.
+ * @back: Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_alignment_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, data_alignment_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_alignment_disable, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 5526800f5d4a..bd973de8cad9 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -109,6 +109,8 @@ enum iio_backend_filter_type {
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
  * @filter_type_set: Set filter type.
+ * @data_alignment_enable: Enable sync process.
+ * @data_alignment_disable: Disable sync process.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -161,6 +163,8 @@ struct iio_backend_ops {
 				  unsigned int writeval, unsigned int *readval);
 	int (*filter_type_set)(struct iio_backend *back,
 			       enum iio_backend_filter_type type);
+	int (*data_alignment_enable)(struct iio_backend *back);
+	int (*data_alignment_disable)(struct iio_backend *back);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -203,6 +207,8 @@ int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_dev *indio_dev);
 int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
+int iio_backend_data_alignment_enable(struct iio_backend *back);
+int iio_backend_data_alignment_disable(struct iio_backend *back);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


