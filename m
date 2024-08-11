Return-Path: <linux-iio+bounces-8408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3880394E22D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2024 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54869B20BD3
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2024 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142651537BB;
	Sun, 11 Aug 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgioOnj1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BD14F130;
	Sun, 11 Aug 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392734; cv=none; b=kryT6Dgu9VBrN+cC2HKFkeinUQzXzL2HowemKAVaKKQCZXgfiXtRUzTgwzf8np2xylSRoUfJjr7khji2Zdm4yjI0zfPRDpB0LMfRkAfGi6d7n7pr8YbPF8r9WXWWxOZyEO4twkYCdIWoEZS3pKNVr/Y+hdc2V7SMrAIVZeFUkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392734; c=relaxed/simple;
	bh=R2Ko8ogcMcvtMkH39y0UEzqevK8dw7tGN8+xjNv17iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqhgInBVa1OcHQAnPc2GfDRqp6KrjfwQw5+myEI9LBqab22g678JoAH4NY9xRe23eY/HxoAUOXiZaMvhNQnbPBD34SEGL6EomFd0XY8HfAnLmVrMHmKFBhigfSgAbBRXamwUfLlCsUxqHINPuLzHKMzQ5OYdxLNAHP2/wWcDKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgioOnj1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so358763066b.2;
        Sun, 11 Aug 2024 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723392731; x=1723997531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FYr2UuWJGazd33/jtfYhMyn4H39rZAf8Nm0rPgYARg=;
        b=dgioOnj1Ow4iEBxydV0YEsTrwn7TFMKRTWmj6e7pVy9PubtmankmjOS100RBTErOIn
         u2PdvuRnQ+wPoKwLe5vKh4uva5UFTtS9DCjOH47GaxqGgrAol4K4zq0gLEj4MxZVcrS8
         B5Xw0joTFr+T0PpDLiaCfMyuVr7BmuNGeAV6BS1Uf2RfvZS1lZ7hTbvPiVKOplOaUqPZ
         V80ogAeUCUFBoNg92FMVVGaso9F5X7o55uzGu0f67aAVc6ZFHbgnz1T/Fr5M37C0g0fy
         ozEHpYJ1AVIKc8w5K5a6VDuEooJpqZaMDzAAlPpq0DzMIW8BaXqEddqLK4Wc/MQvQJEr
         sXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723392731; x=1723997531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FYr2UuWJGazd33/jtfYhMyn4H39rZAf8Nm0rPgYARg=;
        b=MkHEzwzGFSZP9KV4IZB6703sa5+MJzwQ1w06jIgVWE0TBudOytOpnntJ9A/N4iYvvK
         604hlAIabwYfjjUZt0iTILDILZXyAsdSE0yKRqVaxb9uASBMD2Ze1LbCWoK2MiJaXpkx
         VwzeREk0MNrFn+HMULfHFlXWmWsiBf79GhzKePWr8C6YmOpGYZbFOh5RZBfmiKXMKX0K
         dVeI7Bs1MyE7XaJrbdn4/gk2iHGczrLwYS6sU0B+9g9MkwofVzdbqfjpiAVng5pjA1lt
         4lPxq88uaRIa2ltadXO4jOve0NyNwR5pC4BHlNav+msyC1TvYu4LK7Qrer1meG8TOKft
         0zDg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Hfb8Mc2NF2aCz7auBTNOPbLhnaOlAeHJRMLXHj7jMJFxuk9WXuF8Rh/Aswen0MZ5IP7+gEsZrBwOlKuROKTbGsA07ZBhozwhBUgVcn1N4ZP8M06Arcc3nO9cIpAg85V7KZ/gellb
X-Gm-Message-State: AOJu0Yz2S2FRzaScnxs9FhBsrJiO1VmYzMyadMhBwYGx21uf8WBEhJfe
	sabAOou/fyvKQ+Z1mY5NvzPYy9Sfw7xr0RVO/R7fZh3Y7ck9Teyj
X-Google-Smtp-Source: AGHT+IFdadbjYEOuAArVZrIjAFpNP/qfm0Na7AfNPIqywSlBhsP1+E+etwQ5J4SL70l63PpqCr0BFA==
X-Received: by 2002:a17:907:f14a:b0:a77:c9cc:f96f with SMTP id a640c23a62f3a-a80aa556817mr502967966b.7.1723392730852;
        Sun, 11 Aug 2024 09:12:10 -0700 (PDT)
