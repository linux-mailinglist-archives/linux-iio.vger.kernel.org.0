Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27E420239
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhJCPbI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhJCPbC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F0B961A54;
        Sun,  3 Oct 2021 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274955;
        bh=cT8CtZIAglZ5K25Xjr5BJpFkMg8ng0NQscE/+vcmfQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xt1E6ReNpKy9WFqWYb9ttnFk2pPCN9pGwaWdsnbSBnVMP0/06FU8Uv+t9lRlMFYiA
         JNHwOwn3iZZGH+dBD2EmjCx0WGR7DHcy/8feMjrHexWTSg3W0hzCKiBOQmprjBJ/7h
         2711MOwXEPc7TvQvoDtOq4CzuB82kX864DpIoUuOBfNjcqxPeeH+Ns4LB2JWU7boyX
         4b0/CcfMwA3Mj0JsfnaBOAMgTh3Gq8AQmGWNt4ixit6IOC/Xmjcb1R2DH+mGV0pW5q
         QbhCPr+43Ap4zyyB0XwsZt4JUmqpeydXOpV++vio3P+eBglglcFK/RlvOtiAYlzK7x
         /h9MUwg8Zn5eQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 03/11] iio: industrialio-buffer.c: Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:32:58 +0100
Message-Id: <20211003153306.391766-4-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note that a lot of functionality has moved around in IIO over the
years and header includes have not always kept track.

Based on manual inspection suggestions from the
include-what-you-use-tool adjusted to take into account certain
'super headers' used in the kernel.

Includes reordering headers to alphabetical order (mostly in order so
not done in a separate patch).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ed7a5c0a31e1..f5ab3a43d5d6 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -9,16 +9,31 @@
  * - Better memory allocation techniques?
  * - Alternative access techniques?
  */
+#include <linux/align.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/anon_inodes.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/file.h>
 #include <linux/fs.h>
-#include <linux/cdev.h>
-#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/kstrtox.h>
+#include <linux/list.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
 #include <linux/poll.h>
+#include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
-- 
2.33.0

