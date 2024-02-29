Return-Path: <linux-iio+bounces-3225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D147D86CC60
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30189B25AE6
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153B137778;
	Thu, 29 Feb 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pTjrAGaQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3B137756
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219264; cv=none; b=CUp7Zvi/6DjmheMWdET60Ym1eBQxl4N/2vZdhFNdp/dbKkh8fpM9aPFgqdfPF7F2AMa6TNGDtHe6gT592+hIKxsJoI0HKrSzpd1H8YwAxmH5JmSgctGhsXTnYcYZEfRU8G4zk48dG2x3KPDgwTMee6ozsfGt7OdS9evsNdP0PKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219264; c=relaxed/simple;
	bh=ys2e8UB1uISFkHtOpOe+oOYxHwvjzH2l7JPR9wPRA4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mDF4RAfTo1oGFOjRFMcYWNTcFvKd2CV0kME+ATCgkqcPqRnx8dY3gZCzcxtHLWWlz78QmpnxPDYfnV27UYcl9xiwPKLgdNP3DF0nPDQXjoajqVx8w2zuBOiZbPdYEzxTnqoKSnjvjRrPvG6ztqBVWHZyMwwNRAl4MWxdxS3sWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pTjrAGaQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TE4RZQ006976;
	Thu, 29 Feb 2024 10:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=6X+srRayMHumkkBlHkePfD/0SKNxeRm6eKqY2d+MW+4=; b=
	pTjrAGaQl/AOPFRNIkQ77W2G8rIzP0OwlrMdXZUGN26hJII5xiuyubLYukTvo2Av
	dE2JXPVbPrewwgjGGMDp5oZcUW4Vsy3OrRepM4qw4x+ZWByLln9UY0ySRIh1nRII
	rPwig5plLl24Z9/fKObgAIf4HAAn0czKv0+RJn2DAfSXYZebiHLmZ9iLqwY1vXNI
	5S0W5qu4TXTY9g7eTo/UYDwjMgS3oP/n9DN4HJmQl5uvKCJiKjwEnp7xwZf4Y8i7
	cTUOj5ujbUBXMcrYP61BsC6yO+sop+5H7qVJ5y/BgcZ51Z76DG/qNN9CWSpv6N8w
	GakrvVWK3Ww7jfaRH0yPEQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3wjp9qhdb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:07:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TF7Gcw023046
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 10:07:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 29 Feb
 2024 10:07:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 10:07:15 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TF73tm015938;
	Thu, 29 Feb 2024 10:07:10 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 16:10:28 +0100
Subject: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709219428; l=15290;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ys2e8UB1uISFkHtOpOe+oOYxHwvjzH2l7JPR9wPRA4s=;
 b=b2rengPGEVbAmDsAKC1w90dYb2yw/j5Qp4FTr0aVm3jzTDYwOSPJubkP68BrFsXERar1YzlWx
 vfXhW+aTFzCCM1iRDtDfLZgIolprut2snWjILEmr7k6w51qs2n+wkSt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yDlkQNh6yvTJk2JEHASPSGUe78CThfK8
X-Proofpoint-ORIG-GUID: yDlkQNh6yvTJk2JEHASPSGUe78CThfK8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=722 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290115

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

