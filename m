Return-Path: <linux-iio+bounces-15010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AA0A27C64
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F4A7A1F79
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8D62063DB;
	Tue,  4 Feb 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACZojCHr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EC14B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699463; cv=none; b=aGxl0c7hpf1+Id918osCqfubnwvXlItY7g4WcHHVSh9IWda7Z3t+ZAhkyYm5F7aE24Wvu3ochvEzXdCaojoJmRj77TS9tg3Dm7m6vF/VKLLQLM/5qsfXi2cZE7uS6sEmud3bPPu5BESiGbxQyulkgdvlprCM2EcC12vsVvX3z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699463; c=relaxed/simple;
	bh=SY1tV3JYtB2adhbNbqinw55+2pPxbREzHzGcSCKcSyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0YC6KeZb32F47M7RDMrEVQ2A0SfPPOvXo4Gdif2G6T7hLitC4h2Krg8V+SGNMYDBv1JHnmaVfABwUHci5ShHEEOUjnWIRZ1tIbowjNPuYxLXDUtf1qh4uQGuFrAhULJPs0B//rb6EDcyozOrhtEDE3VxZv3dUHbuT6DP0rxCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACZojCHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296CBC4CEDF;
	Tue,  4 Feb 2025 20:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699461;
	bh=SY1tV3JYtB2adhbNbqinw55+2pPxbREzHzGcSCKcSyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACZojCHrTmdICyUc93/JHzD6UcXGIhhuLOORENfdLDgnJ3mPDZpXoyM0fsEjTezi5
	 ep0P2tGndhHPWHyyfBpWUIDBxNTW45WXwurrfOE2gS1y1PjPVVj1C0+S5mVf5LL6TO
	 PgqPls72948s2cNKt0L8Q6Z7bmESRxY2W+1ssQLjmazpRVHrOoVnQ67TyW5/cHvnab
	 a91C73GGLXKUuvrygiuwjPatvHBXg2xbxRF4u4eZbzBC4ozeoz/LLR7rnKkhDxkqAj
	 UjnSmZmClW2tyZHvYY3JUyHxpogbvbigadgYFIb0G+zg3+Z28oPk1nC8u2+zu8JlIv
	 /0HSY5DUp9bKQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/27] iio: adc: max1363: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:38 +0000
Message-ID: <20250204200250.636721-17-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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
2.48.1


