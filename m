Return-Path: <linux-iio+bounces-23608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEFBB3EE80
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4CA4847FE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23395324B30;
	Mon,  1 Sep 2025 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZBk+tWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF419C560;
	Mon,  1 Sep 2025 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755658; cv=none; b=VgvXVsCXrRFrGiNUui9kiirnfvuLaOqPe2LpWk+MMOi5Lxlvd//MlOEn6xy5WbRA4LItdIRi/q+UfFGXHsYGIZiyiD8g9szvw4fa59o56XwqOYe7myesVnw/+6muXD/yexjCt5IirE4KsX35p1QbdRvmjv0Has8MFIJdmWJT+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755658; c=relaxed/simple;
	bh=ocPt+1SEyi2oxhty1jMpyx8kNNmUVJy3vIvSzgAdcnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUInTqeOaaIrvc/FCu7/rltuG5Yyc3lJ4oQ+uXFr04I0v3gx3/2o5P77+VC0rYSQNfJQoIIth4eFe3xhzJFK6xL8wFEGWxIdos7A1z2nDoW6H6Mvv/6Jx/cssaLNZgib9bYU8PhCx8swISSK4vkRsm2JUsC981WmEv0LxWHs7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZBk+tWg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso3124142a12.1;
        Mon, 01 Sep 2025 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756755656; x=1757360456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa/cEbiE4sQZ3vUxdQQl0nT9RvVdeZXT1WSTRxsefWA=;
        b=DZBk+tWgfuUXKGODV7/7Oe1q3tURTcnBnkb8wh1nEMx/JfZUAqJMH5ETJOKDaJwOA1
         El3KlUMB7ruwMdLbFC/S0CkZLCaWYrgpkODgnqhNj7+YTEYLLhMFx6ubQ/9aNcjYvAfw
         2ulWKvgbiWf6HHRVT7qlegoastY4n37tzNl9WReB4POVa8nTK3ouP9QtKVAaG2F++i83
         omPPWWfOhwi4UT/jkJaIm82M3jTfTVelCc+G9TjdGc2hP/6paQ+WHpN069ah1Q/Kxi0G
         mwrzINW7I5kbJJQQ8Ozws1VTcLgl8FU4CzdUNDQONQsdEBLmUJQuGsbuXWVVP5ac354U
         QG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756755656; x=1757360456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa/cEbiE4sQZ3vUxdQQl0nT9RvVdeZXT1WSTRxsefWA=;
        b=qN3AtB1ImmviVYFxiI43scRsIAggPCqUMojEBgJh6Op4xo03XNRa4urtPQOkfG4/1d
         dk+YGlCaj8RYXwe0BrMFgXc8yiAjkumVl3AnLgJ3/xP3/qPot79bvQCxktQfYdzYqb9Z
         wyn1yTH9q61C7UdQFaXAUjA7MPqD/TZdojZb6uCXXlTYPh1v14vI2EW0PCxUKK/rW/z2
         B+wtEngAMe/bsEy7qGpEAyhlNzFSID97VWTjEmX3r0NEwfJuXc4QdjjEtLAIOkGjHxzq
         RvF7vJgZo4qQ901GXW98TxbPKk9IVNMGKz++lkmcMq0e5UyeSuNCDe2xwXuYgTQpSs+U
         P/mA==
X-Gm-Message-State: AOJu0YwLRRRDVZKjo/iHDaiayGqx13pA3PGrSAqKZeONHvmT1NpSogUP
	8V3MRmovLnYWkM+OPVKwmHBW+1VFOWq2FR1vyUHkxZyVMl7aFJ/2Atcqu7361g==
X-Gm-Gg: ASbGncvU4qAlcwnEHNJ66F9jIuf1MxrAgKiil/oW1/HKCEAShYYceu9p++6NYYHDS7O
	J9k1Dvbn7D76mOxZKP/32vBqMNnZZp5TlRe66iqf/g/CG9QaHeAnrh1e02AqTKkK5hLJCgBXvX0
	B6BaR7z3kebHUV/9+x71faZ4kzQ9nz9u71V0Q2MgfbOGINc/3B3tUcifMRJ7bt1ViNbeaijU20z
	YtThnO3Vvn3zJ4sltxRQNtqHP+0Oln/RQm516E9eIjeHYRNP5h9WcQgBFazH8tc43FiZ3P4S0EY
	gb0zlzirO3x4nS4rDZZqBTxEyVb058+Z7E1oH9jGpXQHtaWxnDspTQGxnGX7CSkPIrJyd/ThkLK
	BwnnX44MpnC8kfgLwYE/w0t6NVTGM8yRtV+GJCr+k
X-Google-Smtp-Source: AGHT+IFCgaPwB1AZFWs6YC+/QsEhL0kuUZgRKMZPd5F6euzOV99R5UJHdxfe/uF0njZacaSk+zP97g==
X-Received: by 2002:a17:903:2385:b0:246:80ef:87fc with SMTP id d9443c01a7336-24944af38c7mr101747845ad.45.1756755656416;
        Mon, 01 Sep 2025 12:40:56 -0700 (PDT)
Received: from localhost ([77.111.118.146])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24905da470dsm112384625ad.89.2025.09.01.12.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 12:40:55 -0700 (PDT)
From: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sonic.zhang@analog.com,
	vapier@gentoo.org,
	dan.carpenter@linaro.org,
	Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Subject: [PATCH v5] staging: iio: adc: ad7816: fix race condition in SPI operations
