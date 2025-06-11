Return-Path: <linux-iio+bounces-20480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194A4AD5F4D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1142D1BC24EC
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977182BDC26;
	Wed, 11 Jun 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4nsHuUA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBC2BDC15;
	Wed, 11 Jun 2025 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671279; cv=none; b=snhWdHWbSr8vMiViEYTzStGFB0gOk8sO7iotjMU2LfOSt0YcN5YZX0PwFtQ3j7MgStnACIRsqNTxkGdkN3/318zTvyL0guwXq1djrokNrW3MFo2xFWYMaRq9MBpgBJMmwNjDl7QRHCrw8AeirOuK28mBdQTHfNTAbTEa/wJyeZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671279; c=relaxed/simple;
	bh=YLOU2F2CnWpQj8rysO2FOjfX55FB+LVbYS4tZ08XEQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsAVPkrCueUn8Fb7YrsBj0hRm/1d5RuQyBepk8Pbbjap1sC/ZjbagV1d0Eg7eJsAyIxmcrcKYlQ7H4oYHMkr+LMiG7762HMESC4z37fVS5kgo9YazKU13lJU2CdYGK6LPCPLr69gOGiIaOJFkHWFY6UdpzdcmVWv/dnwudF4y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4nsHuUA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e23e9aeefso1342747b3.2;
        Wed, 11 Jun 2025 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749671276; x=1750276076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULXucmHQ+DQI9KRwaFAtDXf0XTvdLDrcQBcmoDWQaNA=;
        b=O4nsHuUAhnQYZqSm6++0v+LyAiOIZ4nbgVuVguJcGeDsZzz+l0iizY9l9kKB/oK2FX
         ZDZrR4jm5TVnWhgFZ4D9NISLxSPAGRgFWkOIg8e5wJPa4MW610I78U+rWkweND/bqkg2
         WaUBdynHgulTLfFN4+fN8g/le/zXKGmxDpnPmBnaCxAXt/79aI5fwmC52b3tBTNrUH4I
         DCNOfKrO167bevHTAj7Tm2XxK1a2eQP41LWQ4t6jRMqxqKRIUaeRh1etN66UWR1RwzVE
         roXyH/0Fx3SfamxDGaY2946xW0MFdQ2VCt1/NyD5QpR1KmUGlkV8VVAgOfdRZhchLzfe
         Is/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671276; x=1750276076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULXucmHQ+DQI9KRwaFAtDXf0XTvdLDrcQBcmoDWQaNA=;
        b=aesBWOprJQgBuf0suvWINc6KkpsL0BQULmuAvu1aA2R/qN+P6oeRf2KtWPODRhzysD
         ZrsPrMR5XzqGIBZZp0GL0YJ/fUXrkJtnvmBctSZFN4aGbcH3o43GB3M/5edoiaTJI1S9
         b7w98ukipVMy8XhOhSt6i0q9trEsCreNv7LIFi4F8TIZx48Ptk+HGYekowU0wE4u/ngW
         pt4m1VnHmN4S9qxpBgp6egkxRU4SMRFEcv+42ttVEMD4s1lT/zQY6DBUA7uOLjL2DM+N
         iEFbgxDMKssDA2ObF9p/IUh6zdA9LsYne6WGGfNHTBCK1KHQ7Uge+i72P6+hKUCE/3Fe
         ctuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyQHgfzeeAe9vHQTMf2x1PkJ6KUeh/Fiyqr3FoYLc/Sr3BEPee8zv0Knvvkp70EmpbgRuBy8zRqyoyxHo1@vger.kernel.org, AJvYcCX9Gc35csIbxsCwapb2YHbBhx7MRqTCQjV7Ohp+x2ZNBdj6wYZTReZYU7Onnxv2DZbx1FDMdLOBgHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rZGRujAsxbAsMDRPk4TdLULZ8hZtuR9/T9wyfIis2nii2IDW
	Ck3/1JmKCg/hSoC+6VDM4Np2FxLGtKosEG0FGfi6iThr94UaswT4aM15
