Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2131351A26
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhDAR61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:58:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:52043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236745AbhDARzO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:14 -0400
IronPort-SDR: Uf+n2cYiuDCFzdC1QYC9WF/rcSyWndHN//sQQcEqB+Gcoc2xu4WOmJmVO+nlOlTJ9EOB3g4Icv
 ASj9HAXdOw7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190035775"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="190035775"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 08:32:37 -0700
IronPort-SDR: gFwxRxy+CLm11pAPs2/8KkEaYpMKWoO2ZDH3ypVLkCqoH/W0Kzi55C6GXk5zeSgiKS+R3oQzPX
 mnmGi7QGBP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="607640491"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.184])
  by fmsmga006.fm.intel.com with ESMTP; 01 Apr 2021 08:32:36 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 1/2] counter: Add support for Quadrature x4 with swapped inputs
Date:   Thu,  1 Apr 2021 18:32:27 +0300
Message-Id: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
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