While at it, also use __free(kfree) where allocations are done and drop
obvious comment in iio_channel_read_min().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/inkern.c | 255 +++++++++++++++++----------------------------------
 1 file changed, 85 insertions(+), 170 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7a1f6713318a..6017f294ac1c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2011 Jonathan Cameron
  */
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/minmax.h>
@@ -43,13 +44,13 @@ static int iio_map_array_unregister_locked(struct iio_dev *indio_dev)
 
 int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 {
-	int i = 0, ret = 0;
+	int i = 0, ret;
 	struct iio_map_internal *mapi;
 
 	if (!maps)
 		return 0;
 
-	mutex_lock(&iio_map_list_lock);
+	guard(mutex)(&iio_map_list_lock);
 	while (maps[i].consumer_dev_name) {
 		mapi = kzalloc(sizeof(*mapi), GFP_KERNEL);
 		if (!mapi) {
@@ -61,11 +62,10 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 		list_add_tail(&mapi->l, &iio_map_list);
 		i++;
 	}
-error_ret:
-	if (ret)
-		iio_map_array_unregister_locked(indio_dev);
-	mutex_unlock(&iio_map_list_lock);
 
+	return 0;
+error_ret:
+	iio_map_array_unregister_locked(indio_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_map_array_register);
@@ -75,13 +75,8 @@ EXPORT_SYMBOL_GPL(iio_map_array_register);
  */
 int iio_map_array_unregister(struct iio_dev *indio_dev)
 {
-	int ret;
-
-	mutex_lock(&iio_map_list_lock);
-	ret = iio_map_array_unregister_locked(indio_dev);
-	mutex_unlock(&iio_map_list_lock);
-
-	return ret;
+	guard(mutex)(&iio_map_list_lock);
+	return iio_map_array_unregister_locked(indio_dev);
 }
 EXPORT_SYMBOL_GPL(iio_map_array_unregister);
 
@@ -183,25 +178,21 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 static struct iio_channel *fwnode_iio_channel_get(struct fwnode_handle *fwnode,
 						  int index)
 {
-	struct iio_channel *channel;
 	int err;
 
 	if (index < 0)
 		return ERR_PTR(-EINVAL);
 
-	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
+	struct iio_channel *channel __free(kfree) = kzalloc(sizeof(*channel),
+							    GFP_KERNEL);
 	if (!channel)
 		return ERR_PTR(-ENOMEM);
 
 	err = __fwnode_iio_channel_get(channel, fwnode, index);
 	if (err)
-		goto err_free_channel;
+		return ERR_PTR(err);
 
-	return channel;
-
-err_free_channel:
-	kfree(channel);
-	return ERR_PTR(err);
+	return_ptr(channel);
 }
 
 static struct iio_channel *
@@ -291,7 +282,6 @@ EXPORT_SYMBOL_GPL(fwnode_iio_channel_get_by_name);
 static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct iio_channel *chans;
 	int i, mapind, nummaps = 0;
 	int ret;
 
@@ -307,7 +297,9 @@ static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 		return ERR_PTR(-ENODEV);
 
 	/* NULL terminated array to save passing size */
-	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
+	struct iio_channel *chans __free(kfree) = kcalloc(nummaps + 1,
+							  sizeof(*chans),
+							  GFP_KERNEL);
 	if (!chans)
 		return ERR_PTR(-ENOMEM);
 
@@ -317,12 +309,11 @@ static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 		if (ret)
 			goto error_free_chans;
 	}
-	return chans;
+	return_ptr(chans);
 
 error_free_chans:
 	for (i = 0; i < mapind; i++)
 		iio_device_put(chans[i].indio_dev);
-	kfree(chans);
 	return ERR_PTR(ret);
 }
 
@@ -330,28 +321,28 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
 					       const char *channel_name)
 {
 	struct iio_map_internal *c_i = NULL, *c = NULL;
-	struct iio_channel *channel;
 	int err;
 
 	if (!(name || channel_name))
 		return ERR_PTR(-ENODEV);
 
 	/* first find matching entry the channel map */
-	mutex_lock(&iio_map_list_lock);
-	list_for_each_entry(c_i, &iio_map_list, l) {
-		if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
-		    (channel_name &&
-		     strcmp(channel_name, c_i->map->consumer_channel) != 0))
-			continue;
-		c = c_i;
-		iio_device_get(c->indio_dev);
-		break;
+	scoped_guard(mutex, &iio_map_list_lock) {
+		list_for_each_entry(c_i, &iio_map_list, l) {
+			if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
+			    (channel_name &&
+			     strcmp(channel_name, c_i->map->consumer_channel) != 0))
+				continue;
+			c = c_i;
+			iio_device_get(c->indio_dev);
+			break;
+		}
 	}
-	mutex_unlock(&iio_map_list_lock);
 	if (!c)
 		return ERR_PTR(-ENODEV);
 
-	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
+	struct iio_channel *channel __free(kfree) = kzalloc(sizeof(*channel),
+							    GFP_KERNEL);
 	if (!channel) {
 		err = -ENOMEM;
 		goto error_no_mem;
@@ -366,14 +357,12 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
 
 		if (!channel->channel) {
 			err = -EINVAL;
-			goto error_no_chan;
+			goto error_no_mem;
 		}
 	}
 
-	return channel;
+	return_ptr(channel);
 
-error_no_chan:
-	kfree(channel);
 error_no_mem:
 	iio_device_put(c->indio_dev);
 	return ERR_PTR(err);
@@ -450,7 +439,7 @@ EXPORT_SYMBOL_GPL(devm_fwnode_iio_channel_get_by_name);
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
 	const char *name;
