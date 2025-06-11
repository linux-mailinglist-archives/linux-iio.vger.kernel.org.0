Return-Path: <linux-iio+bounces-20481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF361AD5F50
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6433AA768
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547CF2874EA;
	Wed, 11 Jun 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQf9bM8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BC2BDC2C;
	Wed, 11 Jun 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671282; cv=none; b=pLep2W3F6M8StkFL0zjeugnaER4IUukEiZZHYV3mDO14SXQkGJpYPCJj7oEaVQVYJgkZP95AtvliUAy7F6vYe0UsJQra2bnQRmuYWwusEoEJQeyLhy3E1DS1LZWqATpplaXU03rirKzJiTusrVir6AfJ3v9jUzQnoD2uT9PtB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671282; c=relaxed/simple;
	bh=ySuUknDOu9Ye2nlxzI4/NsiZPAimXndQXRImEuAWrXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2x0kE4M/G4IpRfxqnAjIJtwsSdscffjmW7R3UyDkg2LSgY20u9oFcGNlc4OEnyxEzboya/8bSjgxKJBzftuzRuZqeM2O8YTgWJSbUIXoeQiYdUQcoVVrRcZ2fXBenv82csPSxaR++Zpgj+55UL2Axw/M3oAYsJliR8/JocykYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQf9bM8B; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7086dcab64bso1607507b3.1;
        Wed, 11 Jun 2025 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749671279; x=1750276079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfQ1uSWXIil7J+7zJ57XvDKktzBGNsJQ/2rNxebYhh0=;
        b=bQf9bM8BDodmumQQwmpPPfWZKQNwcPfkw95Eq5KFbghW1A6J/q8j1Q7rv7CYl9JA+h
         wG+S+07BB++/lwIrvN72h6cUhvMz1Dw1mQ+udbOSN1uyQHAWy3zeSJXOzMectRLFKDXV
         5by8Hr//AuiEzdAt5THAAihgdmdzfpsyDnpgYVHD7gGMzSBPoFvE/r6T8hD2BoE0/hHo
         jUBLculOzIQb0uJiWOkv5Awnxhyke3b3jW8fcGEnkBmWQC9FM7WGPLM2VXY64SMW+LWw
         WKgmqP/liw5l39qO5BNszAHn1J04VW3exeqy1cjYu1QV/uy2qHTK0i9oUYRPzCsezf+H
         41aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671279; x=1750276079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfQ1uSWXIil7J+7zJ57XvDKktzBGNsJQ/2rNxebYhh0=;
        b=KusFwD25aJUrl/wrZ+aqh4hl2kFkZ9/2r52tMNfAxNTLByTQSEOfynBRiGvK5SaKRv
         t61M5oY9fghcAnUOOZEzrn8FCb41WHYtj08EsHHcAnvgV07NMct+YMkUz7TbiSO5wojQ
         S8z7o/S2orKpNZTx6kb/KFrWnrDNCO6RTvHpysDLmLB+h1ppp0TZZhE1tMqzx2ZxW2HZ
         WkaGtCCN273lZnSZrJH1WdeN1yw/QX+oRPH+RCcK1nT1BrIbFYFvlcUzuOG4x3Cw9/O8
         532k1bBOaTo4LKZwG7QgEXklzt4Imr/25WZjJChkKkinI8yIEv9dPeV4F4pREuvIDZD3
         1UlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDq/MC1+YpmB7srSMNJgVyS16Dacp3J87+7wuNsv09CdpYD0qoYfIoa5WWixi7T2e5uPyTyae4esNaGAQR@vger.kernel.org, AJvYcCXFZH1u/9tpeRYpehf03jDtR89OrtD4FPVf0VQJLyFMhyDod0r4StiwOhNXoPC21K5NE1KUJwhcqnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMDnDB8gvp4NTQ8HabZgNLWunRF5QFXj0aN4Ow8R+ok8dHDouK
	aJBAO36engbaMZ3+uPMH9MUxUVk1YvrcElhdTkMxsyaezYcxKbUoKmVP
X-Gm-Gg: ASbGncu+ix9zBLHPVtp3NngzxktMOg32eRbNN+nhFRN90aoJ+C1At4PtW7SBM2Gl6yr
	5+74QsLN/bvb7ucWfhz4SK/mYIAHrTJLMTx+qeFM27zlXNf+mfZzKsPP+ZKi5cxtykdD7bYkEsL
	NxIN5gvEJ3P5h2TsCgiMehszg5Pd4d1eb0pjDPjvU9uXvlblss2dODehPWgaSN8QEnhEWGphWQm
	RIXv3689O0m8F+vL06NlqwZftKTpplJtjgxPSzsoUUbIrL1TV8ezfiV8ahOLzk2DA9OjpoxM74+
	1h1Ma1TorYjZabUbS6FVL7NvWFVN8YdxLEEYVbfXqAVA6iqDiE+hyE60ra8iaMYnChm2WPDkAOR
	YDmTd
