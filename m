Return-Path: <linux-iio+bounces-1025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A3816142
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C7D1C20D4E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BD1DFD8;
	Sun, 17 Dec 2023 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udbcVKui"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B446451
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFDFC433C9;
	Sun, 17 Dec 2023 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834578;
	bh=0kcwUlxREz2zmy8VMjlbmZoqe5DOt9lBPHqE0R/OQEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udbcVKuinZVhkfusFIFzcjTMyciieeRg0+lfuo++XRhwSPE+W40MgUo9yJcVmn4FK
	 rS2xvq2kXUhlFwN3K0naUfZft97aCgSPBzAXw3eTR4YLg03X/QI03OLqmHtVJqLOME
	 osuXQqwvJG3pVh0mIN8LCbHdxQFJA2xRWUPvEVI+8OCvhpZd2CfI0KBZHq03ZM2xBt
	 NK7xUj/bJTmxmyfldGVydI/AMnh5CPYQUSdDhY6Utkniy7KScpjQ34fYv0J4Kefgl7
	 2pV2YrOW+F1VFQ7pRp/2O5ajiUDGb8TLOblcRh8RIdYbuYB/0u/bJGw6BYEnaQX37s
	 O28nRosbN9MTQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 05/10] iio: adc: max1363: Use automatic cleanup for locks and iio mode claiming.
Date: Sun, 17 Dec 2023 17:35:43 +0000
Message-ID: <20231217173548.112701-6-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217173548.112701-1-jic23@kernel.org>
References: <20231217173548.112701-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This simplifies error return paths.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max1363.c | 149 +++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 83 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 7c2a98b8c3a9..e5be12769d87 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -363,56 +363,46 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	mutex_lock(&st->lock);
-
-	/*
-	 * If monitor mode is enabled, the method for reading a single
-	 * channel will have to be rather different and has not yet
-	 * been implemented.
-	 *
-	 * Also, cannot read directly if buffered capture enabled.
-	 */
-	if (st->monitor_on) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-
-	/* Check to see if current scan mode is correct */
-	if (st->current_mode != &max1363_mode_table[chan->address]) {
-		/* Update scan mode if needed */
-		st->current_mode = &max1363_mode_table[chan->address];
-		ret = max1363_set_scan_mode(st);
-		if (ret < 0)
-			goto error_ret;
-	}
-	if (st->chip_info->bits != 8) {
-		/* Get reading */
-		data = st->recv(client, rxbuf, 2);
-		if (data < 0) {
-			ret = data;
-			goto error_ret;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		guard(mutex)(&st->lock);
+
+		/*
+		 * If monitor mode is enabled, the method for reading a single
+		 * channel will have to be rather different and has not yet
+		 * been implemented.
+		 *
+		 * Also, cannot read directly if buffered capture enabled.
+		 */
+		if (st->monitor_on)
+			return -EBUSY;
+
+		/* Check to see if current scan mode is correct */
+		if (st->current_mode != &max1363_mode_table[chan->address]) {
+			/* Update scan mode if needed */
+			st->current_mode = &max1363_mode_table[chan->address];
+			ret = max1363_set_scan_mode(st);
+			if (ret < 0)
+				return ret;
 		}
-		data = (rxbuf[1] | rxbuf[0] << 8) &
-		  ((1 << st->chip_info->bits) - 1);
-	} else {
-		/* Get reading */
-		data = st->recv(client, rxbuf, 1);
-		if (data < 0) {
-			ret = data;
-			goto error_ret;
+		if (st->chip_info->bits != 8) {
+			/* Get reading */
+			data = st->recv(client, rxbuf, 2);
+			if (data < 0)
+				return data;
+
+			data = (rxbuf[1] | rxbuf[0] << 8) &
+				((1 << st->chip_info->bits) - 1);
+		} else {
+			/* Get reading */
+			data = st->recv(client, rxbuf, 1);
+			if (data < 0)
+				return data;
+
+			data = rxbuf[0];
 		}
-		data = rxbuf[0];
+		*val = data;
 	}
-	*val = data;
-
-error_ret:
-	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
-	return ret;
-
+	return 0;
 }
 
 static int max1363_read_raw(struct iio_dev *indio_dev,
@@ -710,9 +700,8 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	st->monitor_speed = i;
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock)
+		st->monitor_speed = i;
 
 	return 0;
 }
@@ -815,12 +804,11 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
 	int val;
 	int number = chan->channel;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (dir == IIO_EV_DIR_FALLING)
 		val = (1 << number) & st->mask_low;
 	else
 		val = (1 << number) & st->mask_high;
-	mutex_unlock(&st->lock);
 
 	return val;
 }
@@ -967,41 +955,36 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	u16 unifiedmask;
 	int number = chan->channel;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	mutex_lock(&st->lock);
-
-	unifiedmask = st->mask_low | st->mask_high;
-	if (dir == IIO_EV_DIR_FALLING) {
-
-		if (state == 0)
-			st->mask_low &= ~(1 << number);
-		else {
-			ret = __max1363_check_event_mask((1 << number),
-							 unifiedmask);
-			if (ret)
-				goto error_ret;
-			st->mask_low |= (1 << number);
-		}
-	} else {
-		if (state == 0)
-			st->mask_high &= ~(1 << number);
-		else {
-			ret = __max1363_check_event_mask((1 << number),
-							 unifiedmask);
-			if (ret)
-				goto error_ret;
-			st->mask_high |= (1 << number);
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		guard(mutex)(&st->lock);
+
+		unifiedmask = st->mask_low | st->mask_high;
+		if (dir == IIO_EV_DIR_FALLING) {
+
+			if (state == 0)
+				st->mask_low &= ~(1 << number);
+			else {
+				ret = __max1363_check_event_mask((1 << number),
+								 unifiedmask);
+				if (ret)
+					return ret;
+				st->mask_low |= (1 << number);
+			}
+		} else {
+			if (state == 0)
+				st->mask_high &= ~(1 << number);
+			else {
+				ret = __max1363_check_event_mask((1 << number),
+								 unifiedmask);
+				if (ret)
+					return ret;
+				st->mask_high |= (1 << number);
+			}
 		}
 	}
-
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
-error_ret:
-	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
 
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.43.0


