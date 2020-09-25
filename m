Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01D82782E2
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgIYIig (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 04:38:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2526 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727648AbgIYIif (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2020 04:38:35 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08P8YevO009093;
        Fri, 25 Sep 2020 04:38:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u9f97y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Sep 2020 04:38:17 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08P8cFNV054353
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Sep 2020 04:38:16 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 25 Sep
 2020 01:38:12 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 25 Sep 2020 01:38:12 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08P8c5uH006205;
        Fri, 25 Sep 2020 04:38:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 4/5] iio: buffer: extend arg list for {devm_}iio_triggered_buffer_setup()
Date:   Fri, 25 Sep 2020 11:37:42 +0300
Message-ID: <20200925083743.46469-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925083743.46469-1-alexandru.ardelean@analog.com>
References: <20200925083743.46469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-25_02:2020-09-24,2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=989 suspectscore=2 clxscore=1015
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This runs the following semantic patches on the drivers/iio folder:
@@
expression E1, E2, E3, E4;
@@
  iio_triggered_buffer_setup(E1, E2, E3, E4
+ ,NULL
  )

and

@@
expression E1, E2, E3, E4, E5;
@@
  devm_iio_triggered_buffer_setup(E1, E2, E3, E4, E5
+ ,NULL
  )

The argument list is extended, in order to move the buffer attributes as
an argument to the {devm_}iio_triggered_buffer_setup() functions.

Naturally, the {devm_}iio_triggered_buffer_setup() have been edited
manually in this same patch, to assign the IIO buffer attributes to the
buffer, when it is allocated and attached inside
iio_triggered_buffer_setup().

What happens now, is that we can remove the iio_buffer_set_attrs() helper,
since this operation will be done inside iio_triggered_buffer_setup().

This will allow for a more granular IIO buffer setup. We can have some IIO
buffers that get extra sysfs attributes, and some that don't get any extra
sysfs attributes.

These extra sysfs attributes should be pushed to the functions that
allocate them.

The problem with iio_buffer_set_attrs() [once adding more buffers], is that
it's cumbersome to first alloc a set of buffers, then dig them out of IIO
in order to assign any extra attributes.

On the other hand, it's not a good idea to enforce that the extra
attributes be assigned to all IIO buffers. Some may not need/want them.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372.c                               | 2 +-
 drivers/iio/accel/bma180.c                                | 2 +-
 drivers/iio/accel/bma220_spi.c                            | 2 +-
 drivers/iio/accel/bmc150-accel-core.c                     | 2 +-
 drivers/iio/accel/kxcjk-1013.c                            | 2 +-
 drivers/iio/accel/kxsd9.c                                 | 2 +-
 drivers/iio/accel/mma7455_core.c                          | 2 +-
 drivers/iio/accel/mma8452.c                               | 2 +-
 drivers/iio/accel/mxc4005.c                               | 2 +-
 drivers/iio/accel/st_accel_buffer.c                       | 2 +-
 drivers/iio/accel/stk8312.c                               | 2 +-
 drivers/iio/accel/stk8ba50.c                              | 2 +-
 drivers/iio/adc/ad7266.c                                  | 3 ++-
 drivers/iio/adc/ad7298.c                                  | 2 +-
 drivers/iio/adc/ad7476.c                                  | 2 +-
 drivers/iio/adc/ad7606.c                                  | 2 +-
 drivers/iio/adc/ad7766.c                                  | 2 +-
 drivers/iio/adc/ad7768-1.c                                | 2 +-
 drivers/iio/adc/ad7887.c                                  | 2 +-
 drivers/iio/adc/ad7923.c                                  | 2 +-
 drivers/iio/adc/ad799x.c                                  | 2 +-
 drivers/iio/adc/ad_sigma_delta.c                          | 2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                        | 2 +-
 drivers/iio/adc/at91_adc.c                                | 2 +-
 drivers/iio/adc/cc10001_adc.c                             | 2 +-
 drivers/iio/adc/dln2-adc.c                                | 3 ++-
 drivers/iio/adc/hx711.c                                   | 3 ++-
 drivers/iio/adc/max1027.c                                 | 2 +-
 drivers/iio/adc/max1118.c                                 | 2 +-
 drivers/iio/adc/max1363.c                                 | 2 +-
 drivers/iio/adc/mxs-lradc-adc.c                           | 2 +-
 drivers/iio/adc/rockchip_saradc.c                         | 2 +-
 drivers/iio/adc/stm32-adc.c                               | 2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                         | 2 +-
 drivers/iio/adc/ti-adc081c.c                              | 3 ++-
 drivers/iio/adc/ti-adc0832.c                              | 2 +-
 drivers/iio/adc/ti-adc084s021.c                           | 3 ++-
 drivers/iio/adc/ti-adc108s102.c                           | 3 ++-
 drivers/iio/adc/ti-adc12138.c                             | 2 +-
 drivers/iio/adc/ti-adc161s626.c                           | 2 +-
 drivers/iio/adc/ti-ads1015.c                              | 2 +-
 drivers/iio/adc/ti-ads124s08.c                            | 3 ++-
 drivers/iio/adc/ti-ads7950.c                              | 3 ++-
 drivers/iio/adc/ti-ads8688.c                              | 3 ++-
 drivers/iio/adc/ti-tlc4541.c                              | 2 +-
 drivers/iio/adc/vf610_adc.c                               | 3 ++-
 drivers/iio/adc/xilinx-xadc-core.c                        | 2 +-
 drivers/iio/chemical/atlas-sensor.c                       | 2 +-
 drivers/iio/chemical/ccs811.c                             | 2 +-
 drivers/iio/chemical/pms7003.c                            | 3 ++-
 drivers/iio/chemical/scd30_core.c                         | 3 ++-
 drivers/iio/chemical/sps30.c                              | 3 ++-
 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c    | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c       | 2 +-
 drivers/iio/gyro/adxrs290.c                               | 3 ++-
 drivers/iio/gyro/bmg160_core.c                            | 2 +-
 drivers/iio/gyro/fxas21002c_core.c                        | 3 ++-
 drivers/iio/gyro/itg3200_buffer.c                         | 2 +-
 drivers/iio/gyro/mpu3050-core.c                           | 2 +-
 drivers/iio/gyro/st_gyro_buffer.c                         | 2 +-
 drivers/iio/health/afe4403.c                              | 2 +-
 drivers/iio/health/afe4404.c                              | 2 +-
 drivers/iio/humidity/am2315.c                             | 2 +-
 drivers/iio/humidity/hdc100x.c                            | 2 +-
 drivers/iio/humidity/hts221_buffer.c                      | 2 +-
 drivers/iio/imu/adis_buffer.c                             | 2 +-
 drivers/iio/imu/bmi160/bmi160_core.c                      | 3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                | 2 +-
 drivers/iio/imu/kmx61.c                                   | 4 ++--
 drivers/iio/light/adjd_s311.c                             | 2 +-
 drivers/iio/light/as73211.c                               | 3 ++-
 drivers/iio/light/gp2ap020a00f.c                          | 3 ++-
 drivers/iio/light/isl29125.c                              | 2 +-
 drivers/iio/light/ltr501.c                                | 2 +-
 drivers/iio/light/max44000.c                              | 3 ++-
 drivers/iio/light/rpr0521.c                               | 2 +-
 drivers/iio/light/si1145.c                                | 2 +-
 drivers/iio/light/st_uvis25_core.c                        | 2 +-
 drivers/iio/light/tcs3414.c                               | 2 +-
 drivers/iio/light/tcs3472.c                               | 2 +-
 drivers/iio/light/vcnl4000.c                              | 3 ++-
 drivers/iio/light/vcnl4035.c                              | 2 +-
 drivers/iio/magnetometer/ak8974.c                         | 2 +-
 drivers/iio/magnetometer/ak8975.c                         | 2 +-
 drivers/iio/magnetometer/bmc150_magn.c                    | 2 +-
 drivers/iio/magnetometer/hmc5843_core.c                   | 2 +-
 drivers/iio/magnetometer/mag3110.c                        | 2 +-
 drivers/iio/magnetometer/rm3100-core.c                    | 2 +-
 drivers/iio/magnetometer/st_magn_buffer.c                 | 2 +-
 drivers/iio/potentiostat/lmp91000.c                       | 2 +-
 drivers/iio/pressure/dlhl60d.c                            | 2 +-
 drivers/iio/pressure/mpl3115.c                            | 2 +-
 drivers/iio/pressure/ms5611_core.c                        | 2 +-
 drivers/iio/pressure/st_pressure_buffer.c                 | 2 +-
 drivers/iio/pressure/zpa2326.c                            | 2 +-
 drivers/iio/proximity/as3935.c                            | 3 ++-
 drivers/iio/proximity/isl29501.c                          | 2 +-
 drivers/iio/proximity/mb1232.c                            | 3 ++-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c         | 2 +-
 drivers/iio/proximity/srf08.c                             | 3 ++-
 drivers/iio/proximity/sx9310.c                            | 2 +-
 drivers/iio/proximity/sx9500.c                            | 2 +-
 drivers/iio/temperature/maxim_thermocouple.c              | 3 ++-
 104 files changed, 129 insertions(+), 105 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index aed2a4930fb0..0c0de7f47815 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1214,7 +1214,7 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup(dev,
 					      indio_dev, NULL,
 					      adxl372_trigger_handler,
-					      &adxl372_buffer_ops);
+					      &adxl372_buffer_ops, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 6b74c2b04c15..26e2ac1f91aa 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1067,7 +1067,7 @@ static int bma180_probe(struct i2c_client *client,
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-			bma180_trigger_handler, NULL);
+			bma180_trigger_handler, NULL, NULL);
 	if (ret < 0) {
 		dev_err(dev, "unable to setup iio triggered buffer\n");
 		goto err_trigger_unregister;
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 3c9b0c6954e6..d514d8b48176 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -259,7 +259,7 @@ static int bma220_probe(struct spi_device *spi)
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-					 bma220_trigger_handler, NULL);
+					 bma220_trigger_handler, NULL, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
 		goto err_suspend;
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 48435865fdaf..fe3aa6554c23 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1593,7 +1593,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time,
 					 bmc150_accel_trigger_handler,
