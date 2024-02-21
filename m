Return-Path: <linux-iio+bounces-2871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A985DA57
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 14:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5941F1F2414C
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343180C0A;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btp+ZksG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938B80BFF
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522017; cv=none; b=Af9b+1dCHsA9oqLT3ChreJQ/RN71/zYJA7dmk7Lh7lfLAHzdegYwSeP7bQWD7kO/d801pf2CORNf9ySXgdBUyHbcypEEp8dzXNWV9vKnsBt+PpzCvvLIYAwINgAKNchna8pgXHI+ZPv/7DrCXmRP8CvhPo8jIzwQr1j+F8jgO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522017; c=relaxed/simple;
	bh=qFYINX18COEZancOBVE+J0PkNTRewscHNnANq1NtE6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6R5I1VREPPCRuONLPEuqmgDoUkk/iezi78fhKB7+q67Z4cus2ca+Jw2IgoyrI6fxG7XsrGC+IGt8FK5BNHb+mNsaqMbexar9K3KT/c5/aoarlMAuGmF8w/Czr2U5iDs6O0Nknqutg0M+p7UHCYsMuKtGDKrk8h3VJ6kX26UBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btp+ZksG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1889CC41679;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522017;
	bh=qFYINX18COEZancOBVE+J0PkNTRewscHNnANq1NtE6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Btp+ZksGOEW3ZgNHM8Y3IaOQEOxNcGeU8De+wxngMRVruGIgSrMBg8sh9r2e6xZrs
	 Mnh1/UkaXhR0HR7JWYa+CcigQy6pdYtdmJKnOB8iyZ9xmPmUVT0Ha6UN4MAu83C0v4
	 VPcNgBqoo/KAvetTNPlYl8i5oY0CmUoig/ix60c877RNxxkINFsaeLuMW+dvEGi/pk
	 h39bEfa5Otlr+e477gajPTK5N1eqsH2riornq4JzctAkX7t5X9SiNK3Fr2a/mawKlw
	 W2c7rkOwt00hp7F7WGd2OnPX8V7E6erg7wGAZQr/U0Pq/bdA+SLPHVFa8zeRU6SazX
	 0ADxgpxCJaSow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06169C48BC3;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 Feb 2024 14:26:56 +0100
Subject: [PATCH 5/5] iio: inkern: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-iio-use-cleanup-magic-v1-5-f9c292666f26@analog.com>
References: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
In-Reply-To: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708522015; l=12111;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3+/f3kNp+MlxZLmwHTg9hfEYQ4QyDxWxMZCbaPjXvkM=;
 b=IGHcNbQno50QNX5rgt82AJXwjCqLN/WZlZwC67vFz0mQkEkE24odjy2KhjccpHcK8lMb+5RSY
 X5WVS+wq9c4B4vZoLtEYZNabuyD7Yu7QT5Wzml0qPb0RFK42bBRL9Lf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

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
2.43.0


