Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6132C6B8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbhCDA3z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:29:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:50151 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1841820AbhCCGiR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Mar 2021 01:38:17 -0500
IronPort-SDR: m+zdDewE6wxrFoFKHb2ZbRXnhjeKrgQgg4pv7kEW6BAy4tfDqgd9rn1re0UjwtpQCig4sNPF3C
 Qval5Zc9Zb5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167012884"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="167012884"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:36:00 -0800
IronPort-SDR: n841CAA7egzCmxnVOXp/mTQQeI446hcezOqZau0UCHroGA5Lvwp4e4q2IFlvtHhEdBBZe8zaUX
 qabmyh2hOinA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383870907"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2021 22:35:58 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 2/4] iio: hid-sensor-humidity: Get sample timestamp from sensor hub
Date:   Wed,  3 Mar 2021 14:36:13 +0800
Message-Id: <20210303063615.12130-3-xiang.ye@intel.com>
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
 drivers/iio/humidity/hid-sensor-humidity.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 74383abc0d44..f7b4c76ed94f 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -23,6 +23,7 @@ struct hid_humidity_state {
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	s64 timestamp;
 };
 
 static const u32 humidity_sensitivity_addresses[] = {
@@ -131,9 +132,14 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
-	if (atomic_read(&humid_st->common_attributes.data_ready))
+	if (atomic_read(&humid_st->common_attributes.data_ready)) {
+		if (!humid_st->timestamp)
+			humid_st->timestamp = iio_get_time_ns(indio_dev);
+
 		iio_push_to_buffers_with_timestamp(indio_dev, &humid_st->scan,
-						   iio_get_time_ns(indio_dev));
+						   humid_st->timestamp);
+		humid_st->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -151,6 +157,10 @@ static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
 		humid_st->scan.humidity_data = *(s32 *)raw_data;
 
 		return 0;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		humid_st->timestamp = hid_sensor_convert_timestamp(&humid_st->common_attributes,
+								   *(s64 *)raw_data);
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
2.17.1

