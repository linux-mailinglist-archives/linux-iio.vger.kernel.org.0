Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1E3F49A1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhHWLXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhHWLXV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 07:23:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4EC061757
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:22:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d11so36169594eja.8
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9XBBA/DxBRUbkAKTdvn+MMYF0neeU5xKvR7uBwUTh0=;
        b=SM0uU8v4yv2DBhPOnlKwb28YVTmSxe1NdKFU4OsU8yGMGmaubLpdigtiexgNjWsTbb
         wwnCxjI0pIdIqb84ju/kCp7RCt+xMg++hia9sF+KYSkzdIstV7FpGsP0J+h9pAPp/cro
         PxpkHsOk/CbLQw5RTDjz7TBPR/uVIR9HxpIASTS33FbCnCHmCq8gNO5PiJ3Y3Kequpft
         N97E5n5Bi2jgG3iI+TmYyjTE+qdCvNueGzRbXut+MBymIma3o6BAXbMT5v+jfFdaMgA0
         aj4X5mZkR8BRVqsR32crNwMWDJuGjfcAO4QV4tZAAfiUumfLUHl3j9cXjP48t8g9cAHs
         5kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9XBBA/DxBRUbkAKTdvn+MMYF0neeU5xKvR7uBwUTh0=;
        b=oyt1W9VF3nZgux+Xn7pYrlgiUXEZEVczEPOvU7DTuZyVPj+4GSJpXIpMKKEBXlGgPM
         AIozihBB+J6QvY4lNZUgzXOfAh9r5go1NfeCZwwrg9ZjW58dvPY9DeT0fvWB7dLy4iLC
         pSI+7u09+2SUw1LlGshig2lei1qfxwBt2xPDkrd+0uJs9w6vz5jdXA9G8IkGeaxgDsuK
         jnr9gNOWH30KVoqJRPN7L7X5Jty1hAS3559EPZsgsFkk3aI5MuZTQEQNm4Vzx+aRikg6
         PIFSE0Dtx0X7frbCTPq3zCtcE3hVHejFCGXyNazH777iumUp4bQ9y03rytTfEt/vWhCA
         XRug==
X-Gm-Message-State: AOAM531k9lK4sfVsKUS2X3/s/4s2lQ4Xz3bfHoxEo9GztOEG7RswG2ib
        FnK0KfCOsL3dqXYD22ErCfeZUdUITOSdgYoE
X-Google-Smtp-Source: ABdhPJxU6bPtOKVarEFjTXqKMZDir2BQyqYlvv5z9XFDl49yKhQurDziurJPjPrPQadYuiJ27ThCAQ==
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr35233801ejb.3.1629717756974;
        Mon, 23 Aug 2021 04:22:36 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id d22sm7382212ejj.47.2021.08.23.04.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:22:36 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, andy.shevchenko@gmail.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 3/5] iio: st_sensors: remove st_sensors_power_disable() function
Date:   Mon, 23 Aug 2021 14:22:02 +0300
Message-Id: <20210823112204.243255-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210823112204.243255-1-aardelean@deviqon.com>
References: <20210823112204.243255-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the st_sensors_power_enable() function to use
devm_add_action_or_reset() handlers to register regulator_disable hooks for
when the drivers get unloaded.

The parent device of the IIO device object is used. This is based on the
assumption that all other devm_ calls in the ST sensors use this reference.

This makes the st_sensors_power_disable() un-needed.
Removing this also changes unload order a bit, as all ST drivers would call
st_sensors_power_disable() first and iio_device_unregister() after that.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_i2c.c              | 13 +------
 drivers/iio/accel/st_accel_spi.c              | 13 +------
 .../iio/common/st_sensors/st_sensors_core.c   | 34 ++++++++-----------
 drivers/iio/gyro/st_gyro_i2c.c                | 13 +------
 drivers/iio/gyro/st_gyro_spi.c                | 13 +------
 drivers/iio/magnetometer/st_magn_i2c.c        | 13 +------
 drivers/iio/magnetometer/st_magn_spi.c        | 13 +------
 drivers/iio/pressure/st_pressure_i2c.c        | 13 +------
 drivers/iio/pressure/st_pressure_spi.c        | 13 +------
 include/linux/iio/common/st_sensors.h         |  2 --
 10 files changed, 23 insertions(+), 117 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index cba57459e90a..b377575efc41 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -177,16 +177,7 @@ static int st_accel_i2c_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = st_accel_common_probe(indio_dev);
-	if (ret < 0)
-		goto st_accel_power_off;
-
-	return 0;
-
-st_accel_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return ret;
+	return st_accel_common_probe(indio_dev);
 }
 
 static int st_accel_i2c_remove(struct i2c_client *client)
@@ -195,8 +186,6 @@ static int st_accel_i2c_remove(struct i2c_client *client)
 
 	st_accel_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 5167fae1ee8e..4ca87e73bdb3 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -127,16 +127,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_accel_common_probe(indio_dev);
