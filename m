Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49E5EF7FA
	for <lists+linux-iio@lfdr.de>; Thu, 29 Sep 2022 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiI2Oqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Sep 2022 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiI2Oqd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2022 10:46:33 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FA9137464;
        Thu, 29 Sep 2022 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664462790;
  x=1695998790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CFsrUS0Wazhhw4e5WndLnkA03gM+PhS0QY5XoDf9+Ss=;
  b=BZevCYjIxUuu3VB7FAMp7cDf7Cc7tN4OuVcw6sZAMsee+1//nU7rUFOx
   3iHzH52Flkn2hOQxX8QvMEvxs5P4/McOZBvMFGkxxi+Ves5skOnrfUnao
   4rN1nSsy0J5fmM8Lw6zipaPnZag/+rMI5kc1ezsZLVRjziSs4Tv3kOIjM
   CbZC98WT+A6nhX3ljvQ7At3bYvWDQxraPO2H6iQmlwviMSX1Ytqrz241A
   gSwpPb/a5tnhPWX/48kqvxwYyy+v8izQBjut3d/IM0YXBEZFvwNBvj0AZ
   ddvJWNI8rEWKHse+xwAvfW34ANa6MFf0BSixrKcJ2GKJQHxnsN5zINVo5
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 1/2] PM: runtime: Synchronize PM runtime enable state with parent
Date:   Thu, 29 Sep 2022 16:46:17 +0200
Message-ID: <20220929144618.1086985-2-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220929144618.1086985-1-marten.lindahl@axis.com>
References: <20220929144618.1086985-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A device that creates a child character device with cdev_device_add by
default create a PM sysfs group with power attributes for userspace
control. This means that the power attributes monitors the child device
only and thus does not reflect the parent device PM runtime behavior.

But as the PM runtime framework (rpm_suspend/rpm_resume) operates not
only on a single device that has been enabled for runtime PM, but also
on its parent, it should be possible to synchronize the child and the
parent so that the power attribute monitoring reflects the child and the
parent as one.

As an example, if an i2c_client device registers an iio_device, the
iio_device will create sysfs power/attribute nodes for userspace
control. But if the dev_pm_ops with resume/suspend callbacks is attached
to the struct i2c_driver.driver.pm, the PM runtime needs to be enabled
for the i2c_client device and not for the child iio_device.

In this case PM runtime can be enabled for the i2c_client device and
suspend/resume callbacks will be triggered, but the child sysfs power
attributes will be visible but marked as 'unsupported' and can not be
used for control or monitoring. This can be confusing as the sysfs
device node presents the i2c_client and the iio_device as one device.

Add a function to synchronize the runtime PM enable state of a device
with its parent. As there already exists a link from the child to its
parent and both are enabled, all sysfs control/monitoring can reflect
both devices, which from a userspace perspective makes more sense.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/base/power/runtime.c | 18 ++++++++++++++++++
 include/linux/pm_runtime.h   |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 997be3ac20a7..b202d513684a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1499,6 +1499,24 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+/**
+ * pm_runtime_sync_parent_enable - Synchronize enable state.
+ * @dev: Device to handle.
+ *
+ * Synchronize the device enable state with its parent.
+ * NOTE: This function should only be used if the parent will never disable
+ * PM runtime (i.e. calling __pm_runtime_disable()) without telling its child.
+ */
+void pm_runtime_sync_parent_enable(struct device *dev)
+{
+	struct device *parent = dev->parent;
+
+	if (parent && !parent->power.ignore_children
+	    && pm_runtime_enabled(parent))
+		pm_runtime_enable(dev);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_sync_parent_enable);
+
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 0a41b2dcccad..5054427adbd1 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -89,6 +89,7 @@ extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
+extern void pm_runtime_sync_parent_enable(struct device *dev);
 
 extern int devm_pm_runtime_enable(struct device *dev);
 
@@ -315,6 +316,7 @@ static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
 static inline void pm_runtime_drop_link(struct device_link *link) {}
 static inline void pm_runtime_release_supplier(struct device_link *link) {}
+static inline void pm_runtime_sync_parent_enable(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 
-- 
2.30.2

