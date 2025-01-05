Return-Path: <linux-iio+bounces-13916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0FA01AE7
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29ADF7A16A5
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF618870C;
	Sun,  5 Jan 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8BbHN4U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F08F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098027; cv=none; b=ozTim1KsY+edcOrg8/4fM5L1GC4MiSYvOJiGcRSKzdAONdRdXm3O7uEGBcQL+vxy6yxm2EXxLgZV+bikhinbWBZ440WQB7wPfVtLUrUKJLX6rAreVa4qYAUrhnMq5tJAWnBqqvd7N1BDvU0rFTfLlN/kG78MibLGLNgdqE5MoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098027; c=relaxed/simple;
	bh=cxUiR/damgtGhKiOE1aiR2GfIhrYU81eWmM7M1LKBaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXqoHbmCuriSGnKUoZIFMPX6Xs6mf3mcheU8D70nVDUYifmW8Ye1RbbL3re2yhESBYp4CyAC98hE7MZBG31UXAHwBL4NTX6pyfO+AhgArK3YLUKC+OUNWm8Nk4ruWLoJjR8wM8/McwAot+3c9seOMxksDCwaaA46A8uhgf3l8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8BbHN4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ED9C4CEDD;
	Sun,  5 Jan 2025 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098027;
	bh=cxUiR/damgtGhKiOE1aiR2GfIhrYU81eWmM7M1LKBaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8BbHN4UaM6wHtmHFHeAvTvq5Q/envuVdKkiRiDmD8etho949YpKAQzLwqCFGm/PU
	 CBLJoM3oj4OURtDRGqzlH4GFlQ6vJKHU4JP0fDNLmf9AM2hml7zWrJ6qtQ86ZT+3O7
	 XEdmTPeZ2i8lXwyU7uQlKXXGq9SogH5ML+cDoAD/LUKeO8EFmCK8F21nJQ5GMvXnmr
	 NyzD+EIUpgHzsddX4H54ckm9SBJGOsIjHAAKAWXcpkoYkOlgKElZFmlNo6JxHGFWza
	 oX4EWwBJWBNlYo5ikbFlhuQlIqDWz4f0d2s2fwSiTZ8V32Y+gnM2NMa7BA7S2oYmql
	 EOE3J07cUyVLw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 17/27] iio: adc: max1363: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:02 +0000
