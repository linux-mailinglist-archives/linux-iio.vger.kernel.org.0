Return-Path: <linux-iio+bounces-10424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59612999427
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B71C264C2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAA1EBA0A;
	Thu, 10 Oct 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGNpw4Tw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4B1EABBD;
	Thu, 10 Oct 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594053; cv=none; b=Yowrce51JWdTWjDDO01UydCyu6nB85fXO8ekRkadQ/TaKtYxTeWx2VQzxI0TuNZok/5EjYl8Y3zsI7ex/HjZlSReq/nFTPKkb/JusvgbFp/Fd8gY6CItr40Z8ZttV0hayV3R00LUMFw+hFavWGlhX+0FrVjx9dHdQuRC9nXM6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594053; c=relaxed/simple;
	bh=uGwAGY5iqtreG1Rl2Q91IZhfZ4uzMS1tFym9aD9lrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc3EpHLfu2lpqmMeJH2kHPNyUeyv2AAVP5LyGlnvfVLmxbwRryKCs1QWzcEM7Oj9XKHyeslLRjwKgtr7lgvcyOt4rlfisFcP4p/YuGgWZeAagkiQPMj2TwFkfjVGZZe9j8Sdhb52tqUa/PGpxMqAHyyBGDL99yfMQNaQalx5nnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGNpw4Tw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a994ecf79e7so223231366b.0;
        Thu, 10 Oct 2024 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594049; x=1729198849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaXqSuLsFI5WdaDUrYSVDsiRhV/evheqKshVzEAvGPw=;
        b=jGNpw4Twpmxg6629bD3Q/9kPzvVyBam3abI4y5ZQpTd8cYgWa05m9hbbW7HoscMK3I
         g6puV4QCXRkZE2tf9al/bKg2D8YifOtdvl+PFByeb1Kqy0tAJnGZzHjIgrU73NLTqV7i
         zwfClLhCHcbop3vvbdh64WrGr/8vi9Hs1iPtS7X4OW+o/NE80HDIRhFTfY8VHNASqNjw
         1MIrLjXtVvQeIgvsg3iBHsDboi9d5x1QBGtDrHNHSbPGIsVsK+oNQG+xzPZEmVtRw0oN
         zOrkRO/ZSxXMldtr+65nvKBWxjAIPiDAnoIMr8iG/BP8YZ+R0Mwpp9NJ4wTqNXzoZNWg
         M5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594049; x=1729198849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaXqSuLsFI5WdaDUrYSVDsiRhV/evheqKshVzEAvGPw=;
        b=Tejd9bH0uaMXvpw1mQuGpBedx/59Soxn607RYd7dxdhsZ2bQZXtRKVeeHeTCLR8a3G
         ZSS9Iuhq48OY/T/vLFKu+enCfgZnVrD9ahN3R4BdY6kq/+N9apT0H5ZUlVt392pa7Zok
         twcHmb/aSXDEgkzCEIBHij6cxxc69LV0jUd6LaG8UfyFD0C69UFsrVtv+of7XzG9cJTF
         IFc4CkzaxDipr4JXKe711nIAK6h/GWODLdrnJGGSOwzGBB+HBcaU3rHiVDGmuw0lgG+7
         09nu+pI3YXK4E1RXTwL5npUqJwV5OVRwszKaximMDW7UC2wzDst9zqbWM/FdgXlL3xYT
         o0GA==
X-Forwarded-Encrypted: i=1; AJvYcCVh7XECYTsHWwAZkqqGbgkhIcAOUObM+EN4sBA2QSqr57Q29dTHaT3gtVnkMFfWb8oJ0mKI/dNfC50+@vger.kernel.org, AJvYcCX95H1cEsxdHUZQstjOxZ1tOBDdBGzY9ylSj686eQyhIwxuZN3lUb2oKaOGJNhX40gn6dvfjnFZsWzJIwLl@vger.kernel.org, AJvYcCXwYdAVT8y65N6LT0jbhn1s1k4Tk4c4ZAvZTRMAgRxLfNi8ZP5/19Js9YWp0/VbMb5m8wMWithj7crr@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXqdU0G9VXK8WBWDF0hHtBaLQJY3QYphOqsgwY1jMMpJ2mByk
	BgNQ9evp1NR0NsrfHOClSHPSnzNxEoa5wgmvAcwMndlEVmoxd4Z+
