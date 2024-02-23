Return-Path: <linux-iio+bounces-2935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101EE8611B6
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 13:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900091F2796D
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2E7E788;
	Fri, 23 Feb 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lx+XK5lW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BB7CF2D
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692050; cv=none; b=sqnATGW/1gKeJFQ0Ltd5EWWa/PDK3uobdIOVQTkP5VJ7pne09HMCI70DsIaR/EbccJVk02ALh6DByGsiElKRUpPDeFPua2ROwN4pWDvQuFTpJtZ18FJs8WChLA6dFA/TPW1l759nuRSVMrhWcuBD184k00ACL/k+pSIf5Hi7LYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692050; c=relaxed/simple;
	bh=vHv8I8vPQnnQ0Gpp40q2sa6mpIinoMJchTaucfGRBbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sLtlJW3cgDr+3uG8kDEJH/LX+sO5qlX7X4ZVRIkophUPKG4HpWsTWDLmyc0CvG7hYIlFOvk2qkM/AAJWHkO6bmoGGSq3+ntcKas5GLABjoDDTCu8/YkYIQ3J1QU1qAweBtZ3rUl/poQ9sa07hZV4dMxjeRwM2Hl6s7k+C1WAa1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lx+XK5lW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NAR7Wj014873;
	Fri, 23 Feb 2024 07:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=WF2lgOboUf1709ej2XqxZAXszk8xSJSPLnfwbcQgYrE=; b=
	lx+XK5lWRs4+ZspcdRDryBlS3bnfGgs1QfQgV0LoFctpbR5St1/425wYvnssPFUu
	pwszKXv3cTXWoK+Z3XPsE9zvw3T9GpdzJSGwe/Ib9M2GdFwRDuOELmbsm6ddMKMg
	NmV/d1xxWcR6tSkW9vBj4E8j1T9ItNlFDE1tNbwvt2vKYbMxGnMZCNHq8Lh6NKC6
	MRnWpCtikSFAXwsnSH2uM4JWG42jQIlfdM9B9t1ALP2CIcdpbrP79sjBQa1W540B
	tcRxAVGZ9VVwJAOIBw+YGRXDQDRfy2sgBkd2dd9Ri/lOnCo59juOPl2S25lZrMEy
	vtRisqdOvScJdx7W6Piymw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21pefmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 07:40:36 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41NCeZm9005317
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 07:40:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 23 Feb
 2024 07:40:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 07:40:34 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NCeNLp000839;
	Fri, 23 Feb 2024 07:40:29 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 23 Feb 2024 13:43:45 +0100
Subject: [PATCH v2 2/5] iio: events: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-iio-use-cleanup-magic-v2-2-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708692225; l=2320;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vHv8I8vPQnnQ0Gpp40q2sa6mpIinoMJchTaucfGRBbI=;
 b=kOpOgCTMdIj/9hYVuaG84+3TZirBBCkBxQxXmK1Q8crBh/O8olZLoAPbNhC1UiVzzZlN3MbeK
 hTAEtnuiAK0BdYGaxzwPFB9D8gXZ8f7ibxx1IAJKKfFhk/xoNMbl7mk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5gDOedJ1UzXIadAwDVg9vmr-8It7tN7a
X-Proofpoint-ORIG-GUID: 5gDOedJ1UzXIadAwDVg9vmr-8It7tN7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=726 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230091

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-event.c | 42 +++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 910c1f14abd5..ef3cecbce915 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -146,11 +147,10 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 				return -ENODEV;
 		}
 
-		if (mutex_lock_interruptible(&ev_int->read_lock))
-			return -ERESTARTSYS;
-		ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
-		mutex_unlock(&ev_int->read_lock);
-
+		scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
+				  &ev_int->read_lock)
+			ret = kfifo_to_user(&ev_int->det_events, buf, count,
+					    &copied);
 		if (ret)
 			return ret;
 
@@ -198,28 +198,22 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 	if (ev_int == NULL)
 		return -ENODEV;
 
-	fd = mutex_lock_interruptible(&iio_dev_opaque->mlock);
-	if (fd)
-		return fd;
+	scoped_cond_guard(mutex_intr, return -EINTR, &iio_dev_opaque->mlock) {
+		if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags))
+			return -EBUSY;
 
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
-		fd = -EBUSY;
-		goto unlock;
+		iio_device_get(indio_dev);
+
+		fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
+				      indio_dev, O_RDONLY | O_CLOEXEC);
+		if (fd < 0) {
+			clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+			iio_device_put(indio_dev);
+		} else {
+			kfifo_reset_out(&ev_int->det_events);
+		}
 	}
 
-	iio_device_get(indio_dev);
-
-	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
-				indio_dev, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
-		iio_device_put(indio_dev);
-	} else {
-		kfifo_reset_out(&ev_int->det_events);
-	}
-
-unlock:
-	mutex_unlock(&iio_dev_opaque->mlock);
 	return fd;
 }
 

-- 
2.43.2


