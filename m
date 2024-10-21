Return-Path: <linux-iio+bounces-10899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1879A904F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC691F239A0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3501FE101;
	Mon, 21 Oct 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn9P1/ot"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEB1FE0E0;
	Mon, 21 Oct 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540419; cv=none; b=HBxQygh3QDB4X8xHT4AyCUQIz27Tw8ulK7O7sVlS6h3dJKoKRyUIJUKS6WlRlC5fv6Q2jMqm6dPOSH4epdIvY2iPhWQM53Jq2QeihQ2RvdP9I53Lt6oUEOVpvu0hS4zevbvxCtYn369QRrCb3CrMev2cN+7i2moGkyijNkCW4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540419; c=relaxed/simple;
	bh=UVWXbwUbrUBs268eCFhh54s78PsYWHgLof76EVxrEjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qF7wtcO0NDimgkhk7BzLn4Bzs7ChD/A/4cJxj43VapS2ZS/5daJKRYTUX1lntRYbJT4vs6YsVUWNf8JlWQMB0h3H9tMJYpNY0urSHgQ8JZG/DC+YMmVe4Rv7wvcEo9TWp7HI2TQ4GNhO+EBDXqHuqR5AiAxb2aWJLdv2S/nWYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn9P1/ot; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so5550188e87.1;
        Mon, 21 Oct 2024 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540416; x=1730145216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHOvuHmA4/toKmPxxQ13YCc+GHjBN2Z5SMzcuSpTD1Q=;
        b=Yn9P1/otLVgjn+UvZuiH4/9Uunp1aITj176czyiHYUtHNPuLj0eWITu+molWjY+qEK
         xEtJPQePsIbAZSzQ4XbEEfIwp9/e6AJEZPr5ELTrbsC6wqQ83Imi0wrvZdMv/BIuJD/M
         9BmUcGCMgSy3Ne6G967uYFdW5hK7oRqKQ3zwWqmjXioDCqkqVxSCzbCqiGAkjhibmila
         CDphOpyM/y4l50Fb9s05fhQ8khsLpAWCDyQ8jBcgf3grl344qaTLu2dAT003RYgcQ5OE
         O89ztwgO+52sIFLJEpQQJAXx/AQRCHU9D+j7N+Bh5jMTekzTkKtE04Yw4gptab5xcRtL
         Z35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540416; x=1730145216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHOvuHmA4/toKmPxxQ13YCc+GHjBN2Z5SMzcuSpTD1Q=;
        b=drLiE3TKj6hj99OF0rClx7MSaNY5bbkcRhTAPKIJePmtshzaqzYepWjcbjdrONekEN
         SQj39IhHEOf6mizdS0ESMP2onYpRTlZJZM3cudCXH6Ge9lLJc/bnWDXnGe7lwt7tFxPN
         M4oUtRJcbXMB7xbTx1QA4aKm93pWQ7wW0jiw5Dy3xrrtwv458CtCoHn2VMMpOSka6mBz
         75jJQ51++AE4/vIcyAIX/xbe4j57D5e0LNqLw7Z66JBxP5KqoRwimMLlkhfnPBdUdKvL
         7Kh/yoNMBhfIfV0hNhMOp4YokSWvRhii3UMnO2YOftzsXduHfb5kojIVb9JcV4TBa7BN
         T39g==
X-Forwarded-Encrypted: i=1; AJvYcCUsFA878NMvpE04a7ja/kX6IkeH9JKRsLr7VibKZXdvJhjbyy1Jgf2V6g2q4Fm/DlxLysfGY0BhrDO37cUu@vger.kernel.org, AJvYcCWohtXayk+nGBhK0STy7Mo+qk5PcHQJ+MVCwA+Ms6wb24SnYFQIpI3k47c6EQ9uaQChSqDJuX3IqCIo@vger.kernel.org, AJvYcCX65sqZGtbRRxWBsNo6lMA7dZQVFVcMh47d1ow/TEAbOmKqEYxIyUvNzPgV40Rs/vWtCLw3kp39FtKK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QolcC+s7ueMVw90yLHa6LfQgcZzlNboMd9nxMbTDAtkNuTDe
	HOjsMVwguKd21TfnOPC8fE5FYszWSQeNRXD4P3bEpMdFSi36LtBb
X-Google-Smtp-Source: AGHT+IG6UDRo/01CqwTIuHIsaFtYn6v3bwZTt0oBDcQ3RkjuZr4vvUBDCFEVGOAFXpxxgjtlHcDFKw==
X-Received: by 2002:a05:6512:158d:b0:537:a745:3e with SMTP id 2adb3069b0e04-53b12c36af5mr753067e87.45.1729540415578;
        Mon, 21 Oct 2024 12:53:35 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:34 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] iio: chemical: bme680: generalize read_*() functions
Date: Mon, 21 Oct 2024 21:53:10 +0200
Message-ID: <20241021195316.58911-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the IIO specific scaling measurement units from the read functions
and add them inside the ->read_raw() function to keep the read_*() generic.
This way they can be used in other parts of the driver.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 68 ++++++++++++++++++------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2ad427f5deb4..c79ba6d1ece8 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -644,23 +644,20 @@ static int bme680_gas_config(struct bme680_data *data)
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
 
-static int bme680_read_press(struct bme680_data *data,
-			     int *val, int *val2)
+static int bme680_read_press(struct bme680_data *data, u32 *comp_press)
 {
 	int ret;
 	u32 adc_press;
@@ -674,16 +671,14 @@ static int bme680_read_press(struct bme680_data *data,
 	if (ret)
 		return ret;
 
-	*val = bme680_compensate_press(data, adc_press, t_fine);
-	*val2 = 1000;
-	return IIO_VAL_FRACTIONAL;
+	*comp_press = bme680_compensate_press(data, adc_press, t_fine);
+	return 0;
 }
 
-static int bme680_read_humid(struct bme680_data *data,
-			     int *val, int *val2)
+static int bme680_read_humid(struct bme680_data *data, u32 *comp_humidity)
 {
 	int ret;
-	u32 adc_humidity, comp_humidity;
+	u32 adc_humidity;
 	s32 t_fine;
 
 	ret = bme680_get_t_fine(data, &t_fine);
@@ -694,15 +689,11 @@ static int bme680_read_humid(struct bme680_data *data,
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
 
-static int bme680_read_gas(struct bme680_data *data,
-			   int *val)
+static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
@@ -737,9 +728,8 @@ static int bme680_read_gas(struct bme680_data *data,
 	}
 
 	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
-
-	*val = bme680_compensate_gas(data, adc_gas_res, gas_range);
-	return IIO_VAL_INT;
+	*comp_gas_res = bme680_compensate_gas(data, adc_gas_res, gas_range);
+	return 0;
 }
 
 static int bme680_read_raw(struct iio_dev *indio_dev,
@@ -747,7 +737,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
-	int ret;
+	int chan_val, ret;
 
 	guard(mutex)(&data->lock);
 
@@ -763,13 +753,35 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
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


