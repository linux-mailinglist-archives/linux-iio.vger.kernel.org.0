Return-Path: <linux-iio+bounces-18967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65678AA6D54
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0299518938BB
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0923814D;
	Fri,  2 May 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zn4vNVXY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0022FACA;
	Fri,  2 May 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176385; cv=none; b=ZilXHPEQdQxtwArnlGnDdjCINBh9yhipXkeSVSKWJuGTm2DSkwtvFtN48kplfYOwaJ19uG4n6UFXbKcNWgaaBfrRViNiXk4BfUpBp0XaQRwz8+ulLJnafhAW8RF4tWqLXe2QFN0YZy8V2R+G/f94p785D2eaya7Hdhma2Gvmkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176385; c=relaxed/simple;
	bh=yc7YZyiHg5pmKBbPHTB2Guyi6OVLmAtODC1e+TEK/xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btu67qFKLPGf4tR3j1JNbh/BEFtbD39vGdQCvxzTLS0ycuE1qmqCPJLmGtG7ChOHOAUlORagjLyFllyUG9BFTOYutnu95l5yXgYvCcH7DxMptJ3TE/xy9+MEJy5yDBVXxwcaexn0v9tP2HcacjR/MDu8WB/w1RMD6FxtgNW3Yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zn4vNVXY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54270hfw030647;
	Fri, 2 May 2025 04:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xxrIc
	nhBfRtd8cvn/u+XbD4N44DM53U8qi/bmtbLmhQ=; b=zn4vNVXYpds/okvU+gTGX
	Sfd89jJai3P4cLyM95Yb8nyzfwqxNmFibn8O4LSm7P/Byg1+8pUjZlxjWv1zPh5p
	+nfqcHCyw1xtLQ2SiOhlFk3BE3mzzzzDFCQikOoukhDTzfXYRI4QG1C3/0gW5rVE
	UldFSwLQ60u+hg4+0KV1KuJIo7CV7FFFDeorZIU02uDHDxo8XN6PIN7kFznIbA1l
	22ob0JATjfroyLSMRO3EoM5USzXcgam0cZF0sFK/0EUFnV20CW1jr4DVkhst4n+y
	PdK0nT8Je+Pj0jZMRLrYW1knHk0iTNkvvmowFG58lnHtIoM49f0ASyFw6tTDdIkh
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46b6tr3xq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5428xXCp029951
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:33 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7L015723;
	Fri, 2 May 2025 04:59:28 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 02/10] iio: backend: add support for data alignment
Date: Fri, 2 May 2025 11:58:57 +0300
Message-ID: <20250502085905.24926-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lkHQs40aNrIuct8UvJOSjTW1UfE17onc
X-Authority-Analysis: v=2.4 cv=TpTmhCXh c=1 sm=1 tr=0 ts=68148976 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=362gKwIBT9qLEHrmTkEA:9
X-Proofpoint-ORIG-GUID: lkHQs40aNrIuct8UvJOSjTW1UfE17onc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX0LVyNCkrkvDC HeE2Ej8PsL/1C/lJCnqJ/TjZQCAk91P/MnrJALHdvp42vaLN31lqQXlrdu6CjIiAFpK/g4rOlzZ YQcjmP7tFCN/pjcHzl8VAynCD21KtLLfUhnRDgOvgqog82BkqX3DDbovqHMyi4asa/8x1KivrHX
 p42EnIqhnPfOG2QTdknVRXe5x9AjgazivcRkPwUx/H0P7Km35OFdjIHHmQstwnp0LUaa8GGkUFT YLoUm5UgmPjaVMzKudvyO3UEijVe5paQJDCtz2Q6Fp/flnpwgvCwexVutt4F9TaSVpeQ3k1fF7d ZldH2eYx0e53nMvz921cMmknNVcuLltI9dwDiCPOf2OcWXC0+1bn+zVlSbUAcSjvpDc10LVZTPv
 fmK96H0KXS/s3mdbnDH+4E2N4hMGfCYX4OYuRp9AGmCpx3TrddN/0h1yEoIVa5DZ9++kdG2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add backend support for staring the capture synchronization.
When activated, it initates a proccess that aligns the sample's most
significant bit (MSB) based solely on the captured data, without
considering any other external signals.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - implement iio_backend_interface_data_align with timeout parameter.
 drivers/iio/industrialio-backend.c | 14 ++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 038c9e1e2857..b7cbbc7a8fcd 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -796,6 +796,20 @@ int iio_backend_filter_type_set(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_data_align - Perform the data alignment process.
+ * @back: Backend device
+ * @timeout: Timeout value.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout)
+{
+	return iio_backend_op_call(back, interface_data_align, timeout);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 5526800f5d4a..452cb2838dad 100644
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
+	int (*interface_data_align)(struct iio_backend *back, u32 timeout);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -203,6 +205,7 @@ int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_dev *indio_dev);
 int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
+int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


