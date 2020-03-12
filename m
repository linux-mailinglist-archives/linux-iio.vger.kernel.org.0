Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9F183012
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 13:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLMTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 08:19:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:31146 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgCLMTn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 08:19:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 05:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="415915768"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 05:19:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8094A234; Thu, 12 Mar 2020 14:19:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] iio: st_sensors: Drop unneeded explicit castings
Date:   Thu, 12 Mar 2020 14:19:36 +0200
Message-Id: <20200312121938.45608-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312121938.45608-1-andriy.shevchenko@linux.intel.com>
References: <20200312121938.45608-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/accel/st_accel_buffer.c     | 3 +--
 drivers/iio/gyro/st_gyro_buffer.c       | 3 +--
 drivers/iio/gyro/st_gyro_core.c         | 9 +++++----
 drivers/iio/pressure/st_pressure_core.c | 4 +---
 4 files changed, 8 insertions(+), 11 deletions(-)

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

