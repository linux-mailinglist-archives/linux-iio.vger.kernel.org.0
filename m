Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE61530A2D1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 08:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhBAHnz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 02:43:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:46039 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232215AbhBAHnu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Feb 2021 02:43:50 -0500
IronPort-SDR: EjOT25gxAylLeFWunstVpRoFrzHC/HmIywKqzXuYTHk0NWT0DyA6BUhe5j6hw5HTtAgu19XL8I
 nWQ/UxshWMhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="159813881"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="159813881"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 23:43:10 -0800
IronPort-SDR: SYO1Z+gug+MgUX9DKbHORRey7fluggwFcC/OJHDikvhNFpqbp7NV5UZSf0N9KQWaUqvyOKKVT1
 rs/9D00g9aQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="432235895"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2021 23:43:07 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 2/3] iio: hid-sensor-als: Add relative hysteresis support
Date:   Mon,  1 Feb 2021 15:43:57 +0800
Message-Id: <20210201074358.18435-3-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201074358.18435-1-xiang.ye@intel.com>
References: <20210201074358.18435-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hid sensor als uses relative hysteresis, this patch adds the support.

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

