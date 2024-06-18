Return-Path: <linux-iio+bounces-6489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F73590D381
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DE7284E75
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA31514F4;
	Tue, 18 Jun 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kTMKmF/u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005A18EFC4
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718310; cv=none; b=dMANZYOStsyhqd2d6ihFNf+17/DbPYuDI+GN8K9cODYcxTeKyoOJKA2wY1Pl2/tHDTkdjB3Yjhzf7MEHodF9OuklLdfJJ+53ZJaxoAFBlvC+PjCLL6mMMzFJ+F0CPBSH4fyvXJH33RGKipBO5wGCRjHJfDNcydre8ardeYnGi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718310; c=relaxed/simple;
	bh=ae4pwjFhUlQcrVR7mQTgRv94AhEmxr16sF6IEJpjbGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SzKNNOhMOrBD8Yt1XI5Xbnhl65JhmPDfZ6Gv3eD0bY4bTTG/J3ATNrOE4lPdPLjl2FBEgTbf53TgA+EZzTTxDOkz60h7BDAiMatvkXeTXEYo9oJvJtc+OSAroIoVmNn2rJFlTPFL51vBk8x711JnE4mSbh7KmycxZLV7qLWBM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kTMKmF/u; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so65034271fa.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 06:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718718307; x=1719323107; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmejdlmDlKHI06rCiq7kfLWivv1c0iup9shJzGhfZyM=;
        b=kTMKmF/unm1iy5Dc+sTket50eoAUbQ/ssmcEE+Pfr73E8I22m+cTxJ9eGdR1QTfn6e
         OQrRffwW9wOXsAFZdEtqQzOEWAGV/M+u+4I19gQ0XU3BOcVmvACppYDrRxBaBOvOjLYp
         cV+s/ytz1HbPodug8aq7+nLJ/aDspJM8OkFJ6iMdEKF6Z67kH/B34Ktqh+it5b6FL0V+
         QqtvokY5yes0K8xvVC2LRmHBG1FxdJw5LJb+85CPOIKtjbiXfq9U/1Y21yU6QqZfkYXZ
         kboHV5/jfkPhVMZaiFSoyt/eZ/1Z5QoZv9B5PtH6QBWlu7ClMhewTuwGQjXc1eYGokG5
         9DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718307; x=1719323107;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmejdlmDlKHI06rCiq7kfLWivv1c0iup9shJzGhfZyM=;
        b=DBWVPN9x7GMYHRb3nrC9hvjFqUbgST5qVLHKvcaipSFWJRRebKjEhe1QXuX1surwgk
         o74i/gqSLgdSf+77Alp4rQX37r67AZ9ZVbyxLCqg5GEtphyFHdtlvxb1RXaz2dmpxQzV
         NgvD2LBIH6GlTcmjvhRuHrZsDogmfcvlKtJnYuZFa/nseF6eP24BzUWRyoHLyF5c7ry9
         Aibfx57RELm/yeRddkdKhgramIwnHNqWJW7NoLKTeJcr9K8G/CWHnuHyDHthAqpwyVIh
         wJlmeUxNs1R0jzxk2CnWuh3ycOsGdv2fxZxeWnw8KZgT85cRUOBDSXrSwdsLVfgKoQF0
         OFkA==
X-Gm-Message-State: AOJu0Ywq52IGFISAK9RRgtO8XEbW7xRRcATHN1PqAKAa62PreVC7mZ9V
	fsS/DYrKWvywZ8FulLRisjMEbzksDrQb9B3uXh381IimBa4hZ2PeHNy83iC8fic=
X-Google-Smtp-Source: AGHT+IHcoXJP3gEa+WaQYbFLEmPnvIPyvgKbTmvBrMFHfdFfqDYyn76MEt5EBTgP2Xe0lQpJygXuEg==
X-Received: by 2002:a05:651c:c1:b0:2ec:3cc6:e156 with SMTP id 38308e7fff4ca-2ec3cc6e17amr420021fa.50.1718718304493;
        Tue, 18 Jun 2024 06:45:04 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8d8sm14160147f8f.32.2024.06.18.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:45:04 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 13:45:00 +0000
