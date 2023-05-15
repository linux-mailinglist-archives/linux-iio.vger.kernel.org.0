Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36102703EDA
	for <lists+linux-iio@lfdr.de>; Mon, 15 May 2023 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjEOUvI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 May 2023 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245090AbjEOUvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2023 16:51:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC17EDA
        for <linux-iio@vger.kernel.org>; Mon, 15 May 2023 13:51:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyf9j-0005tZ-GF; Mon, 15 May 2023 22:50:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyf9i-000RnV-Go; Mon, 15 May 2023 22:50:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyf9h-004nU8-Gj; Mon, 15 May 2023 22:50:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] iio: Switch i2c drivers back to use .probe()
Date:   Mon, 15 May 2023 22:50:48 +0200
Message-Id: <20230515205048.19561-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=100140; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ioHW3fKGGfBwz2eZQPWShZHPLmrGg1S6p9PnDrjyjKk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkYpsn+zOcG6MhoxmwqaHztm/8pB1w2ZYYB0Wrk garrpluge2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZGKbJwAKCRCPgPtYfRL+ ThknB/0apEm1csY4t0UjJ7HIgvGa7aD0/nw0yWA3kXZ8dpA9sxFiBY0AhOTsiVgJvSppPtx4phJ fjswHTKQU50ZcooMbVmcb/c4WKzQsd+n1AZUQIRxdpwr3eyAjppC4LXsugUO2IKB3t2GpTj7ZzZ +GuBmiBmjftzzQYSCD8G4dQPeCpj8C1A2IqF+UKmJx7BvK0vd4R02NmWsO80e/JHUXVYK06qEjR YxY1HI4uq7il581uHprh2NTu0AjQQvvPuOZTjMqkzP+cnDxrCvGYKtB9pzU/nSUcPJAwf9A2XOZ yd6HlaMkNOVaMuiR+MZ5RbqzrEy0wD/QGTOoLEAj+6UAIFwx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
back to (the new) .probe() to be able to eventually drop .probe_new() from
struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch was generated using coccinelle, but I aligned the result to
the per-file indention.

This is one patch for the whole iio subsystem. if you want it split per
driver (or directory?) for improved patch count numbers, please tell me.

Also note I didn't Cc: all the individual maintainers to not exceed the
allowed length of To: and Cc:. If this patch will be split I can extend
the audience accordingly.

This currently fits on top of 6.4-rc1 and next/master. If you apply it
somewhere else and get conflicts, feel free to just drop the files with
conflicts from this patch and apply anyhow. I'll care about the fallout
later then.

Best regards
Uwe

 drivers/iio/accel/adxl313_i2c.c                   | 2 +-
 drivers/iio/accel/adxl345_i2c.c                   | 2 +-
 drivers/iio/accel/adxl355_i2c.c                   | 2 +-
 drivers/iio/accel/adxl367_i2c.c                   | 2 +-
 drivers/iio/accel/adxl372_i2c.c                   | 2 +-
 drivers/iio/accel/bma180.c                        | 2 +-
 drivers/iio/accel/bma400_i2c.c                    | 2 +-
 drivers/iio/accel/bmc150-accel-i2c.c              | 2 +-
 drivers/iio/accel/da280.c                         | 2 +-
 drivers/iio/accel/da311.c                         | 2 +-
 drivers/iio/accel/dmard06.c                       | 2 +-
 drivers/iio/accel/dmard09.c                       | 2 +-
 drivers/iio/accel/dmard10.c                       | 2 +-
 drivers/iio/accel/fxls8962af-i2c.c                | 2 +-
 drivers/iio/accel/kionix-kx022a-i2c.c             | 2 +-
 drivers/iio/accel/kxcjk-1013.c                    | 2 +-
 drivers/iio/accel/kxsd9-i2c.c                     | 2 +-
 drivers/iio/accel/mc3230.c                        | 2 +-
 drivers/iio/accel/mma7455_i2c.c                   | 2 +-
 drivers/iio/accel/mma7660.c                       | 2 +-
 drivers/iio/accel/mma8452.c                       | 2 +-
 drivers/iio/accel/mma9551.c                       | 2 +-
 drivers/iio/accel/mma9553.c                       | 2 +-
 drivers/iio/accel/msa311.c                        | 2 +-
 drivers/iio/accel/mxc4005.c                       | 2 +-
 drivers/iio/accel/mxc6255.c                       | 2 +-
 drivers/iio/accel/st_accel_i2c.c                  | 2 +-
 drivers/iio/accel/stk8312.c                       | 2 +-
 drivers/iio/accel/stk8ba50.c                      | 2 +-
 drivers/iio/adc/ad7091r5.c                        | 2 +-
 drivers/iio/adc/ad7291.c                          | 2 +-
 drivers/iio/adc/ad799x.c                          | 2 +-
 drivers/iio/adc/ina2xx-adc.c                      | 2 +-
 drivers/iio/adc/ltc2471.c                         | 2 +-
 drivers/iio/adc/ltc2485.c                         | 2 +-
 drivers/iio/adc/ltc2497.c                         | 2 +-
 drivers/iio/adc/max1363.c                         | 2 +-
 drivers/iio/adc/max9611.c                         | 2 +-
 drivers/iio/adc/mcp3422.c                         | 2 +-
 drivers/iio/adc/nau7802.c                         | 2 +-
 drivers/iio/adc/rtq6056.c                         | 2 +-
 drivers/iio/adc/ti-adc081c.c                      | 2 +-
 drivers/iio/adc/ti-ads1015.c                      | 2 +-
 drivers/iio/adc/ti-ads1100.c                      | 2 +-
 drivers/iio/adc/ti-ads7924.c                      | 2 +-
 drivers/iio/cdc/ad7150.c                          | 2 +-
 drivers/iio/cdc/ad7746.c                          | 2 +-
 drivers/iio/chemical/ams-iaq-core.c               | 2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c           | 2 +-
 drivers/iio/chemical/atlas-sensor.c               | 2 +-
 drivers/iio/chemical/bme680_i2c.c                 | 2 +-
 drivers/iio/chemical/ccs811.c                     | 2 +-
 drivers/iio/chemical/scd30_i2c.c                  | 2 +-
 drivers/iio/chemical/scd4x.c                      | 2 +-
 drivers/iio/chemical/sgp30.c                      | 2 +-
 drivers/iio/chemical/sgp40.c                      | 2 +-
 drivers/iio/chemical/sps30_i2c.c                  | 2 +-
 drivers/iio/chemical/sunrise_co2.c                | 2 +-
 drivers/iio/chemical/vz89x.c                      | 2 +-
 drivers/iio/dac/ad5064.c                          | 2 +-
 drivers/iio/dac/ad5380.c                          | 2 +-
 drivers/iio/dac/ad5446.c                          | 2 +-
 drivers/iio/dac/ad5593r.c                         | 2 +-
 drivers/iio/dac/ad5696-i2c.c                      | 2 +-
 drivers/iio/dac/ds4424.c                          | 2 +-
 drivers/iio/dac/m62332.c                          | 2 +-
 drivers/iio/dac/max517.c                          | 2 +-
 drivers/iio/dac/max5821.c                         | 2 +-
 drivers/iio/dac/mcp4725.c                         | 2 +-
 drivers/iio/dac/ti-dac5571.c                      | 2 +-
 drivers/iio/gyro/bmg160_i2c.c                     | 2 +-
 drivers/iio/gyro/fxas21002c_i2c.c                 | 2 +-
 drivers/iio/gyro/itg3200_core.c                   | 2 +-
 drivers/iio/gyro/mpu3050-i2c.c                    | 2 +-
 drivers/iio/gyro/st_gyro_i2c.c                    | 2 +-
 drivers/iio/health/afe4404.c                      | 2 +-
 drivers/iio/health/max30100.c                     | 2 +-
 drivers/iio/health/max30102.c                     | 2 +-
 drivers/iio/humidity/am2315.c                     | 2 +-
 drivers/iio/humidity/hdc100x.c                    | 2 +-
 drivers/iio/humidity/hdc2010.c                    | 2 +-
 drivers/iio/humidity/hts221_i2c.c                 | 2 +-
 drivers/iio/humidity/htu21.c                      | 2 +-
 drivers/iio/humidity/si7005.c                     | 2 +-
 drivers/iio/humidity/si7020.c                     | 2 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c               | 2 +-
 drivers/iio/imu/bno055/bno055_i2c.c               | 2 +-
 drivers/iio/imu/fxos8700_i2c.c                    | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c         | 2 +-
 drivers/iio/imu/kmx61.c                           | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c       | 2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c       | 2 +-
 drivers/iio/light/adjd_s311.c                     | 2 +-
 drivers/iio/light/adux1020.c                      | 2 +-
 drivers/iio/light/al3010.c                        | 2 +-
 drivers/iio/light/al3320a.c                       | 2 +-
 drivers/iio/light/apds9300.c                      | 2 +-
 drivers/iio/light/apds9960.c                      | 2 +-
 drivers/iio/light/as73211.c                       | 2 +-
 drivers/iio/light/bh1750.c                        | 2 +-
 drivers/iio/light/bh1780.c                        | 2 +-
 drivers/iio/light/cm32181.c                       | 2 +-
 drivers/iio/light/cm3232.c                        | 2 +-
 drivers/iio/light/cm3323.c                        | 2 +-
 drivers/iio/light/cm36651.c                       | 2 +-
 drivers/iio/light/gp2ap002.c                      | 2 +-
 drivers/iio/light/gp2ap020a00f.c                  | 2 +-
 drivers/iio/light/isl29018.c                      | 2 +-
 drivers/iio/light/isl29028.c                      | 2 +-
 drivers/iio/light/isl29125.c                      | 2 +-
 drivers/iio/light/jsa1212.c                       | 2 +-
 drivers/iio/light/ltr501.c                        | 2 +-
 drivers/iio/light/ltrf216a.c                      | 2 +-
 drivers/iio/light/lv0104cs.c                      | 2 +-
 drivers/iio/light/max44000.c                      | 2 +-
 drivers/iio/light/max44009.c                      | 2 +-
 drivers/iio/light/noa1305.c                       | 2 +-
 drivers/iio/light/opt3001.c                       | 2 +-
 drivers/iio/light/pa12203001.c                    | 2 +-
 drivers/iio/light/rohm-bu27034.c                  | 2 +-
 drivers/iio/light/rpr0521.c                       | 2 +-
 drivers/iio/light/si1133.c                        | 2 +-
 drivers/iio/light/si1145.c                        | 2 +-
 drivers/iio/light/st_uvis25_i2c.c                 | 2 +-
 drivers/iio/light/stk3310.c                       | 2 +-
 drivers/iio/light/tcs3414.c                       | 2 +-
 drivers/iio/light/tcs3472.c                       | 2 +-
 drivers/iio/light/tsl2563.c                       | 2 +-
 drivers/iio/light/tsl2583.c                       | 2 +-
 drivers/iio/light/tsl2591.c                       | 2 +-
 drivers/iio/light/tsl2772.c                       | 2 +-
 drivers/iio/light/tsl4531.c                       | 2 +-
 drivers/iio/light/us5182d.c                       | 2 +-
 drivers/iio/light/vcnl4000.c                      | 2 +-
 drivers/iio/light/vcnl4035.c                      | 2 +-
 drivers/iio/light/veml6030.c                      | 2 +-
 drivers/iio/light/veml6070.c                      | 2 +-
 drivers/iio/light/vl6180.c                        | 2 +-
 drivers/iio/light/zopt2201.c                      | 2 +-
 drivers/iio/magnetometer/ak8974.c                 | 2 +-
 drivers/iio/magnetometer/ak8975.c                 | 2 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c        | 2 +-
 drivers/iio/magnetometer/hmc5843_i2c.c            | 2 +-
 drivers/iio/magnetometer/mag3110.c                | 2 +-
 drivers/iio/magnetometer/mmc35240.c               | 2 +-
 drivers/iio/magnetometer/rm3100-i2c.c             | 2 +-
 drivers/iio/magnetometer/st_magn_i2c.c            | 2 +-
 drivers/iio/magnetometer/tmag5273.c               | 2 +-
 drivers/iio/magnetometer/yamaha-yas530.c          | 2 +-
 drivers/iio/potentiometer/ad5110.c                | 2 +-
 drivers/iio/potentiometer/ad5272.c                | 2 +-
 drivers/iio/potentiometer/ds1803.c                | 2 +-
 drivers/iio/potentiometer/max5432.c               | 2 +-
 drivers/iio/potentiometer/mcp4018.c               | 2 +-
 drivers/iio/potentiometer/mcp4531.c               | 2 +-
 drivers/iio/potentiometer/tpl0102.c               | 2 +-
 drivers/iio/potentiostat/lmp91000.c               | 2 +-
 drivers/iio/pressure/abp060mg.c                   | 2 +-
 drivers/iio/pressure/bmp280-i2c.c                 | 2 +-
 drivers/iio/pressure/dlhl60d.c                    | 2 +-
 drivers/iio/pressure/dps310.c                     | 2 +-
 drivers/iio/pressure/hp03.c                       | 2 +-
 drivers/iio/pressure/hp206c.c                     | 2 +-
 drivers/iio/pressure/icp10100.c                   | 2 +-
 drivers/iio/pressure/mpl115_i2c.c                 | 2 +-
 drivers/iio/pressure/mpl3115.c                    | 2 +-
 drivers/iio/pressure/ms5611_i2c.c                 | 2 +-
 drivers/iio/pressure/ms5637.c                     | 2 +-
 drivers/iio/pressure/st_pressure_i2c.c            | 2 +-
 drivers/iio/pressure/t5403.c                      | 2 +-
 drivers/iio/pressure/zpa2326_i2c.c                | 2 +-
 drivers/iio/proximity/isl29501.c                  | 2 +-
 drivers/iio/proximity/mb1232.c                    | 2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 +-
 drivers/iio/proximity/rfd77402.c                  | 2 +-
 drivers/iio/proximity/srf08.c                     | 2 +-
 drivers/iio/proximity/sx9310.c                    | 2 +-
 drivers/iio/proximity/sx9324.c                    | 2 +-
 drivers/iio/proximity/sx9360.c                    | 2 +-
 drivers/iio/proximity/sx9500.c                    | 2 +-
 drivers/iio/proximity/vcnl3020.c                  | 2 +-
 drivers/iio/proximity/vl53l0x-i2c.c               | 2 +-
 drivers/iio/temperature/max30208.c                | 2 +-
 drivers/iio/temperature/mlx90614.c                | 2 +-
 drivers/iio/temperature/mlx90632.c                | 2 +-
 drivers/iio/temperature/tmp006.c                  | 2 +-
 drivers/iio/temperature/tmp007.c                  | 2 +-
 drivers/iio/temperature/tmp117.c                  | 2 +-
 drivers/iio/temperature/tsys01.c                  | 2 +-
 drivers/iio/temperature/tsys02d.c                 | 2 +-
 191 files changed, 191 insertions(+), 191 deletions(-)

diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index 99cc7fc29488..524327ea3663 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -85,7 +85,7 @@ static struct i2c_driver adxl313_i2c_driver = {
 		.name	= "adxl313_i2c",
 		.of_match_table = adxl313_of_match,
 	},
-	.probe_new	= adxl313_i2c_probe,
+	.probe		= adxl313_i2c_probe,
 	.id_table	= adxl313_i2c_id,
 };
 
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 098cd83f95b2..e47d12f19602 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -56,7 +56,7 @@ static struct i2c_driver adxl345_i2c_driver = {
 		.of_match_table = adxl345_of_match,
 		.acpi_match_table = adxl345_acpi_match,
 	},
-	.probe_new	= adxl345_i2c_probe,
+	.probe		= adxl345_i2c_probe,
 	.id_table	= adxl345_i2c_id,
 };
 module_i2c_driver(adxl345_i2c_driver);
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index 6cde5ccac06b..d5beea61479d 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -68,7 +68,7 @@ static struct i2c_driver adxl355_i2c_driver = {
 		.name	= "adxl355_i2c",
 		.of_match_table = adxl355_of_match,
 	},
-	.probe_new	= adxl355_i2c_probe,
+	.probe		= adxl355_i2c_probe,
 	.id_table	= adxl355_i2c_id,
 };
 module_i2c_driver(adxl355_i2c_driver);
diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index 070aad724abd..b595fe94f3a3 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -77,7 +77,7 @@ static struct i2c_driver adxl367_i2c_driver = {
 		.name = "adxl367_i2c",
 		.of_match_table = adxl367_of_match,
 	},
-	.probe_new = adxl367_i2c_probe,
+	.probe = adxl367_i2c_probe,
 	.id_table = adxl367_i2c_id,
 };
 
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index e5f310ea65ff..d0690417fd36 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -58,7 +58,7 @@ static struct i2c_driver adxl372_i2c_driver = {
 		.name = "adxl372_i2c",
 		.of_match_table = adxl372_of_match,
 	},
-	.probe_new = adxl372_i2c_probe,
+	.probe = adxl372_i2c_probe,
 	.id_table = adxl372_i2c_id,
 };
 
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index eb697eeb4301..e8ab0d249351 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1134,7 +1134,7 @@ static struct i2c_driver bma180_driver = {
 		.pm	= pm_sleep_ptr(&bma180_pm_ops),
 		.of_match_table = bma180_of_match,
 	},
-	.probe_new	= bma180_probe,
+	.probe		= bma180_probe,
 	.remove		= bma180_remove,
 	.id_table	= bma180_ids,
 };
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index 688b06dae669..adf4e3fd2e1d 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -44,7 +44,7 @@ static struct i2c_driver bma400_i2c_driver = {
 		.name = "bma400",
 		.of_match_table = bma400_of_i2c_match,
 	},
-	.probe_new = bma400_i2c_probe,
+	.probe = bma400_i2c_probe,
 	.id_table = bma400_i2c_ids,
 };
 
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 509cab2bd694..ee1ba134ad42 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -269,7 +269,7 @@ static struct i2c_driver bmc150_accel_driver = {
 		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
 		.pm	= &bmc150_accel_pm_ops,
 	},
-	.probe_new	= bmc150_accel_probe,
+	.probe		= bmc150_accel_probe,
 	.remove		= bmc150_accel_remove,
 	.id_table	= bmc150_accel_id,
 };
diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 38a7d811610e..2f27a5ded94c 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -184,7 +184,7 @@ static struct i2c_driver da280_driver = {
 		.acpi_match_table = ACPI_PTR(da280_acpi_match),
 		.pm = pm_sleep_ptr(&da280_pm_ops),
 	},
-	.probe_new	= da280_probe,
+	.probe		= da280_probe,
 	.id_table	= da280_i2c_id,
 };
 
diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 080335fa2ad6..8f919920ced5 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -278,7 +278,7 @@ static struct i2c_driver da311_driver = {
 		.name = "da311",
 		.pm = pm_sleep_ptr(&da311_pm_ops),
 	},
-	.probe_new	= da311_probe,
+	.probe		= da311_probe,
 	.id_table	= da311_i2c_id,
 };
 
diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index 7390509aaac0..2e719d60fff8 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -217,7 +217,7 @@ static const struct of_device_id dmard06_of_match[] = {
 MODULE_DEVICE_TABLE(of, dmard06_of_match);
 
 static struct i2c_driver dmard06_driver = {
-	.probe_new = dmard06_probe,
+	.probe = dmard06_probe,
 	.id_table = dmard06_id,
 	.driver = {
 		.name = DMARD06_DRV_NAME,
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index 4b7a537f617d..fa98623de579 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -135,7 +135,7 @@ static struct i2c_driver dmard09_driver = {
 	.driver = {
 		.name = DMARD09_DRV_NAME
 	},
-	.probe_new = dmard09_probe,
+	.probe = dmard09_probe,
 	.id_table = dmard09_id,
 };
 
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 07e68aed8a13..7745b6ffd1ad 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -241,7 +241,7 @@ static struct i2c_driver dmard10_driver = {
 		.name = "dmard10",
 		.pm = pm_sleep_ptr(&dmard10_pm_ops),
 	},
-	.probe_new	= dmard10_probe,
+	.probe		= dmard10_probe,
 	.id_table	= dmard10_i2c_id,
 };
 
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 22640eaebac7..160124673308 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -47,7 +47,7 @@ static struct i2c_driver fxls8962af_driver = {
 		   .of_match_table = fxls8962af_of_match,
 		   .pm = pm_ptr(&fxls8962af_pm_ops),
 		   },
-	.probe_new = fxls8962af_probe,
+	.probe = fxls8962af_probe,
 	.id_table = fxls8962af_id,
 };
 module_i2c_driver(fxls8962af_driver);
diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..d9aea36c6e7d 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -41,7 +41,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.name  = "kx022a-i2c",
 		.of_match_table = kx022a_of_match,
 	  },
-	.probe_new    = kx022a_i2c_probe,
+	.probe        = kx022a_i2c_probe,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 98da4bda22df..894709286b0c 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1732,7 +1732,7 @@ static struct i2c_driver kxcjk1013_driver = {
 		.of_match_table = kxcjk1013_of_match,
 		.pm	= &kxcjk1013_pm_ops,
 	},
-	.probe_new	= kxcjk1013_probe,
+	.probe		= kxcjk1013_probe,
 	.remove		= kxcjk1013_remove,
 	.id_table	= kxcjk1013_id,
 };
diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 6b3683ddce36..3bc9ee1f9db3 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -54,7 +54,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
 		.of_match_table = kxsd9_of_match,
 		.pm = pm_ptr(&kxsd9_dev_pm_ops),
 	},
-	.probe_new	= kxsd9_i2c_probe,
+	.probe		= kxsd9_i2c_probe,
 	.remove		= kxsd9_i2c_remove,
 	.id_table	= kxsd9_i2c_id,
 };
diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index efc21871de42..6b87c2c9945c 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -190,7 +190,7 @@ static struct i2c_driver mc3230_driver = {
 		.name = "mc3230",
 		.pm = pm_sleep_ptr(&mc3230_pm_ops),
 	},
-	.probe_new	= mc3230_probe,
+	.probe		= mc3230_probe,
 	.remove		= mc3230_remove,
 	.id_table	= mc3230_i2c_id,
 };
diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
index a3864dbe2761..14f7850a22f0 100644
--- a/drivers/iio/accel/mma7455_i2c.c
+++ b/drivers/iio/accel/mma7455_i2c.c
@@ -46,7 +46,7 @@ static const struct of_device_id mma7455_of_match[] = {
 MODULE_DEVICE_TABLE(of, mma7455_of_match);
 
 static struct i2c_driver mma7455_i2c_driver = {
-	.probe_new = mma7455_i2c_probe,
+	.probe = mma7455_i2c_probe,
 	.remove = mma7455_i2c_remove,
 	.id_table = mma7455_i2c_ids,
 	.driver = {
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index b279ca4dcdc0..260cbceaa151 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -266,7 +266,7 @@ static struct i2c_driver mma7660_driver = {
 		.of_match_table = mma7660_of_match,
 		.acpi_match_table = mma7660_acpi_id,
 	},
-	.probe_new	= mma7660_probe,
+	.probe		= mma7660_probe,
 	.remove		= mma7660_remove,
 	.id_table	= mma7660_i2c_id,
 };
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index ea14e3aaa30a..6e7399e72221 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1846,7 +1846,7 @@ static struct i2c_driver mma8452_driver = {
 		.of_match_table = mma8452_dt_ids,
 		.pm	= &mma8452_pm_ops,
 	},
-	.probe_new = mma8452_probe,
+	.probe = mma8452_probe,
 	.remove = mma8452_remove,
 	.id_table = mma8452_id,
 };
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index aa4f5842859e..d823f2edc6d4 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -607,7 +607,7 @@ static struct i2c_driver mma9551_driver = {
 		   .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
 		   .pm = pm_ptr(&mma9551_pm_ops),
 		   },
-	.probe_new = mma9551_probe,
+	.probe = mma9551_probe,
 	.remove = mma9551_remove,
 	.id_table = mma9551_id,
 };
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 0af578ef9d3d..d01aba4aecba 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1246,7 +1246,7 @@ static struct i2c_driver mma9553_driver = {
 		   .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
 		   .pm = pm_ptr(&mma9553_pm_ops),
 		   },
