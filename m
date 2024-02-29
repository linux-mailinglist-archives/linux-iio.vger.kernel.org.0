Return-Path: <linux-iio+bounces-3223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B517886CC5D
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99251C2221B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0341386A5;
	Thu, 29 Feb 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hj/Yp7nT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E99185B
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219261; cv=none; b=VldM8rhVFXRPwNNXwUJl/I2ehHLdv3cJqGbRNyo1loX//pg/cyu3ldSoLzaR2HGGnc/ex59bALLFLN9AR9WU3+45YJlDq++/g+B5BVeeR8Uou6a56mSZP3LtynJXDm2id6vzHZGV2noAFdskSq9u4OpASqMoUpYd5v9CwseBVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219261; c=relaxed/simple;
	bh=BhE6A6K0zJeeJOai1xDm/06UFHkqenoGkDxOB7kWAuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bnc3jv0FGO1yVjuYseED5ZuHA95onXw3taknH+RaEJotElj8ZYmK1e15ocaNgdpxE4OzMZRLDlq4xEB/SofsL4JH7X72sInHwjnus5xHGasG5uj+4Ndr2Vwlg7EBo6ajvMa+UBT7dklnBZEF8YcSqzWFbsXT3LcRUkFCim6xQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hj/Yp7nT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TEaiEV007950;
	Thu, 29 Feb 2024 10:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=S7tEI5lXZTlox5jbn7MIehYX2VXBGiLwpKRQmvvcXWM=; b=
	Hj/Yp7nTzlKxo/VjCNqMUo9vhIUGPFgT27piV4dC64cDUXbrTxy66T2orUoMrNqH
	WaXpQLgj7mkZGigz+JFqb0z5Y1nO2KWLgwSSQl//Q5dm1AZNF7sdQdAZUaO/EwAV
	z6fSTshYYoX8Wm4ebJUBU9jwD5LdU8PFVdtUPQO7bx+a/oFzAwAs+XOw02hnMzrK
	uE6jISgTKxUpYX9Cn1uY+pjgpNYC+JNjgIttVWI5p4hFwoAfoLlgXuH+Vm9O+Al5
	TkDrEOmHvMBPz1iHcXbIjBuXBl43nL0VNhnzGQzqFQnmVS/6D/CXEvhB6Ktg+DcS
	Zj69hz4msmGWKOewKkaZGg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wjcr2ujaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:07:14 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TF7DRC023040
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 10:07:13 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 10:07:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 10:07:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 10:07:12 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TF73tl015938;
	Thu, 29 Feb 2024 10:07:10 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 16:10:27 +0100
Subject: [PATCH v3 3/4] iio: buffer: iio: core: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-iio-use-cleanup-magic-v3-3-c3d34889ae3c@analog.com>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709219428; l=5988;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BhE6A6K0zJeeJOai1xDm/06UFHkqenoGkDxOB7kWAuI=;
 b=vfcKErHwMLQKXlW6xdLfM1ooxsf9us+wocC7NElrL5PzTbGQfa5rWh4fGKF+kVqUeHepof0yQ
 e7bSQiY1ydVCNOAnEgFeeHQnFafzCN4vwweVw7nDNvxJJeUUZsrHCFh
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: dKBvbBK9B7IHzM2fRSj9SlRKzurh6O5M
X-Proofpoint-ORIG-GUID: dKBvbBK9B7IHzM2fRSj9SlRKzurh6O5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=746 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290115

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 122 +++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b581a7e80566..1d950a3e153b 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -10,6 +10,7 @@
  * - Alternative access techniques?
  */
 #include <linux/anon_inodes.h>
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/device.h>
@@ -533,28 +534,26 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	ret = kstrtobool(buf, &state);
 	if (ret < 0)
 		return ret;
-	mutex_lock(&iio_dev_opaque->mlock);
-	if (iio_buffer_is_active(buffer)) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
+
+	guard(mutex)(&iio_dev_opaque->mlock);
+	if (iio_buffer_is_active(buffer))
+		return -EBUSY;
+
 	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
 	if (ret < 0)
-		goto error_ret;
-	if (!state && ret) {
-		ret = iio_scan_mask_clear(buffer, this_attr->address);
-		if (ret)
-			goto error_ret;
-	} else if (state && !ret) {
+		return ret;
+
+	if (state && ret)
+		return len;
+
+	if (state)
 		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
-		if (ret)
-			goto error_ret;
-	}
+	else
+		ret = iio_scan_mask_clear(buffer, this_attr->address);
+	if (ret)
+		return ret;
 
