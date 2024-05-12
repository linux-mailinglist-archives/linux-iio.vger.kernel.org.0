Return-Path: <linux-iio+bounces-5000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E378C391E
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 01:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3401C20E0A
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A15C60D;
	Sun, 12 May 2024 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8XMEsVy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467159148;
	Sun, 12 May 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555136; cv=none; b=gl+c5Jx0T5J7tw6T/piJriuZT5u/B3VGCPSXGf8/Kr/AvkO/rnput+DwwsK//yTuD57BrqSeDKEri+SVUzSYFvgNtPprLXHYEYVGiO0JpyehPzaJAXYUguZtc3mN4IBO31SEl66+gVPtZ9F4pxVeVlrc2hT4JZQo0+86GBTL+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555136; c=relaxed/simple;
	bh=ecr+D/KdMsZ+2Z+tLcPyFkvTpc0+kiSIh9a6Pd1sdmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBJHl44R/kKK8ZK9OtLDs/ELKIv6p0oSaN8H/Lz9qsUH4qiGH8B78tHTLXYVFgoHoLPLFVkgX8A68Dlz9MJrT/rx0H06nPTGj6pj4VMHU58R4e3ahJpYP1ZE6IaSejMWXWoSEXF+Hx3vAjKFA6xUMd5z0shC8RRPRuVY7U50IN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8XMEsVy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so37932085e9.0;
        Sun, 12 May 2024 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715555132; x=1716159932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18E3ypEpr52xpdOzzJYFX/dWbCwtzRXs2hQ9dkP7Kow=;
        b=J8XMEsVyuIOcSBbHF9ThCShVSSZdaKFWCCemX5J1Tf7fM4FueZ3JC/FKggg+THkTSA
         MHBNRBpsbnmYOjRxuyx0jn3EPpPB5ie50kKXZyOOSu3ehHn0ebEyaaOCsAvA2IepOzca
         7y6Xg8M3Jc/gOWpteycfmpsNMxjDnh4hTP7aumUxuRccpKt6NtbDxkloIt23eDrpX6yf
         2e5YlEt3jTwmEk4DO0NV7oDodXbsXNgY/NujsjtTB56TkD0LojZ4WfRmwC6PJL560qeH
         myx4GzfNJtUcIyNAYLF2SORGeu9gCKgCFOc//ixKreS5uhZQhYrw5nE2uhr0yp68mu4e
         2PzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715555132; x=1716159932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18E3ypEpr52xpdOzzJYFX/dWbCwtzRXs2hQ9dkP7Kow=;
        b=ZQ1bPkAGHULU6jYf3UE2GLIUi/f4jp0yXU2mfI6vkZE/ba9xzVcMtyS/Q3VpkO05N0
         3tAlRI6vp5uRMzbPX65U3g4mcjBoevU71e9pELLF3oZMO75M7jc/Enx04kWCQqjFDaqQ
         rgQprsbbPDfZ0OkFIMMFY+VjBkljUr2dZbeCylRraUq2T0mohkIJrrc4AQkLntb2kOJO
         vc6DG0JeL7UhMZihieqCqe199elbY9vpni93W1I+PQZcc3/elMkV2Gn30vDCU824cZhx
         Yer4t8N4H572rmawKUa1C9Imia6EokoO1bQwdHZMr7uDTloBLk0wuAG15G8ZD/ySMm+K
         bycw==
X-Forwarded-Encrypted: i=1; AJvYcCUxm1NX/9G4ZLA6AaQgNKAL8V6K/X+r4/sz4H4zKoag/nRL9DSPPEYkBmT6qvcqY84I9jbWFZwLrAkQTwpch2b57kxYXCvGvesIYVVyRDva2i9WyloJr7fO9G8uvi8edgjjLTqVuugP
X-Gm-Message-State: AOJu0Yz025ISSr4MKe6J2DPv1+X6iV6+K+LsSNzrNlpQf2TworE3Rgkc
	KRRuZy0OtKuaanaRrXhKb5ZII/shHBFQyRL4IrHimebpREyVt/Fc+nzVF8vA
X-Google-Smtp-Source: AGHT+IGwK5Dggyur85FCz1hfg1fktI0QoTk/7K14zansM/q4FsoFu0ik1XQFPsNIafK8G08lnm899A==
X-Received: by 2002:a05:600c:5116:b0:41b:fa34:9e48 with SMTP id 5b1f17b1804b1-41feac55e26mr74534025e9.30.1715555132514;
        Sun, 12 May 2024 16:05:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:ce14:864c:436e:5c6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm136720935e9.36.2024.05.12.16.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 16:05:31 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 2/5] iio: pressure: bmp280: Introduce new cleanup routines
