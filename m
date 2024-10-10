Return-Path: <linux-iio+bounces-10426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233599942D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD1DB22104
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E41EF0A1;
	Thu, 10 Oct 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsggJZEV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80C1EBA1F;
	Thu, 10 Oct 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594056; cv=none; b=gAa8ikynoQxKNYlfej0h0A7rLcrJyAu+DXI3eLoE0noHSbyfbSaML1L7DoWZskUif8/fC0U2pwvt896KirqCo72k5tvecYf5zIyT+NuSnv3b+xJZ+/CVgcQJeR9XeTrMMYfWZlFE/fuEk2q0T1SHgp1zymAeACZO6uTlq0vN8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594056; c=relaxed/simple;
	bh=Ro3vKVwG9OrFe7D9KeNbV4BcFPOnK3BB+dJZIDGABNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGTk4qpG5QPPdnQ1NAaBCTnuJbkfDqLN4LHxzVpnTyjwedk7D/PYhjGoJDibVAB04HxpVkU1S7v9g9JygQTR1M7W5cXODSaiVrEft8OYAN/sR/zZHqRuhx0MiZzfRtxTwK8aMMIwDUEa1jvdY70zJDQ4lLVpckipjePaewD3Q0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsggJZEV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53991d05416so1802772e87.2;
        Thu, 10 Oct 2024 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594052; x=1729198852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CdvgLs5EyJHbZgt0XAtnGGoYU5wfKc655jog4d69Is=;
        b=YsggJZEVSeiDAjAZ58NAVlKT7ZaVsPZa5yTsgIerTvx7ZcasnIyfPSDil/+5afR60F
         nJGGwTwXvmMjGDvhCMd1SeTQod/LAMjdb/ziOqNRH62fIpYo0TWwdQUIEWXx2eZIM2PR
         KpSC/gfA5Fxzl0qshHQDII5n31BuRxr8/n/x82+GfRXB4dhJRz2oZbzzJxkoUSrZ8oYZ
         /8RLbB9qL4zLRdDDTCLqFkgoqmrwp/BKJWbVcFAadQZsjrDQup8prUHxR6oHx05fbLEB
         1PauQ6K0yw6J2hfpjrDnlS5uI92ybsBY1sXXdyS88AOQpdtB1nQoSRj+d9Yct/JzeuAP
         G0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594052; x=1729198852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CdvgLs5EyJHbZgt0XAtnGGoYU5wfKc655jog4d69Is=;
        b=L99rBsbdwzhNjXcBd3xS7qsN/YMENSBtSnElBZ12+hJYyiaB8N1o901ahap+8dj4Up
         4okeGo6Azf46oDmBrFT78+EbSxlXuXraBNjvZMmp7yetFnNW+JZ7EId0ddzprujMlELE
         9vtyL7O5epZhrkGeqOnFfju5sKpyVRv+oKFf5KG+QmtMzUqTIspF2UJR5CuMuHJfjWg/
         UB5HiShw1wU1MVWRPcTtAVcXtS5X5QiKGl1drUzBQZUPnHzMlf5vaEe7voIeTyT53S9t
         9XAWXgisEaeBCv2n4xCNNJZ8q1R/sjpjRbyZu3Ef4/yGgo3DvrBPdW0dUhmenQmECA8O
         0pCA==
X-Forwarded-Encrypted: i=1; AJvYcCVTXwqNULTiEDFddqGLoWekMshLFzIIf5Nz61v6Yf506bbuPq5NxK4ehyyh6qca77sh1oUhYVjtYIWp@vger.kernel.org, AJvYcCX0M2L2J+p3UJolg8b6IWQ/JMa5p82lXEdTRUKXbbacF12osKKaxrwhCpamXVQoUIOTmhsdrOe4+nWR@vger.kernel.org, AJvYcCXeSTI2JFwnh9VGf0Nik2+QFYiFkIiNbd+OLSo4M9jfOMoedp1vGoIsXpkAiokI8MepNmU9FF+pZzyatoiK@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwxYnc8k8+oR2+MphPxVn9925aIcFk5IX/gWnkhqw5ayWTzFM
	rZibOsq2Zq/ukVHKDRib0WmI4y6Av5i5xoJArMikUF3SNCVAFrN5ZPUbG07t
