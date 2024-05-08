Return-Path: <linux-iio+bounces-4893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F118C020E
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44ACFB20F85
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809627490;
	Wed,  8 May 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSRHonki"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D3E55F;
	Wed,  8 May 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186087; cv=none; b=WK/PATcsh6cOobspPu3q/3km5A73Fyd+wIizNYw0jW8iDmFFfE0H/QNJ7wRzSVjMa9FarbcKEbHtt7dQ38pbyuQ0lGwfFp1PJgISOQCOBSZhN2ljFaBbfzvItgzxZchcvzc9fIs3LwY8MyYQI+7ZNxocI+fgAbm9ZSRdiQ0Xe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186087; c=relaxed/simple;
	bh=RUOtUFnW8ChSXMgwth8WNDNb75HQGYJgeK9h4E9SasA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqgNRWQFhpwYdYS2hPFkbrnTdlww3T1qRAsPX5IVIESikB5LnD3xWY/v1VCaulBuwZ1aFFJ+WXTw57W0zI2a1GAf6ZyMGOCAPYcmHZ3YTS66FJ4SnpRf9gYdft7+b7canM8kdKMBsgsu71l0ErAbK1DcGYTPJUIamFDLIqd6hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSRHonki; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cf8140d0so928425166b.3;
        Wed, 08 May 2024 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186084; x=1715790884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KA3zpKyTxe2e1SQOppyNPxR6Rc9RiQDW4XxAk2Kknk=;
        b=iSRHonkiDA11jie/9kjAqzp2OpbozUH5cZ/rx+8UBKrVRnMLn58DhY3tkP02ceZfpY
         hRRnYTrcUUMaxNsFlS4KxgjXEvYwiRIik18MwZ0Emz+AtaAN6K1Wgm0KPZ/iFrDiX9+w
         //SO+a9NghzPprt9NqLQV+QebUe4ffI30EgM9S2EBmjTd1JPy3eM4/HyhmsYApIIQOi9
         K5QRxC/lclZDrSQChNFsayQ9TNwGwwOCkzk22OHB5unl87dQ3c35sFacHihGCFoHuf8b
         iksXB90Nuyfd0Kpomr1B/uFoGeZNXEP9mIgVl2Ng61aPk1kiXswZl7Tki9VOnJR2DiZw
         /OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186084; x=1715790884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KA3zpKyTxe2e1SQOppyNPxR6Rc9RiQDW4XxAk2Kknk=;
        b=MK2UWgfJXw6089TvD0ur5ie5CPB8nBtStBSBfObuLaLLJ/nnYRpdL2w1G2/xxJ8wMf
         uJZmVfy2c+h4mPmA2/Lc9PRerT6kXLP96eVxyJk5F8z0HB/WkGaUcRtU0HMt6MymX2z2
         5ZT7pNbZzXcga8gchuuP83/hb1mo9It7UBsbaQOjO0NFxJ9Rfmh9SkLXyAy/FxTqjOVZ
         re2+0roq1J6P7kb000rHvWhlT8vu4WNlJiKQAl3L1Te9j3lb4st849EO6kqj2YFyGBrz
         Ni8q3E3TYPvEruQan2XK9zMgo4kb4pJUNu/AnQaD4LxgDmDUC6Z5KKmrgB6D/cDetJ8K
         sN1A==
X-Forwarded-Encrypted: i=1; AJvYcCVgpEqwmMzi5tDSejs5L12VBGUg4C1XhiN2OmpETFre2UBLT7gjezYQJIKkMeY1nTG1E75ewZamwbefJTAlv2KOW8ggZsd7UYUXW/vbJtyiAN/0NJifVUZPFj9pdMrrlt0MGUtDLNxj
X-Gm-Message-State: AOJu0Ywdxqcvcz8HOHntEbMTWa8CQ8iFM4VLkwR0WQAIedEUIGfYJ4oz
	I/MlaiJtyx5954hBnBg0/h73nLd6AjcTlBvt7WMXK2ajcCpgD5/m
X-Google-Smtp-Source: AGHT+IESNX6rspD7HgKicJY4JlAUuIRaCsKxX/trK+hYMAqr0/DPkaWs8GXp6YRyYlAlPN2GOBnWiw==
X-Received: by 2002:a17:906:3c07:b0:a59:a38c:557a with SMTP id a640c23a62f3a-a59fb82785cmr202504866b.11.1715186083785;
        Wed, 08 May 2024 09:34:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:43 -0700 (PDT)
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
Subject: [PATCH 6/9] iio: pressure: bmp280: Introduce new cleanup routines
Date: Wed,  8 May 2024 18:34:22 +0200
Message-Id: <20240508163425.143831-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508163425.143831-1-vassilisamir@gmail.com>
References: <20240508163425.143831-1-vassilisamir@gmail.com>
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


