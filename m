Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAE4F653
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFVO5s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO5s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FF320449;
        Sat, 22 Jun 2019 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215466;
        bh=1wlV+IQRLXQwrasM7Dt61Vdd3Vno7BFWIKU2+ynJCaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uk2UKB4XH11vl5jByoVepMiI2PqTjMjVebhE6xTwFXunOD+7ipj/GYqQrP/SpxQhs
         6wl+5mbwg8N3JhWam/kv0DkW4VPQX3v3tzNp7ldl+ZbY9s3qCjiW2JqmHqlRqqvtmJ
         Y/O5jC0hKn6SOeexY9FE8rKvaZSPoKkElPx+sHWA=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/14] iio: core: SPDX headers for core files. Note fix to MODULE_LICENSE
Date:   Sat, 22 Jun 2019 15:55:03 +0100
Message-Id: <20190622145516.3231-2-jic23@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190622145516.3231-1-jic23@kernel.org>
References: <20190622145516.3231-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is a concerted push to ensure all of the kernel files
have SPDX headers going on, so about time IIO caught up.

Given the large and mechanical nature of the changes + the
need to actually check the changes are correct by hand,
I'll split them down in to fairly bite sized chunks.

This first patch is those files that feed directly into
industrialio.ko.

Note the visual inspection showed that MODULE_LICENSE(GPL)
was different from the clearly file headers which did not
have the or later text that implies.  I have taken the
code as having precedence and changed this to GPL v2.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/iio_core.h               |  8 +++-----
 drivers/iio/iio_core_trigger.h       |  2 +-
 drivers/iio/industrialio-buffer.c    |  8 +++-----
 drivers/iio/industrialio-core.c      | 10 ++++------
 drivers/iio/industrialio-event.c     |  4 +++-
 drivers/iio/industrialio-trigger.c   |  8 +++-----
 drivers/iio/inkern.c                 |  8 +++-----
 include/linux/iio/buffer.h           |  8 +++-----
 include/linux/iio/consumer.h         |  5 +----
 include/linux/iio/driver.h           |  5 +----
 include/linux/iio/events.h           |  8 +++-----
 include/linux/iio/iio.h              |  9 +++------
 include/linux/iio/machine.h          |  5 +----
 include/linux/iio/sysfs.h            | 10 ++++------
 include/linux/iio/trigger.h          |  5 +----
 include/linux/iio/trigger_consumer.h |  8 +++-----
 include/linux/iio/types.h            |  8 +++-----
 17 files changed, 43 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index c775fedbcaf6..62b3c436d367 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -1,11 +1,9 @@
-/* The industrial I/O core function defs.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The industrial I/O core function defs.
  *
  * Copyright (c) 2008 Jonathan Cameron
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  * These definitions are meant for use only within the IIO core, not individual
  * drivers.
  */
diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index 1fdb1e4ea4a5..e945764da1b0 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -1,4 +1,4 @@
-
+/* SPDX-License-Identifier: GPL-2.0 */
 /* The industrial I/O core, trigger consumer handling functions
  *
  * Copyright (c) 2008 Jonathan Cameron
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4fa273002c03..698f650145a0 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1,11 +1,9 @@
-/* The industrial I/O core
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The industrial I/O core
  *
  * Copyright (c) 2008 Jonathan Cameron
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  * Handling of buffer allocation / resizing.
  *
  *
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 85a699b5ae96..518b654a248b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1,11 +1,9 @@
-/* The industrial I/O core
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The industrial I/O core
  *
  * Copyright (c) 2008 Jonathan Cameron
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  * Based on elements of hwmon and input subsystems.
  */
 
@@ -1821,4 +1819,4 @@ module_exit(iio_exit);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Industrial I/O core");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index c6dfdf0aaac5..d32ebf47960f 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -1,4 +1,6 @@
-/* Industrial I/O event handling
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Industrial I/O event handling
  *
  * Copyright (c) 2008 Jonathan Cameron
  *
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index e5b538379ed1..affe336842e0 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -1,10 +1,8 @@
-/* The industrial I/O core, trigger handling functions
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The industrial I/O core, trigger handling functions
  *
  * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 4a5eff3f18bc..89684464b72a 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -1,10 +1,8 @@
-/* The industrial I/O core in kernel channel mapping
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The industrial I/O core in kernel channel mapping
  *
  * Copyright (c) 2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #include <linux/err.h>
 #include <linux/export.h>
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 48767c776119..50c645369544 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -1,10 +1,8 @@
-/* The industrial I/O core - generic buffer interfaces.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The industrial I/O core - generic buffer interfaces.
  *
  * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef _IIO_BUFFER_GENERIC_H_
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index b2d34831ed7c..25c5f932c03d 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Industrial I/O in kernel consumer interface
  *
  * Copyright (c) 2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #ifndef _IIO_INKERN_CONSUMER_H_
 #define _IIO_INKERN_CONSUMER_H_
diff --git a/include/linux/iio/driver.h b/include/linux/iio/driver.h
index f54a7bcdefe3..d5e63a832f49 100644
--- a/include/linux/iio/driver.h
+++ b/include/linux/iio/driver.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Industrial I/O in kernel access map interface.
  *
  * Copyright (c) 2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef _IIO_INKERN_H_
diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index 8ad87d1c5340..4ed5a1e4b3c0 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -1,10 +1,8 @@
-/* The industrial I/O - event passing to userspace
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The industrial I/O - event passing to userspace
  *
  * Copyright (c) 2008-2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #ifndef _IIO_EVENTS_H_
 #define _IIO_EVENTS_H_
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index bb10c1bee301..9a5d40874ed5 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -1,11 +1,8 @@
-
-/* The industrial I/O core
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The industrial I/O core
  *
  * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
diff --git a/include/linux/iio/machine.h b/include/linux/iio/machine.h
index 5e1cfa75f652..3a2dfd43c8ef 100644
--- a/include/linux/iio/machine.h
+++ b/include/linux/iio/machine.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Industrial I/O in kernel access map definitions for board files.
  *
  * Copyright (c) 2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef __LINUX_IIO_MACHINE_H__
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index ce9426c507fd..e70291975d5b 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -1,10 +1,8 @@
-/* The industrial I/O core
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The industrial I/O core
  *
- *Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
+ * Copyright (c) 2008 Jonathan Cameron
  *
  * General attributes
  */
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index b19b7204ef84..430b99f76081 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* The industrial I/O core, trigger handling functions
  *
  * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #include <linux/irq.h>
 #include <linux/module.h>
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index c4f8c7409666..6c6d7da8d626 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -1,10 +1,8 @@
-/* The industrial I/O core, trigger consumer functions
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The industrial I/O core, trigger consumer functions
  *
  * Copyright (c) 2008-2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef __LINUX_IIO_TRIGGER_CONSUMER_H__
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 6eb3d683ef62..a4af165d6461 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -1,10 +1,8 @@
-/* industrial I/O data types needed both in and out of kernel
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * industrial I/O data types needed both in and out of kernel
  *
  * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef _IIO_TYPES_H_
-- 
2.22.0

