Return-Path: <linux-iio+bounces-2937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7928611B8
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 13:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CB51F27AE9
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C77D417;
	Fri, 23 Feb 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uRn0Il+z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8014A97
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692051; cv=none; b=enaGF1kJMqk0ZNpgC7BwJDWvwwaksJVq1C4je4PGL7oM+4/d3pdrA0vLRcnVWlHDrdalPfXt1h70kJK6GOjuzk4KtHWjJgQxAPEi6ECbxM5qyZMRRCKAWA91RnFTQ3X+3HRMmIq+LlmmZVabCR4eXzNlZCqcrd+y756cBILQP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692051; c=relaxed/simple;
	bh=QmgYGthuEqmr2B4sVv7vB9o1+nU0CxkUHgGMqwOLki0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h8YAdlCRfPudvQpiY/KKxYygxkAx/s2Gy1nIWoyJo/kqgo/X7OuJlFx2Dz3CFw11nQPJkpvra/SJkFwnAVOPF8xeJDIRvxBTcIgQ57cmAYVgkRFYelo5tJTYtWHQr4Kaw+NbXgTY1YB00tdEcaTK8XizPOwcp26iKfa9unbf5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uRn0Il+z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NC2Win001590;
	Fri, 23 Feb 2024 07:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=gHkh8mMhzksWa9QKEra9nETsROLjS1H+xzsSF+r+1QI=; b=
	uRn0Il+z2uQ8GzwrklAX9jATNmUaIg8BnU2+HkkkQvcpLldqlKOiYsPJcOSTnENV
	U6v5m2LOAyYZdYoO2UOWMnsctDE7Ec8DZBBbzGC2s7gatRGGFZsk/ZRuoJOf+J2m
	UgSQ4++wmKSh+hFurcexPDzbx2S0TYqewGBkKtIPtDib9bz1FA+tCoeNOFgDUM8w
	5xMn3syNJ6gEJV0ZxjMxsJqEB0iULvwKWqKoDZZRYEx4+Tj1iwa+NkTwg9zf55tb
	9n9z23elLbLwlNPTfItOvLHkhCAFLGBQ4OpcpAw0jglI5ziVHskUyqJFu1OowdZd
	clJE0oypnWqdWknnRzkseQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wep5mh723-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 07:40:34 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41NCeX1M005311
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 07:40:33 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 23 Feb
 2024 07:40:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 07:40:32 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NCeNLq000839;
	Fri, 23 Feb 2024 07:40:30 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 23 Feb 2024 13:43:46 +0100
Subject: [PATCH v2 3/5] iio: trigger: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-iio-use-cleanup-magic-v2-3-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708692226; l=4771;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=QmgYGthuEqmr2B4sVv7vB9o1+nU0CxkUHgGMqwOLki0=;
 b=JNlwLXTM4sLJSQsem9HZVvlxFVDFOmci5ApD1S4mTjklvk8xXz5Agmed+9Uyd5bxYuqd08oq0
 5koouclDGqoAAoN4POTJhMjxwFTFJ6XxAMedfmhg0xk72FpJRji55Sk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rE4Mhquop9487Exl72rAGnyPNa0PJ9bT
X-Proofpoint-GUID: rE4Mhquop9487Exl72rAGnyPNa0PJ9bT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230091

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-trigger.c | 64 ++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 18f83158f637..e4f0802fdd1d 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2008 Jonathan Cameron
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -80,19 +81,18 @@ int iio_trigger_register(struct iio_trigger *trig_info)
 		goto error_unregister_id;
 
 	/* Add to list of available triggers held by the IIO core */