Received: from localhost.localdomain ([151.49.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cd337sm158535566b.142.2024.08.11.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 09:12:10 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH 1/1] iio: bmi323: peripheral in lowest power state on suspend
Date: Sun, 11 Aug 2024 18:12:02 +0200
Message-ID: <20240811161202.19818-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240811161202.19818-1-benato.denis96@gmail.com>
References: <20240811161202.19818-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi323 is mounted on some devices that are powered
by an internal battery: help in reducing system overall power drain
while the imu is not in use by resetting it in its lowest power
draining state.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323.h      |   1 +
 drivers/iio/imu/bmi323/bmi323_core.c | 183 ++++++++++++++++++++++++++-
 drivers/iio/imu/bmi323/bmi323_i2c.c  |   8 ++
 drivers/iio/imu/bmi323/bmi323_spi.c  |   8 ++
 4 files changed, 194 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
index 209bccb1f335..9fd3c5db7520 100644
--- a/drivers/iio/imu/bmi323/bmi323.h
+++ b/drivers/iio/imu/bmi323/bmi323.h
@@ -204,6 +204,7 @@
 
 struct device;
 int bmi323_core_probe(struct device *dev);
+void bmi323_core_remove(struct device *dev);
 extern const struct regmap_config bmi323_regmap_config;
 extern const struct dev_pm_ops bmi323_core_pm_ops;
 
diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 4b2b211a3e88..edb9ce4e66a0 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -118,6 +118,24 @@ static const struct bmi323_hw bmi323_hw[2] = {
 	},
 };
 
