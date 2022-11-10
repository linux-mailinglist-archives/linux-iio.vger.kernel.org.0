Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1874262432F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Nov 2022 14:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKJN2P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Nov 2022 08:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiKJN2C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2022 08:28:02 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5023477228
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2022 05:27:57 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7N1T5H9Hz15MMp;
        Thu, 10 Nov 2022 21:27:41 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 21:27:54 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <jic23@kernel.org>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <liwei391@huawei.com>,
        <zengheng4@huawei.com>
Subject: [PATCH] iio: fix kobject_put warning in iio_device_register
Date:   Thu, 10 Nov 2022 21:26:15 +0800
Message-ID: <20221110132615.331454-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is warning reported by kobject lib in kobject_put():

kobject: '(null)' (00000000be81a546): is not initialized, yet kobject_put() is being called.
WARNING: CPU: 0 PID: 535 at lib/kobject.c:718 kobject_put+0x12c/0x180
Call Trace:
 cdev_device_add
 __iio_device_register
 __devm_iio_device_register
 tmp117_probe

If don't need to register chardev for most of IIO devices,
we just register them with device_add() only, and use device_del()
to unregister them.

Otherwise, when device_add() fails in internal and calls kobject_put()
in error handling path, it would report warning because the device
never be registered as chardev and there is no release function for it.

Fixes: 8ebaa3ff1e71 ("iio: core: register chardev only if needed")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/iio/industrialio-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 151ff3993354..f4f48bda07f7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1982,7 +1982,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	/* assign device groups now; they should be all registered now */
 	indio_dev->dev.groups = iio_dev_opaque->groups;
 
-	ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
+	if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface)
+		ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
+	else
+		ret = device_add(&indio_dev->dev);
+
 	if (ret < 0)
 		goto error_unreg_eventset;
 
@@ -2008,7 +2012,10 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
-	cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
+	if (iio_dev_opaque->chrdev.kobj.state_initialized)
+		cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
+	else
+		device_del(&indio_dev->dev);
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
 
-- 
2.25.1