Date: Mon,  1 Sep 2025 23:10:43 +0330
Message-ID: <20250901194043.20366-1-moahmmad.hosseinii@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7816 driver lacks proper synchronization around SPI operations
and device state access. Concurrent access from multiple threads can
lead to data corruption and inconsistent device state.

The driver performs sequences of GPIO pin manipulations followed by
SPI transactions without any locking. Device state variables (mode,
channel_id, oti_data) are also accessed without synchronization.

This bug was found through manual code review using static analysis
techniques. The review focused on identifying unsynchronized access
patterns to shared resources. Key indicators were:
- GPIO pin state changes followed by SPI operations without atomicity
- Shared state variables accessed from multiple sysfs entry points
- No mutex or spinlock protection around sections
- Potential for interleaved execution in multi-threaded environments

The review methodology involved tracing data flow paths and identifying
points where concurrent access could corrupt device state or SPI
communication sequences.

Add io_lock mutex to protect:
- SPI transactions and GPIO sequences in read/write functions
- Device state variables in sysfs show/store functions
- Concurrent access to chip configuration

This prevents race conditions when multiple processes access the device
simultaneously through sysfs attributes or device file operations.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")

Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>

---
Changes in v5:
- Rebased on top of latest staging tree
- Dropped unrelated cleanups (sysfs_emit, sysfs_streq, type casts, etc.)
- Keep only the mutex locking for SPI and GPIO access
---
 drivers/staging/iio/adc/ad7816.c | 59 +++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 4774df778de9..669572c04181 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -50,6 +50,7 @@ struct ad7816_chip_info {
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
+	struct mutex io_lock;	/* Protects SPI transactions and GPIO toggling */
 };
 
 enum ad7816_type {
@@ -67,13 +68,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	int ret;
 	__be16 buf;
 
+	mutex_lock(&chip->io_lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI channel setting error\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 	gpiod_set_value(chip->rdwr_pin, 1);
 
 	if (chip->mode == AD7816_PD) { /* operating mode 2 */
@@ -92,13 +93,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
 	ret = spi_read(spi_dev, &buf, sizeof(*data));
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI data read error\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	*data = be16_to_cpu(buf);
 
+unlock:
+	mutex_unlock(&chip->io_lock);
 	return ret;
 }
 
@@ -107,12 +108,13 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
 
+	mutex_lock(&chip->io_lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &data, sizeof(data));
-	if (ret < 0)
-		dev_err(&spi_dev->dev, "SPI oti data write error\n");
 
+	mutex_unlock(&chip->io_lock);
 	return ret;
 }
 
@@ -122,10 +124,16 @@ static ssize_t ad7816_show_mode(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	int ret;
 
+	mutex_lock(&chip->io_lock);
 	if (chip->mode)
-		return sprintf(buf, "power-save\n");
-	return sprintf(buf, "full\n");
+		ret = sprintf(buf, "power-save\n");
+	else
+		ret = sprintf(buf, "full\n");
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
 }
 
 static ssize_t ad7816_store_mode(struct device *dev,
@@ -136,6 +144,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
+	mutex_lock(&chip->io_lock);
 	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
@@ -143,6 +152,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 		gpiod_set_value(chip->rdwr_pin, 0);
 		chip->mode = AD7816_PD;
 	}
+	mutex_unlock(&chip->io_lock);
 
 	return len;
 }
@@ -168,8 +178,13 @@ static ssize_t ad7816_show_channel(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	int ret;
 
-	return sprintf(buf, "%d\n", chip->channel_id);
+	mutex_lock(&chip->io_lock);
+	ret = sprintf(buf, "%d\n", chip->channel_id);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
 }
 
 static ssize_t ad7816_store_channel(struct device *dev,
@@ -200,7 +215,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&chip->io_lock);
 	chip->channel_id = data;
+	mutex_unlock(&chip->io_lock);
 
 	return len;
 }
@@ -272,18 +289,23 @@ static ssize_t ad7816_show_oti(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-	int value;
+	int value, ret;
 
+	mutex_lock(&chip->io_lock);
 	if (chip->channel_id > AD7816_CS_MAX) {
 		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
-		return -EINVAL;
+		ret = -EINVAL;
 	} else if (chip->channel_id == 0) {
 		value = AD7816_BOUND_VALUE_MIN +
 			(chip->oti_data[chip->channel_id] -
 			AD7816_BOUND_VALUE_BASE);
-		return sprintf(buf, "%d\n", value);
+		ret = sprintf(buf, "%d\n", value);
+	} else {
+		ret = sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
 	}
-	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
 }
 
 static inline ssize_t ad7816_set_oti(struct device *dev,
@@ -322,7 +344,9 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	if (ret)
 		return -EIO;
 
+	mutex_lock(&chip->io_lock);
 	chip->oti_data[chip->channel_id] = data;
+	mutex_unlock(&chip->io_lock);
 
 	return len;
 }
@@ -363,6 +387,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	dev_set_drvdata(&spi_dev->dev, indio_dev);
 
 	chip->spi_dev = spi_dev;
+	mutex_init(&chip->io_lock);
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
 
-- 
2.43.0


