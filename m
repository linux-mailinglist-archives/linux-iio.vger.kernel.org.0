Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FEF35FC06
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353563AbhDNTzX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 15:55:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:35241 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353554AbhDNTzU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Apr 2021 15:55:20 -0400
IronPort-SDR: E6j5l+Wv3UA6xoGZprUU0ovfSl9FdV9hlVVRuN306OUPV+Q+XHuZG55qfJ4levzX8rM1/ovudv
 lYcdhfDQG+yQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258686521"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="258686521"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:54:57 -0700
IronPort-SDR: QS6uxTn3MXW/nqj9CcB8e4C6VcBtOmOu+rpoMf/fYxVg9H5OCl+1tR2DM9m1LQklKAMkEfpkpG
 /I2KTn7GMy7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="612222032"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2021 12:54:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 617B31D2; Wed, 14 Apr 2021 22:55:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 5/7] iio: st_sensors: Make accel, gyro, magn and pressure probe shared
Date:   Wed, 14 Apr 2021 22:54:52 +0300
Message-Id: <20210414195454.84183-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some IMUs may utilize existing library code for STMicro accelerometer,
gyroscope, magnetometer and pressure. Let's share them via st_sensors.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel.h          |  4 ----
 drivers/iio/gyro/st_gyro.h            |  4 ----
 drivers/iio/magnetometer/st_magn.h    |  4 ----
 drivers/iio/pressure/st_pressure.h    |  4 ----
 include/linux/iio/common/st_sensors.h | 20 ++++++++++++++++++++
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 181ebe79c4eb..f5b0b8bbaff7 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -62,10 +62,6 @@ enum st_accel_type {
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
 
-const struct st_sensor_settings *st_accel_get_settings(const char *name);
-int st_accel_common_probe(struct iio_dev *indio_dev);
-void st_accel_common_remove(struct iio_dev *indio_dev);
-
 #ifdef CONFIG_IIO_BUFFER
 int st_accel_allocate_ring(struct iio_dev *indio_dev);
 void st_accel_deallocate_ring(struct iio_dev *indio_dev);
diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index b385fe664dcc..6537f5cb8320 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -24,10 +24,6 @@
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 #define LSM9DS0_GYRO_DEV_NAME		"lsm9ds0_gyro"
 
-const struct st_sensor_settings *st_gyro_get_settings(const char *name);
-int st_gyro_common_probe(struct iio_dev *indio_dev);
-void st_gyro_common_remove(struct iio_dev *indio_dev);
-
 #ifdef CONFIG_IIO_BUFFER
 int st_gyro_allocate_ring(struct iio_dev *indio_dev);
 void st_gyro_deallocate_ring(struct iio_dev *indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 204b285725c8..143b6fb4ae8d 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -22,10 +22,6 @@
 #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
 #define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
 
-const struct st_sensor_settings *st_magn_get_settings(const char *name);
-int st_magn_common_probe(struct iio_dev *indio_dev);
-void st_magn_common_remove(struct iio_dev *indio_dev);
-
 #ifdef CONFIG_IIO_BUFFER
 int st_magn_allocate_ring(struct iio_dev *indio_dev);
 void st_magn_deallocate_ring(struct iio_dev *indio_dev);
diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 5c746ff6087e..9417b3bd7513 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -41,10 +41,6 @@ static __maybe_unused const struct st_sensors_platform_data default_press_pdata
 	.drdy_int_pin = 1,
 };
 
-const struct st_sensor_settings *st_press_get_settings(const char *name);
-int st_press_common_probe(struct iio_dev *indio_dev);
-void st_press_common_remove(struct iio_dev *indio_dev);
-
 #ifdef CONFIG_IIO_BUFFER
 int st_press_allocate_ring(struct iio_dev *indio_dev);
 void st_press_deallocate_ring(struct iio_dev *indio_dev);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 33e939977444..aa017b90fb06 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -317,4 +317,24 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 
 void st_sensors_dev_name_probe(struct device *dev, char *name, int len);
 
+/* Accelerometer */
+const struct st_sensor_settings *st_accel_get_settings(const char *name);
+int st_accel_common_probe(struct iio_dev *indio_dev);
+void st_accel_common_remove(struct iio_dev *indio_dev);
+
+/* Gyroscope */
+const struct st_sensor_settings *st_gyro_get_settings(const char *name);
+int st_gyro_common_probe(struct iio_dev *indio_dev);
+void st_gyro_common_remove(struct iio_dev *indio_dev);
+
+/* Magnetometer */
+const struct st_sensor_settings *st_magn_get_settings(const char *name);
+int st_magn_common_probe(struct iio_dev *indio_dev);
+void st_magn_common_remove(struct iio_dev *indio_dev);
+
+/* Pressure */
+const struct st_sensor_settings *st_press_get_settings(const char *name);
+int st_press_common_probe(struct iio_dev *indio_dev);
+void st_press_common_remove(struct iio_dev *indio_dev);
+
 #endif /* ST_SENSORS_H */
-- 
2.30.2

