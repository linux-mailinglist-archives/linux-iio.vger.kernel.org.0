Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E13ED049
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhHPIav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhHPIaq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:30:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309C7C0613C1
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g21so11346720edw.4
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewp5U8kF+FXKWWMsgkBXPVYQxrHS+YarQYwuh1e7NlE=;
        b=Cl0HvK1UICHx9hQttcR4xAFSCqYF3MPUw0eteUvqDmocvcwGXjvdou0vA5jm9KYwlp
         ixToO0zTzEWX105tgO0U2+wBZUPIbRu7O/Imzu4+w/NtZ6ARByHQ6uX/h/RAbqzzoiTZ
         UkQAhJ+Gw1yBDu34UlfnpKAIOSdo3O7iGikShZYBKLlSCiKeHrImCYU286yiOdjs1U1Z
         ibuIaw1Kj9bpCk3zXIgZHxaVH8aCmo8Dw7iD/vcG2lxlJbcZlViYvH1fxUydi6t8XZCj
         StH1E6Hdz95eDpJC15YPaVZxCKO4mc2+3MDuhECFoFi0FLGDMv4glyvudWK7olZTNpWn
         YBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewp5U8kF+FXKWWMsgkBXPVYQxrHS+YarQYwuh1e7NlE=;
        b=HeDVezgBHBETcoGxmcb79rds6cyUXBaLzWCemuQCW8XeL0qo4V3xDBpJZHcIrlrPKV
         cvBf5kaald/mnFXqctK0kSvsKRuiZnaHdKcM/o7qFTt6aTsQYzS53S56XTKHuj7dqmO9
         a/4hKjtgCIY2AlpjiSFi07CLReYcgOFszxKjLXNNrI5YmB+Q4ljw59vk2Ze3QsyH9iRt
         TAT5Yky6riaUVqQ18tVoWvYNjg1+oKx/D0N/rfOhTPb+XvfUVc6w3alREKl87KkoliZC
         lFyIYEO7KkDXEDtQO6XsTFQD3/ATrOsgI57GaEdj3OTy0bdbm6tLpe9OFPwbgWFtFCF1
         L/5Q==
X-Gm-Message-State: AOAM533ow0xlgHW60Sa8btkY5WSYhuktxMWXclxKaGzKoD4vKOsUn9yz
        c7hZ/TY4q8PEOCDLMo5xBjJ+nixBh8l139uX
X-Google-Smtp-Source: ABdhPJw2e+JNZdcGnW3H4MoJ0vCzmr48tgxi+rzfwKAtnvxqxMtIw/PdkQkPZ9p/qfBq9Nf1uoxpbg==
X-Received: by 2002:aa7:d818:: with SMTP id v24mr14161145edq.170.1629102613530;
        Mon, 16 Aug 2021 01:30:13 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id q30sm4516878edi.84.2021.08.16.01.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:30:13 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 4/5] iio: st_sensors: remove all driver remove functions
Date:   Mon, 16 Aug 2021 11:28:35 +0300
Message-Id: <20210816082836.67511-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816082836.67511-1-aardelean@deviqon.com>
References: <20210816082836.67511-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

At this point all ST driver remove functions do iio_device_unregister().
This change removes them from them and replaces all iio_device_register()
with devm_iio_device_register().

This can be done in a single change relatively easy, since all these remove
functions are define in st_sensors.h.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_core.c            |  9 ++-------
 drivers/iio/accel/st_accel_i2c.c             | 10 ----------
 drivers/iio/accel/st_accel_spi.c             | 10 ----------
 drivers/iio/gyro/st_gyro_core.c              |  9 ++-------
 drivers/iio/gyro/st_gyro_i2c.c               | 10 ----------
 drivers/iio/gyro/st_gyro_spi.c               | 10 ----------
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      |  1 -
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 15 +--------------
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  |  6 ------
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  |  6 ------
 drivers/iio/magnetometer/st_magn_core.c      |  9 ++-------
 drivers/iio/magnetometer/st_magn_i2c.c       | 10 ----------
 drivers/iio/magnetometer/st_magn_spi.c       | 10 ----------
 drivers/iio/pressure/st_pressure_core.c      |  9 ++-------
 drivers/iio/pressure/st_pressure_i2c.c       | 10 ----------
 drivers/iio/pressure/st_pressure_spi.c       | 10 ----------
 include/linux/iio/common/st_sensors.h        |  4 ----
 17 files changed, 9 insertions(+), 139 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index a7be1633bff1..01695abd9d2f 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1335,6 +1335,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata = dev_get_platdata(adata->dev);
