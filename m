Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AE836B850
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhDZRvT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237003AbhDZRvT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B3C661185;
        Mon, 26 Apr 2021 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459437;
        bh=cyw2lXDsHJN3i/Xxg2XtLHHHSyZxoDTyvoQHxdwSYNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/3bNnnNmGLdTGs415qOdlZWQtH9/WUqJNhz59pJEkw2HkMttdhjusCtzBCe6Gwh8
         h8AHw9722StJGYQ45Kj69/Lkmm+F4xiRoXdlDArDxmPZWr4H/qL8MB3ftqaJSFrHMU
         DOP9rU0OG0z4tmZDC8xEeg36J05h+oFUBX3jmT0vecy2RIfHr0S41AAhScAAZuqeNW
         M1//e/3c7rNmfH2FyQkGMuk4OXVJYh36OEXEB8MNYZgUiCCEl3zzJ9sjjeAUgSQt1k
         8uCOkhiddvXpnu0/GkuyGieKD019RTkqwwJlzFzfjpX+u2NlpQ+oyoiOjXlBcjNCev
         hu5gwRH9XL5aA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/9] iio: core: move @driver_module from struct iio_dev to struct iio_dev_opaque
Date:   Mon, 26 Apr 2021 18:49:05 +0100
Message-Id: <20210426174911.397061-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174911.397061-1-jic23@kernel.org>
References: <20210426174911.397061-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Continuing move to hide internal elements from drivers, move this structure
element over.  It's only accessed from iio core files so this one was
straight forward and no accessor functions are needed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c    | 2 +-
 drivers/iio/industrialio-trigger.c | 9 ++++++---
 include/linux/iio/iio-opaque.h     | 2 ++
 include/linux/iio/iio.h            | 3 ---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c16b8f344c93..8c38f1f6e075 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1859,7 +1859,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (!indio_dev->info)
 		return -EINVAL;
 
-	indio_dev->driver_module = this_mod;
+	iio_dev_opaque->driver_module = this_mod;
 	/* If the calling driver did not initialize of_node, do it here */
 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
 		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 3236647b2c37..b489eeeb0004 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/iio-opaque.h>
 #include <linux/iio/trigger.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
@@ -240,12 +241,13 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 				 struct iio_poll_func *pf)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(pf->indio_dev);
 	bool notinuse =
 		bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 	int ret = 0;
 
 	/* Prevent the module from being removed whilst attached to a trigger */
-	__module_get(pf->indio_dev->driver_module);
+	__module_get(iio_dev_opaque->driver_module);
 
 	/* Get irq number */
 	pf->irq = iio_trigger_get_irq(trig);
@@ -284,13 +286,14 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 out_put_irq:
 	iio_trigger_put_irq(trig, pf->irq);
 out_put_module:
-	module_put(pf->indio_dev->driver_module);
+	module_put(iio_dev_opaque->driver_module);
 	return ret;
 }
 
 int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 				 struct iio_poll_func *pf)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(pf->indio_dev);
 	bool no_other_users =
 		bitmap_weight(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER) == 1;
 	int ret = 0;
@@ -304,7 +307,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 		trig->attached_own_device = false;
 	iio_trigger_put_irq(trig, pf->irq);
 	free_irq(pf->irq, pf);
-	module_put(pf->indio_dev->driver_module);
+	module_put(iio_dev_opaque->driver_module);
 
 	return ret;
 }
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index f876e3aede2c..96dd265103d0 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -7,6 +7,7 @@
  * struct iio_dev_opaque - industrial I/O device opaque information
  * @indio_dev:			public industrial I/O device information
  * @id:			used to identify device internally
+ * @driver_module:		used to make it harder to undercut users
  * @event_interface:		event chrdevs associated with interrupt lines
  * @attached_buffers:		array of buffers statically attached by the driver
  * @attached_buffers_cnt:	number of buffers in the array of statically attached buffers
@@ -28,6 +29,7 @@
 struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
 	int				id;
+	struct module			*driver_module;
 	struct iio_event_interface	*event_interface;
 	struct iio_buffer		**attached_buffers;
 	unsigned int			attached_buffers_cnt;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 569861d5887a..9e8e1358a032 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -488,7 +488,6 @@ struct iio_buffer_setup_ops {
 
 /**
  * struct iio_dev - industrial I/O device
- * @driver_module:	[INTERN] used to make it harder to undercut users
  * @modes:		[DRIVER] operating modes supported by device
  * @currentmode:	[DRIVER] current operating mode
  * @dev:		[DRIVER] device structure, should be assigned a parent
@@ -522,8 +521,6 @@ struct iio_buffer_setup_ops {
  *			**MUST** be accessed **ONLY** via iio_priv() helper
  */
 struct iio_dev {
-	struct module			*driver_module;
-
 	int				modes;
 	int				currentmode;
 	struct device			dev;
-- 
2.31.1