-					 &bmc150_accel_buffer_ops);
+					 &bmc150_accel_buffer_ops, NULL);
 	if (ret < 0) {
 		dev_err(dev, "Failed: iio triggered buffer setup\n");
 		return ret;
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index beb38d9d607d..de999dec3e69 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1366,7 +1366,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time,
 					 kxcjk1013_trigger_handler,
-					 &kxcjk1013_buffer_setup_ops);
+					 &kxcjk1013_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		goto err_trigger_unregister;
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0e18b92e2099..daf869aefa31 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -442,7 +442,7 @@ int kxsd9_common_probe(struct device *dev,
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 iio_pollfunc_store_time,
 					 kxsd9_trigger_handler,
-					 &kxsd9_buffer_setup_ops);
+					 &kxsd9_buffer_setup_ops, NULL);
 	if (ret) {
 		dev_err(dev, "triggered buffer setup failed\n");
 		goto err_power_down;
diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 922bd38ff6ea..6a74b5bd064a 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -277,7 +277,7 @@ int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 		     MMA7455_MCTL_MODE_MEASURE);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 mma7455_trigger_handler, NULL);
+					 mma7455_trigger_handler, NULL, NULL);
 	if (ret) {
 		dev_err(dev, "unable to setup triggered buffer\n");
 		return ret;
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index bf1d2c8afdbd..ae1cb3d80610 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1652,7 +1652,7 @@ static int mma8452_probe(struct i2c_client *client,
 		goto trigger_cleanup;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 mma8452_trigger_handler, NULL);
+					 mma8452_trigger_handler, NULL, NULL);
 	if (ret < 0)
 		goto trigger_cleanup;
 
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index f877263dc6ef..b591071b9096 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -426,7 +426,7 @@ static int mxc4005_probe(struct i2c_client *client,
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
 					 iio_pollfunc_store_time,
 					 mxc4005_trigger_handler,
-					 NULL);
+					 NULL, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"failed to setup iio triggered buffer\n");
diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 492263589e04..0a691e37a601 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -68,7 +68,7 @@ static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
 int st_accel_allocate_ring(struct iio_dev *indio_dev)
 {
 	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
+		&st_sensors_trigger_handler, &st_accel_buffer_setup_ops, NULL);
 }
 
 void st_accel_deallocate_ring(struct iio_dev *indio_dev)
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 3b59887a8581..201f8009a4f5 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -571,7 +571,7 @@ static int stk8312_probe(struct i2c_client *client,
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 iio_pollfunc_store_time,
 					 stk8312_trigger_handler,
-					 &stk8312_buffer_setup_ops);
+					 &stk8312_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		goto err_trigger_unregister;
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 3ead378b02c9..53345818797c 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -467,7 +467,7 @@ static int stk8ba50_probe(struct i2c_client *client,
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 iio_pollfunc_store_time,
 					 stk8ba50_trigger_handler,
-					 &stk8ba50_buffer_setup_ops);
+					 &stk8ba50_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		goto err_trigger_unregister;
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index a8ec3efd659e..02c901c0eeca 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -459,7 +459,8 @@ static int ad7266_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->single_xfer[2], &st->single_msg);
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-		&ad7266_trigger_handler, &iio_triggered_buffer_setup_ops);
+		&ad7266_trigger_handler, &iio_triggered_buffer_setup_ops,
+		NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 48d43cb0f932..1307acfee2f8 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -334,7 +334,7 @@ static int ad7298_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-			&ad7298_trigger_handler, NULL);
+			&ad7298_trigger_handler, NULL, NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 66c55ae67791..646f5aadeb00 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -317,7 +317,7 @@ static int ad7476_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->xfer, &st->msg);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-			&ad7476_trigger_handler, NULL);
+			&ad7476_trigger_handler, NULL, NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ee7b108688b3..449c8b1e37af 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -687,7 +687,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      &ad7606_trigger_handler,
-					      &ad7606_buffer_ops);
+					      &ad7606_buffer_ops, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index b6b6765be7b4..76f34671b67d 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -287,7 +287,7 @@ static int ad7766_probe(struct spi_device *spi)
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 		&iio_pollfunc_store_time, &ad7766_trigger_handler,
-		&ad7766_buffer_setup_ops);
+		&ad7766_buffer_setup_ops, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0e93b0766eb4..a8c21aba2e70 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -614,7 +614,7 @@ static int ad7768_probe(struct spi_device *spi)
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      &ad7768_trigger_handler,
-					      &ad7768_buffer_ops);
+					      &ad7768_buffer_ops, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 037bcb47693c..93e263100345 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -313,7 +313,7 @@ static int ad7887_probe(struct spi_device *spi)
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
+			&ad7887_trigger_handler, &ad7887_ring_setup_ops, NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index a2cc96658054..9f2f153daf4c 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -341,7 +341,7 @@ static int ad7923_probe(struct spi_device *spi)
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &ad7923_trigger_handler, NULL);
+					 &ad7923_trigger_handler, NULL, NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 1575b7670207..4788b54ff922 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -826,7 +826,7 @@ static int ad799x_probe(struct i2c_client *client,
 		goto error_disable_vref;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		&ad799x_trigger_handler, NULL);
