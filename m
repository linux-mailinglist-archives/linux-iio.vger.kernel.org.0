Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F66B74AF
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbfISIDN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 04:03:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:10561 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfISIDN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Sep 2019 04:03:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 01:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="387188714"
Received: from pipin.fi.intel.com ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2019 01:03:07 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [RFC/PATCH 1/2] counter: add support for Quadrature x4 with swapped inputs
Date:   Thu, 19 Sep 2019 11:03:04 +0300
Message-Id: <20190919080305.960198-1-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917114403.GA8368@icarus>
References: <20190917114403.GA8368@icarus>
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
 drivers/counter/counter.c | 3 ++-
 include/linux/counter.h   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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

