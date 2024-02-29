Return-Path: <linux-iio+bounces-3221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F182E86CC5F
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582F3B25AE8
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAC81384BB;
	Thu, 29 Feb 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MZu8xUzf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE286275
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219261; cv=none; b=IPGt1RSieeeL32Y2yPHz4QilClV6iFcyGD7Lccud0O8+HouZSFoMvgP8rx1QRyY+dltu3I4BYZjYDvKnxzMBaearfbRpEZwp8KbApxUNP6xGDOKJUaoUz5Xi62DLRChXAh4Z/hktYnL7SfoJ1IOGxg4to0+GcUli1jDKPeECB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219261; c=relaxed/simple;
	bh=KpXJNxoGIddQpDJe5dpbHlAcBk6pr4U9YfhXAQ3qU5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tHfcu6nURUhqkzKDNgSYUiYi5ZCNoLSiXvvJN2D4KbrDu2Cf4keNiVqwysO/GImcvtLw79A4QIHSFbIdX5V2At/prHK6JHf10UWzlimVDQ8aPnEQDEkEbe5vDXFLSvNHN4ptjl+Q4y21Mkg930jwDrg45OGjGa6nBfBzfMtXvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MZu8xUzf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TECxjY007932;
	Thu, 29 Feb 2024 10:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=e+NiLelCm3HQz2pJGLc3OF6TxbuYvneYlP5StwzdYgE=; b=
	MZu8xUzfyhixfDUmbfYucSyu/nz8R0B/Y0nYn4pi9OMfZXB7qAI44cDNdKI/2OOK
	ijeFpJoDIoTlfKMOBSgmN3zNHm0ngGhQElkE8cGDcZoZtjXstX6WPAsqtnr8okNa
	g++RO6mzw/0yYNSWm236BiprLNeRLNFrUObPhuakj5mLI0CWBr4vLhBwG9VfsyK8
	ILeHJluXrKKrpxgaWwcfn/PG2Tbeuef+qIBHndreFgbJljjwls5PQRrgbf76Xpz9
	MTQTQRVCqrNpLCPNwVghLIpqK1HCwrUcHu0KrBB1qB/9aMcwnbf2BtL0m4b14G5v
	3hI5ofEv3RViV7vaysOwUg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wjcr2ujan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:07:14 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TF7CwS023034
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 10:07:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 29 Feb
 2024 10:07:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 10:07:11 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TF73tk015938;
	Thu, 29 Feb 2024 10:07:09 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 16:10:26 +0100
Subject: [PATCH v3 2/4] iio: trigger: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709219428; l=4787;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KpXJNxoGIddQpDJe5dpbHlAcBk6pr4U9YfhXAQ3qU5Y=;
 b=ow75LzjTnwvIs9RyRbQSxpXHoS23WujwWf8QM1+fctVrsDGK+Ru9q5AEmBXzfL833sHZ8yrBM
 xKrGna6WUgcA7EyI6bt8MqYfxWlw0HC/HrI/GQmi3qlB8M+vaX9OiNm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Rj66mnSUjR3xXu2GQWiPWEN7-wTEt4Fy
X-Proofpoint-ORIG-GUID: Rj66mnSUjR3xXu2GQWiPWEN7-wTEt4Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290115

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-trigger.c | 71 ++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 18f83158f637..16de57846bd9 100644
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
+			ret = -EEXIST;
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
@@ -259,22 +253,21 @@ static int iio_trigger_get_irq(struct iio_trigger *trig)
 {
 	int ret;
 
-	mutex_lock(&trig->pool_lock);
-	ret = bitmap_find_free_region(trig->pool,
-				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
-				      ilog2(1));
-	mutex_unlock(&trig->pool_lock);
-	if (ret >= 0)
-		ret += trig->subirq_base;
+	scoped_guard(mutex, &trig->pool_lock) {
+		ret = bitmap_find_free_region(trig->pool,
+					      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
+					      ilog2(1));
+		if (ret < 0)
+			return ret;
+	}
 
-	return ret;
+	return ret + trig->subirq_base;
 }
 
 static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 {
-	mutex_lock(&trig->pool_lock);
+	guard(mutex)(&trig->pool_lock);
 	clear_bit(irq - trig->subirq_base, trig->pool);
-	mutex_unlock(&trig->pool_lock);
 }
 
 /* Complexity in here.  With certain triggers (datardy) an acknowledgement
@@ -451,16 +444,12 @@ static ssize_t current_trigger_store(struct device *dev,
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
2.44.0


