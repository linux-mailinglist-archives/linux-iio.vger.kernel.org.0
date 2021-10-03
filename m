Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5234A42023B
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhJCPbI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhJCPbF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67CE861A58;
        Sun,  3 Oct 2021 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274958;
        bh=J+jSd1lVSN0kvpuEY51noDAwdYKslzs8PeYsWzfLWpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0X+W27qgQ1X3OhbSvbtdwGA9Ha/ihwUILzXM3CgLRTJJJa46VUUGvM8Zh5hVMt2f
         GFIdM7oKAmUJ+5ED8hVxC4CnNQz04QLJmmD5J8OcdT+XxFSj9wX3wx9ICm5T/MHKfp
         H15GQEqOt/GQEeNqDlll1qEH+4t448BJs90GytQBdIpk6AZWm5S11iy5+0RFkNxqd2
         kCEfa6vkEz3V4OMaARHEoCoE6iAJSE0s1DPj0wHR6NmF2fU6VFJwiSystlpvChWFeH
         MQq4mS+556zCwaQgPndoJK9IDxz+CmwJrVFaTNAf+shf1GAptQitWcEyyCqjf6H0Qd
         6QDt8dTiRoh1Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 05/11] iio: industrialio-trigger.c: Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:33:00 +0100
Message-Id: <20211003153306.391766-6-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on manual inspection of the suggestions from the
include-what-you-use tool.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-trigger.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index e4e59466a263..3b77371aea57 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -4,13 +4,22 @@
  * Copyright (c) 2008 Jonathan Cameron
  */
 
-#include <linux/kernel.h>
-#include <linux/idr.h>
-#include <linux/err.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
-- 
2.33.0

