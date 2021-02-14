Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0831B0C7
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 15:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBNOcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 09:32:14 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17356 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhBNOcF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 09:32:05 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EET6mv013816;
        Sun, 14 Feb 2021 09:31:12 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gathg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 09:31:12 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11EEVAKF054472
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 14 Feb 2021 09:31:11 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 14 Feb 2021 06:31:09 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 14 Feb 2021 06:31:09 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11EEV2ts027551;
        Sun, 14 Feb 2021 09:31:07 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/5] iio: make use of devm_iio_kfifo_buffer_setup() helper
Date:   Sun, 14 Feb 2021 16:33:11 +0200
Message-ID: <20210214143313.67202-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214143313.67202-1-alexandru.ardelean@analog.com>
References: <20210214143313.67202-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All drivers that already call devm_iio_kfifo_allocate() &
iio_device_attach_buffer() are simple to convert to
iio_device_attach_kfifo_buffer() in a single go.

This change does that; the unwind order is preserved.
What is important, is that the devm_iio_kfifo_buffer_setup() be called
after the indio_dev->modes is assigned, to make sure that
INDIO_BUFFER_SOFTWARE flag is set and not overridden by the assignment to
indio_dev->modes.

Also, the INDIO_BUFFER_SOFTWARE has been removed from the assignments of
'indio_dev->modes' because it is set by devm_iio_kfifo_buffer_setup().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/ssp_accel_sensor.c          | 14 ++++-------
 drivers/iio/adc/ina2xx-adc.c                  | 14 +++++------
 drivers/iio/adc/ti_am335x_adc.c               | 18 ++++-----------
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 13 ++++-------
 drivers/iio/gyro/ssp_gyro_sensor.c            | 14 ++++-------
 drivers/iio/health/max30100.c                 | 16 ++++++-------
 drivers/iio/health/max30102.c                 | 16 ++++++-------
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 14 +++++------
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 13 +++++------
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 15 +++++-------
 drivers/iio/light/acpi-als.c                  | 12 ++++------
 drivers/iio/light/apds9960.c                  | 16 ++++++-------
 .../staging/iio/impedance-analyzer/ad5933.c   | 23 ++++---------------
 13 files changed, 74 insertions(+), 124 deletions(-)

diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
index 474477e91b5e..04dcb2b657ee 100644
--- a/drivers/iio/accel/ssp_accel_sensor.c
+++ b/drivers/iio/accel/ssp_accel_sensor.c
@@ -96,7 +96,6 @@ static int ssp_accel_probe(struct platform_device *pdev)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct ssp_sensor_data *spd;
-	struct iio_buffer *buffer;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*spd));
 	if (!indio_dev)
@@ -109,18 +108,15 @@ static int ssp_accel_probe(struct platform_device *pdev)
 
 	indio_dev->name = ssp_accel_device_name;
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
+	ret = devm_iio_kfifo_buffer_setup(&pdev->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &ssp_accel_buffer_ops);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index b573ec60a8b8..2ae54258b221 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -953,7 +953,6 @@ static int ina2xx_probe(struct i2c_client *client,
 {
 	struct ina2xx_chip_info *chip;
 	struct iio_dev *indio_dev;
-	struct iio_buffer *buffer;
 	unsigned int val;
 	enum ina2xx_ids type;
 	int ret;
@@ -1017,7 +1016,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	if (id->driver_data == ina226) {
 		indio_dev->channels = ina226_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
@@ -1028,13 +1027,12 @@ static int ina2xx_probe(struct i2c_client *client,
 		indio_dev->info = &ina219_info;
 	}
 	indio_dev->name = id->name;
-	indio_dev->setup_ops = &ina2xx_setup_ops;
 
-	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
+	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &ina2xx_setup_ops);
+	if (ret)
+		return ret;
 
 	return iio_device_register(indio_dev);
 }
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index e946903b0993..855cc2d64ac8 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -385,24 +385,16 @@ static int tiadc_iio_buffered_hardware_setup(struct device *dev,
 	unsigned long flags,
 	const struct iio_buffer_setup_ops *setup_ops)
 {
-	struct iio_buffer *buffer;
 	int ret;
 
-	buffer = devm_iio_kfifo_allocate(dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	ret = devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
-				flags, indio_dev->name, indio_dev);
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  setup_ops);
 	if (ret)
 		return ret;
 
-	indio_dev->setup_ops = setup_ops;
-	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
-
-	return 0;
+	return devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
+				flags, indio_dev->name, indio_dev);
 }
 
 static const char * const chan_name_ain[] = {
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c833ec0ef214..f8824afe595e 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -334,14 +334,11 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			 * We can not use trigger here, as events are generated
 			 * as soon as sample_frequency is set.
 			 */
-			struct iio_buffer *buffer;
-
-			buffer = devm_iio_kfifo_allocate(dev);
-			if (!buffer)
-				return -ENOMEM;
-
-			iio_device_attach_buffer(indio_dev, buffer);
-			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+			ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+							  INDIO_BUFFER_SOFTWARE,
+							  NULL);
+			if (ret)
+				return ret;
 
 			ret = cros_ec_sensorhub_register_push_data(
 					sensor_hub, sensor_platform->sensor_num,
diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
index ac7c170a20de..46ed12771d2f 100644
--- a/drivers/iio/gyro/ssp_gyro_sensor.c
+++ b/drivers/iio/gyro/ssp_gyro_sensor.c
@@ -96,7 +96,6 @@ static int ssp_gyro_probe(struct platform_device *pdev)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct ssp_sensor_data *spd;
-	struct iio_buffer *buffer;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*spd));
 	if (!indio_dev)
