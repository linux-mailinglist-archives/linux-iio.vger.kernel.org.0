Return-Path: <linux-iio+bounces-20754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805FCADE197
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 05:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B83A784E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 03:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507DC1E51EF;
	Wed, 18 Jun 2025 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inScrJFJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D31E0E14;
	Wed, 18 Jun 2025 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216657; cv=none; b=HzOdDRdWTIVuIX9+u+NiXLRim6bIPxdQsxG+pd7gCTTKWvTY2C/AjAmuvSbZKyazg7ZJ0PFw+tmLTHLRDGiNC0EqyEFRZHWwjVASpdIxGVJgJnJ0IvxUHDBPXGVLUUy6gorUoJNcXoVANEcsMC9WSs/n4kfI8bazWsIDqr+AkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216657; c=relaxed/simple;
	bh=3X6iautA+rVq3UozUsQR5OdIV798z6KvJHqgvAc0V3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asKbBmhavSavB0vRL8f2DomW4+3HitSK91GJAB0AwQzqc11jM3/j2/HsTy+Kz3H/1rAqFIDaHPyWA2TiPSK/oSTv8cjsKoMF5zIgRqw/pdkIghBBdlh2iIRYWWd63gR4W4GT9Gswxlk0sWZFdmV+36ulIjCjMfLUgaLBeJxB2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inScrJFJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236377f00a1so57468475ad.3;
        Tue, 17 Jun 2025 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750216654; x=1750821454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8NHjy30QYpMH8wGk4U2AA90RBMYfc/a+wEG/dD30AY=;
        b=inScrJFJIr9vkHWKxGsauiY/+wZbx8pzNvqRforiuwXSjNc4P4LDMtaVn1DofUJnQj
         jK518TmrqY4Uvgv9u2/SoLn+jSGvoyyGDNpXJUTrFHJfP49QUOdmnmfLK+v6XgCxeHQ4
         XFOK9ZJslvKaaN86+XOYBIkwyNdXgXsR0oReA7qm2OCwXN7q6/LIPmbv3fi0gPkFJZRd
         Ear0TGf2cOwG5KKphjbWPT9EP1j29JP9rbrGvBdeYaEtU+kJ4hwtEE7ISXBvDvyN3S2t
         cTFoXVw9MvrhvArM4NsUeME6jNpsjXqSTtrx3f2H0BgyhKrw9+XBS85mkQcn83FsTu1j
         vbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750216654; x=1750821454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8NHjy30QYpMH8wGk4U2AA90RBMYfc/a+wEG/dD30AY=;
        b=aMD+ps7keCZwBSfd6d5TPuooFW2l/d+qWmuG5KKKlL1jEzpj3twRXb0Iqh0IdRbJgR
         UiZSvNV7ex4w//ykVgaOCl8rZxQFFfJ3gUXWPRLtMlSW6i7y1a1grlpK1LeIZye6zGyA
         /5Jt75jGnyga3BjC09XymmC2p9NG+GxpIeW9mnnVTX4eCUfayCImKi4oz848m1S4CBN1
         vFQT7TWuLARueObkzvNcDhQeBXS5MopBn8IFcHseP52Fz1J/mi25YHlVQT0Ck14uM1G1
         /J+lZqdPrJWz0s0adcKIKRfy8OGpyz1zoe75whXDG9qMwzA8KMkES9gAM16QEEwgMRVJ
         LQMA==
X-Forwarded-Encrypted: i=1; AJvYcCUXBhN6gcdle/R3ODltOOsYsqETCZ4J52IBTqAcARO4wjEH4olHf4Am3OAGFaTYe7qFSLcDrCH5HkXetOOD@vger.kernel.org, AJvYcCWmlYgE5G3Q2XddS5GDvVNxtU9UBO6bpEwlba/3RltCZVG0c4xlh1utLr/519HfVjilKsXy8W41DRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzocCus6Z3gfdV+dG+W5IwuxLKNFjKRqKzlsNXP9zPtRvP1+BVR
	QsAnGgyk3FdJqhV14S1Zj6mK5L3BzWWmBWLnaSnhf7ijE7GZwBtYbfFG0CRBBrMnJS0=
X-Gm-Gg: ASbGnctiJzxJ1CJPMLHnxOB2pdhw39VLt0jYFwUBFUKmdp9kD42xLy90f7/Fo7vJPgj
	W4sUcsDBA1temF+uj8trVvCQDzG0LCuaiBWXykqNbBEyhKVc2/Hclqi0EEqx5alBz7wFl+346d0
	VBhaQmFBxaaKec7PRGy74bco9vQjEXWPyLewZK9FhuszW74oQ/QIq/WwJWBL0ln5UH2W5eKLDyB
	vTELMh2//xxAmNRgpG3JK5fVvF6Nc5gJFfDtP1ifwhDEUW18ApK5HjS/G2W2qc/OTuVxUzaXLnl
	V5LR9krqTuAGxH6IN+Xhqesdoddbtq+y//sdj/PnhYhZHQSdc8QmWifUQzQeG7uJ0Nmsar7klRw
	y