Message-ID: <20250105172613.1204781-18-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max1363.c | 165 ++++++++++++++++++++------------------
 1 file changed, 89 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index e8d731bc34e0..35717ec082ce 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -364,55 +364,52 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 				    int *val,
 				    long m)
 {
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		s32 data;
-		u8 rxbuf[2];
-		struct max1363_state *st = iio_priv(indio_dev);
-		struct i2c_client *client = st->client;
-
-		guard(mutex)(&st->lock);
-
-		/*
-		 * If monitor mode is enabled, the method for reading a single
-		 * channel will have to be rather different and has not yet
-		 * been implemented.
-		 *
-		 * Also, cannot read directly if buffered capture enabled.
-		 */
-		if (st->monitor_on)
-			return -EBUSY;
+	s32 data;
+	u8 rxbuf[2];
+	struct max1363_state *st = iio_priv(indio_dev);
+	struct i2c_client *client = st->client;
 
-		/* Check to see if current scan mode is correct */
-		if (st->current_mode != &max1363_mode_table[chan->address]) {
-			int ret;
+	guard(mutex)(&st->lock);
 
-			/* Update scan mode if needed */
-			st->current_mode = &max1363_mode_table[chan->address];
-			ret = max1363_set_scan_mode(st);
-			if (ret < 0)
-				return ret;
-		}
-		if (st->chip_info->bits != 8) {
-			/* Get reading */
-			data = st->recv(client, rxbuf, 2);
-			if (data < 0)
-				return data;
-
-			data = get_unaligned_be16(rxbuf) &
-				((1 << st->chip_info->bits) - 1);
-		} else {
-			/* Get reading */
-			data = st->recv(client, rxbuf, 1);
-			if (data < 0)
-				return data;
-
-			data = rxbuf[0];
-		}
-		*val = data;
+	/*
+	 * If monitor mode is enabled, the method for reading a single
+	 * channel will have to be rather different and has not yet
+	 * been implemented.
+	 *
+	 * Also, cannot read directly if buffered capture enabled.
+	 */
+	if (st->monitor_on)
+		return -EBUSY;
+
+	/* Check to see if current scan mode is correct */
+	if (st->current_mode != &max1363_mode_table[chan->address]) {
+		int ret;
+
+		/* Update scan mode if needed */
+		st->current_mode = &max1363_mode_table[chan->address];
+		ret = max1363_set_scan_mode(st);
+		if (ret < 0)
+			return ret;
+	}
+	if (st->chip_info->bits != 8) {
+		/* Get reading */
+		data = st->recv(client, rxbuf, 2);
+		if (data < 0)
+			return data;
+
+		data = get_unaligned_be16(rxbuf) &
+			((1 << st->chip_info->bits) - 1);
+	} else {
+		/* Get reading */
+		data = st->recv(client, rxbuf, 1);
+		if (data < 0)
+			return data;
 
-		return 0;
+		data = rxbuf[0];
 	}
-	unreachable();
+	*val = data;
+
+	return 0;
 }
 
 static int max1363_read_raw(struct iio_dev *indio_dev,
@@ -426,7 +423,11 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
 		ret = max1363_read_single_chan(indio_dev, chan, val, m);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
@@ -947,46 +948,58 @@ static inline int __max1363_check_event_mask(int thismask, int checkmask)
 	return ret;
 }
 
-static int max1363_write_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
+static int __max1363_write_event_config(struct max1363_state *st,
+	const struct iio_chan_spec *chan,
 	enum iio_event_direction dir, bool state)
 {
-	struct max1363_state *st = iio_priv(indio_dev);
-
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		int number = chan->channel;
-		u16 unifiedmask;
-		int ret;
+	int number = chan->channel;
+	u16 unifiedmask;
+	int ret;
 
-		guard(mutex)(&st->lock);
+	guard(mutex)(&st->lock);
 
-		unifiedmask = st->mask_low | st->mask_high;
-		if (dir == IIO_EV_DIR_FALLING) {
+	unifiedmask = st->mask_low | st->mask_high;
+	if (dir == IIO_EV_DIR_FALLING) {
 
-			if (state == 0)
-				st->mask_low &= ~(1 << number);
-			else {
-				ret = __max1363_check_event_mask((1 << number),
-								 unifiedmask);
-				if (ret)
-					return ret;
-				st->mask_low |= (1 << number);
-			}
-		} else {
-			if (state == 0)
-				st->mask_high &= ~(1 << number);
-			else {
-				ret = __max1363_check_event_mask((1 << number),
-								 unifiedmask);
-				if (ret)
-					return ret;
-				st->mask_high |= (1 << number);
-			}
+		if (state == 0)
+			st->mask_low &= ~(1 << number);
+		else {
+			ret = __max1363_check_event_mask((1 << number),
+							 unifiedmask);
+			if (ret)
+				return ret;
+			st->mask_low |= (1 << number);
+		}
+	} else {
+		if (state == 0)
+			st->mask_high &= ~(1 << number);
+		else {
+			ret = __max1363_check_event_mask((1 << number),
+							 unifiedmask);
+			if (ret)
+				return ret;
+			st->mask_high |= (1 << number);
 		}
 	}
-	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 
 	return 0;
+
+}
+static int max1363_write_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, bool state)
+{
+	struct max1363_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = __max1363_write_event_config(st, chan,  dir, state);
+	iio_device_release_direct(indio_dev);
+	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
+
+	return ret;
 }
 
 /*
-- 
2.47.1


