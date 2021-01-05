Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF742EA5E5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 08:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbhAEHVq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 02:21:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:49501 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbhAEHVp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 02:21:45 -0500
IronPort-SDR: AaMh5CMnFBnQSQO9qqffboEagMfg+hGVpYcokuA7DoO00tjATFdMVY7x0LY7Vhy0kHoHqI85tG
 ZpwA2QUeEHpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="164137782"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="164137782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 23:21:01 -0800
IronPort-SDR: c9G3Tl8CzmSYMiHQcMuFxByijgo0MsVL4Sry5pPXXOLDzyosBcuG+62zOYNUTVBUpG8vDUU4tb
 UshFi+NJU96Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="350260567"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2021 23:20:54 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v3 2/6] iio: hid-sensor-gyro-3d: Add timestamp channel
Date:   Tue,  5 Jan 2021 15:21:59 +0800
Message-Id: <20210105072203.5701-3-xiang.ye@intel.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 40 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c817d91b3b51..37c7ac0ad32b 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -23,15 +23,20 @@ enum gyro_3d_channel {
 	GYRO_3D_CHANNEL_MAX,
 };
 
+#define CHANNEL_SCAN_INDEX_TIMESTAMP GYRO_3D_CHANNEL_MAX
 struct gyro_3d_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info gyro[GYRO_3D_CHANNEL_MAX];
-	u32 gyro_val[GYRO_3D_CHANNEL_MAX];
+	struct {
+		u32 gyro_val[GYRO_3D_CHANNEL_MAX];
+		u64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	s64 timestamp;
 };
 
 static const u32 gyro_3d_addresses[GYRO_3D_CHANNEL_MAX] = {
@@ -79,7 +84,8 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -185,14 +191,6 @@ static const struct iio_info gyro_3d_info = {
 	.write_raw = &gyro_3d_write_raw,
 };
 
-/* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
-	int len)
-{
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, data);
-}
-
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -202,10 +200,15 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "gyro_3d_proc_event\n");
-	if (atomic_read(&gyro_state->common_attributes.data_ready))
-		hid_sensor_push_data(indio_dev,
-				gyro_state->gyro_val,
-				sizeof(gyro_state->gyro_val));
+	if (atomic_read(&gyro_state->common_attributes.data_ready)) {
+		if (!gyro_state->timestamp)
+			gyro_state->timestamp = iio_get_time_ns(indio_dev);
+
+		iio_push_to_buffers_with_timestamp(indio_dev, &gyro_state->scan,
+						   gyro_state->timestamp);
+
+		gyro_state->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -226,10 +229,15 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case HID_USAGE_SENSOR_ANGL_VELOCITY_Y_AXIS:
 	case HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS:
 		offset = usage_id - HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS;
-		gyro_state->gyro_val[CHANNEL_SCAN_INDEX_X + offset] =
-						*(u32 *)raw_data;
+		gyro_state->scan.gyro_val[CHANNEL_SCAN_INDEX_X + offset] =
+				*(u32 *)raw_data;
 		ret = 0;
 	break;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		gyro_state->timestamp =
+			hid_sensor_convert_timestamp(&gyro_state->common_attributes,
+						     *(s64 *)raw_data);
+	break;
 	default:
 		break;
 	}
-- 
2.17.1

