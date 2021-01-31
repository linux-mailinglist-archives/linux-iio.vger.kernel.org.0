Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B878C309D1B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 15:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhAaOmt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 09:42:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:11389 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232832AbhAaOkq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 09:40:46 -0500
IronPort-SDR: 4whJ+tet2BTmEGqB7BKN4iZjh7XGH3lAmKq0JuiOJGxKAEMKNFMqhZ1uCUNDLilVgm9e+W+mde
 RhANPHlNmyaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="244675635"
X-IronPort-AV: E=Sophos;i="5.79,390,1602572400"; 
   d="scan'208";a="244675635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 06:40:03 -0800
IronPort-SDR: MopmHMfv199gonZ3LrbVH6RXt0UVS9AvkJ2XOO1Lz17N7D5qMt0z+PlrxbbCDNJ0GRr548rp3Y
 42wqy2l2kylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,390,1602572400"; 
   d="scan'208";a="431805565"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2021 06:40:01 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 1/2] iio: hid-sensors: Move get sensitivity attribute to hid-sensor-common
Date:   Sun, 31 Jan 2021 22:40:57 +0800
Message-Id: <20210131144058.11834-2-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210131144058.11834-1-xiang.ye@intel.com>
References: <20210131144058.11834-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

No functional change has been made with this patch. The main intent here
is to reduce code repetition of getting sensitivity attribute.

In the current implementation, sensor_hub_input_get_attribute_info() is
called from multiple drivers to get attribute info for sensitivity
field. Moving this to common place will avoid code repetition.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 23 ++++++-------
 .../hid-sensors/hid-sensor-attributes.c       | 17 +++++++++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 19 ++++-------
 drivers/iio/humidity/hid-sensor-humidity.c    | 16 ++++------
 drivers/iio/light/hid-sensor-als.c            | 19 ++++-------
 drivers/iio/light/hid-sensor-prox.c           | 27 +++++-----------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 32 ++++++-------------
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 19 ++++-------
 drivers/iio/orientation/hid-sensor-rotation.c | 23 ++++++-------
 .../position/hid-sensor-custom-intel-hinge.c  | 20 ++++--------
 drivers/iio/pressure/hid-sensor-press.c       | 19 ++++-------
 .../iio/temperature/hid-sensor-temperature.c  | 16 ++++------
 drivers/rtc/rtc-hid-sensor-time.c             |  4 ++-
 include/linux/hid-sensor-hub.h                |  4 ++-
 14 files changed, 107 insertions(+), 151 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 5d63ed19e6e2..2f9465cb382f 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -43,6 +43,10 @@ static const u32 accel_3d_addresses[ACCEL_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_ACCEL_Z_AXIS
 };
 
+static const u32 accel_3d_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_ACCELERATION,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec accel_3d_channels[] = {
 	{
@@ -317,18 +321,6 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 				&st->accel[CHANNEL_SCAN_INDEX_X],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_ACCELERATION,
-			&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
-
 	return ret;
 }
 
@@ -366,8 +358,11 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		channel_size = sizeof(gravity_channels);
 		indio_dev->num_channels = ARRAY_SIZE(gravity_channels);
 	}
-	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
-					&accel_state->common_attributes);
+	ret = hid_sensor_parse_common_attributes(hsdev,
+						 hsdev->usage,
+						 &accel_state->common_attributes,
+						 accel_3d_sensitivity_addresses,
+						 ARRAY_SIZE(accel_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 5b822a4298a0..d349ace2e33f 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -448,12 +448,15 @@ EXPORT_SYMBOL(hid_sensor_batch_mode_supported);
 
 int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
-					struct hid_sensor_common *st)
+					struct hid_sensor_common *st,
+					const u32 *sensitivity_addresses,
+					u32 sensitivity_addresses_len)
 {
 
 	struct hid_sensor_hub_attribute_info timestamp;
 	s32 value;
 	int ret;
+	int i;
 
 	hid_sensor_get_reporting_interval(hsdev, usage_id, st);
 
@@ -475,6 +478,18 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
 			 &st->sensitivity);
 