X-Gm-Gg: ASbGncsW8XQRg+yVUB+oYUL1sAeSK3ZVvZuf5pCVbE5IMltSQF3JKDHh0n5RrE9MKKW
	2cukKwecxqaS8YaxlaINgbCGVR0m3CZ55PbTPLFt/nOMkTJ1QtQESPNBw1qeIUrzDiS0kcWEBxz
	wZ4IltsJkXKHFlYVhqhtW5mBGPbREYllGBWRSOdPX16f5Rqf6MVWqqxtfiB1L43rDTGyrRK9IOr
	yx+oxPRB6peZAOsLhHF8OQEnj8x8UH8aX7j9UhZ3rk88CUsbyYDANQBzRhGaWdFzxjK3pI1r58H
	aJTRu+W4rKTiQ7xfdp58RU5+3BPz7q73k8pLPiDSVHELpEOgAh/7xN3fP2eKlfc/BUZ5bsOrSqe
	5qayTztiGtzyhYIM=
X-Google-Smtp-Source: AGHT+IG/UXfJJh+pp7lcWjw/SthtjALYOPD+4ffiOAQQXWyLedNggTKTtwTMjnFLmmOGBMHTthqx8g==
X-Received: by 2002:a05:690c:7007:b0:70d:f07c:f593 with SMTP id 00721157ae682-7114ec49002mr19803177b3.6.1749671276052;
        Wed, 11 Jun 2025 12:47:56 -0700 (PDT)
Received: from delta4.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115206130csm80587b3.1.2025.06.11.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:47:55 -0700 (PDT)
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
Subject: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal read data helpers by spi helpers
Date: Wed, 11 Jun 2025 16:39:20 -0300
Message-ID: <20250611194648.18133-3-andrew.lopes@alumni.usp.br>
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

Remove usages of sca3000_read_data() and sca3000_read_data_short()
functions, replacing it by spi_w8r8() and spi_w8r16be() helpers. Just
one case that reads large buffers is left using an internal helper.

This is an old driver that was not making full use of the newer
infrastructure.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/sca3000.c | 166 +++++++++++++++---------------------
 1 file changed, 68 insertions(+), 98 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index bfa8a3f5a92f..d41759c68fb4 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -281,24 +281,6 @@ static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
 	return spi_write(st->us, st->tx, 2);
 }
 
-static int sca3000_read_data_short(struct sca3000_state *st,
-				   u8 reg_address_high,
-				   int len)
-{
-	struct spi_transfer xfer[2] = {
-		{
-			.len = 1,
-			.tx_buf = st->tx,
-		}, {
-			.len = len,
-			.rx_buf = st->rx,
-		}
-	};
-	st->tx[0] = SCA3000_READ_REG(reg_address_high);
-
-	return spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
-}
-
 /**
  * sca3000_reg_lock_on() - test if the ctrl register lock is on
  * @st: Driver specific device instance data.
@@ -309,11 +291,11 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_STATUS_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_STATUS_ADDR));
 	if (ret < 0)
 		return ret;
 
-	return !(st->rx[0] & SCA3000_LOCKED);
+	return !(ret & SCA3000_LOCKED);
 }
 
 /**
@@ -409,10 +391,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
 	if (ret)
 		return ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
-	if (ret)
-		return ret;
-	return st->rx[0];
+	return spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_CTRL_DATA_ADDR));
 }
 
 /**
@@ -427,13 +406,13 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_REVID_ADDR));
 	if (ret < 0)
 		goto error_ret;
 	dev_info(&indio_dev->dev,
 		 "sca3000 revision major=%lu, minor=%lu\n",
-		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
-		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
+		 ret & SCA3000_REG_REVID_MAJOR_MASK,
+		 ret & SCA3000_REG_REVID_MINOR_MASK);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -570,7 +549,7 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 
@@ -660,13 +639,13 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 
 	/* mask bottom 2 bits - only ones that are relevant */
