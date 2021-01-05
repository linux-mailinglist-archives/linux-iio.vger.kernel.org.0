Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1A2EA7AD
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 10:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbhAEJe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 04:34:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:51522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbhAEJe6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 04:34:58 -0500
IronPort-SDR: I3QepB09Bl0i9b/SDeD9mqOyFqqzJcsUGAbV1jnKG/7xm/9aZeXJnkvMUC4r39WAiI7UfPra6i
 V8R0KF4kkwuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156864089"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156864089"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:34:10 -0800
IronPort-SDR: A4v6glU6sqRp/Iox4CIhTC7Qdp/0HOMWvEQT3YzPEcWDtKXBnR5S+GaZlNyvmTBNHhvkiF31xS
 B338BpenEg0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="569665165"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2021 01:34:08 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 4/6] iio: hid-sensor-magn-3d: Add timestamp channel
Date:   Tue,  5 Jan 2021 17:35:13 +0800
Message-Id: <20210105093515.19135-5-xiang.ye@intel.com>
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 48 ++++++++++++-------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index cacbd053b2c6..b79c8a5a98f9 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -24,6 +24,7 @@ enum magn_3d_channel {
 	CHANNEL_SCAN_INDEX_NORTH_TRUE_TILT_COMP,
 	CHANNEL_SCAN_INDEX_NORTH_MAGN,
 	CHANNEL_SCAN_INDEX_NORTH_TRUE,
+	CHANNEL_SCAN_INDEX_TIMESTAMP,
 	MAGN_3D_CHANNEL_MAX,
 };
 
@@ -47,6 +48,7 @@ struct magn_3d_state {
 
 	struct common_attributes magn_flux_attr;
 	struct common_attributes rot_attr;
+	s64 timestamp;
 };
 
 static const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
@@ -57,6 +59,7 @@ static const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_ORIENT_COMP_TRUE_NORTH,
 	HID_USAGE_SENSOR_ORIENT_MAGN_NORTH,
 	HID_USAGE_SENSOR_ORIENT_TRUE_NORTH,
+	HID_USAGE_SENSOR_TIME_TIMESTAMP,
 };
 
 static const u32 magn_3d_sensitivity_addresses[] = {
@@ -132,7 +135,8 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -281,13 +285,6 @@ static const struct iio_info magn_3d_info = {
 	.write_raw = &magn_3d_write_raw,
 };
 
-/* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data)
-{
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, data);
-}
-
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -297,8 +294,15 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "magn_3d_proc_event\n");
-	if (atomic_read(&magn_state->magn_flux_attributes.data_ready))
-		hid_sensor_push_data(indio_dev, magn_state->iio_vals);
+	if (atomic_read(&magn_state->magn_flux_attributes.data_ready)) {
+		if (!magn_state->timestamp)
+			magn_state->timestamp = iio_get_time_ns(indio_dev);
+
+		iio_push_to_buffers_with_timestamp(indio_dev,
+						   magn_state->iio_vals,
+						   magn_state->timestamp);
+		magn_state->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -329,6 +333,11 @@ static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 		offset = (usage_id - HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH)
 				+ CHANNEL_SCAN_INDEX_NORTH_MAGN_TILT_COMP;
 	break;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		magn_state->timestamp =
+			hid_sensor_convert_timestamp(&magn_state->magn_flux_attributes,
+						     *(s64 *)raw_data);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -394,9 +403,10 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	st->iio_vals = devm_kcalloc(&pdev->dev, attr_count,
-				sizeof(u32),
-				GFP_KERNEL);
+	/* attr_count include timestamp channel, and the iio_vals should be aligned to 8byte */
+	st->iio_vals = devm_kcalloc(&pdev->dev,
+				    ((attr_count + 1) % 2 + (attr_count + 1) / 2) * 2,
+				    sizeof(u32), GFP_KERNEL);
 	if (!st->iio_vals) {
 		dev_err(&pdev->dev,
 			"failed to allocate space for iio values array\n");
@@ -412,11 +422,13 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			(_channels[*chan_count]).scan_index = *chan_count;
 			(_channels[*chan_count]).address = i;
 
-			/* Set magn_val_addr to iio value address */
-			st->magn_val_addr[i] = &(st->iio_vals[*chan_count]);
-			magn_3d_adjust_channel_bit_mask(_channels,
-							*chan_count,
-							st->magn[i].size);
+			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
+				/* Set magn_val_addr to iio value address */
+				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
+				magn_3d_adjust_channel_bit_mask(_channels,
+								*chan_count,
+								st->magn[i].size);
+			}
 			(*chan_count)++;
 		}
 	}
-- 
2.17.1

