Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E76370806
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEARDq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhEARDq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD9116157F;
        Sat,  1 May 2021 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888576;
        bh=gQpVM9Cjx5z63XPT6CD6bJ12GbYdKROqP9XpixHdnbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncfjSczyyk4p/DnXfqwzTVSSbzv9Alv/Vb+WQj7S3+tkMXk/sI5eHRQyMBDOMO2j3
         3XbyaE0ZnluKyg506QZVkGM4nllBIKu0lw6HhGhf+MR1n8iMTkV262X9Sj7fW3zXpt
         yZb68NFEDOV+zHyk0Y6cMkUSH8FmQ0lobYvV3z1umh4Lt+vb6eL4ZgLL+4a40a1fuQ
         zKh5MLZ8HvbYDixtLCXZzH2gRbINCPzwRBzHJ4zD4iEx0Y/kWFX7YfeY8zhoHSEFMg
         a7RCY5i4UZ9vclyWBU/XWb1raRILo+3OQfYDqZM9hZv1gDoyRvR9qTcM5rJXuPDWta
         ABfJnq0wCRYTw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/19] iio: accel: hid: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:05 +0100
Message-Id: <20210501170121.512209-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.
Note this matches what was done in all the other hid sensor drivers.
This one was missed previously due to an extra level of indirection.

Found during an audit of all calls of this function.

Fixes: a96cd0f901ee ("iio: accel: hid-sensor-accel-3d: Add timestamp")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2f9465cb382f..27f47e1c251e 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -28,8 +28,11 @@ struct accel_3d_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info accel[ACCEL_3D_CHANNEL_MAX];
-	/* Reserve for 3 channels + padding + timestamp */
-	u32 accel_val[ACCEL_3D_CHANNEL_MAX + 3];
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u32 accel_val[3];
+		s64 timestamp __aligned(8);
+	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
@@ -245,8 +248,8 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 			accel_state->timestamp = iio_get_time_ns(indio_dev);
 
 		hid_sensor_push_data(indio_dev,
-				     accel_state->accel_val,
-				     sizeof(accel_state->accel_val),
+				     &accel_state->scan,
+				     sizeof(accel_state->scan),
 				     accel_state->timestamp);
 
 		accel_state->timestamp = 0;
@@ -271,7 +274,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case HID_USAGE_SENSOR_ACCEL_Y_AXIS:
 	case HID_USAGE_SENSOR_ACCEL_Z_AXIS:
 		offset = usage_id - HID_USAGE_SENSOR_ACCEL_X_AXIS;
-		accel_state->accel_val[CHANNEL_SCAN_INDEX_X + offset] =
+		accel_state->scan.accel_val[CHANNEL_SCAN_INDEX_X + offset] =
 						*(u32 *)raw_data;
 		ret = 0;
 	break;
-- 
2.31.1