Date: Mon, 13 May 2024 01:05:21 +0200
Message-Id: <20240512230524.53990-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512230524.53990-1-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce new linux/cleanup.h with the guard(mutex) functionality.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 166 +++++++++++++++--------------
 1 file changed, 84 insertions(+), 82 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 58f3aaaa1efe..212583d35350 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,6 +27,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -505,77 +506,67 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	return IIO_VAL_INT;
 }
 
-static int bmp280_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret;
 
-	pm_runtime_get_sync(data->dev);
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = data->chip_info->read_humid(data, val, val2);
-			break;
+			return data->chip_info->read_humid(data, val, val2);
 		case IIO_PRESSURE:
-			ret = data->chip_info->read_press(data, val, val2);
-			break;
+			return data->chip_info->read_press(data, val, val2);
 		case IIO_TEMP:
-			ret = data->chip_info->read_temp(data, val, val2);
-			break;
+			return data->chip_info->read_temp(data, val, val2);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
 			*val = 1 << data->oversampling_humid;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_PRESSURE:
 			*val = 1 << data->oversampling_press;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_TEMP:
 			*val = 1 << data->oversampling_temp;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (!data->chip_info->sampling_freq_avail) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!data->chip_info->sampling_freq_avail)
+			return -EINVAL;
 
 		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
 		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		if (!data->chip_info->iir_filter_coeffs_avail) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!data->chip_info->iir_filter_coeffs_avail)
+			return -EINVAL;
 
 		*val = (1 << data->iir_filter_coeff) - 1;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
+
+static int bmp280_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
 
-	mutex_unlock(&data->lock);
+	pm_runtime_get_sync(data->dev);
+	ret = bmp280_read_raw_impl(indio_dev, chan, val, val2, mask);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -707,12 +698,13 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	return -EINVAL;
 }
 
-static int bmp280_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int bmp280_write_raw_impl(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret = 0;
+
+	guard(mutex)(&data->lock);
 
 	/*
 	 * Helper functions to update sensor running configuration.
@@ -722,45 +714,36 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	 */
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bme280_write_oversampling_ratio_humid(data, val);
-			break;
+			return bme280_write_oversampling_ratio_humid(data, val);
 		case IIO_PRESSURE:
-			ret = bmp280_write_oversampling_ratio_press(data, val);
-			break;
+			return bmp280_write_oversampling_ratio_press(data, val);
 		case IIO_TEMP:
-			ret = bmp280_write_oversampling_ratio_temp(data, val);
-			break;
+			return bmp280_write_oversampling_ratio_temp(data, val);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
-		ret = bmp280_write_sampling_frequency(data, val, val2);
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
+		return bmp280_write_sampling_frequency(data, val, val2);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
-		ret = bmp280_write_iir_filter_coeffs(data, val);
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
+		return bmp280_write_iir_filter_coeffs(data, val);
 	default:
 		return -EINVAL;
 	}
+}
+
+static int bmp280_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp280_write_raw_impl(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
 }
@@ -1550,15 +1533,14 @@ static const int bmp580_odr_table[][2] = {
 
 static const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
 
-static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
-			     size_t bytes)
+static int bmp580_nvmem_read_impl(void *priv, unsigned int offset, void *val,
+				  size_t bytes)
 {
 	struct bmp280_data *data = priv;
 	u16 *dst = val;
 	int ret, addr;
 
-	pm_runtime_get_sync(data->dev);
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/* Set sensor in standby mode */
 	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
@@ -1600,21 +1582,31 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 exit:
 	/* Restore chip config */
 	data->chip_info->chip_config(data);
-	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct bmp280_data *data = priv;
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp580_nvmem_read_impl(priv, offset, val, bytes);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
+
 	return ret;
 }
 
-static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
-			      size_t bytes)
+static int bmp580_nvmem_write_impl(void *priv, unsigned int offset, void *val,
+				   size_t bytes)
 {
 	struct bmp280_data *data = priv;
 	u16 *buf = val;
 	int ret, addr;
 
-	pm_runtime_get_sync(data->dev);
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/* Set sensor in standby mode */
 	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
@@ -1665,12 +1657,22 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 exit:
 	/* Restore chip config */
 	data->chip_info->chip_config(data);
-	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct bmp280_data *data = priv;
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp580_nvmem_write_impl(priv, offset, val, bytes);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
+
 	return ret;
 }
-
 static int bmp580_preinit(struct bmp280_data *data)
 {
 	struct nvmem_config config = {
-- 
2.25.1


