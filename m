Return-Path: <linux-iio+bounces-17935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DC5A85D63
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D98F179B72
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED622C3760;
	Fri, 11 Apr 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zqo1Lo40"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325292BEC4D;
	Fri, 11 Apr 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375014; cv=none; b=LrAG05btwkvuNpvxWhz5y9W5BK68mAWoM0xs4olfW+afnCmK+le6fS1461IP/Ii6G9YvbgyoNFQfmEg2g7KgJ/qRMFDB6m3wHkAIq8qa0eFnv4FnxqbTaSwpx64nTiHSj9ccjoZqPgPf+hUDMnioQTkOm/tLvrS9ZF9kRfCXcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375014; c=relaxed/simple;
	bh=yK0mkDN8ALiXZ4/3J/toMNem8KUgvx2szsl3CPXxjmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrITP+PMri0Y7n1WmtCXqYcY20J03NfKGR8Wg1y18vteg2V+pwZEf05NfmA3jUdnVX4NuF4xDZ1UX6sp1h6oJW3EmuLwEQtWDlhuPA8Dt0dE6FKenfDnmOzAfy+jmI0Bn2grtzvCntpJ1k6pc5pxGbPTxaGSA/gSN3ieigauIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zqo1Lo40; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9VvR2015129;
	Fri, 11 Apr 2025 08:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lnmEA
	lTnzjsRixf4kdaMCGr7P/uLkqVnRE4iogjkWIg=; b=Zqo1Lo40c1apR4sW2pGWf
	SCR7NCXK9AYRJ6Sgfhd1UbqzmdD1K1kz+715wvNZ0sqxQrxAg6qm7a35zGbBLYVz
	1jrZjfA+qhjiVFGw1K/6BnmQgg33QliDq9WtwYoGYOVPPvTpaBC0OPNxXJsejJpy
	aIHSIxOXhR5NwC8/FDSeT6HWKyeyzu2fU0o7MdS7M2YbvtY15YGBCUzD+Jg3BBUl
	Gl8F+C7V8sZgkSJ/alxGMwtDBd9hFrRGygEM0OhKMF2kBHCeAJfx+gvLkHCCnR8w
	L2s0qNf753/i+CQLtogDJcOhik36sBPSS+Jtww4krK06Od77BUdC6JV/l6nDmtge
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6u55f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53BCafN8005149
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:41 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPM006015;
	Fri, 11 Apr 2025 08:36:35 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 02/13] iio: backend: add support for sync process
Date: Fri, 11 Apr 2025 15:36:16 +0300
Message-ID: <20250411123627.6114-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: XVFNQ9iN1YoLfzfnWh8AX0SbMnC5o454
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f90cda cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=AWommT912SskAef1OWUA:9
X-Proofpoint-GUID: XVFNQ9iN1YoLfzfnWh8AX0SbMnC5o454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add backend support for enabling/disabling the sync process for devices
that have data capture synchronization done through bit-slip (correct
data allignment) procedure and not through and external hardware pin.
This setting can be adjusted within the IP cores interfacing devices.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - rename function for better clarity.
 - improve commit description
 drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index ffafe7c73508..60578267643d 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -804,6 +804,32 @@ int iio_backend_filter_disable(struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_filter_disable, "IIO_BACKEND");
 
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
index 7987d9f1cdb3..beff66d18151 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -102,6 +102,8 @@ enum iio_backend_interface_type {
  * @debugfs_reg_access: Read or write register value of backend.
  * @filter_enable: Enable filter.
  * @filter_disable: Disable filter.
+ * @data_alignment_enable: Enable sync process.
+ * @data_alignment_disable: Disable sync process.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -154,6 +156,8 @@ struct iio_backend_ops {
 				  unsigned int writeval, unsigned int *readval);
 	int (*filter_enable)(struct iio_backend *back);
 	int (*filter_disable)(struct iio_backend *back);
+	int (*data_alignment_enable)(struct iio_backend *back);
+	int (*data_alignment_disable)(struct iio_backend *back);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -196,6 +200,8 @@ int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_dev *indio_dev);
 int iio_backend_filter_enable(struct iio_backend *back);
 int iio_backend_filter_disable(struct iio_backend *back);
+int iio_backend_data_alignment_enable(struct iio_backend *back);
+int iio_backend_data_alignment_disable(struct iio_backend *back);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


