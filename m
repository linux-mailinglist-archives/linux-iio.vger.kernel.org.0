Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012C5481FE8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhL3T2T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57984 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbhL3T2T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C492B615F1
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065E4C36AEB;
        Thu, 30 Dec 2021 19:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892498;
        bh=sOX13OXwiE3BhEO1SA1qKAKQUWdTEtDF0jEs19P7I8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lz8rcGeRC8m9B+h5LpbtMF37zsI4w4+M9aPpropFqGXGyUpPp0qSIGNB7Cire4r10
         VqJI7OA9MACtUz17CJXQWGmFlmr4l3QdIqQykfGrR36TMfPCIogAQvbvHv/sHoR/d5
         XpaS4CdDFOou9umnj+CfrgKwy1MQLTDQnipALBSy41HzGSVAKjk0gPt3NVYh8lffR+
         t5voI+3Hvm28DfHmK0DVXv77nZCq7N5Xuu/odV3tznMjdciBx9FwiiR+R9ZI/DpUM+
         vIC7OinwLEQgjBSAYgi3etjXEV0/nUWHE8zC3LE/KKVJ46PaLiWbhuiy7D+16HUH6k
         QSbhRCohmI4Nw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 13/13] iio:st-sensors: Move exports into ST_SENSORS namespace
Date:   Thu, 30 Dec 2021 19:33:31 +0000
Message-Id: <20211230193331.283503-14-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To avoid unnecessary pollution of the global symbol namespace move the
driver core and type specific core exports into their a new namespace
and import that where needed.

For more info see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c             |  5 ++--
 drivers/iio/accel/st_accel_i2c.c              |  1 +
 drivers/iio/accel/st_accel_spi.c              |  1 +
 .../iio/common/st_sensors/st_sensors_buffer.c |  2 +-
 .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++++----------
 .../iio/common/st_sensors/st_sensors_i2c.c    |  2 +-
 .../iio/common/st_sensors/st_sensors_spi.c    |  2 +-
 .../common/st_sensors/st_sensors_trigger.c    |  4 +--
 drivers/iio/gyro/st_gyro_core.c               |  5 ++--
 drivers/iio/gyro/st_gyro_i2c.c                |  1 +
 drivers/iio/gyro/st_gyro_spi.c                |  1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  |  3 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  1 +
 drivers/iio/magnetometer/st_magn_core.c       |  5 ++--
 drivers/iio/magnetometer/st_magn_i2c.c        |  1 +
 drivers/iio/magnetometer/st_magn_spi.c        |  1 +
 drivers/iio/pressure/st_pressure_core.c       |  5 ++--
 drivers/iio/pressure/st_pressure_i2c.c        |  1 +
 drivers/iio/pressure/st_pressure_spi.c        |  1 +
 20 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 31ea19d0ba71..4bb4ce081d45 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1329,7 +1329,7 @@ const struct st_sensor_settings *st_accel_get_settings(const char *name)
 
 	return &st_accel_sensors_settings[index];
 }
-EXPORT_SYMBOL(st_accel_get_settings);
+EXPORT_SYMBOL_NS(st_accel_get_settings, ST_SENSORS);
 
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
@@ -1383,8 +1383,9 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 
 	return devm_iio_device_register(parent, indio_dev);
 }
