Return-Path: <linux-iio+bounces-11837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F179BA052
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F7D2817D9
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39711A76DA;
	Sat,  2 Nov 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSuEOdNw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D281A76D2;
	Sat,  2 Nov 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553217; cv=none; b=T/u/cvG/Vo9rCSSqEqdK4b2fZ8mfBQ89SL2ExZa/4ttRM6XFnBTP3cpGTRhTk/Z6YwpCbRckg3QKcqsUc0WwAyJ82oUPRNAaEbf9csRYac5sfJtEf1Z6FTl7O4luhoOmxaSHEDs+Ydhwx7bpGq31KchT7kap6v82OC3EXhANqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553217; c=relaxed/simple;
	bh=3uM+WTqtBsg0xw8sisrXt1kS0w4vpxas/UEHkXkdmv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH7zy8emM+q52oN4OUPU7whaAK25s/kLKX2wBIHVYa3Ypxsz0JnYwA3RR/HovCPj+iy27hq1VOtv2HmJ8nmOKUekfPFWvx/64G5Sp+7oY8RQNN+nbakOGQVRvaEu7KSXbxuOBl4z3uUUqudQbAW0WWXG+Gsth7j0xfg6bco9g28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSuEOdNw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d5aedd177so1760429f8f.1;
        Sat, 02 Nov 2024 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553212; x=1731158012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDHI8hy0XPenUBZmXhVO2K57CVRNbJxHW4WA2n3XfjI=;
        b=kSuEOdNwkg3xsw7RAIUfbe1SkyXgVL+8FF/MNDjdVNggAq+fHQ0CvhhG7fTDDC781V
         ft2zZmk3Qw7wH1/YMA9PiYNjJLA0XDddHWLxN5fMWD3H9zO8k3wIqYJy83PV5ZOBo3cF
         2DSt6vlmJf0JUXhykNcNS0JHo0NPL9WydsDX//Mw4JmcxLvtCbwlOZH9kuZ0TB8QTqiH
         7NYx8/PUBegrMZfg1dM3cDRyOH9sGhOdM1/3Io2Patq976jypgeCxB836HSnwxGtIkXw
         +Ox10RQyVXan6pFpFz1a1BZa6DCi+xqUeCNTfwZ3J2kOjZaeeoEIq9Cx+hBNveu24zi5
         AE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553212; x=1731158012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDHI8hy0XPenUBZmXhVO2K57CVRNbJxHW4WA2n3XfjI=;
        b=I9QngpKUFGU8+9yuRJYeSoOFlbFLZWthIdJ/iWCnkds8bwLgsqTrFfT0OnwNec/A/B
         Z1UOow9Aan7aUDdZpUirAonLeqnI2n3d+2J9iGpKGAzJpzt03UuqwRpa2CpffxmI6jfp
         BOFaykWV7N3BrBrclabMj1ugoIYQZH7P5/goSGq9yb6/1vMrB1AcpvpFngEPmww1vjDx
         tgaiXqkQ+ThU0qUVr9AJa+BDvw6OtUUVvY9fxUZpSa6BWohmLdfe6w+AvfG4bwW3s5zW
         7N18tB279PLVaSOoWTY9G/wVls75Y4J0Sr+vsVhRmY34VvNlVmE5M+SyamXtk6mSUJqA
         hKnA==
X-Forwarded-Encrypted: i=1; AJvYcCVuMqboeWVr5NryMbgijgo8k6y87xzWiykh9n9rqaL1GGfcvKJYRSSl9ibt9lrVC3OGXg/KUitqL01tn7lP@vger.kernel.org, AJvYcCW1inn1igZ1hIJ7uLATSHRZd410UanqaUTEWdAypLylGkM6xS/DEclYz4Wn7tlXjq0Xir6nzIMialYY@vger.kernel.org, AJvYcCWw2JDThIaDmzlBjMdyisYCjH1jDR4Hqp0AMy+oqMevbLKDkt2y5NfgsvORS7wIWsq/Lz2YHQ9r/DaD@vger.kernel.org
X-Gm-Message-State: AOJu0YzuoSKRSjN8+tCfuACtAr9W1h+lP7rlvcE6F6g0Tx0+PgFIfGMA
	cSwRRx+xpi6+Xc3ojrd0dMjAkl5wRIjImYBMV5nVm6VbTRKpA7Ry
