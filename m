Return-Path: <linux-iio+bounces-4871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D165C8BF70D
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330BE1F248D6
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3E2837E;
	Wed,  8 May 2024 07:29:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F990286AE
	for <linux-iio@vger.kernel.org>; Wed,  8 May 2024 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153384; cv=none; b=TgZ3OD5tf8FWWG9jS64HcWoI6bPylzenpUlLYjbmibbwYooyXnRsuHC2+hazPYN1n7SOn9tmZDmx9FrkTHmBS+Dhv1cIWUv1RG1Et9COrKmH+pGXdrLrOc2KTL6sX9FjYBtAJazdn1TflNdfqRbkWtS3L5UxV8EIMbF5NjM7PqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153384; c=relaxed/simple;
	bh=vx5xKsNp7EQzJ+7J6m0D+1Z0aIngnUWDqqntBI7tYbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hd9AbCDLtirnhfmn5M/bEZs435dR5TRIrHcFT2fNefXH2fSbpVdgPZFlVxcovEcMBHfcHnpav/B2TmCILA6y3F70ci3GTQp8N+ZIHcQxKeJHaiKPxoJ+d8zWBfnvqdIy2izuksYhw3yS212/8PXoAyNNZ1mFpJ3WynxO2o2jEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4bk3-00038K-S8; Wed, 08 May 2024 09:29:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4bk3-000EXe-By; Wed, 08 May 2024 09:29:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4bk3-000JOq-0u;
	Wed, 08 May 2024 09:29:31 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] iio: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed,  8 May 2024 09:29:27 +0200
Message-ID: <20240508072928.2135858-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=48249; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vx5xKsNp7EQzJ+7J6m0D+1Z0aIngnUWDqqntBI7tYbA=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjRrzRuVYqLXjuUJPrKJ0g+fPD/HTO/trAzWCWxh2atZq 3x2qjzoZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAitqzsf0W33dDuPnQvtXf/ lZRrXMZyxtsUg68mvi7/7MJdp1890yj7ulDOj+SSrovLikW+ddxTPn3hb8fHuYdMDoVmmqakXeW bpf8/9nqzvnz7PzPlQJ2L7AI1U7wzq6w5X7fsCCysdZ6vnhX/5WrBgu1mojznlm13Pu0zR4yPXe D5tSdr9oleSmFdIpOfvuTKF032b1kszN90w1LnbRcPMGaNPViU0yDLql39/krhgXp30Y0t9V5Fz FdWPmX3Lyt6uyPyt9xO9/fbhC8UdwrFvqmffirorVdES+N0n9P3fNXC9E3THlWG75RuFdeZ88zn btbtjYWOS+6X/dHbtVgwdsPaT1lXjbqW5rxKWX80y/YZAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While add it, also remove commas after the sentinel entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I didn't add all the individual maintainers to Cc and put the iio changes in a
single patch. If you want I can split per driver (or per iio subdirectory?),
just tell me if you prefer it that way.

