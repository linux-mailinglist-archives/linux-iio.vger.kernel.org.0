Return-Path: <linux-iio+bounces-18964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00BAA6D4B
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB6464559
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39B230BD2;
	Fri,  2 May 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FLkgmCLp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A122DFA7;
	Fri,  2 May 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176384; cv=none; b=Wb6jSCnMKxxp3HQ5k1IV0vEcsp4JnzjWpJIoWWKAEYLyBKkAqbp1jCt4Mc8+ql+/5OSoZD0gMU5FzLptRizmsqrmUhiYpMgxWJ/rVfBNLM7pNMYMYrgnWz7D2SpZmRfv5lY9E1Dzu14bMJpAxNhUDCUyl0YvKVXJgSc0YAAQJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176384; c=relaxed/simple;
	bh=LM3ISJdPNjpaYVD/id7uVZyE9EZXVma+CN0TwsdfXtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALmrtaDeNyDFCYddkNi2tLBd+eR72oHSNUyDcOraVFigCOIURp/dGgnf8BCFBBjnyp8r3SMeiBMrtr20I6hzUFldGgKc4Y2OjFy8TjejwnCW+FitTZyOmD29qJMq/Xju9bTP7bre86qLFVS9CRVFWFCwXzLsR1cdlDo16rlWnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FLkgmCLp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5426qvdG030837;
	Fri, 2 May 2025 04:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TRLas
	Txx/1kDGYQyOgFNaUyOIo+ZeDqV5phFc6/7rEM=; b=FLkgmCLp6m5UoRD9i3zxz
	rfNXQwJeJrqBLz3J4n6YL9XT/boQ72DWkV+Aa3zN+0Ju+SSUumJfFxZ+k1Nim5fM
	GGBRNkKoMZSHcd572ozhzlnvCQF7NtCGRYZODxt2jkRQomSnmTMf8nmYygwjXc/b
	Gx4EXkLEkMkjUkKNUnRI/JrHkQ/otuKKMi3jEfuBI3/n9diWUb29/JCaDiezgAW0
	WwNuwN9nHyBxj9O/XZUqI59KnfcEQtOdGq/7+z0tlC40NLo3pXyZae5265QrKH5z
	Nu4LINSOXMnfmcwsyQxhFa/lO7n5J/SmYkFQX9Wv0/NiQtKVPwHXT9IOpMcNaYr/
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46b6tr3xq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5428xXCY029948
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:32 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7M015723;
	Fri, 2 May 2025 04:59:29 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v4 03/10] iio: backend: add support for number of lanes
Date: Fri, 2 May 2025 11:58:58 +0300
Message-ID: <20250502085905.24926-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iGFygjxJJyk4SYVeiGntPh8gWuLimZzd
X-Authority-Analysis: v=2.4 cv=TpTmhCXh c=1 sm=1 tr=0 ts=68148976 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=Ge_Sr372ckFWHCXdfyYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iGFygjxJJyk4SYVeiGntPh8gWuLimZzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX3WBUfKD602pW qaMxJwEYwESxzqQFNMePxzH1bk32jh/t7xfmQ60RmDBAMIOpV16ht2YaX/wc/8pLsmhF18u0onk ZRMF4cpsKeULtYOQ/VN25NiPUK8z2LrtPFpGNkBCmZwAOgIHKY5cIZqLCnDPDq1EVtqZfxqEsvy
 syniEzbpRpmq5JHNVy0AxgaMXDjFXIeCInXYdZ01+71t5NU3yRQv22zBrjHX77Cjjy05i4Zcfx2 SvgbcQg8dT9FlbRmQewb5OpnIqa/obVeX4GV99inaLnqNOFZwGpcpOQRF3osZ3OHBFl5hAS0czB QYZa20+Bq2lRzg3rEUvnNxscVhZrNRFNDZjMpzsvRE15j9KccaJ0DnSkeN5ylS6z3FQnObVFELv
 E5H6gRNoeFdebX7nlIgnPZxVyImIwZsLFyeWnkEE1pUTUPuQE0udZDUyTNBocyS7xf4U9xzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add iio backend support for number of lanes to be enabled.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v4.
 drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index b7cbbc7a8fcd..78a957d1fe92 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -810,6 +810,23 @@ int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
 
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
index 452cb2838dad..1ffb200eb3ff 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -110,6 +110,7 @@ enum iio_backend_filter_type {
  * @debugfs_reg_access: Read or write register value of backend.
  * @filter_type_set: Set filter type.
  * @interface_data_align: Perform the data alignment process.
+ * @num_lanes_set: Set the number of lanes enabled.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -163,6 +164,7 @@ struct iio_backend_ops {
 	int (*filter_type_set)(struct iio_backend *back,
 			       enum iio_backend_filter_type type);
 	int (*interface_data_align)(struct iio_backend *back, u32 timeout);
+	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -206,6 +208,7 @@ int devm_iio_backend_request_buffer(struct device *dev,
 int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
 int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout);
+int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