+		&ad799x_trigger_handler, NULL, NULL);
 	if (ret)
 		goto error_disable_vref;
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 86039e9ecaca..a2f0572d3488 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -536,7 +536,7 @@ int ad_sd_setup_buffer_and_trigger(struct iio_dev *indio_dev)
 	int ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-			&ad_sd_trigger_handler, &ad_sd_buffer_setup_ops);
+			&ad_sd_trigger_handler, &ad_sd_buffer_setup_ops, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ad7d9819f83c..89a18184b59a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1160,7 +1160,7 @@ static int at91_adc_buffer_init(struct iio_dev *indio)
 {
 	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
 		&iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
+		&at91_adc_trigger_handler, &at91_buffer_setup_ops, NULL);
 }
 
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9b2c548fae95..ec204c753ec5 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -675,7 +675,7 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
 static int at91_adc_buffer_init(struct iio_dev *idev)
 {
 	return iio_triggered_buffer_setup(idev, &iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, NULL);
+		&at91_adc_trigger_handler, NULL, NULL);
 }
 
 static void at91_adc_buffer_remove(struct iio_dev *idev)
diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index e16ac935693b..9c16cdb2f81b 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -383,7 +383,7 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	mutex_init(&adc_dev->lock);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &cc10001_adc_trigger_h, NULL);
+					 &cc10001_adc_trigger_h, NULL, NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 0d53ef18e045..9d750ed22250 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -660,7 +660,8 @@ static int dln2_adc_probe(struct platform_device *pdev)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      dln2_adc_trigger_h,
-					      &dln2_adc_buffer_setup_ops);
+					      &dln2_adc_buffer_setup_ops,
+					      NULL);
 	if (ret) {
 		dev_err(dev, "failed to allocate triggered buffer: %d\n", ret);
 		return ret;
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 6a173531d355..3ae83ff72547 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -557,7 +557,8 @@ static int hx711_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
 
 	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-							hx711_trigger, NULL);
