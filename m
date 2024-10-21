Return-Path: <linux-iio+bounces-10902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775599A9059
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F0B1C22BD9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9211FEFDC;
	Mon, 21 Oct 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm875eeF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270771FEFBB;
	Mon, 21 Oct 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540425; cv=none; b=S6UmMbNRHw0Q44AMMHE1u5EbP7oFk9dk1qVqnnfygn2bJPHDCG/Tm0m4Za2khxAGO7RFtZEEj6UdWRuTltOFqn0MBCmda9EMzDTr7SApV/Nk5L0s1//Yk3RUzAQv99MBcCrjDmhXvIaC5OlsouwNHv1ANg4jbHpaRg0tTAmUrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540425; c=relaxed/simple;
	bh=WMn2eYkD1TDSeknpCBtf1al8/6YBl+fbIaLWQn8dlHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIhhzt/qG+PTnfJw6zjK18ekUAYpPq1TLXfSjnMVKz7JXmIlgSGZbuJbr1kUFbgQ9gaOw1gO908EeoqT/UOru7o7BYAVEVCMYRv6dyxOgNN6MXTExKxr2HaPT8z+1UPm7EeT3QlxQR7LCWsx2Evs3bNsJZ/AFkAGH/x/EmmewPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm875eeF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb51f39394so51032381fa.2;
        Mon, 21 Oct 2024 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540421; x=1730145221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YnjJ8/zhtnYop/8ZDBf7vSXapFQNrBGViVFS5PeYFY=;
        b=Dm875eeFNA0Gi3Kq6iYiH5oT8chBnU+wWX2tAgi3UCxfunXL+ZTc/Mu2LI5NSMpCvC
         abR6ktkELeOsA02O7KEwuIdb0qMO1sIJyqXyo2ze6CipZfGtJ4Mw/aMYTmmDQvsYqVeD
         VBCiSA7K5WER0XcfNuUN8VYTEMWgEUykg25J0+AIZ/sz4gat3YKuqML+uyocIHgMGl2q
         0du22kkFjnFNKkqDodeRod+0WRSBlLO/pSY90c+6YY7pS6Dk7UoJ21niStzMMzJpzVhE
         nUkyxr8lNHK7o/PtUoGOIC85aFOVMHzEqUaNGmWqwrOxDgagj1fMkoF0VA7ONzm8zuqo
         cxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540421; x=1730145221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YnjJ8/zhtnYop/8ZDBf7vSXapFQNrBGViVFS5PeYFY=;
        b=VhVL24r6m8f9CmKHbq74+9JzEWSvCEyUuLv3VVt0SkkAL9Ck7s64oBkwhxvho1p/RO
         Cdiu5UQRtywpeYPEzpuI/14YCPfu6dBeK9iIxHE9xnAUFMp9LAGKf8q32x/n6NsA9CWn
         gqRu0PXB/kCNh4Oxn0CCXvXzT3hDwoRAUyGSkn8Zon230I+kxjM+LCnIaL/EU7xG9Z6Q
         ORF4lTDRXdHuHvBxxz5VBEdxlliygzn+kYdX4zHyA20/9eaKvJPeIkw9Hb7tvxVQ5pVp
         dt5Q7RJjPUkNsA4C5YBie5yKQadrqwrwGe50kwyCys/4BC7KTVbm/2EYPfSpSZxzKI15
         fNXA==
X-Forwarded-Encrypted: i=1; AJvYcCVK4FLE5mmOfHb1jemcq8M3uLO9ultWVv6zCvwvsDKpOmeGqPaT7y7mFTLk9HWN8Rp3vHZyrxTanIJM@vger.kernel.org, AJvYcCW56jHBColic6P/jhOxlsT2o1fbgYEl35VGnyqWQHkrO+phgTM8QGcAd7Hh2jNlViFDuxPb8NnVPgaSpEaZ@vger.kernel.org, AJvYcCXyMpdb0DEHz44PC3wpp0u5Zo0XdyE6W2A9e0SENGnOfZrA2aTHcITMIIuTWdTU3h3+meU+zTZB516P@vger.kernel.org
X-Gm-Message-State: AOJu0YyuA3fDj6UJ8q2pA4A8BujKt99uMmx57gCHGjlh+JWGyCx5wP6Q
	wGFmeOkMJElt+F75WvWFYsvGyOTUMp2i++8hfeO8nQcMPm0UXwm1