-	.probe_new = mma9553_probe,
+	.probe = mma9553_probe,
 	.remove = mma9553_remove,
 	.id_table = mma9553_id,
 };
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 6690fa37da8f..6ddcc3c2f840 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -1294,7 +1294,7 @@ static struct i2c_driver msa311_driver = {
 		.of_match_table = msa311_of_match,
 		.pm = pm_ptr(&msa311_pm_ops),
 	},
-	.probe_new	= msa311_probe,
+	.probe		= msa311_probe,
 	.id_table	= msa311_i2c_id,
 };
 module_i2c_driver(msa311_driver);
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index b146fc82738f..75d142bc14b4 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -488,7 +488,7 @@ static struct i2c_driver mxc4005_driver = {
 		.name = MXC4005_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
 	},
-	.probe_new	= mxc4005_probe,
+	.probe		= mxc4005_probe,
 	.id_table	= mxc4005_id,
 };
 
diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index aa2e660545f8..33c2253561e6 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -183,7 +183,7 @@ static struct i2c_driver mxc6255_driver = {
 		.name = MXC6255_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(mxc6255_acpi_match),
 	},
-	.probe_new	= mxc6255_probe,
+	.probe		= mxc6255_probe,
 	.id_table	= mxc6255_id,
 };
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index fb9e2d6f4210..71ee861b2980 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -206,7 +206,7 @@ static struct i2c_driver st_accel_driver = {
 		.of_match_table = st_accel_of_match,
 		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
-	.probe_new = st_accel_i2c_probe,
+	.probe = st_accel_i2c_probe,
 	.id_table = st_accel_id_table,
 };
 module_i2c_driver(st_accel_driver);
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 68f680db7505..ef0ae7672253 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -644,7 +644,7 @@ static struct i2c_driver stk8312_driver = {
 		.name = STK8312_DRIVER_NAME,
 		.pm = pm_sleep_ptr(&stk8312_pm_ops),
 	},
-	.probe_new =        stk8312_probe,
+	.probe =        stk8312_probe,
 	.remove =           stk8312_remove,
 	.id_table =         stk8312_i2c_id,
 };
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 44f6e0fbdfcc..3415ac1b4495 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -543,7 +543,7 @@ static struct i2c_driver stk8ba50_driver = {
 		.pm = pm_sleep_ptr(&stk8ba50_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk8ba50_acpi_id),
 	},
-	.probe_new =        stk8ba50_probe,
+	.probe =        stk8ba50_probe,
 	.remove =           stk8ba50_remove,
 	.id_table =         stk8ba50_i2c_id,
 };
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 7d6709da1005..2f048527b7b7 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -103,7 +103,7 @@ static struct i2c_driver ad7091r5_driver = {
 		.name = "ad7091r5",
 		.of_match_table = ad7091r5_dt_ids,
 	},
-	.probe_new = ad7091r5_i2c_probe,
+	.probe = ad7091r5_i2c_probe,
 	.id_table = ad7091r5_i2c_ids,
 };
 module_i2c_driver(ad7091r5_driver);
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index f9ee189925de..14d02b085d3b 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -553,7 +553,7 @@ static struct i2c_driver ad7291_driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = ad7291_of_match,
 	},
-	.probe_new = ad7291_probe,
+	.probe = ad7291_probe,
 	.id_table = ad7291_id,
 };
 module_i2c_driver(ad7291_driver);
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 8f0a3a35e727..b757cc45c4de 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -968,7 +968,7 @@ static struct i2c_driver ad799x_driver = {
 		.name = "ad799x",
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
-	.probe_new = ad799x_probe,
+	.probe = ad799x_probe,
 	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 38d9d7b2313e..213526c1592f 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1090,7 +1090,7 @@ static struct i2c_driver ina2xx_driver = {
 		   .name = KBUILD_MODNAME,
 		   .of_match_table = ina2xx_of_match,
 	},
-	.probe_new = ina2xx_probe,
+	.probe = ina2xx_probe,
 	.remove = ina2xx_remove,
 	.id_table = ina2xx_id,
 };
diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index eeb2945829eb..97c417c3a4eb 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -146,7 +146,7 @@ static struct i2c_driver ltc2471_i2c_driver = {
 	.driver = {
 		.name = "ltc2471",
 	},
-	.probe_new = ltc2471_i2c_probe,
+	.probe = ltc2471_i2c_probe,
 	.id_table = ltc2471_i2c_id,
 };
 
diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
index 6a23427344ec..859e4314cfa2 100644
--- a/drivers/iio/adc/ltc2485.c
+++ b/drivers/iio/adc/ltc2485.c
@@ -133,7 +133,7 @@ static struct i2c_driver ltc2485_driver = {
 	.driver = {
 		.name = "ltc2485",
 	},
-	.probe_new = ltc2485_probe,
+	.probe = ltc2485_probe,
 	.id_table = ltc2485_id,
 };
 module_i2c_driver(ltc2485_driver);
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index ec198c6f13d6..5bdd40729611 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -163,7 +163,7 @@ static struct i2c_driver ltc2497_driver = {
 		.name = "ltc2497",
 		.of_match_table = ltc2497_of_match,
 	},
-	.probe_new = ltc2497_probe,
+	.probe = ltc2497_probe,
 	.remove = ltc2497_remove,
 	.id_table = ltc2497_id,
 };
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 73b783b430d7..b31581616ce3 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1718,7 +1718,7 @@ static struct i2c_driver max1363_driver = {
 		.name = "max1363",
 		.of_match_table = max1363_of_match,
 	},
-	.probe_new = max1363_probe,
+	.probe = max1363_probe,
 	.id_table = max1363_id,
 };
 module_i2c_driver(max1363_driver);
diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index cb7f4785423a..76e517b7b1e4 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -556,7 +556,7 @@ static struct i2c_driver max9611_driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = max9611_of_table,
 	},
-	.probe_new = max9611_probe,
+	.probe = max9611_probe,
 };
 module_i2c_driver(max9611_driver);
 
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index ada844c3f7ec..0778a8fb6866 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -417,7 +417,7 @@ static struct i2c_driver mcp3422_driver = {
 		.name = "mcp3422",
 		.of_match_table = mcp3422_of_match,
 	},
-	.probe_new = mcp3422_probe,
+	.probe = mcp3422_probe,
 	.id_table = mcp3422_id,
 };
 module_i2c_driver(mcp3422_driver);
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index c1261ecd400c..d9e1696df7ae 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -544,7 +544,7 @@ static const struct of_device_id nau7802_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, nau7802_dt_ids);
 
 static struct i2c_driver nau7802_driver = {
-	.probe_new = nau7802_probe,
+	.probe = nau7802_probe,
 	.id_table = nau7802_i2c_id,
 	.driver = {
 		   .name = "nau7802",
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index c1b2e8dc9a26..ad4cea6839b2 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -652,7 +652,7 @@ static struct i2c_driver rtq6056_driver = {
 		.of_match_table = rtq6056_device_match,
 		.pm = pm_ptr(&rtq6056_pm_ops),
 	},
-	.probe_new = rtq6056_probe,
+	.probe = rtq6056_probe,
 };
 module_i2c_driver(rtq6056_driver);
 
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index c663dc59d459..50c450e7a55f 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -235,7 +235,7 @@ static struct i2c_driver adc081c_driver = {
 		.of_match_table = adc081c_of_match,
 		.acpi_match_table = adc081c_acpi_match,
 	},
-	.probe_new = adc081c_probe,
+	.probe = adc081c_probe,
 	.id_table = adc081c_id,
 };
 module_i2c_driver(adc081c_driver);
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 56af5e148802..075c75a87544 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1195,7 +1195,7 @@ static struct i2c_driver ads1015_driver = {
 		.of_match_table = ads1015_of_match,
 		.pm = &ads1015_pm_ops,
 	},
-	.probe_new	= ads1015_probe,
+	.probe		= ads1015_probe,
 	.remove		= ads1015_remove,
 	.id_table	= ads1015_id,
 };
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 6b5aebb82455..1e46f07a9ca6 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -434,7 +434,7 @@ static struct i2c_driver ads1100_driver = {
 		   .of_match_table = ads1100_of_match,
 		   .pm = pm_ptr(&ads1100_pm_ops),
 	},
-	.probe_new = ads1100_probe,
+	.probe = ads1100_probe,
 	.id_table = ads1100_id,
 };
 
diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index b02abb026966..afdbd04778a8 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -463,7 +463,7 @@ static struct i2c_driver ads7924_driver = {
 		.name = "ads7924",
 		.of_match_table = ads7924_of_match,
 	},
-	.probe_new	= ads7924_probe,
+	.probe		= ads7924_probe,
 	.id_table	= ads7924_id,
 };
 
diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 79aeb0aaea67..d656d2f12755 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -647,7 +647,7 @@ static struct i2c_driver ad7150_driver = {
 		.name = "ad7150",
 		.of_match_table = ad7150_of_match,
 	},
-	.probe_new = ad7150_probe,
+	.probe = ad7150_probe,
 	.id_table = ad7150_id,
 };
 module_i2c_driver(ad7150_driver);
diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index a1db5469f2d1..d11bc3496dda 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -809,7 +809,7 @@ static struct i2c_driver ad7746_driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = ad7746_of_match,
 	},
-	.probe_new = ad7746_probe,
+	.probe = ad7746_probe,
 	.id_table = ad7746_id,
 };
 module_i2c_driver(ad7746_driver);
diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 0a0fbcdd4469..164facac5db6 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -179,7 +179,7 @@ static struct i2c_driver ams_iaqcore_driver = {
 		.name	= "ams-iaq-core",
 		.of_match_table = ams_iaqcore_dt_ids,
 	},
-	.probe_new = ams_iaqcore_probe,
+	.probe = ams_iaqcore_probe,
 	.id_table = ams_iaqcore_id,
 };
 module_i2c_driver(ams_iaqcore_driver);
diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 307c3488f4bd..8fc926a2d33b 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -238,7 +238,7 @@ static struct i2c_driver atlas_ezo_driver = {
 		.name	= ATLAS_EZO_DRV_NAME,
 		.of_match_table	= atlas_ezo_dt_ids,
 	},
-	.probe_new	= atlas_ezo_probe,
+	.probe		= atlas_ezo_probe,
 	.id_table	= atlas_ezo_id,
 };
 module_i2c_driver(atlas_ezo_driver);
diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 024657bc59e1..fb15bb216019 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -767,7 +767,7 @@ static struct i2c_driver atlas_driver = {
 		.of_match_table	= atlas_dt_ids,
 		.pm	= pm_ptr(&atlas_pm_ops),
 	},
-	.probe_new	= atlas_probe,
+	.probe		= atlas_probe,
 	.remove		= atlas_remove,
 	.id_table	= atlas_id,
 };
diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 61b12079858d..1c7076cf91ca 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -52,7 +52,7 @@ static struct i2c_driver bme680_i2c_driver = {
 		.name			= "bme680_i2c",
 		.of_match_table		= bme680_of_i2c_match,
 	},
