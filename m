Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6FC387772
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhERL0u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 07:26:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:48642 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhERL0t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 07:26:49 -0400
IronPort-SDR: VPt/hgH2yN986NCHuOg5x/Io0a+2wYeR1Dbctf1nJ+ie/Hfr4qeD0JmLpg3io5LgSpjuIm9nfe
 axkksLhRBZ3w==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="261916075"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="261916075"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:25:31 -0700
IronPort-SDR: CGpK977XSXhlnrlMcPKDsvQOdcsYPFz++QkHvbNHIwxexUJP4QF1FRfERjiIKGhftUJXQu6cLS
 oyDwDNGQsQEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="611939628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2021 04:25:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7052F12F; Tue, 18 May 2021 14:25:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Robertson <dan@dlrobertson.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH v1 1/1] iio: Drop Duplicated "mount-matrix" parameter
Date:   Tue, 18 May 2021 14:25:46 +0300
Message-Id: <20210518112546.44592-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All of the users of iio_read_mount_matrix() are using the very same
property name. Moreover, the property name is hard coded in the API
documentation.

Make this clear and avoid duplication now and in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I have decided to get this done in a single patch due to several things:
- avoidance of unneeded churn with obsoleting APIs
- all users are under one subsystem anyway
- the atomicity of the change allows to stop new duplication to come
- if anything, we will need to revert entire series and single patch
  here may be better solution

But I can redo (although I really want to avoid this) as a series
if there is a strong opinion why it should be split.

