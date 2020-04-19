Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87BF1AFBAB
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgDSPPq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgDSPPq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:15:46 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54607214D8;
        Sun, 19 Apr 2020 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587309346;
        bh=cQ9U94UnrbUT8HgyDQm3AZwdy/gyoQAPtkqTjvyUzsk=;
        h=From:To:Cc:Subject:Date:From;
        b=GjqvAql2t+nh9DMbZlCojUZKnSlyzm7yP1PBSOyjb5sNtWoOdvyU9xRs8SLbLGpiW
         Lhuqi7vfgX900NS8O6Kl1KCMl+UvZJruLqM7x/bC85lUjKlc3M8/8ewVJfdunI/eok
         IWECPTDzIpIK0Sy0y6gLkvRkLQp+xtE/lmqe+QbY=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: Use an early return in iio_device_alloc to simplify code.
Date:   Sun, 19 Apr 2020 16:13:37 +0100
Message-Id: <20200419151337.43293-1-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Noticed whilst reviewing Alexandru's patch to the same function.
If we simply flip the logic and return NULL immediately after memory
allocation failure we reduce the indent of the following block and
end up with more 'idiomatic' kernel code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 38 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f4daf19f2a3b..96f6dacb206d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1504,27 +1504,27 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	alloc_size += IIO_ALIGN - 1;
 
 	dev = kzalloc(alloc_size, GFP_KERNEL);
+	if (!dev)
+		return NULL;
 
-	if (dev) {
-		dev->dev.groups = dev->groups;
-		dev->dev.type = &iio_device_type;
-		dev->dev.bus = &iio_bus_type;
-		device_initialize(&dev->dev);
-		dev_set_drvdata(&dev->dev, (void *)dev);
-		mutex_init(&dev->mlock);
-		mutex_init(&dev->info_exist_lock);
-		INIT_LIST_HEAD(&dev->channel_attr_list);
-
-		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
-		if (dev->id < 0) {
-			/* cannot use a dev_err as the name isn't available */
-			pr_err("failed to get device id\n");
-			kfree(dev);
-			return NULL;
-		}
-		dev_set_name(&dev->dev, "iio:device%d", dev->id);
-		INIT_LIST_HEAD(&dev->buffer_list);
+	dev->dev.groups = dev->groups;
+	dev->dev.type = &iio_device_type;
+	dev->dev.bus = &iio_bus_type;
+	device_initialize(&dev->dev);
+	dev_set_drvdata(&dev->dev, (void *)dev);
+	mutex_init(&dev->mlock);
+	mutex_init(&dev->info_exist_lock);
+	INIT_LIST_HEAD(&dev->channel_attr_list);
+
+	dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
+	if (dev->id < 0) {
+		/* cannot use a dev_err as the name isn't available */
+		pr_err("failed to get device id\n");
+		kfree(dev);
+		return NULL;
 	}
+	dev_set_name(&dev->dev, "iio:device%d", dev->id);
+	INIT_LIST_HEAD(&dev->buffer_list);
 
 	return dev;
 }
-- 
2.26.1

