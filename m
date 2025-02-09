Return-Path: <linux-iio+bounces-15209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9398FA2DFCD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9163A36A2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482291E0DFE;
	Sun,  9 Feb 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiS6DVUx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A001DF246
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124522; cv=none; b=E5Bvut/+w8iYGIb5VhqRdHtQgjPkZOJGg7ED4fB4L4ogdBRARNDyXxSD9XLuBwaCfyy6c0eXrFZh3Mh5IdiNV+e2AZwRxdl5/yhY+su4L3bAJNjLJsEK3G5CT7af9pqxWB1dMYGqjaXk+lZqjtbLDt8WkhDNpGI0QnZIS3ES6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124522; c=relaxed/simple;
	bh=vlIVdcFjOD1HV6+8hcQX5v9gLxkgwEUAxZCN5GGzy2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4i+roy03AN8B20uj7syZwaDv/4PuvLry1yJauiRjBYVuz0sfCsL5QCUzgrjQu6U1I1/13eJLve3FJpSPH0iqS4K/k2MFWYES1VbopgCBN3k7zb1IEfETxNhZP6Es0vK7hGAS5WYnAIvXbKiiRvttKobqKDhr+LT+3JF3Xnwpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiS6DVUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448F7C4CEDD;
	Sun,  9 Feb 2025 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124521;
	bh=vlIVdcFjOD1HV6+8hcQX5v9gLxkgwEUAxZCN5GGzy2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiS6DVUxqhfqMBJgn2EU+sKeRL10IAU6oObquvuKTfZYuqigbID5zpwwznFz8ZpBV
	 ExowLStfEn9H4Padsn1abMgfcCq5TcM9i4gDqMNgUmOImgpYSO9sJg9TWzPVm3di1s
	 DYqPR+6XwzoG7l/mB/DosIAUvhhb/tYrkh60/dutijStmPF0TK7x1+D+4aBCKJ1JeX
	 Di8GWI6SQnJBIFPb3DmhVY0kGJv6QTuYxZQVaFceVuAahHpnuoWGhv7+xKlQ47UOkk
	 boujVohGVydrw+vp2+gtalFCY12Us2qBuKkT7YVPu66abGDrd0kA/2nXW5szLPyWrz
	 HvBDlGETkHrOw==
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
Subject: [PATCH v2 16/27] iio: adc: max1363: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:13 +0000
Message-ID: <20250209180624.701140-17-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
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


