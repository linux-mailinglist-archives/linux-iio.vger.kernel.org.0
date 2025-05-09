Return-Path: <linux-iio+bounces-19353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0135EAB0781
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 03:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647324A6772
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E916C12B17C;
	Fri,  9 May 2025 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh/7H01f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E092208AD;
	Fri,  9 May 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746754792; cv=none; b=ebIG8h98MQJx8P/hIs3vkO9I361tenkFtqFWHyIpCDQ5CtnYd+MiiNDkWhGUif/WUO+E9ZMny4oIAVoh6HiF8g6LppDWaa7jWgKH5MtdTk5tUkh8RQqexNWjZ4ABqs1Rj/inSixahQr4G6hSa6njni1xM2TyOmY54chujI9QQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746754792; c=relaxed/simple;
	bh=IPbxJmGasZA45CAQ++rPpMRuJMTtm6mGkF6W4RJnPCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iw4oXzcy/j63sBXZtYWJWGIe6GZNIInrUBqJnBf2aUDn2ZmJhb+4AZJzWJm7cJwhnk3qTPvJQZj7vo4yEUlDKLwMXJj++aZA0wQL8hVhOH5kPH4+3DXIaBv5+cgwpTtGb4EW3TxQP2nI4GybYzmbkfaGctm1xvBQB2nK7yQ7XZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh/7H01f; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so442647241.0;
        Thu, 08 May 2025 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746754789; x=1747359589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhdwGMdwmHTeOScYwrRU/fG8PC/QKO4j1b+2bB2QDhU=;
        b=Dh/7H01f/7h4YxP0tgbh5/fblQQV5w+ANJ0IQah6jOOCNsbr+418Q7dXnaly/3FEaY
         pI454r2lgHeww4LLUKoW2lUDFk9OB1YAR+1+RVkaJO3YPlrNhkJYIAvuH9gdp8nXok6f
         3S/1qI/CpjPb5Up6rewXcImcPawxyGxZ2VENeDcn+tso/4X5JzqI1hb9Db10OzTzQpQz
         pVNq/P4iwjmG46ZsKzeJImu1nFC2/zcTUvurkPkNYwDuRgDF0oY5Dz6zhPKjfTU0HjM3
         4ZaiDRohkruaDvjKGwKsVngjrzuSc5HGJ4tcxaK9wMsnELAHPKvyjRslkyUTETBTHlTP
         eI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746754789; x=1747359589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhdwGMdwmHTeOScYwrRU/fG8PC/QKO4j1b+2bB2QDhU=;
        b=Qwr0DEqdv2pF8xFeCtELSoRv+xRFEGnynzZrQG7bazKImXaAHHbidguh9J3VROWjQ2
         tbVSQbPfd0fBm19wqIqAl7TseNEF9vE0tqybnUu8lSO7gmppOyeF07ugdomMFHA7ULGF
         LPSCd9hGuhToYBksshbrxJq+mwdOwbyZ0CdYQrZ6JvKdE8liZjLBlzR/BPLqNj+gHQ9U
         LFtstZhOAMCjA9YrgtHhgm/Y0yrN7h7nCNHJpZh5W5Z/nZ+2kgYXsc/JbDFl19QvqWsi
         9wbyunZh7491k1wzda/iZ1kZ40QY0hPQGhNSetlDN7ukRqeVLA8R4KqMZ+LLqhz5xZaz
         dzzw==
X-Forwarded-Encrypted: i=1; AJvYcCVAVxFTS2R9sW2alBp+LUPVrrRTks2Xps+++38JsajZrlZ6eB8xpYlSD+vdd1ovZjqS3T0Dd3+T+v0=@vger.kernel.org, AJvYcCVXX3EuaGm5P3RITKwbmgaN2TB2aIwIaxv4/+CixHNYOwzSVnch50/AdxdWTSZC5vAI0UmXT9CwbMBQSMob@vger.kernel.org
X-Gm-Message-State: AOJu0Yxix9r6tZTfxelcUXFH4sUaU6yvux6WrMXZ638zWyrKqlK2oNp6
	Bn1dxNtj+Vg9xt93xewvmVmsP5FoGgftLmngtmWshSKCH7gYVWIKBU4tYmPOZWM=
X-Gm-Gg: ASbGncvhTRc/boRWvzYHPIXw7TULlB5zCAYjhkuAX9CBEN7uCDlP+Hvnhdv7r8OfAFM
	m24flNfTRnAi5d/USb2n0In/Jf3TL81qQQF2/+w84YvdBINFVEK83W6vcA/1u6TcCjSdXGtotpZ
	W6v5YwWU3vM4BOYVz4u6nXICTxC3MpugemHu/wKUMw1pJ5hJq+YKmJgd+69jxPzIekoZZ/yqU85
	F0+CkgRdt6QHxdYk0w6AKPX898e+fCt8BujReqJsDv/RLjXXpLrJP6lrPFCQQCMy2pMcQ/w1Cut
	i7oUaANIXsexhgtQ+pJ8kTkBbbDiJkjVYRggMkiQb9iq
X-Google-Smtp-Source: AGHT+IFSjM00QKEC/2ROZqdesOs0/hq0gK8oqQrWrfr5+IhNQjMrqcgmDpyEwHQjomrwMh7Z/pNZ4A==
X-Received: by 2002:a05:6102:8097:b0:4de:dc75:1c10 with SMTP id ada2fe7eead31-4deed3e23e8mr1394538137.16.1746754789357;
        Thu, 08 May 2025 18:39:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1002])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4deb2018611sm418299137.20.2025.05.08.18.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 18:39:49 -0700 (PDT)
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
Subject: [PATCH v3] iio: accel: sca3000: replace usages of internal read data helpers by spi helpers
Date: Thu,  8 May 2025 22:38:06 -0300
Message-ID: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove usages of sca3000_read_data() and sca3000_read_data_short()
functions, replacing it by spi_w8r8() and spi_w8r16() helpers. Just
one case that reads large buffers is left using an internal helper.