+	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1380,16 +1381,10 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(parent, indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_probe);
 
-void st_accel_common_remove(struct iio_dev *indio_dev)
-{
-	iio_device_unregister(indio_dev);
-}
-EXPORT_SYMBOL(st_accel_common_remove);
-
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index b377575efc41..c0ce78eebad9 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -180,15 +180,6 @@ static int st_accel_i2c_probe(struct i2c_client *client)
 	return st_accel_common_probe(indio_dev);
 }
 
-static int st_accel_i2c_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	st_accel_common_remove(indio_dev);
-
-	return 0;
-}
-
 static struct i2c_driver st_accel_driver = {
 	.driver = {
 		.name = "st-accel-i2c",
@@ -196,7 +187,6 @@ static struct i2c_driver st_accel_driver = {
 		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
 	.probe_new = st_accel_i2c_probe,
-	.remove = st_accel_i2c_remove,
 	.id_table = st_accel_id_table,
 };
 module_i2c_driver(st_accel_driver);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 4ca87e73bdb3..b74a1c6d03de 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -130,15 +130,6 @@ static int st_accel_spi_probe(struct spi_device *spi)
 	return st_accel_common_probe(indio_dev);
 }
 
-static int st_accel_spi_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	st_accel_common_remove(indio_dev);
-
-	return 0;
-}
-
 static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS3DH_ACCEL_DEV_NAME },
 	{ LSM330D_ACCEL_DEV_NAME },
@@ -166,7 +157,6 @@ static struct spi_driver st_accel_driver = {
 		.of_match_table = st_accel_of_match,
 	},
 	.probe = st_accel_spi_probe,
-	.remove = st_accel_spi_remove,
 	.id_table = st_accel_id_table,
 };
 module_spi_driver(st_accel_driver);
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index cb539b47cdf4..3609082a6778 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -478,6 +478,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata;
+	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -515,16 +516,10 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(parent, indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_probe);
 
-void st_gyro_common_remove(struct iio_dev *indio_dev)
-{
-	iio_device_unregister(indio_dev);
-}
-EXPORT_SYMBOL(st_gyro_common_remove);
-
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics gyroscopes driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 0bd80dfd389f..163c7ba300c1 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -93,15 +93,6 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	return st_gyro_common_probe(indio_dev);
 }
 
-static int st_gyro_i2c_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	st_gyro_common_remove(indio_dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id st_gyro_id_table[] = {
 	{ L3G4200D_GYRO_DEV_NAME },
 	{ LSM330D_GYRO_DEV_NAME },
@@ -122,7 +113,6 @@ static struct i2c_driver st_gyro_driver = {
 		.of_match_table = st_gyro_of_match,
 	},
 	.probe = st_gyro_i2c_probe,
-	.remove = st_gyro_i2c_remove,
 	.id_table = st_gyro_id_table,
 };
 module_i2c_driver(st_gyro_driver);
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index f74b09fa5cde..b0023f9b9771 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -97,15 +97,6 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	return st_gyro_common_probe(indio_dev);
 }
 
-static int st_gyro_spi_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	st_gyro_common_remove(indio_dev);
-
-	return 0;
-}
-
 static const struct spi_device_id st_gyro_id_table[] = {
 	{ L3G4200D_GYRO_DEV_NAME },
 	{ LSM330D_GYRO_DEV_NAME },
@@ -126,7 +117,6 @@ static struct spi_driver st_gyro_driver = {
 		.of_match_table = st_gyro_of_match,
 	},
 	.probe = st_gyro_spi_probe,
-	.remove = st_gyro_spi_remove,
 	.id_table = st_gyro_id_table,
 };
 module_spi_driver(st_gyro_driver);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
