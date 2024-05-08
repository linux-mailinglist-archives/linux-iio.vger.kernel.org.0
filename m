Return-Path: <linux-iio+bounces-4902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5348C0254
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C31C21D9F
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDDA12BEB7;
	Wed,  8 May 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gITznSvY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53102D53C;
	Wed,  8 May 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187148; cv=none; b=XvhMqIXNUXhVlx+ZaM9c4hHkezn+llKF4y8vP0hzltluiPDHSFVuM6cUuQAj+iRD0VPU9ob4LzMKTx3Vy1QptMZLj6gQXjhCxzPzehhKilZJw8WBdZQma6uMgVcWWNThkHXoMNono9E1ZLFs9k9EOEiPFbh6Y9z+qy5YNBWGIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187148; c=relaxed/simple;
	bh=RUOtUFnW8ChSXMgwth8WNDNb75HQGYJgeK9h4E9SasA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYMhvHMCaUjvkFSzoPSu6N6xh+9ehWI0fgoswVf2KOntlLO+49kurrzMoTAzRhOGiUPjP6oCmbKQHeAt6Wf6OISZ3yfwkQBynVRwM9viFoeO9hm9YUGOndNcWIaijF6iN3rGJe/Ro8f1BF40i2xrCOkRhlUJchq+ynZH8rLayx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gITznSvY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4702457ccbso1226449766b.3;
        Wed, 08 May 2024 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187145; x=1715791945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KA3zpKyTxe2e1SQOppyNPxR6Rc9RiQDW4XxAk2Kknk=;
        b=gITznSvY+XH2RUBdnQlI0hcYfZsIrYxl30aTLG3Gurx94hw7VRxBQCoJxhjK/olozn
         yufMA+lYnQkP0qUij3e9XXOWZc+gYm01oCToXCgMFcxxPii+EOzNmnzFLrner3K4xvLB
         z+mUCVhnYtddVH78w235uLGvvr2ZhEEXWgnU4sR1GKLt/2VJ+4P9L3efZ7Omm3b3zYw+
         xjZratu1vj5Zfq/MdDu8AG9DOiCRG9Mt333QajCOQpp+7SZExEw8oOkzfee3xt3awM6l
         VUadXWLIbiDsCDNDj1NnvOGx3vUN+2Lm3e1LaFMdVdV9G3PUlxEqeS43epwsjD0IiFal
         vAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187145; x=1715791945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KA3zpKyTxe2e1SQOppyNPxR6Rc9RiQDW4XxAk2Kknk=;
        b=NHjcjqcxiWu6g5m3Gp5iG+MatA4zxSqNANYYJYSqnFu47s6qblgxOqFJ2pOSbr2qJ7
         vFnRZgzqmCf6sLHBuwetH3+H7dIHBo4IwYbgBtJbJ3Cm89BvY5EASFbOsqjlsHcmMmHn
         odo3j/I/DpU0rAIx3QrBGmtRfugv0lvcAe03ecsqXDDUngR5A6cvQX/hXqhorJMivUSl
         AyowibegGF2owvWz0jnzPpGdiahrKoWt/p4pP1BMNtghtSGx8h2avjbxAn4WDGpdeAdC
         lAjhHU93+chaYUJZz1+7IoV5pkiW4LHADAa/Ar5wavLda6ATdCz4+aPChREHO37aiCAf
         MAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAmlxRJAxI9+m7iMDniERk6KSkxN9rP5Vh5fu1p+LjCHu1ySsl9TYwru13iuXtJRPOwwq4AY1DNOMpzTW9tleyzSJmMh8aCv8FfNOviqICIImwt9ySrEOO4OMstsJ82QAbCF6sCpuI
X-Gm-Message-State: AOJu0YwDhjFIobJRxxJXx80/FHiL4ybjzwoVh6HP9cMqyw40+Jk6bdFV
	J32L0AlWybnXCqGQGTyFyibESOw/EME5ma0d3/ZzbW6NSrUXcPbU
X-Google-Smtp-Source: AGHT+IF8zT7nCu7udUnbMJpkwjkOdbK+sJNqFOyMX21Gx4Kp1puFetSE58WlomygUQ7MzFuMI0GwwA==
X-Received: by 2002:a17:906:c444:b0:a59:c28a:7ec2 with SMTP id a640c23a62f3a-a59fb95dc67mr183599966b.41.1715187144763;
        Wed, 08 May 2024 09:52:24 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00a59a8212c8esm5648010ejc.42.2024.05.08.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:52:23 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
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
Subject: [PATCH v6 6/9] iio: pressure: bmp280: Introduce new cleanup routines
Date: Wed,  8 May 2024 18:52:04 +0200
Message-Id: <20240508165207.145554-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508165207.145554-1-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 131 ++++++++++++-----------------
 1 file changed, 56 insertions(+), 75 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a864f8db8e24..eed356bcf8a2 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,6 +27,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -508,77 +509,67 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
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
 
@@ -710,12 +701,13 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
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
@@ -725,45 +717,36 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
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
+			 struct iio_chan_spec const *chan,
+			 int val, int val2, long mask)
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
@@ -1564,7 +1547,7 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 	int ret, addr;
 
 	pm_runtime_get_sync(data->dev);
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/* Set sensor in standby mode */
 	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
@@ -1606,7 +1589,6 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 exit:
 	/* Restore chip config */
 	data->chip_info->chip_config(data);
-	mutex_unlock(&data->lock);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 	return ret;
@@ -1620,7 +1602,7 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 	int ret, addr;
 
 	pm_runtime_get_sync(data->dev);
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/* Set sensor in standby mode */
 	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
@@ -1671,7 +1653,6 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 exit:
 	/* Restore chip config */
 	data->chip_info->chip_config(data);
-	mutex_unlock(&data->lock);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 	return ret;
-- 
2.25.1


