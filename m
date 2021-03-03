Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998BA32C6C0
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhCDA35 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:29:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:50147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1841823AbhCCGi3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Mar 2021 01:38:29 -0500
IronPort-SDR: QupRfpN9oBzzs6zVIuboLXDxDoZMdk2mqvHukpoBsDxq6zthxHviWdMYu5UUnLmncnlofHcucd
 aPcxtno4UaWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167012902"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="167012902"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:36:02 -0800
IronPort-SDR: 1NxdKoDzUvWwhEtx/0uVwLiNyEaT+4EYDyHqLUGY+iyA3yPB99tpZj9MxZPd8Wxtw9MltYeL8D
 Uh+pPZQ5bibA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383870919"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2021 22:36:00 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 3/4] iio: hid-sensor-temperature: Fix issues of timestamp channel
Date:   Wed,  3 Mar 2021 14:36:14 +0800
Message-Id: <20210303063615.12130-4-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210303063615.12130-1-xiang.ye@intel.com>
References: <20210303063615.12130-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch fixes 2 issues of timestamp channel:
1. This patch ensures that there is sufficient space and correct
alignment for the timestamp.
2. Correct the timestamp channel scan index.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index e3d38cbcf354..dc534ed784c3 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -15,7 +15,10 @@
 struct temperature_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info temperature_attr;
-	s32 temperature_data;
+	struct {
+		s32 temperature_data;
+		u64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
@@ -36,7 +39,7 @@ static const struct iio_chan_spec temperature_channels[] = {
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			BIT(IIO_CHAN_INFO_HYSTERESIS),
 	},
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -127,9 +130,8 @@ static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
 	if (atomic_read(&temp_st->common_attributes.data_ready))
-		iio_push_to_buffers_with_timestamp(indio_dev,
-				&temp_st->temperature_data,
-				iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_timestamp(indio_dev, &temp_st->scan,
+						   iio_get_time_ns(indio_dev));
 
 	return 0;
 }
@@ -144,7 +146,7 @@ static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 	switch (usage_id) {
 	case HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE:
-		temp_st->temperature_data = *(s32 *)raw_data;
+		temp_st->scan.temperature_data = *(s32 *)raw_data;
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.17.1

