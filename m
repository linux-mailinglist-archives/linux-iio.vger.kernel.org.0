Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE455A463
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 00:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiFXWdt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jun 2022 18:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFXWds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2022 18:33:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631852E55
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2022 15:33:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id r1so3234504plo.10
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2022 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOxyiidE0XayyRLxJup7Yrx0Xq1SxWMLzDy5htdSrjE=;
        b=BSDcY6WTpEnFqSjFJ+C2Z2dsOkp4FXI0BdP0y2+exv+ZBEud5/x4SUBhtc5hKvDmRY
         T5AQQ826Miq2pNsUQILn5Lio8cb9A4UzFDUEr8YGE0oYlLg4GHDKWJ/jLpCaRuRKOvRf
         JXQHrO8jshxWCGSQVRhDaXVBnKSI2jxoS7I5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOxyiidE0XayyRLxJup7Yrx0Xq1SxWMLzDy5htdSrjE=;
        b=zs/VX80UwWSS3mQLJknq/tn5KIIQJ+koInC49jlghy9JKAr3+lrBF42I/utrgypd6c
         91VgeySqCoRApbXgO4OaqWRf4kASl2tNdAwbwQWvxiwK8owZ9fCk26CXW3paf7O0Kx2x
         8ECB06riAYGxoLOZIy212ng1tdqWTOPWOqh7PeH/DH0CryBibKlcmRJB3+kPA7MlNQuG
         amd7cwOEx5AtT8yNKiJFD7F1awbJXhSWTrUa2VOcuya31loyY6B4hFKYE7jyyy2XrK16
         iesXDEDPqy9FGNgcRnrHUL2ZSGaj5TIwuo9ujSfRaVRY8CoeoNMO2ErLku/3ZcutipWX
         Pikw==
X-Gm-Message-State: AJIora/WDwdablOz/DA1gP5qpsV05nZTLazmwll5SqiT8UqUAmKzsD3k
        cDMFid2b/5q82QFPG7j7F8YgOzuQiTwJOw==
X-Google-Smtp-Source: AGRyM1uU2HLunXbWofJSjVg8IZTUXIpUiKSl0F2h6Vki2x5V6PRtL8thKbpIfuPhO1faR6Z95/fItw==
X-Received: by 2002:a17:902:d2c1:b0:16a:4028:4748 with SMTP id n1-20020a170902d2c100b0016a40284748mr1381070plc.37.1656110026727;
        Fri, 24 Jun 2022 15:33:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7851:19cd:de16:eb4d])
        by smtp.gmail.com with UTF8SMTPSA id iy11-20020a170903130b00b0016a4a2ea92asm2288382plb.255.2022.06.24.15.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 15:33:46 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com, wpsmith@google.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio/hid: Add mount_matrix
Date:   Fri, 24 Jun 2022 15:33:41 -0700
Message-Id: <20220624223341.2625231-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ISH based sensors do not naturally return data in the W3C 'natural'
orientation.
They returns all data inverted, to match Microsoft Windows requirement:
[https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sensors#accelerometer]
""" If the device has the SimpleOrientation of FaceUp on a table, then
the accelerometer would read -1 G on the Z axis. """
While W3C defines [https://www.w3.org/TR/motion-sensors/#accelerometer-sensor]
"""The Accelerometer sensor is an inertial-frame sensor, this means that
when the device is in free fall, the acceleration is 0 m/s2 in the
falling direction, and when a device is laying flat on a table, the
acceleration in upwards direction will be equal to the Earth gravity,
i.e. g ≡ 9.8 m/s2 as it is measuring the force of the table pushing the
device upwards."""

Fixes all HID sensors that defines IIO_MOD_[XYZ] attributes.

Tested on "HP Spectre x360 Convertible 13" and "Dell XPS 13 9365".

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       |  3 +++
 .../hid-sensors/hid-sensor-attributes.c       | 21 +++++++++++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 +++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 +++
 include/linux/hid-sensor-hub.h                |  2 ++
 5 files changed, 32 insertions(+)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index a2def6f9380a3..980bbd7fba502 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -59,6 +59,7 @@ static const struct iio_chan_spec accel_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_X,
+		.ext_info = hid_sensor_ext_info,
 	}, {
 		.type = IIO_ACCEL,
 		.modified = 1,
@@ -69,6 +70,7 @@ static const struct iio_chan_spec accel_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
+		.ext_info = hid_sensor_ext_info,
 	}, {
 		.type = IIO_ACCEL,
 		.modified = 1,
@@ -79,6 +81,7 @@ static const struct iio_chan_spec accel_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
+		.ext_info = hid_sensor_ext_info,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 9b279937a24e0..e367e4b482ef0 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -585,6 +585,27 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 }
 EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, IIO_HID);
 
+static const struct iio_mount_matrix hid_sensor_windows_axis = {
+	.rotation = {
+		"-1", "0", "0",
+		"0", "-1", "0",
+		"0", "0", "-1"
+	}
+};
+
+static const struct iio_mount_matrix *
+hid_sensor_get_mount_matrix(const struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan)
+{
+	return &hid_sensor_windows_axis;
+}
+
+const struct iio_chan_spec_ext_info hid_sensor_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, hid_sensor_get_mount_matrix),
+	{ }
+};
+EXPORT_SYMBOL(hid_sensor_ext_info);
+
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
 MODULE_DESCRIPTION("HID Sensor common attribute processing");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 8f0ad022c7f1b..b852f5166bb21 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -58,6 +58,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_X,
+		.ext_info = hid_sensor_ext_info,
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
@@ -68,6 +69,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
+		.ext_info = hid_sensor_ext_info,
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
@@ -78,6 +80,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
+		.ext_info = hid_sensor_ext_info,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index e85a3a8eea908..aefbdb9b0869a 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -74,6 +74,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.ext_info = hid_sensor_ext_info,
 	}, {
 		.type = IIO_MAGN,
 		.modified = 1,
@@ -83,6 +84,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.ext_info = hid_sensor_ext_info,
 	}, {
 		.type = IIO_MAGN,
 		.modified = 1,
@@ -92,6 +94,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.ext_info = hid_sensor_ext_info,
 	}, {
 		.type = IIO_ROT,
 		.modified = 1,
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index c27329e2a5ad5..ee7d5b430a785 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -236,6 +236,8 @@ struct hid_sensor_common {
 	struct work_struct work;
 };
 
+extern const struct iio_chan_spec_ext_info hid_sensor_ext_info[];
+
 /* Convert from hid unit expo to regular exponent */
 static inline int hid_sensor_convert_exponent(int unit_expo)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