-	.probe_new = bme680_i2c_probe,
+	.probe = bme680_i2c_probe,
 	.id_table = bme680_i2c_id,
 };
 module_i2c_driver(bme680_i2c_driver);
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 6ead80c08924..87741f155c32 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -567,7 +567,7 @@ static struct i2c_driver ccs811_driver = {
 		.name = "ccs811",
 		.of_match_table = ccs811_dt_ids,
 	},
-	.probe_new = ccs811_probe,
+	.probe = ccs811_probe,
 	.remove = ccs811_remove,
 	.id_table = ccs811_id,
 };
diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index bae479a4721f..bd3b01ded246 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -130,7 +130,7 @@ static struct i2c_driver scd30_i2c_driver = {
 		.of_match_table = scd30_i2c_of_match,
 		.pm = pm_sleep_ptr(&scd30_pm_ops),
 	},
-	.probe_new = scd30_i2c_probe,
+	.probe = scd30_i2c_probe,
 };
 module_i2c_driver(scd30_i2c_driver);
 
diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index f7ed9455b3c8..a4f22d926400 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -690,7 +690,7 @@ static struct i2c_driver scd4x_i2c_driver = {
 		.of_match_table = scd4x_dt_ids,
 		.pm = pm_sleep_ptr(&scd4x_pm_ops),
 	},
-	.probe_new = scd4x_probe,
+	.probe = scd4x_probe,
 };
 module_i2c_driver(scd4x_i2c_driver);
 
diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 9d0c68485b63..b509cff9ce37 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -575,7 +575,7 @@ static struct i2c_driver sgp_driver = {
 		.name = "sgp30",
 		.of_match_table = sgp_dt_ids,
 	},
-	.probe_new = sgp_probe,
+	.probe = sgp_probe,
 	.remove = sgp_remove,
 	.id_table = sgp_id,
 };
diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index c0ea01300908..7f0de14a1956 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -368,7 +368,7 @@ static struct i2c_driver sgp40_driver = {
 		.name = "sgp40",
 		.of_match_table = sgp40_dt_ids,
 	},
-	.probe_new = sgp40_probe,
+	.probe = sgp40_probe,
 	.id_table = sgp40_id,
 };
 module_i2c_driver(sgp40_driver);
diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index 0cb5d9b65d62..5c31299813ec 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -249,7 +249,7 @@ static struct i2c_driver sps30_i2c_driver = {
 		.of_match_table = sps30_i2c_of_match,
 	},
 	.id_table = sps30_i2c_id,
-	.probe_new = sps30_i2c_probe,
+	.probe = sps30_i2c_probe,
 };
 module_i2c_driver(sps30_i2c_driver);
 
diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
index 8440dc0c77cf..cdb8696a4e81 100644
--- a/drivers/iio/chemical/sunrise_co2.c
+++ b/drivers/iio/chemical/sunrise_co2.c
@@ -528,7 +528,7 @@ static struct i2c_driver sunrise_driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = sunrise_of_match,
 	},
-	.probe_new = sunrise_probe,
+	.probe = sunrise_probe,
 };
 module_i2c_driver(sunrise_driver);
 
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index d4604f7ccd1e..13555f4f401a 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -402,7 +402,7 @@ static struct i2c_driver vz89x_driver = {
 		.name	= "vz89x",
 		.of_match_table = vz89x_dt_ids,
 	},
-	.probe_new = vz89x_probe,
+	.probe = vz89x_probe,
 	.id_table = vz89x_id,
 };
 module_i2c_driver(vz89x_driver);
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index f01249c1ba93..7712dc6be608 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -1056,7 +1056,7 @@ static struct i2c_driver ad5064_i2c_driver = {
 	.driver = {
 		   .name = "ad5064",
 	},
-	.probe_new = ad5064_i2c_probe,
+	.probe = ad5064_i2c_probe,
 	.id_table = ad5064_i2c_ids,
 };
 
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 64b4519f8f5e..2e3e33f92bc0 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -589,7 +589,7 @@ static struct i2c_driver ad5380_i2c_driver = {
 	.driver = {
 		   .name = "ad5380",
 	},
-	.probe_new = ad5380_i2c_probe,
+	.probe = ad5380_i2c_probe,
 	.remove = ad5380_i2c_remove,
 	.id_table = ad5380_i2c_ids,
 };
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index aa3130b33456..8103d2cd13f6 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -595,7 +595,7 @@ static struct i2c_driver ad5446_i2c_driver = {
 	.driver = {
 		   .name = "ad5446",
 	},
-	.probe_new = ad5446_i2c_probe,
+	.probe = ad5446_i2c_probe,
 	.remove = ad5446_i2c_remove,
 	.id_table = ad5446_i2c_ids,
 };
diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index d311567ab324..fae5e5a0e72f 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -138,7 +138,7 @@ static struct i2c_driver ad5593r_driver = {
 		.of_match_table = ad5593r_of_match,
 		.acpi_match_table = ad5593r_acpi_match,
 	},
-	.probe_new = ad5593r_i2c_probe,
+	.probe = ad5593r_i2c_probe,
 	.remove = ad5593r_i2c_remove,
 	.id_table = ad5593r_i2c_ids,
 };
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 8a95f0278018..81541f755a3e 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -115,7 +115,7 @@ static struct i2c_driver ad5686_i2c_driver = {
 		.name = "ad5696",
 		.of_match_table = ad5686_of_match,
 	},
-	.probe_new = ad5686_i2c_probe,
+	.probe = ad5686_i2c_probe,
 	.remove = ad5686_i2c_remove,
 	.id_table = ad5686_i2c_id,
 };
diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index a16a6a934d9d..e89e4c054653 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -312,7 +312,7 @@ static struct i2c_driver ds4424_driver = {
 		.of_match_table = ds4424_of_match,
 		.pm     = pm_sleep_ptr(&ds4424_pm_ops),
 	},
-	.probe_new	= ds4424_probe,
+	.probe		= ds4424_probe,
 	.remove		= ds4424_remove,
 	.id_table	= ds4424_id,
 };
diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index b692459b0f23..ae53baccec91 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -238,7 +238,7 @@ static struct i2c_driver m62332_driver = {
 		.name	= "m62332",
 		.pm	= pm_sleep_ptr(&m62332_pm_ops),
 	},
-	.probe_new	= m62332_probe,
+	.probe		= m62332_probe,
 	.remove		= m62332_remove,
 	.id_table	= m62332_id,
 };
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 25967c39365d..685980184d3c 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -203,7 +203,7 @@ static struct i2c_driver max517_driver = {
 		.name	= MAX517_DRV_NAME,
 		.pm	= pm_sleep_ptr(&max517_pm_ops),
 	},
-	.probe_new	= max517_probe,
+	.probe		= max517_probe,
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 23da345b9250..18ba3eaaad75 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -377,7 +377,7 @@ static struct i2c_driver max5821_driver = {
 		.of_match_table = max5821_of_match,
 		.pm     = pm_sleep_ptr(&max5821_pm_ops),
 	},
-	.probe_new	= max5821_probe,
+	.probe		= max5821_probe,
 	.id_table	= max5821_id,
 };
 module_i2c_driver(max5821_driver);
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 46bf758760f8..6ddd3f7fc3a5 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -524,7 +524,7 @@ static struct i2c_driver mcp4725_driver = {
 		.of_match_table = mcp4725_of_match,
 		.pm	= pm_sleep_ptr(&mcp4725_pm_ops),
 	},
-	.probe_new	= mcp4725_probe,
+	.probe		= mcp4725_probe,
 	.remove		= mcp4725_remove,
 	.id_table	= mcp4725_id,
 };
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 40191947fea3..bab11b9adc25 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -426,7 +426,7 @@ static struct i2c_driver dac5571_driver = {
 		   .name = "ti-dac5571",
 		   .of_match_table = dac5571_of_id,
 	},
-	.probe_new = dac5571_probe,
+	.probe = dac5571_probe,
 	.remove   = dac5571_remove,
 	.id_table = dac5571_id,
 };
diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 2b019ee5b2eb..2f9675596138 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -70,7 +70,7 @@ static struct i2c_driver bmg160_i2c_driver = {
 		.of_match_table = bmg160_of_match,
 		.pm	= &bmg160_pm_ops,
 	},
-	.probe_new	= bmg160_i2c_probe,
+	.probe		= bmg160_i2c_probe,
 	.remove		= bmg160_i2c_remove,
 	.id_table	= bmg160_i2c_id,
 };
diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
index 9e2d0f34a672..ee7f21b718e2 100644
--- a/drivers/iio/gyro/fxas21002c_i2c.c
+++ b/drivers/iio/gyro/fxas21002c_i2c.c
@@ -56,7 +56,7 @@ static struct i2c_driver fxas21002c_i2c_driver = {
 		.pm = pm_ptr(&fxas21002c_pm_ops),
 		.of_match_table = fxas21002c_i2c_of_match,
 	},
-	.probe_new	= fxas21002c_i2c_probe,
+	.probe		= fxas21002c_i2c_probe,
 	.remove		= fxas21002c_i2c_remove,
 	.id_table	= fxas21002c_i2c_id,
 };
diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index ceacd863d3ea..53fb92f0ac7e 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -405,7 +405,7 @@ static struct i2c_driver itg3200_driver = {
 		.pm	= pm_sleep_ptr(&itg3200_pm_ops),
 	},
 	.id_table	= itg3200_id,
-	.probe_new	= itg3200_probe,
+	.probe		= itg3200_probe,
 	.remove		= itg3200_remove,
 };
 
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index 2116798226bf..52b6feed2637 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -108,7 +108,7 @@ static const struct of_device_id mpu3050_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, mpu3050_i2c_of_match);
 
 static struct i2c_driver mpu3050_i2c_driver = {
-	.probe_new = mpu3050_i2c_probe,
+	.probe = mpu3050_i2c_probe,
 	.remove = mpu3050_i2c_remove,
 	.id_table = mpu3050_i2c_id,
 	.driver = {
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 797a1c6a0402..5a10a3556ab0 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -111,7 +111,7 @@ static struct i2c_driver st_gyro_driver = {
 		.name = "st-gyro-i2c",
 		.of_match_table = st_gyro_of_match,
 	},
-	.probe_new = st_gyro_i2c_probe,
+	.probe = st_gyro_i2c_probe,
 	.id_table = st_gyro_id_table,
 };
 module_i2c_driver(st_gyro_driver);
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 21a6378b7052..ede1e8201311 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -609,7 +609,7 @@ static struct i2c_driver afe4404_i2c_driver = {
 		.of_match_table = afe4404_of_match,
 		.pm = pm_sleep_ptr(&afe4404_pm_ops),
 	},
-	.probe_new = afe4404_probe,
+	.probe = afe4404_probe,
 	.remove = afe4404_remove,
 	.id_table = afe4404_ids,
 };
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index a80fa9852c22..6236b4d96137 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -499,7 +499,7 @@ static struct i2c_driver max30100_driver = {
 		.name	= MAX30100_DRV_NAME,
 		.of_match_table	= max30100_dt_ids,
 	},
-	.probe_new	= max30100_probe,
+	.probe		= max30100_probe,
 	.remove		= max30100_remove,
 	.id_table	= max30100_id,
 };
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 7edcf9e05687..37e619827e8a 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -631,7 +631,7 @@ static struct i2c_driver max30102_driver = {
 		.name	= MAX30102_DRV_NAME,
 		.of_match_table	= max30102_dt_ids,
 	},
-	.probe_new	= max30102_probe,
+	.probe		= max30102_probe,
 	.remove		= max30102_remove,
 	.id_table	= max30102_id,
 };
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index f246516bd45e..37a35d1153d5 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -262,7 +262,7 @@ static struct i2c_driver am2315_driver = {
 	.driver = {
 		.name = "am2315",
 	},
-	.probe_new =        am2315_probe,
+	.probe =        am2315_probe,
 	.id_table =         am2315_i2c_id,
 };
 
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 49a950d739e4..202014da2785 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -428,7 +428,7 @@ static struct i2c_driver hdc100x_driver = {
 		.of_match_table = hdc100x_dt_ids,
 		.acpi_match_table = hdc100x_acpi_match,
 	},
