Return-Path: <linux-iio+bounces-20752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D738BADE194
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 05:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA527A22BD
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 03:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD51AE877;
	Wed, 18 Jun 2025 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrFUEXt5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F31D88A4;
	Wed, 18 Jun 2025 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216651; cv=none; b=klFqfjPvd61RXNX0jM/6DrJkbFhTDIEGNRHmE+N5naG5D0P/fc6/croAiPhLTQRrYgY/FgyBzQQlXqszODVheFzEH6K8fzQZ6w5GE9hZAUkxqYUOmMVygmy2Xh36XfuH0RkKuccn7q4kFZTdNvNsNLYfNG9cncWz1Pmt6o67ArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216651; c=relaxed/simple;
	bh=K4mkFXPR5RVIaI8OVBq6n+HJilkj6RKa5cQixSoKpxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7i/PhuN0DqLKexOaXs9WzwJHdOvkw14nDapsGX7M0fOapgzv+OCxqSSwH6Po6Hw5LmO0IGCaId5dHc7Eh+iuqCqJX2du2yiwHdKAm1ZCH3qd1vU3oQTFRRCjx489ZUeewuWhPWdSQYO0RdmALonk8oi2VyvHcO4xn+N8Vo8I4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrFUEXt5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e1d710d8so79977885ad.1;
        Tue, 17 Jun 2025 20:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750216648; x=1750821448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCe9O75l1lXpId/iHwtAGjSH/WRH6ycIZoI9+EJlbAE=;
        b=lrFUEXt54aL6j3/jiKfimw6gSX9Bo5ww6dxb7Ogl99vJvHrT8EbPadDSi+MGf+lkJ/
         gUYa9y+HmsNCwHpe3Esbn9913/2C4QLGRn7wspLxsUSzST/+3zoJTtBkKkwYb6lI9ylM
         +PEOtHsTfoUWLP8z5d9B4OumJsUsVg9iDb5sp67ef5S0UdIDrxpYQ3YQ0avATeaeERwU
         B46xonAlrYD/XzllBQ1o0nrPFZ6/trrgvEQs2eNMqRIN+dd1kbGHmskb7ZadStm5C2wm
         MaY10ZJ+6pKmyb76Dv4f0OAPZuI0N5LHyA+mw+hAWzsQ0eCCDjRaZKC6Yi5WveiD1DFy
         /2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750216648; x=1750821448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCe9O75l1lXpId/iHwtAGjSH/WRH6ycIZoI9+EJlbAE=;
        b=ZPuV90ghgpKfk8X0yu+KZveg3UK71YftNwUqUYOA6FXwPgXj5LsnyWRMk2535nu3ed
         ZyOX1fsiIsGIUnU24MYQO0mlKhKrcj7bqd0OoOLglU66b9jBYWV61/2IXQ2rT8N7CIQd
         UV0mBFMuoED/Wi9FeR4jR9HGh9FwVGEC6m++8HVoBOduYy8QBQgT/IcflYioG9lxv4ao
         gCPf2iJwOk6nw5IblqUk0nR1z0dUGbnvWuqsjNxZPQVlk0wRObVGuCvZfYpLGe0INQmd
         XlzVPaH08ISFcL60dHwQf68hvSVaDLRAQrjhktIauD/ByMFStfiuOBbEd455Ig2hG4th
         JWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOq6lTmnLYzrsEC/1yPeubp7rVw53Cuz0ux3oklxWOl/EQWLmiyAu1IWRAfHxZ/zQdYX39oM7ADZs=@vger.kernel.org, AJvYcCWRwsj70eXUjE8j6OwNqa2p7yYnHJtAFCzfa4QKufYYTk5Rnun4fjJmaBmVabQyTcEPRCIekZ90EenUdNtm@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVDGQztoxIAidH2L8LNzLGB0CxJXnAX8tyLL9RGKb2kzHzNoB
	8z0K54WwF62I9x7ZifgpIg0DMoHTm8tHH9gj/KfpvzAHXAaewSy3HF5i