-error_ret:
-	mutex_unlock(&iio_dev_opaque->mlock);
-
-	return ret < 0 ? ret : len;
+	return len;
 }
 
 static ssize_t iio_scan_el_ts_show(struct device *dev,
@@ -581,16 +580,13 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&iio_dev_opaque->mlock);
-	if (iio_buffer_is_active(buffer)) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-	buffer->scan_timestamp = state;
-error_ret:
-	mutex_unlock(&iio_dev_opaque->mlock);
+	guard(mutex)(&iio_dev_opaque->mlock);
+	if (iio_buffer_is_active(buffer))
+		return -EBUSY;
 
-	return ret ? ret : len;
+	buffer->scan_timestamp = state;
+
+	return len;
 }
 
 static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
@@ -674,21 +670,16 @@ static ssize_t length_store(struct device *dev, struct device_attribute *attr,
 	if (val == buffer->length)
 		return len;
 
-	mutex_lock(&iio_dev_opaque->mlock);
-	if (iio_buffer_is_active(buffer)) {
-		ret = -EBUSY;
-	} else {
-		buffer->access->set_length(buffer, val);
-		ret = 0;
-	}
-	if (ret)
-		goto out;
+	guard(mutex)(&iio_dev_opaque->mlock);
+	if (iio_buffer_is_active(buffer))
+		return -EBUSY;
+
+	buffer->access->set_length(buffer, val);
+
 	if (buffer->length && buffer->length < buffer->watermark)
 		buffer->watermark = buffer->length;
-out:
-	mutex_unlock(&iio_dev_opaque->mlock);
 
-	return ret ? ret : len;
+	return len;
 }
 
 static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
@@ -1268,7 +1259,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		       struct iio_buffer *remove_buffer)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	int ret;
 
 	if (insert_buffer == remove_buffer)
 		return 0;
@@ -1277,8 +1267,8 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 	    insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)
 		return -EINVAL;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	mutex_lock(&iio_dev_opaque->mlock);
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	guard(mutex)(&iio_dev_opaque->mlock);
 
 	if (insert_buffer && iio_buffer_is_active(insert_buffer))
 		insert_buffer = NULL;
@@ -1286,23 +1276,13 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 	if (remove_buffer && !iio_buffer_is_active(remove_buffer))
 		remove_buffer = NULL;
 
-	if (!insert_buffer && !remove_buffer) {
-		ret = 0;
-		goto out_unlock;
-	}
+	if (!insert_buffer && !remove_buffer)
+		return 0;
 
-	if (!indio_dev->info) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	if (!indio_dev->info)
+		return -ENODEV;
 
-	ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
-
-out_unlock:
-	mutex_unlock(&iio_dev_opaque->mlock);
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
 }
 EXPORT_SYMBOL_GPL(iio_update_buffers);
 
@@ -1326,22 +1306,22 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&iio_dev_opaque->mlock);
+	guard(mutex)(&iio_dev_opaque->mlock);
 
 	/* Find out if it is in the list */
 	inlist = iio_buffer_is_active(buffer);
 	/* Already in desired state */
 	if (inlist == requested_state)
-		goto done;
+		return len;
 
 	if (requested_state)
 		ret = __iio_update_buffers(indio_dev, buffer, NULL);
 	else
 		ret = __iio_update_buffers(indio_dev, NULL, buffer);
+	if (ret)
+		return ret;
 
-done:
-	mutex_unlock(&iio_dev_opaque->mlock);
-	return (ret < 0) ? ret : len;
+	return len;
 }
 
 static ssize_t watermark_show(struct device *dev, struct device_attribute *attr,
@@ -1368,23 +1348,17 @@ static ssize_t watermark_store(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&iio_dev_opaque->mlock);
+	guard(mutex)(&iio_dev_opaque->mlock);
 
-	if (val > buffer->length) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (val > buffer->length)
+		return -EINVAL;
 
-	if (iio_buffer_is_active(buffer)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (iio_buffer_is_active(buffer))
+		return -EBUSY;
 
 	buffer->watermark = val;
-out:
-	mutex_unlock(&iio_dev_opaque->mlock);
 
-	return ret ? ret : len;
+	return len;
 }
 
 static ssize_t data_available_show(struct device *dev,

-- 
2.44.0


