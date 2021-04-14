Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147B435FC0B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353569AbhDNTzZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 15:55:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:35245 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353558AbhDNTzW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Apr 2021 15:55:22 -0400
IronPort-SDR: yIUyhLwricyLwnXOLvpCrwNLv78wgADJ7fDUpxu4p0EvlsbIldUW6a9xOVO79TdD7j6/QlikR4
 T0+glTTa0rjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258686529"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="258686529"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:54:59 -0700
IronPort-SDR: n0PEyPYANsh45LGCEpGS75Shdws3NYUVfN7Ryc/lAonvBBmdKhfD8BJsIljmv5PSUN3V8elRyA
 ZU6gVrc1rgLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="461343766"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2021 12:54:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9176C202; Wed, 14 Apr 2021 22:55:12 +0300 (EEST)
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
        Rob Herring <robh+dt@kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        mr.lahorde@laposte.net,
        Matija Podravec <matija_podravec@fastmail.fm>,
        Sergey Borishchenko <borischenko.sergey@gmail.com>
Subject: [PATCH v1 6/7] iio: st_sensors: Add lsm9ds0 IMU support
Date:   Wed, 14 Apr 2021 22:54:53 +0300
Message-Id: <20210414195454.84183-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We can utilize separate drivers for accelerometer and magnetometer,
so here is the glue driver to enable LSM9DS0 IMU support.

The idea was suggested by Crestez Dan Leonard in [1]. The proposed change
was sent as RFC due to race condition concerns, which are indeed possible.

In order to amend the initial change, I went further by providing a specific
multi-instantiate probe driver that reuses existing accelerometer and
magnetometer.

[1]: https://lore.kernel.org/patchwork/patch/670353/

Suggested-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: mr.lahorde@laposte.net
Cc: Matija Podravec <matija_podravec@fastmail.fm>
Cc: Sergey Borishchenko <borischenko.sergey@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel_core.c            |  89 +++++++++-
 drivers/iio/imu/Kconfig                      |   1 +
 drivers/iio/imu/Makefile                     |   1 +
 drivers/iio/imu/st_lsm9ds0/Kconfig           |  28 ++++
 drivers/iio/imu/st_lsm9ds0/Makefile          |   5 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      |  23 +++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 163 +++++++++++++++++++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  |  84 ++++++++++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  |  83 ++++++++++
 drivers/iio/magnetometer/st_magn_core.c      |  98 +++++++++++
 include/linux/iio/common/st_sensors.h        |   2 +
 11 files changed, 576 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/st_lsm9ds0/Kconfig
 create mode 100644 drivers/iio/imu/st_lsm9ds0/Makefile
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 5c258c1ca62d..dc32ebefe3fc 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -980,7 +980,94 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
-
+	{
+		.wai = 0x49,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LSM9DS0_IMU_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = GENMASK(7, 4),
+			.odr_avl = {
+				{ 3, 0x01, },
+				{ 6, 0x02, },
+				{ 12, 0x03, },
+				{ 25, 0x04, },
+				{ 50, 0x05, },
+				{ 100, 0x06, },
+				{ 200, 0x07, },
+				{ 400, 0x08, },
+				{ 800, 0x09, },
+				{ 1600, 0x0a, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = GENMASK(7, 4),
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x21,
+			.mask = GENMASK(5, 3),
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(61),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(122),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_6G,
+					.value = 0x02,
+					.gain = IIO_G_TO_M_S_2(183),
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(244),
+				},
+				[4] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = 0x04,
+					.gain = IIO_G_TO_M_S_2(732),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x20,
+			.mask = BIT(3),
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = BIT(2),
+			},
+			.int2 = {
+				.addr = 0x23,
+				.mask = BIT(3),
+			},
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = GENMASK(2, 0),
+			},
+		},
+		.sim = {
+			.addr = 0x21,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 };
 
 /* Default accel DRDY is available on INT1 pin */
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index f02883b08480..001ca2c3ff95 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -94,6 +94,7 @@ config KMX61
 source "drivers/iio/imu/inv_icm42600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 source "drivers/iio/imu/st_lsm6dsx/Kconfig"
