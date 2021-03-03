Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F052E32C6BA
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhCDA34 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:29:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:50156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1841824AbhCCGi3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Mar 2021 01:38:29 -0500
IronPort-SDR: yIfh+60QftoxJaewV0G3QGyUTSm630FeEBeLr0HV2b1l6nGenlxyt0VWgytiq1ptusUbL12lX6
 /OwU0CQgnZ6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167012921"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="167012921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:36:05 -0800
IronPort-SDR: p8PRixu5iICIt0F7j6aYBCTvO75n1qvcpJjSZ7PgSSavIFjUJZbG53rGiC5ERXthdLGpPpxWhb
 PLQ1PRooPStg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383870931"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2021 22:36:03 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 4/4] iio: hid-sensor-temperature: Get sample timestamp from sensor hub
Date:   Wed,  3 Mar 2021 14:36:15 +0800
Message-Id: <20210303063615.12130-5-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210303063615.12130-1-xiang.ye@intel.com>
References: <20210303063615.12130-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Try to get sample timestamp from sensor hub first, if failed
then use system timestamp.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index dc534ed784c3..0d8110735779 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -23,6 +23,7 @@ struct temperature_state {
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	s64 timestamp;
 };
 
 static const u32 temperature_sensitivity_addresses[] = {
@@ -129,9 +130,14 @@ static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
-	if (atomic_read(&temp_st->common_attributes.data_ready))
+	if (atomic_read(&temp_st->common_attributes.data_ready)) {
+		if (!temp_st->timestamp)
+			temp_st->timestamp = iio_get_time_ns(indio_dev);
+
 		iio_push_to_buffers_with_timestamp(indio_dev, &temp_st->scan,
-						   iio_get_time_ns(indio_dev));
+						   temp_st->timestamp);
+		temp_st->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -148,6 +154,10 @@ static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE:
 		temp_st->scan.temperature_data = *(s32 *)raw_data;
 		return 0;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		temp_st->timestamp = hid_sensor_convert_timestamp(&temp_st->common_attributes,
+								  *(s64 *)raw_data);
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
2.17.1

