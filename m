Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17111211F4
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 18:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfLPRkW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 12:40:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:37441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfLPRkV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 12:40:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="365088535"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 09:38:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36D61628; Mon, 16 Dec 2019 19:38:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/9] iio: st_sensors: Drop redundant parameter from st_sensors_of_name_probe()
Date:   Mon, 16 Dec 2019 19:38:52 +0200
Message-Id: <20191216173853.75797-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since we have access to the struct device_driver and thus to the ID table,
there is no need to supply special parameters to st_sensors_of_name_probe().

Besides that we have a common API to get driver match data, there is
no need to do matching separately for OF and ACPI.

Taking into consideration above, simplify the ST sensors code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel_spi.c              |  3 +-
 .../iio/common/st_sensors/st_sensors_core.c   | 38 +++++++++----------
 .../iio/common/st_sensors/st_sensors_i2c.c    | 21 ----------
 drivers/iio/gyro/st_gyro_i2c.c                |  3 +-
 drivers/iio/gyro/st_gyro_spi.c                |  3 +-
 drivers/iio/magnetometer/st_magn_i2c.c        |  3 +-
 drivers/iio/magnetometer/st_magn_spi.c        |  3 +-
 drivers/iio/pressure/st_pressure_i2c.c        | 14 +------
 drivers/iio/pressure/st_pressure_spi.c        |  3 +-
 include/linux/iio/common/st_sensors.h         | 12 +-----
 include/linux/iio/common/st_sensors_i2c.h     | 10 -----
 11 files changed, 25 insertions(+), 88 deletions(-)

diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 8af7027d5598..3e25268638e2 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -107,8 +107,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int err;
 
-	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
-				 spi->modalias, sizeof(spi->modalias));
+	st_sensors_dev_name_probe(&spi->dev, spi->modalias, sizeof(spi->modalias));
 
 	settings = st_accel_get_settings(spi->modalias);
 	if (!settings) {
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 4a3064fb6cd9..42a71a50650f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -340,42 +341,37 @@ static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
 
 	return pdata;
 }
+#else
+static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
+		struct st_sensors_platform_data *defdata)
+{
+	return NULL;
+}
+#endif
 
 /**
- * st_sensors_of_name_probe() - device tree probe for ST sensor name
+ * st_sensors_dev_name_probe() - device probe for ST sensor name
  * @dev: driver model representation of the device.
- * @match: the OF match table for the device, containing compatible strings
- *	but also a .data field with the corresponding internal kernel name
- *	used by this sensor.
  * @name: device name buffer reference.
  * @len: device name buffer length.
  *
- * In effect this function matches a compatible string to an internal kernel
+ * In effect this function matches an ID to an internal kernel
  * name for a certain sensor device, so that the rest of the autodetection can
  * rely on that name from this point on. I2C/SPI devices will be renamed
  * to match the internal kernel convention.
  */
-void st_sensors_of_name_probe(struct device *dev,
-			      const struct of_device_id *match,
-			      char *name, int len)
+void st_sensors_dev_name_probe(struct device *dev, char *name, int len)
 {
-	const struct of_device_id *of_id;
+	const void *match;
 
-	of_id = of_match_device(match, dev);
-	if (!of_id || !of_id->data)
+	match = device_get_match_data(dev);
+	if (!match)
 		return;
 
-	/* The name from the OF match takes precedence if present */
-	strlcpy(name, of_id->data, len);
+	/* The name from the match takes precedence if present */
+	strlcpy(name, match, len);
 }
-EXPORT_SYMBOL(st_sensors_of_name_probe);
-#else
-static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
-		struct st_sensors_platform_data *defdata)
-{
-	return NULL;
-}
-#endif
+EXPORT_SYMBOL(st_sensors_dev_name_probe);
 
 int st_sensors_init_sensor(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index aa89d54a7c59..286830fb5d35 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -11,8 +11,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
-#include <linux/of_device.h>
-#include <linux/acpi.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
@@ -68,25 +66,6 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL(st_sensors_i2c_configure);
 
-#ifdef CONFIG_ACPI
-int st_sensors_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *acpi_id;
-	kernel_ulong_t driver_data = 0;
-
-	if (ACPI_HANDLE(dev)) {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id) {
-			dev_err(dev, "No driver data\n");
-			return -EINVAL;
-		}
-		driver_data = acpi_id->driver_data;
-	}
-	return driver_data;
-}
-EXPORT_SYMBOL(st_sensors_match_acpi_device);
-#endif
-
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors i2c driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 05a1a0874bd5..bc0010835ac0 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -70,8 +70,7 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int err;
 