Linus, feel free to prepend this in your series where you are adding
a few new users.

 drivers/iio/accel/bma180.c                       | 3 +--
 drivers/iio/accel/bma400_core.c                  | 2 +-
 drivers/iio/accel/bmc150-accel-core.c            | 3 +--
 drivers/iio/accel/fxls8962af-core.c              | 2 +-
 drivers/iio/accel/kxcjk-1013.c                   | 3 +--
 drivers/iio/accel/kxsd9.c                        | 2 +-
 drivers/iio/gyro/bmg160_core.c                   | 3 +--
 drivers/iio/gyro/itg3200_core.c                  | 3 +--
 drivers/iio/gyro/mpu3050-core.c                  | 2 +-
 drivers/iio/imu/bmi160/bmi160_core.c             | 3 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       | 3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c     | 2 +-
 drivers/iio/industrialio-core.c                  | 7 ++-----
 drivers/iio/magnetometer/ak8974.c                | 3 +--
 drivers/iio/magnetometer/ak8975.c                | 2 +-
 drivers/iio/magnetometer/bmc150_magn.c           | 3 +--
 drivers/iio/magnetometer/hmc5843_core.c          | 3 +--
 drivers/iio/magnetometer/yamaha-yas530.c         | 2 +-
 include/linux/iio/iio.h                          | 3 +--
 20 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 71c76bbd81d4..97e991581960 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1001,8 +1001,7 @@ static int bma180_probe(struct i2c_client *client,
 		chip = id->driver_data;
 	data->part_info = &bma180_part_info[chip];
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix",
-				&data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 7eeba80e32cb..21520e022a21 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -811,7 +811,7 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 	if (ret)
 		return ret;
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 43cfadf8f6b7..46ab7675186c 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1685,8 +1685,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	data->regmap = regmap;
 
 	if (!bmc150_apply_acpi_orientation(dev, &data->orientation)) {
-		ret = iio_read_mount_matrix(dev, "mount-matrix",
-					     &data->orientation);
+		ret = iio_read_mount_matrix(dev, &data->orientation);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 9fe5a18a605c..078d87865fde 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -862,7 +862,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7cd647315194..a51fdd3c9b5b 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1455,8 +1455,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	} else {
 		data->active_high_intr = true; /* default polarity */
 
-		ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
-					    &data->orientation);
+		ret = iio_read_mount_matrix(&client->dev, &data->orientation);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0e18b92e2099..bf7ed9e7d00f 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -420,7 +420,7 @@ int kxsd9_common_probe(struct device *dev,
 	indio_dev->available_scan_masks = kxsd9_scan_masks;
 
 	/* Read the mounting matrix, if present */
-	ret = iio_read_mount_matrix(dev, "mount-matrix", &st->orientation);
+	ret = iio_read_mount_matrix(dev, &st->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index a7cc2cad8bbf..17b939a367ad 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1106,8 +1106,7 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (ret)
 		return ret;
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix",
-				&data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index e9804664db73..a7f1bbb5f289 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -308,8 +308,7 @@ static int itg3200_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
-	ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
-				&st->orientation);
+	ret = iio_read_mount_matrix(&client->dev, &st->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 2b930c7f4d86..3225de1f023b 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1164,7 +1164,7 @@ int mpu3050_common_probe(struct device *dev,
 	mpu3050->divisor = 99;
 
 	/* Read the mounting matrix, if present */
-	ret = iio_read_mount_matrix(dev, "mount-matrix", &mpu3050->orientation);
+	ret = iio_read_mount_matrix(dev, &mpu3050->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index b63bd7e5e5e5..824b5124a5f5 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -852,8 +852,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix",
-				    &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 8bd77185ccb7..86858da9cc38 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -592,7 +592,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 	st->chip = chip;
 	st->map = regmap;
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix", &st->orientation);
+	ret = iio_read_mount_matrix(dev, &st->orientation);
 	if (ret) {
 		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
 		return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6244a07048df..64704b55f6eb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1455,8 +1455,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
 	pdata = dev_get_platdata(dev);
 	if (!pdata) {
-		result = iio_read_mount_matrix(dev, "mount-matrix",
-					       &st->orientation);
+		result = iio_read_mount_matrix(dev, &st->orientation);
 		if (result) {
 			dev_err(dev, "Failed to retrieve mounting matrix %d\n",
 				result);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index e8d242ee6743..db45f1fc0b81 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2256,7 +2256,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
-	err = iio_read_mount_matrix(hw->dev, "mount-matrix", &hw->orientation);
+	err = iio_read_mount_matrix(hw->dev, &hw->orientation);
 	if (err)
 		return err;
 
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 75e92bac78f3..6d2175eb7af2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -617,7 +617,6 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
  * iio_read_mount_matrix() - retrieve iio device mounting matrix from
  *                           device "mount-matrix" property
  * @dev:	device the mounting matrix property is assigned to
- * @propname:	device specific mounting matrix property name
  * @matrix:	where to store retrieved matrix
  *
  * If device is assigned no mounting matrix property, a default 3x3 identity
@@ -625,14 +624,12 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
  *
  * Return: 0 if success, or a negative error code on failure.
  */
-int iio_read_mount_matrix(struct device *dev, const char *propname,
-			  struct iio_mount_matrix *matrix)
+int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 {
 	size_t len = ARRAY_SIZE(iio_mount_idmatrix.rotation);
 	int err;
 
-	err = device_property_read_string_array(dev, propname,
-						matrix->rotation, len);
+	err = device_property_read_string_array(dev, "mount-matrix", matrix->rotation, len);
 	if (err == len)
 		return 0;
 
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 24b2f7b1fe44..e54feacfb980 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -833,8 +833,7 @@ static int ak8974_probe(struct i2c_client *i2c,
 	ak8974->i2c = i2c;
 	mutex_init(&ak8974->lock);
 
-	ret = iio_read_mount_matrix(&i2c->dev, "mount-matrix",
-				    &ak8974->orientation);
+	ret = iio_read_mount_matrix(&i2c->dev, &ak8974->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d988b6ac3659..42b8a2680e3a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -890,7 +890,7 @@ static int ak8975_probe(struct i2c_client *client,
 	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
-	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
+	err = iio_read_mount_matrix(&client->dev, &data->orientation);
 	if (err)
 		return err;
 
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 5f28220a7994..f96f53175349 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -890,8 +890,7 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix",
-				&data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 221563e0c18f..cf62057480cf 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -637,8 +637,7 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 	data->variant = &hmc5843_chip_info_tbl[id];
 	mutex_init(&data->lock);
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix",
-				&data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 2f2f8cb3c26c..9ff7b0e56cf6 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -831,7 +831,7 @@ static int yas5xx_probe(struct i2c_client *i2c,
 	yas5xx->dev = dev;
 	mutex_init(&yas5xx->lock);
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix", &yas5xx->orientation);
+	ret = iio_read_mount_matrix(dev, &yas5xx->orientation);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 5606a3f4c4cb..324561b7a5e8 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -127,8 +127,7 @@ struct iio_mount_matrix {
 
 ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
 			      const struct iio_chan_spec *chan, char *buf);
-int iio_read_mount_matrix(struct device *dev, const char *propname,
-			  struct iio_mount_matrix *matrix);
+int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix);
 
 typedef const struct iio_mount_matrix *
 	(iio_get_mount_matrix_t)(const struct iio_dev *indio_dev,
-- 
2.30.2

