Return-Path: <linux-iio+bounces-15667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C713A38549
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E849188E214
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08AA21C9F8;
	Mon, 17 Feb 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvFg0bZI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AF22083
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800931; cv=none; b=NOUK/joanHpBfo7ff2i3bS/nTl4gBIGXqNo2KrehWyy2JMNuNrM5HAlkuW/ba4hirfOW3pM8qP/a0mzBpZmORCpvDIPsuZB2fiZkzeVHF5msb+s5/RAXlfVTwB4samKdiC1rr/K+MC8WysOIRQlA8ZwXzSe2240dF9sULkEze2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800931; c=relaxed/simple;
	bh=eGZI46neJBkWMfRmxrPwgrLmwMaRB+Cg3jxbH0Nf0OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlQZtyZUq4uDX9SVlHewZyvH27Sv324Rzbf6YSU2L7bp3nZJugLLe/SQONcERycURw16rUM/Rv6zyCJsQgODolWxUcC8gzoZ4KtqtFM5JsgAvMgYy+d6TjAPKngJ3siq/fqF3jwfH02z29eW5zTvaFBr0VT+b1KFTyy64Xxk9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvFg0bZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2546C4CED1;
	Mon, 17 Feb 2025 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800931;
	bh=eGZI46neJBkWMfRmxrPwgrLmwMaRB+Cg3jxbH0Nf0OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvFg0bZIWFtBTdMuHp1UTKNm+m9rUifKpKcFBlLLbhXCUwe0YRwV+Df3pbOETl+im
	 OdzIg9iKMHy7f8KOjXrC2m5FQ1j7GoPUkZTaDX10WL07j9b2zk3M6w6fFSxxGIP+kk
	 ACP7dsmdhpwC8/IcSUwNqDk7aQ19406YMMUC2EGpydUylRyPFtTgwnBHHaj/yYa9JA
	 MYi+2gdCpZxyPYu6Ulko5q6a8GxTLu6y5HPgp0/9slesxMLZ2a98vNlo151UP8EujM
	 RiVcLX/dWsojz7WO/9//fN0Z60plNmN7eVHjIrfHVrvnRT2lgG/x0DaETFbnPpsPYT
	 KVxh4a6M85iVQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 8/8] iio: accel: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:01:35 +0000
Message-ID: <20250217140135.896574-9-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217140135.896574-1-jic23@kernel.org>
References: <20250217140135.896574-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Single patch for the simple cases in accelerometer drivers.

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Given we had so many complex cases, maybe it makes sense to break
these out as well.
---
 drivers/iio/accel/adxl372.c           |  7 +++----
 drivers/iio/accel/adxl380.c           |  7 +++----
 drivers/iio/accel/bma180.c            |  7 +++----
 drivers/iio/accel/bmi088-accel-core.c |  7 ++++---
 drivers/iio/accel/fxls8962af-core.c   | 21 +++++++++------------
 5 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 8ba5fbe6e1f5..961145b50293 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -763,12 +763,11 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = adxl372_read_axis(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 90340f134722..0cf3c6815829 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1175,12 +1175,11 @@ static int adxl380_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = adxl380_read_chn(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 128db14ba726..aa664a923f91 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -540,14 +540,13 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		mutex_lock(&data->mutex);
 		ret = bma180_get_data_reg(data, chan->scan_index);
 		mutex_unlock(&data->mutex);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		if (chan->scan_type.sign == 's') {
diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 36e5d06ffd33..dea126f993c1 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -313,12 +313,13 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
+			if (!iio_device_claim_direct(indio_dev)) {
+				ret = -EBUSY;
 				goto out_read_raw_pm_put;
+			}
 
 			ret = bmi088_accel_get_axis(data, chan, val);
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			if (!ret)
 				ret = IIO_VAL_INT;
 
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 987212a7c038..48e4282964a0 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -460,22 +460,20 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
 		if (val != 0)
 			return -EINVAL;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = fxls8962af_set_full_scale(data, val2);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = fxls8962af_set_samp_freq(data, val, val2);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	default:
 		return -EINVAL;
@@ -683,14 +681,13 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
 		fxls8962af_active(data);
 		ret = fxls8962af_power_on(data);
 	} else {
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		/* Not in buffered mode so disable power */
 		ret = fxls8962af_power_off(data);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 	}
 
 	return ret;
-- 
2.48.1


