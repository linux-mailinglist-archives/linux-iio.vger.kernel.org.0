Return-Path: <linux-iio+bounces-10429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959FB999436
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE11F2801A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58D1F12F4;
	Thu, 10 Oct 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD+NH7PG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21A1EF93F;
	Thu, 10 Oct 2024 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594059; cv=none; b=IS9MXIy1bsjEyRxP2mIJ2Jg91H2wOH0qBYG5S75kzEIhu48cQxPTGL7PsW12h+VGfWvkIz4tK8bmMS8EsZj3fM7Oork3ESMWoCdyowgb0juH8TfjBFfSwtx2jmobLQqh6CZCXbig5GYckXJd9ddmiwC121q3SgeYCNPmFK/evuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594059; c=relaxed/simple;
	bh=htghE5bfd+kQ4viLBkQpuFbt4H05U95ieqRgBCY1ekg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHo18/fln8ciKUIHXYny0elq5+zzGeqTeDYZUkcDlQg51BvQR/X2qqnLU9+eZ5S6xAyfpMk+EkUomlRFeOtztDBCyNEYdoDzVcn3Xw0StbN1bzgzJ9iw++MAJzDtf9qhqUbD/jrXZYyoeQftdBgkBW1XplN/VJCeaxtSO+5PYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD+NH7PG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398b589032so2384441e87.1;
        Thu, 10 Oct 2024 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594056; x=1729198856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFZcG4G/nDJlbBxKx5ip52fFFHl5Oj4RpUgHu+Xf+xI=;
        b=WD+NH7PGwIghdl550yLg+Ylq/8yxC+g/pSmuMnNnsWN+VnIAkY9qC0sw04HVjSeSaq
         5QsLrz5XaYrX7Gpgoxx4B/brRBxvt5Hv7deBQbuCmi9UZvSIXMWISIbHiOeol/v1Gx5T
         GMYI2cnX5YhiYF4qHqC5YCs829k5wIlMXq+6IlW4QZatTE/wkJmwv4Fsku9n5LSTUkLF
         7rLqEmKtWnZGdNL6XyYJMz+aB1yDk+IJ3aqE38udIBvasPeR66dlPELAJVXAdeXKC9J+
         QmzGxpKZDHG+smSowW9Et0YeCfofRA0HUZPv0t+iEh3b+jhPOoqSh9UltOwa/mUpqLHY
         2lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594056; x=1729198856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFZcG4G/nDJlbBxKx5ip52fFFHl5Oj4RpUgHu+Xf+xI=;
        b=Cy7WVBOV5gvGbVa6PxNc484YpeWkEK+LaMGZB0ngkXDPdDrQqgUg1qcsyepJUlhbFc
         LM3RPfMcIS539fTd9rbcm7+eQQWC38yBhrURq8ScFoELF49l5qafmy8f1O/M3KcOrlSx
         LS3JTJk4yiPdnwFDnsK7A/0NnD2U90f3Zo3lFoVnXxhrT2dOzWSbe0J/+VTPSAvopebW
         +XkeE8UK6oVOxdE9lx/kMP1dQGV44zYpHulgZxFiKAi81AWEOqoiM+jJflsGLbxiaWf2
         T4vUC2xlQFKWhPY576tD5UHKKkYprKHjROwm1xoQJN8VGxM7shs/gdeTSrS5YxLRjWLt
         VmYw==
X-Forwarded-Encrypted: i=1; AJvYcCVFnaLR/sct0eTj8jIfqcB7R+9zyJ26OwLt8Z37xglorwHRyiBzYQ9WnNyaZ2caE4nFNys6Czzv7q/s@vger.kernel.org, AJvYcCWGoexOU+QX1lsj6mHIlDvvtsZ/mcIRBvpQ7FbHt2ITEfXA0Lw+a+coxj+AetzOZ+xxgh7p1FZe/fa3@vger.kernel.org, AJvYcCWfRJSxIE3OM4khWShJyUNVwbydObHNdhEHR/o4tO/hzwECzNNPp56Llz4l4ifUTeAqaVt8DVCTFBlLveuS@vger.kernel.org
X-Gm-Message-State: AOJu0YyUh6dfT6yb5Q245u/pfgd78xmKPUA9TUwVelU0TPlPjPH4imJ+
	zHGlPEiiUR0mfjPt4pZzpS1p/pLwvypJ6ZqoKzrot6xQP0KeoQXD
