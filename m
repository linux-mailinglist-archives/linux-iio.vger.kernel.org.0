Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC332C6B3
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442158AbhCDA3w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:29:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:50156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1841810AbhCCGiH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Mar 2021 01:38:07 -0500
IronPort-SDR: c83ZcA82RkRczXgl5i59GxccgYZGylr0JMG86BuoM2IeMQgH4yycrfzhpmRSdbE5lcgugAAzsp
 +swzsKSf2pTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167012874"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="167012874"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:35:57 -0800
IronPort-SDR: Gy3mAPxL2/2WviYYVKUVJHi6hQ4UjNDKPADQJzNEPFb7llQZquOPv8f7Z4bWgwEnfCYCeU79xt
 GKmB5DG5WRWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383870896"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2021 22:35:55 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 1/4] iio: hid-sensor-humidity: Fix alignment issue of timestamp channel
Date:   Wed,  3 Mar 2021 14:36:12 +0800
Message-Id: <20210303063615.12130-2-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210303063615.12130-1-xiang.ye@intel.com>
References: <20210303063615.12130-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch ensures that, there is sufficient space and correct
alignment for the timestamp.

Fixes: d7ed89d5aadf ("iio: hid: Add humidity sensor support")
Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index ec88ae3f233d..74383abc0d44 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -15,7 +15,10 @@
 struct hid_humidity_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info humidity_attr;
-	s32 humidity_data;
+	struct {
+		s32 humidity_data;
+		u64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
@@ -129,9 +132,8 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
 	if (atomic_read(&humid_st->common_attributes.data_ready))
-		iio_push_to_buffers_with_timestamp(indio_dev,
-					&humid_st->humidity_data,
-					iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_timestamp(indio_dev, &humid_st->scan,
+						   iio_get_time_ns(indio_dev));
 
 	return 0;
 }
@@ -146,7 +148,7 @@ static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 	switch (usage_id) {
 	case HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY:
-		humid_st->humidity_data = *(s32 *)raw_data;
+		humid_st->scan.humidity_data = *(s32 *)raw_data;
 
 		return 0;
 	default:
-- 
2.17.1

