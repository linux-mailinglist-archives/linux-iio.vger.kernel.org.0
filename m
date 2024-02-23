Return-Path: <linux-iio+bounces-2934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDC8611B4
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 13:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A461F27A19
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B137D418;
	Fri, 23 Feb 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SOj82SJV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109B14A97
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692049; cv=none; b=HOvTESYujf74oipBOnEWxAe/fo622aRSeV43oijoSPchUPng3S0ubDoJTGTCJVr3JqPR9li3wBR3oN79cHCifOzL/HRVIX2JtyJDSiyaldydnkV8KD9qXaBqJaYKtOmr2HD27anmWbFYIWrGUiGIDoG1Nr8X3PDZV5CHkpwoCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692049; c=relaxed/simple;
	bh=7bWocc/cBH3da0IiWDt4z9hAUz+zgnZIPTh8xDiX4IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Pz//pLL3mnOqPbq5C4u/rT16+kMmvcHZ6DwBAcqYLMWW0ST5z3lXgcP7VnTPRn3KVUZdmaReShhjdlBbiRJb6GTBikbEpZpzMR1TyYwNMFbBEv7q0DJwUU4vPgPQHBv+dcIqk6Abm+KUzraIztCgHTion1+wi0ZmjvBdfZY4Kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SOj82SJV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N9EMEo014756;
	Fri, 23 Feb 2024 07:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=noBV0nWBOV9LdCt/ADzguJPlwgFp7aXLnofspq7KXw4=; b=
	SOj82SJVLoabg11LGICjmiDKuhNEKuHccDBCHHm0eFN9EnYQVShisbhK0Z38Bkva
	M+6ZraRci2q5x8ljyLvgmnn60ELR+RaD13l2HZs8XQGXYeEy1lk6omhfCmYcRjqc
	56fjgA4YeQN2gTFaUwHmiqro0X8AT32kHLmNeIFaXZS+eqjp734Ls9vx5wvYiPpg
	KbhJF0BnuXgSnocgCJFHvn8CjvLrOHHDvdpEBwj1UCwp46VAJ/ZvN7LzxgYUUUKN
	4Hwzbt9dZSSDFwErwSsfFVv0L734evQllJPktK3TUphOyIuWMbZPIAqTsmkI7zwD
	fklfh9fNwHN5n3jdd94EMA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21pefma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 07:40:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41NCeW8c005308
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 07:40:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 23 Feb
 2024 07:40:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 07:40:31 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NCeNLo000839;
	Fri, 23 Feb 2024 07:40:28 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 23 Feb 2024 13:43:44 +0100
Subject: [PATCH v2 1/5] iio: core: move to cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-iio-use-cleanup-magic-v2-1-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708692225; l=3488;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7bWocc/cBH3da0IiWDt4z9hAUz+zgnZIPTh8xDiX4IA=;
 b=yKAsqgUldoaf5jS0kF3zs7z5hWAgqPKqxf9g3s6xko6X9caaDQQsZIguLAk6c78JIkqbx96pp
 pBvoJUQwIAZAC8f4Bzb4YRMIPlgJzXmQdFmsI12piThu15di+HFUCwm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: TuJh6M5jQe6naJC2syz2d0yylpHVE0VL
X-Proofpoint-ORIG-GUID: TuJh6M5jQe6naJC2syz2d0yylpHVE0VL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=708 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230091

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Note that we keep the plain mutex calls in the
iio_device_release|acquire() APIs since in there the macros would likely
not help much (as we want to keep the lock acquired when he leave the
APIs).

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 48 ++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9b2877fe8689..17cc3e579d56 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -11,6 +11,7 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -268,20 +269,16 @@ EXPORT_SYMBOL(iio_read_const_attr);
  */
 int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 {
-	int ret;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	const struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
 
-	ret = mutex_lock_interruptible(&iio_dev_opaque->mlock);
-	if (ret)
-		return ret;
-	if ((ev_int && iio_event_enabled(ev_int)) ||
-	    iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&iio_dev_opaque->mlock);
-		return -EBUSY;
+	scoped_cond_guard(mutex_intr, return -EINTR, &iio_dev_opaque->mlock) {
+		if ((ev_int && iio_event_enabled(ev_int)) ||
+		    iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		iio_dev_opaque->clock_id = clock_id;
 	}
-	iio_dev_opaque->clock_id = clock_id;
-	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return 0;
 }
@@ -1808,29 +1805,22 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct iio_ioctl_handler *h;
 	int ret = -ENODEV;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
 	/*
 	 * The NULL check here is required to prevent crashing when a device
 	 * is being removed while userspace would still have open file handles
 	 * to try to access this device.
 	 */
 	if (!indio_dev->info)
-		goto out_unlock;
+		return ret;
 
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
@@ -2058,18 +2048,16 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
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
2.43.2


