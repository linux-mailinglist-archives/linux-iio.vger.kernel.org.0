Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C731211E6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfLPRjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 12:39:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:14035 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfLPRjB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 12:39:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="240111559"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2019 09:38:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 413DC685; Mon, 16 Dec 2019 19:38:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 9/9] iio: st_sensors: Make use of device properties
Date:   Mon, 16 Dec 2019 19:38:53 +0200
Message-Id: <20191216173853.75797-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel_i2c.c              |  6 +-----
 drivers/iio/accel/st_accel_spi.c              |  6 +-----
 .../iio/common/st_sensors/st_sensors_core.c   | 21 +++++--------------
 .../iio/common/st_sensors/st_sensors_spi.c    | 12 ++++++-----
 drivers/iio/gyro/st_gyro_i2c.c                |  6 +-----
 drivers/iio/gyro/st_gyro_spi.c                |  6 +-----
 drivers/iio/magnetometer/st_magn_i2c.c        |  6 +-----
 drivers/iio/magnetometer/st_magn_spi.c        |  6 +-----
 drivers/iio/pressure/st_pressure_i2c.c        |  6 +-----
 drivers/iio/pressure/st_pressure_spi.c        |  6 +-----
 10 files changed, 20 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 0f4aef5448e7..633955d764cc 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -18,7 +18,6 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_accel.h"
 
