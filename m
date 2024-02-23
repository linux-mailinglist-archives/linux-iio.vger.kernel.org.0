Return-Path: <linux-iio+bounces-2936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08688611B7
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 13:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B2D1F27A8C
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA1D7E78A;
	Fri, 23 Feb 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wgUETCqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F67CF2E
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692050; cv=none; b=f7U1zzRuxXlqbZnO2LUetzjmue6HVOrBjRtgJnaqj9iNJSJOdn7v82usweyZlgktjOOI8fYZTieMSrtKtrfMOXG+7xrtQUiJtG+rnD3SwpXLSUJqTVQgPptnxa6/905QQqwTAmZivW320s/93Rd6rZkVEwtpfcOXerAwq29f1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692050; c=relaxed/simple;
	bh=F5qGd0ss6005QJk2CsOmL5exdWJFS+RlG4rHWdrRQ4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cNXZ4ndL+9fXBNPsi6Dh2iDz1Av+6vp2v/TDxU75Sc1DE4ytEl7zpdDp/Dj0k9wxlcBZiXp9hdTnHfJIQlhO4D5UBdshkreS4I/1WedpGRSPSaowyyQMcN7tYTUCbPZBGnysLUqO/Hb7Qq6wi6sKNcvq6rcmtD7dMaaKjcpyWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wgUETCqF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N9No1n014764;
	Fri, 23 Feb 2024 07:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=FmYonK+lnJ3Tyafpn6EMTPq6uKc+7+GSiDJQObD1dTk=; b=
	wgUETCqF6J4FqbBuv/XKK3Rn1Hjywi+ptwc5KlQ2xjJaOaFpI9UTN/m5cNflYMan
	Y+OmAndAnBGmUz+bkLu6J8LJhADC4vWBDUaQApaAzx79pRgs5j+h1meHU9Ufzyk1
	IftD5RnYwTQAePh84fLYAjCXJn7Tg3BtI+wzpCmqiokMzJ/A3DLDtyaC1eRE7R7Z
	6IE720heQsc8kXyZkPWKR9Rrd2U6cTo8ZihFwgdQwF+77iyRqH6da3ePbhHoYImi
	gg5UuLlPs0YwsTYDcJjX9jPiQe7fWf0VNt4Cn6tqRdrg4rFb9d9hn/FQiwJlQalQ
	riTMcpt9HKWb3RY179GPqQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21pefmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 07:40:35 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41NCeYlF005314
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 07:40:34 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 23 Feb
 2024 07:40:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 07:40:33 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NCeNLr000839;
	Fri, 23 Feb 2024 07:40:30 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 23 Feb 2024 13:43:47 +0100
Subject: [PATCH v2 4/5] iio: buffer: iio: core: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-iio-use-cleanup-magic-v2-4-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708692226; l=5744;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=F5qGd0ss6005QJk2CsOmL5exdWJFS+RlG4rHWdrRQ4Q=;
 b=PLfK0+H/HeE5BkBhLdVu/GcShuKVRrTiNmcMN/Gl1K3qKpcVGxIHzODwhfB7k1ktahTBI0Jzb
 B24uNMG8CwyAUx/+EqU7qmC1SrPi4wgJ+ELLEKXEgS5iLSzFTmLnUOi
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pw7OfVYHm9XY6psFHEwcgN_R0dDkU73w
X-Proofpoint-ORIG-GUID: pw7OfVYHm9XY6psFHEwcgN_R0dDkU73w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=744 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230091

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 105 ++++++++++++++------------------------
 1 file changed, 38 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b581a7e80566..ec6bc881cf13 100644
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
@@ -533,28 +534,25 @@ static ssize_t iio_scan_el_store(struct device *dev,
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
+		return ret;
 	if (!state && ret) {
 		ret = iio_scan_mask_clear(buffer, this_attr->address);
 		if (ret)
-			goto error_ret;
+			return ret;
 	} else if (state && !ret) {
 		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
 		if (ret)
-			goto error_ret;
+			return ret;
 	}
 
-error_ret:
-	mutex_unlock(&iio_dev_opaque->mlock);
-
-	return ret < 0 ? ret : len;
+	return len;
 }
 
 static ssize_t iio_scan_el_ts_show(struct device *dev,
@@ -581,16 +579,13 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
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
@@ -674,21 +669,16 @@ static ssize_t length_store(struct device *dev, struct device_attribute *attr,
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
@@ -1268,7 +1258,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		       struct iio_buffer *remove_buffer)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	int ret;
 
 	if (insert_buffer == remove_buffer)
 		return 0;
@@ -1277,8 +1266,8 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 	    insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)
 		return -EINVAL;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	mutex_lock(&iio_dev_opaque->mlock);
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	guard(mutex)(&iio_dev_opaque->mlock);
 
 	if (insert_buffer && iio_buffer_is_active(insert_buffer))
 		insert_buffer = NULL;
@@ -1286,23 +1275,13 @@ int iio_update_buffers(struct iio_dev *indio_dev,
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
 
@@ -1326,21 +1305,19 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
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
 
-done:
-	mutex_unlock(&iio_dev_opaque->mlock);
 	return (ret < 0) ? ret : len;
 }
 
@@ -1368,23 +1345,17 @@ static ssize_t watermark_store(struct device *dev,
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
2.43.2