X-Gm-Gg: ASbGncsPuWhrptL1bOROmQyvbBvgXgX07DLkO77lI2SCjrbcZOgvVs+qTs+qH+I6IdE
	L80PE56XIJs/FtIHkvJoXf6uQP4g/YIjkH+59xc5IQNWdTRo0cJuBjtO8iZRLj6ZW1SPH4iyU65
	ehtseqV/lgKBVY/+GCPGSLRdVGa4xjB0ttjjIlddMtxPkPsIHuPNSTAkYhX9JMVGPv6h3aesk3s
	hZZdaENMOSob6J0GmcmAP8Z0kkpZd4x17+QD749/FqUNQb2jIfHUjh20eqdu7yoPDAxLcM1ic9o
	RsgcWbj9tyoVH69nXDsu8VaafWy8jaAd1FUUn/3vn4M3JresU59k8qyNc9xkKT87LQ==
X-Google-Smtp-Source: AGHT+IGVrqDaywlxdJmEWpv+1cSFi4lsp78ym2fwnS4sY7mbHX+6662L4yf8pmmNd7ohVbPfGoCjsw==
X-Received: by 2002:a17:903:1d0:b0:235:ed01:18cd with SMTP id d9443c01a7336-2366b3f851amr256115545ad.44.1750216647887;
        Tue, 17 Jun 2025 20:17:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm89179545ad.239.2025.06.17.20.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:17:27 -0700 (PDT)
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
Subject: [PATCH v6 1/4] iio: accel: sca3000: replace usages of internal read data helpers by spi helpers
Date: Wed, 18 Jun 2025 00:12:16 -0300
Message-ID: <20250618031638.26477-2-andrew.lopes@alumni.usp.br>
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

Remove sca3000_read_data_short() function, replacing it by spi_w8r8()
and spi_w8r16be() helpers.

This is an old driver that was not making full use of the newer
infrastructure.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/sca3000.c | 152 +++++++++++++++---------------------
 1 file changed, 63 insertions(+), 89 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index bfa8a3f5a92f..c85a06cbea37 100644
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
+	ret |= mode & SCA3000_REG_MODE_MODE_MASK;
 
-	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, st->rx[0]);
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, ret);
 }
 
 static int sca3000_read_raw(struct iio_dev *indio_dev,
@@ -727,25 +706,21 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
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
+			ret = spi_w8r16be(st->us, SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));
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
@@ -822,16 +797,16 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int len = 0, ret, val;
+	unsigned int len = 0;
+	int ret;
 
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
@@ -1001,11 +976,10 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
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
@@ -1045,7 +1019,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret, val;
+	int ret;
 	s64 last_timestamp = iio_get_time_ns(indio_dev);
 
 	/*
@@ -1053,15 +1027,14 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
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
@@ -1070,7 +1043,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 						  IIO_EV_DIR_FALLING),
 			       last_timestamp);
 
-	if (val & SCA3000_INT_STATUS_Y_TRIGGER)
+	if (ret & SCA3000_INT_STATUS_Y_TRIGGER)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1079,7 +1052,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 						  IIO_EV_DIR_RISING),
 			       last_timestamp);
 
-	if (val & SCA3000_INT_STATUS_X_TRIGGER)
+	if (ret & SCA3000_INT_STATUS_X_TRIGGER)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1088,7 +1061,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 						  IIO_EV_DIR_RISING),
 			       last_timestamp);
 
-	if (val & SCA3000_INT_STATUS_Z_TRIGGER)
+	if (ret & SCA3000_INT_STATUS_Z_TRIGGER)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1114,13 +1087,13 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
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
@@ -1129,7 +1102,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		 * Motion detection mode cannot run at the same time as
 		 * acceleration data being read.
 		 */
-		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		if ((ret & SCA3000_REG_MODE_MODE_MASK)
 		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
 			ret = 0;
 		} else {
@@ -1157,20 +1130,20 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
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
@@ -1207,22 +1180,22 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
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
@@ -1280,18 +1253,18 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
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
+			ret | SCA3000_REG_MODE_RING_BUF_ENABLE);
 	} else
 		ret = sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
-			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
+			ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -1315,12 +1288,12 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
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
 
@@ -1346,12 +1319,12 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
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
@@ -1376,7 +1349,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 
@@ -1402,7 +1375,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
@@ -1416,11 +1389,11 @@ static int sca3000_clean_setup(struct sca3000_state *st)
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
@@ -1503,14 +1476,15 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
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


