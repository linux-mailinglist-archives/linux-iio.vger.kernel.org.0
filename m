Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA4184539
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCMKuA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 06:50:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:21832 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgCMKuA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 06:50:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="444269157"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2020 03:49:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BC4A1352; Fri, 13 Mar 2020 12:49:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/8] iio: st_sensors: Drop unneeded explicit castings
Date:   Fri, 13 Mar 2020 12:49:50 +0200
Message-Id: <20200313104955.30423-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In few places the unnecessary explicit castings are being used.
Drop them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: more conversions to cast-less approach
 drivers/iio/accel/st_accel_buffer.c             | 3 +--
 drivers/iio/accel/st_accel_core.c               | 3 +--
 drivers/iio/common/st_sensors/st_sensors_core.c | 3 +--
 drivers/iio/gyro/st_gyro_buffer.c               | 3 +--
 drivers/iio/gyro/st_gyro_core.c                 | 9 +++++----
 drivers/iio/magnetometer/st_magn_core.c         | 3 +--
 drivers/iio/pressure/st_pressure_core.c         | 4 +---
 7 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 9f2b40474b8e..b5c814ef1637 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -37,8 +37,7 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		return err;
 
-	err = st_sensors_set_axis_enable(indio_dev,
-					 (u8)indio_dev->active_scan_mask[0]);
+	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
 	if (err < 0)
 		goto st_accel_buffer_predisable;
 
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 5f7bdb1f55d1..e2ec5d127495 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1203,8 +1203,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 			 "failed to apply ACPI orientation data: %d\n", err);
 
 	indio_dev->channels = channels;
-	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
-					&adata->sensor_settings->fs.fs_avl[0];
+	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
 	if (!pdata)
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index e051edbc43c1..804a9068e687 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -150,8 +150,7 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 	if (err < 0)
 		goto st_accel_set_fullscale_error;
 
-	sdata->current_fullscale = (struct st_sensor_fullscale_avl *)
-					&sdata->sensor_settings->fs.fs_avl[i];
+	sdata->current_fullscale = &sdata->sensor_settings->fs.fs_avl[i];
 	return err;
 
 st_accel_set_fullscale_error:
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 7465ad62391c..9c92ff7a82be 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -37,8 +37,7 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		return err;
 
-	err = st_sensors_set_axis_enable(indio_dev,
-					 (u8)indio_dev->active_scan_mask[0]);
+	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
 	if (err < 0)
 		goto st_gyro_buffer_predisable;
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 26c50b24bc08..c8aa051995d3 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -460,6 +460,7 @@ EXPORT_SYMBOL(st_gyro_get_settings);
 int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -477,12 +478,12 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = gdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
-	gdata->current_fullscale = (struct st_sensor_fullscale_avl *)
-					&gdata->sensor_settings->fs.fs_avl[0];
+	gdata->current_fullscale = &gdata->sensor_settings->fs.fs_avl[0];
 	gdata->odr = gdata->sensor_settings->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	pdata = (struct st_sensors_platform_data *)&gyro_pdata;
+
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_gyro_power_off;
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index e68184a93a6d..79de721e6015 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -506,8 +506,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = mdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
-	mdata->current_fullscale = (struct st_sensor_fullscale_avl *)
-					&mdata->sensor_settings->fs.fs_avl[0];
+	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
 	err = st_sensors_init_sensor(indio_dev, NULL);
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 8bb47c3b4d6b..789a2928504a 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -707,9 +707,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = press_data->sensor_settings->ch;
 	indio_dev->num_channels = press_data->sensor_settings->num_ch;
 
-	press_data->current_fullscale =
-		(struct st_sensor_fullscale_avl *)
-			&press_data->sensor_settings->fs.fs_avl[0];
+	press_data->current_fullscale = &press_data->sensor_settings->fs.fs_avl[0];
 
 	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
 
-- 
2.25.1

