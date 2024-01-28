Return-Path: <linux-iio+bounces-1985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312D283F60D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84675B22828
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE725776;
	Sun, 28 Jan 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OflWPOl2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B33210EC
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454397; cv=none; b=Yyb7+D86BEvjdpfEpxGDqzIWw/xRFHuUYAmeChcZ67AVkjc8TflK+oq0HtytHPw0mIUZRC6f3JesIsSj9kV/sq4Xx9wu4Uj73OP7hbqHfxWoKUDZQxTcpIIOXwTz9MBGtJdGt9hAsFBNn9Ohlz07N7MMWmIfrTZbnnohlTedVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454397; c=relaxed/simple;
	bh=aoHPlvtdXcHqvSWdX2d+hx3h66EYSpAyWr/70czQIKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+gj4wWpewlVsP+zF4hBTaop6e5upW9nyTPSM9ueuCS7+FuEVgCFV8jZq7Gs+5z1ndbq1W8qNZEWRHuvK/UpgDU0FUKK0Dfqma06TjuJALIehMed7gop8Ts23n0EVaT/6jPtnfQaT9f/svhcB1J0upjd4CcqEyPFwCi7FTAPIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OflWPOl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AB5C43394;
	Sun, 28 Jan 2024 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454396;
	bh=aoHPlvtdXcHqvSWdX2d+hx3h66EYSpAyWr/70czQIKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OflWPOl2/ZkgbjEKC1Fea+oG4P+GC3A5H6a5JOH4KFOQaqHeV1coImFm+P1gVdoSB
	 xaxtakoo8cnwLurP2tTwCXtI2zCXlxxGz3ZqKcrUGNLeswirO+y5q78iY+2htTq3vE
	 zT5qB8eN/3OARH6i8Zj1SFXejU/HeVdTWXE79+pJeKZa94J1gF7T9nLfivVzuoaA+L
	 cxbp5zmmqwdsfQ/DJ+GJ3XcKW+v8PiJTpoPz3BuNyS6f3VkwWh9LCdHseYqAU8gDPH
	 WDFKrQZ3sk5hHcLGZlhN4NH8laJL7Fft9BHbKcAi/biHjcV87bgNivDkXYHcKRUc4J
	 nUvN4yklT88vQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/10] iio: adc: max1363: Use automatic cleanup for locks and iio mode claiming.
Date: Sun, 28 Jan 2024 15:05:32 +0000
Message-ID: <20240128150537.44592-6-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128150537.44592-1-jic23@kernel.org>
References: <20240128150537.44592-1-jic23@kernel.org>
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
Since RFC:
- Reduce scope of some local variables to within
  iio_device_claim_direct_scoped() covered blocks.
- Don't initialize ret in a few paths where it's never used without
  being assigned.
- Use unreachable in one case to make the code flow to return 0 more
  obvious (only if claiming direct mode succeeds).
---
 drivers/iio/adc/max1363.c | 171 ++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 92 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 7c2a98b8c3a9..8b5bc96cb9fb 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -357,62 +357,55 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 				    int *val,
 				    long m)
 {
-	int ret = 0;
-	s32 data;
-	u8 rxbuf[2];
-	struct max1363_state *st = iio_priv(indio_dev);
-	struct i2c_client *client = st->client;
-
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
+		s32 data;
+		u8 rxbuf[2];
+		struct max1363_state *st = iio_priv(indio_dev);
+		struct i2c_client *client = st->client;
+
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
+			int ret;
+
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
-	}
-	*val = data;
-
-error_ret:
-	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
-	return ret;
+		*val = data;
 
+		return 0;
+	}
+	unreachable();
 }
 
 static int max1363_read_raw(struct iio_dev *indio_dev,
@@ -710,9 +703,8 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	st->monitor_speed = i;
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock)
+		st->monitor_speed = i;
 
 	return 0;
 }
@@ -815,12 +807,11 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
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
@@ -962,46 +953,42 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
 	enum iio_event_direction dir, int state)
 {
-	int ret = 0;
 	struct max1363_state *st = iio_priv(indio_dev);
-	u16 unifiedmask;
-	int number = chan->channel;
 
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
+		int number = chan->channel;
+		u16 unifiedmask;
+		int ret;
+
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