-	.probe_new = hdc100x_probe,
+	.probe = hdc100x_probe,
 	.id_table = hdc100x_id,
 };
 module_i2c_driver(hdc100x_driver);
diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc2010.c
index c8fddd612e06..f5867659e00f 100644
--- a/drivers/iio/humidity/hdc2010.c
+++ b/drivers/iio/humidity/hdc2010.c
@@ -338,7 +338,7 @@ static struct i2c_driver hdc2010_driver = {
 		.name	= "hdc2010",
 		.of_match_table = hdc2010_dt_ids,
 	},
-	.probe_new = hdc2010_probe,
+	.probe = hdc2010_probe,
 	.remove = hdc2010_remove,
 	.id_table = hdc2010_id,
 };
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index d81869423cf0..30f2068ea156 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -65,7 +65,7 @@ static struct i2c_driver hts221_driver = {
 		.of_match_table = hts221_i2c_of_match,
 		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
 	},
-	.probe_new = hts221_i2c_probe,
+	.probe = hts221_i2c_probe,
 	.id_table = hts221_i2c_id_table,
 };
 module_i2c_driver(hts221_driver);
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 8411a9f3e828..39e886075299 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -244,7 +244,7 @@ static const struct of_device_id htu21_of_match[] = {
 MODULE_DEVICE_TABLE(of, htu21_of_match);
 
 static struct i2c_driver htu21_driver = {
-	.probe_new = htu21_probe,
+	.probe = htu21_probe,
 	.id_table = htu21_id,
 	.driver = {
 		   .name = "htu21",
diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
index fa1faf168c8d..ebfb79bc9edc 100644
--- a/drivers/iio/humidity/si7005.c
+++ b/drivers/iio/humidity/si7005.c
@@ -173,7 +173,7 @@ static struct i2c_driver si7005_driver = {
 	.driver = {
 		.name	= "si7005",
 	},
-	.probe_new = si7005_probe,
+	.probe = si7005_probe,
 	.id_table = si7005_id,
 };
 module_i2c_driver(si7005_driver);
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index 3e50592e8e68..fb1006649328 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -155,7 +155,7 @@ static struct i2c_driver si7020_driver = {
 		.name = "si7020",
 		.of_match_table = si7020_dt_ids,
 	},
-	.probe_new	= si7020_probe,
+	.probe		= si7020_probe,
 	.id_table	= si7020_id,
 };
 
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 2ca907d396a0..81652c08e644 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -60,7 +60,7 @@ static struct i2c_driver bmi160_i2c_driver = {
 		.acpi_match_table	= bmi160_acpi_match,
 		.of_match_table		= bmi160_of_match,
 	},
-	.probe_new	= bmi160_i2c_probe,
+	.probe		= bmi160_i2c_probe,
 	.id_table	= bmi160_i2c_id,
 };
 module_i2c_driver(bmi160_i2c_driver);
diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
index c1bbc0fe34f9..6ecd750c6b76 100644
--- a/drivers/iio/imu/bno055/bno055_i2c.c
+++ b/drivers/iio/imu/bno055/bno055_i2c.c
@@ -46,7 +46,7 @@ static struct i2c_driver bno055_driver = {
 		.name = "bno055-i2c",
 		.of_match_table = bno055_i2c_of_match,
 	},
-	.probe_new = bno055_i2c_probe,
+	.probe = bno055_i2c_probe,
 	.id_table = bno055_i2c_id,
 };
 module_i2c_driver(bno055_driver);
diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
index a74a15fda8cb..2ace306d0f9a 100644
--- a/drivers/iio/imu/fxos8700_i2c.c
+++ b/drivers/iio/imu/fxos8700_i2c.c
@@ -60,7 +60,7 @@ static struct i2c_driver fxos8700_i2c_driver = {
 		.acpi_match_table       = ACPI_PTR(fxos8700_acpi_match),
 		.of_match_table         = fxos8700_of_match,
 	},
-	.probe_new      = fxos8700_i2c_probe,
+	.probe          = fxos8700_i2c_probe,
 	.id_table       = fxos8700_i2c_id,
 };
 module_i2c_driver(fxos8700_i2c_driver);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index eb2681ad375f..1af559403ba6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -98,7 +98,7 @@ static struct i2c_driver inv_icm42600_driver = {
 		.of_match_table = inv_icm42600_of_matches,
 		.pm = pm_ptr(&inv_icm42600_pm_ops),
 	},
-	.probe_new = inv_icm42600_probe,
+	.probe = inv_icm42600_probe,
 };
 module_i2c_driver(inv_icm42600_driver);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 2f2da4cb7321..bafb18e70564 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -259,7 +259,7 @@ static const struct acpi_device_id inv_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
 
 static struct i2c_driver inv_mpu_driver = {
-	.probe_new	=	inv_mpu_probe,
+	.probe		=	inv_mpu_probe,
 	.remove		=	inv_mpu_remove,
 	.id_table	=	inv_mpu_id,
 	.driver = {
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 53ba020fa5d0..958167b31241 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1517,7 +1517,7 @@ static struct i2c_driver kmx61_driver = {
 		.acpi_match_table = ACPI_PTR(kmx61_acpi_match),
 		.pm = pm_ptr(&kmx61_pm_ops),
 	},
-	.probe_new	= kmx61_probe,
+	.probe		= kmx61_probe,
 	.remove		= kmx61_remove,
 	.id_table	= kmx61_id,
 };
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 020717f92363..911444ec57c0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -179,7 +179,7 @@ static struct i2c_driver st_lsm6dsx_driver = {
 		.of_match_table = st_lsm6dsx_i2c_of_match,
 		.acpi_match_table = st_lsm6dsx_i2c_acpi_match,
 	},
-	.probe_new = st_lsm6dsx_i2c_probe,
+	.probe = st_lsm6dsx_i2c_probe,
 	.id_table = st_lsm6dsx_i2c_id_table,
 };
 module_i2c_driver(st_lsm6dsx_driver);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index a90138d8b06a..5c465444b4be 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -69,7 +69,7 @@ static struct i2c_driver st_lsm9ds0_driver = {
 		.name = "st-lsm9ds0-i2c",
 		.of_match_table = st_lsm9ds0_of_match,
 	},
-	.probe_new = st_lsm9ds0_i2c_probe,
+	.probe = st_lsm9ds0_i2c_probe,
 	.id_table = st_lsm9ds0_id_table,
 };
 module_i2c_driver(st_lsm9ds0_driver);
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 210a90f44c53..5fd775a20176 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -270,7 +270,7 @@ static struct i2c_driver adjd_s311_driver = {
 	.driver = {
 		.name	= ADJD_S311_DRV_NAME,
 	},
-	.probe_new	= adjd_s311_probe,
+	.probe		= adjd_s311_probe,
 	.id_table	= adjd_s311_id,
 };
 module_i2c_driver(adjd_s311_driver);
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 606075350d01..aa4a6c78f0aa 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -837,7 +837,7 @@ static struct i2c_driver adux1020_driver = {
 		.name	= ADUX1020_DRV_NAME,
 		.of_match_table = adux1020_of_match,
 	},
-	.probe_new	= adux1020_probe,
+	.probe		= adux1020_probe,
 	.id_table	= adux1020_id,
 };
 module_i2c_driver(adux1020_driver);
diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 69cc723e2ac4..8f0119f392b7 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -229,7 +229,7 @@ static struct i2c_driver al3010_driver = {
 		.of_match_table = al3010_of_match,
 		.pm = pm_sleep_ptr(&al3010_pm_ops),
 	},
-	.probe_new	= al3010_probe,
+	.probe		= al3010_probe,
 	.id_table	= al3010_id,
 };
 module_i2c_driver(al3010_driver);
diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 9ff28bbf34bb..255e9e5bc24f 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -253,7 +253,7 @@ static struct i2c_driver al3320a_driver = {
 		.of_match_table = al3320a_of_match,
 		.pm = pm_sleep_ptr(&al3320a_pm_ops),
 	},
-	.probe_new	= al3320a_probe,
+	.probe		= al3320a_probe,
 	.id_table	= al3320a_id,
 };
 
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 15dfb753734f..0f978b30a232 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -504,7 +504,7 @@ static struct i2c_driver apds9300_driver = {
 		.name	= APDS9300_DRV_NAME,
 		.pm	= pm_sleep_ptr(&apds9300_pm_ops),
 	},
-	.probe_new	= apds9300_probe,
+	.probe		= apds9300_probe,
 	.remove		= apds9300_remove,
 	.id_table	= apds9300_id,
 };
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index cc5974a95bd3..1065a340b12b 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1131,7 +1131,7 @@ static struct i2c_driver apds9960_driver = {
 		.pm	= &apds9960_pm_ops,
 		.acpi_match_table = apds9960_acpi_match,
 	},
-	.probe_new	= apds9960_probe,
+	.probe		= apds9960_probe,
 	.remove		= apds9960_remove,
 	.id_table	= apds9960_id,
 };
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 2307fc531752..ec97a3a46839 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -790,7 +790,7 @@ static struct i2c_driver as73211_driver = {
 		.of_match_table = as73211_of_match,
 		.pm             = pm_sleep_ptr(&as73211_pm_ops),
 	},
-	.probe_new  = as73211_probe,
+	.probe      = as73211_probe,
 	.id_table   = as73211_id,
 };
 module_i2c_driver(as73211_driver);
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 390c5b3ad4f6..4b869fa9e5b1 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -320,7 +320,7 @@ static struct i2c_driver bh1750_driver = {
 		.of_match_table = bh1750_of_match,
 		.pm = pm_sleep_ptr(&bh1750_pm_ops),
 	},
-	.probe_new = bh1750_probe,
+	.probe = bh1750_probe,
 	.remove = bh1750_remove,
 	.id_table = bh1750_id,
 
diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index da9039e5a839..b84166c5fa06 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -269,7 +269,7 @@ static const struct of_device_id of_bh1780_match[] = {
 MODULE_DEVICE_TABLE(of, of_bh1780_match);
 
 static struct i2c_driver bh1780_driver = {
-	.probe_new	= bh1780_probe,
+	.probe		= bh1780_probe,
 	.remove		= bh1780_remove,
 	.id_table	= bh1780_id,
 	.driver = {
diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index d4a34a3bf00d..9df85b3999fa 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -542,7 +542,7 @@ static struct i2c_driver cm32181_driver = {
 		.of_match_table = cm32181_of_match,
 		.pm = pm_sleep_ptr(&cm32181_pm_ops),
 	},
-	.probe_new	= cm32181_probe,
+	.probe		= cm32181_probe,
 };
 
 module_i2c_driver(cm32181_driver);
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 43e492f5051d..d48a70efca69 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -417,7 +417,7 @@ static struct i2c_driver cm3232_driver = {
 		.pm	= pm_sleep_ptr(&cm3232_pm_ops),
 	},
 	.id_table	= cm3232_id,
-	.probe_new	= cm3232_probe,
+	.probe		= cm3232_probe,
 	.remove		= cm3232_remove,
 };
 
diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index e5ce7d0fd272..35d20207a648 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -266,7 +266,7 @@ static struct i2c_driver cm3323_driver = {
 		.name = CM3323_DRV_NAME,
 		.of_match_table = cm3323_of_match,
 	},
-	.probe_new	= cm3323_probe,
+	.probe		= cm3323_probe,
 	.id_table	= cm3323_id,
 };
 
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 1707dbf2ce26..97e559acba2b 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -730,7 +730,7 @@ static struct i2c_driver cm36651_driver = {
 		.name	= "cm36651",
 		.of_match_table = cm36651_of_match,
 	},