X-Google-Smtp-Source: AGHT+IGDsfwzeqAdM57791o3FOb4sGtnBah0MtDXYgkYPGoPAhOaix3Z0ep25ZNxWyEP+xHGsEPKJg==
X-Received: by 2002:a17:907:86ab:b0:a8b:ddf4:46f1 with SMTP id a640c23a62f3a-a99b9678822mr23747066b.63.1728594049459;
        Thu, 10 Oct 2024 14:00:49 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:48 -0700 (PDT)
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
Subject: [PATCH v1 08/13] iio: chemical: bme680: add power management
Date: Thu, 10 Oct 2024 23:00:25 +0200
Message-ID: <20241010210030.33309-9-vassilisamir@gmail.com>
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

Add runtime power management to the device. To facilitate this, add also
a struct dev * inside the bme680_data structure to have the device
accesible from the data structure.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |   1 +
 drivers/iio/chemical/bme680_core.c | 100 +++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index e55a48982b3e..e9e3e08fa366 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -75,6 +75,7 @@
 #define BME680_CALIB_RANGE_3_LEN               5
 
 extern const struct regmap_config bme680_regmap_config;
+extern const struct dev_pm_ops bmp280_dev_pm_ops;
 
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name);
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index a2039b966f20..5fd5740bb7fe 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -111,6 +112,7 @@ struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
 	struct mutex lock; /* Protect multiple serial R/W ops to device. */
+	struct device *dev;
 	u8 oversampling_temp;
 	u8 oversampling_press;
 	u8 oversampling_humid;
@@ -753,9 +755,9 @@ static int bme680_read_gas(struct bme680_data *data, int *val)
 	return IIO_VAL_INT;
 }
 
-static int bme680_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int __bme680_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 	int ret;
@@ -803,14 +805,29 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int bme680_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
 static bool bme680_is_valid_oversampling(int rate)
 {
 	return (rate > 0 && rate <= 16 && is_power_of_2(rate));
 }
 
-static int bme680_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int __bme680_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
@@ -846,6 +863,21 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int bme680_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = __bme680_write_raw(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
 static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
 
 static IIO_CONST_ATTR(oversampling_ratio_available,
@@ -873,6 +905,15 @@ static void bme680_regulators_disable(void *data)
 	regulator_bulk_disable(BME680_NUM_SUPPLIES, supplies);
 }
 
+static void bme680_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_get_sync(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+}
+
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -887,6 +928,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data = iio_priv(indio_dev);
 	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
+	data->dev = dev;
 	data->regmap = regmap;
 	indio_dev->name = name;
 	indio_dev->channels = bme680_channels;
@@ -947,10 +989,56 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		return dev_err_probe(dev, ret,
 				     "failed to set gas config data\n");
 
+	/* Enable runtime PM */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US * 100);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
+
+	ret = devm_add_action_or_reset(dev, bme680_pm_disable, dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(bme680_core_probe, IIO_BME680);
 
+static int bme680_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+
+	return regulator_bulk_disable(BME680_NUM_SUPPLIES, data->supplies);
+}
+
+static int bme680_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
+	if (ret)
+		return ret;
+
+	fsleep(BME680_STARTUP_TIME_US);
+
+	ret = bme680_chip_config(data);
+	if (ret)
+		return ret;
+
+	ret = bme680_gas_config(data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
+			  bme680_runtime_resume, NULL);
+
 MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
 MODULE_DESCRIPTION("Bosch BME680 Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