+	/*
+	 * Set Sensitivity field ids, when there is no individual modifier, will
+	 * check absolute sensitivity of data field
+	 */
+	for (i = 0; i < sensitivity_addresses_len && st->sensitivity.index < 0; i++) {
+		sensor_hub_input_get_attribute_info(hsdev,
+				HID_FEATURE_REPORT, usage_id,
+				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+					sensitivity_addresses[i],
+				&st->sensitivity);
+	}
+
 	st->raw_hystersis = -1;
 
 	sensor_hub_input_get_attribute_info(hsdev,
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index fb0d678ece1a..dad26ee4fd1f 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -45,6 +45,10 @@ static const u32 gyro_3d_addresses[GYRO_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS
 };
 
+static const u32 gryo_3d_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_ANGL_VELOCITY,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec gyro_3d_channels[] = {
 	{
@@ -271,17 +275,6 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 				&st->gyro[CHANNEL_SCAN_INDEX_X],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_ANGL_VELOCITY,
-			&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
 	return ret;
 }
 
@@ -305,7 +298,9 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
 						HID_USAGE_SENSOR_GYRO_3D,
-						&gyro_state->common_attributes);
+						&gyro_state->common_attributes,
+						gryo_3d_sensitivity_addresses,
+						ARRAY_SIZE(gryo_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 52f605114ef7..ec88ae3f233d 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -22,6 +22,10 @@ struct hid_humidity_state {
 	int value_offset;
 };
 
+static const u32 humidity_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec humidity_channels[] = {
 	{
@@ -174,14 +178,6 @@ static int humidity_parse_report(struct platform_device *pdev,
 						&st->scale_pre_decml,
 						&st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0)
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
-			&st->common_attributes.sensitivity);
-
 	return ret;
 }
 
@@ -210,7 +206,9 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
 					HID_USAGE_SENSOR_HUMIDITY,
-					&humid_st->common_attributes);
+					&humid_st->common_attributes,
+					humidity_sensitivity_addresses,
+					ARRAY_SIZE(humidity_sensitivity_addresses));
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 4093f2353d95..8bf6e9e0a0e0 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -39,6 +39,10 @@ struct als_state {
 	s64 timestamp;
 };
 
+static const u32 als_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_LIGHT,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec als_channels[] = {
 	{
@@ -252,17 +256,6 @@ static int als_parse_report(struct platform_device *pdev,
 				&st->als_illum,
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_LIGHT,
-			&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
 	return ret;
 }
 
@@ -285,7 +278,9 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->common_attributes.pdev = pdev;
 
 	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_ALS,
-					&als_state->common_attributes);
+					&als_state->common_attributes,
+					als_sensitivity_addresses,
+					ARRAY_SIZE(als_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 330cf359e0b8..4ab285a418d5 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -25,6 +25,11 @@ struct prox_state {
 	u32 human_presence;
 };
 
+static const u32 prox_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_HUMAN_PRESENCE,
+	HID_USAGE_SENSOR_DATA_PRESENCE,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec prox_channels[] = {
 	{
@@ -216,24 +221,6 @@ static int prox_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
 			st->prox_attr.report_id);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_PRESENCE,
-			&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
-	if (st->common_attributes.sensitivity.index < 0)
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_HUMAN_PRESENCE,
-			&st->common_attributes.sensitivity);
-
 	return ret;
 }
 
@@ -257,7 +244,9 @@ static int hid_prox_probe(struct platform_device *pdev)
 	prox_state->common_attributes.pdev = pdev;
 
 	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_PROX,
-					&prox_state->common_attributes);
+					&prox_state->common_attributes,
+					prox_sensitivity_addresses,
+					ARRAY_SIZE(prox_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index fa48044b7f5b..b78691523dd4 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -62,6 +62,11 @@ static const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_TIME_TIMESTAMP,
 };
 
