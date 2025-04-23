Return-Path: <linux-iio+bounces-18571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FEA99609
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 19:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3199746576C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04785289367;
	Wed, 23 Apr 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGTZSSJJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19270202961;
	Wed, 23 Apr 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427982; cv=none; b=QR7JfdAtlZQt/eeWQr05rT0ZC5xJRiJy2iA8tIG2YqbDDlSNZaFVTWVqdl3A+k3dWyU23fmhlWzJASD60u98ecv8U2BqfM2qbQEwmNAHI2IdQF7NwqGHdvtAMWUtVhQIlkXYwq2LvbYUFslPzGOcSIj1Z2ej6KjG14n/6CH3MA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427982; c=relaxed/simple;
	bh=n0hLIQMV4RgMq6A50D+8hjviVxHs848BOPaJqtM4q90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZhww1ddhy9W2PbbDk6tmVG0eQdww4OFUxEbGkgz9YiepUu2UvOiUCFTAyc0AgsHolDuxqbVTMz/p+vmeIYB+nWvaUiMgebXzcdlqTaPgbBO2VeGT8Oqn+qThfs2jnKdJEKLb356yj2lEmb6LTreLLoAwx00Zr7kxJgAdhjOHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGTZSSJJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264aefc45dso1354405ad.0;
        Wed, 23 Apr 2025 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745427980; x=1746032780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zq5XdeL9ToAKwNn1O6D6mibDHxiyxNVwdZRqKOds+wk=;
        b=RGTZSSJJAETTZi7uxGXZQLvoEBWZViVYwKBqo6WfFFlgyDlI48BQr9ozkJMdoXQ+j/
         1hAEFlG7AlZEzCiULElEoljNcpnP9EaA3DCUyrcv4AuyjZzpWxnfa/Cs9yuGOpEIEmO1
         3VVRUlmxH7VL9chPgwMDmWx3axAQjGIquJyPrxN/amGoxooqBHJcb4UZZHufIqN3JRBE
         65RXS8X6jVsjcH5oftCQk6HeFbaLjqRxkkiK+6nWz7La1FbIF6xV4aGqTvuirD5c5Hgg
         NFhmZVGKDnwBZLEt/323FEP5nMYYOhL+3gC6t+Uy3KcWekIYVMhGYN378iTIauOm11uP
         dh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427980; x=1746032780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zq5XdeL9ToAKwNn1O6D6mibDHxiyxNVwdZRqKOds+wk=;
        b=KX6AOL5lXHxs55YjiyYEPlwwXeuGXPpmub4mDyqUcXBsQB7FtD7B124mIpY1m2+LzI
         pOfUEn9fdkEpNGqCFTyQGsU1EN2pe9XFsOg8PbxauGhVmQLMNxXSJLBaUZUwOU6ppIav
         tnm4vB/+YW1PRsUJFfToUsdqiBX2EdPhpq7XveFObGgWDJUCVUc28SCVrHEX00+HWQAQ
         Ln2/uLkDMD6Q3bDkMoh0jA9+dY3oD5Gy8M9J6xN6VrE9O08TQrqgXd7h9WlIsA/Sz+Le
         mNTVftSCCNSZFUlB1AKfHE4XMzl5RYQ8w+ErC1nEXt1iF1fxyVdAhUJEBBnc8xRse5jX
         ALQw==
X-Forwarded-Encrypted: i=1; AJvYcCUy2fLWlEEZAvpqQ9/Xadex9zqthmRCVhWqaXxN6LUj8EAs2HC4vvBFx4pRF55hHbD+OTzM40vVD6V4WwZD@vger.kernel.org, AJvYcCVm37PvyRYw+UintLk/ubEL4+olSrSAsjx8M79tFEhlDYfLR395pjBlYRCA/4Bj+CaMadvpQ7rtONY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMMcy10oN0cPJXG5dnEnYN25SKleOvLYUL+qN+55Vj/IuWBbL
	Xtdq7clcQvAIpRgCiuxQLNRW9kaALSw3QxaEnEPtlCLB5zD267La