+							hx711_trigger, NULL,
+							NULL);
 	if (ret < 0) {
 		dev_err(dev, "setup of iio triggered buffer failed\n");
 		goto error_regulator;
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index ca1dff3924ff..1a619a809f17 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -457,7 +457,7 @@ static int max1027_probe(struct spi_device *spi)
 		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 						      &iio_pollfunc_store_time,
 						      &max1027_trigger_handler,
-						      NULL);
+						      NULL, NULL);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
 			return ret;
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 6efb0b43d938..b279b9c177b4 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -244,7 +244,7 @@ static int max1118_probe(struct spi_device *spi)
 	max1118_read(spi, 0);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					max1118_trigger_handler, NULL);
+					max1118_trigger_handler, NULL, NULL);
 	if (ret)
 		goto err_reg_disable;
 
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index f2b576c69949..a5a412631b3a 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1658,7 +1658,7 @@ static int max1363_probe(struct i2c_client *client,
 		goto error_disable_reg;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		&max1363_trigger_handler, NULL);
+		&max1363_trigger_handler, NULL, NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 30e29f44ebd2..fb8450711ee1 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -760,7 +760,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
 					 &mxs_lradc_adc_trigger_handler,
-					 &mxs_lradc_adc_buffer_ops);
+					 &mxs_lradc_adc_buffer_ops, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 1f3d7d639d37..7be4d201d57b 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -426,7 +426,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = info->data->num_channels;
 	ret = devm_iio_triggered_buffer_setup(&indio_dev->dev, indio_dev, NULL,
 					      rockchip_saradc_trigger_handler,
-					      NULL);
+					      NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b3f31f147347..e4b8424f041e 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1918,7 +1918,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time, handler,
-					 &stm32_adc_buffer_setup_ops);
+					 &stm32_adc_buffer_setup_ops, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "buffer setup failed\n");
 		goto err_dma_disable;
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index c7e0109315f8..a5d7bd987f0e 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1483,7 +1483,7 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time, NULL,
-					 &stm32_dfsdm_buffer_setup_ops);
+					 &stm32_dfsdm_buffer_setup_ops, NULL);
 	if (ret) {
 		stm32_dfsdm_dma_release(indio_dev);
 		dev_err(&indio_dev->dev, "buffer setup failed\n");
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index b64718daa201..c5928ee4642b 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -182,7 +182,8 @@ static int adc081c_probe(struct i2c_client *client,
 	iio->channels = model->channels;
 	iio->num_channels = ADC081C_NUM_CHANNELS;
 
-	err = iio_triggered_buffer_setup(iio, NULL, adc081c_trigger_handler, NULL);
+	err = iio_triggered_buffer_setup(iio, NULL, adc081c_trigger_handler,
+					 NULL, NULL);
 	if (err < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		goto err_regulator_disable;
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 0261b3cfc92b..8ccdcbb126e0 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -290,7 +290,7 @@ static int adc0832_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 adc0832_trigger_handler, NULL);
+					 adc0832_trigger_handler, NULL, NULL);
 	if (ret)
 		goto err_reg_disable;
 
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index dfba34834a57..586f9fe1c20d 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -235,7 +235,8 @@ static int adc084s021_probe(struct spi_device *spi)
 	/* Setup triggered buffer with pollfunction */
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					    adc084s021_buffer_trigger_handler,
-					    &adc084s021_buffer_setup_ops);
+					    &adc084s021_buffer_setup_ops,
+					    NULL);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
 		return ret;
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 183b2245e89b..667d9669e2b7 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -267,7 +267,8 @@ static int adc108s102_probe(struct spi_device *spi)
 					&st->scan_single_xfer, 1);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &adc108s102_trigger_handler, NULL);
