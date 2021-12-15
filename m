Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36994475B9C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhLOPNz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:55 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:54967 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243841AbhLOPNz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:55 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8F743200009;
        Wed, 15 Dec 2021 15:13:52 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 09/10] iio: core: Simplify the registration of kfifo buffers
Date:   Wed, 15 Dec 2021 16:13:43 +0100
Message-Id: <20211215151344.163036-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Among all the users of the kfifo buffers, no one uses the
INDIO_BUFFER_HARDWARE mode. So let's take this as a general rule and
simplify a little bit the internals - overall the documentation - by
eliminating unused specific cases. Use the INDIO_BUFFER_SOFTWARE mode by
default with kfifo buffers, which will basically mimic what all the "non
direct" modes do.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/accel/fxls8962af-core.c                  |  1 -
 drivers/iio/accel/sca3000.c                          |  1 -
 drivers/iio/accel/ssp_accel_sensor.c                 |  1 -
 drivers/iio/adc/ina2xx-adc.c                         |  1 -
 drivers/iio/adc/ti_am335x_adc.c                      |  4 +---
 drivers/iio/buffer/kfifo_buf.c                       | 12 ++----------
 .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  3 +--
 drivers/iio/common/scmi_sensors/scmi_iio.c           |  1 -
 drivers/iio/gyro/ssp_gyro_sensor.c                   |  1 -
 drivers/iio/health/max30100.c                        |  1 -
 drivers/iio/health/max30102.c                        |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c    |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c     |  1 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c       |  1 -
 drivers/iio/light/apds9960.c                         |  1 -
 drivers/staging/iio/impedance-analyzer/ad5933.c      |  1 -
 include/linux/iio/kfifo_buf.h                        |  5 ++---
 17 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 32989d91b982..cf494937a346 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1209,7 +1209,6 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 			return ret;
 
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-						  INDIO_BUFFER_SOFTWARE,
 						  &fxls8962af_buffer_ops);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index c6b75308148a..a65a05f1208b 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1465,7 +1465,6 @@ static int sca3000_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &sca3000_ring_setup_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
index 04dcb2b657ee..d20f8d299c11 100644
--- a/drivers/iio/accel/ssp_accel_sensor.c
+++ b/drivers/iio/accel/ssp_accel_sensor.c
@@ -113,7 +113,6 @@ static int ssp_accel_probe(struct platform_device *pdev)
 	indio_dev->available_scan_masks = ssp_accel_scan_mask;
 
 	ret = devm_iio_kfifo_buffer_setup(&pdev->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &ssp_accel_buffer_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0dd5..013d2d586df1 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1030,7 +1030,6 @@ static int ina2xx_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &ina2xx_setup_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index dbdc1ef48566..567d43a30955 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -376,9 +376,7 @@ static int tiadc_iio_buffered_hardware_setup(struct device *dev,
 {
 	int ret;
 
-	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
-					  setup_ops);
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, setup_ops);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 416d35a61ae2..f17473e06ee8 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -197,7 +197,7 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.set_length = &iio_set_length_kfifo,
 	.release = &iio_kfifo_buffer_release,
 
-	.modes = INDIO_BUFFER_SOFTWARE | INDIO_BUFFER_TRIGGERED,
+	.modes = INDIO_BUFFER_SOFTWARE,
 };
 
 struct iio_buffer *iio_kfifo_allocate(void)
@@ -259,8 +259,6 @@ static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
  * devm_iio_kfifo_buffer_setup_ext - Allocate a kfifo buffer & attach it to an IIO device
  * @dev: Device object to which to attach the life-time of this kfifo buffer
  * @indio_dev: The device the buffer should be attached to
- * @mode_flags: The mode flags for this buffer (INDIO_BUFFER_SOFTWARE and/or
- *		INDIO_BUFFER_TRIGGERED).
  * @setup_ops: The setup_ops required to configure the HW part of the buffer (optional)
  * @buffer_attrs: Extra sysfs buffer attributes for this IIO buffer
  *
@@ -271,22 +269,16 @@ static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
  */
 int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 				    struct iio_dev *indio_dev,
