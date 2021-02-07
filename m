Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B86312224
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 08:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBGHBO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 02:01:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:37942 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhBGHAp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 02:00:45 -0500
IronPort-SDR: pJmBNURaKSUNGpw2XBWSsAtR5phrLA7BxkuOkt+3nr5C8gjhwtCsGCjSvTqkNu7zUa8Lm/wMub
 vynZCv+9V8uA==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="178080529"
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="178080529"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 23:00:04 -0800
IronPort-SDR: tVoW+3raKaBNdfPkP1uqmsmqMj78Lz9JHKc7vY6Mk3C+3mo+YN4tvW4VF2bN6m0oJzF5wWjV7K
 yv6IwQtaFU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="374982582"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2021 23:00:02 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 2/3] iio: hid-sensor-als: Add relative hysteresis support
Date:   Sun,  7 Feb 2021 15:00:47 +0800
Message-Id: <20210207070048.23935-3-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210207070048.23935-1-xiang.ye@intel.com>
References: <20210207070048.23935-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hid sensor als use relative hysteresis, this patch adds the support.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/light/hid-sensor-als.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index afcdb424bfb8..85c8a05b73cb 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -54,7 +54,8 @@ static const struct iio_chan_spec als_channels[] = {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_INTENSITY,
 	},
 	{
@@ -63,7 +64,8 @@ static const struct iio_chan_spec als_channels[] = {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
@@ -141,6 +143,10 @@ static int als_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_raw_hyst_value(
 				&als_state->common_attributes, val, val2);
 		break;
+	case IIO_CHAN_INFO_HYSTERESIS_RELATIVE:
+		ret_type = hid_sensor_read_raw_hyst_rel_value(
+				&als_state->common_attributes, val, val2);
+		break;
 	default:
 		ret_type = -EINVAL;
 		break;
@@ -168,6 +174,10 @@ static int als_write_raw(struct iio_dev *indio_dev,
 		ret = hid_sensor_write_raw_hyst_value(
 				&als_state->common_attributes, val, val2);
 		break;
+	case IIO_CHAN_INFO_HYSTERESIS_RELATIVE:
+		ret = hid_sensor_write_raw_hyst_rel_value(
+				&als_state->common_attributes, val, val2);
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.17.1

