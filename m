Return-Path: <linux-iio+bounces-2869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CD85DA59
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9840B2775C
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97557C094;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGRe2hVQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D517C08B
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522017; cv=none; b=kYRm8UWcweGchIFtIL1C+2G/BxUM/XUfSyIWbGs/Bb2YbuVJZWC94g9l/mGBvCosnRhzVAY4wDq2uZfrcDVZhoE68qq9Uav6xBItvG/jhUBp3kdurtJAAYei5P1PC8/JDekM6kXV9yZFaKXoE19IcJLmtI1+zuSjZDNOAXvP7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522017; c=relaxed/simple;
	bh=3yqhtwWO2DRjtVmZXZWj9y2hj/hOXyf+Gm02TneJ/0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snp2fTgi1tY3GmH48fCSM9qd2jz6crXXT40PFO+0QKRRpTYsn14K7fOidb++BgSd9hiIE/XUlG+e4T1/VGCR2yEw0AMKi7GJoPtDx2cVS4p2Q9Zwqf1/nUwVJmRmXZ6/nMD96S+IhE8yipXR08tDv2/MhqOElCepsyayPii+1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGRe2hVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B138C4166D;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522017;
	bh=3yqhtwWO2DRjtVmZXZWj9y2hj/hOXyf+Gm02TneJ/0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UGRe2hVQy5SF5RmIk5kyAp2mJ0ElQB6aDRfVmsGRtk/fHwulfF0WLRunFJhul8EZ1
	 4c+aaWnn8Wl/Sg60TJLWRul/O8mQnoS5/aQRwNhWA32eGGDgvXDce9GjAHdZjhH9kW
	 wTBCZXLbuL3+2FVi+yXwB4vv8G0mdLdIzSiUYiMVpOuAZzP77mGbrS05lkkLl0qUOF
	 8B6jmdCPLdrWbRZBMjZIXnBWT/IxS9jz42E4BqsKyozqVDgTaPwd4yB6Yvxd3d2Y65
	 quXtvXobZSfJOzeFGEgoVfc9ZrxgqPDU/RPUJ2/2LRO2b0ws9rYJzWvXQH0OGBSvh3
	 6JLNeRyBl2Jog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00BC5478B;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 Feb 2024 14:26:55 +0100
Subject: [PATCH 4/5] iio: buffer: iio: core: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-iio-use-cleanup-magic-v1-4-f9c292666f26@analog.com>
References: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
In-Reply-To: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708522015; l=5744;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=OnkkOpFV90Za5vmcQJyxeW+vquaE1ViN2ybUVAdH++M=;
 b=A0OM5HO2T+Rk0KdYwCt7uu6ci66URbPeET00I0A8eeJtKNuye7T9CqKGKpf5IfQAXYbaI/vrW
 ELec9w4kC3DBYLOckN21Ad0EO+iFAebIwM8fXD6qPjIkFZtWMsuw3gV
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
2.43.0


