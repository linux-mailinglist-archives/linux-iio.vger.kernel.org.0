Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB42EA5E6
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 08:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbhAEHV7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 02:21:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:49499 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbhAEHV7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 02:21:59 -0500
IronPort-SDR: 2Hy1NyMHIrBi62zgJ1ocCuTE7Tyaq03M5K9YFtkxMTTkz66OH0U+T2YkMOB16D6JYLEt7d1tv9
 S2y5A2nvCpzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="164137785"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="164137785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 23:21:03 -0800
IronPort-SDR: +hyeSHcF5QgVABrr0JvHXvOKyjVE0gitbCQdSXU/BjwLQC0YjvFGzKslGDupceTnipVB6E5/g1
 CD43JLbvNLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="350260620"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2021 23:21:02 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v3 5/6] iio: hid-sensor-incl-3d: Add timestamp channel
Date:   Tue,  5 Jan 2021 15:22:02 +0800
Message-Id: <20210105072203.5701-6-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105072203.5701-1-xiang.ye@intel.com>
References: <20210105072203.5701-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each sample has a timestamp field with this change. This timestamp may
be from the sensor hub when present or local kernel timestamp. And the
unit of timestamp is nanosecond.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 43 ++++++++++++--------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index df2fe91e8117..3baa52fbb426 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -24,15 +24,21 @@ enum incl_3d_channel {
 	INCLI_3D_CHANNEL_MAX,
 };
 
+#define CHANNEL_SCAN_INDEX_TIMESTAMP INCLI_3D_CHANNEL_MAX
+
 struct incl_3d_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info incl[INCLI_3D_CHANNEL_MAX];
-	u32 incl_val[INCLI_3D_CHANNEL_MAX];
+	struct {
+		u32 incl_val[INCLI_3D_CHANNEL_MAX];
+		u64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	s64 timestamp;
 };
 
 static const u32 incl_3d_addresses[INCLI_3D_CHANNEL_MAX] = {
@@ -81,7 +87,8 @@ static const struct iio_chan_spec incl_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP),
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -186,13 +193,6 @@ static const struct iio_info incl_3d_info = {
 	.write_raw = &incl_3d_write_raw,
 };
 
-/* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
-{
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, (u8 *)data);
-}
-
 /* Callback handler to send event after all samples are received and captured */
 static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -202,10 +202,16 @@ static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct incl_3d_state *incl_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "incl_3d_proc_event\n");
-	if (atomic_read(&incl_state->common_attributes.data_ready))
-		hid_sensor_push_data(indio_dev,
-				(u8 *)incl_state->incl_val,
-				sizeof(incl_state->incl_val));
+	if (atomic_read(&incl_state->common_attributes.data_ready)) {
+		if (!incl_state->timestamp)
+			incl_state->timestamp = iio_get_time_ns(indio_dev);
+
+		iio_push_to_buffers_with_timestamp(indio_dev,
+						   &incl_state->scan,
+						   incl_state->timestamp);
+
+		incl_state->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -222,13 +228,18 @@ static int incl_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 	switch (usage_id) {
 	case HID_USAGE_SENSOR_ORIENT_TILT_X:
-		incl_state->incl_val[CHANNEL_SCAN_INDEX_X] = *(u32 *)raw_data;
+		incl_state->scan.incl_val[CHANNEL_SCAN_INDEX_X] = *(u32 *)raw_data;
 	break;
 	case HID_USAGE_SENSOR_ORIENT_TILT_Y:
-		incl_state->incl_val[CHANNEL_SCAN_INDEX_Y] = *(u32 *)raw_data;
+		incl_state->scan.incl_val[CHANNEL_SCAN_INDEX_Y] = *(u32 *)raw_data;
 	break;
 	case HID_USAGE_SENSOR_ORIENT_TILT_Z:
-		incl_state->incl_val[CHANNEL_SCAN_INDEX_Z] = *(u32 *)raw_data;
+		incl_state->scan.incl_val[CHANNEL_SCAN_INDEX_Z] = *(u32 *)raw_data;
+	break;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		incl_state->timestamp =
+			hid_sensor_convert_timestamp(&incl_state->common_attributes,
+						     *(s64 *)raw_data);
 	break;
 	default:
 		ret = -EINVAL;
-- 
2.17.1

