Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3FC3042
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfJAJcl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 05:32:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:18424 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfJAJcl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Oct 2019 05:32:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="191407300"
Received: from pipin.fi.intel.com ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2019 02:32:39 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH v3 1/2] counter: add support for Quadrature x4 with swapped inputs
Date:   Tue,  1 Oct 2019 12:32:36 +0300
Message-Id: <20191001093237.775608-1-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <87o8zax6ya.fsf@gmail.com>
References: <87o8zax6ya.fsf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some Quadrature Encoders can swap phase inputs A and B
internally. This new function will allow drivers to configure input
swap mode.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
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
index 106bc7180cd8..b818ae9e85f2 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -823,7 +823,8 @@ static const char *const counter_count_function_str[] = {
 	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
 	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
 	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4",
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED] = "quadrature x4 swapped"
 };
 
 static ssize_t counter_function_show(struct device *dev,
diff --git a/include/linux/counter.h b/include/linux/counter.h
index a061cdcdef7c..860769250f89 100644
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
2.23.0