+					 &adc108s102_trigger_handler, NULL,
+					 NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index fcd5d39dd03e..d8b2c9743804 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -479,7 +479,7 @@ static int adc12138_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 adc12138_trigger_handler, NULL);
+					 adc12138_trigger_handler, NULL, NULL);
 	if (ret)
 		goto err_vref_n_disable;
 
diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 607791ffe7f0..6cd4c9bab8aa 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -210,7 +210,7 @@ static int ti_adc_probe(struct spi_device *spi)
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 ti_adc_trigger_handler, NULL);
+					 ti_adc_trigger_handler, NULL, NULL);
 	if (ret)
 		goto error_regulator_disable;
 
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9fef39bcf997..72b490bdb44a 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -994,7 +994,7 @@ static int ads1015_probe(struct i2c_client *client,
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
-					      &ads1015_buffer_setup_ops);
+					      &ads1015_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 4b4fbe33930c..bc79e43754bf 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -333,7 +333,8 @@ static int ads124s_probe(struct spi_device *spi)
 	mutex_init(&ads124s_priv->lock);
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
-					      ads124s_trigger_handler, NULL);
+					      ads124s_trigger_handler, NULL,
+					      NULL);
 	if (ret) {
 		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
 		return ret;
diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 2383eacada87..a7df46356ca3 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -613,7 +613,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &ti_ads7950_trigger_handler, NULL);
+					 &ti_ads7950_trigger_handler, NULL,
+					 NULL);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
 		goto error_disable_reg;
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 16bcb37eebb7..c1d3118eab2b 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -458,7 +458,8 @@ static int ads8688_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler,
+					 NULL, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
 		goto err_regulator_disable;
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 403b787f9f7e..99eac7e410f8 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -206,7 +206,7 @@ static int tlc4541_probe(struct spi_device *spi)
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-			&tlc4541_trigger_handler, NULL);
+			&tlc4541_trigger_handler, NULL, NULL);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 1d794cf3e3f1..ca0693cdac94 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -871,7 +871,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	vf610_adc_hw_init(info);
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					NULL, &iio_triggered_buffer_setup_ops);
+					NULL, &iio_triggered_buffer_setup_ops,
+					NULL);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
 		goto error_iio_device_register;
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d0b7ef296afb..bf700e18eb2a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1230,7 +1230,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
 		ret = iio_triggered_buffer_setup(indio_dev,
 			&iio_pollfunc_store_time, &xadc_trigger_handler,
-			&xadc_buffer_ops);
+			&xadc_buffer_ops, NULL);
 		if (ret)
 			goto err_device_free;
 
diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index cdab9d04dedd..352b23992a0d 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -676,7 +676,7 @@ static int atlas_probe(struct i2c_client *client,
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-		&atlas_trigger_handler, &atlas_buffer_setup_ops);
+		&atlas_trigger_handler, &atlas_buffer_setup_ops, NULL);
 	if (ret) {
 		dev_err(&client->dev, "cannot setup iio trigger\n");
 		goto unregister_trigger;
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 60dd87e96f5f..e9428ca2c893 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -508,7 +508,7 @@ static int ccs811_probe(struct i2c_client *client,
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 ccs811_trigger_handler, NULL);
+					 ccs811_trigger_handler, NULL, NULL);
 
 	if (ret < 0) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index e9d4405654bc..d5450ce8e020 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -319,7 +319,8 @@ static int pms7003_probe(struct serdev_device *serdev)
 		return ret;
 
 	ret = devm_iio_triggered_buffer_setup(&serdev->dev, indio_dev, NULL,
-					      pms7003_trigger_handler, NULL);
+					      pms7003_trigger_handler, NULL,
+					      NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 4d0d798c7cd3..c80cc40c5d63 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -730,7 +730,8 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 		}
 	}
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd30_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd30_trigger_handler,
+					      NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 2ea9a5c4d846..f594e656b154 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -516,7 +516,8 @@ static int sps30_probe(struct i2c_client *client)
 		return ret;
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
-					      sps30_trigger_handler, NULL);
+					      sps30_trigger_handler, NULL,
+					      NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index 752f59037715..b7be9c6cb96c 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -110,7 +110,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-			cros_ec_sensors_capture, NULL);
+			cros_ec_sensors_capture, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c62cacc04672..678cb9ad9e29 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -359,7 +359,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			 */
 			ret = devm_iio_triggered_buffer_setup(
 					dev, indio_dev, NULL, trigger_capture,
-					NULL);
+					NULL, NULL);
 			if (ret)
 				return ret;
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index ff375790b7e8..2f1cf242c156 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -251,7 +251,7 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	struct iio_trigger *trig;
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 NULL, NULL);
+					 NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
 		return ret;
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index ca6fc234076e..1cb907a6370e 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -678,7 +678,8 @@ static int adxrs290_probe(struct spi_device *spi)
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      &iio_pollfunc_store_time,
-					      &adxrs290_trigger_handler, NULL);
+					      &adxrs290_trigger_handler, NULL,
+					      NULL);
 	if (ret < 0)
 		return dev_err_probe(&spi->dev, ret,
 				     "iio triggered buffer setup failed\n");
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 8ddda96455fc..e872ff568234 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1147,7 +1147,7 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 iio_pollfunc_store_time,
 					 bmg160_trigger_handler,
