Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD05F35FC04
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353551AbhDNTzW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 15:55:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:35237 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353549AbhDNTzU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Apr 2021 15:55:20 -0400
IronPort-SDR: bzEhr3Iv5toMh1rxDGuQ6DtPu95caPaRofSL1TtRnDz6yO2wlKfg+3qIftUpnh9NFnjcKSfhtX
 xclVYlusCZCw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258686519"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="258686519"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:54:56 -0700
IronPort-SDR: lQEmibHfpUq2p8LGx8k2gy+oiUMDA4iPKTxceQ7DDk3uZph/VWIDPxwnaU00R4VUI30dgwWJPE
 ndOjWV9XnbiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="612222028"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2021 12:54:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B820147; Wed, 14 Apr 2021 22:55:10 +0300 (EEST)
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
Subject: [PATCH v1 4/7] iio: st_sensors: Call st_sensors_power_enable() from bus drivers
Date:   Wed, 14 Apr 2021 22:54:51 +0300
Message-Id: <20210414195454.84183-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In case we would initialize two IIO devices from one physical device,
we shouldn't have a clash on regulators. That's why move
st_sensors_power_enable() call from core to bus drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel_core.c       | 21 +++++----------------
 drivers/iio/accel/st_accel_i2c.c        | 17 +++++++++++++++--
 drivers/iio/accel/st_accel_spi.c        | 17 +++++++++++++++--
 drivers/iio/gyro/st_gyro_core.c         | 15 +++------------
 drivers/iio/gyro/st_gyro_i2c.c          | 17 +++++++++++++++--
 drivers/iio/gyro/st_gyro_spi.c          | 17 +++++++++++++++--
 drivers/iio/magnetometer/st_magn_core.c | 15 +++------------
 drivers/iio/magnetometer/st_magn_i2c.c  | 14 +++++++++++++-
 drivers/iio/magnetometer/st_magn_spi.c  | 14 +++++++++++++-
 drivers/iio/pressure/st_pressure_core.c | 15 +++------------
 drivers/iio/pressure/st_pressure_i2c.c  | 17 +++++++++++++++--
 drivers/iio/pressure/st_pressure_spi.c  | 17 +++++++++++++++--
 12 files changed, 130 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index a1bd7e3b912e..5c258c1ca62d 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1260,13 +1260,9 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &accel_info;
 
-	err = st_sensors_power_enable(indio_dev);
-	if (err)
-		return err;
-
 	err = st_sensors_verify_id(indio_dev);
 	if (err < 0)
-		goto st_accel_power_off;
+		return err;
 
 	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
@@ -1275,10 +1271,8 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	channels = devm_kmemdup(&indio_dev->dev,
 				adata->sensor_settings->ch,
 				channels_size, GFP_KERNEL);
