Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC43DC2E2
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 05:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhGaDWg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 23:22:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:37975 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231395AbhGaDWf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Jul 2021 23:22:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="200408406"
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="200408406"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 20:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="439414699"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2021 20:22:27 -0700
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH] iio: hid-sensor-press: Add timestamp channel
Date:   Sat, 31 Jul 2021 11:25:56 +0800
Message-Id: <20210731032556.26813-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each sample has a timestamp field with this change. This timestamp may
be from the sensor hub when present or local kernel timestamp. The
unit of timestamp is nanosecond.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 40 +++++++++++++++----------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index c416d261e3e3..b365483bd09e 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -16,17 +16,24 @@
 #include <linux/iio/buffer.h>
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
-#define CHANNEL_SCAN_INDEX_PRESSURE 0
+enum {
+	CHANNEL_SCAN_INDEX_PRESSURE,
+	CHANNEL_SCAN_INDEX_TIMESTAMP,
+};
 
 struct press_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info press_attr;
-	u32 press_data;
+	struct {
+		u32 press_data;
+		u64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	s64 timestamp;
 };
 
 static const u32 press_sensitivity_addresses[] = {
@@ -44,7 +51,9 @@ static const struct iio_chan_spec press_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_PRESSURE,
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
+
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -157,14 +166,6 @@ static const struct iio_info press_info = {
 	.write_raw = &press_write_raw,
 };
 
-/* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
-					int len)
-{
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, data);
-}
-
 /* Callback handler to send event after all samples are received and captured */
 static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -174,10 +175,13 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct press_state *press_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "press_proc_event\n");
-	if (atomic_read(&press_state->common_attributes.data_ready))
-		hid_sensor_push_data(indio_dev,
-				&press_state->press_data,
-				sizeof(press_state->press_data));
+	if (atomic_read(&press_state->common_attributes.data_ready)) {
+		if (!press_state->timestamp)
+			press_state->timestamp = iio_get_time_ns(indio_dev);
+
+		iio_push_to_buffers_with_timestamp(
+			indio_dev, &press_state->scan, press_state->timestamp);
+	}
 
 	return 0;
 }
@@ -194,9 +198,13 @@ static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 	switch (usage_id) {
 	case HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE:
-		press_state->press_data = *(u32 *)raw_data;
+		press_state->scan.press_data = *(u32 *)raw_data;
 		ret = 0;
 		break;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		press_state->timestamp = hid_sensor_convert_timestamp(
+			&press_state->common_attributes, *(s64 *)raw_data);
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