-					 &bmg160_buffer_setup_ops);
+					 &bmg160_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(dev,
 			"iio triggered buffer setup failed\n");
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 129eead8febc..7af88f8f7984 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -982,7 +982,8 @@ int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		return ret;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-					      fxas21002c_trigger_handler, NULL);
+					      fxas21002c_trigger_handler,
+					      NULL, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 1c3c1bd53374..5bfc47aebc73 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -70,7 +70,7 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 int itg3200_buffer_configure(struct iio_dev *indio_dev)
 {
 	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-		itg3200_trigger_handler, NULL);
+		itg3200_trigger_handler, NULL, NULL);
 }
 
 void itg3200_buffer_unconfigure(struct iio_dev *indio_dev)
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 00e58060968c..3b131188a7ae 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1205,7 +1205,7 @@ int mpu3050_common_probe(struct device *dev,
 
 	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
 					 mpu3050_trigger_handler,
-					 &mpu3050_buffer_setup_ops);
+					 &mpu3050_buffer_setup_ops, NULL);
 	if (ret) {
 		dev_err(dev, "triggered buffer setup failed\n");
 		goto err_power_down;
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 4feb7ada7195..2258fbd046dc 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -67,7 +67,7 @@ static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
 int st_gyro_allocate_ring(struct iio_dev *indio_dev)
 {
 	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_gyro_buffer_setup_ops);
+		&st_sensors_trigger_handler, &st_gyro_buffer_setup_ops, NULL);
 }
 
 void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 38734e4ce360..ede6d5c25fb2 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -551,7 +551,7 @@ static int afe4403_probe(struct spi_device *spi)
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 afe4403_trigger_handler, NULL);
+					 afe4403_trigger_handler, NULL, NULL);
 	if (ret) {
 		dev_err(afe->dev, "Unable to setup buffer\n");
 		goto err_trig;
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 61fe4932d81d..ad32f66e2900 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -558,7 +558,7 @@ static int afe4404_probe(struct i2c_client *client,
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 afe4404_trigger_handler, NULL);
+					 afe4404_trigger_handler, NULL, NULL);
 	if (ret) {
 		dev_err(afe->dev, "Unable to setup buffer\n");
 		goto unregister_trigger;
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 02ad1767c845..ff672057d524 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -241,7 +241,7 @@ static int am2315_probe(struct i2c_client *client,
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev,
 					indio_dev, iio_pollfunc_store_time,
-					 am2315_trigger_handler, NULL);
+					 am2315_trigger_handler, NULL, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 2a957f19048e..dc9cb1afb085 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -385,7 +385,7 @@ static int hdc100x_probe(struct i2c_client *client,
 	ret = devm_iio_triggered_buffer_setup(&client->dev,
 					 indio_dev, NULL,
 					 hdc100x_trigger_handler,
-					 &hdc_buffer_setup_ops);
+					 &hdc_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 95e56917677f..919bf933aaad 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -194,7 +194,7 @@ int hts221_allocate_buffers(struct iio_dev *iio_dev)
 	struct hts221_hw *hw = iio_priv(iio_dev);
 	return devm_iio_triggered_buffer_setup(hw->dev, iio_dev,
 					NULL, hts221_buffer_handler_thread,
-					&hts221_buffer_ops);
+					&hts221_buffer_ops, NULL);
 }
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index ac354321f63a..5b3460991680 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -192,7 +192,7 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 
 	ret = devm_iio_triggered_buffer_setup(&adis->spi->dev, indio_dev,
 					      &iio_pollfunc_store_time,
-					      trigger_handler, NULL);
+					      trigger_handler, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 222ebb26f013..a52c4e5364bf 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -878,7 +878,8 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      bmi160_trigger_handler, NULL);
+					      bmi160_trigger_handler, NULL,
+					      NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 18a1898e3e34..2d65881fb53e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1587,7 +1587,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	result = devm_iio_triggered_buffer_setup(dev, indio_dev,
 						 iio_pollfunc_store_time,
 						 inv_mpu6050_read_fifo,
-						 NULL);
+						 NULL, NULL);
 	if (result) {
 		dev_err(dev, "configure buffer fail %d\n", result);
 		return result;
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 61885e99d3fc..8118294d8442 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1363,7 +1363,7 @@ static int kmx61_probe(struct i2c_client *client,
 		ret = iio_triggered_buffer_setup(data->acc_indio_dev,
 						 &iio_pollfunc_store_time,
 						 kmx61_trigger_handler,
-						 NULL);
+						 NULL, NULL);
 		if (ret < 0) {
 			dev_err(&data->client->dev,
 				"Failed to setup acc triggered buffer\n");
@@ -1373,7 +1373,7 @@ static int kmx61_probe(struct i2c_client *client,
 		ret = iio_triggered_buffer_setup(data->mag_indio_dev,
 						 &iio_pollfunc_store_time,
 						 kmx61_trigger_handler,
-						 NULL);
+						 NULL, NULL);
 		if (ret < 0) {
 			dev_err(&data->client->dev,
 				"Failed to setup mag triggered buffer\n");
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 17dac8d0e11d..f82eff6bd3ff 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -266,7 +266,7 @@ static int adjd_s311_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	err = iio_triggered_buffer_setup(indio_dev, NULL,
-		adjd_s311_trigger_handler, NULL);
+		adjd_s311_trigger_handler, NULL, NULL);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 7b32dfaee9b3..e5d2e659d61a 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -739,7 +739,8 @@ static int as73211_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, as73211_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, as73211_trigger_handler,
+					      NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index e2850c1a7353..2f2f64c7127c 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1525,7 +1525,8 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
 
 	/* Allocate buffer */
 	err = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-		&gp2ap020a00f_trigger_handler, &gp2ap020a00f_buffer_setup_ops);
+		&gp2ap020a00f_trigger_handler, &gp2ap020a00f_buffer_setup_ops,
+		NULL);
 	if (err < 0)
 		goto error_regulator_disable;
 
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index b93b85dbc3a6..001c4b2cb0a5 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -275,7 +275,7 @@ static int isl29125_probe(struct i2c_client *client,
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		isl29125_trigger_handler, &isl29125_buffer_setup_ops);
+		isl29125_trigger_handler, &isl29125_buffer_setup_ops, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index b4323d2db0b1..5bfd65fbec17 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1510,7 +1510,7 @@ static int ltr501_probe(struct i2c_client *client,
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 ltr501_trigger_handler, NULL);
+					 ltr501_trigger_handler, NULL, NULL);
 	if (ret)
 		goto powerdown_on_error;
 
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index b8e721bced5b..52cc87ca0a46 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -589,7 +589,8 @@ static int max44000_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler, NULL);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler,
+					 NULL, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index aa2972b04833..4eca0f6aad0f 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1014,7 +1014,7 @@ static int rpr0521_probe(struct i2c_client *client,
 			indio_dev,
 			rpr0521_trigger_consumer_store_time,
 			rpr0521_trigger_consumer_handler,
-			&rpr0521_buffer_setup_ops);
+			&rpr0521_buffer_setup_ops, NULL);
 		if (ret < 0) {
 			dev_err(&client->dev, "iio triggered buffer setup failed\n");
 			goto err_pm_disable;
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index b304801c7916..6d525cbba708 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1323,7 +1323,7 @@ static int si1145_probe(struct i2c_client *client,
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev,
 		indio_dev, NULL,
-		si1145_trigger_handler, &si1145_buffer_setup_ops);
+		si1145_trigger_handler, &si1145_buffer_setup_ops, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index a18a82e6bbf5..3996ca3c2607 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -258,7 +258,7 @@ static int st_uvis25_allocate_buffer(struct iio_dev *iio_dev)
 	return devm_iio_triggered_buffer_setup(regmap_get_device(hw->regmap),
 					       iio_dev, NULL,
 					       st_uvis25_buffer_handler_thread,
-					       &st_uvis25_buffer_ops);
+					       &st_uvis25_buffer_ops, NULL);
 }
 
 static const struct iio_info st_uvis25_info = {
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 6fe5d46f80d4..33dd320316fc 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -317,7 +317,7 @@ static int tcs3414_probe(struct i2c_client *client,
 	data->gain = ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		tcs3414_trigger_handler, &tcs3414_buffer_setup_ops);
+		tcs3414_trigger_handler, &tcs3414_buffer_setup_ops, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index a0dc447aeb68..e357eeb89764 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -510,7 +510,7 @@ static int tcs3472_probe(struct i2c_client *client,
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		tcs3472_trigger_handler, NULL);
+		tcs3472_trigger_handler, NULL, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fff4b36b8b58..02cfe8ffdd8c 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1047,7 +1047,8 @@ static int vcnl4000_probe(struct i2c_client *client,
 		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
 						      NULL,
 						      vcnl4010_trigger_handler,
-						      &vcnl4010_buffer_ops);
+						      &vcnl4010_buffer_ops,
+						      NULL);
 		if (ret < 0) {
 			dev_err(&client->dev,
 				"unable to setup iio triggered buffer\n");
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 765c44adac57..62bdc8f24e09 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -524,7 +524,7 @@ static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
 	/* Trigger setup */
 	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
 					NULL, vcnl4035_trigger_consumer_handler,
-					&iio_triggered_buffer_setup_ops);
+					&iio_triggered_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "iio triggered buffer setup failed\n");
 		return ret;
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 24b2f7b1fe44..f16dedc5ab2e 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -910,7 +910,7 @@ static int ak8974_probe(struct i2c_client *i2c,
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 ak8974_handle_trigger,
-					 NULL);
+					 NULL, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "triggered buffer setup failed\n");
 		goto disable_pm;
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d988b6ac3659..62100778688f 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -952,7 +952,7 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->name = name;
 
 	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
