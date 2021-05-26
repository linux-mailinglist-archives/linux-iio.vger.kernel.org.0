Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AFE391B21
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhEZPHp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 11:07:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:51126 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235255AbhEZPHp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 May 2021 11:07:45 -0400
IronPort-SDR: eZYHCyO5glQE9skdfCG7s4mK+J3GNoDOEvGbKUy17/j7xyFxTKrpU9mIPY62uJeWsy1RY94tM7
 lBpY0KJ9JOQw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="263692112"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="263692112"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 08:06:08 -0700
IronPort-SDR: hlAEMFS0kxnv0q35jv4DGkDtlnI9pTAZhP0L3BvETj/xsrhWKj8z4AsGv+MIUAX7RlX8RMTWzk
 si8GXbgQn+WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="397346174"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.166])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2021 08:06:05 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2 1/2] counter: Add support for Quadrature x4 with swapped inputs
Date:   Wed, 26 May 2021 18:06:00 +0300
Message-Id: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some Quadrature Encoders can swap phase inputs A and B internally. This
new function will allow drivers to configure input swap mode.

This was implemented by Felipe Balbi while he was working at Intel.

Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 4 ++++
 drivers/counter/counter.c                   | 3 ++-
 include/linux/counter.h                     | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 566bd99fe0a5..8f1e3de88c77 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -146,6 +146,10 @@ Description:
 			updates	the respective count. Quadrature encoding
 			determines the direction.
 
+		quadrature x4 swapped:
+			Same as quadrature x4, however Phase A and Phase B
+			signals are swapped.
+
 What:		/sys/bus/counter/devices/counterX/countY/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
index 6a683d086008..11d357245b14 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -752,7 +752,8 @@ static const char *const counter_count_function_str[] = {
 	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
 	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
 	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4",
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED] = "quadrature x4 swapped"
 };
 
 static ssize_t counter_function_show(struct device *dev,
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 9dbd5df4cd34..c3b4d263eb22 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -170,7 +170,8 @@ enum counter_count_function {
 	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
 	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
 	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED,
 };
 
 /**
-- 
2.30.2