X-Google-Smtp-Source: AGHT+IFmay82+G/zjZfNTuj6UJ34TQdi2pCailaGSIe8wpnlN+6szQHKVCzTMVLDc0M8QtTakVsszA==
X-Received: by 2002:a17:902:c943:b0:223:4d7e:e52c with SMTP id d9443c01a7336-2366afbe6afmr248707325ad.5.1750216654430;
        Tue, 17 Jun 2025 20:17:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm89179545ad.239.2025.06.17.20.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:17:34 -0700 (PDT)
From: Andrew Ijano <andrew.ijano@gmail.com>
X-Google-Original-From: Andrew Ijano <andrew.lopes@alumni.usp.br>
To: jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] iio: accel: sca3000: use lock guards
Date: Wed, 18 Jun 2025 00:12:18 -0300
Message-ID: <20250618031638.26477-4-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() for handling mutex lock instead of
manually locking and unlocking the mutex. This prevents forgotten
locks due to early exits and remove the need of gotos.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/sca3000.c | 205 +++++++++++++-----------------------
 1 file changed, 73 insertions(+), 132 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 7145b4541264..058a2d67c91c 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -405,17 +405,14 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_REVID_ADDR));
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	dev_info(&indio_dev->dev,
 		 "sca3000 revision major=%lu, minor=%lu\n",
 		 ret & SCA3000_REG_REVID_MAJOR_MASK,
 		 ret & SCA3000_REG_REVID_MINOR_MASK);
-error_ret:
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -698,33 +695,27 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 	u8 address;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
 		if (chan->type == IIO_ACCEL) {
-			if (st->mo_det_use_count) {
-				mutex_unlock(&st->lock);
+			if (st->mo_det_use_count)
 				return -EBUSY;
-			}
 			address = sca3000_addresses[chan->address][0];
 			ret = spi_w8r16be(st->us, SCA3000_READ_REG(address));
-			if (ret < 0) {
-				mutex_unlock(&st->lock);
+			if (ret < 0)
 				return ret;
-			}
 			*val = sign_extend32(ret >> chan->scan_type.shift,
 					     chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
 			ret = spi_w8r16be(st->us, SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));
-			if (ret < 0) {
-				mutex_unlock(&st->lock);
+			if (ret < 0)
 				return ret;
-			}
 			*val = (ret >> chan->scan_type.shift) &
 				GENMASK(chan->scan_type.realbits - 1, 0);
 		}
-		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		if (chan->type == IIO_ACCEL)
@@ -736,16 +727,16 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 		*val = -214;
 		*val2 = 600000;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
 		ret = sca3000_read_raw_samp_freq(st, val);
-		mutex_unlock(&st->lock);
 		return ret ? ret : IIO_VAL_INT;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		mutex_lock(&st->lock);
+	}
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
+		guard(mutex)(&st->lock);
 		ret = sca3000_read_3db_freq(st, val);
-		mutex_unlock(&st->lock);
 		return ret;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -756,28 +747,23 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&st->lock);
-		ret = sca3000_write_raw_samp_freq(st, val);
-		mutex_unlock(&st->lock);
-		return ret;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return sca3000_write_raw_samp_freq(st, val);
+	}
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
+		guard(mutex)(&st->lock);
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&st->lock);
-		ret = sca3000_write_3db_freq(st, val);
-		mutex_unlock(&st->lock);
-		return ret;
+		return sca3000_write_3db_freq(st, val);
+	}
 	default:
 		return -EINVAL;
 	}
-
-	return ret;
 }
 
 /**
@@ -800,9 +786,9 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 	unsigned int len = 0;
 	int ret;
 
-	mutex_lock(&st->lock);
-	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock) {
+		ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
+	}
 	if (ret)
 		return ret;
 
@@ -850,11 +836,10 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 	int i;
 
 	switch (info) {
-	case IIO_EV_INFO_VALUE:
-		mutex_lock(&st->lock);
-		ret = sca3000_read_ctrl_reg(st,
-					    sca3000_addresses[chan->address][1]);
-		mutex_unlock(&st->lock);
+	case IIO_EV_INFO_VALUE: {
+		scoped_guard(mutex, &st->lock) {
+			ret = sca3000_read_ctrl_reg(st, sca3000_addresses[chan->address][1]);
+		}
 		if (ret < 0)
 			return ret;
 		*val = 0;
@@ -868,6 +853,7 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 				*val += st->info->mot_det_mult_xz[i];
 
 		return IIO_VAL_INT;
+	}
 	case IIO_EV_INFO_PERIOD:
 		*val = 0;
 		*val2 = 226000;
@@ -898,7 +884,6 @@ static int sca3000_write_event_value(struct iio_dev *indio_dev,
 				     int val, int val2)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
 	int i;
 	u8 nonlinear = 0;
 
@@ -918,13 +903,10 @@ static int sca3000_write_event_value(struct iio_dev *indio_dev,
 			}
 	}
 
-	mutex_lock(&st->lock);
-	ret = sca3000_write_ctrl_reg(st,
+	guard(mutex)(&st->lock);
+	return sca3000_write_ctrl_reg(st,
 				     sca3000_addresses[chan->address][1],
 				     nonlinear);
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static struct attribute *sca3000_attributes[] = {
@@ -969,12 +951,12 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, i, num_available;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
 		ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
 		if (ret)
-			goto error_ret;
+			return;
 		num_available = ret;
 		/*
 		 * num_available is the total number of samples available
@@ -982,7 +964,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		 */
 		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, num_available * 2);
 		if (ret)