+source "drivers/iio/imu/st_lsm9ds0/Kconfig"
 
 endmenu
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 13e9ff442b11..c82748096c77 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -26,3 +26,4 @@ obj-y += inv_mpu6050/
 obj-$(CONFIG_KMX61) += kmx61.o
 
 obj-y += st_lsm6dsx/
+obj-y += st_lsm9ds0/
diff --git a/drivers/iio/imu/st_lsm9ds0/Kconfig b/drivers/iio/imu/st_lsm9ds0/Kconfig
new file mode 100644
index 000000000000..53b7017014f8
--- /dev/null
+++ b/drivers/iio/imu/st_lsm9ds0/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config IIO_ST_LSM9DS0
+	tristate "STMicroelectronics LSM9DS0 IMU driver"
+	depends on (I2C || SPI_MASTER) && SYSFS
+	depends on !SENSORS_LIS3_I2C
+	depends on !SENSORS_LIS3_SPI
+	select IIO_ST_LSM9DS0_I2C if I2C
+	select IIO_ST_LSM9DS0_SPI if SPI_MASTER
+	select IIO_ST_ACCEL_3AXIS
+	select IIO_ST_MAGN_3AXIS
+
+	help
+	  Say yes here to build support for STMicroelectronics LSM9DS0 IMU
+	  sensor. Supported devices: accelerometer/magnetometer of lsm9ds0.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called st_lsm9ds0.
+
+config IIO_ST_LSM9DS0_I2C
+	tristate
+	depends on IIO_ST_LSM9DS0
+	select REGMAP_I2C
+
+config IIO_ST_LSM9DS0_SPI
+	tristate
+	depends on IIO_ST_LSM9DS0
+	select REGMAP_SPI
diff --git a/drivers/iio/imu/st_lsm9ds0/Makefile b/drivers/iio/imu/st_lsm9ds0/Makefile
new file mode 100644
index 000000000000..488af523f648
--- /dev/null
+++ b/drivers/iio/imu/st_lsm9ds0/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_IIO_ST_LSM9DS0) += st_lsm9ds0.o
+st_lsm9ds0-y := st_lsm9ds0_core.o
+obj-$(CONFIG_IIO_ST_LSM9DS0_I2C) += st_lsm9ds0_i2c.o
+obj-$(CONFIG_IIO_ST_LSM9DS0_SPI) += st_lsm9ds0_spi.o
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
new file mode 100644
index 000000000000..146393afd9a7
--- /dev/null
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// STMicroelectronics LSM9DS0 IMU driver
+
+#ifndef ST_LSM9DS0_H
+#define ST_LSM9DS0_H
+
+struct iio_dev;
+struct regulator;
+
+struct st_lsm9ds0 {
+	struct device *dev;
+	const char *name;
+	int irq;
+	struct iio_dev *accel;
+	struct iio_dev *magn;
+	struct regulator *vdd;
+	struct regulator *vdd_io;
+};
+
+int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap);
+int st_lsm9ds0_remove(struct st_lsm9ds0 *lsm9ds0);
+
+#endif /* ST_LSM9DS0_H */
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
new file mode 100644
index 000000000000..8204f7303fd7
--- /dev/null
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics LSM9DS0 IMU driver
+ *
+ * Copyright (C) 2021, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/common/st_sensors.h>
+#include <linux/iio/iio.h>
+
+#include "st_lsm9ds0.h"
+
+static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds0)
+{
+	int ret;
+
+	/* Regulators not mandatory, but if requested we should enable them. */
+	lsm9ds0->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(lsm9ds0->vdd)) {
+		dev_err(dev, "unable to get Vdd supply\n");
+		return PTR_ERR(lsm9ds0->vdd);
+	}
+	ret = regulator_enable(lsm9ds0->vdd);
+	if (ret) {
+		dev_warn(dev, "Failed to enable specified Vdd supply\n");
+		return ret;
+	}
+
+	lsm9ds0->vdd_io = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(lsm9ds0->vdd_io)) {
+		dev_err(dev, "unable to get Vdd_IO supply\n");
+		regulator_disable(lsm9ds0->vdd);
+		return PTR_ERR(lsm9ds0->vdd_io);
+	}
+	ret = regulator_enable(lsm9ds0->vdd_io);
+	if (ret) {
+		dev_warn(dev, "Failed to enable specified Vdd_IO supply\n");
+		regulator_disable(lsm9ds0->vdd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void st_lsm9ds0_power_disable(void *data)
+{
+	struct st_lsm9ds0 *lsm9ds0 = data;
+
+	regulator_disable(lsm9ds0->vdd_io);
+	regulator_disable(lsm9ds0->vdd);
+}
+
+static int devm_st_lsm9ds0_power_enable(struct st_lsm9ds0 *lsm9ds0)
+{
+	struct device *dev = lsm9ds0->dev;
+	int ret;
+
+	ret = st_lsm9ds0_power_enable(dev, lsm9ds0);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, st_lsm9ds0_power_disable, lsm9ds0);
+}
+
+static int st_lsm9ds0_probe_accel(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
+{
+	const struct st_sensor_settings *settings;
+	struct device *dev = lsm9ds0->dev;
+	struct st_sensor_data *data;
+
+	settings = st_accel_get_settings(lsm9ds0->name);
+	if (!settings) {
+		dev_err(dev, "device name %s not recognized.\n", lsm9ds0->name);
+		return -ENODEV;
+	}
+
+	lsm9ds0->accel = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!lsm9ds0->accel)
+		return -ENOMEM;
+
+	lsm9ds0->accel->name = lsm9ds0->name;
+
+	data = iio_priv(lsm9ds0->accel);
+	data->sensor_settings = (struct st_sensor_settings *)settings;
+	data->dev = dev;
+	data->irq = lsm9ds0->irq;
+	data->regmap = regmap;
+	data->vdd = lsm9ds0->vdd;
+	data->vdd_io = lsm9ds0->vdd_io;
+
+	return st_accel_common_probe(lsm9ds0->accel);
+}
+
+static int st_lsm9ds0_probe_magn(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
+{
+	const struct st_sensor_settings *settings;
+	struct device *dev = lsm9ds0->dev;
+	struct st_sensor_data *data;
+
+	settings = st_magn_get_settings(lsm9ds0->name);
+	if (!settings) {
+		dev_err(dev, "device name %s not recognized.\n", lsm9ds0->name);
+		return -ENODEV;
+	}
+
+	lsm9ds0->magn = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!lsm9ds0->magn)
+		return -ENOMEM;
+
+	lsm9ds0->magn->name = lsm9ds0->name;
+
+	data = iio_priv(lsm9ds0->magn);
+	data->sensor_settings = (struct st_sensor_settings *)settings;
+	data->dev = dev;
+	data->irq = lsm9ds0->irq;
+	data->regmap = regmap;
+	data->vdd = lsm9ds0->vdd;
+	data->vdd_io = lsm9ds0->vdd_io;
+
+	return st_magn_common_probe(lsm9ds0->magn);
+}
+
+int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
+{
+	int ret;
+
+	ret = devm_st_lsm9ds0_power_enable(lsm9ds0);
+	if (ret)
+		return ret;
+
+	/* Setup accelerometer device */
+	ret = st_lsm9ds0_probe_accel(lsm9ds0, regmap);
+	if (ret)
+		return ret;
+
+	/* Setup magnetometer device */
+	ret = st_lsm9ds0_probe_magn(lsm9ds0, regmap);
+	if (ret)
+		st_accel_common_remove(lsm9ds0->accel);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(st_lsm9ds0_probe);
+
+int st_lsm9ds0_remove(struct st_lsm9ds0 *lsm9ds0)
+{
+	st_magn_common_remove(lsm9ds0->magn);
+	st_accel_common_remove(lsm9ds0->accel);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(st_lsm9ds0_remove);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU core driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
new file mode 100644
index 000000000000..50a36ab53bc3
--- /dev/null
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics LSM9DS0 IMU driver
+ *
+ * Copyright (C) 2021, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <linux/iio/common/st_sensors_i2c.h>
+
+#include "st_lsm9ds0.h"
+
+static const struct of_device_id st_lsm9ds0_of_match[] = {
+	{
+		.compatible = "st,lsm9ds0-imu",
+		.data = LSM9DS0_IMU_DEV_NAME,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
+
+static const struct i2c_device_id st_lsm9ds0_id_table[] = {
+	{ LSM9DS0_IMU_DEV_NAME },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
+
+static const struct regmap_config st_lsm9ds0_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.read_flag_mask	= 0x80,
+};
+
+static int st_lsm9ds0_i2c_probe(struct i2c_client *client)
+{
+	const struct regmap_config *config = &st_lsm9ds0_regmap_config;
+	struct device *dev = &client->dev;
+	struct st_lsm9ds0 *lsm9ds0;
+	struct regmap *regmap;
+
+	st_sensors_dev_name_probe(dev, client->name, sizeof(client->name));
+
+	lsm9ds0 = devm_kzalloc(dev, sizeof(*lsm9ds0), GFP_KERNEL);
+	if (!lsm9ds0)
+		return -ENOMEM;
+
+	lsm9ds0->dev = dev;
+	lsm9ds0->name = client->name;
+	lsm9ds0->irq = client->irq;
+
+	regmap = devm_regmap_init_i2c(client, config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	i2c_set_clientdata(client, lsm9ds0);
+
+	return st_lsm9ds0_probe(lsm9ds0, regmap);
+}
+
+static int st_lsm9ds0_i2c_remove(struct i2c_client *client)
+{
+	return st_lsm9ds0_remove(i2c_get_clientdata(client));
+}
+
+static struct i2c_driver st_lsm9ds0_driver = {
+	.driver = {
+		.name = "st-lsm9ds0-i2c",
+		.of_match_table = st_lsm9ds0_of_match,
+	},
+	.probe_new = st_lsm9ds0_i2c_probe,
+	.remove = st_lsm9ds0_i2c_remove,
+	.id_table = st_lsm9ds0_id_table,
+};
+module_i2c_driver(st_lsm9ds0_driver);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU I2C driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
new file mode 100644
index 000000000000..272c88990dd0
--- /dev/null
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics LSM9DS0 IMU driver
+ *
+ * Copyright (C) 2021, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/common/st_sensors_spi.h>
+
+#include "st_lsm9ds0.h"
+
+static const struct of_device_id st_lsm9ds0_of_match[] = {
+	{
+		.compatible = "st,lsm9ds0-imu",
+		.data = LSM9DS0_IMU_DEV_NAME,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
+
+static const struct spi_device_id st_lsm9ds0_id_table[] = {
+	{ LSM9DS0_IMU_DEV_NAME },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
+
+static const struct regmap_config st_lsm9ds0_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.read_flag_mask	= 0xc0,
+};
+
+static int st_lsm9ds0_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct st_lsm9ds0 *lsm9ds0;
+	struct regmap *regmap;
+
+	st_sensors_dev_name_probe(dev, spi->modalias, sizeof(spi->modalias));
+
+	lsm9ds0 = devm_kzalloc(dev, sizeof(*lsm9ds0), GFP_KERNEL);
+	if (!lsm9ds0)
+		return -ENOMEM;
+
+	lsm9ds0->dev = dev;
+	lsm9ds0->name = spi->modalias;
+	lsm9ds0->irq = spi->irq;
+
+	regmap = devm_regmap_init_spi(spi, &st_lsm9ds0_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	spi_set_drvdata(spi, lsm9ds0);
+
+	return st_lsm9ds0_probe(lsm9ds0, regmap);
+}
+
+static int st_lsm9ds0_spi_remove(struct spi_device *spi)
+{
+	return st_lsm9ds0_remove(spi_get_drvdata(spi));
+}
+
+static struct spi_driver st_lsm9ds0_driver = {
+	.driver = {
+		.name = "st-lsm9ds0-spi",
+		.of_match_table = st_lsm9ds0_of_match,
+	},
+	.probe = st_lsm9ds0_spi_probe,
+	.remove = st_lsm9ds0_spi_remove,
+	.id_table = st_lsm9ds0_id_table,
+};
+module_spi_driver(st_lsm9ds0_driver);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU SPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 018b2523edfe..34fd892a776a 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -33,6 +33,7 @@
 /* FULLSCALE */
 #define ST_MAGN_FS_AVL_1300MG			1300
 #define ST_MAGN_FS_AVL_1900MG			1900
+#define ST_MAGN_FS_AVL_2000MG			2000
 #define ST_MAGN_FS_AVL_2500MG			2500
 #define ST_MAGN_FS_AVL_4000MG			4000
 #define ST_MAGN_FS_AVL_4700MG			4700
@@ -53,6 +54,11 @@
 #define ST_MAGN_3_OUT_Y_L_ADDR			0x6a
 #define ST_MAGN_3_OUT_Z_L_ADDR			0x6c
 
+/* Special L addresses for sensor 4 */
+#define ST_MAGN_4_OUT_X_L_ADDR			0x08
+#define ST_MAGN_4_OUT_Y_L_ADDR			0x0a
+#define ST_MAGN_4_OUT_Z_L_ADDR			0x0c
+
 static const struct iio_chan_spec st_magn_16bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -101,6 +107,22 @@ static const struct iio_chan_spec st_magn_3_16bit_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
+static const struct iio_chan_spec st_magn_4_16bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_MAGN_4_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_MAGN_4_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_MAGN_4_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
 static const struct st_sensor_settings st_magn_sensors_settings[] = {
 	{
 		.wai = 0, /* This sensor has no valid WhoAmI report 0 */
@@ -380,6 +402,82 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x49,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LSM9DS0_IMU_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_magn_4_16bit_channels,
+		.odr = {
+			.addr = 0x24,
+			.mask = GENMASK(4, 2),
+			.odr_avl = {
+				{ 3, 0x00, },
+				{ 6, 0x01, },
+				{ 12, 0x02, },
+				{ 25, 0x03, },
+				{ 50, 0x04, },
+				{ 100, 0x05, },
+			},
+		},
+		.pw = {
+			.addr = 0x26,
+			.mask = GENMASK(1, 0),
+			.value_on = 0x00,
+			.value_off = 0x03,
+		},
+		.fs = {
+			.addr = 0x25,
+			.mask = GENMASK(6, 5),
+			.fs_avl = {
+				[0] = {
+					.num = ST_MAGN_FS_AVL_2000MG,
+					.value = 0x00,
+					.gain = 73,
+				},
+				[1] = {
+					.num = ST_MAGN_FS_AVL_4000MG,
+					.value = 0x01,
+					.gain = 146,
+				},
+				[2] = {
+					.num = ST_MAGN_FS_AVL_8000MG,
+					.value = 0x02,
+					.gain = 292,
+				},
+				[3] = {
+					.num = ST_MAGN_FS_AVL_12000MG,
+					.value = 0x03,
+					.gain = 438,
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x20,
+			.mask = BIT(3),
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = BIT(1),
+			},
+			.int2 = {
+				.addr = 0x23,
+				.mask = BIT(2),
+			},
+			.stat_drdy = {
+				.addr = 0x07,
+				.mask = GENMASK(2, 0),
+			},
+		},
+		.sim = {
+			.addr = 0x21,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 };
 
 /* Default magn DRDY is available on INT2 pin */
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index aa017b90fb06..0b9aeb479f48 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -20,6 +20,8 @@
 
 #include <linux/platform_data/st_sensors_pdata.h>
 
+#define LSM9DS0_IMU_DEV_NAME		"lsm9ds0"
+
 /*
  * Buffer size max case: 2bytes per channel, 3 channels in total +
  *			 8bytes timestamp channel (s64)
-- 
2.30.2