index 146393afd9a7..76678cdefb07 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
@@ -18,6 +18,5 @@ struct st_lsm9ds0 {
 };
 
 int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap);
-int st_lsm9ds0_remove(struct st_lsm9ds0 *lsm9ds0);
 
 #endif /* ST_LSM9DS0_H */
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index 5e6625140db7..d276f663fe57 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -142,23 +142,10 @@ int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
 		return ret;
 
 	/* Setup magnetometer device */
-	ret = st_lsm9ds0_probe_magn(lsm9ds0, regmap);
-	if (ret)
-		st_accel_common_remove(lsm9ds0->accel);
-
-	return ret;
+	return st_lsm9ds0_probe_magn(lsm9ds0, regmap);
 }
 EXPORT_SYMBOL_GPL(st_lsm9ds0_probe);
 
-int st_lsm9ds0_remove(struct st_lsm9ds0 *lsm9ds0)
-{
-	st_magn_common_remove(lsm9ds0->magn);
-	st_accel_common_remove(lsm9ds0->accel);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(st_lsm9ds0_remove);
-
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 78bede358747..8f205c477e6f 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -64,18 +64,12 @@ static int st_lsm9ds0_i2c_probe(struct i2c_client *client)
 	return st_lsm9ds0_probe(lsm9ds0, regmap);
 }
 
-static int st_lsm9ds0_i2c_remove(struct i2c_client *client)
-{
-	return st_lsm9ds0_remove(i2c_get_clientdata(client));
-}
-
 static struct i2c_driver st_lsm9ds0_driver = {
 	.driver = {
 		.name = "st-lsm9ds0-i2c",
 		.of_match_table = st_lsm9ds0_of_match,
 	},
 	.probe_new = st_lsm9ds0_i2c_probe,
-	.remove = st_lsm9ds0_i2c_remove,
 	.id_table = st_lsm9ds0_id_table,
 };
 module_i2c_driver(st_lsm9ds0_driver);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 180b54e66438..0ddfa53166af 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -63,18 +63,12 @@ static int st_lsm9ds0_spi_probe(struct spi_device *spi)
 	return st_lsm9ds0_probe(lsm9ds0, regmap);
 }
 
-static int st_lsm9ds0_spi_remove(struct spi_device *spi)
-{
-	return st_lsm9ds0_remove(spi_get_drvdata(spi));
-}
-
 static struct spi_driver st_lsm9ds0_driver = {
 	.driver = {
 		.name = "st-lsm9ds0-spi",
 		.of_match_table = st_lsm9ds0_of_match,
 	},
 	.probe = st_lsm9ds0_spi_probe,
-	.remove = st_lsm9ds0_spi_remove,
 	.id_table = st_lsm9ds0_id_table,
 };
 module_spi_driver(st_lsm9ds0_driver);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 5be85e2405a5..1458906a3765 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -612,6 +612,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata = dev_get_platdata(mdata->dev);
+	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -650,16 +651,10 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(parent, indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_probe);
 
-void st_magn_common_remove(struct iio_dev *indio_dev)
-{
-	iio_device_unregister(indio_dev);
-}
-EXPORT_SYMBOL(st_magn_common_remove);
-
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics magnetometers driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 0a5117dffcf4..7237711fc09b 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -89,15 +89,6 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 	return st_magn_common_probe(indio_dev);
 }
 
-static int st_magn_i2c_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	st_magn_common_remove(indio_dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id st_magn_id_table[] = {
 	{ LSM303DLH_MAGN_DEV_NAME },
 	{ LSM303DLHC_MAGN_DEV_NAME },
@@ -117,7 +108,6 @@ static struct i2c_driver st_magn_driver = {
 		.of_match_table = st_magn_of_match,
 	},
 	.probe = st_magn_i2c_probe,
-	.remove = st_magn_i2c_remove,
 	.id_table = st_magn_id_table,
 };
 module_i2c_driver(st_magn_driver);
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 1f3bf02b24e0..489d4462862f 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -83,15 +83,6 @@ static int st_magn_spi_probe(struct spi_device *spi)
 	return st_magn_common_probe(indio_dev);
 }
 
