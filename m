Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA07420224
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhJCO76 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 10:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhJCO75 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 10:59:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E24B661501;
        Sun,  3 Oct 2021 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633273090;
        bh=RvjYp2RSrvJTDhaVhPX9B00CsJg8YCl78Vf+TnpnFg4=;
        h=From:To:Cc:Subject:Date:From;
        b=uw/XkPzdm/49IFPoccUWoyoTff3jwa5HbNmps+skVEH7HCu2i4PeP8zf7yc5ugrv6
         USc+OaZgpmQdL94aUFqTb1PbNyHfoxP+HulxAZEVjPp3Ns4xaZot9WAlxfDyU391nb
         56YZJ5nJrcjcM2SKUF3tOfoXsQCXWSYwUGZ9ZpjFOMTguAZIgdijP1f2Ic2lVseW+c
         Rd+O5KvKUfqWwiFyNdh3rBAf49cf+mhh0WMtBXXs9+3QQk1gnL5/NiR0sPmfC8PIdM
         1H0cEWpw0LPGK1HM6VtbQV2hLv1TdQObYSicV3D9n7V1k5Ae4hcke4gOxQm+NLhQI8
         Rgs4F7NRjU9Dw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: Move include/linux/iio-opaque.h to drivers/iio/iio_opaque.h
Date:   Sun,  3 Oct 2021 16:02:00 +0100
Message-Id: <20211003150200.391320-1-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This header is only intended for use within IIO core modules so move
it to an appropriate location.  Also rename to bring it inline with
other IIO core only headers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Cc: Alexandru Ardelean <aardelean@deviqon.com>
---

I'm not sure if there was a strong reason this file was in
include/linux/iio before?


 include/linux/iio/iio-opaque.h => drivers/iio/iio_opaque.h | 0
 drivers/iio/industrialio-buffer.c                          | 2 +-
 drivers/iio/industrialio-core.c                            | 2 +-
 drivers/iio/industrialio-event.c                           | 2 +-
 drivers/iio/industrialio-trigger.c                         | 2 +-
 drivers/iio/inkern.c                                       | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/iio/iio-opaque.h b/drivers/iio/iio_opaque.h
similarity index 100%
rename from include/linux/iio/iio-opaque.h
rename to drivers/iio/iio_opaque.h
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a95cc2da56be..ed7a5c0a31e1 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -21,9 +21,9 @@
 #include <linux/sched/signal.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
+#include "iio_opaque.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2dbb37e09b8c..6afa70c89c80 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -25,9 +25,9 @@
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
+#include "iio_opaque.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index d0732eac0f0a..1d49714d9832 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -18,8 +18,8 @@
 #include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
+#include "iio_opaque.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index b23caa2f2aa1..e4e59466a263 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -13,10 +13,10 @@
 #include <linux/slab.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/iio-opaque.h>
 #include <linux/iio/trigger.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
+#include "iio_opaque.h"
 #include <linux/iio/trigger_consumer.h>
 
 /* RFC - Question of approach
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0222885b334c..72c130d9fecb 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -10,8 +10,8 @@
 #include <linux/of.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
+#include "iio_opaque.h"
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
 #include <linux/iio/consumer.h>
-- 
2.33.0

