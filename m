Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9412B8FC5
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 11:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgKSKCt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 05:02:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:10879 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgKSKCt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Nov 2020 05:02:49 -0500
IronPort-SDR: AS2eBuEZPoiat6d5xTwA1LVmv5pw+pyipw+/L1Co9U4qLFzjpKdVXtbrhTuqmW+zRhj9Tlffy+
 7Lp5l4lBtxbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170482245"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="170482245"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 02:02:49 -0800
IronPort-SDR: jiEDvqRj5GkfRbyDAUn7Iw4gx/IYLh3nZ5pKIsyZlkRfiTmS4Ckc37v5LXtXHb1Ax4vtigu1gU
 94jVRv9xMyJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359909801"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 02:02:47 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 3/4] iio: hid-sensor-trigger: Use iio->trig instead trig field internal structure
Date:   Thu, 19 Nov 2020 18:03:30 +0800
Message-Id: <20201119100331.2594-4-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119100331.2594-1-xiang.ye@intel.com>
References: <20201119100331.2594-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use iio->trig instead of attrb->trig as parameter of iio_trigger_unregister
and iio_trigger_free. This allows one HID sensor driver to create
multiple iio devices. In this case common attributes are shared and
there can be one instance for the structure containing common attributes
for all iio devices.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 30340abcbc8d..bb5e7c8ff15b 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -236,8 +236,8 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
 	pm_runtime_put_noidle(&attrb->pdev->dev);
 
 	cancel_work_sync(&attrb->work);
-	iio_trigger_unregister(attrb->trigger);
-	iio_trigger_free(attrb->trigger);
+	iio_trigger_unregister(indio_dev->trig);
+	iio_trigger_free(indio_dev->trig);
 	iio_triggered_buffer_cleanup(indio_dev);
 }
 EXPORT_SYMBOL(hid_sensor_remove_trigger);
-- 
2.17.1