-	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
-				 client->name, sizeof(client->name));
+	st_sensors_dev_name_probe(&client->dev, client->name, sizeof(client->name));
 
 	settings = st_gyro_get_settings(client->name);
 	if (!settings) {
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index b5c624251231..07224d5bf299 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -74,8 +74,7 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int err;
 
-	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
-				 spi->modalias, sizeof(spi->modalias));
+	st_sensors_dev_name_probe(&spi->dev, spi->modalias, sizeof(spi->modalias));
 
 	settings = st_gyro_get_settings(spi->modalias);
 	if (!settings) {
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index fdba480a12be..bf63777bbc6e 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -62,8 +62,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int err;
 
-	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
-				 client->name, sizeof(client->name));
+	st_sensors_dev_name_probe(&client->dev, client->name, sizeof(client->name));
 
 	settings = st_magn_get_settings(client->name);
 	if (!settings) {
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index fbf909bde841..78f846fc120e 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -56,8 +56,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int err;
 
-	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
-				 spi->modalias, sizeof(spi->modalias));
+	st_sensors_dev_name_probe(&spi->dev, spi->modalias, sizeof(spi->modalias));
 
 	settings = st_magn_get_settings(spi->modalias);
 	if (!settings) {
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 6203bc9d5c2d..dd1f515ca1f1 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
@@ -83,18 +82,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
 
-	if (client->dev.of_node) {
-		st_sensors_of_name_probe(&client->dev, st_press_of_match,
-					 client->name, sizeof(client->name));
-	} else if (ACPI_HANDLE(&client->dev)) {
-		ret = st_sensors_match_acpi_device(&client->dev);
-		if ((ret < 0) || (ret >= ST_PRESS_MAX))
-			return -ENODEV;
-
-		strlcpy(client->name, st_press_id_table[ret].name,
-			sizeof(client->name));
-	} else if (!id)
-		return -ENODEV;
+	st_sensors_dev_name_probe(&client->dev, client->name, sizeof(client->name));
 
 	settings = st_press_get_settings(client->name);
 	if (!settings) {
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 7c8b70221e70..dd31241bf4b4 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -66,8 +66,7 @@ static int st_press_spi_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int err;
 
-	st_sensors_of_name_probe(&spi->dev, st_press_of_match,
-				 spi->modalias, sizeof(spi->modalias));
+	st_sensors_dev_name_probe(&spi->dev, spi->modalias, sizeof(spi->modalias));
 
 	settings = st_press_get_settings(spi->modalias);
 	if (!settings) {
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 686be532f4cb..33e939977444 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -315,16 +315,6 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 				struct device_attribute *attr, char *buf);
 
-#ifdef CONFIG_OF
-void st_sensors_of_name_probe(struct device *dev,
-			      const struct of_device_id *match,
-			      char *name, int len);
-#else
-static inline void st_sensors_of_name_probe(struct device *dev,
-					    const struct of_device_id *match,
-					    char *name, int len)
-{
-}
-#endif
+void st_sensors_dev_name_probe(struct device *dev, char *name, int len);
 
 #endif /* ST_SENSORS_H */
diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
index 01e424e2af4f..5f15cf01036c 100644
--- a/include/linux/iio/common/st_sensors_i2c.h
+++ b/include/linux/iio/common/st_sensors_i2c.h
@@ -12,18 +12,8 @@
 
 #include <linux/i2c.h>
 #include <linux/iio/common/st_sensors.h>
-#include <linux/of.h>
 
 int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 			     struct i2c_client *client);
 
-#ifdef CONFIG_ACPI
-int st_sensors_match_acpi_device(struct device *dev);
-#else
-static inline int st_sensors_match_acpi_device(struct device *dev)
-{
-	return -ENODEV;
-}
-#endif
-
 #endif /* ST_SENSORS_I2C_H */
-- 
2.24.0