X-Google-Smtp-Source: AGHT+IHYinGx1REj6CM7N5rlymBC2ErBoX16/znp7FVMGsk6Z19Jx4XLJfXy4qBZJmrdOKK7OGaA+g==
X-Received: by 2002:a2e:be22:0:b0:2fb:5014:c963 with SMTP id 38308e7fff4ca-2fb82eb03damr60889371fa.20.1729540420954;
        Mon, 21 Oct 2024 12:53:40 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:40 -0700 (PDT)
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
Subject: [PATCH v2 10/13] iio: chemical: bme680: Add support for preheat current
Date: Mon, 21 Oct 2024 21:53:13 +0200
Message-ID: <20241021195316.58911-11-vassilisamir@gmail.com>
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

Add functionality to inject a specified amount of current to the heating
plate before the start of the gas measurement to allow the sensor to reach
faster to the requested temperature.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  1 +
 drivers/iio/chemical/bme680_core.c | 41 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 574877bc51c5..e5d82a6d5b59 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -44,6 +44,7 @@
 #define   BME680_RHRANGE_MASK			GENMASK(5, 4)
 #define BME680_REG_RES_HEAT_VAL			0x00
 #define   BME680_RSERROR_MASK			GENMASK(7, 4)
+#define BME680_REG_IDAC_HEAT_0			0x50
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
 #define BME680_ADC_GAS_RES			GENMASK(15, 6)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7bf4daa35ba5..8c80a5f1ef9e 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -117,6 +117,7 @@ struct bme680_data {
 	u8 oversampling_temp;
 	u8 oversampling_press;
 	u8 oversampling_humid;
+	u8 preheat_curr_mA;
 	u16 heater_dur;
 	u16 heater_temp;
 
@@ -213,6 +214,12 @@ static const struct iio_chan_spec bme680_channels[] = {
 		},
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(4),
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.output = 1,
+		.scan_index = -1,
+	},
 };
 
 static int bme680_read_calib(struct bme680_data *data,
@@ -560,6 +567,12 @@ static u8 bme680_calc_heater_dur(u16 dur)
 	return durval;
 }
 
+/* Taken from datasheet, section 5.3.3 */
+static u8 bme680_calc_heater_preheat_current(u8 curr)
+{
+	return 8 * curr - 1;
+}
+
 static int bme680_set_mode(struct bme680_data *data, enum bme680_op_mode mode)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -658,6 +671,20 @@ static int bme680_chip_config(struct bme680_data *data)
 	return 0;
 }
 
+static int bme680_preheat_curr_config(struct bme680_data *data, u8 val)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 heatr_curr;
+	int ret;
+
+	heatr_curr = bme680_calc_heater_preheat_current(val);
+	ret = regmap_write(data->regmap, BME680_REG_IDAC_HEAT_0, heatr_curr);
+	if (ret < 0)
+		dev_err(dev, "failed to write idac_heat_0 register\n");
+
+	return ret;
+}
+
 static int bme680_gas_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -686,6 +713,10 @@ static int bme680_gas_config(struct bme680_data *data)
 		return ret;
 	}
 
+	ret = bme680_preheat_curr_config(data, data->preheat_curr_mA);
+	if (ret)
+		return ret;
+
 	/* Enable the gas sensor and select heater profile set-point 0 */
 	ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_GAS_1,
 				 BME680_RUN_GAS_MASK | BME680_NB_CONV_MASK,
@@ -937,6 +968,15 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 
 		return bme680_chip_config(data);
 	}
+	case IIO_CHAN_INFO_PROCESSED:
+	{
+		switch (chan->type) {
+		case IIO_CURRENT:
+			return bme680_preheat_curr_config(data, (u8)val);
+		default:
+			return -EINVAL;
+		}
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1072,6 +1112,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->oversampling_temp = 8;  /* 8X oversampling rate */
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
+	data->preheat_curr_mA = 0;
 
 	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
 	if (ret < 0)
-- 
2.43.0