-	if (!channels) {
-		err = -ENOMEM;
-		goto st_accel_power_off;
-	}
+	if (!channels)
+		return -ENOMEM;
 
 	if (apply_acpi_orientation(indio_dev, channels))
 		dev_warn(&indio_dev->dev,
@@ -1293,11 +1287,11 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-		goto st_accel_power_off;
+		return err;
 
 	err = st_accel_allocate_ring(indio_dev);
 	if (err < 0)
-		goto st_accel_power_off;
+		return err;
 
 	if (adata->irq > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
@@ -1320,9 +1314,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 st_accel_probe_trigger_error:
 	st_accel_deallocate_ring(indio_dev);
-st_accel_power_off:
-	st_sensors_power_disable(indio_dev);
-
 	return err;
 }
 EXPORT_SYMBOL(st_accel_common_probe);
@@ -1331,8 +1322,6 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	iio_device_unregister(indio_dev);
 	if (adata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 360e16f2cadb..95e305b88d5e 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -174,16 +174,29 @@ static int st_accel_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = st_sensors_power_enable(indio_dev);
+	if (ret)
+		return ret;
+
 	ret = st_accel_common_probe(indio_dev);
 	if (ret < 0)
-		return ret;
+		goto st_accel_power_off;
 
 	return 0;
+
+st_accel_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return ret;
 }
 
 static int st_accel_i2c_remove(struct i2c_client *client)
 {
-	st_accel_common_remove(i2c_get_clientdata(client));
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	st_sensors_power_disable(indio_dev);
+
+	st_accel_common_remove(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 568ff1bae0ee..83d3308ce5cc 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -123,16 +123,29 @@ static int st_accel_spi_probe(struct spi_device *spi)
 	if (err < 0)
 		return err;
 
+	err = st_sensors_power_enable(indio_dev);
+	if (err)
+		return err;
+
 	err = st_accel_common_probe(indio_dev);
 	if (err < 0)
-		return err;
+		goto st_accel_power_off;
 
 	return 0;
+
+st_accel_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return err;
 }
 
 static int st_accel_spi_remove(struct spi_device *spi)
 {
-	st_accel_common_remove(spi_get_drvdata(spi));
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	st_sensors_power_disable(indio_dev);
+
+	st_accel_common_remove(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e000504e1df4..ee3f0ea96ac5 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -471,13 +471,9 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &gyro_info;
 
-	err = st_sensors_power_enable(indio_dev);
-	if (err)
-		return err;
-
 	err = st_sensors_verify_id(indio_dev);
 	if (err < 0)
-		goto st_gyro_power_off;
+		return err;
 
 	gdata->num_data_channels = ST_GYRO_NUMBER_DATA_CHANNELS;
 	indio_dev->channels = gdata->sensor_settings->ch;
@@ -490,11 +486,11 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-		goto st_gyro_power_off;
+		return err;
 
 	err = st_gyro_allocate_ring(indio_dev);
 	if (err < 0)
-		goto st_gyro_power_off;
+		return err;
 
 	if (gdata->irq > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
@@ -517,9 +513,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 st_gyro_probe_trigger_error:
 	st_gyro_deallocate_ring(indio_dev);
-st_gyro_power_off:
-	st_sensors_power_disable(indio_dev);
-
 	return err;
 }
 EXPORT_SYMBOL(st_gyro_common_probe);
@@ -528,8 +521,6 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	iio_device_unregister(indio_dev);
 	if (gdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 8190966e6ff0..a25cc0379e16 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -86,16 +86,29 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	if (err < 0)
 		return err;
 
+	err = st_sensors_power_enable(indio_dev);
+	if (err)
+		return err;
+
 	err = st_gyro_common_probe(indio_dev);
 	if (err < 0)
-		return err;
+		goto st_gyro_power_off;
 
 	return 0;
+
+st_gyro_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return err;
 }
 
 static int st_gyro_i2c_remove(struct i2c_client *client)
 {
-	st_gyro_common_remove(i2c_get_clientdata(client));
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	st_sensors_power_disable(indio_dev);
+
+	st_gyro_common_remove(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index efb862763ca3..18d6a2aeda45 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -90,16 +90,29 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	if (err < 0)
 		return err;
 
+	err = st_sensors_power_enable(indio_dev);
+	if (err)
+		return err;
+
 	err = st_gyro_common_probe(indio_dev);
 	if (err < 0)
-		return err;
+		goto st_gyro_power_off;
 
 	return 0;
+
+st_gyro_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return err;
 }
 
 static int st_gyro_spi_remove(struct spi_device *spi)
 {
-	st_gyro_common_remove(spi_get_drvdata(spi));
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	st_sensors_power_disable(indio_dev);
+
+	st_gyro_common_remove(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index cf3722e42419..018b2523edfe 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -500,13 +500,9 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &magn_info;
 
-	err = st_sensors_power_enable(indio_dev);
-	if (err)
-		return err;
-
 	err = st_sensors_verify_id(indio_dev);
 	if (err < 0)
-		goto st_magn_power_off;
+		return err;
 
 	mdata->num_data_channels = ST_MAGN_NUMBER_DATA_CHANNELS;
 	indio_dev->channels = mdata->sensor_settings->ch;
@@ -520,11 +516,11 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-		goto st_magn_power_off;
+		return err;
 
 	err = st_magn_allocate_ring(indio_dev);
 	if (err < 0)
-		goto st_magn_power_off;
+		return err;
 
 	if (mdata->irq > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
@@ -547,9 +543,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 st_magn_probe_trigger_error:
 	st_magn_deallocate_ring(indio_dev);
-st_magn_power_off:
-	st_sensors_power_disable(indio_dev);
-
 	return err;
 }
 EXPORT_SYMBOL(st_magn_common_probe);
@@ -558,8 +551,6 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	iio_device_unregister(indio_dev);
 	if (mdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index c6bb4ce77594..7a7ab27379fc 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -78,16 +78,28 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 	if (err < 0)
 		return err;
 
+	err = st_sensors_power_enable(indio_dev);
+	if (err)
+		return err;
+
 	err = st_magn_common_probe(indio_dev);
 	if (err < 0)
-		return err;
+		goto st_magn_power_off;
 
 	return 0;
+
+st_magn_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return err;
 }
 
 static int st_magn_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	st_sensors_power_disable(indio_dev);
+
 	st_magn_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 3d08d74c367d..ee352f083c02 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -72,16 +72,28 @@ static int st_magn_spi_probe(struct spi_device *spi)
 	if (err < 0)
 		return err;
 
+	err = st_sensors_power_enable(indio_dev);
+	if (err)
+		return err;
+
 	err = st_magn_common_probe(indio_dev);
 	if (err < 0)
-		return err;
+		goto st_magn_power_off;
 
 	return 0;
+
+st_magn_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return err;
 }
 
 static int st_magn_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	st_sensors_power_disable(indio_dev);
+
 	st_magn_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 789a2928504a..7912b5a68395 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -689,13 +689,9 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &press_info;
 
-	err = st_sensors_power_enable(indio_dev);
-	if (err)
-		return err;
-
 	err = st_sensors_verify_id(indio_dev);
 	if (err < 0)
-		goto st_press_power_off;
+		return err;
 
 	/*
 	 * Skip timestamping channel while declaring available channels to
@@ -718,11 +714,11 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-		goto st_press_power_off;
+		return err;
 
 	err = st_press_allocate_ring(indio_dev);
 	if (err < 0)
-		goto st_press_power_off;
+		return err;
 
 	if (press_data->irq > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
@@ -745,9 +741,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 st_press_probe_trigger_error:
 	st_press_deallocate_ring(indio_dev);
-st_press_power_off:
-	st_sensors_power_disable(indio_dev);
-
 	return err;
 }
 EXPORT_SYMBOL(st_press_common_probe);
@@ -756,8 +749,6 @@ void st_press_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	iio_device_unregister(indio_dev);
 	if (press_data->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 09c6903f99b8..f0a5af314ceb 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -98,16 +98,29 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	ret = st_sensors_power_enable(indio_dev);
+	if (ret)
+		return ret;
+
 	ret = st_press_common_probe(indio_dev);
 	if (ret < 0)
-		return ret;
+		goto st_press_power_off;
 
 	return 0;
+
+st_press_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return ret;
 }
 
 static int st_press_i2c_remove(struct i2c_client *client)
 {
-	st_press_common_remove(i2c_get_clientdata(client));
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	st_sensors_power_disable(indio_dev);
+
+	st_press_common_remove(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index b5ee3ec2764f..b48cf7d01cd7 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -82,16 +82,29 @@ static int st_press_spi_probe(struct spi_device *spi)
 	if (err < 0)
 		return err;
 
+	err = st_sensors_power_enable(indio_dev);
+	if (err)
+		return err;
+
 	err = st_press_common_probe(indio_dev);
 	if (err < 0)
-		return err;
+		goto st_press_power_off;
 
 	return 0;
+
+st_press_power_off:
+	st_sensors_power_disable(indio_dev);
+
+	return err;
 }
 
 static int st_press_spi_remove(struct spi_device *spi)
 {
-	st_press_common_remove(spi_get_drvdata(spi));
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	st_sensors_power_disable(indio_dev);
+
+	st_press_common_remove(indio_dev);
 
 	return 0;
 }
-- 
2.30.2

