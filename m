Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6330619AC45
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbgDANAq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 09:00:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55062 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732629AbgDANAp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 09:00:45 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031D06EZ014956;
        Wed, 1 Apr 2020 09:00:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6myqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 09:00:26 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 031D0PYj057309
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 1 Apr 2020 09:00:25 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 1 Apr 2020
 06:00:23 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 1 Apr 2020 06:00:23 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 031D0Hmw023654;
        Wed, 1 Apr 2020 09:00:20 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <lorenzo.bianconi83@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: make use of iio_device_attach_kfifo_buffer() where straightforward
Date:   Wed, 1 Apr 2020 15:59:35 +0300
Message-ID: <20200401125936.6398-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401125936.6398-1-alexandru.ardelean@analog.com>
References: <20200401125936.6398-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=2 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All drivers that already call devm_iio_kfifo_allocate() &
iio_device_attach_buffer() are simple to convert to
iio_device_attach_kfifo_buffer() in a single go/patch/.

This change does that.

For drivers max30100 & max30102 this helper is called after indio_dev has
been populated. This doesn't make any difference [at this point in time].

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/sca3000.c                    | 18 ++----------------
 drivers/iio/accel/ssp_accel_sensor.c           | 13 ++++---------
 drivers/iio/adc/ina2xx-adc.c                   | 13 +++++--------
 drivers/iio/gyro/ssp_gyro_sensor.c             | 13 ++++---------
 drivers/iio/health/max30100.c                  | 15 ++++++---------
 drivers/iio/health/max30102.c                  | 15 ++++++---------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 17 +++++++----------
 drivers/iio/light/acpi-als.c                   | 11 +++++------
 drivers/iio/light/apds9960.c                   | 15 ++++++---------
 9 files changed, 45 insertions(+), 85 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 66d768d971e1..a0db76082ba6 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1272,20 +1272,6 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int sca3000_configure_ring(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-
-	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
-
-	return 0;
-}
-
 static inline
 int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 {
@@ -1480,7 +1466,8 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = sca3000_configure_ring(indio_dev);
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &sca3000_ring_setup_ops);
 	if (ret)
 		return ret;
 
@@ -1494,7 +1481,6 @@ static int sca3000_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 	}
-	indio_dev->setup_ops = &sca3000_ring_setup_ops;
 	ret = sca3000_clean_setup(st);
 	if (ret)
 		goto error_free_irq;
diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
index c32647abce20..1d9971db949d 100644
--- a/drivers/iio/accel/ssp_accel_sensor.c
+++ b/drivers/iio/accel/ssp_accel_sensor.c
@@ -96,7 +96,6 @@ static int ssp_accel_probe(struct platform_device *pdev)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct ssp_sensor_data *spd;
-	struct iio_buffer *buffer;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*spd));
 	if (!indio_dev)
@@ -111,18 +110,14 @@ static int ssp_accel_probe(struct platform_device *pdev)
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->dev.of_node = pdev->dev.of_node;
 	indio_dev->info = &ssp_accel_iio_info;
-	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = ssp_acc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ssp_acc_channels);
 	indio_dev->available_scan_masks = ssp_accel_scan_mask;
 
-	buffer = devm_iio_kfifo_allocate(&pdev->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	indio_dev->setup_ops = &ssp_accel_buffer_ops;
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &ssp_accel_buffer_ops);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index bdd7cba6f6b0..2070809e1acc 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -950,7 +950,6 @@ static int ina2xx_probe(struct i2c_client *client,
 {
 	struct ina2xx_chip_info *chip;
 	struct iio_dev *indio_dev;
-	struct iio_buffer *buffer;
 	unsigned int val;
 	enum ina2xx_ids type;
 	int ret;
@@ -1014,7 +1013,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->dev.of_node = client->dev.of_node;
 	if (id->driver_data == ina226) {
@@ -1027,13 +1026,11 @@ static int ina2xx_probe(struct i2c_client *client,
 		indio_dev->info = &ina219_info;
 	}
 	indio_dev->name = id->name;
-	indio_dev->setup_ops = &ina2xx_setup_ops;
 
-	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &ina2xx_setup_ops);
+	if (ret)
+		return ret;
 
 	return iio_device_register(indio_dev);
 }
diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
index 4e4ee4167544..c12d3db5a951 100644
--- a/drivers/iio/gyro/ssp_gyro_sensor.c
+++ b/drivers/iio/gyro/ssp_gyro_sensor.c
@@ -96,7 +96,6 @@ static int ssp_gyro_probe(struct platform_device *pdev)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct ssp_sensor_data *spd;
-	struct iio_buffer *buffer;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*spd));
 	if (!indio_dev)