-#ifdef CONFIG_OF
 static const struct of_device_id st_accel_of_match[] = {
 	{
 		/* An older compatible */
@@ -108,9 +107,6 @@ static const struct of_device_id st_accel_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
-#else
-#define st_accel_of_match NULL
-#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id st_accel_acpi_match[] = {
@@ -193,7 +189,7 @@ static int st_accel_i2c_remove(struct i2c_client *client)
 static struct i2c_driver st_accel_driver = {
 	.driver = {
 		.name = "st-accel-i2c",
-		.of_match_table = of_match_ptr(st_accel_of_match),
+		.of_match_table = st_accel_of_match,
 		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
 	.probe_new = st_accel_i2c_probe,
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 3e25268638e2..568ff1bae0ee 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -17,7 +17,6 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_accel.h"
 
-#ifdef CONFIG_OF
 /*
  * For new single-chip sensors use <device_name> as compatible string.
  * For old single-chip devices keep <device_name>-accel to maintain
@@ -96,9 +95,6 @@ static const struct of_device_id st_accel_of_match[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
-#else
-#define st_accel_of_match	NULL
-#endif
 
 static int st_accel_spi_probe(struct spi_device *spi)
 {
@@ -165,7 +161,7 @@ MODULE_DEVICE_TABLE(spi, st_accel_id_table);
 static struct spi_driver st_accel_driver = {
 	.driver = {
 		.name = "st-accel-spi",
-		.of_match_table = of_match_ptr(st_accel_of_match),
+		.of_match_table = st_accel_of_match,
 	},
 	.probe = st_accel_spi_probe,
 	.remove = st_accel_spi_remove,
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 42a71a50650f..e051edbc43c1 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -14,8 +14,6 @@
 #include <linux/iio/iio.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <asm/unaligned.h>
 #include <linux/iio/common/st_sensors.h>
@@ -320,34 +318,25 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
+static struct st_sensors_platform_data *st_sensors_dev_probe(struct device *dev,
 		struct st_sensors_platform_data *defdata)
 {
 	struct st_sensors_platform_data *pdata;
-	struct device_node *np = dev->of_node;
 	u32 val;
 
-	if (!np)
+	if (!dev_fwnode(dev))
 		return NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!of_property_read_u32(np, "st,drdy-int-pin", &val) && (val <= 2))
+	if (!device_property_read_u32(dev, "st,drdy-int-pin", &val) && (val <= 2))
 		pdata->drdy_int_pin = (u8) val;
 	else
 		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 0;
 
-	pdata->open_drain = of_property_read_bool(np, "drive-open-drain");
+	pdata->open_drain = device_property_read_bool(dev, "drive-open-drain");
 
 	return pdata;
 }
-#else
-static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
-		struct st_sensors_platform_data *defdata)
-{
-	return NULL;
-}
-#endif
 
 /**
  * st_sensors_dev_name_probe() - device probe for ST sensor name
@@ -381,7 +370,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	int err = 0;
 
 	/* If OF/DT pdata exists, it will take precedence of anything else */
-	of_pdata = st_sensors_of_probe(indio_dev->dev.parent, pdata);
+	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
 	if (of_pdata)
 		pdata = of_pdata;
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 2262f81b07c2..1275fb0eda31 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors_spi.h>
@@ -37,14 +38,15 @@ static const struct regmap_config st_sensors_spi_regmap_multiread_bit_config = {
  */
 static bool st_sensors_is_spi_3_wire(struct spi_device *spi)
 {
-	struct device_node *np = spi->dev.of_node;
 	struct st_sensors_platform_data *pdata;
+	struct device *dev = &spi->dev;
 
-	pdata = (struct st_sensors_platform_data *)spi->dev.platform_data;
-	if ((np && of_property_read_bool(np, "spi-3wire")) ||
-	    (pdata && pdata->spi_3wire)) {
+	if (device_property_read_bool(dev, "spi-3wire"))
+		return true;
+
+	pdata = (struct st_sensors_platform_data *)dev->platform_data;
+	if (pdata && pdata->spi_3wire)
 		return true;
-	}
 
 	return false;
 }
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index bc0010835ac0..8190966e6ff0 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -17,7 +17,6 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_gyro.h"
 
-#ifdef CONFIG_OF
 static const struct of_device_id st_gyro_of_match[] = {
 	{
 		.compatible = "st,l3g4200d-gyro",
@@ -58,9 +57,6 @@ static const struct of_device_id st_gyro_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_gyro_of_match);
-#else
-#define st_gyro_of_match NULL
-#endif
 
 static int st_gyro_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
@@ -121,7 +117,7 @@ MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
 static struct i2c_driver st_gyro_driver = {
 	.driver = {
 		.name = "st-gyro-i2c",
-		.of_match_table = of_match_ptr(st_gyro_of_match),
+		.of_match_table = st_gyro_of_match,
 	},
 	.probe = st_gyro_i2c_probe,
 	.remove = st_gyro_i2c_remove,
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 07224d5bf299..efb862763ca3 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -17,7 +17,6 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_gyro.h"
 
-#ifdef CONFIG_OF
 /*
  * For new single-chip sensors use <device_name> as compatible string.
  * For old single-chip devices keep <device_name>-gyro to maintain
@@ -63,9 +62,6 @@ static const struct of_device_id st_gyro_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_gyro_of_match);
-#else
-#define st_gyro_of_match	NULL
-#endif
 
 static int st_gyro_spi_probe(struct spi_device *spi)
 {
@@ -125,7 +121,7 @@ MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
 static struct spi_driver st_gyro_driver = {
 	.driver = {
 		.name = "st-gyro-spi",
-		.of_match_table = of_match_ptr(st_gyro_of_match),
+		.of_match_table = st_gyro_of_match,
 	},
 	.probe = st_gyro_spi_probe,
 	.remove = st_gyro_spi_remove,
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index bf63777bbc6e..c6bb4ce77594 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -17,7 +17,6 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_magn.h"
 
-#ifdef CONFIG_OF
 static const struct of_device_id st_magn_of_match[] = {
 	{
 		.compatible = "st,lsm303dlh-magn",
@@ -50,9 +49,6 @@ static const struct of_device_id st_magn_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
-#else
-#define st_magn_of_match NULL
-#endif
 
 static int st_magn_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
@@ -112,7 +108,7 @@ MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
 static struct i2c_driver st_magn_driver = {
 	.driver = {
 		.name = "st-magn-i2c",
-		.of_match_table = of_match_ptr(st_magn_of_match),
+		.of_match_table = st_magn_of_match,
 	},
 	.probe = st_magn_i2c_probe,
 	.remove = st_magn_i2c_remove,
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 78f846fc120e..3d08d74c367d 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -17,7 +17,6 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_magn.h"
 
-#ifdef CONFIG_OF
 /*
  * For new single-chip sensors use <device_name> as compatible string.
  * For old single-chip devices keep <device_name>-magn to maintain
@@ -45,9 +44,6 @@ static const struct of_device_id st_magn_of_match[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
-#else
-#define st_magn_of_match	NULL
-#endif
 
 static int st_magn_spi_probe(struct spi_device *spi)
 {
@@ -103,7 +99,7 @@ MODULE_DEVICE_TABLE(spi, st_magn_id_table);
 static struct spi_driver st_magn_driver = {
 	.driver = {
 		.name = "st-magn-spi",
-		.of_match_table = of_match_ptr(st_magn_of_match),
+		.of_match_table = st_magn_of_match,
 	},
 	.probe = st_magn_spi_probe,
 	.remove = st_magn_spi_remove,
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index dd1f515ca1f1..09c6903f99b8 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -17,7 +17,6 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_pressure.h"
 
-#ifdef CONFIG_OF
 static const struct of_device_id st_press_of_match[] = {
 	{
 		.compatible = "st,lps001wp-press",
@@ -50,9 +49,6 @@ static const struct of_device_id st_press_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
-#else
-#define st_press_of_match NULL
-#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id st_press_acpi_match[] = {
@@ -119,7 +115,7 @@ static int st_press_i2c_remove(struct i2c_client *client)
 static struct i2c_driver st_press_driver = {
 	.driver = {
 		.name = "st-press-i2c",
-		.of_match_table = of_match_ptr(st_press_of_match),
+		.of_match_table = st_press_of_match,
 		.acpi_match_table = ACPI_PTR(st_press_acpi_match),
 	},
 	.probe = st_press_i2c_probe,
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index dd31241bf4b4..b5ee3ec2764f 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -17,7 +17,6 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_pressure.h"
 
-#ifdef CONFIG_OF
 /*
  * For new single-chip sensors use <device_name> as compatible string.
  * For old single-chip devices keep <device_name>-press to maintain
@@ -55,9 +54,6 @@ static const struct of_device_id st_press_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
-#else
-#define st_press_of_match	NULL
-#endif
 
 static int st_press_spi_probe(struct spi_device *spi)
 {
@@ -115,7 +111,7 @@ MODULE_DEVICE_TABLE(spi, st_press_id_table);
 static struct spi_driver st_press_driver = {
 	.driver = {
 		.name = "st-press-spi",
-		.of_match_table = of_match_ptr(st_press_of_match),
+		.of_match_table = st_press_of_match,
 	},
 	.probe = st_press_spi_probe,
 	.remove = st_press_spi_remove,
-- 
2.24.0