X-Gm-Gg: ASbGncuqusQuciF9+mDDI1DtJT2S1QtLbhySg0OQ8g5RtHQyzcKLU7jinlIYlYbgNww
	xllaa3l7UDcwUNTYoCgDDG9QGCXMAx/qDMRC+kdM8/3gDQeo6CZskKBkH7e0DOmYg/lUAfNiNMX
	jXPrsUvb1G6wF2k2zzc9+KnHzZwdLrIt/H9f3MRpTCorzuys7yooR7a/UOaBl3PZWmXddVJRwi8
	T6V/tspKxcUljuqZcOd8q5WfT+ktpW4t/4JGkWN0kqmV2RBpGaC1f/3m3a4dktIuxwoCymNMXct
	ICKFY4ogZHVn75ceHu68HQPuK86V8znGb/jmXoVWASb8Es/VWRvzt7uivQ4=
X-Google-Smtp-Source: AGHT+IEvexOcjSgNuSPlOz9TKyCXBOjUd5ptRfZhm3pBbIhNiVkRxQRrLtdhgoJbdiDeq9RqFeZxSA==
X-Received: by 2002:a17:903:410a:b0:223:536d:f67b with SMTP id d9443c01a7336-22c53607c21mr266532495ad.38.1745427980450;
        Wed, 23 Apr 2025 10:06:20 -0700 (PDT)
Received: from delta4.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdf3a6sm106943875ad.259.2025.04.23.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:06:20 -0700 (PDT)
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
Subject: [PATCH] iio: accel: sca3000: remove duplicated code in sca3000_read_data
Date: Wed, 23 Apr 2025 14:05:26 -0300
Message-ID: <20250423170526.15143-1-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicated code between sca3000_read_data and
sca3000_read_data_short functions.

The common behavior is centralized in just one sca3000_read_data
function and used for every case.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
---
 drivers/iio/accel/sca3000.c | 85 ++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index aabe4491efd7..cdede5df63d8 100644
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
@@ -294,9 +295,15 @@ static int sca3000_read_data_short(struct sca3000_state *st,
 			.rx_buf = st->rx,
 		}
 	};
+
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
+	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	if (ret) {
+		dev_err(&st->us->dev, "problem reading register\n");
+		return ret;
+	}
 
-	return spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	return 0;
 }
 
 /**
@@ -309,7 +316,7 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_STATUS_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_STATUS_ADDR, 1);
 	if (ret < 0)
 		return ret;
 
@@ -412,7 +419,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	return st->rx[0];
@@ -432,7 +439,7 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_REVID_ADDR, 1);
 	if (ret < 0)
 		goto error_ret;
 	dev_info(&indio_dev->dev,
@@ -575,7 +582,7 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
@@ -665,7 +672,7 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 
@@ -703,7 +710,7 @@ static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
 		mode = SCA3000_REG_MODE_MEAS_MODE_OP_2;
 	else
 		return -EINVAL;
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 
@@ -732,7 +739,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				return -EBUSY;
 			}
 			address = sca3000_addresses[chan->address][0];
-			ret = sca3000_read_data_short(st, address, 2);
+			ret = sca3000_read_data(st, address, 2);
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
@@ -742,7 +749,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 					     chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
-			ret = sca3000_read_data_short(st,
+			ret = sca3000_read_data(st,
 						      SCA3000_REG_TEMP_MSB_ADDR,
 						      2);
 			if (ret < 0) {
@@ -830,7 +837,7 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 	int len = 0, ret, val;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
@@ -969,32 +976,6 @@ static const struct attribute_group sca3000_attribute_group = {
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
@@ -1008,7 +989,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
-		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
+		ret = sca3000_read_data(st, SCA3000_REG_BUF_COUNT_ADDR,
 					      1);
 		if (ret)
 			goto error_ret;
@@ -1017,7 +998,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		 * num_available is the total number of samples available
 		 * i.e. number of time points * number of channels.
 		 */
-		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
+		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
 					num_available * 2);
 		if (ret)
 			goto error_ret;
@@ -1060,7 +1041,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * but ensures no interrupt is missed.
 	 */
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
@@ -1121,7 +1102,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 
@@ -1164,7 +1145,7 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 
@@ -1214,7 +1195,7 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
 	}
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 	/* if off and should be on */
@@ -1287,7 +1268,7 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	if (state) {
@@ -1322,7 +1303,7 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	/* Enable the 50% full interrupt */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_unlock;
 	ret = sca3000_write_reg(st,
@@ -1353,7 +1334,7 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	/* Disable the 50% full interrupt */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto unlock;
 	ret = sca3000_write_reg(st,
@@ -1383,7 +1364,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	if (ret)
 		goto error_ret;
 
@@ -1409,7 +1390,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
@@ -1423,7 +1404,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
 	 * as that occurs in one of the example on the datasheet
 	 */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
@@ -1510,7 +1491,7 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-- 
2.49.0


