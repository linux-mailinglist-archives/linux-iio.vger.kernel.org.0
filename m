Return-Path: <linux-iio+bounces-15858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5133A3DBD2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD8617DA51
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904171FBEA9;
	Thu, 20 Feb 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R2TMZR26"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFEA1F9AB1;
	Thu, 20 Feb 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059777; cv=none; b=YQT4lzix0Mm7FUrSAeP0tjrFdXUEa0Qz2xkNU1ZRLkpxjuPSn3/kB3+hla5MTatNHmBILuBEnlqwSSOE5AYQwb/wfmglPKb+YII1dM+WaxyRVXPoeU04VXTn7jreZr/YUuXCgrp6yuu6oFa/7uAKjbftSeJjQCYtD048rNmiKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059777; c=relaxed/simple;
	bh=sOXHwtePtDD9Td2RPZMUXFNfKi17ygGe/v1geKwjgB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uljGtXevxPxoyqtyvZ8RF8WtDgQdptIg/UqKyrDWWXRKmO/JvsdfUP8QbLwBqqZvqEoruyTc5/cwCMzQselOfdPloEI1U6hBGXky2C1mZtL4/2pfD0N6Iv25UyFCKno6czZAYZQKs86gzkjkkOmOA7qGosBx8Tw4lUgSDy18hts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R2TMZR26; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBM0Vf023658;
	Thu, 20 Feb 2025 08:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZfWv8
	39mya+9Gjs08Hs993o1bTkuNZQMJqXS9gcxbKM=; b=R2TMZR26wqha5qfr0TzVB
	e6RBigX5zahDkrtvx7szHHUFkMLc/q5oyj8AH1gITfgbsxlRMouJnBLzJuGR9Kd2
	Ej0OQg0nZlEMcco8E3SYp46TmIbByuN9Tfw5c3QouNkYG0+gCgKVq+Vj/DP5z/5T
	1gfMe5rTndUYpRoJSx13NsX3b+9cLUzevZhh4zIfVHkQkhwOjY9TMkE1psGTHMpF
	xgeViBQHX6XIQWnxt3+sbuYl5DXEPFsvZaXuQbArCEKMhTTxv2eHI4Cpqe8BzMFP
	3xMtJFKjmQ/xuKs4yXkgxCvT70oP7cRfFvVgRhJycjnnR7R5zumG756IfTu3WDMM
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44x3f40hdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuB52054120
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:56:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:11 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqq008409;
	Thu, 20 Feb 2025 08:56:07 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 03/14] iio: backend: add support for self sync
Date: Thu, 20 Feb 2025 15:54:13 +0200
Message-ID: <20250220135429.8615-4-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: HOY_LTJ2SEj9Wqfkoqf_eiWVzFldfpI2
X-Proofpoint-GUID: HOY_LTJ2SEj9Wqfkoqf_eiWVzFldfpI2
X-Authority-Analysis: v=2.4 cv=DuKs+H/+ c=1 sm=1 tr=0 ts=67b7347c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=ygil0CsSKELNEGpiZjoA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=974 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add iio backend support for self sync enable/disable.
When disabled data capture synchronization is done
through CNV signal, otherwise through bit-slip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/industrialio-backend.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index b01db8a65b1c..a81780f569e3 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -830,6 +830,36 @@ int iio_backend_bitslip_disable(struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_bitslip_disable, "IIO_BACKEND");
 
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
index c7b4631b524c..8e663c838974 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -104,6 +104,8 @@ enum iio_backend_interface_type {
  * @filter_disable: Disable filter.
  * @bitslip_enable: Enable sync process.
  * @bitslip_disable: Disable sync process.
+ * @self_sync_enable: Enable the self sync data capture.
+ * @self_sync_disable: Disable the self sync data capture.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -158,6 +160,8 @@ struct iio_backend_ops {
 	int (*filter_disable)(struct iio_backend *back);
 	int (*bitslip_enable)(struct iio_backend *back);
 	int (*bitslip_disable)(struct iio_backend *back);
+	int (*self_sync_enable)(struct iio_backend *back);
+	int (*self_sync_disable)(struct iio_backend *back);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -202,6 +206,8 @@ int iio_backend_filter_enable(struct iio_backend *back);
 int iio_backend_filter_disable(struct iio_backend *back);
 int iio_backend_bitslip_enable(struct iio_backend *back);
 int iio_backend_bitslip_disable(struct iio_backend *back);
+int iio_backend_self_sync_enable(struct iio_backend *back);
+int iio_backend_self_sync_disable(struct iio_backend *back);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.48.1