-			goto error_ret;
+			return;
 		for (i = 0; i < num_available / 3; i++) {
 			/*
 			 * Dirty hack to cover for 11 bit in fifo, 13 bit
@@ -994,8 +976,6 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
 		}
 	}
-error_ret:
-	mutex_unlock(&st->lock);
 }
 
 /**
@@ -1021,9 +1001,8 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * Could lead if badly timed to an extra read of status reg,
 	 * but ensures no interrupt is missed.
 	 */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_ADDR));
-	mutex_unlock(&st->lock);
 	if (ret)
 		goto done;
 
@@ -1080,16 +1059,15 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	/* read current value of mode register */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
-		ret = !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
-		break;
+		return !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
 	case IIO_MOD_Z:
@@ -1099,24 +1077,18 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		 */
 		if ((ret & SCA3000_REG_MODE_MODE_MASK)
 		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
-			ret = 0;
+			return 0;
 		} else {
 			ret = sca3000_read_ctrl_reg(st,
 						SCA3000_REG_CTRL_SEL_MD_CTRL);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 			/* only supporting logical or's for now */
-			ret = !!(ret & sca3000_addresses[chan->address][2]);
+			return !!(ret & sca3000_addresses[chan->address][2]);
 		}
-		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
@@ -1217,28 +1189,20 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 				      bool state)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
-		ret = sca3000_freefall_set_state(indio_dev, state);
-		break;
-
+		return sca3000_freefall_set_state(indio_dev, state);
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
 	case IIO_MOD_Z:
-		ret = sca3000_motion_detect_set_state(indio_dev,
+		return sca3000_motion_detect_set_state(indio_dev,
 						      chan->address,
 						      state);
-		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static inline
@@ -1247,23 +1211,19 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
-		goto error_ret;
+		return ret;
+
 	if (state) {
 		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
-		ret = sca3000_write_reg(st,
+		return sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
 			ret | SCA3000_REG_MODE_RING_BUF_ENABLE);
-	} else
-		ret = sca3000_write_reg(st,
-			SCA3000_REG_MODE_ADDR,
-			ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	}
+	return sca3000_write_reg(st,
+		SCA3000_REG_MODE_ADDR,
+		ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE);
 }
 
 /**
@@ -1280,26 +1240,18 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
-
+	guard(mutex)(&st->lock);
 	/* Enable the 50% full interrupt */
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
-		goto error_unlock;
+		return ret;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				ret | SCA3000_REG_INT_MASK_RING_HALF);
 	if (ret)
-		goto error_unlock;
-
-	mutex_unlock(&st->lock);
+		return ret;
 
 	return __sca3000_hw_ring_state_set(indio_dev, 1);
-
-error_unlock:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
@@ -1307,22 +1259,18 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
 	ret = __sca3000_hw_ring_state_set(indio_dev, 0);
 	if (ret)
 		return ret;
 
 	/* Disable the 50% full interrupt */
-	mutex_lock(&st->lock);
-
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
-		goto unlock;
-	ret = sca3000_write_reg(st,
+		return ret;
+	return sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				ret & ~SCA3000_REG_INT_MASK_RING_HALF);
-unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
@@ -1342,25 +1290,25 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Turn off all motion detection channels */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL,
 				     ret & SCA3000_MD_CTRL_PROT_MASK);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Disable ring buffer */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
 				     (ret & SCA3000_REG_OUT_CTRL_PROT_MASK)
 				     | SCA3000_REG_OUT_CTRL_BUF_X_EN
@@ -1368,17 +1316,17 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 				     | SCA3000_REG_OUT_CTRL_BUF_Z_EN
 				     | SCA3000_REG_OUT_CTRL_BUF_DIV_4);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				(ret & SCA3000_REG_INT_MASK_PROT_MASK)
 				| SCA3000_REG_INT_MASK_ACTIVE_LOW);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/*
 	 * Select normal measurement mode, free fall off, ring off
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
@@ -1386,13 +1334,9 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 */
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+		return ret;
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
 				ret & SCA3000_MODE_PROT_MASK);
-
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static const struct iio_info sca3000_info = {
@@ -1470,19 +1414,16 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
-		goto error_ret;
+		return ret;
 
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
 				ret &
 				~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
 				  SCA3000_REG_INT_MASK_RING_HALF |
 				  SCA3000_REG_INT_MASK_ALL_INTS));
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static void sca3000_remove(struct spi_device *spi)
-- 
2.49.0