-	.probe_new	= cm36651_probe,
+	.probe		= cm36651_probe,
 	.remove		= cm36651_remove,
 	.id_table	= cm36651_id,
 };
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index c0430db0038a..fec10d5e037e 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -710,7 +710,7 @@ static struct i2c_driver gp2ap002_driver = {
 		.of_match_table = gp2ap002_of_match,
 		.pm = pm_ptr(&gp2ap002_dev_pm_ops),
 	},
-	.probe_new = gp2ap002_probe,
+	.probe = gp2ap002_probe,
 	.remove = gp2ap002_remove,
 	.id_table = gp2ap002_id_table,
 };
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index a5bf9da0d2f3..9f41724819b6 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1609,7 +1609,7 @@ static struct i2c_driver gp2ap020a00f_driver = {
 		.name	= GP2A_I2C_NAME,
 		.of_match_table = gp2ap020a00f_of_match,
 	},
-	.probe_new	= gp2ap020a00f_probe,
+	.probe		= gp2ap020a00f_probe,
 	.remove		= gp2ap020a00f_remove,
 	.id_table	= gp2ap020a00f_id,
 };
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 141845fb47f9..43484c18b101 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -865,7 +865,7 @@ static struct i2c_driver isl29018_driver = {
 			.pm = pm_sleep_ptr(&isl29018_pm_ops),
 			.of_match_table = isl29018_of_match,
 		    },
-	.probe_new = isl29018_probe,
+	.probe = isl29018_probe,
 	.id_table = isl29018_id,
 };
 module_i2c_driver(isl29018_driver);
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index bcf3a556e41a..5694683389be 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -698,7 +698,7 @@ static struct i2c_driver isl29028_driver = {
 		.pm = pm_ptr(&isl29028_pm_ops),
 		.of_match_table = isl29028_of_match,
 	},
-	.probe_new = isl29028_probe,
+	.probe = isl29028_probe,
 	.remove  = isl29028_remove,
 	.id_table = isl29028_id,
 };
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index b4bd656ca169..f1d3356d3369 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -337,7 +337,7 @@ static struct i2c_driver isl29125_driver = {
 		.name	= ISL29125_DRV_NAME,
 		.pm	= pm_sleep_ptr(&isl29125_pm_ops),
 	},
-	.probe_new	= isl29125_probe,
+	.probe		= isl29125_probe,
 	.remove		= isl29125_remove,
 	.id_table	= isl29125_id,
 };
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index d3834d0a0635..37e2807041a1 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -440,7 +440,7 @@ static struct i2c_driver jsa1212_driver = {
 		.pm	= pm_sleep_ptr(&jsa1212_pm_ops),
 		.acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
 	},
-	.probe_new	= jsa1212_probe,
+	.probe		= jsa1212_probe,
 	.remove		= jsa1212_remove,
 	.id_table	= jsa1212_id,
 };
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index bdbd918213e4..061c122fdc5e 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1641,7 +1641,7 @@ static struct i2c_driver ltr501_driver = {
 		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
 		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
 	},
-	.probe_new = ltr501_probe,
+	.probe = ltr501_probe,
 	.remove	= ltr501_remove,
 	.id_table = ltr501_id,
 };
diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 4b8ef36b6912..8de4dd849936 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -539,7 +539,7 @@ static struct i2c_driver ltrf216a_driver = {
 		.pm = pm_ptr(&ltrf216a_pm_ops),
 		.of_match_table = ltrf216a_of_match,
 	},
-	.probe_new = ltrf216a_probe,
+	.probe = ltrf216a_probe,
 	.id_table = ltrf216a_id,
 };
 module_i2c_driver(ltrf216a_driver);
diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
index c041fa0faa5d..a5445d58fddf 100644
--- a/drivers/iio/light/lv0104cs.c
+++ b/drivers/iio/light/lv0104cs.c
@@ -520,7 +520,7 @@ static struct i2c_driver lv0104cs_i2c_driver = {
 		.name	= "lv0104cs",
 	},
 	.id_table	= lv0104cs_id,
-	.probe_new	= lv0104cs_probe,
+	.probe		= lv0104cs_probe,
 };
 module_i2c_driver(lv0104cs_i2c_driver);
 
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 5dcabc43a30e..db96c5b73100 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -616,7 +616,7 @@ static struct i2c_driver max44000_driver = {
 		.name	= MAX44000_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(max44000_acpi_match),
 	},
-	.probe_new	= max44000_probe,
+	.probe		= max44000_probe,
 	.id_table	= max44000_id,
 };
 
diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 176dcad6e8e8..61ce276e86f7 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -544,7 +544,7 @@ static struct i2c_driver max44009_driver = {
 		.name = MAX44009_DRV_NAME,
 		.of_match_table = max44009_of_match,
 	},
-	.probe_new = max44009_probe,
+	.probe = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);
diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index eaf548d4649e..1574310020e3 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -278,7 +278,7 @@ static struct i2c_driver noa1305_driver = {
 		.name		= NOA1305_DRIVER_NAME,
 		.of_match_table	= noa1305_of_match,
 	},
-	.probe_new	= noa1305_probe,
+	.probe		= noa1305_probe,
 	.id_table	= noa1305_ids,
 };
 
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index ec4f5c2369c4..cb41e5ee8ec1 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -834,7 +834,7 @@ static const struct of_device_id opt3001_of_match[] = {
 MODULE_DEVICE_TABLE(of, opt3001_of_match);
 
 static struct i2c_driver opt3001_driver = {
-	.probe_new = opt3001_probe,
+	.probe = opt3001_probe,
 	.remove = opt3001_remove,
 	.id_table = opt3001_id,
 
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 15a666f15c27..ed241598aefb 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -474,7 +474,7 @@ static struct i2c_driver pa12203001_driver = {
 		.pm = &pa12203001_pm_ops,
 		.acpi_match_table = ACPI_PTR(pa12203001_acpi_match),
 	},
-	.probe_new = pa12203001_probe,
+	.probe = pa12203001_probe,
 	.remove = pa12203001_remove,
 	.id_table = pa12203001_id,
 
diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index e486dcf35eba..9ce117ac2a41 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1487,7 +1487,7 @@ static struct i2c_driver bu27034_i2c_driver = {
 		.name = "bu27034-als",
 		.of_match_table = bu27034_of_match,
 	},
-	.probe_new = bu27034_probe,
+	.probe = bu27034_probe,
 };
 module_i2c_driver(bu27034_i2c_driver);
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 9d0218b7426e..bbb8581622f2 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1121,7 +1121,7 @@ static struct i2c_driver rpr0521_driver = {
 		.pm	= pm_ptr(&rpr0521_pm_ops),
 		.acpi_match_table = ACPI_PTR(rpr0521_acpi_match),
 	},
-	.probe_new	= rpr0521_probe,
+	.probe		= rpr0521_probe,
 	.remove		= rpr0521_remove,
 	.id_table	= rpr0521_id,
 };
diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index a08fbc8f5adb..ea2c437199c0 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -1064,7 +1064,7 @@ static struct i2c_driver si1133_driver = {
 	.driver = {
 	    .name   = "si1133",
 	},
-	.probe_new = si1133_probe,
+	.probe = si1133_probe,
 	.id_table = si1133_ids,
 };
 
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index f7126235f94c..77666b780a5c 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1352,7 +1352,7 @@ static struct i2c_driver si1145_driver = {
 	.driver = {
 		.name   = "si1145",
 	},
-	.probe_new = si1145_probe,
+	.probe = si1145_probe,
 	.id_table = si1145_ids,
 };
 
diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index 2160e87bb498..6bc2ddfb77ca 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -57,7 +57,7 @@ static struct i2c_driver st_uvis25_driver = {
 		.pm = pm_sleep_ptr(&st_uvis25_pm_ops),
 		.of_match_table = st_uvis25_i2c_of_match,
 	},
-	.probe_new = st_uvis25_i2c_probe,
+	.probe = st_uvis25_i2c_probe,
 	.id_table = st_uvis25_i2c_id_table,
 };
 module_i2c_driver(st_uvis25_driver);
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 48ae6ff0015e..72b08d870d33 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -714,7 +714,7 @@ static struct i2c_driver stk3310_driver = {
 		.pm = pm_sleep_ptr(&stk3310_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
 	},
-	.probe_new =        stk3310_probe,
+	.probe =        stk3310_probe,
 	.remove =           stk3310_remove,
 	.id_table =         stk3310_i2c_id,
 };
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 5100732fbaf0..dcdd85b006be 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -373,7 +373,7 @@ static struct i2c_driver tcs3414_driver = {
 		.name	= TCS3414_DRV_NAME,
 		.pm	= pm_sleep_ptr(&tcs3414_pm_ops),
 	},
-	.probe_new	= tcs3414_probe,
+	.probe		= tcs3414_probe,
 	.id_table	= tcs3414_id,
 };
 module_i2c_driver(tcs3414_driver);
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 6187c5487916..75fcf2c93717 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -609,7 +609,7 @@ static struct i2c_driver tcs3472_driver = {
 		.name	= TCS3472_DRV_NAME,
 		.pm	= pm_sleep_ptr(&tcs3472_pm_ops),
 	},
-	.probe_new	= tcs3472_probe,
+	.probe		= tcs3472_probe,
 	.remove		= tcs3472_remove,
 	.id_table	= tcs3472_id,
 };
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index f2f55239a072..1a6f514bced6 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -862,7 +862,7 @@ static struct i2c_driver tsl2563_i2c_driver = {
 		.of_match_table = tsl2563_of_match,
 		.pm	= pm_sleep_ptr(&tsl2563_pm_ops),
 	},
-	.probe_new	= tsl2563_probe,
+	.probe		= tsl2563_probe,
 	.remove		= tsl2563_remove,
 	.id_table	= tsl2563_id,
 };
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a05f1c0453d1..02ad11611b9c 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -942,7 +942,7 @@ static struct i2c_driver tsl2583_driver = {
 		.of_match_table = tsl2583_of_match,
 	},
 	.id_table = tsl2583_idtable,
-	.probe_new = tsl2583_probe,
+	.probe = tsl2583_probe,
 	.remove = tsl2583_remove,
 };
 module_i2c_driver(tsl2583_driver);
diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index e485a556e6da..7bdbfe72f0f0 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1214,7 +1214,7 @@ static struct i2c_driver tsl2591_driver = {
 		.pm = pm_ptr(&tsl2591_pm_ops),
 		.of_match_table = tsl2591_of_match,
 	},
-	.probe_new = tsl2591_probe
+	.probe = tsl2591_probe
 };
 module_i2c_driver(tsl2591_driver);
 
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index e823c145f679..cab468a82b61 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1932,7 +1932,7 @@ static struct i2c_driver tsl2772_driver = {
 		.pm = &tsl2772_pm_ops,
 	},
 	.id_table = tsl2772_idtable,
-	.probe_new = tsl2772_probe,
+	.probe = tsl2772_probe,
 };
 
 module_i2c_driver(tsl2772_driver);
diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index d95397eb1526..4da7d78906d4 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -237,7 +237,7 @@ static struct i2c_driver tsl4531_driver = {
 		.name   = TSL4531_DRV_NAME,
 		.pm	= pm_sleep_ptr(&tsl4531_pm_ops),
 	},
-	.probe_new = tsl4531_probe,
+	.probe = tsl4531_probe,
 	.remove = tsl4531_remove,
 	.id_table = tsl4531_id,
 };
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 8b2a0c99c8e6..61b3b2aea626 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -974,7 +974,7 @@ static struct i2c_driver us5182d_driver = {
 		.of_match_table = us5182d_of_match,
 		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
 	},
-	.probe_new = us5182d_probe,
+	.probe = us5182d_probe,
 	.remove = us5182d_remove,
 	.id_table = us5182d_id,
 
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 56d3963d3d66..7c7362e28821 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1500,7 +1500,7 @@ static struct i2c_driver vcnl4000_driver = {
 		.pm	= pm_ptr(&vcnl4000_pm_ops),
 		.of_match_table = vcnl_4000_of_match,
 	},
