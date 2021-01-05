Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECC2EA7AA
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbhAEJe4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 04:34:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:51517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbhAEJez (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 04:34:55 -0500
IronPort-SDR: 9kbVifhrAdykXO2or9bj5Qf+Maj7cVgkutUFvoBj0UvF1p1JgPXNXbmeklaoBJWX9+iBc9cbDb
 5ai/PEa/ds7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156864080"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156864080"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:34:07 -0800
IronPort-SDR: vs7eGC1ODWxJRsImJyrQAWrg4X9hHiiujFcvVPfSsAHWDnA8sL4pPK0Dz00qzSd+cD/2HAKpRq
 Im1T7HhgJlJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="569665158"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2021 01:34:05 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 3/6] iio: hid-sensor-als: Add timestamp channel
Date:   Tue,  5 Jan 2021 17:35:12 +0800
Message-Id: <20210105093515.19135-4-xiang.ye@intel.com>
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
 drivers/iio/light/hid-sensor-als.c | 39 ++++++++++++++++++------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 5460a744dbd0..afcdb424bfb8 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -22,15 +22,21 @@ enum {
 	CHANNEL_SCAN_INDEX_MAX
 };
 
+#define CHANNEL_SCAN_INDEX_TIMESTAMP CHANNEL_SCAN_INDEX_MAX
+
 struct als_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info als_illum;
-	u32 illum[CHANNEL_SCAN_INDEX_MAX];
+	struct {
+		u32 illum[CHANNEL_SCAN_INDEX_MAX];
+		u64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	s64 timestamp;
 };
 
 static const u32 als_sensitivity_addresses[] = {
@@ -59,7 +65,8 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -173,14 +180,6 @@ static const struct iio_info als_info = {
 	.write_raw = &als_write_raw,
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
 static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -190,10 +189,14 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct als_state *als_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "als_proc_event\n");
-	if (atomic_read(&als_state->common_attributes.data_ready))
-		hid_sensor_push_data(indio_dev,
-				&als_state->illum,
-				sizeof(als_state->illum));
+	if (atomic_read(&als_state->common_attributes.data_ready)) {
+		if (!als_state->timestamp)
+			als_state->timestamp = iio_get_time_ns(indio_dev);
+
+		iio_push_to_buffers_with_timestamp(indio_dev, &als_state->scan,
+						   als_state->timestamp);
+		als_state->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -211,10 +214,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 	switch (usage_id) {
 	case HID_USAGE_SENSOR_LIGHT_ILLUM:
-		als_state->illum[CHANNEL_SCAN_INDEX_INTENSITY] = sample_data;
-		als_state->illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_INTENSITY] = sample_data;
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
 		ret = 0;
 		break;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
+								    *(s64 *)raw_data);
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