@@ -109,18 +108,15 @@ static int ssp_gyro_probe(struct platform_device *pdev)
 
 	indio_dev->name = ssp_gyro_name;
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
+	ret = devm_iio_kfifo_buffer_setup(&pdev->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &ssp_gyro_buffer_ops);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 38aa2030f3c6..36ba7611d9ce 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -418,7 +418,6 @@ static int max30100_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct max30100_data *data;
-	struct iio_buffer *buffer;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -426,19 +425,18 @@ static int max30100_probe(struct i2c_client *client,
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
+
+	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &max30100_buffer_setup_ops);
+	if (ret)
+		return ret;
 
 	data = iio_priv(indio_dev);
 	data->indio_dev = indio_dev;
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index b35557a54ee2..2292876c55e2 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -506,7 +506,6 @@ static int max30102_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct max30102_data *data;
-	struct iio_buffer *buffer;
 	struct iio_dev *indio_dev;
 	int ret;
 	unsigned int reg;
@@ -515,16 +514,9 @@ static int max30102_probe(struct i2c_client *client,
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
 
 	data = iio_priv(indio_dev);
 	data->indio_dev = indio_dev;
@@ -549,6 +541,12 @@ static int max30102_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &max30102_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
 	if (IS_ERR(data->regmap)) {
 		dev_err(&client->dev, "regmap initialization failed\n");
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 3441b0d61c5d..383cc3250342 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -709,7 +709,6 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	const char *name;
 	struct inv_icm42600_timestamp *ts;
 	struct iio_dev *indio_dev;
-	struct iio_buffer *buffer;
 	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
@@ -720,23 +719,22 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
-	buffer = devm_iio_kfifo_allocate(dev);
-	if (!buffer)
-		return ERR_PTR(-ENOMEM);
-
 	ts = iio_priv(indio_dev);
 	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.accel.odr));
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_accel_info;
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = inv_icm42600_accel_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_accel_channels);
 	indio_dev->available_scan_masks = inv_icm42600_accel_scan_masks;
-	indio_dev->setup_ops = &inv_icm42600_buffer_ops;
 
-	iio_device_attach_buffer(indio_dev, buffer);
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &inv_icm42600_buffer_ops);
+	if (ret)
+		return ERR_PTR(ret);
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index aee7b9ff4bf4..cec1dd0e0464 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -720,7 +720,6 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	const char *name;
 	struct inv_icm42600_timestamp *ts;
 	struct iio_dev *indio_dev;
-	struct iio_buffer *buffer;
 	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
@@ -731,23 +730,23 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
-	buffer = devm_iio_kfifo_allocate(dev);
-	if (!buffer)
-		return ERR_PTR(-ENOMEM);
-
 	ts = iio_priv(indio_dev);
 	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.gyro.odr));
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
 	indio_dev->info = &inv_icm42600_gyro_info;
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = inv_icm42600_gyro_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_gyro_channels);
 	indio_dev->available_scan_masks = inv_icm42600_gyro_scan_masks;
 	indio_dev->setup_ops = &inv_icm42600_buffer_ops;
 
-	iio_device_attach_buffer(indio_dev, buffer);
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &inv_icm42600_buffer_ops);
+	if (ret)
+		return ERR_PTR(ret);
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index f1103ecedd64..16730a780964 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -739,20 +739,17 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
 
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
+		ret = devm_iio_kfifo_buffer_setup(hw->dev, hw->iio_devs[i],
+						  INDIO_BUFFER_SOFTWARE,
+						  &st_lsm6dsx_buffer_ops);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2be7180e2cbf..f8e547fd35e7 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -165,7 +165,7 @@ static int acpi_als_add(struct acpi_device *device)
 {
 	struct acpi_als *als;
 	struct iio_dev *indio_dev;
-	struct iio_buffer *buffer;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
 	if (!indio_dev)
@@ -179,15 +179,13 @@ static int acpi_als_add(struct acpi_device *device)
 
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
 	indio_dev->info = &acpi_als_info;
-	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	buffer = devm_iio_kfifo_allocate(&device->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
+	ret = devm_iio_kfifo_buffer_setup(&device->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE, NULL);
+	if (ret)
+		return ret;
 
 	return devm_iio_device_register(&device->dev, indio_dev);
 }
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index df0647856e5d..4141c0fa7bc4 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -988,7 +988,6 @@ static int apds9960_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct apds9960_data *data;
-	struct iio_buffer *buffer;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -996,19 +995,18 @@ static int apds9960_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	buffer = devm_iio_kfifo_allocate(&client->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
 	indio_dev->info = &apds9960_info;
 	indio_dev->name = APDS9960_DRV_NAME;
 	indio_dev->channels = apds9960_channels;
 	indio_dev->num_channels = ARRAY_SIZE(apds9960_channels);
 	indio_dev->available_scan_masks = apds9960_scan_masks;
-	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
-	indio_dev->setup_ops = &apds9960_buffer_setup_ops;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &apds9960_buffer_setup_ops);
+	if (ret)
+		return ret;
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index dba78896ea8f..793918e1c45f 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -602,23 +602,6 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 	.postdisable = ad5933_ring_postdisable,
 };
 
-static int ad5933_register_ring_funcs_and_init(struct device *dev,
-					       struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-
-	buffer = devm_iio_kfifo_allocate(dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad5933_ring_setup_ops;
-
-	return 0;
-}
-
 static void ad5933_work(struct work_struct *work)
 {
 	struct ad5933_state *st = container_of(work,
@@ -761,11 +744,13 @@ static int ad5933_probe(struct i2c_client *client,
 
 	indio_dev->info = &ad5933_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
-	ret = ad5933_register_ring_funcs_and_init(&client->dev, indio_dev);
+	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &ad5933_ring_setup_ops);
 	if (ret)
 		return ret;
 
-- 
2.17.1