X-Google-Smtp-Source: AGHT+IH4L2gJ42cSXuloYs3N4M3zCvTDsJLBQzoH7Qk61ueY6LwVwLS83bEg0pvjJXN8c6IFzkQL3Q==
X-Received: by 2002:a05:6512:1083:b0:539:8d9b:b61c with SMTP id 2adb3069b0e04-539da592814mr99256e87.51.1728594052062;
        Thu, 10 Oct 2024 14:00:52 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:51 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/13] iio: chemical: bme680: generalize read_*() functions
Date: Thu, 10 Oct 2024 23:00:27 +0200
Message-ID: <20241010210030.33309-11-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Remove the IIO specific scaling measurement units from the read functions
and add them inside the ->read_raw() function to keep the read_*() generic.
This way they can be used in other parts of the driver.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 65 ++++++++++++++++++------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 0979c8f0afcf..4669338ec2e5 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -661,22 +661,20 @@ static int bme680_gas_config(struct bme680_data *data)
 	return ret;
 }
 
-static int bme680_read_temp(struct bme680_data *data, int *val)
+static int bme680_read_temp(struct bme680_data *data, s16 *comp_temp)
 {
 	int ret;
 	u32 adc_temp;
-	s16 comp_temp;
 
 	ret = bme680_read_temp_adc(data, &adc_temp);
 	if (ret)
 		return ret;
 
-	comp_temp = bme680_compensate_temp(data, adc_temp);
-	*val = comp_temp * 10; /* Centidegrees to millidegrees */
-	return IIO_VAL_INT;
+	*comp_temp = bme680_compensate_temp(data, adc_temp);
+	return 0;
 }
 
-static int bme680_read_press(struct bme680_data *data, int *val, int *val2)
+static int bme680_read_press(struct bme680_data *data, u32 *comp_press)
 {
 	int ret;
 	u32 adc_press;
@@ -690,15 +688,14 @@ static int bme680_read_press(struct bme680_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	*val = bme680_compensate_press(data, adc_press, t_fine);
-	*val2 = 1000;
-	return IIO_VAL_FRACTIONAL;
+	*comp_press = bme680_compensate_press(data, adc_press, t_fine);
+	return 0;
 }
 
-static int bme680_read_humid(struct bme680_data *data, int *val, int *val2)
+static int bme680_read_humid(struct bme680_data *data, u32 *comp_humidity)
 {
 	int ret;
-	u32 adc_humidity, comp_humidity;
+	u32 adc_humidity;
 	s32 t_fine;
 
 	ret = bme680_get_t_fine(data, &t_fine);
@@ -709,14 +706,11 @@ static int bme680_read_humid(struct bme680_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_humidity = bme680_compensate_humid(data, adc_humidity, t_fine);
-
-	*val = comp_humidity;
-	*val2 = 1000;
-	return IIO_VAL_FRACTIONAL;
+	*comp_humidity = bme680_compensate_humid(data, adc_humidity, t_fine);
+	return 0;
 }
 
-static int bme680_read_gas(struct bme680_data *data, int *val)
+static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
@@ -751,9 +745,8 @@ static int bme680_read_gas(struct bme680_data *data, int *val)
 	}
 
 	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
-
-	*val = bme680_compensate_gas(data, adc_gas_res, gas_range);
-	return IIO_VAL_INT;
+	*comp_gas_res = bme680_compensate_gas(data, adc_gas_res, gas_range);
+	return 0;
 }
 
 static int __bme680_read_raw(struct iio_dev *indio_dev,
@@ -761,7 +754,7 @@ static int __bme680_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
-	int ret;
+	int chan_val, ret;
 
 	guard(mutex)(&data->lock);
 
@@ -777,13 +770,35 @@ static int __bme680_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_TEMP:
-			return bme680_read_temp(data, val);
+			ret = bme680_read_temp(data, (s16 *)&chan_val);
+			if (ret)
+				return ret;
+
+			*val = chan_val * 10;
+			return IIO_VAL_INT;
 		case IIO_PRESSURE:
-			return bme680_read_press(data, val, val2);
+			ret = bme680_read_press(data, &chan_val);
+			if (ret)
+				return ret;
+
+			*val = chan_val;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_HUMIDITYRELATIVE:
-			return bme680_read_humid(data, val, val2);
+			ret = bme680_read_humid(data, &chan_val);
+			if (ret)
+				return ret;
+
+			*val = chan_val;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_RESISTANCE:
-			return bme680_read_gas(data, val);
+			ret = bme680_read_gas(data, &chan_val);
+			if (ret)
+				return ret;
+
+			*val = chan_val;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
-- 
2.43.0


