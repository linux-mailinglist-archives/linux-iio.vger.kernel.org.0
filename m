Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7EE7D23BC
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjJVPrg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjJVPrf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C22F4
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5266DC433C9;
        Sun, 22 Oct 2023 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989653;
        bh=yaL/Tdkx0HZY6R7xVKerDQOGc7BnZ9SP9TWWUJOUwY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bP4UEBWEjL7+MPET/wHlVZFIlUjPtd2y0S8geD69Q7S7Y59T6PiJ5jz+MJCkZsr9I
         tE/LS+bJ2X6jCmo9a5uyd4G41je85MFY5ZGN9TYueuBuJfZAPvWtqP3O2PUMrMxoJ/
         VuWDxYY2a2XZVxGCDvIDKuadYtF6MPN4TRei70iQSIW99eYYSPOvPoO9Tf9OAxV4VQ
         3/mbv84+Wbzmn4y/Lh/aDYIr8qw9FoTnDnIVvA02Zy07eaZqGYlqUVyeW4NWAR4RzE
         TbqIx7mIl1Oa7Nm1ZTV5hcbQrBCGrWY7BpmNRlWcAEsTGJ6bdN4lSTbgI4GrwfFT+n
         IbOGs6pRK8ACA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based direct mode claiming infrastructure
Date:   Sun, 22 Oct 2023 16:47:03 +0100
Message-ID: <20231022154710.402590-2-jic23@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022154710.402590-1-jic23@kernel.org>
References: <20231022154710.402590-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Allows use of:

	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
	if (IS_ERR(claimed_dev))
		return PTR_ERR(claimed_dev);

	st = iio_priv(claimed_dev);

to automatically call iio_device_release_direct_mode() based on scope.
Typically seen in combination with local device specific locks which
are already have automated cleanup options via guard(mutex)(&st->lock)
and scoped_guard().  Using both together allows most error handling to
be automated.

Note that whilst this pattern results in a struct iio_dev *claimed_dev
that can be used, it is not necessary to do so as long as that pointer
has been checked for errors as in the example.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c |  4 ++++
 include/linux/iio/iio.h         | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..93bfad105eb5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2065,6 +2065,10 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
  */
 void iio_device_release_direct_mode(struct iio_dev *indio_dev)
 {
+	/* Auto cleanup can result in this being called with an ERR_PTR */
+	if (IS_ERR(indio_dev))
+		return;
+
 	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
 }
 EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d0ce3b71106a..11c42170fda1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
@@ -644,6 +645,30 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
+/*
+ * Auto cleanup version of iio_device_claim_direct_mode,
+ *
+ *	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+ *	if (IS_ERR(claimed_dev))
+ *		return PTR_ERR(claimed_dev);
+ *
+ *	st = iio_priv(claimed_dev);
+ *	....
+ */
+DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
+	     iio_device_release_direct_mode(_T),
+	     ({
+			struct iio_dev *dev;
+			int d = iio_device_claim_direct_mode(_T);
+
+			if (d < 0)
+				dev = ERR_PTR(d);
+			else
+				dev = _T;
+			dev;
+	     }),
+	     struct iio_dev *_T);
+
 int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
 void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
 
-- 
2.42.0

