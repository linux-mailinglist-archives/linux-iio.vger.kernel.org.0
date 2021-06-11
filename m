Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D963A440B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFKOae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 10:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhFKOad (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 10:30:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8FCB613AE;
        Fri, 11 Jun 2021 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623421715;
        bh=6Ad5Bg9s5yE0b0VsXU6bAFZHGkMU+1oB8Ghp/cgJDA0=;
        h=From:To:Cc:Subject:Date:From;
        b=YPf0DzQ/KOwyqP2v+qHeYDlnilnATOLWoxzxXACuJZ9SrjWvYW3G2CiYXuiR2InmD
         n2s7g8olhzxxoXMZnJsohF9GoZ52eayolG5biGwnk8DveAzV+DQ8Hn4ipMxOhWW5XB
         Roft7LhhUJ4YokY5yJS3allWmol2+fruRY06KMaUaBI6Sv5hXsJyFr/Su+qQQwygRi
         G2C+dD98Vz/USCYj7io6ZgwXHJPHyZxO09UpDt/GvdLz/BvHfYNJl+lc/4bvuIERgh
         PfLbI366KfV4MZpy7j7eq2X0xAOSKntWJHiXjlirgnWIFQUSlhS2qer+ZnmK6C/Tky
         xkAOyCgI7HDlg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH] iio: core: Cleanup includes
Date:   Fri, 11 Jun 2021 15:29:18 +0100
Message-Id: <20210611142918.103708-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Result of considering output of the include-what-you-use static checker.
Note that there are rarely hard rules on when particular headers should
be included.  This series attempts to go for some level of consistency.

Some headers were simiply not used, mostly as a result of rework that
didn't include updating them. Some others were missing that probably
should have been there from the start (mutex.h, list.h etc)
because their functionality was directly used in the file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/industrialio-buffer.c     | 2 +-
 drivers/iio/industrialio-configfs.c   | 6 ++----
 drivers/iio/industrialio-core.c       | 7 -------
 drivers/iio/industrialio-event.c      | 1 -
 drivers/iio/industrialio-sw-device.c  | 5 ++---
 drivers/iio/industrialio-sw-trigger.c | 5 ++---
 drivers/iio/inkern.c                  | 1 +
 7 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index fdd623407b96..e67c6c636044 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -15,7 +15,7 @@
 #include <linux/device.h>
 #include <linux/file.h>
 #include <linux/fs.h>
-#include <linux/cdev.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
index 47900de1f105..f3db62aa9be6 100644
--- a/drivers/iio/industrialio-configfs.c
+++ b/drivers/iio/industrialio-configfs.c
@@ -6,12 +6,10 @@
  */
 
 #include <linux/configfs.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/kmod.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/configfs.h>
 
 static const struct config_item_type iio_root_group_type = {
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6d2175eb7af2..c1113add619b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -15,13 +15,9 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/fs.h>
-#include <linux/poll.h>
 #include <linux/property.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
-#include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
 #include <linux/iio/iio.h>
@@ -29,9 +25,6 @@
 #include "iio_core.h"
 #include "iio_core_trigger.h"
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/buffer_impl.h>
 
 /* IDA to assign each registered device a unique id */
 static DEFINE_IDA(iio_ida);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index d0732eac0f0a..48c9a1479b83 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -13,7 +13,6 @@
 #include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/poll.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
index 49f775f16ad5..0c00bdcc0e88 100644
--- a/drivers/iio/industrialio-sw-device.c
+++ b/drivers/iio/industrialio-sw-device.c
@@ -5,11 +5,10 @@
  * Copyright (c) 2016 Intel Corporation
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/kmod.h>
 #include <linux/list.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 
 #include <linux/iio/sw_device.h>
 #include <linux/iio/configfs.h>
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index 9ae793a70b8b..a8ab461be373 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -5,11 +5,10 @@
  * Copyright (c) 2015 Intel Corporation
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/kmod.h>
 #include <linux/list.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 
 #include <linux/iio/sw_trigger.h>
 #include <linux/iio/configfs.h>
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 391a3380a1d1..c2fc6cdc1c8c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -6,6 +6,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 
-- 
2.31.1