+static const u32 magn_3d_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_ORIENTATION,
+	HID_USAGE_SENSOR_ORIENT_MAGN_FLUX,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec magn_3d_channels[] = {
 	{
@@ -448,27 +453,6 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			&st->rot_attr.scale_pre_decml,
 			&st->rot_attr.scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->magn_flux_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_ORIENTATION,
-			&st->magn_flux_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->magn_flux_attributes.sensitivity.index,
-			st->magn_flux_attributes.sensitivity.report_id);
-	}
-	if (st->magn_flux_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_ORIENT_MAGN_FLUX,
-			&st->magn_flux_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->magn_flux_attributes.sensitivity.index,
-			st->magn_flux_attributes.sensitivity.report_id);
-	}
 	if (st->rot_attributes.sensitivity.index < 0) {
 		sensor_hub_input_get_attribute_info(hsdev,
 			HID_FEATURE_REPORT, usage_id,
@@ -507,12 +491,16 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
 				HID_USAGE_SENSOR_COMPASS_3D,
-				&magn_state->magn_flux_attributes);
+				&magn_state->magn_flux_attributes,
+				magn_3d_sensitivity_addresses,
+				ARRAY_SIZE(magn_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
 	}
 	magn_state->rot_attributes = magn_state->magn_flux_attributes;
+	/* sensitivity of rot_attribute is not the same as magn_flux_attributes */
+	magn_state->rot_attributes.sensitivity.index = -1;
 
 	ret = magn_3d_parse_report(pdev, hsdev,
 				&channels, &chan_count,
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 52ebef30f9be..6e69f6e673cc 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -47,6 +47,10 @@ static const u32 incl_3d_addresses[INCLI_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_ORIENT_TILT_Z
 };
 
+static const u32 incl_3d_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_ORIENTATION,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec incl_3d_channels[] = {
 	{
@@ -291,17 +295,6 @@ static int incl_3d_parse_report(struct platform_device *pdev,
 				&st->incl[CHANNEL_SCAN_INDEX_X],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_ORIENTATION,
-			&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
 	return ret;
 }
 
@@ -327,7 +320,9 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
 				HID_USAGE_SENSOR_INCLINOMETER_3D,
-				&incl_state->common_attributes);
+				&incl_state->common_attributes,
+				incl_3d_sensitivity_addresses,
+				ARRAY_SIZE(incl_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 18e4ef060096..03d2845a7b2c 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -31,6 +31,10 @@ struct dev_rot_state {
 	s64 timestamp;
 };
 
+static const u32 rotation_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_ORIENTATION,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec dev_rot_channels[] = {
 	{
@@ -214,18 +218,6 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 				&st->quaternion,
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_ORIENTATION,
-			&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
-
 	return 0;
 }
 
@@ -263,8 +255,11 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
-				&rot_state->common_attributes);
+	ret = hid_sensor_parse_common_attributes(hsdev,
+						 hsdev->usage,
+						 &rot_state->common_attributes,
+						 rotation_sensitivity_addresses,
+						 ARRAY_SIZE(rotation_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 64a7fa7db6af..fd77e7ee87f3 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -47,6 +47,10 @@ struct hinge_state {
 	u64 timestamp;
 };
 
+static const u32 hinge_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(1),
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec hinge_channels[] = {
 	{
@@ -251,18 +255,6 @@ static int hinge_parse_report(struct platform_device *pdev,
 			&st->hinge[CHANNEL_SCAN_INDEX_HINGE_ANGLE],
 			&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-				HID_FEATURE_REPORT, usage_id,
-				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-					HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(1),
-				&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
-
 	return ret;
 }
 
@@ -289,7 +281,9 @@ static int hid_hinge_probe(struct platform_device *pdev)
 		st->labels[i] = hinge_labels[i];
 
 	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
-						 &st->common_attributes);
+						 &st->common_attributes,
+						 hinge_sensitivity_addresses,
+						 ARRAY_SIZE(hinge_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5c458788f346..8cac2c94e75a 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -29,6 +29,10 @@ struct press_state {
 	int value_offset;
 };
 
+static const u32 press_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_ATMOSPHERIC_PRESSURE,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec press_channels[] = {
 	{
@@ -225,17 +229,6 @@ static int press_parse_report(struct platform_device *pdev,
 				&st->press_attr,
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_ATMOSPHERIC_PRESSURE,
-			&st->common_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-			st->common_attributes.sensitivity.index,
-			st->common_attributes.sensitivity.report_id);
-	}
 	return ret;
 }
 
@@ -260,7 +253,9 @@ static int hid_press_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
 					HID_USAGE_SENSOR_PRESSURE,
-					&press_state->common_attributes);
+					&press_state->common_attributes,
+					press_sensitivity_addresses,
+					ARRAY_SIZE(press_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 81688f1b932f..e3d38cbcf354 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -22,6 +22,10 @@ struct temperature_state {
 	int value_offset;
 };
 
+static const u32 temperature_sensitivity_addresses[] = {
+	HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE,
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec temperature_channels[] = {
 	{
@@ -171,14 +175,6 @@ static int temperature_parse_report(struct platform_device *pdev,
 				&st->temperature_attr,
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	/* Set Sensitivity field ids, when there is no individual modifier */
-	if (st->common_attributes.sensitivity.index < 0)
-		sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, usage_id,
-			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-			HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE,
-			&st->common_attributes.sensitivity);
-
 	return ret;
 }
 
@@ -207,7 +203,9 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
 					HID_USAGE_SENSOR_TEMPERATURE,
-					&temp_st->common_attributes);
+					&temp_st->common_attributes,
+					temperature_sensitivity_addresses,
+					ARRAY_SIZE(temperature_sensitivity_addresses));
 	if (ret)
 		return ret;
 
diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index 1b42ee0758d2..47cd12db2356 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -238,7 +238,9 @@ static int hid_time_probe(struct platform_device *pdev)
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
 				HID_USAGE_SENSOR_TIME,
-				&time_state->common_attributes);
+				&time_state->common_attributes,
+				NULL,
+				0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes!\n");
 		return ret;
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 46bcef380446..8b2599348554 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -247,7 +247,9 @@ static inline int hid_sensor_convert_exponent(int unit_expo)
 
 int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
-					struct hid_sensor_common *st);
+					struct hid_sensor_common *st,
+					const u32 *sensitivity_addresses,
+					u32 sensitivity_addresses_len);
 int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
 					int val1, int val2);
 int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
-- 
2.17.1