Best regards
Uwe

 drivers/iio/accel/adxl367_i2c.c                   |  4 ++--
 drivers/iio/accel/adxl372_i2c.c                   |  2 +-
 drivers/iio/accel/bma400_i2c.c                    |  2 +-
 drivers/iio/accel/da311.c                         |  2 +-
 drivers/iio/accel/dmard06.c                       |  6 +++---
 drivers/iio/accel/dmard09.c                       |  4 ++--
 drivers/iio/accel/dmard10.c                       |  2 +-
 drivers/iio/accel/kxsd9-i2c.c                     |  4 ++--
 drivers/iio/accel/mc3230.c                        |  2 +-
 drivers/iio/accel/mma7455_i2c.c                   |  4 ++--
 drivers/iio/accel/mma7660.c                       |  2 +-
 drivers/iio/accel/mma9551.c                       |  2 +-
 drivers/iio/accel/mma9553.c                       |  4 ++--
 drivers/iio/accel/mxc4005.c                       |  6 +++---
 drivers/iio/accel/mxc6255.c                       |  4 ++--
 drivers/iio/accel/stk8312.c                       |  4 ++--
 drivers/iio/accel/stk8ba50.c                      |  2 +-
 drivers/iio/adc/ad7291.c                          |  2 +-
 drivers/iio/adc/ltc2485.c                         |  2 +-
 drivers/iio/adc/nau7802.c                         |  2 +-
 drivers/iio/adc/ti-ads7924.c                      |  2 +-
 drivers/iio/chemical/ams-iaq-core.c               |  2 +-
 drivers/iio/chemical/bme680_i2c.c                 |  4 ++--
 drivers/iio/chemical/ccs811.c                     |  2 +-
 drivers/iio/dac/mcp4728.c                         |  2 +-
 drivers/iio/gyro/bmg160_i2c.c                     |  6 +++---
 drivers/iio/gyro/fxas21002c_i2c.c                 |  2 +-
 drivers/iio/gyro/itg3200_core.c                   |  2 +-
 drivers/iio/health/afe4404.c                      |  2 +-
 drivers/iio/health/max30100.c                     |  2 +-
 drivers/iio/humidity/am2315.c                     |  2 +-
 drivers/iio/humidity/hdc100x.c                    | 12 ++++++------
 drivers/iio/humidity/si7005.c                     |  4 ++--
 drivers/iio/humidity/si7020.c                     |  4 ++--
 drivers/iio/imu/bmi160/bmi160_i2c.c               |  2 +-
 drivers/iio/imu/bno055/bno055_i2c.c               |  2 +-
 drivers/iio/imu/fxos8700_i2c.c                    |  2 +-
 drivers/iio/imu/kmx61.c                           |  2 +-
 drivers/iio/light/adjd_s311.c                     |  2 +-
 drivers/iio/light/adux1020.c                      |  2 +-
 drivers/iio/light/al3320a.c                       |  2 +-
 drivers/iio/light/apds9300.c                      |  2 +-
 drivers/iio/light/apds9960.c                      |  2 +-
 drivers/iio/light/bh1780.c                        |  4 ++--
 drivers/iio/light/cm3232.c                        |  2 +-
 drivers/iio/light/cm3323.c                        |  2 +-
 drivers/iio/light/cm36651.c                       |  2 +-
 drivers/iio/light/gp2ap002.c                      |  4 ++--
 drivers/iio/light/gp2ap020a00f.c                  |  2 +-
 drivers/iio/light/isl29028.c                      |  4 ++--
 drivers/iio/light/isl29125.c                      |  2 +-
 drivers/iio/light/jsa1212.c                       |  2 +-
 drivers/iio/light/lv0104cs.c                      |  2 +-
 drivers/iio/light/max44000.c                      |  2 +-
 drivers/iio/light/max44009.c                      |  2 +-
 drivers/iio/light/noa1305.c                       |  2 +-
 drivers/iio/light/opt3001.c                       |  2 +-
 drivers/iio/light/pa12203001.c                    |  2 +-
 drivers/iio/light/rpr0521.c                       |  2 +-
 drivers/iio/light/si1133.c                        |  2 +-
 drivers/iio/light/stk3310.c                       |  6 +++---
 drivers/iio/light/tcs3414.c                       |  2 +-
 drivers/iio/light/tcs3472.c                       |  2 +-
 drivers/iio/light/tsl4531.c                       |  2 +-
 drivers/iio/light/us5182d.c                       |  2 +-
 drivers/iio/light/vcnl4035.c                      |  2 +-
 drivers/iio/light/veml6030.c                      |  2 +-
 drivers/iio/light/veml6070.c                      |  2 +-
 drivers/iio/light/vl6180.c                        |  2 +-
 drivers/iio/light/zopt2201.c                      |  2 +-
 drivers/iio/magnetometer/af8133j.c                |  2 +-
 drivers/iio/magnetometer/ak8974.c                 |  8 ++++----
 drivers/iio/magnetometer/bmc150_magn_i2c.c        |  6 +++---
 drivers/iio/magnetometer/mag3110.c                |  2 +-
 drivers/iio/magnetometer/mmc35240.c               |  2 +-
 drivers/iio/potentiostat/lmp91000.c               |  4 ++--
 drivers/iio/pressure/dps310.c                     |  2 +-
 drivers/iio/pressure/hp03.c                       |  4 ++--
 drivers/iio/pressure/icp10100.c                   |  2 +-
 drivers/iio/pressure/mpl115_i2c.c                 |  2 +-
 drivers/iio/pressure/mpl3115.c                    |  2 +-
 drivers/iio/pressure/t5403.c                      |  2 +-
 drivers/iio/pressure/zpa2326_i2c.c                |  4 ++--
 drivers/iio/proximity/isl29501.c                  |  2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |  6 +++---
 drivers/iio/proximity/rfd77402.c                  |  2 +-
 drivers/iio/proximity/sx9500.c                    |  4 ++--
 drivers/iio/proximity/vl53l0x-i2c.c               |  2 +-
 drivers/iio/temperature/mlx90632.c                |  2 +-
 drivers/iio/temperature/tmp006.c                  |  2 +-
 drivers/iio/temperature/tmp007.c                  |  2 +-
 drivers/iio/temperature/tsys01.c                  |  2 +-
 drivers/iio/temperature/tsys02d.c                 |  2 +-
 93 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index 62c74bdc0d77..deb82a43ec36 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -61,8 +61,8 @@ static int adxl367_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl367_i2c_id[] = {
-	{ "adxl367", 0 },
-	{ },
+	{ "adxl367" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl367_i2c_id);
 
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index d0690417fd36..3571cfde1c0e 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -42,7 +42,7 @@ static int adxl372_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl372_i2c_id[] = {
-	{ "adxl372", 0 },
+	{ "adxl372" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index adf4e3fd2e1d..c1c72f577295 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -28,7 +28,7 @@ static int bma400_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bma400_i2c_ids[] = {
-	{ "bma400", 0 },
+	{ "bma400" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bma400_i2c_ids);
diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 8f919920ced5..94f827acdd1c 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -268,7 +268,7 @@ static int da311_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
 
 static const struct i2c_device_id da311_i2c_id[] = {
-	{"da311", 0},
+	{ "da311" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, da311_i2c_id);
diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index 2e719d60fff8..fb14894c66f9 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -201,9 +201,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard06_suspend,
 				dmard06_resume);
 
 static const struct i2c_device_id dmard06_id[] = {
-	{ "dmard05", 0 },
-	{ "dmard06", 0 },
-	{ "dmard07", 0 },
+	{ "dmard05" },
+	{ "dmard06" },
+	{ "dmard07" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dmard06_id);
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index fa98623de579..6644c1fec3e6 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -125,8 +125,8 @@ static int dmard09_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id dmard09_id[] = {
-	{ "dmard09", 0 },
-	{ },
+	{ "dmard09" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, dmard09_id);
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 7745b6ffd1ad..35c0eefb741e 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -231,7 +231,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend,
 				dmard10_resume);
 
 static const struct i2c_device_id dmard10_i2c_id[] = {
-	{"dmard10", 0},
+	{ "dmard10" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 3bc9ee1f9db3..c4c7e2d4e98a 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -43,8 +43,8 @@ static const struct of_device_id kxsd9_of_match[] = {
 MODULE_DEVICE_TABLE(of, kxsd9_of_match);
 
 static const struct i2c_device_id kxsd9_i2c_id[] = {
-	{"kxsd9", 0},
-	{ },
+	{ "kxsd9" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kxsd9_i2c_id);
 
diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 6b87c2c9945c..caa40a14a631 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -180,7 +180,7 @@ static int mc3230_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
 static const struct i2c_device_id mc3230_i2c_id[] = {
-	{"mc3230", 0},
+	{ "mc3230" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
index 14f7850a22f0..36a357c8e9ed 100644
--- a/drivers/iio/accel/mma7455_i2c.c
+++ b/drivers/iio/accel/mma7455_i2c.c
@@ -32,8 +32,8 @@ static void mma7455_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id mma7455_i2c_ids[] = {
-	{ "mma7455", 0 },
-	{ "mma7456", 0 },
+	{ "mma7455" },
+	{ "mma7456" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma7455_i2c_ids);
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 260cbceaa151..d3febc760c4c 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -241,7 +241,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma7660_suspend,
 				mma7660_resume);
 
 static const struct i2c_device_id mma7660_i2c_id[] = {
-	{"mma7660", 0},
+	{ "mma7660" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mma7660_i2c_id);
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 083c08f65baf..fa1799b0b0df 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -595,7 +595,7 @@ static const struct acpi_device_id mma9551_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
 
 static const struct i2c_device_id mma9551_id[] = {
-	{"mma9551", 0},
+	{ "mma9551" },
 	{}
 };
 
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 3cbd0fd4e624..86543f34ef17 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1234,8 +1234,8 @@ static const struct acpi_device_id mma9553_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
 
 static const struct i2c_device_id mma9553_id[] = {
-	{"mma9553", 0},
-	{},
+	{ "mma9553" },
+	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, mma9553_id);
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index e56407b6f204..fc54a2a4693c 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -584,9 +584,9 @@ static const struct of_device_id mxc4005_of_match[] = {
 MODULE_DEVICE_TABLE(of, mxc4005_of_match);
 
 static const struct i2c_device_id mxc4005_id[] = {
-	{"mxc4005",	0},
-	{"mxc6655",	0},
-	{ },
+	{ "mxc4005" },
+	{ "mxc6655" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mxc4005_id);
 
diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index ac228128c4f9..a8abda7b2a63 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -172,8 +172,8 @@ static const struct acpi_device_id mxc6255_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, mxc6255_acpi_match);
 
 static const struct i2c_device_id mxc6255_id[] = {
-	{"mxc6225",	0},
-	{"mxc6255",	0},
+	{ "mxc6225" },
+	{ "mxc6255" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mxc6255_id);
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index ef0ae7672253..b3534d5751b9 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -633,8 +633,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend,
 
 static const struct i2c_device_id stk8312_i2c_id[] = {
 	/* Deprecated in favour of lowercase form */
-	{ "STK8312", 0 },
-	{ "stk8312", 0 },
+	{ "STK8312" },
+	{ "stk8312" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 668edc88c89d..6d3c7f444d21 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -525,7 +525,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8ba50_suspend,
 				stk8ba50_resume);
 
 static const struct i2c_device_id stk8ba50_i2c_id[] = {
-	{"stk8ba50", 0},
+	{ "stk8ba50" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, stk8ba50_i2c_id);
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index 14d02b085d3b..b59b2a51623c 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -536,7 +536,7 @@ static int ad7291_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad7291_id[] = {
-	{ "ad7291", 0 },
+	{ "ad7291" },
 	{}
 };
 
diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
index 859e4314cfa2..060651dd4130 100644
--- a/drivers/iio/adc/ltc2485.c
+++ b/drivers/iio/adc/ltc2485.c
@@ -124,7 +124,7 @@ static int ltc2485_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ltc2485_id[] = {
-	{ "ltc2485", 0 },
+	{ "ltc2485" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2485_id);
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index d9e1696df7ae..600151a62f1f 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -532,7 +532,7 @@ static int nau7802_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id nau7802_i2c_id[] = {
-	{ "nau7802", 0 },
+	{ "nau7802" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, nau7802_i2c_id);
diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index afdbd04778a8..4da78302359b 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -447,7 +447,7 @@ static int ads7924_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ads7924_id[] = {
-	{ "ads7924", 0 },
+	{ "ads7924" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ads7924_id);
diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 164facac5db6..4d605c2b9750 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -163,7 +163,7 @@ static int ams_iaqcore_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ams_iaqcore_id[] = {
-	{ "ams-iaq-core", 0 },
+	{ "ams-iaq-core" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ams_iaqcore_id);
diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 1c7076cf91ca..7c4224d75955 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -36,8 +36,8 @@ static int bme680_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bme680_i2c_id[] = {
-	{"bme680", 0},
-	{},
+	{ "bme680" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
 
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 87741f155c32..17d1bc518bf2 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -551,7 +551,7 @@ static void ccs811_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ccs811_id[] = {
-	{"ccs811", 0},
+	{ "ccs811" },
 	{	}
 };
 MODULE_DEVICE_TABLE(i2c, ccs811_id);
diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
index 5113f67ddc31..c449ca949465 100644
--- a/drivers/iio/dac/mcp4728.c
+++ b/drivers/iio/dac/mcp4728.c
@@ -591,7 +591,7 @@ static int mcp4728_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp4728_id[] = {
-	{ "mcp4728", 0 },
+	{ "mcp4728" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mcp4728_id);
diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 9c8e20c25e96..672d0b720f61 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -47,9 +47,9 @@ static const struct acpi_device_id bmg160_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
 
 static const struct i2c_device_id bmg160_i2c_id[] = {
-	{"bmg160", 0},
-	{"bmi055_gyro", 0},
-	{"bmi088_gyro", 0},
+	{ "bmg160" },
+	{ "bmi055_gyro" },
+	{ "bmi088_gyro" },
 	{}
 };
 
diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
index ee7f21b718e2..b1318a1ea41b 100644
--- a/drivers/iio/gyro/fxas21002c_i2c.c
+++ b/drivers/iio/gyro/fxas21002c_i2c.c
@@ -39,7 +39,7 @@ static void fxas21002c_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id fxas21002c_i2c_id[] = {
-	{ "fxas21002c", 0 },
+	{ "fxas21002c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, fxas21002c_i2c_id);
diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index 53fb92f0ac7e..cd8a2dae56cd 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -387,7 +387,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(itg3200_pm_ops, itg3200_suspend,
 				itg3200_resume);
 
 static const struct i2c_device_id itg3200_id[] = {
-	{ "itg3200", 0 },
+	{ "itg3200" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, itg3200_id);
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 7768b07ef7a6..390fbb6effaf 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -582,7 +582,7 @@ static int afe4404_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id afe4404_ids[] = {
-	{ "afe4404", 0 },
+	{ "afe4404" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, afe4404_ids);
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 6236b4d96137..1dc0df21450d 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -483,7 +483,7 @@ static void max30100_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max30100_id[] = {
-	{ "max30100", 0 },
+	{ "max30100" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, max30100_id);
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 37a35d1153d5..a56474be5dd2 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -253,7 +253,7 @@ static int am2315_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id am2315_i2c_id[] = {
-	{"am2315", 0},
+	{ "am2315" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 202014da2785..9b355380c9bf 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -396,12 +396,12 @@ static int hdc100x_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id hdc100x_id[] = {
-	{ "hdc100x", 0 },
-	{ "hdc1000", 0 },
-	{ "hdc1008", 0 },
-	{ "hdc1010", 0 },
-	{ "hdc1050", 0 },
-	{ "hdc1080", 0 },
+	{ "hdc100x" },
+	{ "hdc1000" },
+	{ "hdc1008" },
+	{ "hdc1010" },
+	{ "hdc1050" },
+	{ "hdc1080" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hdc100x_id);
diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
index 9465908cc65e..0797ece1fcba 100644
--- a/drivers/iio/humidity/si7005.c
+++ b/drivers/iio/humidity/si7005.c
@@ -163,8 +163,8 @@ static int si7005_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id si7005_id[] = {
-	{ "si7005", 0 },
-	{ "th02", 0 },
+	{ "si7005" },
+	{ "th02" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si7005_id);
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index fb1006649328..d34a915e3d4a 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -138,8 +138,8 @@ static int si7020_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id si7020_id[] = {
-	{ "si7020", 0 },
-	{ "th06", 0 },
+	{ "si7020" },
+	{ "th06" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si7020_id);
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index a081305254db..e79c46ab55db 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -37,7 +37,7 @@ static int bmi160_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bmi160_i2c_id[] = {
-	{"bmi160", 0},
+	{ "bmi160" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
index 6ecd750c6b76..cf3dd62a83ba 100644
--- a/drivers/iio/imu/bno055/bno055_i2c.c
+++ b/drivers/iio/imu/bno055/bno055_i2c.c
@@ -30,7 +30,7 @@ static int bno055_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bno055_i2c_id[] = {
-	{"bno055", 0},
+	{ "bno055" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bno055_i2c_id);
diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
index e99677ad96a2..2cc4a27a4527 100644
--- a/drivers/iio/imu/fxos8700_i2c.c
+++ b/drivers/iio/imu/fxos8700_i2c.c
@@ -36,7 +36,7 @@ static int fxos8700_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id fxos8700_i2c_id[] = {
-	{"fxos8700", 0},
+	{ "fxos8700" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, fxos8700_i2c_id);
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 7d3e061f3046..d37eca5ef761 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1505,7 +1505,7 @@ static const struct acpi_device_id kmx61_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, kmx61_acpi_match);
 
 static const struct i2c_device_id kmx61_id[] = {
-	{"kmx611021", 0},
+	{ "kmx611021" },
 	{}
 };
 
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 5fd775a20176..5169f12c3eba 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -261,7 +261,7 @@ static int adjd_s311_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adjd_s311_id[] = {
-	{ "adjd_s311", 0 },
+	{ "adjd_s311" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adjd_s311_id);
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index aa4a6c78f0aa..d4eb938c3bf5 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -821,7 +821,7 @@ static int adux1020_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adux1020_id[] = {
-	{ "adux1020", 0 },
+	{ "adux1020" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, adux1020_id);
diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 105f379b9b41..497ea3fe3377 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -236,7 +236,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend,
 				al3320a_resume);
 
 static const struct i2c_device_id al3320a_id[] = {
-	{"al3320a", 0},
+	{ "al3320a" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, al3320a_id);
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 0f978b30a232..11f2ab4ca261 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -493,7 +493,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend,
 				apds9300_resume);
 
 static const struct i2c_device_id apds9300_id[] = {
-	{ APDS9300_DRV_NAME, 0 },
+	{ APDS9300_DRV_NAME },
 	{ }
 };
 
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 1065a340b12b..e9e65130b6f9 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1107,7 +1107,7 @@ static const struct dev_pm_ops apds9960_pm_ops = {
 };
 
 static const struct i2c_device_id apds9960_id[] = {
-	{ "apds9960", 0 },
+	{ "apds9960" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, apds9960_id);
diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index b84166c5fa06..475f44954f61 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -256,8 +256,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(bh1780_dev_pm_ops, bh1780_runtime_suspend,
 				bh1780_runtime_resume, NULL);
 
 static const struct i2c_device_id bh1780_id[] = {
-	{ "bh1780", 0 },
-	{ },
+	{ "bh1780" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, bh1780_id);
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index d48a70efca69..b6288dd25bbf 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -368,7 +368,7 @@ static void cm3232_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id cm3232_id[] = {
-	{"cm3232", 0},
+	{ "cm3232" },
 	{}
 };
 
diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 35d20207a648..79a64e2ff812 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -250,7 +250,7 @@ static int cm3323_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id cm3323_id[] = {
-	{"cm3323", 0},
+	{ "cm3323" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, cm3323_id);
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 97e559acba2b..a4a1505534c0 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -713,7 +713,7 @@ static void cm36651_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id cm36651_id[] = {
-	{ "cm36651", 0 },
+	{ "cm36651" },
 	{ }
 };
 
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index fec10d5e037e..7125e011a38a 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -692,8 +692,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(gp2ap002_dev_pm_ops, gp2ap002_runtime_suspend,
 				 gp2ap002_runtime_resume, NULL);
 
 static const struct i2c_device_id gp2ap002_id_table[] = {
-	{ "gp2ap002", 0 },
-	{ },
+	{ "gp2ap002" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, gp2ap002_id_table);
 
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 9f41724819b6..c3b290bcf6ec 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1592,7 +1592,7 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id gp2ap020a00f_id[] = {
-	{ GP2A_I2C_NAME, 0 },
+	{ GP2A_I2C_NAME },
 	{ }
 };
 
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 5694683389be..95bfb3ffa519 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -678,8 +678,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(isl29028_pm_ops, isl29028_suspend,
 				 isl29028_resume, NULL);
 
 static const struct i2c_device_id isl29028_id[] = {
-	{"isl29028", 0},
-	{"isl29030", 0},
+	{ "isl29028" },
+	{ "isl29030" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index f1d3356d3369..59329546df58 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -327,7 +327,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(isl29125_pm_ops, isl29125_suspend,
 				isl29125_resume);
 
 static const struct i2c_device_id isl29125_id[] = {
-	{ "isl29125", 0 },
+	{ "isl29125" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl29125_id);
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 869196746045..e7ba934c8e69 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -429,7 +429,7 @@ static const struct acpi_device_id jsa1212_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
 
 static const struct i2c_device_id jsa1212_id[] = {
-	{ JSA1212_DRIVER_NAME, 0 },
+	{ JSA1212_DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, jsa1212_id);
diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
index a5445d58fddf..916109ec3217 100644
--- a/drivers/iio/light/lv0104cs.c
+++ b/drivers/iio/light/lv0104cs.c
@@ -510,7 +510,7 @@ static int lv0104cs_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lv0104cs_id[] = {
-	{ "lv0104cs", 0 },
+	{ "lv0104cs" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lv0104cs_id);
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 26b464b1b650..b935976871a6 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -598,7 +598,7 @@ static int max44000_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max44000_id[] = {
-	{"max44000", 0},
+	{ "max44000" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max44000_id);
diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 61ce276e86f7..3b92362675dc 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -534,7 +534,7 @@ static const struct of_device_id max44009_of_match[] = {
 MODULE_DEVICE_TABLE(of, max44009_of_match);
 
 static const struct i2c_device_id max44009_id[] = {
-	{ "max44009", 0 },
+	{ "max44009" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max44009_id);
diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index 1574310020e3..596cc48c4c34 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -268,7 +268,7 @@ static const struct of_device_id noa1305_of_match[] = {
 MODULE_DEVICE_TABLE(of, noa1305_of_match);
 
 static const struct i2c_device_id noa1305_ids[] = {
-	{ "noa1305", 0 },
+	{ "noa1305" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, noa1305_ids);
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index cb41e5ee8ec1..887c4b776a86 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -822,7 +822,7 @@ static void opt3001_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id opt3001_id[] = {
-	{ "opt3001", 0 },
+	{ "opt3001" },
 	{ } /* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(i2c, opt3001_id);
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 636432c45651..b920bf82c102 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -462,7 +462,7 @@ static const struct acpi_device_id pa12203001_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, pa12203001_acpi_match);
 
 static const struct i2c_device_id pa12203001_id[] = {
-		{ "txcpa122", 0 },
+		{ "txcpa122" },
 		{}
 };
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 40d5732b5e32..78c08e0bd077 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1109,7 +1109,7 @@ static const struct acpi_device_id rpr0521_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rpr0521_acpi_match);
 
 static const struct i2c_device_id rpr0521_id[] = {
-	{"rpr0521", 0},
+	{ "rpr0521" },
 	{ }
 };
 
diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index ea2c437199c0..eeff6cc792f2 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -1055,7 +1055,7 @@ static int si1133_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id si1133_ids[] = {
-	{ "si1133", 0 },
+	{ "si1133" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si1133_ids);
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 08d471438175..3a03823e488a 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -683,9 +683,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
 				stk3310_resume);
 
 static const struct i2c_device_id stk3310_i2c_id[] = {
-	{"STK3310", 0},
-	{"STK3311", 0},
-	{"STK3335", 0},
+	{ "STK3310" },
+	{ "STK3311" },
+	{ "STK3335" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index dcdd85b006be..c9566615b964 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -363,7 +363,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tcs3414_pm_ops, tcs3414_suspend,
 				tcs3414_resume);
 
 static const struct i2c_device_id tcs3414_id[] = {
-	{ "tcs3414", 0 },
+	{ "tcs3414" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tcs3414_id);
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 75fcf2c93717..89384dba83dd 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -599,7 +599,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend,
 				tcs3472_resume);
 
 static const struct i2c_device_id tcs3472_id[] = {
-	{ "tcs3472", 0 },
+	{ "tcs3472" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tcs3472_id);
diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 4da7d78906d4..a5788c09ad02 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -227,7 +227,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend,
 				tsl4531_resume);
 
 static const struct i2c_device_id tsl4531_id[] = {
-	{ "tsl4531", 0 },
+	{ "tsl4531" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl4531_id);
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 9189a1d4d7e1..de6967ac3b0b 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -955,7 +955,7 @@ static const struct acpi_device_id us5182d_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, us5182d_acpi_match);
 
 static const struct i2c_device_id us5182d_id[] = {
-	{ "usd5182", 0 },
+	{ "usd5182" },
 	{}
 };
 
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 56bbefbc0ae6..337a1332c2c6 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -653,7 +653,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(vcnl4035_pm_ops, vcnl4035_runtime_suspend,
 				 vcnl4035_runtime_resume, NULL);
 
 static const struct i2c_device_id vcnl4035_id[] = {
-	{ "vcnl4035", 0 },
+	{ "vcnl4035" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 043f233d9bdb..4be151308574 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -881,7 +881,7 @@ static const struct of_device_id veml6030_of_match[] = {
 MODULE_DEVICE_TABLE(of, veml6030_of_match);
 
 static const struct i2c_device_id veml6030_id[] = {
-	{ "veml6030", 0 },
+	{ "veml6030" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, veml6030_id);
diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index d99bf3ae0fe8..f8321d346d77 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -189,7 +189,7 @@ static void veml6070_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id veml6070_id[] = {
-	{ "veml6070", 0 },
+	{ "veml6070" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, veml6070_id);
diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index dcadf6428a87..a1b2b3c0b4c8 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -527,7 +527,7 @@ static const struct of_device_id vl6180_of_match[] = {
 MODULE_DEVICE_TABLE(of, vl6180_of_match);
 
 static const struct i2c_device_id vl6180_id[] = {
-	{ "vl6180", 0 },
+	{ "vl6180" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vl6180_id);
diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index d370193a4742..327f94e447af 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -545,7 +545,7 @@ static int zopt2201_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id zopt2201_id[] = {
-	{ "zopt2201", 0 },
+	{ "zopt2201" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, zopt2201_id);
diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
index 742bbdf25f08..d81d89af6283 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -505,7 +505,7 @@ static const struct of_device_id af8133j_of_match[] = {
 MODULE_DEVICE_TABLE(of, af8133j_of_match);
 
 static const struct i2c_device_id af8133j_id[] = {
-	{ "af8133j", 0 },
+	{ "af8133j" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, af8133j_id);
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index c74d11943ec7..d802034c5402 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -1025,10 +1025,10 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ak8974_dev_pm_ops, ak8974_runtime_suspend,
 				 ak8974_runtime_resume, NULL);
 
 static const struct i2c_device_id ak8974_id[] = {
-	{"ami305", 0 },
-	{"ami306", 0 },
-	{"ak8974", 0 },
-	{"hscdtd008a", 0 },
+	{ "ami305" },
+	{ "ami306" },
+	{ "ak8974" },
+	{ "hscdtd008a" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ak8974_id);
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index 48d9c698f520..a28d46d59875 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -47,9 +47,9 @@ static const struct acpi_device_id bmc150_magn_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
 
 static const struct i2c_device_id bmc150_magn_i2c_id[] = {
-	{"bmc150_magn",	0},
-	{"bmc156_magn", 0},
-	{"bmm150_magn", 0},
+	{ "bmc150_magn" },
+	{ "bmc156_magn" },
+	{ "bmm150_magn" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index deffe3ca9004..5295dc0100e4 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -624,7 +624,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag3110_suspend,
 				mag3110_resume);
 
 static const struct i2c_device_id mag3110_id[] = {
-	{ "mag3110", 0 },
+	{ "mag3110" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mag3110_id);
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 6b9f4b056191..c57932db455f 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -563,7 +563,7 @@ static const struct acpi_device_id mmc35240_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);
 
 static const struct i2c_device_id mmc35240_id[] = {
-	{"mmc35240", 0},
+	{ "mmc35240" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mmc35240_id);
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index bd0f2c3bf2f2..c2c6b2b29867 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -405,8 +405,8 @@ static const struct of_device_id lmp91000_of_match[] = {
 MODULE_DEVICE_TABLE(of, lmp91000_of_match);
 
 static const struct i2c_device_id lmp91000_id[] = {
-	{ "lmp91000", 0 },
-	{ "lmp91002", 0 },
+	{ "lmp91000" },
+	{ "lmp91002" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, lmp91000_id);
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 7d882e15e556..c6f44f0f4d2e 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -887,7 +887,7 @@ static int dps310_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id dps310_id[] = {
-	{ DPS310_DEV_NAME, 0 },
+	{ DPS310_DEV_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index 8bdb279129fa..6f7a16787143 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -266,8 +266,8 @@ static int hp03_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id hp03_id[] = {
-	{ "hp03", 0 },
-	{ },
+	{ "hp03" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hp03_id);
 
diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 2086f3ef338f..3e0bf5d31ad7 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -637,7 +637,7 @@ static const struct of_device_id icp10100_of_match[] = {
 MODULE_DEVICE_TABLE(of, icp10100_of_match);
 
 static const struct i2c_device_id icp10100_id[] = {
-	{ "icp10100", 0 },
+	{ "icp10100" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, icp10100_id);
diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
index fcbdadf4a511..0c51dc02478e 100644
--- a/drivers/iio/pressure/mpl115_i2c.c
+++ b/drivers/iio/pressure/mpl115_i2c.c
@@ -45,7 +45,7 @@ static int mpl115_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mpl115_i2c_id[] = {
-	{ "mpl115", 0 },
+	{ "mpl115" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mpl115_i2c_id);
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 7aa19584c340..71ded2eee060 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -318,7 +318,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend,
 				mpl3115_resume);
 
 static const struct i2c_device_id mpl3115_id[] = {
-	{ "mpl3115", 0 },
+	{ "mpl3115" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mpl3115_id);
diff --git a/drivers/iio/pressure/t5403.c b/drivers/iio/pressure/t5403.c
index a6463c06975e..c7cb0fd816d3 100644
--- a/drivers/iio/pressure/t5403.c
+++ b/drivers/iio/pressure/t5403.c
@@ -251,7 +251,7 @@ static int t5403_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id t5403_id[] = {
-	{ "t5403", 0 },
+	{ "t5403" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, t5403_id);
diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
index c7fffbe7c788..4833e525c393 100644
--- a/drivers/iio/pressure/zpa2326_i2c.c
+++ b/drivers/iio/pressure/zpa2326_i2c.c
@@ -59,8 +59,8 @@ static void zpa2326_remove_i2c(struct i2c_client *client)
 }
 
 static const struct i2c_device_id zpa2326_i2c_ids[] = {
-	{ "zpa2326", 0 },
-	{ },
+	{ "zpa2326" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, zpa2326_i2c_ids);
 
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 4982686fb4c3..dc66ca9bba6b 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -989,7 +989,7 @@ static int isl29501_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id isl29501_id[] = {
-	{"isl29501", 0},
+	{ "isl29501" },
 	{}
 };
 
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 2913d5e0fe4f..5c959730aecd 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -322,9 +322,9 @@ static void lidar_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lidar_id[] = {
-	{"lidar-lite-v2", 0},
-	{"lidar-lite-v3", 0},
-	{ },
+	{ "lidar-lite-v2" },
+	{ "lidar-lite-v3" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lidar_id);
 
diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index f02e83e3f15f..aff60a3c1a6f 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -308,7 +308,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend,
 				rfd77402_resume);
 
 static const struct i2c_device_id rfd77402_id[] = {
-	{ "rfd77402", 0 },
+	{ "rfd77402" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rfd77402_id);
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 550e7d3cd5ee..b89d49defd7a 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1043,8 +1043,8 @@ static const struct of_device_id sx9500_of_match[] = {
 MODULE_DEVICE_TABLE(of, sx9500_of_match);
 
 static const struct i2c_device_id sx9500_id[] = {
-	{"sx9500", 0},
-	{ },
+	{ "sx9500" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sx9500_id);
 
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 2cea64bea909..8d4f3f849fe2 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -278,7 +278,7 @@ static int vl53l0x_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id vl53l0x_id[] = {
-	{ "vl53l0x", 0 },
+	{ "vl53l0x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 8a57be108620..4676e0edde4a 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1279,7 +1279,7 @@ static int mlx90632_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mlx90632_id[] = {
-	{ "mlx90632", 0 },
+	{ "mlx90632" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mlx90632_id);
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 3a3904fe138c..6d8d661f0c82 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -280,7 +280,7 @@ static const struct of_device_id tmp006_of_match[] = {
 MODULE_DEVICE_TABLE(of, tmp006_of_match);
 
 static const struct i2c_device_id tmp006_id[] = {
-	{ "tmp006", 0 },
+	{ "tmp006" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp006_id);
diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index decef6896362..9bdfa9423492 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -563,7 +563,7 @@ static const struct of_device_id tmp007_of_match[] = {
 MODULE_DEVICE_TABLE(of, tmp007_of_match);
 
 static const struct i2c_device_id tmp007_id[] = {
-	{ "tmp007", 0 },
+	{ "tmp007" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp007_id);
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 53ef56fbfe1d..9213761c5d18 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -206,7 +206,7 @@ static int tsys01_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tsys01_id[] = {
-	{"tsys01", 0},
+	{ "tsys01" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tsys01_id);
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 6191db92ef9a..2b4959d6e467 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -168,7 +168,7 @@ static int tsys02d_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tsys02d_id[] = {
-	{"tsys02d", 0},
+	{ "tsys02d" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tsys02d_id);

base-commit: 93a39e4766083050ca0ecd6a3548093a3b9eb60c
-- 
2.43.0


