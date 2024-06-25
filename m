Return-Path: <linux-iio+bounces-6894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA384916C96
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEDB1C242AC
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3717082D;
	Tue, 25 Jun 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jNqiWMPx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910FB170820;
	Tue, 25 Jun 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328160; cv=none; b=tsVtbA67RlQ01wQBCXWPIdoFpOZ/GiaqXCdMJjkpwfBd90kIRA840cWcIpKXkZoenNVUbeLsWYjV0po+0jQQFcvzPeIOEfI/wXsawCmU0bSZM8ix58WHgRI9brraWJ4xlRsQGdrAE0ROL+2V/IJjkxQbLdI/2hNFP/vy9A1P6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328160; c=relaxed/simple;
	bh=5WDojB2x8hYrLSfa5970Ibbg3oMXxbS5W1+0qaDaHiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4jlAx0Logh8ytadbMj7oy1Oj0+vlpoQvDgqRZUz2ntarT5uQ38pEKyKlbR3qWH1aWYO81RQF3w2yRE+oU+S6dHRPAEyDP46BaWQHqz2JxYYilgRf+Mo4RcguobiTb5i3mfZ2z5Z9tRyyLVfqyjnp+f1f631SwJX7vdJAi0MRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jNqiWMPx; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PDtVaq015936;
	Tue, 25 Jun 2024 17:09:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Lvu8LvSrvYK3xmjKziEMtqoXx01wKO4QCeuXVQ8Jr/o=; b=jNqiWMPxXoiO/fKQ
	cJI8fJRIHTa7gW3GRfm9FCkNujDvo1A70pfOHaLDQ0/M9uAE/OnKRUnfe/ZagsnD
	Q46TE2mRRg52drHn1c+Ic945wcj/iPyrZ4cUD1+G+kW2O65xowFmrjnmCbejZ4NQ
	mqDz4Z68NG9NwjadlS8jm2IGZZOv9joBXYIcwnGSyAU3w7J9bDdAcJbKjFuybafU
	zu2Y5h0yQY4bpSX0zIqDi930Ea3nb3YHEaTYsfQzeXT7JahFFiHntwYo2n/21MgV
	FafAOggHkb+AI53XkXANyOVKu4h+pXBWbWrklKUKKLpgTsd4/Hjir1Z5/+k8zIUd
	ZHWqKA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywkr5cbw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:09:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A7F0740044;
	Tue, 25 Jun 2024 17:08:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43FC42207A7;
	Tue, 25 Jun 2024 17:08:27 +0200 (CEST)
Received: from localhost (10.252.26.63) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:08:26 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/8] iio: add read raw service to iio backend framework
Date: Tue, 25 Jun 2024 17:07:09 +0200
Message-ID: <20240625150717.1038212-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01

Add iio_backend_read_raw() service to support attributes read
from an IIO backend.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
 include/linux/iio/backend.h        |  6 +++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 929aff4040ed..0e2653de1956 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -357,6 +357,27 @@ int devm_iio_backend_request_buffer(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
 
+/**
+ * iio_backend_read_raw - Request a channel attribute from the IIO backend.
+ * @back:	Backend device
+ * @chan:	IIO channel reference
+ * @val:	First element of the returned value
+ * @val2:	Second element of the returned value
+ * @mask:	Specify value to retrieve
+ *
+ * This callback replicates the read_raw callback of the IIO framework, and is intended to
+ * request miscellaneous channel attributes from the backend device.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_read_raw(struct iio_backend *back, struct iio_chan_spec const *chan, int *val,
+			 int *val2, long mask)
+{
+	return iio_backend_op_call(back, read_raw, chan, val, val2, mask);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);
+
 static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device *dev)
 {
 	struct iio_backend *back = ERR_PTR(-ENODEV), *iter;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 8099759d7242..24185718b20d 100644
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
@@ -113,6 +114,8 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*read_raw)(struct iio_backend *back, struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -141,7 +144,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const char *buf, size_t len);
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
-
+int iio_backend_read_raw(struct iio_backend *back, struct iio_chan_spec const *chan, int *val,
+			 int *val2, long mask);
 int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_backend *back,
 				 struct iio_chan_spec *chan);
-- 
2.25.1