-EXPORT_SYMBOL(st_accel_common_probe);
+EXPORT_SYMBOL_NS(st_accel_common_probe, ST_SENSORS);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c0ce78eebad9..88b2b1767bf2 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -194,3 +194,4 @@ module_i2c_driver(st_accel_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index b74a1c6d03de..cecd6a38949e 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -164,3 +164,4 @@ module_spi_driver(st_accel_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 5f2b1fb95fd7..668f825f22a6 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -76,4 +76,4 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 
 	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL(st_sensors_trigger_handler);
+EXPORT_SYMBOL_NS(st_sensors_trigger_handler, ST_SENSORS);
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index eb452d0c423c..2708a5e9b43d 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -46,7 +46,7 @@ int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(st_sensors_debugfs_reg_access);
+EXPORT_SYMBOL_NS(st_sensors_debugfs_reg_access, ST_SENSORS);
 
 static int st_sensors_match_odr(struct st_sensor_settings *sensor_settings,
 			unsigned int odr, struct st_sensor_odr_avl *odr_out)
@@ -106,7 +106,7 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 st_sensors_match_odr_error:
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_set_odr);
+EXPORT_SYMBOL_NS(st_sensors_set_odr, ST_SENSORS);
 
 static int st_sensors_match_fs(struct st_sensor_settings *sensor_settings,
 					unsigned int fs, int *index_fs_avl)
@@ -199,7 +199,7 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 set_enable_error:
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_set_enable);
+EXPORT_SYMBOL_NS(st_sensors_set_enable, ST_SENSORS);
 
 int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 {
@@ -213,7 +213,7 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 				axis_enable);
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_set_axis_enable);
+EXPORT_SYMBOL_NS(st_sensors_set_axis_enable, ST_SENSORS);
 
 static void st_reg_disable(void *reg)
 {
@@ -257,7 +257,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 
 	return devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd_io);
 }
-EXPORT_SYMBOL(st_sensors_power_enable);
+EXPORT_SYMBOL_NS(st_sensors_power_enable, ST_SENSORS);
 
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
@@ -352,7 +352,7 @@ void st_sensors_dev_name_probe(struct device *dev, char *name, int len)
 	/* The name from the match takes precedence if present */
 	strlcpy(name, match, len);
 }
-EXPORT_SYMBOL(st_sensors_dev_name_probe);
+EXPORT_SYMBOL_NS(st_sensors_dev_name_probe, ST_SENSORS);
 
 int st_sensors_init_sensor(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
@@ -437,7 +437,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_init_sensor);
+EXPORT_SYMBOL_NS(st_sensors_init_sensor, ST_SENSORS);
 
 int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 {
@@ -486,7 +486,7 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 st_accel_set_dataready_irq_error:
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_set_dataready_irq);
+EXPORT_SYMBOL_NS(st_sensors_set_dataready_irq, ST_SENSORS);
 
 int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale)
 {
@@ -509,7 +509,7 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale)
 st_sensors_match_scale_error:
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_set_fullscale_by_gain);
+EXPORT_SYMBOL_NS(st_sensors_set_fullscale_by_gain, ST_SENSORS);
 
 static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *ch, int *data)
@@ -572,7 +572,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_read_info_raw);
+EXPORT_SYMBOL_NS(st_sensors_read_info_raw, ST_SENSORS);
 
 /*
  * st_sensors_get_settings_index() - get index of the sensor settings for a
@@ -599,7 +599,7 @@ int st_sensors_get_settings_index(const char *name,
 
 	return -ENODEV;
 }
-EXPORT_SYMBOL(st_sensors_get_settings_index);
+EXPORT_SYMBOL_NS(st_sensors_get_settings_index, ST_SENSORS);
 
 /*
  * st_sensors_verify_id() - verify sensor ID (WhoAmI) is matching with the
@@ -632,7 +632,7 @@ int st_sensors_verify_id(struct iio_dev *indio_dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(st_sensors_verify_id);
+EXPORT_SYMBOL_NS(st_sensors_verify_id, ST_SENSORS);
 
 ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -654,7 +654,7 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 
 	return len;
 }
-EXPORT_SYMBOL(st_sensors_sysfs_sampling_frequency_avail);
+EXPORT_SYMBOL_NS(st_sensors_sysfs_sampling_frequency_avail, ST_SENSORS);
 
 ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -678,7 +678,7 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 
 	return len;
 }
-EXPORT_SYMBOL(st_sensors_sysfs_scale_avail);
+EXPORT_SYMBOL_NS(st_sensors_sysfs_scale_avail, ST_SENSORS);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors core");
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 18bd3c3d99bc..7f9fcc84e032 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -61,7 +61,7 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(st_sensors_i2c_configure);
+EXPORT_SYMBOL_NS(st_sensors_i2c_configure, ST_SENSORS);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors i2c driver");
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 7c60050e90dc..bf3893d619ee 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -113,7 +113,7 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(st_sensors_spi_configure);
+EXPORT_SYMBOL_NS(st_sensors_spi_configure, ST_SENSORS);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors spi driver");
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index ab7a5a24fa6e..1f382d011146 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -227,7 +227,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(st_sensors_allocate_trigger);
+EXPORT_SYMBOL_NS(st_sensors_allocate_trigger, ST_SENSORS);
 
 int st_sensors_validate_device(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev)
@@ -239,4 +239,4 @@ int st_sensors_validate_device(struct iio_trigger *trig,
 
 	return 0;
 }
-EXPORT_SYMBOL(st_sensors_validate_device);
+EXPORT_SYMBOL_NS(st_sensors_validate_device, ST_SENSORS);
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 201050b76fe5..fe599f909806 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -472,7 +472,7 @@ const struct st_sensor_settings *st_gyro_get_settings(const char *name)
 
 	return &st_gyro_sensors_settings[index];
 }
-EXPORT_SYMBOL(st_gyro_get_settings);
+EXPORT_SYMBOL_NS(st_gyro_get_settings, ST_SENSORS);
 
 int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
@@ -518,8 +518,9 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 
 	return devm_iio_device_register(parent, indio_dev);
 }
-EXPORT_SYMBOL(st_gyro_common_probe);
+EXPORT_SYMBOL_NS(st_gyro_common_probe, ST_SENSORS);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics gyroscopes driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 163c7ba300c1..4784ad819f73 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -120,3 +120,4 @@ module_i2c_driver(st_gyro_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics gyroscopes i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index b0023f9b9771..4c6b8b15f894 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -124,3 +124,4 @@ module_spi_driver(st_gyro_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics gyroscopes spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index 9fb06b7cde3c..48fbd3905074 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -142,8 +142,9 @@ int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
 	/* Setup magnetometer device */
 	return st_lsm9ds0_probe_magn(lsm9ds0, regmap);
 }