-	if (err < 0)
-		goto st_accel_power_off;
-
-	return 0;
-
-st_accel_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_accel_common_probe(indio_dev);
 }
 
 static int st_accel_spi_remove(struct spi_device *spi)
@@ -145,8 +136,6 @@ static int st_accel_spi_remove(struct spi_device *spi)
 
 	st_accel_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 0bbb090b108c..a5a140de9a23 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -215,13 +215,19 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 }
 EXPORT_SYMBOL(st_sensors_set_axis_enable);
 
+static void st_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 int st_sensors_power_enable(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	/* Regulators not mandatory, but if requested we should enable them. */
-	pdata->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
+	pdata->vdd = devm_regulator_get(parent, "vdd");
 	if (IS_ERR(pdata->vdd)) {
 		dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
 		return PTR_ERR(pdata->vdd);
@@ -233,36 +239,26 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 		return err;
 	}
 
-	pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent, "vddio");
+	err = devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd);
+	if (err)
+		return err;
+
+	pdata->vdd_io = devm_regulator_get(parent, "vddio");
 	if (IS_ERR(pdata->vdd_io)) {
 		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
-		err = PTR_ERR(pdata->vdd_io);
-		goto st_sensors_disable_vdd;
+		return PTR_ERR(pdata->vdd_io);
 	}
 	err = regulator_enable(pdata->vdd_io);
 	if (err != 0) {
 		dev_warn(&indio_dev->dev,
 			 "Failed to enable specified Vdd_IO supply\n");
-		goto st_sensors_disable_vdd;
+		return err;
 	}
 
-	return 0;
-
-st_sensors_disable_vdd:
-	regulator_disable(pdata->vdd);
-	return err;
+	return devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd_io);
 }
 EXPORT_SYMBOL(st_sensors_power_enable);
 
-void st_sensors_power_disable(struct iio_dev *indio_dev)
-{
-	struct st_sensor_data *pdata = iio_priv(indio_dev);
-
-	regulator_disable(pdata->vdd);
-	regulator_disable(pdata->vdd_io);
-}
-EXPORT_SYMBOL(st_sensors_power_disable);
-
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index a8164fe48b85..0bd80dfd389f 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -90,16 +90,7 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	err = st_gyro_common_probe(indio_dev);
-	if (err < 0)
-		goto st_gyro_power_off;
-
-	return 0;
-
-st_gyro_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_gyro_common_probe(indio_dev);
 }
 
 static int st_gyro_i2c_remove(struct i2c_client *client)
@@ -108,8 +99,6 @@ static int st_gyro_i2c_remove(struct i2c_client *client)
 
 	st_gyro_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 9d8916871b4b..f74b09fa5cde 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -94,16 +94,7 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_gyro_common_probe(indio_dev);
-	if (err < 0)
-		goto st_gyro_power_off;
-
-	return 0;
-
-st_gyro_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_gyro_common_probe(indio_dev);
 }
 
 static int st_gyro_spi_remove(struct spi_device *spi)
@@ -112,8 +103,6 @@ static int st_gyro_spi_remove(struct spi_device *spi)
 
 	st_gyro_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index fa78f0a3b53e..0a5117dffcf4 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -86,16 +86,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		goto st_magn_power_off;
-
-	return 0;
-
-st_magn_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_magn_common_probe(indio_dev);
 }
 
 static int st_magn_i2c_remove(struct i2c_client *client)
@@ -104,8 +95,6 @@ static int st_magn_i2c_remove(struct i2c_client *client)
 
 	st_magn_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index ff43cbf61b05..1f3bf02b24e0 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -80,16 +80,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		goto st_magn_power_off;
-
-	return 0;
-
-st_magn_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_magn_common_probe(indio_dev);
 }
 
 static int st_magn_spi_remove(struct spi_device *spi)
@@ -98,8 +89,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 
 	st_magn_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 6215de677017..afeeab485c0d 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -103,16 +103,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = st_press_common_probe(indio_dev);
-	if (ret < 0)
-		goto st_press_power_off;
-
-	return 0;
-
-st_press_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return ret;
+	return st_press_common_probe(indio_dev);
 }
 
 static int st_press_i2c_remove(struct i2c_client *client)
@@ -121,8 +112,6 @@ static int st_press_i2c_remove(struct i2c_client *client)
 
 	st_press_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 5001aae8f00b..834ad6d40a70 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -86,16 +86,7 @@ static int st_press_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_press_common_probe(indio_dev);
-	if (err < 0)
-		goto st_press_power_off;
-
-	return 0;
-
-st_press_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_press_common_probe(indio_dev);
 }
 
 static int st_press_spi_remove(struct spi_device *spi)
@@ -104,8 +95,6 @@ static int st_press_spi_remove(struct spi_device *spi)
 
 	st_press_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index e74b55244f35..fc90c202d15e 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -293,8 +293,6 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
 
 int st_sensors_power_enable(struct iio_dev *indio_dev);
 
-void st_sensors_power_disable(struct iio_dev *indio_dev);
-
 int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
 				  unsigned reg, unsigned writeval,
 				  unsigned *readval);
-- 
2.31.1