-				    int mode_flags,
 				    const struct iio_buffer_setup_ops *setup_ops,
 				    const struct attribute **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 
-	if (!mode_flags)
-		return -EINVAL;
-
 	buffer = devm_iio_kfifo_allocate(dev);
 	if (!buffer)
 		return -ENOMEM;
 
-	mode_flags &= kfifo_access_funcs.modes;
-
-	indio_dev->modes |= mode_flags;
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
 	indio_dev->setup_ops = setup_ops;
 
 	buffer->attrs = buffer_attrs;
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b2725c6adc7f..a4cf1d9a8a49 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -333,8 +333,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			 * We can not use trigger here, as events are generated
 			 * as soon as sample_frequency is set.
 			 */
-			ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
-							      INDIO_BUFFER_SOFTWARE, NULL,
+			ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, NULL,
 							      cros_ec_sensor_fifo_attributes);
 			if (ret)
 				return ret;
diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..792807b2894f 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -631,7 +631,6 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 
 		err = devm_iio_kfifo_buffer_setup(&scmi_iio_dev->dev,
 						  scmi_iio_dev,
-						  INDIO_BUFFER_SOFTWARE,
 						  &scmi_iio_buffer_ops);
 		if (err < 0) {
 			dev_err(dev,
diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
index 46ed12771d2f..eebc036717af 100644
--- a/drivers/iio/gyro/ssp_gyro_sensor.c
+++ b/drivers/iio/gyro/ssp_gyro_sensor.c
@@ -113,7 +113,6 @@ static int ssp_gyro_probe(struct platform_device *pdev)
 	indio_dev->available_scan_masks = ssp_gyro_scan_mask;
 
 	ret = devm_iio_kfifo_buffer_setup(&pdev->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &ssp_gyro_buffer_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 36ba7611d9ce..ad5717965223 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -433,7 +433,6 @@ static int max30100_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &max30100_buffer_setup_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 2292876c55e2..abbcef563807 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -542,7 +542,6 @@ static int max30102_probe(struct i2c_client *client,
 	}
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &max30102_buffer_setup_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 383cc3250342..c3f433ad3af6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -731,7 +731,6 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	indio_dev->available_scan_masks = inv_icm42600_accel_scan_masks;
 
 	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &inv_icm42600_buffer_ops);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index cec1dd0e0464..9d94a8518e3c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -743,7 +743,6 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	indio_dev->setup_ops = &inv_icm42600_buffer_ops;
 
 	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &inv_icm42600_buffer_ops);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 16730a780964..f80c62849d30 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -746,7 +746,6 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 			continue;
 
 		ret = devm_iio_kfifo_buffer_setup(hw->dev, hw->iio_devs[i],
-						  INDIO_BUFFER_SOFTWARE,
 						  &st_lsm6dsx_buffer_ops);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 4141c0fa7bc4..09b831f9f40b 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1003,7 +1003,6 @@ static int apds9960_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &apds9960_buffer_setup_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 793918e1c45f..f177b20f0f2d 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -749,7 +749,6 @@ static int ad5933_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE,
 					  &ad5933_ring_setup_ops);
 	if (ret)
 		return ret;
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index ccd2ceae7b25..8a83fb58232d 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -12,11 +12,10 @@ void iio_kfifo_free(struct iio_buffer *r);
 
 int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 				    struct iio_dev *indio_dev,
-				    int mode_flags,
 				    const struct iio_buffer_setup_ops *setup_ops,
 				    const struct attribute **buffer_attrs);
 
-#define devm_iio_kfifo_buffer_setup(dev, indio_dev, mode_flags, setup_ops)	\
-	devm_iio_kfifo_buffer_setup_ext((dev), (indio_dev), (mode_flags), (setup_ops), NULL)
+#define devm_iio_kfifo_buffer_setup(dev, indio_dev, setup_ops)	\
+	devm_iio_kfifo_buffer_setup_ext((dev), (indio_dev), (setup_ops), NULL)
 
 #endif
-- 
2.27.0