-	mutex_lock(&iio_trigger_list_lock);
-	if (__iio_trigger_find_by_name(trig_info->name)) {
-		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
-		ret = -EEXIST;
-		goto error_device_del;
+	scoped_guard(mutex, &iio_trigger_list_lock) {
+		if (__iio_trigger_find_by_name(trig_info->name)) {
+			pr_err("Duplicate trigger name '%s'\n", trig_info->name);
+			ret =  -EEXIST;
+			goto error_device_del;
+		}
+		list_add_tail(&trig_info->list, &iio_trigger_list);
 	}
-	list_add_tail(&trig_info->list, &iio_trigger_list);
-	mutex_unlock(&iio_trigger_list_lock);
 
 	return 0;
 
 error_device_del:
-	mutex_unlock(&iio_trigger_list_lock);
 	device_del(&trig_info->dev);
 error_unregister_id:
 	ida_free(&iio_trigger_ida, trig_info->id);
@@ -102,9 +102,8 @@ EXPORT_SYMBOL(iio_trigger_register);
 
 void iio_trigger_unregister(struct iio_trigger *trig_info)
 {
-	mutex_lock(&iio_trigger_list_lock);
-	list_del(&trig_info->list);
-	mutex_unlock(&iio_trigger_list_lock);
+	scoped_guard(mutex, &iio_trigger_list_lock)
+		list_del(&trig_info->list);
 
 	ida_free(&iio_trigger_ida, trig_info->id);
 	/* Possible issue in here */
@@ -120,12 +119,11 @@ int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *tri
 		return -EINVAL;
 
 	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	mutex_lock(&iio_dev_opaque->mlock);
+	guard(mutex)(&iio_dev_opaque->mlock);
 	WARN_ON(iio_dev_opaque->trig_readonly);
 
 	indio_dev->trig = iio_trigger_get(trig);
 	iio_dev_opaque->trig_readonly = true;
-	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return 0;
 }
@@ -145,18 +143,14 @@ static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
 
 static struct iio_trigger *iio_trigger_acquire_by_name(const char *name)
 {
-	struct iio_trigger *trig = NULL, *iter;
+	struct iio_trigger *iter;
 
-	mutex_lock(&iio_trigger_list_lock);
+	guard(mutex)(&iio_trigger_list_lock);
 	list_for_each_entry(iter, &iio_trigger_list, list)
-		if (sysfs_streq(iter->name, name)) {
-			trig = iter;
-			iio_trigger_get(trig);
-			break;
-		}
-	mutex_unlock(&iio_trigger_list_lock);
+		if (sysfs_streq(iter->name, name))
+			return iio_trigger_get(iter);
 
-	return trig;
+	return NULL;
 }
 
 static void iio_reenable_work_fn(struct work_struct *work)
@@ -259,11 +253,10 @@ static int iio_trigger_get_irq(struct iio_trigger *trig)
 {
 	int ret;
 
-	mutex_lock(&trig->pool_lock);
-	ret = bitmap_find_free_region(trig->pool,
-				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
-				      ilog2(1));
-	mutex_unlock(&trig->pool_lock);
+	scoped_guard(mutex, &trig->pool_lock)
+		ret = bitmap_find_free_region(trig->pool,
+					      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
+					      ilog2(1));
 	if (ret >= 0)
 		ret += trig->subirq_base;
 
@@ -272,9 +265,8 @@ static int iio_trigger_get_irq(struct iio_trigger *trig)
 
 static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 {
-	mutex_lock(&trig->pool_lock);
+	guard(mutex)(&trig->pool_lock);
 	clear_bit(irq - trig->subirq_base, trig->pool);
-	mutex_unlock(&trig->pool_lock);
 }
 
 /* Complexity in here.  With certain triggers (datardy) an acknowledgement
@@ -451,16 +443,12 @@ static ssize_t current_trigger_store(struct device *dev,
 	struct iio_trigger *trig;
 	int ret;
 
-	mutex_lock(&iio_dev_opaque->mlock);
-	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
-		mutex_unlock(&iio_dev_opaque->mlock);
-		return -EBUSY;
+	scoped_guard(mutex, &iio_dev_opaque->mlock) {
+		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
+			return -EBUSY;
+		if (iio_dev_opaque->trig_readonly)
+			return -EPERM;
 	}
-	if (iio_dev_opaque->trig_readonly) {
-		mutex_unlock(&iio_dev_opaque->mlock);
-		return -EPERM;
-	}
-	mutex_unlock(&iio_dev_opaque->mlock);
 
 	trig = iio_trigger_acquire_by_name(buf);
 	if (oldtrig == trig) {

-- 
2.43.2