-	struct iio_channel *chans;
+	struct iio_channel *fw_chans;
 	struct iio_map_internal *c = NULL;
 	int nummaps = 0;
 	int mapind = 0;
@@ -459,17 +448,17 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	if (!dev)
 		return ERR_PTR(-EINVAL);
 
-	chans = fwnode_iio_channel_get_all(dev);
+	fw_chans = fwnode_iio_channel_get_all(dev);
 	/*
 	 * We only want to carry on if the error is -ENODEV.  Anything else
 	 * should be reported up the stack.
 	 */
-	if (!IS_ERR(chans) || PTR_ERR(chans) != -ENODEV)
-		return chans;
+	if (!IS_ERR(fw_chans) || PTR_ERR(fw_chans) != -ENODEV)
+		return fw_chans;
 
 	name = dev_name(dev);
 
-	mutex_lock(&iio_map_list_lock);
+	guard(mutex)(&iio_map_list_lock);
 	/* first count the matching maps */
 	list_for_each_entry(c, &iio_map_list, l)
 		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
@@ -477,17 +466,15 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		else
 			nummaps++;
 
-	if (nummaps == 0) {
-		ret = -ENODEV;
-		goto error_ret;
-	}
+	if (nummaps == 0)
+		return ERR_PTR(-ENODEV);
 
 	/* NULL terminated array to save passing size */
-	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
-	if (!chans) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	struct iio_channel *chans __free(kfree) = kcalloc(nummaps + 1,
+							  sizeof(*chans),
+							  GFP_KERNEL);
+	if (!chans)
+		return ERR_PTR(-ENOMEM);
 
 	/* for each map fill in the chans element */
 	list_for_each_entry(c, &iio_map_list, l) {
@@ -509,17 +496,12 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		ret = -ENODEV;
 		goto error_free_chans;
 	}
-	mutex_unlock(&iio_map_list_lock);
 
-	return chans;
+	return_ptr(chans);
 
 error_free_chans:
 	for (i = 0; i < nummaps; i++)
 		iio_device_put(chans[i].indio_dev);
-	kfree(chans);
-error_ret:
-	mutex_unlock(&iio_map_list_lock);
-
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(iio_channel_get_all);
@@ -590,38 +572,24 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 int iio_read_channel_raw(struct iio_channel *chan, int *val)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_raw);
 
 int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_AVERAGE_RAW);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_AVERAGE_RAW);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 
@@ -708,20 +676,13 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 				 int *processed, unsigned int scale)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_convert_raw_to_processed_unlocked(chan, raw, processed,
-						    scale);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_convert_raw_to_processed_unlocked(chan, raw, processed,
+						     scale);
 }
 EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
@@ -729,19 +690,12 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 			       enum iio_chan_info_enum attribute)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_channel_read(chan, val, val2, attribute);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_channel_read(chan, val, val2, attribute);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
 
@@ -757,29 +711,24 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
 	int ret;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
 	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
 		ret = iio_channel_read(chan, val, NULL,
 				       IIO_CHAN_INFO_PROCESSED);
 		if (ret < 0)
-			goto err_unlock;
+			return ret;
 		*val *= scale;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-			goto err_unlock;
+			return ret;
 		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val,
 							    scale);
 	}
 
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_processed_scale);
@@ -813,19 +762,12 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
 				     enum iio_chan_info_enum attribute)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_channel_read_avail(chan, vals, type, length, attribute);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_channel_read_avail(chan, vals, type, length, attribute);
 }
 EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
 
@@ -892,20 +834,13 @@ static int iio_channel_read_max(struct iio_channel *chan,
 int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 	int type;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_channel_read_max(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_channel_read_max(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
 }
 EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
 
@@ -955,40 +890,27 @@ static int iio_channel_read_min(struct iio_channel *chan,
 int iio_read_min_channel_raw(struct iio_channel *chan, int *val)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 	int type;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_channel_read_min(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_channel_read_min(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
 }
 EXPORT_SYMBOL_GPL(iio_read_min_channel_raw);
 
 int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret = 0;
-	/* Need to verify underlying driver has not gone away */
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
 	*type = chan->channel->type;
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iio_get_channel_type);
 
@@ -1003,19 +925,12 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
 				enum iio_chan_info_enum attribute)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (!chan->indio_dev->info) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info)
+		return -ENODEV;
 
-	ret = iio_channel_write(chan, val, val2, attribute);
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return iio_channel_write(chan, val, val2, attribute);
 }
 EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
 

-- 
2.44.0