-static int st_magn_spi_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	st_magn_common_remove(indio_dev);
-
-	return 0;
-}
-
 static const struct spi_device_id st_magn_id_table[] = {
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
@@ -108,7 +99,6 @@ static struct spi_driver st_magn_driver = {
 		.of_match_table = st_magn_of_match,
 	},
 	.probe = st_magn_spi_probe,
-	.remove = st_magn_spi_remove,
 	.id_table = st_magn_id_table,
 };
 module_spi_driver(st_magn_driver);
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 17ebb5171d4c..cebcc1d93d0b 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -678,6 +678,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata = dev_get_platdata(press_data->dev);
+	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -721,16 +722,10 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(parent, indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_probe);
 
-void st_press_common_remove(struct iio_dev *indio_dev)
-{
-	iio_device_unregister(indio_dev);
-}
-EXPORT_SYMBOL(st_press_common_remove);
-
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics pressures driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index afeeab485c0d..1939e999a427 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -106,15 +106,6 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	return st_press_common_probe(indio_dev);
 }
 
-static int st_press_i2c_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	st_press_common_remove(indio_dev);
-
-	return 0;
-}
-
 static struct i2c_driver st_press_driver = {
 	.driver = {
 		.name = "st-press-i2c",
@@ -122,7 +113,6 @@ static struct i2c_driver st_press_driver = {
 		.acpi_match_table = ACPI_PTR(st_press_acpi_match),
 	},
 	.probe = st_press_i2c_probe,
-	.remove = st_press_i2c_remove,
 	.id_table = st_press_id_table,
 };
 module_i2c_driver(st_press_driver);
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 834ad6d40a70..9b2523c5bc94 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -89,15 +89,6 @@ static int st_press_spi_probe(struct spi_device *spi)
 	return st_press_common_probe(indio_dev);
 }
 
-static int st_press_spi_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	st_press_common_remove(indio_dev);
-
-	return 0;
-}
-
 static const struct spi_device_id st_press_id_table[] = {
 	{ LPS001WP_PRESS_DEV_NAME },
 	{ LPS25H_PRESS_DEV_NAME },
@@ -116,7 +107,6 @@ static struct spi_driver st_press_driver = {
 		.of_match_table = st_press_of_match,
 	},
 	.probe = st_press_spi_probe,
-	.remove = st_press_spi_remove,
 	.id_table = st_press_id_table,
 };
 module_spi_driver(st_press_driver);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index fc90c202d15e..d17ae1e5ca19 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -323,21 +323,17 @@ void st_sensors_dev_name_probe(struct device *dev, char *name, int len);
 /* Accelerometer */
 const struct st_sensor_settings *st_accel_get_settings(const char *name);
 int st_accel_common_probe(struct iio_dev *indio_dev);
-void st_accel_common_remove(struct iio_dev *indio_dev);
 
 /* Gyroscope */
 const struct st_sensor_settings *st_gyro_get_settings(const char *name);
 int st_gyro_common_probe(struct iio_dev *indio_dev);
-void st_gyro_common_remove(struct iio_dev *indio_dev);
 
 /* Magnetometer */
 const struct st_sensor_settings *st_magn_get_settings(const char *name);
 int st_magn_common_probe(struct iio_dev *indio_dev);
-void st_magn_common_remove(struct iio_dev *indio_dev);
 
 /* Pressure */
 const struct st_sensor_settings *st_press_get_settings(const char *name);
 int st_press_common_probe(struct iio_dev *indio_dev);
-void st_press_common_remove(struct iio_dev *indio_dev);
 
 #endif /* ST_SENSORS_H */
-- 
2.31.1

