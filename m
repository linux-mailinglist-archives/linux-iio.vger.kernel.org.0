Return-Path: <linux-iio+bounces-19574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981DFAB9784
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263E117DF94
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741622CBEA;
	Fri, 16 May 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gt3m7Nd9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E41FECB1;
	Fri, 16 May 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384012; cv=none; b=L1a7xGAZx+KRfmxCeDcXznFOEKvLxX5PaRWcHKNzzW3BbvNLHWo8zanPWEReLGFB8iFGMB4CA5TLUGQCPEVNRYASovmRz/TFmIfM2E6fKqQKH5fMmJoxsLXHcOKPJVk0uFU6Txd4FlTSqHNUpcPiDQryxLjKstd5QfXzBI0bUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384012; c=relaxed/simple;
	bh=PXHQfJ3vn1EsI5Gv7WaYPUScwI3KJ7RIRgAa+nUDW04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0ulcFcTBGCR70B3jkqYyOGUQLd7pDSbJAN90SiPGmxzRF8xnAVkn+Q9jnYNeob70u2FUcdYsQMRGi3KhL9JM0SAZf2UfX6Y08L9hG8OpVKQOcqXgAswaBcL6WIq4fSHBi3+cR555HrYL8seshZF0TIHt9u1YBtM3+ya7IE3YD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gt3m7Nd9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G8Ce18016372;
	Fri, 16 May 2025 04:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F5lkZ
	1qJDGrYUeQEVHeu7s0q9S89KNko1H1VJOnmKdo=; b=gt3m7Nd9ZepOUhDuvxTZS
	rp036HM47OLhz5fPU3AbqRI/7Rp5ABhjMvkqJRaGKQ3AH36yQu+fb2DcTwcoY93s
	fID1ooTBYi+tsab93UgpKo8FOrwAZQYSZ9eTcVwOhmo3Jh2K3Qdy/caw72QQ5PpU
	rxpWgARFNXow9pdnpcoYlY8YwN2Mdzf9xdG4npSoc7DnyE7GEEW/9AwkNPRuqAS1
	33l8M535UU8GlUF1XlvQdv3ngBc6Sbo3mJ+NASgml1Xk8udwx/+qTh4KPinBYfXL
	YOb05TnPpS+t7IyD/uNNyqQt2wDWWO2ItwlYUU6K9Nc21SJwLw5dYgyhpbYDKvE7
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46mn654vf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8Qkor033605
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:46 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwg031549;
	Fri, 16 May 2025 04:26:42 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v6 02/10] iio: backend: add support for data alignment
Date: Fri, 16 May 2025 11:26:22 +0300
Message-ID: <20250516082630.8236-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: hjS6tQnkKX2ml0NvlG0KlWXNEtnGfGgG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX9swB45JTor+H
 EEeTJFeibFD0Ix3gv9WVKAjJlQuCxvouOO9YnC9kZUu2+Cw+SpnUE5FWtbhTPoegtv57Jv67S1B
 sjkEuUK4aI87xdI4kFo8bytawsuzBD21cUczCThXIK4rtLX890+d6DDfbaXKyq0ioNJnFAIXDsC
 YZ1e6FooPlQQ0pUW2HIDF/C4rhgjM4ZZzPe1mphHUsUgouGS1Ob/5ckJDBJ8nSLXvQJtobl3gyG
 bL5Ok0CZ7YXzjEzxXE8kfe6jPViS85HEqXQHlHq8HCXpiN1vjfhAgS8js/vCC4q19VukmSr2mco
 gNb2SWLB46jjfkmXr1O9q6MY8YwcyQqFyrRyAxst4YAlWY6NfIKowfMV6ZbVZArhDqRiZWoX83B
 FakMsQvtUmSOGafI5Z8A7UkViI59jIXGyPt14FFriTjHnW7XjuiuccI9ipUOK3Y/LSjL4Eu7
X-Authority-Analysis: v=2.4 cv=SZL3duRu c=1 sm=1 tr=0 ts=6826f6c7 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=LieQXdaOVuYbdPten0EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hjS6tQnkKX2ml0NvlG0KlWXNEtnGfGgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160079

Add backend support for staring the capture synchronization.
When activated, it initates a proccess that aligns the sample's most
significant bit (MSB) based solely on the captured data, without
considering any other external signals.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 drivers/iio/industrialio-backend.c | 23 +++++++++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 038c9e1e2857..545923310f1f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -796,6 +796,29 @@ int iio_backend_filter_type_set(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_data_align - Perform the data alignment process.
+ * @back: Backend device
+ * @timeout_us: Timeout value in us.
+ *
+ * When activated, it initates a proccess that aligns the sample's most
+ * significant bit (MSB) based solely on the captured data, without
+ * considering any other external signals.
+ *
+ * The timeout_us value must be greater than 0.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us)
+{
+	if (!timeout_us)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, interface_data_align, timeout_us);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 5526800f5d4a..a971a83121b7 100644
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
+	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -203,6 +205,7 @@ int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_dev *indio_dev);
 int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
+int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


