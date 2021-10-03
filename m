Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5342023D
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJCPbL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhJCPbK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD83261A50;
        Sun,  3 Oct 2021 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274962;
        bh=dvH0bxqeV9kJS9Uf4j4GyWge6JxAA5EEgCHJdWlrb+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+h+bZvLPFjHETYaJr93/3heaUrDMXoswk6SkmoJkl4zJ1Wv3EnlZszx0FhRnOYVr
         WS2i12SMMk9oZykycwOzZ3uZGjZY12zkNt7u+pkXpqy2SW6RH2oR1LGKWJ7D7EoDVo
         2Hb4K3dztuhsoylwm9z59jl7iEVVU38d4JRG5GdGsLPlQdgH8Z4KFNBVQlQe1yDhz1
         7htBBKp35+iaNAXJ+p7J4+KF+HIlBpjO7v7xLTzkLA/1hP6r2c09q4goaL2lTD+eXf
         cGXV/Cv/SKThgxWYC4aKwEDr/vkIZOuHb1xO+qKfXmY1CQu0RJeYSDWjvo1Po73qyx
         aiFPThRjclAng==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 08/11] iio: misc core files: Bring includes up to date
Date:   Sun,  3 Oct 2021 16:33:03 +0100
Message-Id: <20211003153306.391766-9-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Small utility files from the IIO core grouped together in this commit.
Based on manual inspection fo the suggestions from the
include-what-you-use tool.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-sw-device.c       | 8 +++++---
 drivers/iio/industrialio-sw-trigger.c      | 9 ++++++---
 drivers/iio/industrialio-triggered-event.c | 3 ++-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
index 49f775f16ad5..6bcea1bacec2 100644
--- a/drivers/iio/industrialio-sw-device.c
+++ b/drivers/iio/industrialio-sw-device.c
@@ -5,11 +5,13 @@
  * Copyright (c) 2016 Intel Corporation
  */
 
-#include <linux/module.h>
+#include <linux/err.h>
 #include <linux/init.h>
-#include <linux/kmod.h>
 #include <linux/list.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/iio/sw_device.h>
 #include <linux/iio/configfs.h>
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index 9ae793a70b8b..66796ca59676 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -5,11 +5,14 @@
  * Copyright (c) 2015 Intel Corporation
  */
 
-#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/init.h>
-#include <linux/kmod.h>
 #include <linux/list.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/iio/sw_trigger.h>
 #include <linux/iio/configfs.h>
diff --git a/drivers/iio/industrialio-triggered-event.c b/drivers/iio/industrialio-triggered-event.c
index 4bedc65c9fe3..91179482dc4f 100644
--- a/drivers/iio/industrialio-triggered-event.c
+++ b/drivers/iio/industrialio-triggered-event.c
@@ -3,8 +3,9 @@
  * Copyright (C) 2015 Cogent Embedded, Inc.
  */
 
-#include <linux/kernel.h>
+#include <linux/err.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_event.h>
-- 
2.33.0