+struct bmi323_ext_regs_settings {
+	unsigned int reg;
+	unsigned int val;
+};
+
+struct bmi323_regs_settings {
+	unsigned int reg;
+	unsigned int val;
+};
+
+#define EXT_SETTING_REGISTERS 12
+#define SETTING_REGISTERS 9
+
+struct bmi323_regs_runtime_pm {
+	struct bmi323_regs_settings reg_settings[SETTING_REGISTERS];
+	struct bmi323_ext_regs_settings ext_settings[EXT_SETTING_REGISTERS];
+};
+
 struct bmi323_data {
 	struct device *dev;
 	struct regmap *regmap;
@@ -130,6 +148,7 @@ struct bmi323_data {
 	u32 odrns[BMI323_SENSORS_CNT];
 	u32 odrhz[BMI323_SENSORS_CNT];
 	unsigned int feature_events;
+	struct bmi323_regs_runtime_pm runtime_pm_status;
 
 	/*
 	 * Lock to protect the members of device's private data from concurrent
@@ -1982,7 +2001,7 @@ static int bmi323_set_bw(struct bmi323_data *data,
 				  FIELD_PREP(BMI323_ACC_GYRO_CONF_BW_MSK, bw));
 }
 
-static int bmi323_init(struct bmi323_data *data)
+static int bmi323_init(struct bmi323_data *data, bool first_init)
 {
 	int ret, val;
 
@@ -2030,6 +2049,9 @@ static int bmi323_init(struct bmi323_data *data)
 		return dev_err_probe(data->dev, -EINVAL,
 				     "Sensor power error = 0x%x\n", val);
 
+	if (!first_init)
+		return 0;
+
 	/*
 	 * Set the Bandwidth coefficient which defines the 3 dB cutoff
 	 * frequency in relation to the ODR.
@@ -2078,9 +2100,32 @@ int bmi323_core_probe(struct device *dev)
 	data = iio_priv(indio_dev);
 	data->dev = dev;
 	data->regmap = regmap;
+	data->irq_pin = BMI323_IRQ_DISABLED;
+	data->state = BMI323_IDLE;
+	data->runtime_pm_status.reg_settings[0].reg = BMI323_INT_MAP1_REG;
+	data->runtime_pm_status.reg_settings[1].reg = BMI323_INT_MAP2_REG;
+	data->runtime_pm_status.reg_settings[2].reg = BMI323_IO_INT_CTR_REG;
+	data->runtime_pm_status.reg_settings[3].reg = BMI323_IO_INT_CONF_REG;
+	data->runtime_pm_status.reg_settings[4].reg = BMI323_ACC_CONF_REG;
+	data->runtime_pm_status.reg_settings[5].reg = BMI323_GYRO_CONF_REG;
+	data->runtime_pm_status.reg_settings[6].reg = BMI323_FEAT_IO0_REG;
+	data->runtime_pm_status.reg_settings[7].reg = BMI323_FIFO_WTRMRK_REG;
+	data->runtime_pm_status.reg_settings[8].reg = BMI323_FIFO_CONF_REG;
+	data->runtime_pm_status.ext_settings[0].reg = BMI323_GEN_SET1_REG;
+	data->runtime_pm_status.ext_settings[1].reg = BMI323_TAP1_REG;
+	data->runtime_pm_status.ext_settings[2].reg = BMI323_TAP2_REG;
+	data->runtime_pm_status.ext_settings[3].reg = BMI323_TAP3_REG;
+	data->runtime_pm_status.ext_settings[4].reg = BMI323_FEAT_IO0_S_TAP_MSK;
+	data->runtime_pm_status.ext_settings[5].reg = BMI323_STEP_SC1_REG;
+	data->runtime_pm_status.ext_settings[6].reg = BMI323_ANYMO1_REG;
+	data->runtime_pm_status.ext_settings[7].reg = BMI323_NOMO1_REG;
+	data->runtime_pm_status.ext_settings[8].reg = BMI323_ANYMO1_REG + BMI323_MO2_OFFSET;
+	data->runtime_pm_status.ext_settings[9].reg = BMI323_NOMO1_REG + BMI323_MO2_OFFSET;
+	data->runtime_pm_status.ext_settings[10].reg = BMI323_ANYMO1_REG + BMI323_MO3_OFFSET;
+	data->runtime_pm_status.ext_settings[11].reg = BMI323_NOMO1_REG + BMI323_MO3_OFFSET;
 	mutex_init(&data->mutex);
 
-	ret = bmi323_init(data);
+	ret = bmi323_init(data, true);
 	if (ret)
 		return -EINVAL;
 
@@ -2117,21 +2162,147 @@ int bmi323_core_probe(struct device *dev)
 		return dev_err_probe(data->dev, ret,
 				     "Unable to register iio device\n");
 
-	return 0;
+	return bmi323_fifo_disable(data);
 }
 EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 
+void bmi323_core_remove(struct device *dev)
+{
+	struct regmap *const regmap = dev_get_regmap(dev, NULL);
+
+	/*
+	 * Place the peripheral in its lowest power consuming state.
+	 */
+	if (regmap)
+		regmap_write(regmap, BMI323_CMD_REG, BMI323_RST_VAL);
+}
+EXPORT_SYMBOL_NS_GPL(bmi323_core_remove, IIO_BMI323);
+
 #if defined(CONFIG_PM)
 static int bmi323_core_runtime_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *const indio_dev = dev_get_drvdata(dev);
+	struct bmi323_data *const data = iio_priv(indio_dev);
+
+	int ret = 0;
+
+	guard(mutex)(&data->mutex);
 
-	return iio_device_suspend_triggering(indio_dev);
+	ret = iio_device_suspend_triggering(indio_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Save registers meant to be restored by resume pm callback.
+	 */
+	for (unsigned int i = 0; i < SETTING_REGISTERS; ++i) {
+		ret = regmap_read(data->regmap,
+			  data->runtime_pm_status.reg_settings[i].reg,
+			  &data->runtime_pm_status.reg_settings[i].val);
+		if (ret) {
+			dev_err(data->dev, "Error reading bmi323 reg 0x%x: %d\n",
+				  data->runtime_pm_status.ext_settings[i].reg, ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Save external registers meant to be restored by resume pm callback.
+	 */
+	for (unsigned int i = 0; i < EXT_SETTING_REGISTERS; ++i) {
+		ret = bmi323_read_ext_reg(data,
+			  data->runtime_pm_status.ext_settings[i].reg,
+			  &data->runtime_pm_status.ext_settings[i].val);
+		if (ret) {
+			dev_err(data->dev, "Error reading bmi323 external reg 0x%x: %d\n",
+				  data->runtime_pm_status.ext_settings[i].reg, ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Perform soft reset to place the device in its lowest power state.
+	 */
+	ret = regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int bmi323_core_runtime_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *const indio_dev = dev_get_drvdata(dev);
+	struct bmi323_data *const data = iio_priv(indio_dev);
+
+	int ret = 0;
+
+	guard(mutex)(&data->mutex);
+
+	/*
+	 * Perform the device power-on and initial setup once again
+	 * after being reset in the lower power state by runtime-pm.
+	 */
+	ret = bmi323_init(data, false);
+	if (!ret)
+		return ret;
+
+	/* Register must be cleared before changing an active config */
+	ret = regmap_write(data->regmap, BMI323_FEAT_IO0_REG, 0);
+	if (ret) {
+		dev_err(data->dev, "Error stopping feature engine\n");
+		return ret;
+	}
+
+	/*
+	 * Restore external registers saved by suspend pm callback.
+	 */
+	for (unsigned int i = 0; i < EXT_SETTING_REGISTERS; ++i) {
+		ret = bmi323_write_ext_reg(data,
+			data->runtime_pm_status.ext_settings[i].reg,
+			data->runtime_pm_status.ext_settings[i].val);
+		if (ret) {
+			dev_err(data->dev, "Error writing bmi323 external reg 0x%x: %d\n",
+				data->runtime_pm_status.ext_settings[i].reg, ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Restore registers saved by suspend pm callback.
+	 */
+	for (unsigned int i = 0; i < SETTING_REGISTERS; ++i) {
+		ret = regmap_write(data->regmap,
+			data->runtime_pm_status.reg_settings[i].reg,
+			data->runtime_pm_status.reg_settings[i].val);
+		if (ret) {
+			dev_err(data->dev, "Error writing bmi323 reg 0x%x: %d\n",
+				data->runtime_pm_status.reg_settings[i].reg, ret);
+			return ret;
+		}
+	}
+
+	if (data->state == BMI323_BUFFER_FIFO) {
+		ret = regmap_write(data->regmap, BMI323_FIFO_CTRL_REG,
+			   BMI323_FIFO_FLUSH_MSK);
+		if (ret) {
+			dev_err(data->dev, "Error flushing FIFO buffer: %d\n", ret);
+			return ret;
+		}
+	}
+
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, BMI323_ERR_REG, &val);
+	if (ret) {
+		dev_err(data->dev, "Error reading bmi323 error register: %d\n", ret);
+		return ret;
+	}
+
+	if (val) {
+		dev_err(data->dev, "Sensor power error in PM = 0x%x\n", val);
+		return -EINVAL;
+	}
 
 	return iio_device_resume_triggering(indio_dev);
 }
diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 0ba5d69d8329..2d93861281eb 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -93,6 +93,13 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
 	return bmi323_core_probe(dev);
 }
 
+static void bmi323_i2c_remove(struct i2c_client *i2c)
+{
+	struct device *const dev = &i2c->dev;
+
+	bmi323_core_remove(dev);
+}
+
 static const struct acpi_device_id bmi323_acpi_match[] = {
 	/*
 	 * The "BOSC0200" identifier used here is not unique to bmi323 devices.
@@ -133,6 +140,7 @@ static struct i2c_driver bmi323_i2c_driver = {
 		.acpi_match_table = bmi323_acpi_match,
 	},
 	.probe = bmi323_i2c_probe,
+	.remove = bmi323_i2c_remove,
 	.id_table = bmi323_i2c_ids,
 };
 module_i2c_driver(bmi323_i2c_driver);
diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
index 9de3ade78d71..f42c49c471c1 100644
--- a/drivers/iio/imu/bmi323/bmi323_spi.c
+++ b/drivers/iio/imu/bmi323/bmi323_spi.c
@@ -64,6 +64,13 @@ static int bmi323_spi_probe(struct spi_device *spi)
 	return bmi323_core_probe(dev);
 }
 
+static void bmi323_spi_remove(struct spi_device *spi)
+{
+	struct device *const dev = &spi->dev;
+
+	bmi323_core_remove(dev);
+}
+
 static const struct spi_device_id bmi323_spi_ids[] = {
 	{ "bmi323" },
 	{ }
@@ -83,6 +90,7 @@ static struct spi_driver bmi323_spi_driver = {
 		.of_match_table = bmi323_of_spi_match,
 	},
 	.probe = bmi323_spi_probe,
+	.remove = bmi323_spi_remove,
 	.id_table = bmi323_spi_ids,
 };
 module_spi_driver(bmi323_spi_driver);
-- 
2.46.0


