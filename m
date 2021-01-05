Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515C82EA7A4
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 10:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbhAEJen (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 04:34:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:51522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbhAEJem (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 04:34:42 -0500
IronPort-SDR: gem+i0qZkncvWW0xM1RIlND0cHShobsq19lNzNw3Ee/aaIWRXG+Y+ghTf1+50fqxV+UX3e76Sz
 Q9KCF++er2HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156864068"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156864068"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:34:02 -0800
IronPort-SDR: 7gsOjnO5t+VBBJTo98uZ+gVwOtAt5Zgosw90lqIoFWmtRby76WQzTrDQfwp99gxHEqXbDofP2e
 1CpPirsqtcaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="569665139"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2021 01:34:00 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 1/6] iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
Date:   Tue,  5 Jan 2021 17:35:10 +0800
Message-Id: <20210105093515.19135-2-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105093515.19135-1-xiang.ye@intel.com>
References: <20210105093515.19135-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The accel_3d sensor already has a timestamp channel, this patch just
replicate that for gravity sensor.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 589b7d8a36f2..7cd3cd81b1a7 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -23,6 +23,7 @@ enum accel_3d_channel {
 	ACCEL_3D_CHANNEL_MAX,
 };
 
+#define CHANNEL_SCAN_INDEX_TIMESTAMP ACCEL_3D_CHANNEL_MAX
 struct accel_3d_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
@@ -82,7 +83,7 @@ static const struct iio_chan_spec accel_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	},
-	IIO_CHAN_SOFT_TIMESTAMP(3)
+	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
 /* Channel definitions */
@@ -117,7 +118,8 @@ static const struct iio_chan_spec gravity_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP),
 };
 
 /* Adjust channel real bits based on report descriptor */
-- 
2.17.1