-	st->rx[0] &= SCA3000_REG_MODE_MODE_MASK;
-	switch (st->rx[0]) {
+	ret &= SCA3000_REG_MODE_MODE_MASK;
+	switch (ret) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		*val = st->info->measurement_mode_3db_freq;
 		return IIO_VAL_INT;
@@ -698,14 +677,14 @@ static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
 		mode = SCA3000_REG_MODE_MEAS_MODE_OP_2;
 	else
 		return -EINVAL;
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 
-	st->rx[0] &= ~SCA3000_REG_MODE_MODE_MASK;
-	st->rx[0] |= (mode & SCA3000_REG_MODE_MODE_MASK);
+	ret &= ~SCA3000_REG_MODE_MODE_MASK;
+	ret |= (mode & SCA3000_REG_MODE_MODE_MASK);
 
-	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, st->rx[0]);
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, ret);
 }
 
 static int sca3000_read_raw(struct iio_dev *indio_dev,
@@ -727,25 +706,22 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				return -EBUSY;
 			}
 			address = sca3000_addresses[chan->address][0];
-			ret = sca3000_read_data_short(st, address, 2);
+			ret = spi_w8r16be(st->us, SCA3000_READ_REG(address));
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = sign_extend32(be16_to_cpup((__be16 *)st->rx) >>
-					     chan->scan_type.shift,
+			*val = sign_extend32(ret >> chan->scan_type.shift,
 					     chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
-			ret = sca3000_read_data_short(st,
-						      SCA3000_REG_TEMP_MSB_ADDR,
-						      2);
+			ret = spi_w8r16be(st->us,
+						SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = (be16_to_cpup((__be16 *)st->rx) >>
-				chan->scan_type.shift) &
+			*val = (ret >> chan->scan_type.shift) &
 				GENMASK(chan->scan_type.realbits - 1, 0);
 		}
 		mutex_unlock(&st->lock);
@@ -822,16 +798,15 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int len = 0, ret, val;
+	int len = 0, ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
-	val = st->rx[0];
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	mutex_unlock(&st->lock);
 	if (ret)
 		return ret;
 
-	switch (val & SCA3000_REG_MODE_MODE_MASK) {
+	switch (ret & SCA3000_REG_MODE_MODE_MASK) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		len += sprintf(buf + len, "%d %d %d\n",
 			       st->info->measurement_mode_freq,
@@ -964,7 +939,6 @@ static const struct attribute_group sca3000_attribute_group = {
 
 static int sca3000_read_data(struct sca3000_state *st,
 			     u8 reg_address_high,
-			     u8 *rx,
 			     int len)
 {
 	int ret;
@@ -974,18 +948,15 @@ static int sca3000_read_data(struct sca3000_state *st,
 			.tx_buf = st->tx,
 		}, {
 			.len = len,
-			.rx_buf = rx,
+			.rx_buf = st->rx,
 		}
 	};
-
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
+
 	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
-	if (ret) {
+	if (ret)
 		dev_err(&st->us->dev, "problem reading register\n");
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 /**
@@ -1001,16 +972,15 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
-		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
-					      1);
+		ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
 		if (ret)
 			goto error_ret;
-		num_available = st->rx[0];
+		num_available = ret;
 		/*
 		 * num_available is the total number of samples available
 		 * i.e. number of time points * number of channels.
 		 */
-		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
+		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
 					num_available * 2);
 		if (ret)
 			goto error_ret;
@@ -1045,7 +1015,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret, val;
+	int ret;
 	s64 last_timestamp = iio_get_time_ns(indio_dev);
 
 	/*
@@ -1053,15 +1023,14 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * but ensures no interrupt is missed.
 	 */
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
-	val = st->rx[0];
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_ADDR));
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto done;
 
-	sca3000_ring_int_process(val, indio_dev);
+	sca3000_ring_int_process(ret, indio_dev);
 
-	if (val & SCA3000_INT_STATUS_FREE_FALL)
+	if (ret & SCA3000_INT_STATUS_FREE_FALL)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1070,7 +1039,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 						  IIO_EV_DIR_FALLING),
 			       last_timestamp);
 
-	if (val & SCA3000_INT_STATUS_Y_TRIGGER)
+	if (ret & SCA3000_INT_STATUS_Y_TRIGGER)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1079,7 +1048,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 						  IIO_EV_DIR_RISING),
 			       last_timestamp);
 
