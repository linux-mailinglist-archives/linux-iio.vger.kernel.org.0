Return-Path: <linux-iio+bounces-6518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2DE90D966
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B7BB2A38D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0407F770E4;
	Tue, 18 Jun 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="i5Q6aiiA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116D768E1;
	Tue, 18 Jun 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727028; cv=none; b=MkK7KDF2GmKr7/k99PlqpL2XKpL6xKxH2qXJhRliZrJcHiSEWatcwpf6ZHy9p9Gnjc65J+YgJzLO5mV8M3j3UYiEg0XXBytCnBHyuP+jtE0mnMM4TOb4N9BG1Pd1rK0+i2DCjgAP2iG12Yg6xEZApEtVNoFS9gF2Htap9a+7FM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727028; c=relaxed/simple;
	bh=WnYHhpxz9XlN8DeOrkUc8ti0eDWrfck7MDCrMFMg9h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnJArWGn9IzsH65cqI1ZYyHCXDV5vUNk7nIEtt2eC7Ss9o/UA+30dSTRsokDxD2NfGXrUme3xsNzPMEowdODRrN7RXlkvMhTsvstXbGElN6lolXjDgYd29Klo3VtGRG9Y1o3jgbAxtdoG0/XGln6lpJv4z45zKIV8oaMg/EiQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=i5Q6aiiA; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IFZ34s031794;
	Tue, 18 Jun 2024 18:09:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oBCkKn2xGyjUcuH9Isse3UsfR/NglWbSwpBTIgOD8P4=; b=i5Q6aiiAhdqsWdh3
	COWH75mYjCzG2pIayjSaeCWo6gFdff4vmdgtWq0H5fK7Lz7VeVLwCQj/27uWzC89
	aSeC+TFdNXZqE7qFTSbn/rqFEmzsfTCRiN3r3E8Jier68lWgX0sMdBhzyoAtjaPI
	4gf5QOURQlUDWssLYf4eFVKXh6dblMisLnDziwJ0iRAdoQJP3AHqC9UUb/WIthLH
	7culiSKt+7p9vJg8W1YlDrb2IGsjEOAPeZGaxZdE8mFm7ExV0tSbkHDCIXUCdL0g
	vz8j8P03g0I4nPHV81MP/AhFt8nxWR5it/pJX6L2oVI/xQUM/DGpqJ2IyVTkgBRf
	Ov5BeQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys0cgca1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:09:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 76F3940044;
	Tue, 18 Jun 2024 18:09:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B94321D3C8;
	Tue, 18 Jun 2024 18:09:23 +0200 (CEST)
Received: from localhost (10.252.27.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 18:09:23 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] iio: add read raw service to iio backend framework
Date: Tue, 18 Jun 2024 18:08:27 +0200
Message-ID: <20240618160836.945242-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618160836.945242-1-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

Add iio_backend_read_raw() service to support attributes read
from an IIO backend.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/industrialio-backend.c | 16 ++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 929aff4040ed..b950e30018ca 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -357,6 +357,22 @@ int devm_iio_backend_request_buffer(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
 
+/**
+ * iio_backend_read_raw - Request a value from the backend.
+ * @back:	Backend device
+ * @val:	First element of the returned value
+ * @val2:	Second element of the returned value
+ * @mask:	Specify value to retrieve
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_read_raw(struct iio_backend *back, int *val, int *val2, long mask)
+{
+	return iio_backend_op_call(back, read_raw, val, val2, mask);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);
+
 static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device *dev)
 {
 	struct iio_backend *back = ERR_PTR(-ENODEV), *iter;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 8099759d7242..cff486699054 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -81,6 +81,7 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @read_raw: Read value from a backend device
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -113,6 +114,7 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*read_raw)(struct iio_backend *back, int *val, int *val2, long mask);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -141,6 +143,7 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const char *buf, size_t len);
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
+int iio_backend_read_raw(struct iio_backend *back, int *val, int *val2, long mask);
 
 int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_backend *back,
-- 
2.25.1