Subject: [PATCH v2] iio: adc: ad7606: remove frstdata check for serial mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v2-1-b0fd015586aa@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFuPcWYC/13MQQ6CMBCF4auQWVvTmWABV97DsCjtKJMgkFYbC
 eHuVhI3Lv+XvG+FyEE4wrlYIXCSKNOYgw4FuN6Od1bicwNpKnWJRrmB7fialfWV0UahQSb2TY1
 1B/k0B77Jewevbe5e4nMKy+4n/K4/qvqnEipUJ0eWGmPIaXvp7DJIF/jopge027Z9AG3Is5qvA
 AAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jstephan@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718718304; l=5944;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=ae4pwjFhUlQcrVR7mQTgRv94AhEmxr16sF6IEJpjbGg=;
 b=UFHUE5RnD+Ur1KhALafDx0bqfNAbkQsQkxH64MYMSYGUORjK+ET2QDnqADfUI0UmPjBlXyHqd
 X5JQ/hyS94wCJ0gmqDESOfgMXIJpWCN0AmbvP5Dapgg5UbaFPtV+XGy
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Frstdata pin is set high during the first sample's transmission and then
set low.  This code chunk attempts to recover from an eventual glitch in
the clock by checking frstdata state after reading the first channel's
sample.  Currently, in serial mode, this check happens AFTER the 16th
pulse, and if frstdata is not set it resets the device and returns EINVAL.
According to the datasheet, "The FRSTDATA output returns to a logic low
following the 16th SCLK falling edge.", thus after the 16th pulse, the
check will always be true, and the driver will not work as expected.  Thus
it must be removed for serial mode.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Changes in v2:
 - Remove frstdata check only for the serial interface as suggested by
   Michael Hennerich.
 - Link to v1: https://lore.kernel.org/r/20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com
---
 drivers/iio/adc/ad7606.c     | 28 ++-----------------------
 drivers/iio/adc/ad7606.h     |  2 ++
 drivers/iio/adc/ad7606_par.c | 49 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3a417595294f..c321c6ef48df 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -49,7 +49,7 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
-static int ad7606_reset(struct ad7606_state *st)
+int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
 		gpiod_set_value(st->gpio_reset, 1);
@@ -60,6 +60,7 @@ static int ad7606_reset(struct ad7606_state *st)
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
 
 static int ad7606_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
@@ -88,31 +89,6 @@ static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels - 1;
 	u16 *data = st->data;
-	int ret;
-
-	/*
-	 * The frstdata signal is set to high while and after reading the sample
-	 * of the first channel and low for all other channels. This can be used
-	 * to check that the incoming data is correctly aligned. During normal
-	 * operation the data should never become unaligned, but some glitch or
-	 * electrostatic discharge might cause an extra read or clock cycle.
-	 * Monitoring the frstdata signal allows to recover from such failure
-	 * situations.
-	 */
-
-	if (st->gpio_frstdata) {
-		ret = st->bops->read_block(st->dev, 1, data);
-		if (ret)
-			return ret;
-
-		if (!gpiod_get_value(st->gpio_frstdata)) {
-			ad7606_reset(st);
-			return -EIO;
-		}
-
-		data++;
-		num--;
-	}
 
 	return st->bops->read_block(st->dev, num, data);
 }
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 0c6a88cc4695..6649e84d25de 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -151,6 +151,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops);
 
+int ad7606_reset(struct ad7606_state *st);
+
 enum ad7606_supported_device_ids {
 	ID_AD7605_4,
 	ID_AD7606_8,
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index d8408052262e..1f7050297b64 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -7,6 +7,7 @@
 
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/err.h>
@@ -21,8 +22,30 @@ static int ad7606_par16_read_block(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	insw((unsigned long)st->base_address, buf, count);
 
+	/*
+	 * On the parallel interface, the frstdata signal is set to high while
+	 * and after reading the sample of the first channel and low for all
+	 * other channels.  This can be used to check that the incoming data is
+	 * correctly aligned.  During normal operation the data should never
+	 * become unaligned, but some glitch or electrostatic discharge might
+	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
+	 * allows to recover from such failure situations.
+	 */
+	int num = count;
+	u16 *_buf = buf;
+
+	if (st->gpio_frstdata) {
+		insw((unsigned long)st->base_address, _buf, 1);
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+		_buf++;
+		num--;
+	}
+	insw((unsigned long)st->base_address, _buf, num)
+;
 	return 0;
 }
 
@@ -35,8 +58,28 @@ static int ad7606_par8_read_block(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
-
-	insb((unsigned long)st->base_address, buf, count * 2);
+	/*
+	 * On the parallel interface, the frstdata signal is set to high while
+	 * and after reading the sample of the first channel and low for all
+	 * other channels.  This can be used to check that the incoming data is
+	 * correctly aligned.  During normal operation the data should never
+	 * become unaligned, but some glitch or electrostatic discharge might
+	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
+	 * allows to recover from such failure situations.
+	 */
+	int num = count;
+	u16 *_buf = buf;
+
+	if (st->gpio_frstdata) {
+		insb((unsigned long)st->base_address, _buf, 2);
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+		_buf++;
+		num--;
+	}
+	insb((unsigned long)st->base_address, _buf, num * 2);
 
 	return 0;
 }

---
base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
change-id: 20240416-cleanup-ad7606-161e2ed9818b

Best regards,
-- 
Guillaume Stols <gstols@baylibre.com>


