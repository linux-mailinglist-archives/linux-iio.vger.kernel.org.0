Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7C2FCBFA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 08:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbhATHrB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jan 2021 02:47:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:29181 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbhATHqt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Jan 2021 02:46:49 -0500
IronPort-SDR: Hil/hJyYkWsbjHiIiHTioWZzjVB1v6enehdfIgEeU5zbJiZ4Ok/WTRwM6TWv39zMNOxC0ddhxe
 c58ph/8oXxVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="178282813"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="178282813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 23:46:06 -0800
IronPort-SDR: qWNe4iBZ9fNWumFZjjvEWM6OXeV6CgGUQkZpKeQURmC38SPOCngkRknGj2n5/+4RV9jmuCYz2z
 EZ0Pty18uADg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="466994266"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 23:46:05 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 2/3] hid-sensor-common: Add relative sensitivity check
Date:   Wed, 20 Jan 2021 15:47:05 +0800
Message-Id: <20210120074706.23199-3-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210120074706.23199-1-xiang.ye@intel.com>
References: <20210120074706.23199-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some hid sensors may use relative sensitivity such as als sensor.
This patch add relative sensitivity check for all hid-sensors.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c    | 11 ++++++++++-
 include/linux/hid-sensor-ids.h                        |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index d349ace2e33f..b685c292a179 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -480,7 +480,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 
 	/*
 	 * Set Sensitivity field ids, when there is no individual modifier, will
-	 * check absolute sensitivity of data field
+	 * check absolute sensitivity and relative sensitivity of data field
 	 */
 	for (i = 0; i < sensitivity_addresses_len && st->sensitivity.index < 0; i++) {
 		sensor_hub_input_get_attribute_info(hsdev,
@@ -488,6 +488,15 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
 					sensitivity_addresses[i],
 				&st->sensitivity);
+
+		if (st->sensitivity.index >= 0)
+			break;
+
+		sensor_hub_input_get_attribute_info(hsdev,
+				HID_FEATURE_REPORT, usage_id,
+				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT |
+					sensitivity_addresses[i],
+				&st->sensitivity);
 	}
 
 	st->raw_hystersis = -1;
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 3bbdbccc5805..ac631159403a 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -149,6 +149,7 @@
 /* Per data field properties */
 #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
 #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
+#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE000
 
 /* Power state enumerations */
 #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x200850
-- 
2.17.1