This is an old driver that was not making full use of the newer
infrastructure.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
---
Even though we reviewed every change and it compiled without
any errors, we don't have the required devices to manually
test its behavior.

drivers/iio/accel/sca3000.c | 153 +++++++++++++++---------------------
 1 file changed, 65 insertions(+), 88 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index aabe4491efd7..4a9ec0639aaa 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -281,10 +281,11 @@ static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
 	return spi_write(st->us, st->tx, 2);
 }
 
-static int sca3000_read_data_short(struct sca3000_state *st,
-				   u8 reg_address_high,
-				   int len)
+static int sca3000_read_data(struct sca3000_state *st,
+			     u8 reg_address_high,
+			     int len)
 {
+	int ret;
 	struct spi_transfer xfer[2] = {
 		{
 			.len = 1,
@@ -296,7 +297,10 @@ static int sca3000_read_data_short(struct sca3000_state *st,
 	};
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
 
-	return spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		dev_err(&st->us->dev, "problem reading register\n");
+	return ret;
 }
 
 /**
@@ -309,11 +313,11 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
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
@@ -412,10 +416,11 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
+
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_CTRL_DATA_ADDR));
 	if (ret)
 		goto error_ret;
-	return st->rx[0];
+	return ret;
 error_ret:
 	return ret;
 }
@@ -432,13 +437,13 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
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
 
@@ -575,10 +580,10 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
-	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
+	switch (SCA3000_REG_MODE_MODE_MASK & ret) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		*base_freq = info->measurement_mode_freq;
 		break;
@@ -665,13 +670,13 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
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
@@ -703,14 +708,14 @@ static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
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
@@ -732,24 +737,23 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				return -EBUSY;
 			}
 			address = sca3000_addresses[chan->address][0];
-			ret = sca3000_read_data_short(st, address, 2);
+			ret = spi_w8r16(st->us, SCA3000_READ_REG(address));
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = sign_extend32(be16_to_cpup((__be16 *)st->rx) >>
+			*val = sign_extend32(be16_to_cpu((__be16) ret) >>
 					     chan->scan_type.shift,
 					     chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
-			ret = sca3000_read_data_short(st,
-						      SCA3000_REG_TEMP_MSB_ADDR,
-						      2);
+			ret = spi_w8r16(st->us,
+						SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = (be16_to_cpup((__be16 *)st->rx) >>
+			*val = (be16_to_cpu((__be16) ret) >>
 				chan->scan_type.shift) &
 				GENMASK(chan->scan_type.realbits - 1, 0);
 		}
@@ -827,16 +831,15 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
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
 		goto error_ret;
 
-	switch (val & SCA3000_REG_MODE_MODE_MASK) {
+	switch (ret & SCA3000_REG_MODE_MODE_MASK) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		len += sprintf(buf + len, "%d %d %d\n",
 			       st->info->measurement_mode_freq,
@@ -969,32 +972,6 @@ static const struct attribute_group sca3000_attribute_group = {
 	.attrs = sca3000_attributes,
 };
 
-static int sca3000_read_data(struct sca3000_state *st,
-			     u8 reg_address_high,
-			     u8 *rx,
-			     int len)
-{
-	int ret;
-	struct spi_transfer xfer[2] = {
-		{
-			.len = 1,
-			.tx_buf = st->tx,
-		}, {
-			.len = len,
-			.rx_buf = rx,
-		}
-	};
-
-	st->tx[0] = SCA3000_READ_REG(reg_address_high);
-	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
-	if (ret) {
-		dev_err(&st->us->dev, "problem reading register\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 /**
  * sca3000_ring_int_process() - ring specific interrupt handling.
  * @val: Value of the interrupt status register.
@@ -1008,16 +985,15 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
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
@@ -1060,8 +1036,8 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * but ensures no interrupt is missed.
 	 */
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
-	val = st->rx[0];
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_ADDR));
+	val = ret;
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto done;
@@ -1121,13 +1097,13 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
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
@@ -1136,7 +1112,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		 * Motion detection mode cannot run at the same time as
 		 * acceleration data being read.
 		 */
-		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		if ((ret & SCA3000_REG_MODE_MODE_MASK)
 		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
 			ret = 0;
 		} else {
@@ -1164,18 +1140,18 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
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
+	else if (!state && (ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-					 st->rx[0] & ~SCA3000_REG_MODE_FREE_FALL_DETECT);
+					 ret & ~SCA3000_REG_MODE_FREE_FALL_DETECT);
 	else
 		return 0;
 }
@@ -1214,22 +1190,22 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
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
@@ -1287,18 +1263,18 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
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
 
@@ -1322,12 +1298,12 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
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
 
@@ -1353,12 +1329,12 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
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
@@ -1383,7 +1359,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 
@@ -1409,7 +1385,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
@@ -1423,11 +1399,11 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
 	 * as that occurs in one of the example on the datasheet
 	 */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-				(st->rx[0] & SCA3000_MODE_PROT_MASK));
+				(ret & SCA3000_MODE_PROT_MASK));
 
 error_ret:
 	mutex_unlock(&st->lock);
@@ -1510,11 +1486,12 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
+
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
+				(ret &
 				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
 				   SCA3000_REG_INT_MASK_RING_HALF |
 				   SCA3000_REG_INT_MASK_ALL_INTS)));
-- 
2.49.0