-					 NULL);
+					 NULL, NULL);
 	if (err) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
 		goto power_off;
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index fc6840f9c1fa..ff82d1f3c6b1 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -923,7 +923,7 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 iio_pollfunc_store_time,
 					 bmc150_magn_trigger_handler,
-					 &bmc150_magn_buffer_setup_ops);
+					 &bmc150_magn_buffer_setup_ops, NULL);
 	if (ret < 0) {
 		dev_err(dev, "iio triggered buffer setup failed\n");
 		goto err_free_irq;
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 780faea61d82..5df9687da5ec 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -654,7 +654,7 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 hmc5843_trigger_handler, NULL);
+					 hmc5843_trigger_handler, NULL, NULL);
 	if (ret < 0)
 		goto buffer_setup_err;
 
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 838b13c8bb3d..434698be5662 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -531,7 +531,7 @@ static int mag3110_probe(struct i2c_client *client,
 		goto standby_on_error;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		mag3110_trigger_handler, NULL);
+		mag3110_trigger_handler, NULL, NULL);
 	if (ret < 0)
 		goto standby_on_error;
 
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 7242897a05e9..54bc41e39723 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -588,7 +588,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      rm3100_trigger_handler,
-					      &rm3100_buffer_ops);
+					      &rm3100_buffer_ops, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 4917721fa2e5..edb043bea15b 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -47,7 +47,7 @@ static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
 int st_magn_allocate_ring(struct iio_dev *indio_dev)
 {
 	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_magn_buffer_setup_ops);
