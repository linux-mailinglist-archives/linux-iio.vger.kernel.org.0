Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6499C32C6AF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhCDA3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:29:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:35288 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355277AbhCCG2n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Mar 2021 01:28:43 -0500
IronPort-SDR: Ux0z2ZcL7eAgh9fidPOJj/xJvlQ6Y8EOe1Z7WeCZcjHdb564c0tFXPhGm+vn3lNfVU/XYhQYEn
 DrMUy5GnBNQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="206797464"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="206797464"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:28:04 -0800
IronPort-SDR: QO1PR4w9uIiXTYCgTkHLh/nhJIsQUMfyQ58OMMjSaFZgMQq1uGTOu2YgSodcg/vcvuzGCJaqiK
 b6I9PPPm27nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="600030995"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2021 22:28:03 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH] HID: intel_ish-hid: HBM: Use connected standby state bit during suspend/resume
Date:   Wed,  3 Mar 2021 14:28:25 +0800
Message-Id: <20210303062825.7724-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ISH firmware uses connected standby state bit (CONNECTED_STANDBY_STATE_BIT bit 1)
to notify current power state to sensors instead of suspend state bit (bit 0).
So send both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT to firmware
to be compatible with the previous version.

Signed-off-by: xiangye <xiang.ye@intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/hbm.c | 6 +++---
 drivers/hid/intel-ish-hid/ishtp/hbm.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index 30a91d068306..dbfae60f2621 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -914,7 +914,7 @@ static inline void fix_cl_hdr(struct ishtp_msg_hdr *hdr, size_t length,
 /*** Suspend and resume notification ***/
 
 static uint32_t current_state;
-static uint32_t supported_states = 0 | SUSPEND_STATE_BIT;
+static uint32_t supported_states = SUSPEND_STATE_BIT | CONNECTED_STANDBY_STATE_BIT;
 
 /**
  * ishtp_send_suspend() - Send suspend message to FW
@@ -933,7 +933,7 @@ void ishtp_send_suspend(struct ishtp_device *dev)
 	memset(&state_status_msg, 0, len);
 	state_status_msg.hdr.cmd = SYSTEM_STATE_STATUS;
 	state_status_msg.supported_states = supported_states;
-	current_state |= SUSPEND_STATE_BIT;
+	current_state |= (SUSPEND_STATE_BIT | CONNECTED_STANDBY_STATE_BIT);
 	dev->print_log(dev, "%s() sends SUSPEND notification\n", __func__);
 	state_status_msg.states_status = current_state;
 
@@ -959,7 +959,7 @@ void ishtp_send_resume(struct ishtp_device *dev)
 	memset(&state_status_msg, 0, len);
 	state_status_msg.hdr.cmd = SYSTEM_STATE_STATUS;
 	state_status_msg.supported_states = supported_states;
-	current_state &= ~SUSPEND_STATE_BIT;
+	current_state &= ~(CONNECTED_STANDBY_STATE_BIT | SUSPEND_STATE_BIT);
 	dev->print_log(dev, "%s() sends RESUME notification\n", __func__);
 	state_status_msg.states_status = current_state;
 
diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.h b/drivers/hid/intel-ish-hid/ishtp/hbm.h
index 7c445b203f2a..08f3f3ceb18c 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.h
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.h
@@ -235,6 +235,7 @@ struct dma_xfer_hbm {
 #define SYSTEM_STATE_QUERY_SUBSCRIBERS		0x3
 #define SYSTEM_STATE_STATE_CHANGE_REQ		0x4
 /*indicates suspend and resume states*/
+#define CONNECTED_STANDBY_STATE_BIT		(1<<0)
 #define SUSPEND_STATE_BIT			(1<<1)
 
 struct ish_system_states_header {
-- 
2.17.1

