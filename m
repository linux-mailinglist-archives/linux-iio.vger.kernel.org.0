Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD82B8FC4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 11:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgKSKCr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 05:02:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:10879 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgKSKCq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Nov 2020 05:02:46 -0500
IronPort-SDR: PAUFLMMmENz6CgUxHPAK6bAlcS8mrSp6wLWHgXvY4AN2drEUpJ2X2hif3pnwgNVz44uJmcEh/P
 muZknd6kRdzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170482240"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="170482240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 02:02:46 -0800
IronPort-SDR: 4rP8QmvTHyGMSLXW+TaqC3wxA+tat2EQI+ouizZ472FCyqqkQLDL32IzmH0v6Rk+IyDqVeCNqB
 yBR2uzPwKlJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359909776"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 02:02:44 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 2/4] iio: hid-sensor-trigger: Decrement runtime pm enable count on driver removal
Date:   Thu, 19 Nov 2020 18:03:29 +0800
Message-Id: <20201119100331.2594-3-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119100331.2594-1-xiang.ye@intel.com>
References: <20201119100331.2594-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To avoid pm_runtime_disable called repeatedly by hid sensor drivers,
decrease runtime pm enable count after call it.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index ff375790b7e8..30340abcbc8d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -227,8 +227,10 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
 			       struct hid_sensor_common *attrb)
 {
-	if (atomic_read(&attrb->runtime_pm_enable))
+	if (atomic_read(&attrb->runtime_pm_enable)) {
 		pm_runtime_disable(&attrb->pdev->dev);
+		atomic_dec(&attrb->runtime_pm_enable);
+	}
 
 	pm_runtime_set_suspended(&attrb->pdev->dev);
 	pm_runtime_put_noidle(&attrb->pdev->dev);
-- 
2.17.1