-	.probe_new = vcnl4000_probe,
+	.probe = vcnl4000_probe,
 	.id_table = vcnl4000_id,
 	.remove	= vcnl4000_remove,
 };
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 14e29330e972..a85955e34db7 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -667,7 +667,7 @@ static struct i2c_driver vcnl4035_driver = {
 		.pm	= pm_ptr(&vcnl4035_pm_ops),
 		.of_match_table = vcnl4035_of_match,
 	},
-	.probe_new = vcnl4035_probe,
+	.probe = vcnl4035_probe,
 	.remove	= vcnl4035_remove,
 	.id_table = vcnl4035_id,
 };
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index e7d2d5d177d4..043f233d9bdb 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -892,7 +892,7 @@ static struct i2c_driver veml6030_driver = {
 		.of_match_table = veml6030_of_match,
 		.pm = pm_ptr(&veml6030_pm_ops),
 	},
-	.probe_new = veml6030_probe,
+	.probe = veml6030_probe,
 	.id_table = veml6030_id,
 };
 module_i2c_driver(veml6030_driver);
diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index ee76a68deb24..d99bf3ae0fe8 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -198,7 +198,7 @@ static struct i2c_driver veml6070_driver = {
 	.driver = {
 		.name   = VEML6070_DRV_NAME,
 	},
-	.probe_new = veml6070_probe,
+	.probe = veml6070_probe,
 	.remove  = veml6070_remove,
 	.id_table = veml6070_id,
 };
diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 8b56df26c59e..d4948dfc31ff 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -538,7 +538,7 @@ static struct i2c_driver vl6180_driver = {
 		.name   = VL6180_DRV_NAME,
 		.of_match_table = vl6180_of_match,
 	},
-	.probe_new = vl6180_probe,
+	.probe = vl6180_probe,
 	.id_table = vl6180_id,
 };
 
diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index e3bac8b56380..d370193a4742 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -554,7 +554,7 @@ static struct i2c_driver zopt2201_driver = {
 	.driver = {
 		.name   = ZOPT2201_DRV_NAME,
 	},
-	.probe_new = zopt2201_probe,
+	.probe = zopt2201_probe,
 	.id_table = zopt2201_id,
 };
 
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 45abdcce6bc0..c74d11943ec7 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -1046,7 +1046,7 @@ static struct i2c_driver ak8974_driver = {
 		.pm = pm_ptr(&ak8974_dev_pm_ops),
 		.of_match_table = ak8974_of_match,
 	},
-	.probe_new = ak8974_probe,
+	.probe = ak8974_probe,
 	.remove	  = ak8974_remove,
 	.id_table = ak8974_id,
 };
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 924b481a3034..eb706d0bf70b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1110,7 +1110,7 @@ static struct i2c_driver ak8975_driver = {
 		.of_match_table = ak8975_of_match,
 		.acpi_match_table = ak_acpi_match,
 	},
-	.probe_new	= ak8975_probe,
+	.probe		= ak8975_probe,
 	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index 44b8960eea17..281d1fa31c8e 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -71,7 +71,7 @@ static struct i2c_driver bmc150_magn_driver = {
 		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
 		.pm	= &bmc150_magn_pm_ops,
 	},
-	.probe_new	= bmc150_magn_i2c_probe,
+	.probe		= bmc150_magn_i2c_probe,
 	.remove		= bmc150_magn_i2c_remove,
 	.id_table	= bmc150_magn_i2c_id,
 };
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 7ef2b1d56289..bdd2784a9f86 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -95,7 +95,7 @@ static struct i2c_driver hmc5843_driver = {
 		.of_match_table = hmc5843_of_match,
 	},
 	.id_table	= hmc5843_id,
-	.probe_new	= hmc5843_i2c_probe,
+	.probe		= hmc5843_i2c_probe,
 	.remove		= hmc5843_i2c_remove,
 };
 module_i2c_driver(hmc5843_driver);
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 661176a885ad..deffe3ca9004 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -641,7 +641,7 @@ static struct i2c_driver mag3110_driver = {
 		.of_match_table = mag3110_of_match,
 		.pm	= pm_sleep_ptr(&mag3110_pm_ops),
 	},
-	.probe_new = mag3110_probe,
+	.probe = mag3110_probe,
 	.remove = mag3110_remove,
 	.id_table = mag3110_id,
 };
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 756dadbad106..b495b8a63928 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -575,7 +575,7 @@ static struct i2c_driver mmc35240_driver = {
 		.pm = pm_sleep_ptr(&mmc35240_pm_ops),
 		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
 	},
-	.probe_new	= mmc35240_probe,
+	.probe		= mmc35240_probe,
 	.id_table	= mmc35240_id,
 };
 
diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
index ba669ab7113d..ac7276b3798c 100644
--- a/drivers/iio/magnetometer/rm3100-i2c.c
+++ b/drivers/iio/magnetometer/rm3100-i2c.c
@@ -45,7 +45,7 @@ static struct i2c_driver rm3100_driver = {
 		.name = "rm3100-i2c",
 		.of_match_table = rm3100_dt_match,
 	},
-	.probe_new = rm3100_probe,
+	.probe = rm3100_probe,
 };
 module_i2c_driver(rm3100_driver);
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index cc0e0e94b129..950826dd20bf 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -111,7 +111,7 @@ static struct i2c_driver st_magn_driver = {
 		.name = "st-magn-i2c",
 		.of_match_table = st_magn_of_match,
 	},
-	.probe_new = st_magn_i2c_probe,
+	.probe = st_magn_i2c_probe,
 	.id_table = st_magn_id_table,
 };
 module_i2c_driver(st_magn_driver);
diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 28bb7efe8df8..321419676211 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -733,7 +733,7 @@ static struct i2c_driver tmag5273_driver = {
 		.of_match_table = tmag5273_of_match,
 		.pm = pm_ptr(&tmag5273_pm_ops),
 	},
-	.probe_new = tmag5273_probe,
+	.probe = tmag5273_probe,
 	.id_table = tmag5273_id,
 };
 module_i2c_driver(tmag5273_driver);
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 753717158b07..c5e485bfc6fc 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1605,7 +1605,7 @@ static struct i2c_driver yas5xx_driver = {
 		.of_match_table = yas5xx_of_match,
 		.pm = pm_ptr(&yas5xx_dev_pm_ops),
 	},
-	.probe_new = yas5xx_probe,
+	.probe = yas5xx_probe,
 	.remove	  = yas5xx_remove,
 	.id_table = yas5xx_id,
 };
diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiometer/ad5110.c
index 8fbcce482989..991e745c4f93 100644
--- a/drivers/iio/potentiometer/ad5110.c
+++ b/drivers/iio/potentiometer/ad5110.c
@@ -334,7 +334,7 @@ static struct i2c_driver ad5110_driver = {
 		.name	= "ad5110",
 		.of_match_table = ad5110_of_match,
 	},
-	.probe_new	= ad5110_probe,
+	.probe		= ad5110_probe,
 	.id_table	= ad5110_id,
 };
 module_i2c_driver(ad5110_driver);
diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index aa140d632101..b17941e4c2f7 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -218,7 +218,7 @@ static struct i2c_driver ad5272_driver = {
 		.name	= "ad5272",
 		.of_match_table = ad5272_dt_ids,
 	},
-	.probe_new	= ad5272_probe,
+	.probe		= ad5272_probe,
 	.id_table	= ad5272_id,
 };
 
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 0b5e475807cb..fc183e0790da 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -252,7 +252,7 @@ static struct i2c_driver ds1803_driver = {
 		.name	= "ds1803",
 		.of_match_table = ds1803_dt_ids,
 	},
-	.probe_new	= ds1803_probe,
+	.probe		= ds1803_probe,
 	.id_table	= ds1803_id,
 };
 
diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
index 94ef27ef3fb5..c8e2481dadb5 100644
--- a/drivers/iio/potentiometer/max5432.c
+++ b/drivers/iio/potentiometer/max5432.c
@@ -123,7 +123,7 @@ static struct i2c_driver max5432_driver = {
 		.name = "max5432",
 		.of_match_table = max5432_dt_ids,
 	},
-	.probe_new = max5432_probe,
+	.probe = max5432_probe,
 };
 
 module_i2c_driver(max5432_driver);
diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index c0e171fec062..89daecc90305 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -174,7 +174,7 @@ static struct i2c_driver mcp4018_driver = {
 		.name	= "mcp4018",
 		.of_match_table = mcp4018_of_match,
 	},
-	.probe_new	= mcp4018_probe,
+	.probe		= mcp4018_probe,
 	.id_table	= mcp4018_id,
 };
 
diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index c25f84b4a270..c513c00c8243 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -385,7 +385,7 @@ static struct i2c_driver mcp4531_driver = {
 		.name	= "mcp4531",
 		.of_match_table = mcp4531_of_match,
 	},
-	.probe_new	= mcp4531_probe,
+	.probe		= mcp4531_probe,
 	.id_table	= mcp4531_id,
 };
 
diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index a3465b413b0c..8923ccb0fc4f 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -161,7 +161,7 @@ static struct i2c_driver tpl0102_driver = {
 	.driver = {
 		.name = "tpl0102",
 	},
-	.probe_new = tpl0102_probe,
+	.probe = tpl0102_probe,
 	.id_table = tpl0102_id,
 };
 
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 0083e858c21e..bd0f2c3bf2f2 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -416,7 +416,7 @@ static struct i2c_driver lmp91000_driver = {
 		.name = LMP91000_DRV_NAME,
 		.of_match_table = lmp91000_of_match,
 	},
-	.probe_new = lmp91000_probe,
+	.probe = lmp91000_probe,
 	.remove = lmp91000_remove,
 	.id_table = lmp91000_id,
 };
diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index c0140779366a..752a63c06b44 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -255,7 +255,7 @@ static struct i2c_driver abp060mg_driver = {
 	.driver = {
 		.name = "abp060mg",
 	},
-	.probe_new = abp060mg_probe,
+	.probe = abp060mg_probe,
 	.id_table = abp060mg_id_table,
 };
 module_i2c_driver(abp060mg_driver);
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 567b945e6427..dbe630ad05b5 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -56,7 +56,7 @@ static struct i2c_driver bmp280_i2c_driver = {
 		.of_match_table = bmp280_of_i2c_match,
 		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
-	.probe_new	= bmp280_i2c_probe,
+	.probe		= bmp280_i2c_probe,
 	.id_table	= bmp280_i2c_id,
 };
 module_i2c_driver(bmp280_i2c_driver);
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 43650b048d62..28c8269ba65d 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -362,7 +362,7 @@ static struct i2c_driver dlh_driver = {
 		.name = "dlhl60d",
 		.of_match_table = dlh_of_match,
 	},
-	.probe_new = dlh_probe,
+	.probe = dlh_probe,
 	.id_table = dlh_id,
 };
 module_i2c_driver(dlh_driver);
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 2af275a24ff9..b10dbf5cf494 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -887,7 +887,7 @@ static struct i2c_driver dps310_driver = {
 		.name = DPS310_DEV_NAME,
 		.acpi_match_table = dps310_acpi_match,
 	},
-	.probe_new = dps310_probe,
+	.probe = dps310_probe,
 	.id_table = dps310_id,
 };
 module_i2c_driver(dps310_driver);
diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index bd1f71a99cfa..8bdb279129fa 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -282,7 +282,7 @@ static struct i2c_driver hp03_driver = {
 		.name	= "hp03",
 		.of_match_table = hp03_of_match,
 	},
-	.probe_new	= hp03_probe,
+	.probe		= hp03_probe,
 	.id_table	= hp03_id,
 };
 module_i2c_driver(hp03_driver);
diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index b6d2ff464341..a072de6cb59c 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -409,7 +409,7 @@ MODULE_DEVICE_TABLE(acpi, hp206c_acpi_match);
 #endif
 
 static struct i2c_driver hp206c_driver = {
-	.probe_new = hp206c_probe,
+	.probe = hp206c_probe,
 	.id_table = hp206c_id,
 	.driver = {
 		.name = "hp206c",
diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 407cf25ea0e3..2086f3ef338f 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -648,7 +648,7 @@ static struct i2c_driver icp10100_driver = {
 		.pm = pm_ptr(&icp10100_pm),
 		.of_match_table = icp10100_of_match,
 	},
-	.probe_new = icp10100_probe,
+	.probe = icp10100_probe,
 	.id_table = icp10100_id,
 };
 module_i2c_driver(icp10100_driver);
diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
index ade4dd854ddf..fcbdadf4a511 100644
--- a/drivers/iio/pressure/mpl115_i2c.c
+++ b/drivers/iio/pressure/mpl115_i2c.c
@@ -55,7 +55,7 @@ static struct i2c_driver mpl115_i2c_driver = {
 		.name	= "mpl115",
 		.pm = pm_ptr(&mpl115_dev_pm_ops),
 	},
-	.probe_new = mpl115_i2c_probe,
+	.probe = mpl115_i2c_probe,
 	.id_table = mpl115_i2c_id,
 };
 module_i2c_driver(mpl115_i2c_driver);
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 72e811a5c96e..7aa19584c340 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -335,7 +335,7 @@ static struct i2c_driver mpl3115_driver = {
 		.of_match_table = mpl3115_of_match,
 		.pm	= pm_sleep_ptr(&mpl3115_pm_ops),
 	},
-	.probe_new = mpl3115_probe,
+	.probe = mpl3115_probe,
 	.remove = mpl3115_remove,
 	.id_table = mpl3115_id,
 };
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index e3c68a3ed76a..9a0f52321fcb 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -125,7 +125,7 @@ static struct i2c_driver ms5611_driver = {
 		.of_match_table = ms5611_i2c_matches,
 	},
 	.id_table = ms5611_id,
-	.probe_new = ms5611_i2c_probe,
+	.probe = ms5611_i2c_probe,
 };
 module_i2c_driver(ms5611_driver);
 
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index c4981b29dccb..9b3abffb724b 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -238,7 +238,7 @@ static const struct of_device_id ms5637_of_match[] = {
 MODULE_DEVICE_TABLE(of, ms5637_of_match);
 
 static struct i2c_driver ms5637_driver = {
-	.probe_new = ms5637_probe,
+	.probe = ms5637_probe,
 	.id_table = ms5637_id,
 	.driver = {
 		   .name = "ms5637",
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index f2c3bb568d16..5101552e3f38 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -116,7 +116,7 @@ static struct i2c_driver st_press_driver = {
 		.of_match_table = st_press_of_match,
 		.acpi_match_table = ACPI_PTR(st_press_acpi_match),
 	},
-	.probe_new = st_press_i2c_probe,
+	.probe = st_press_i2c_probe,
 	.id_table = st_press_id_table,
 };
 module_i2c_driver(st_press_driver);
diff --git a/drivers/iio/pressure/t5403.c b/drivers/iio/pressure/t5403.c
index 2fbf14aff033..a6463c06975e 100644
--- a/drivers/iio/pressure/t5403.c
+++ b/drivers/iio/pressure/t5403.c
@@ -260,7 +260,7 @@ static struct i2c_driver t5403_driver = {
 	.driver = {
 		.name	= "t5403",
 	},
-	.probe_new = t5403_probe,
+	.probe = t5403_probe,
 	.id_table = t5403_id,
 };
 module_i2c_driver(t5403_driver);
diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
index ade465014be1..c7fffbe7c788 100644
--- a/drivers/iio/pressure/zpa2326_i2c.c
+++ b/drivers/iio/pressure/zpa2326_i2c.c
@@ -76,7 +76,7 @@ static struct i2c_driver zpa2326_i2c_driver = {
 		.of_match_table = zpa2326_i2c_matches,
 		.pm             = ZPA2326_PM_OPS,
 	},
-	.probe_new = zpa2326_probe_i2c,
+	.probe = zpa2326_probe_i2c,
 	.remove   = zpa2326_remove_i2c,
 	.id_table = zpa2326_i2c_ids,
 };
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 7b8f40b7ccf3..fe45ca35a124 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -1008,7 +1008,7 @@ static struct i2c_driver isl29501_driver = {
 		.name	= "isl29501",
 	},
 	.id_table	= isl29501_id,
-	.probe_new	= isl29501_probe,
+	.probe		= isl29501_probe,
 };
 module_i2c_driver(isl29501_driver);
 
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index e70cac8240af..fb1073c8d9f7 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -264,7 +264,7 @@ static struct i2c_driver mb1232_driver = {
 		.name	= "maxbotix-mb1232",
 		.of_match_table	= of_mb1232_match,
 	},
-	.probe_new = mb1232_probe,
+	.probe = mb1232_probe,
 	.id_table = mb1232_id,
 };
 module_i2c_driver(mb1232_driver);
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index c9eead01a031..2913d5e0fe4f 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -365,7 +365,7 @@ static struct i2c_driver lidar_driver = {
 		.of_match_table	= lidar_dt_ids,
 		.pm	= pm_ptr(&lidar_pm_ops),
 	},
-	.probe_new	= lidar_probe,
+	.probe		= lidar_probe,
 	.remove		= lidar_remove,
 	.id_table	= lidar_id,
 };
diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 44f72b78bd50..f02e83e3f15f 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -318,7 +318,7 @@ static struct i2c_driver rfd77402_driver = {
 		.name   = RFD77402_DRV_NAME,
 		.pm     = pm_sleep_ptr(&rfd77402_pm_ops),
 	},
-	.probe_new = rfd77402_probe,
+	.probe = rfd77402_probe,
 	.id_table = rfd77402_id,
 };
 
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 61866d0440f7..a75ea5042876 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -549,7 +549,7 @@ static struct i2c_driver srf08_driver = {
 		.name	= "srf08",
 		.of_match_table	= of_srf08_match,
 	},
-	.probe_new = srf08_probe,
+	.probe = srf08_probe,
 	.id_table = srf08_id,
 };
 module_i2c_driver(srf08_driver);
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 0e4747ccd3cf..d977aacb7491 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1050,7 +1050,7 @@ static struct i2c_driver sx9310_driver = {
 		 */
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe_new	= sx9310_probe,
+	.probe		= sx9310_probe,
 	.id_table	= sx9310_id,
 };
 module_i2c_driver(sx9310_driver);
diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 9a40ca32bb1c..438f9c9aba6e 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1152,7 +1152,7 @@ static struct i2c_driver sx9324_driver = {
 		 */
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe_new	= sx9324_probe,
+	.probe		= sx9324_probe,
 	.id_table	= sx9324_id,
 };
 module_i2c_driver(sx9324_driver);
diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index a50d9176411a..2c4e14a4fe9f 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -896,7 +896,7 @@ static struct i2c_driver sx9360_driver = {
 		 */
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe_new	= sx9360_probe,
+	.probe		= sx9360_probe,
 	.id_table	= sx9360_id,
 };
 module_i2c_driver(sx9360_driver);
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 9b2cfcade6a4..550e7d3cd5ee 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1055,7 +1055,7 @@ static struct i2c_driver sx9500_driver = {
 		.of_match_table = sx9500_of_match,
 		.pm = pm_sleep_ptr(&sx9500_pm_ops),
 	},
-	.probe_new	= sx9500_probe,
+	.probe		= sx9500_probe,
 	.remove		= sx9500_remove,
 	.id_table	= sx9500_id,
 };
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index cbc8400c773c..d1ddf85f5383 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -662,7 +662,7 @@ static struct i2c_driver vcnl3020_driver = {
 		.name   = "vcnl3020",
 		.of_match_table = vcnl3020_of_match,
 	},
-	.probe_new  = vcnl3020_probe,
+	.probe      = vcnl3020_probe,
 };
 module_i2c_driver(vcnl3020_driver);
 
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index c7c4d33d340f..2cea64bea909 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -294,7 +294,7 @@ static struct i2c_driver vl53l0x_driver = {
 		.name = "vl53l0x-i2c",
 		.of_match_table = st_vl53l0x_dt_match,
 	},
-	.probe_new = vl53l0x_probe,
+	.probe = vl53l0x_probe,
 	.id_table = vl53l0x_id,
 };
 module_i2c_driver(vl53l0x_driver);
diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
index c85c21474711..48be03852cd8 100644
--- a/drivers/iio/temperature/max30208.c
+++ b/drivers/iio/temperature/max30208.c
@@ -242,7 +242,7 @@ static struct i2c_driver max30208_driver = {
 		.of_match_table = max30208_of_match,
 		.acpi_match_table = max30208_acpi_match,
 	},
-	.probe_new = max30208_probe,
+	.probe = max30208_probe,
 	.id_table = max30208_id_table,
 };
 module_i2c_driver(max30208_driver);
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 909fadb62349..6a1531669b34 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -675,7 +675,7 @@ static struct i2c_driver mlx90614_driver = {
 		.of_match_table = mlx90614_of_match,
 		.pm	= pm_ptr(&mlx90614_pm_ops),
 	},
-	.probe_new = mlx90614_probe,
+	.probe = mlx90614_probe,
 	.remove = mlx90614_remove,
 	.id_table = mlx90614_id,
 };
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 753b7a4ccfdd..8a57be108620 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1337,7 +1337,7 @@ static struct i2c_driver mlx90632_driver = {
 		.of_match_table = mlx90632_of_match,
 		.pm	= pm_ptr(&mlx90632_pm_ops),
 	},
-	.probe_new = mlx90632_probe,
+	.probe = mlx90632_probe,
 	.id_table = mlx90632_id,
 };
 module_i2c_driver(mlx90632_driver);
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index cdf08477e63f..811d7eaa939c 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -283,7 +283,7 @@ static struct i2c_driver tmp006_driver = {
 		.name	= "tmp006",
 		.pm	= pm_sleep_ptr(&tmp006_pm_ops),
 	},
-	.probe_new = tmp006_probe,
+	.probe = tmp006_probe,
 	.id_table = tmp006_id,
 };
 module_i2c_driver(tmp006_driver);
diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index 8d27aa3bdd6d..decef6896362 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -574,7 +574,7 @@ static struct i2c_driver tmp007_driver = {
 		.of_match_table = tmp007_of_match,
 		.pm	= pm_sleep_ptr(&tmp007_pm_ops),
 	},
-	.probe_new	= tmp007_probe,
+	.probe		= tmp007_probe,
 	.id_table	= tmp007_id,
 };
 module_i2c_driver(tmp007_driver);
diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 638e3a5bd6b8..fc02f491688b 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -217,7 +217,7 @@ static struct i2c_driver tmp117_driver = {
 		.name	= "tmp117",
 		.of_match_table = tmp117_of_match,
 	},
-	.probe_new	= tmp117_probe,
+	.probe		= tmp117_probe,
 	.id_table	= tmp117_id,
 };
 module_i2c_driver(tmp117_driver);
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 30b268ba82cc..53ef56fbfe1d 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -218,7 +218,7 @@ static const struct of_device_id tsys01_of_match[] = {
 MODULE_DEVICE_TABLE(of, tsys01_of_match);
 
 static struct i2c_driver tsys01_driver = {
-	.probe_new = tsys01_i2c_probe,
+	.probe = tsys01_i2c_probe,
 	.id_table = tsys01_id,
 	.driver = {
 		   .name = "tsys01",
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index cdefe046ab17..6191db92ef9a 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -174,7 +174,7 @@ static const struct i2c_device_id tsys02d_id[] = {
 MODULE_DEVICE_TABLE(i2c, tsys02d_id);
 
 static struct i2c_driver tsys02d_driver = {
-	.probe_new = tsys02d_probe,
+	.probe = tsys02d_probe,
 	.id_table = tsys02d_id,
 	.driver = {
 		   .name = "tsys02d",

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

