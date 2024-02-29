Return-Path: <linux-iio+bounces-3224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46986CC5E
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A9C283BF8
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374F86275;
	Thu, 29 Feb 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="y2u7xN5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE96137778
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219262; cv=none; b=qtl+Lp/s6aiVGVkKkgasIT0XV7NgknGxTyv7P1MaojSh6VN0Jy48J2p5maAy216uep7RjtD1N3DYDRtNJmqVYbX7z1TVMZMMWKk8/X35eBH08Y4CxCF9aej8LUeRaHSEkoMTRXD5RFDerZxp/KlRHpnt0XZ+ae2PPHyMJWgpUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219262; c=relaxed/simple;
	bh=3pT2neXWJaDgnK0R+OXDeerc8butxu8ZO+dlOXYeKIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t0DTKoM9tTh8MQ+KkPaHoRtqde0cqf/57hA4LPxm4JK5nC4gcc2VpQRxM1BstKirxytd2yziRQg+PliWPl/uQrnGfSxH1l3WSCdjfd66e3r8Foqgyv01EK8rPIVPA2eWfZ9HBXc0zOWXdpg3RDwibyI6vEhlxbsEeXmThngczQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=y2u7xN5h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TE6q0O006807;
	Thu, 29 Feb 2024 10:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=WYtf8rdeoTOAnvbovsngVM8yy8r6AIc0NlUbU8F7F4s=; b=
	y2u7xN5hcGdzbdssgZcw+JbSpAo34zSp3/AyZ+L+rM7NTZU5kj3tfUm4lWVx77HY
	5sv+hK7NRAsp2Hcqrip0NBflJdQcaJr31N3GO6rn3Wv/6/Y/woPHFkwaBS03fROP
	rd3kaEGYBQTy+lOvHvYw0pE4NBTvpE5S+ooB035CJIBu8kZ43TUQX10DqcaMNg3j
	TuIQAGHJw6n2A65o4Qt4Unng4CcQGO9AAzWUdPPs4hgQDLLjia6fjLj2Vsf51WzQ
	qf54hmJzzwwYsA0US3TGLhunORS7dJDNOop/J/+slaOoJQhRVXodphqUvrXfNd38
	3e1q18mzc+zRJvXncBLsxg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3wjp9qhday-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:07:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TF7EMu023043
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 10:07:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 29 Feb
 2024 10:07:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 10:07:13 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TF73tj015938;
	Thu, 29 Feb 2024 10:07:08 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 16:10:25 +0100
Subject: [PATCH v3 1/4] iio: core: move to cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-iio-use-cleanup-magic-v3-1-c3d34889ae3c@analog.com>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709219428; l=2738;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3pT2neXWJaDgnK0R+OXDeerc8butxu8ZO+dlOXYeKIc=;
 b=Gqs8q8OyEfl0Wjcg0PTEBYBJr7zd1R33aKJfFz2/kuxbFfXElUZdJVImPLVaWGNcrgSVawXHk
 lXrpkUsq2HiCdefMQ6Idd+AxzSSmLOkMlDjggrcVLxvSoUWtxL7Gcg7
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: R9OIdmZTXgdB4e9LkDgN63qE3Wq_7aBr
X-Proofpoint-ORIG-GUID: R9OIdmZTXgdB4e9LkDgN63qE3Wq_7aBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=655 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290115

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Note that we keep the plain mutex calls in the
iio_device_release|acquire() APIs since in there the macros would likely
not help much (as we want to keep the lock acquired when he leave the
APIs).

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9b2877fe8689..e80a8065b7b9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -11,6 +11,7 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -1806,31 +1807,24 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct iio_dev *indio_dev = ib->indio_dev;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_ioctl_handler *h;
-	int ret = -ENODEV;
-
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
+	int ret;
 
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
 	/*
 	 * The NULL check here is required to prevent crashing when a device
 	 * is being removed while userspace would still have open file handles
 	 * to try to access this device.
 	 */
 	if (!indio_dev->info)
-		goto out_unlock;
+		return -ENODEV;
 
 	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
 		ret = h->ioctl(indio_dev, filp, cmd, arg);
 		if (ret != IIO_IOCTL_UNHANDLED)
-			break;
+			return ret;
 	}
 
-	if (ret == IIO_IOCTL_UNHANDLED)
-		ret = -ENODEV;
-
-out_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return -ENODEV;
 }
 
 static const struct file_operations iio_buffer_fileops = {
@@ -2058,18 +2052,16 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
+	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
+		iio_device_unregister_debugfs(indio_dev);
 
-	iio_device_unregister_debugfs(indio_dev);
+		iio_disable_all_buffers(indio_dev);
 
-	iio_disable_all_buffers(indio_dev);
+		indio_dev->info = NULL;
 
-	indio_dev->info = NULL;
-
-	iio_device_wakeup_eventset(indio_dev);
-	iio_buffer_wakeup_poll(indio_dev);
-
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
+		iio_device_wakeup_eventset(indio_dev);
+		iio_buffer_wakeup_poll(indio_dev);
+	}
 
 	iio_buffers_free_sysfs_and_mask(indio_dev);
 }

-- 
2.44.0


