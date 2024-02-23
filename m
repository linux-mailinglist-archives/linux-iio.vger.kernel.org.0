Return-Path: <linux-iio+bounces-2938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57328611B9
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F751C22079
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0417D41E;
	Fri, 23 Feb 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OV+bq4PE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3547CF2D
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692053; cv=none; b=YT32VztyeT+iJFiwTINrFnf5/kWtRMmPSzQp7WbMbXeecmLpLc/urBrFyBvamuBFJAn7sSPWlCVO+TAT70BZjhF5BsfNp9DdAn4T2yyhKeTqJaswtyz4FogbDuuKVRzF7y6gIP9KQ4xAQGqh3naFgcRcthPnFSMT6gvQK6RsG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692053; c=relaxed/simple;
	bh=mCqc4DuW+ELSDQuTMfaXa4qBgXZiORm6SzvXOK3q6xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qm0RYI8yRNTNCG+su9hIG5IAAgt88oedhDltkf9y8MZ7mINFEL7G0Sqfl0Xbp6lDOABD8DrEcXBHxBTBIiy6QN7rST9oHhIGyshFvlun2pStpEjMtgDlGngTfpUgzGUsQpz9qqKcuT138kBfJreWWysqxo2AVWJ6XRlVL3jB650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OV+bq4PE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N9No1o014764;
	Fri, 23 Feb 2024 07:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=acJ+KcQ/Q+xofpUL+wD/jGXIVyNaiUKPCUIKXQsk6rI=; b=
	OV+bq4PErSO4vn1AYtbgg6dWDUfbPWZatHhNSIq2URpT2IY1+F1FqcSpMaaXIs7T
	6BjbQUrGhmBP6T3OnU77o0kYXPIzWhjsLc2H6aFy6fw5NuUJj/0qC1OnYCkERizz
	BZkoT1NpGM/1NypDwm5hxkQyOg62jVzvdatYb/e9P7qiM8NfXhAOjaOJBiacwzYa
	8zFhSODvgO4cx82PNymTyQjutCyqykKwdptwuuCNYj9TbJn13NkMseNdptFmAAAc
	1xWHTR5C5d492MOa7liJfJWAEkWDW1EaJT+KkNZGfrcDrxhlG87vTPBogs49Higf
	taWL5uuekbLbfWzVtQ4uBw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21pefmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 07:40:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41NCeaor005320
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 07:40:36 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 07:40:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 07:40:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 07:40:35 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NCeNLs000839;
	Fri, 23 Feb 2024 07:40:31 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 23 Feb 2024 13:43:48 +0100
Subject: [PATCH v2 5/5] iio: inkern: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-iio-use-cleanup-magic-v2-5-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708692226; l=12111;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mCqc4DuW+ELSDQuTMfaXa4qBgXZiORm6SzvXOK3q6xU=;
 b=HZSY60dGrNyoa5z8HddEEhAiu0mABpOwg9E3aYBJfVi7SQfb6wtaV9UxLLC8Obm2wyf6Cf0d7
 7HfZhzzAS69C14ODQ2PYpLmlmIdg7iXSeMf1HlKDuFfJkHGQpp5pZIn
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Zd2oq18S53WIaV2x_tKSQ67yljBCjiDc
X-Proofpoint-ORIG-GUID: Zd2oq18S53WIaV2x_tKSQ67yljBCjiDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=644 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230091

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/inkern.c | 224 ++++++++++++++++-----------------------------------
 1 file changed, 71 insertions(+), 153 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7a1f6713318a..6a1d6ff8eb97 100644
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
@@ -43,30 +44,26 @@ static int iio_map_array_unregister_locked(struct iio_dev *indio_dev)
 
 int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 {
-	int i = 0, ret = 0;
+	int i = 0;
 	struct iio_map_internal *mapi;
 
 	if (!maps)
 		return 0;
 
-	mutex_lock(&iio_map_list_lock);
+	guard(mutex)(&iio_map_list_lock);
 	while (maps[i].consumer_dev_name) {
 		mapi = kzalloc(sizeof(*mapi), GFP_KERNEL);
 		if (!mapi) {
-			ret = -ENOMEM;
-			goto error_ret;
+			iio_map_array_unregister_locked(indio_dev);
+			return -ENOMEM;
 		}
 		mapi->map = &maps[i];
 		mapi->indio_dev = indio_dev;
 		list_add_tail(&mapi->l, &iio_map_list);
 		i++;
 	}
-error_ret:
-	if (ret)
-		iio_map_array_unregister_locked(indio_dev);
-	mutex_unlock(&iio_map_list_lock);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iio_map_array_register);
 
@@ -75,13 +72,8 @@ EXPORT_SYMBOL_GPL(iio_map_array_register);
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
 
@@ -337,17 +329,17 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
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
 
@@ -469,7 +461,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 
 	name = dev_name(dev);
 
-	mutex_lock(&iio_map_list_lock);
+	guard(mutex)(&iio_map_list_lock);
 	/* first count the matching maps */
 	list_for_each_entry(c, &iio_map_list, l)
 		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
@@ -477,17 +469,13 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		else
 			nummaps++;
 
-	if (nummaps == 0) {
-		ret = -ENODEV;
-		goto error_ret;
-	}
+	if (nummaps == 0)
+		return ERR_PTR(-ENODEV);
 
 	/* NULL terminated array to save passing size */
 	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
-	if (!chans) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (!chans)
+		return ERR_PTR(-ENOMEM);
 
 	/* for each map fill in the chans element */
 	list_for_each_entry(c, &iio_map_list, l) {
@@ -509,7 +497,6 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		ret = -ENODEV;
 		goto error_free_chans;
 	}
-	mutex_unlock(&iio_map_list_lock);
 
 	return chans;
 
@@ -517,9 +504,6 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	for (i = 0; i < nummaps; i++)
 		iio_device_put(chans[i].indio_dev);
 	kfree(chans);
-error_ret:
-	mutex_unlock(&iio_map_list_lock);
-
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(iio_channel_get_all);
@@ -590,38 +574,24 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
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
 
@@ -708,20 +678,13 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
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
 
@@ -729,19 +692,12 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
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
 
@@ -757,30 +713,25 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
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
+
 		*val *= scale;
-	} else {
-		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
-		if (ret < 0)
-			goto err_unlock;
-		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val,
-							    scale);
+		return ret;
 	}
 
-err_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
+	ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return iio_convert_raw_to_processed_unlocked(chan, *val, val, scale);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_processed_scale);
 
@@ -813,19 +764,12 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
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
 
@@ -892,20 +836,13 @@ static int iio_channel_read_max(struct iio_channel *chan,
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
 
@@ -955,40 +892,28 @@ static int iio_channel_read_min(struct iio_channel *chan,
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
+	/* Need to verify underlying driver has not gone away */
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
 
@@ -1003,19 +928,12 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
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
2.43.2


