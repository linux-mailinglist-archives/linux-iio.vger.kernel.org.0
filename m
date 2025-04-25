Return-Path: <linux-iio+bounces-18630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A9A9C775
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5911BC64C2
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B5B244685;
	Fri, 25 Apr 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z/hb23nH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC39242D77;
	Fri, 25 Apr 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580362; cv=none; b=eplGGQpfGk0zzok7qUrkNU7bNkmRD9EDXThPd3xZtrSOy3H29bDW2EigL/xxzgwaU4HjXHaxeDyZbsnry03NUekImq7SnQSosAODO4K4wTGsdTb2eFwoUTYeDOGZoG4NJy1cvEV2kxeoEOm5+mDr0OwscteEzU1KB3h6ly/LXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580362; c=relaxed/simple;
	bh=jKD0Fvkhbkt/Nbn18+Y0DDmBYBcCCj9kOxH1VqdF2Ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZzCS80W1qMnylHVaMYCni7BJk1G0PwceKc6jb3gY80ajN53sgMM4Z8M+fsm04S8o2c2qu7ARXj1vZZ3ZgjHW5o017R5Q1A2d+vweQltPF3FhwixmNX/wU/EdQeb+1M+8+uQEPlPXGohMaHRGzn5pIvN2QzYy+1uomyXUZ+RZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z/hb23nH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PBNnRZ014719;
	Fri, 25 Apr 2025 07:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DItPv
	E/G6RgDJjdJUkC+0TQLy6mncpdzKnHVih8ldUg=; b=z/hb23nHod6n97YW5ZVAb
	wqezTeXlUnyZ+s8wDQNR1S39i5W7CpdvcsSM+HUcYb3eWqMkENz2UXFG7beOK6kE
	s76bUAt0EBi+6GjK97uibpKxDgE5fkJ8rgHmsO2G2s5o+MgKsMWwj/TLKjupON2C
	HYSTevcbbEv+0B4Jd2N2U+K5Ck/DuJL1yZ5zvkpoIA/QRzcBLoqsupjIUZg+98mX
	9agrqO/jpoRYgQG7V27ZIcSq+d/kbY76YZdfi3XD2MVc7c8UtHNnMVGJ8ghJnXlL
	XobA62riZ4elicczdw4mEf4HAQK09Ux/V9t+NC8OlsWaDkh63S9/5XcKb55V7LSE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjwf1g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:25:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBPuL6049206
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:25:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 07:25:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:25:56 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbr003881;
	Fri, 25 Apr 2025 07:25:50 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 01/11] iio: backend: add support for filter config
Date: Fri, 25 Apr 2025 14:25:28 +0300
Message-ID: <20250425112538.59792-2-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: bfYrKdjSxwR0puM1cr1KzAGLvYHiqRGj
X-Authority-Analysis: v=2.4 cv=JMU7s9Kb c=1 sm=1 tr=0 ts=680b7145 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=UD3WkZFi8vOiteFn2FEA:9
X-Proofpoint-ORIG-GUID: bfYrKdjSxwR0puM1cr1KzAGLvYHiqRGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX8JCgyO6przdI Go/8Uljs9R7E1cLT1uOS5/wdrbyWwnaXXrXTZaBWklXDleRDfArDPdq37oZ1VbQ9KrRZuvtPYUB csZCuP+DTdrGep9KPOaSjaOcO0PJg1QyKhO/ksJ7oSzQuGUoRO/TMkCrW+Ip2InumCdjy0jh0dw
 E4WOOD+OSBY5Z4505cz/yW3abFhlKpGgBQ9Wy0edMO0XDaSfdRQeMNDtC8veHlk4smk3JtRH94c /JdukB7IqgRzTGaZCA/MYozGB7pO4o7NyeSmmCPtlO+SVyaol1fOTD1RD3RxAOwPKzzSEszaSuV Azf3OpyY6HSrrbPRUSEMDRjFJz9Qo5kAGNuw0yXkddc0xfjJ/6koECneTsiwB+S8c5sVaM+r03+
 JRBEGZeJzsfcCYNxANgNzlb4rTX7Q97gPFObdbAzqC0w3LHhqXuGwajc162RJn7HRkjh/1yW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add backend support for digital filter type selection.

This setting can be adjusted within the IP cores interfacing devices.

The IP core can be configured based on the state of the actual
digital filter configuration of the part.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - update function to set the actual filter type instead of just enable/disable.
 drivers/iio/industrialio-backend.c | 15 +++++++++++++++
 include/linux/iio/backend.h        | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index d4ad36f54090..2d28eabb1607 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -778,6 +778,21 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
 	return 0;
 }
 
+/**
+ * iio_backend_filter_type_set - Set filter type
+ * @back: Backend device
+ * @type: Filter type.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_filter_type_set(struct iio_backend *back,
+				enum iio_backend_filter_type type)
+{
+	return iio_backend_op_call(back, filter_type_set, type);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index e45b7dfbec35..5526800f5d4a 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -76,6 +76,14 @@ enum iio_backend_interface_type {
 	IIO_BACKEND_INTERFACE_MAX
 };
 
+enum iio_backend_filter_type {
+	IIO_BACKEND_FILTER_TYPE_DISABLED,
+	IIO_BACKEND_FILTER_TYPE_SINC1,
+	IIO_BACKEND_FILTER_TYPE_SINC5,
+	IIO_BACKEND_FILTER_TYPE_SINC5_PLUS_COMP,
+	IIO_BACKEND_FILTER_TYPE_MAX
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -100,6 +108,7 @@ enum iio_backend_interface_type {
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
+ * @filter_type_set: Set filter type.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -150,6 +159,8 @@ struct iio_backend_ops {
 					 size_t len);
 	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
 				  unsigned int writeval, unsigned int *readval);
+	int (*filter_type_set)(struct iio_backend *back,
+			       enum iio_backend_filter_type type);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -190,6 +201,8 @@ int iio_backend_data_sample_trigger(struct iio_backend *back,
 int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_backend *back,
 				    struct iio_dev *indio_dev);
+int iio_backend_filter_type_set(struct iio_backend *back,
+				enum iio_backend_filter_type type);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