X-Google-Smtp-Source: AGHT+IHUHptKoHrqPPCbXGaA3a+T1isiiRkGcpjAvzUotIy4gQ6iWdZtolCvWzro8Oe+sONYrOIMQQ==
X-Received: by 2002:a05:6512:108a:b0:539:901c:e2e with SMTP id 2adb3069b0e04-539da598edcmr68580e87.58.1728594055542;
        Thu, 10 Oct 2024 14:00:55 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:54 -0700 (PDT)
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
Subject: [PATCH v1 13/13] iio: chemical: bme680: Add support for preheat current
Date: Thu, 10 Oct 2024 23:00:30 +0200
Message-ID: <20241010210030.33309-14-vassilisamir@gmail.com>
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

Add functionality to inject a specified amount of current to the heating
plate before the start of the gas measurement to allow the sensor to reach
faster to the requested temperature.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  1 +
 drivers/iio/chemical/bme680_core.c | 38 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index e7eed2962baa..c658cb631b52 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -42,6 +42,7 @@
 #define   BME680_RHRANGE_MASK			GENMASK(5, 4)
 #define BME680_REG_RES_HEAT_VAL			0x00
 #define   BME680_RSERROR_MASK			GENMASK(7, 4)
+#define BME680_REG_IDAC_HEAT_0			0x50
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
 #define BME680_ADC_GAS_RES			GENMASK(15, 6)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index df6ae4355902..6cdf8b9dbf2b 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -126,6 +126,7 @@ struct bme680_data {
 	u8 oversampling_temp;
 	u8 oversampling_press;
 	u8 oversampling_humid;
+	u8 preheat_curr;
 	u16 heater_dur;
 	u16 heater_temp;
 
@@ -223,6 +224,12 @@ static const struct iio_chan_spec bme680_channels[] = {
 		},
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(4),
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.output = 1,
+		.scan_index = 5,
+	},
 };
 
 static int bme680_read_calib(struct bme680_data *data,
@@ -569,6 +576,12 @@ static u8 bme680_calc_heater_dur(u16 dur)
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
@@ -673,6 +686,19 @@ static int bme680_chip_config(struct bme680_data *data)
 	return 0;
 }
 
+static int bme680_preheat_curr_config(struct bme680_data *data, u8 val)
+{
+	u8 heatr_curr;
+	int ret;
+
+	heatr_curr = bme680_calc_heater_preheat_current(val);
+	ret = regmap_write(data->regmap, BME680_REG_IDAC_HEAT_0, heatr_curr);
+	if (ret < 0)
+		dev_err(data->dev, "failed to write idac_heat_0 register\n");
+
+	return ret;
+}
+
 static int bme680_gas_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -701,6 +727,10 @@ static int bme680_gas_config(struct bme680_data *data)
 		return ret;
 	}
 
+	ret = bme680_preheat_curr_config(data, data->preheat_curr);
+	if (ret)
+		return ret;
+
 	/* Enable the gas sensor and select heater profile set-point 0 */
 	ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_GAS_1,
 				 BME680_RUN_GAS_MASK | BME680_NB_CONV_MASK,
@@ -967,6 +997,13 @@ static int __bme680_write_raw(struct iio_dev *indio_dev,
 
 		return bme680_chip_config(data);
 	}
+	case IIO_CHAN_INFO_RAW:
+	{
+		if (chan->type != IIO_CURRENT)
+			return -EINVAL;
+
+		return bme680_preheat_curr_config(data, (u8)val);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1199,6 +1236,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->oversampling_temp = 8;  /* 8X oversampling rate */
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
+	data->preheat_curr = 0; /* milliamps */
 
 	regulator_bulk_set_supply_names(data->supplies, bme680_supply_names,
 					BME680_NUM_SUPPLIES);
-- 
2.43.0