-	if (val & SCA3000_INT_STATUS_X_TRIGGER)
+	if (ret & SCA3000_INT_STATUS_X_TRIGGER)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1088,7 +1057,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 						  IIO_EV_DIR_RISING),
 			       last_timestamp);
 
-	if (val & SCA3000_INT_STATUS_Z_TRIGGER)
+	if (ret & SCA3000_INT_STATUS_Z_TRIGGER)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1114,13 +1083,13 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
 
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
-		ret = !!(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT);
+		ret = !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
 		break;
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
@@ -1129,7 +1098,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		 * Motion detection mode cannot run at the same time as
 		 * acceleration data being read.
 		 */
-		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		if ((ret & SCA3000_REG_MODE_MODE_MASK)
 		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
 			ret = 0;
 		} else {
@@ -1157,20 +1126,20 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 
 	/* if off and should be on */
-	if (state && !(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
+	if (state && !(ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-					 st->rx[0] | SCA3000_REG_MODE_FREE_FALL_DETECT);
+					 ret | SCA3000_REG_MODE_FREE_FALL_DETECT);
 	/* if on and should be off */
-	else if (!state && (st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
+	if (!state && (ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-					 st->rx[0] & ~SCA3000_REG_MODE_FREE_FALL_DETECT);
-	else
-		return 0;
+					 ret & ~SCA3000_REG_MODE_FREE_FALL_DETECT);
+
+	return 0;
 }
 
 static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
@@ -1207,22 +1176,22 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
 	}
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 	/* if off and should be on */
 	if ((st->mo_det_use_count) &&
-	    ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+	    ((ret & SCA3000_REG_MODE_MODE_MASK)
 	     != SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-			(st->rx[0] & ~SCA3000_REG_MODE_MODE_MASK)
+			(ret & ~SCA3000_REG_MODE_MODE_MASK)
 			| SCA3000_REG_MODE_MEAS_MODE_MOT_DET);
 	/* if on and should be off */
 	else if (!(st->mo_det_use_count) &&
-		 ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		 ((ret & SCA3000_REG_MODE_MODE_MASK)
 		  == SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-			st->rx[0] & SCA3000_REG_MODE_MODE_MASK);
+			ret & SCA3000_REG_MODE_MODE_MASK);
 	else
 		return 0;
 }
@@ -1280,18 +1249,18 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
 	if (state) {
 		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
 		ret = sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
-			(st->rx[0] | SCA3000_REG_MODE_RING_BUF_ENABLE));
+			(ret | SCA3000_REG_MODE_RING_BUF_ENABLE));
 	} else
 		ret = sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
-			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
+			(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -1315,12 +1284,12 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	/* Enable the 50% full interrupt */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_unlock;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
-				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
+				ret | SCA3000_REG_INT_MASK_RING_HALF);
 	if (ret)
 		goto error_unlock;
 
@@ -1346,12 +1315,12 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	/* Disable the 50% full interrupt */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto unlock;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
-				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
+				ret & ~SCA3000_REG_INT_MASK_RING_HALF);
 unlock:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -1376,7 +1345,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 
@@ -1402,7 +1371,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
@@ -1416,11 +1385,11 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
 	 * as that occurs in one of the example on the datasheet
 	 */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-				(st->rx[0] & SCA3000_MODE_PROT_MASK));
+				ret & SCA3000_MODE_PROT_MASK);
 
 error_ret:
 	mutex_unlock(&st->lock);
@@ -1503,14 +1472,15 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
+
 	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
-				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-				   SCA3000_REG_INT_MASK_RING_HALF |
-				   SCA3000_REG_INT_MASK_ALL_INTS)));
+				ret &
+				~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+				  SCA3000_REG_INT_MASK_RING_HALF |
+				  SCA3000_REG_INT_MASK_ALL_INTS));
 error_ret:
 	mutex_unlock(&st->lock);
 	return ret;
-- 
2.49.0