+		&st_sensors_trigger_handler, &st_magn_buffer_setup_ops, NULL);
 }
 
 void st_magn_deallocate_ring(struct iio_dev *indio_dev)
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index f34ca769dc20..43a269126135 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -352,7 +352,7 @@ static int lmp91000_probe(struct i2c_client *client,
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 &lmp91000_buffer_handler,
-					 &lmp91000_buffer_setup_ops);
+					 &lmp91000_buffer_setup_ops, NULL);
 	if (ret)
 		goto error_unreg_trigger;
 
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index ade73267d5eb..4c240061d691 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -331,7 +331,7 @@ static int dlh_probe(struct i2c_client *client,
 	}
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
-		NULL, &dlh_trigger_handler, NULL);
+		NULL, &dlh_trigger_handler, NULL, NULL);
 	if (ret) {
 		dev_err(&client->dev, "failed to setup iio buffer\n");
 		return ret;
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index ccdb0b70e48c..a7616604e219 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -257,7 +257,7 @@ static int mpl3115_probe(struct i2c_client *client,
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		mpl3115_trigger_handler, NULL);
+		mpl3115_trigger_handler, NULL, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 214b0d25f598..b2feb41e0c74 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -452,7 +452,7 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 ms5611_trigger_handler, NULL);
+					 ms5611_trigger_handler, NULL, NULL);
 	if (ret < 0) {
 		dev_err(dev, "iio triggered buffer setup failed\n");
 		goto err_fini;
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 7cf6f06797e1..dc46239ab891 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -47,7 +47,7 @@ static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
 int st_press_allocate_ring(struct iio_dev *indio_dev)
 {
 	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_press_buffer_setup_ops);
+		&st_sensors_trigger_handler, &st_press_buffer_setup_ops, NULL);
 }
 
 void st_press_deallocate_ring(struct iio_dev *indio_dev)
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 2cecbe0adb3f..867bf87ef28d 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1641,7 +1641,7 @@ int zpa2326_probe(struct device *parent,
 
 	err = devm_iio_triggered_buffer_setup(parent, indio_dev, NULL,
 					      zpa2326_trigger_handler,
-					      &zpa2326_buffer_setup_ops);
+					      &zpa2326_buffer_setup_ops, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index b79ada839e01..b667740b7a74 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -423,7 +423,8 @@ static int as3935_probe(struct spi_device *spi)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      as3935_trigger_handler, NULL);
+					      as3935_trigger_handler, NULL,
+					      NULL);
 
 	if (ret) {
 		dev_err(dev, "cannot setup iio trigger\n");
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 90e76451c972..885dd9508df9 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -980,7 +980,7 @@ static int isl29501_probe(struct i2c_client *client,
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      isl29501_trigger_handler,
-					      NULL);
+					      NULL, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
 		return ret;
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index ad4b1fb2607a..de5df7882c96 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -223,7 +223,8 @@ static int mb1232_probe(struct i2c_client *client,
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-			iio_pollfunc_store_time, mb1232_trigger_handler, NULL);
+			iio_pollfunc_store_time, mb1232_trigger_handler, NULL,
+			NULL);
 	if (ret < 0) {
 		dev_err(dev, "setup of iio triggered buffer failed\n");
 		return ret;
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index c685f10b5ae4..436b07cbeb5d 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -279,7 +279,7 @@ static int lidar_probe(struct i2c_client *client,
 	data->indio_dev = indio_dev;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 lidar_trigger_handler, NULL);
+					 lidar_trigger_handler, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 70beac5c9c1d..887a2f765fac 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -490,7 +490,8 @@ static int srf08_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
-			iio_pollfunc_store_time, srf08_trigger_handler, NULL);
+			iio_pollfunc_store_time, srf08_trigger_handler, NULL,
+			NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "setup of iio triggered buffer failed\n");
 		return ret;
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 6d3f4ab8c6b2..1905c1af1ef2 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -968,7 +968,7 @@ static int sx9310_probe(struct i2c_client *client)
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      sx9310_trigger_handler,
-					      &sx9310_buffer_setup_ops);
+					      &sx9310_buffer_setup_ops, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index acb821cbad46..be9438c196d9 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -961,7 +961,7 @@ static int sx9500_probe(struct i2c_client *client,
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 sx9500_trigger_handler,
-					 &sx9500_buffer_setup_ops);
+					 &sx9500_buffer_setup_ops, NULL);
 	if (ret < 0)
 		goto out_trigger_unregister;
 
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 0297e215b61a..75101382151b 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -252,7 +252,8 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev,
 				indio_dev, NULL,
-				maxim_thermocouple_trigger_handler, NULL);
+				maxim_thermocouple_trigger_handler, NULL,
+				NULL);
 	if (ret)
 		return ret;
 
-- 
2.17.1