-EXPORT_SYMBOL_GPL(st_lsm9ds0_probe);
+EXPORT_SYMBOL_NS_GPL(st_lsm9ds0_probe, ST_SENSORS);
 
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU core driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 8f205c477e6f..019b16809f84 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -77,3 +77,4 @@ module_i2c_driver(st_lsm9ds0_driver);
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 0ddfa53166af..4d631bcb7f41 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -76,3 +76,4 @@ module_spi_driver(st_lsm9ds0_driver);
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 0806a1e65ce4..9f126361b5f0 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -606,7 +606,7 @@ const struct st_sensor_settings *st_magn_get_settings(const char *name)
 
 	return &st_magn_sensors_settings[index];
 }
-EXPORT_SYMBOL(st_magn_get_settings);
+EXPORT_SYMBOL_NS(st_magn_get_settings, ST_SENSORS);
 
 int st_magn_common_probe(struct iio_dev *indio_dev)
 {
@@ -653,8 +653,9 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 
 	return devm_iio_device_register(parent, indio_dev);
 }
-EXPORT_SYMBOL(st_magn_common_probe);
+EXPORT_SYMBOL_NS(st_magn_common_probe, ST_SENSORS);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics magnetometers driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 7237711fc09b..f4a07d89543e 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -115,3 +115,4 @@ module_i2c_driver(st_magn_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics magnetometers i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 489d4462862f..316a1d6c1647 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -106,3 +106,4 @@ module_spi_driver(st_magn_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics magnetometers spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 26a1ee43d56e..14524d8c9783 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -672,7 +672,7 @@ const struct st_sensor_settings *st_press_get_settings(const char *name)
 
 	return &st_press_sensors_settings[index];
 }
-EXPORT_SYMBOL(st_press_get_settings);
+EXPORT_SYMBOL_NS(st_press_get_settings, ST_SENSORS);
 
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
@@ -724,8 +724,9 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 
 	return devm_iio_device_register(parent, indio_dev);
 }
-EXPORT_SYMBOL(st_press_common_probe);
+EXPORT_SYMBOL_NS(st_press_common_probe, ST_SENSORS);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics pressures driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 1939e999a427..3ce69a14fc69 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -120,3 +120,4 @@ module_i2c_driver(st_press_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics pressures i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index d6fc954e28f8..a5302f95e82b 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -118,3 +118,4 @@ module_spi_driver(st_press_driver);
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics pressures spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ST_SENSORS);
-- 
2.34.1

