Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73584420237
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhJCPbB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhJCPbB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E07C661A50;
        Sun,  3 Oct 2021 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274954;
        bh=9v91GW04cmj631Y1Si1BQQl6se6WUIR9xIDGlQVaXPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFpg1DSR0y8O+oDkFqL4VaGA4F7q+3P8m+B+BgyZmdb22OoBj6ryXzK+9m7wQ/gZM
         Qzvj4UE2kQVlEWBLTCpTCnAt0VstAhRB6g9WnMXP2GcwSOn6K5UjPelS8xy7R/Bqwk
         a2/o3I4By+Q6IWGis0YKwUDO7maZZkXP+oj/+q5vRa1hutFMqS9GtXCk7wbjbCNedA
         fTNb8KyZyGYlaLAsj1Nz07l7qB4IDeyY4EU7Ws3aiGK67o62H31oPR8ZvhRHthw0Dc
         rVsh/tYsh/FEiansfhnDK9YYtRZonn3X9GxdAGdTqw6q/bUaPvJudb+/gmjnJHnxW1
         m23qu9L0eD/CQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 02/11] iio: industrialio-core - Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:32:57 +0100
Message-Id: <20211003153306.391766-3-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using the include-what-you-use tool as a guide
a) Drop unnused headers.
b) Add missing headers for functionality directly used in this file.

Note that this is not an automated process and in somecases the
suggestions were ignored, or a different header included to reflect
what I understand to be expected structure of includes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d6c2875a832e..64f4aba20d9e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -8,22 +8,35 @@
 
 #define pr_fmt(fmt) "iio-core: " fmt
 
-#include <linux/anon_inodes.h>
-#include <linux/device.h>
+#include <linux/align.h>
+#include <linux/bitops.h>
 #include <linux/cdev.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/hrtimer.h>
 #include <linux/idr.h>
+#include <linux/init.h>
 #include <linux/kdev_t.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/poll.h>
+#include <linux/printk.h>
 #include <linux/property.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/wait.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/time64.h>
+#include <linux/uaccess.h>
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
@@ -31,8 +44,8 @@
 #include "iio_opaque.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/buffer_impl.h>
+
+struct iio_buffer;
 
 /* IDA to assign each registered device a unique id */
 static DEFINE_IDA(iio_ida);
-- 
2.33.0

