Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC912EA7B5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbhAEJfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 04:35:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:51517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbhAEJfL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 04:35:11 -0500
IronPort-SDR: FTVBKLBiFPlr4X3pFTV6W0XCD5ttzSthT7xiBxftPQyMsslaii9JEJgWxnrf9IbQwcSePATmx6
 CJBSCYgY3S3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156864101"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156864101"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:34:15 -0800
IronPort-SDR: Q9PolnMbw6qWmNGPTsXyTZCh0/LqSeTD7l8tWk5VSeg289HhseqCxMN1VcQteUTVr6rngkeAdm
 4B3at3xF1lpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="569665187"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2021 01:34:13 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 6/6] iio: hid-sensor-rotation: Add timestamp channel
Date:   Tue,  5 Jan 2021 17:35:15 +0800
Message-Id: <20210105093515.19135-7-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105093515.19135-1-xiang.ye@intel.com>
References: <20210105093515.19135-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each sample has a timestamp field with this change. This timestamp may
be from the sensor hub when present or local kernel timestamp. And the
unit of timestamp is nanosecond.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 46 +++++++++++--------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 665ccf3673cc..b0245b3b7ffc 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -20,11 +20,15 @@ struct dev_rot_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info quaternion;
-	u32 sampled_vals[4];
+	struct {
+		u32 sampled_vals[4] __aligned(16);
+		u64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	s64 timestamp;
 };
 
 static const u32 rotation_sensitivity_addresses[] = {
@@ -42,8 +46,10 @@ static const struct iio_chan_spec dev_rot_channels[] = {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					BIT(IIO_CHAN_INFO_OFFSET) |
 					BIT(IIO_CHAN_INFO_SCALE) |
-					BIT(IIO_CHAN_INFO_HYSTERESIS)
-	}
+					BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.scan_index = 0
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1)
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -75,7 +81,7 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (size >= 4) {
 			for (i = 0; i < 4; ++i)
-				vals[i] = rot_state->sampled_vals[i];
+				vals[i] = rot_state->scan.sampled_vals[i];
 			ret_type = IIO_VAL_INT_MULTIPLE;
 			*val_len =  4;
 		} else
@@ -137,15 +143,6 @@ static const struct iio_info dev_rot_info = {
 	.write_raw = &dev_rot_write_raw,
 };
 
-/* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
-{
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data >>\n");
-	iio_push_to_buffers(indio_dev, (u8 *)data);
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data <<\n");
-
-}
-
 /* Callback handler to send event after all samples are received and captured */
 static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -155,10 +152,15 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct dev_rot_state *rot_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "dev_rot_proc_event\n");
-	if (atomic_read(&rot_state->common_attributes.data_ready))
-		hid_sensor_push_data(indio_dev,
-				(u8 *)rot_state->sampled_vals,
-				sizeof(rot_state->sampled_vals));
+	if (atomic_read(&rot_state->common_attributes.data_ready)) {
+		if (!rot_state->timestamp)
+			rot_state->timestamp = iio_get_time_ns(indio_dev);
+
+		iio_push_to_buffers_with_timestamp(indio_dev, &rot_state->scan,
+						   rot_state->timestamp);
+
+		rot_state->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -173,10 +175,14 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
 	struct dev_rot_state *rot_state = iio_priv(indio_dev);
 
 	if (usage_id == HID_USAGE_SENSOR_ORIENT_QUATERNION) {
-		memcpy(rot_state->sampled_vals, raw_data,
-					sizeof(rot_state->sampled_vals));
+		memcpy(&rot_state->scan.sampled_vals, raw_data,
+		       sizeof(rot_state->scan.sampled_vals));
+
 		dev_dbg(&indio_dev->dev, "Recd Quat len:%zu::%zu\n", raw_len,
-					sizeof(rot_state->sampled_vals));
+			sizeof(rot_state->scan.sampled_vals));
+	} else if (usage_id == HID_USAGE_SENSOR_TIME_TIMESTAMP) {
+		rot_state->timestamp = hid_sensor_convert_timestamp(&rot_state->common_attributes,
+								    *(s64 *)raw_data);
 	}
 
 	return 0;
-- 
2.17.1