X-Google-Smtp-Source: AGHT+IHInBw6EOfyGKOt2Y7vXqIXSTg7zRjKrOAcNA2fScdV1r1eN3P0K2WiUFiXsmR3YlX53y4v4g==
X-Received: by 2002:a05:6000:178a:b0:37c:c5c4:627 with SMTP id ffacd0b85a97d-381be765277mr8898023f8f.5.1730553212000;
        Sat, 02 Nov 2024 06:13:32 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:31 -0700 (PDT)
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
Subject: [PATCH v3 7/7] iio: chemical: bme680: add power management
Date: Sat,  2 Nov 2024 14:13:11 +0100
Message-ID: <20241102131311.36210-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102131311.36210-1-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime power management to the device.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |   2 +
 drivers/iio/chemical/bme680_core.c | 104 +++++++++++++++++++++++++++--
 drivers/iio/chemical/bme680_i2c.c  |   1 +
 drivers/iio/chemical/bme680_spi.c  |   1 +
 4 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 00ab89b3138b..7d86ed8b02e6 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -2,6 +2,7 @@
 #ifndef BME680_H_
 #define BME680_H_
 
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #define BME680_REG_CHIP_ID			0xD0
@@ -80,6 +81,7 @@
 #define BME680_CALIB_RANGE_3_LEN               5
 
 extern const struct regmap_config bme680_regmap_config;
+extern const struct dev_pm_ops bme680_dev_pm_ops;
 
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name);
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 31769e0df7c2..61d095f1d2f6 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -14,6 +14,8 @@
 #include <linux/device.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -822,9 +824,9 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
 	return 0;
 }
 
-static int bme680_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int __bme680_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 	int chan_val, ret;
@@ -937,14 +939,30 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int bme680_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
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
 
@@ -989,6 +1007,22 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int bme680_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	ret = __bme680_write_raw(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
 
 static IIO_CONST_ATTR(oversampling_ratio_available,
@@ -1091,6 +1125,30 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int bme680_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	pm_runtime_get_sync(dev);
+	return 0;
+}
+
+static int bme680_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops bme680_buffer_setup_ops = {
+	.preenable = bme680_buffer_preenable,
+	.postdisable = bme680_buffer_postdisable,
+};
+
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -1164,15 +1222,47 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bme680_trigger_handler,
-					      NULL);
+					      &bme680_buffer_setup_ops);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "iio triggered buffer setup failed\n");
 
+	/* Enable runtime PM */
+	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
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
+	return bme680_set_mode(data, BME680_MODE_SLEEP);
+}
+
+static int bme680_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = bme680_chip_config(data);
+	if (ret)
+		return ret;
+
+	return bme680_gas_config(data);
+}
+
+EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
+			  bme680_runtime_resume, NULL);
+
 MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
 MODULE_DESCRIPTION("Bosch BME680 Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 7c4224d75955..9998d7fa3e98 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -51,6 +51,7 @@ static struct i2c_driver bme680_i2c_driver = {
 	.driver = {
 		.name			= "bme680_i2c",
 		.of_match_table		= bme680_of_i2c_match,
+		.pm = pm_ptr(&bme680_dev_pm_ops),
 	},
 	.probe = bme680_i2c_probe,
 	.id_table = bme680_i2c_id,
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index 7c54bd17d4b0..43d59544d903 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -154,6 +154,7 @@ static struct spi_driver bme680_spi_driver = {
 	.driver = {
 		.name			= "bme680_spi",
 		.of_match_table		= bme680_of_spi_match,
+		.pm = pm_ptr(&bme680_dev_pm_ops),
 	},
 	.probe = bme680_spi_probe,
 	.id_table = bme680_spi_id,
-- 
2.43.0


