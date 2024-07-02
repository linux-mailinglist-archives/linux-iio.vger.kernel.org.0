Return-Path: <linux-iio+bounces-7130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D24923E28
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B89B210EB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFC16C6A2;
	Tue,  2 Jul 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U99sVV+o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD041158DC8
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924787; cv=none; b=ujtjG2rKsahyAEV50H3xZGNzJJWESIXKUOtAxEkkvazwm6btyAK/uDq06RNGbKQT4RBiV0tqq7Ul8J+s9lkyl5z2WteGB8l2z2STrp4V2lTftHw0g5hqmihRVKEJoS1j8IChEI7SV1Wd1zncsnnMujOQeh+vFoj0+a/Kq03ae4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924787; c=relaxed/simple;
	bh=EE9VMssCnR5r1SJkLPOTxAxdyk/ynSBn2ejlAazK20g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PbBCPF50j9DozoC8Rky7ttkUvwcx2fMpZlkNK5YNSoUq4WP4cfygPyP2fTb5Vfpq3EDPwm8xj8EJFm/azd76a/M2K4+eAzTrKjwqSi4dqPJ5FdNusGC7USPhkLUTsfyy0wAN6UbTiTx1qaipk4EXpAUcmngm4y9244mSKTtsMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U99sVV+o; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367601ca463so2383622f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719924782; x=1720529582; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TzqRvuDLH0pBN0onOuhawPxbUBxlc5j7kY4fNlDza2k=;
        b=U99sVV+oJCvjoxmDVLZ9ODC/kHDOFl5H3zUn0cK/yceDnZH2yKyVcfOTaquEsaF1cx
         NZda/rrPWRlUsLW5ewOqvbQPSFdu6h2QI1Iir/HuHbTuT6zk5qAjnKFLkqv6PP4aXQaf
         Pg/7YdmXZtscZ5J0DVrqn/wLSJS9iubTXrKtMtdVH/hAxP57LVqNDt06XhIgZicr7zUL
         Pxqa2XcEJ1xz1efxGa4mK86h75l1Luvx9BPZkO2lBLyaM8XcMR+t1Ee7yM4u7R/X4ehE
         Hf5f2WWsOUcEB282Oe2lQ7B2UI59NVJKB/vBNl+fgAoFA5QAv5usvpuCyqje/5IpEMKg
         HjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719924782; x=1720529582;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzqRvuDLH0pBN0onOuhawPxbUBxlc5j7kY4fNlDza2k=;
        b=ELzngvRRaCl5yi+fVh+/gSoTjEJqHVclrQYYnTeJG55BObASq/W+2LLmdCQkJ+SVCI
         J23n7vu8/07JZoNXg3kvfL8G7WHdpXoO826XEJqyqbz+EC31Dg5Rpa4rpAUMTv52vZXK
         4KKtUltkbUHEbUJTdFRyy8ilN0wcszPTQQXtPCRSZiltk9AxGv8rJ+heDwuMPUaD25e2
         oImYl5yRL/KdbeEoT2SG8b0CzvGDybZOZMPUwCbgiCA72ZrlT7Y87A0G6GCLWlPe077D
         l/6jiaLAzIfI6JZwanl7/LNcSPIDq+lEGL3XD1hfcMzR12rrquTIkuy/nZj7y1plvFCH
         CTcA==
X-Gm-Message-State: AOJu0YzOLDsJ4GNQGRpvFXBZYvefRXYFLAgESB1iPhywtMxlOD2aXtNd
	3RaFGjv3g9MH+klfJUuAwzqS0zr/DRYn9VgjbBsC4C0in0EdmUcqDAxwg7CFock=
X-Google-Smtp-Source: AGHT+IFdY57KtbrSnjYiE9ePTLLZUjyexs3HjSholeijR4GbHb11DetPRQQxPAzH4tDgaabHTWXYrg==
X-Received: by 2002:adf:f550:0:b0:35f:2c43:8861 with SMTP id ffacd0b85a97d-367757282e8mr4654577f8f.66.1719924782036;
        Tue, 02 Jul 2024 05:53:02 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103e44sm13142858f8f.107.2024.07.02.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:53:01 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 02 Jul 2024 12:52:51 +0000
Subject: [PATCH v3] iio: adc: ad7606: remove frstdata check for serial mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-cleanup-ad7606-v3-1-18d5ea18770e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACP4g2YC/2XM3QqCMBjG8VuRHbfY+6ZTO+o+ooN9vObAVLYai
 XjvTSECO/w/8PxmFsg7CuyczcxTdMENfYrTIWOmVf2duLOpGQrMRQ6Sm45U/xq5sqUUkoMEQrJ
 1BZVm6TR6atx7A6+31K0Lz8FPmx9hXb9UuacicOCFQYW1lGiEumg1dU57OprhwVYt4k+QUP0Jm
 AQtGiugKCqp9sKyLB/jU42v8QAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@cam.ac.uk>, 
 Michael Hennerich <michael.hennerich@analog.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com, Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.0

The current implementation attempts to recover from an eventual glitch
in the clock by checking frstdata state after reading the first
channel's sample: If frstdata is low, it will reset the chip and
return -EIO.

This will only work in parallel mode, where frstdata pin is set low
after the 2nd sample read starts.

For the serial mode, according to the datasheet, "The FRSTDATA output
returns to a logic low following the 16th SCLK falling edge.", thus
after the Xth pulse, X being the number of bits in a sample, the check
will always be true, and the driver will not work at all in serial
mode if frstdata(optional) is defined in the devicetree as it will
reset the chip, and return -EIO every time read_sample is called.

Hence, this check must be removed for serial mode.

Fixes: b9618c0cacd7 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Changes in v3:
- Improve commit message.
- Add Fixes tag: the fixes tag is the initial commit since the issue
  have been there from then on, probably overlooked because removing
  frstdata from DT solved the issue.
- Remove extra linebreak.
- Link to v2: https://lore.kernel.org/r/20240618-cleanup-ad7606-v2-1-b0fd015586aa@baylibre.com

iio: adc: ad7606: remove frstdata check for serial modei

Changes in v2:
 - Remove frstdata check only for the serial interface as suggested by
   Michael Hennerich.
 - Link to v1: https://lore.kernel.org/r/20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com
---
 drivers/iio/adc/ad7606.c     | 28 ++------------------------
 drivers/iio/adc/ad7606.h     |  2 ++
 drivers/iio/adc/ad7606_par.c | 48 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 29 deletions(-)

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
index d8408052262e..6bc587b20f05 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -7,6 +7,7 @@
 
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/err.h>
@@ -21,8 +22,29 @@ static int ad7606_par16_read_block(struct device *dev,
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
+	insw((unsigned long)st->base_address, _buf, num);
 	return 0;
 }
 
@@ -35,8 +57,28 @@ static int ad7606_par8_read_block(struct device *dev,
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