X-Google-Smtp-Source: AGHT+IHYOgSp+DMOamhYZzo+8wdSHUOh6c+TRGHTfZxh9sfPbOHLuysN00DZxUK5MBSoj88eOKlNLg==
X-Received: by 2002:a05:690c:6aca:b0:710:f55f:7922 with SMTP id 00721157ae682-71150bcd055mr6396627b3.34.1749671278937;
        Wed, 11 Jun 2025 12:47:58 -0700 (PDT)
Received: from delta4.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115206130csm80587b3.1.2025.06.11.12.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:47:58 -0700 (PDT)
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
Subject: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for handling mutex lock
Date: Wed, 11 Jun 2025 16:39:21 -0300
Message-ID: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex)(&st->lock) for handling mutex lock instead of
manually locking and unlocking the mutex. This prevents forgotten
locks due to early exits and remove the need of gotos.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
For this one, there are two cases where the previous implementation
was a smalllocking portion of the code and now it's locking the whole
function. I don't know if this is a desired behavior.

 drivers/iio/accel/sca3000.c | 177 ++++++++++++------------------------
 1 file changed, 57 insertions(+), 120 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index d41759c68fb4..098d45bad389 100644
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
 
@@ -699,32 +696,25 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
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
 			ret = spi_w8r16be(st->us,
 						SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));
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
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
@@ -738,14 +728,12 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 		*val2 = 600000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&st->lock);
+		guard(mutex)(&st->lock);
 		ret = sca3000_read_raw_samp_freq(st, val);
-		mutex_unlock(&st->lock);
 		return ret ? ret : IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		mutex_lock(&st->lock);
+		guard(mutex)(&st->lock);
 		ret = sca3000_read_3db_freq(st, val);
-		mutex_unlock(&st->lock);
 		return ret;
 	default:
 		return -EINVAL;
@@ -763,22 +751,16 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&st->lock);
-		ret = sca3000_write_raw_samp_freq(st, val);
-		mutex_unlock(&st->lock);
-		return ret;
+		guard(mutex)(&st->lock);
+		return sca3000_write_raw_samp_freq(st, val);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&st->lock);
-		ret = sca3000_write_3db_freq(st, val);
-		mutex_unlock(&st->lock);
-		return ret;
+		guard(mutex)(&st->lock);
+		return sca3000_write_3db_freq(st, val);
 	default:
 		return -EINVAL;
 	}
-
-	return ret;
 }
 
 /**
@@ -800,9 +782,8 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int len = 0, ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
-	mutex_unlock(&st->lock);
 	if (ret)
 		return ret;
 
@@ -851,10 +832,9 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		mutex_lock(&st->lock);
+		guard(mutex)(&st->lock);
 		ret = sca3000_read_ctrl_reg(st,
 					    sca3000_addresses[chan->address][1]);
-		mutex_unlock(&st->lock);
 		if (ret < 0)
 			return ret;
 		*val = 0;
@@ -918,13 +898,10 @@ static int sca3000_write_event_value(struct iio_dev *indio_dev,
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
@@ -969,12 +946,12 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
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
@@ -983,7 +960,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
 					num_available * 2);
 		if (ret)
-			goto error_ret;
+			return;
 		for (i = 0; i < num_available / 3; i++) {
 			/*
 			 * Dirty hack to cover for 11 bit in fifo, 13 bit
@@ -995,8 +972,6 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
 		}
 	}
-error_ret:
-	mutex_unlock(&st->lock);
 }
 
 /**
@@ -1022,9 +997,8 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * Could lead if badly timed to an extra read of status reg,
 	 * but ensures no interrupt is missed.
 	 */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_ADDR));
-	mutex_unlock(&st->lock);
 	if (ret)
 		goto done;
 
@@ -1081,16 +1055,15 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
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
@@ -1100,24 +1073,18 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
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
@@ -1220,26 +1187,19 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
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
@@ -1248,23 +1208,19 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
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
 			(ret | SCA3000_REG_MODE_RING_BUF_ENABLE));
-	} else
-		ret = sca3000_write_reg(st,
-			SCA3000_REG_MODE_ADDR,
-			(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	}
+	return sca3000_write_reg(st,
+		SCA3000_REG_MODE_ADDR,
+		(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
 }
 
 /**
@@ -1281,26 +1237,18 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
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
@@ -1308,22 +1256,18 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
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
@@ -1343,25 +1287,25 @@ static int sca3000_clean_setup(struct sca3000_state *st)
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
@@ -1369,17 +1313,17 @@ static int sca3000_clean_setup(struct sca3000_state *st)
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
@@ -1387,13 +1331,9 @@ static int sca3000_clean_setup(struct sca3000_state *st)
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
@@ -1471,19 +1411,16 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
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


