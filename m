Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA807361283
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhDOSw6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 14:52:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:31157 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234101AbhDOSw5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Apr 2021 14:52:57 -0400
IronPort-SDR: XvI4ysctFejX4uyz5VK18NhRSsFJVb7k33FunaIfLnZgx1/d0Pde5HgvvU8JF0qmWv2cSRyQMJ
 Y5mMsLcCgyHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="192792351"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="192792351"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 11:52:34 -0700
IronPort-SDR: WB2x6z6CCoH5XIEzorYma2EX9jtZ2l+8i7JM5jECwf9LC/1rItW8KiDCtEs7hzjz6VxZV7qu7i
 zPb49kjLhHeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="384108663"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2021 11:52:33 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, jic23@kernel.org, benjamin.tissoires@redhat.com
Cc:     jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] HID: hid-sensor-hub: Return error for hid_set_field() failure
Date:   Thu, 15 Apr 2021 11:52:31 -0700
Message-Id: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the function sensor_hub_set_feature(), return error when hid_set_field()
fails.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 3dd7d3246737..f9983145d4e7 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -210,16 +210,21 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	buffer_size = buffer_size / sizeof(__s32);
 	if (buffer_size) {
 		for (i = 0; i < buffer_size; ++i) {
-			hid_set_field(report->field[field_index], i,
-				      (__force __s32)cpu_to_le32(*buf32));
+			ret = hid_set_field(report->field[field_index], i,
+					    (__force __s32)cpu_to_le32(*buf32));
+			if (ret)
+				goto done_proc;
+
 			++buf32;
 		}
 	}
 	if (remaining_bytes) {
 		value = 0;
 		memcpy(&value, (u8 *)buf32, remaining_bytes);
-		hid_set_field(report->field[field_index], i,
-			      (__force __s32)cpu_to_le32(value));
+		ret = hid_set_field(report->field[field_index], i,
+				    (__force __s32)cpu_to_le32(value));
+		if (ret)
+			goto done_proc;
 	}
 	hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
 	hid_hw_wait(hsdev->hdev);
-- 
2.27.0