@@ -110,18 +109,14 @@ static int ssp_gyro_probe(struct platform_device *pdev)
 	indio_dev->name = ssp_gyro_name;
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &ssp_gyro_iio_info;
-	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = ssp_gyro_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ssp_gyro_channels);
 	indio_dev->available_scan_masks = ssp_gyro_scan_mask;
 
-	buffer = devm_iio_kfifo_allocate(&pdev->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	indio_dev->setup_ops = &ssp_gyro_buffer_ops;
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &ssp_gyro_buffer_ops);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 546fc37ad75d..f4e9866f4c3d 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -418,7 +418,6 @@ static int max30100_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct max30100_data *data;
-	struct iio_buffer *buffer;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -426,21 +425,19 @@ static int max30100_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	buffer = devm_iio_kfifo_allocate(&client->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
 	indio_dev->name = MAX30100_DRV_NAME;
 	indio_dev->channels = max30100_channels;
 	indio_dev->info = &max30100_info;
 	indio_dev->num_channels = ARRAY_SIZE(max30100_channels);
 	indio_dev->available_scan_masks = max30100_scan_masks;
-	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
-	indio_dev->setup_ops = &max30100_buffer_setup_ops;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->dev.parent = &client->dev;
 
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &max30100_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	data = iio_priv(indio_dev);
 	data->indio_dev = indio_dev;
 	data->client = client;
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 74fc260b957e..e15126d23dfb 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -507,7 +507,6 @@ static int max30102_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct max30102_data *data;
-	struct iio_buffer *buffer;
 	struct iio_dev *indio_dev;
 	int ret;
 	unsigned int reg;
@@ -516,16 +515,9 @@ static int max30102_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	buffer = devm_iio_kfifo_allocate(&client->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
 	indio_dev->name = MAX30102_DRV_NAME;
 	indio_dev->info = &max30102_info;
-	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
-	indio_dev->setup_ops = &max30102_buffer_setup_ops;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->dev.parent = &client->dev;
 
 	data = iio_priv(indio_dev);
@@ -551,6 +543,11 @@ static int max30102_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &max30102_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
 	if (IS_ERR(data->regmap)) {
 		dev_err(&client->dev, "regmap initialization failed\n");
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index bb899345f2bb..4ba3d5551570 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -30,8 +30,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 #include <linux/module.h>
-#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/buffer.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
@@ -713,20 +713,17 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
 
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 {
-	struct iio_buffer *buffer;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		if (!hw->iio_devs[i])
 			continue;
 
-		buffer = devm_iio_kfifo_allocate(hw->dev);
-		if (!buffer)
-			return -ENOMEM;
-
-		iio_device_attach_buffer(hw->iio_devs[i], buffer);
-		hw->iio_devs[i]->modes |= INDIO_BUFFER_SOFTWARE;
-		hw->iio_devs[i]->setup_ops = &st_lsm6dsx_buffer_ops;
+		ret = iio_device_attach_kfifo_buffer(hw->iio_devs[i],
+						     INDIO_BUFFER_SOFTWARE,
+						     &st_lsm6dsx_buffer_ops);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 1eafd0b24e18..ea99705c3387 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -166,6 +166,7 @@ static int acpi_als_add(struct acpi_device *device)
 	struct acpi_als *als;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
 	if (!indio_dev)
@@ -180,15 +181,13 @@ static int acpi_als_add(struct acpi_device *device)
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
 	indio_dev->dev.parent = &device->dev;
 	indio_dev->info = &acpi_als_info;
-	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	buffer = devm_iio_kfifo_allocate(&device->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     NULL);
+	if (ret)
+		return ret;
 
 	return devm_iio_device_register(&device->dev, indio_dev);
 }
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 52f86bc777dd..8acc319445b6 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -987,7 +987,6 @@ static int apds9960_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct apds9960_data *data;
-	struct iio_buffer *buffer;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -995,20 +994,18 @@ static int apds9960_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	buffer = devm_iio_kfifo_allocate(&client->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &apds9960_info;
 	indio_dev->name = APDS9960_DRV_NAME;
 	indio_dev->channels = apds9960_channels;
 	indio_dev->num_channels = ARRAY_SIZE(apds9960_channels);
 	indio_dev->available_scan_masks = apds9960_scan_masks;
-	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
-	indio_dev->setup_ops = &apds9960_buffer_setup_ops;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &apds9960_buffer_setup_ops);
+	if (ret)
+		return ret;
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-- 
2.17.1

