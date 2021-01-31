Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFEF309D52
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhAaOvd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 09:51:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:11395 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhAaOku (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 09:40:50 -0500
IronPort-SDR: i+v9E0vsmAhBpfTlzkz+E3bZ69AKBXQfByTo5PxgkM1Bry6KouEEG5mmPiHLYfnbevBowZ0Y6a
 ZxiK8i+udykQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="244675639"
X-IronPort-AV: E=Sophos;i="5.79,390,1602572400"; 
   d="scan'208";a="244675639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 06:40:07 -0800
IronPort-SDR: 2BzTl4yV3ce3XbGMPmFobsSpVYbBZKOsAiWyV/UFFFGA9m5s3cF5/WgaHJjnUQLXxdpLi1ymBo
 wHYXNLhxEHzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,390,1602572400"; 
   d="scan'208";a="431805589"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2021 06:40:05 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 2/2] hid-sensors: Add more data fields for sensitivity checking
Date:   Sun, 31 Jan 2021 22:40:58 +0800
Message-Id: <20210131144058.11834-3-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210131144058.11834-1-xiang.ye@intel.com>
References: <20210131144058.11834-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before, when reading/writing the hysteresis of als, incli-3d, press, and
rotation sensor, we will get invalid argument error.

This patch add more sensitivity data fields for these sensors, so that
these sensors can get sensitivity index and return correct hysteresis
value.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/light/hid-sensor-als.c            | 1 +
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 1 +
 drivers/iio/orientation/hid-sensor-rotation.c | 1 +
 drivers/iio/pressure/hid-sensor-press.c       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 8bf6e9e0a0e0..afcdb424bfb8 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -41,6 +41,7 @@ struct als_state {
 
 static const u32 als_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_LIGHT,
+	HID_USAGE_SENSOR_LIGHT_ILLUM,
 };
 
 /* Channel definitions */
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 6e69f6e673cc..7af48d336285 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -49,6 +49,7 @@ static const u32 incl_3d_addresses[INCLI_3D_CHANNEL_MAX] = {
 
 static const u32 incl_3d_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_ORIENTATION,
+	HID_USAGE_SENSOR_ORIENT_TILT,
 };
 
 /* Channel definitions */
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 03d2845a7b2c..b0245b3b7ffc 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -33,6 +33,7 @@ struct dev_rot_state {
 
 static const u32 rotation_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_ORIENTATION,
+	HID_USAGE_SENSOR_ORIENT_QUATERNION,
 };
 
 /* Channel definitions */
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 8cac2c94e75a..c416d261e3e3 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -31,6 +31,7 @@ struct press_state {
 
 static const u32 press_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_ATMOSPHERIC_PRESSURE,
+	HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE
 };
 
 /* Channel definitions */
-- 
2.17.1

