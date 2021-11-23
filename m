Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D245ADD8
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhKWVJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbhKWVJC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC6760FC3;
        Tue, 23 Nov 2021 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701553;
        bh=R43Tfs1kPPYp4Fze8UGKrx3HgzcdvmqB9L9VxHJ4aEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVWyndx6wzrwZT3DPVCwJsEADXrueX67L6iXdSrhI/SGbIq2GVTPKkxBvjOlHJEOo
         rKZO2M7R4kPYWTAPG+QNLNUUDwSt4pQiO+/6/Beel/DQ7kfqx3Xd0eiExxt1xqtwRU
         aubl6YiM+W3Sn8VybFjDejnSMzYt/wu162PWFx7+HLZ/OLSOEG8hF2otu2k5JVtbi0
         jPMtCwc92GPlveEREnxMQ/nKcGLHYn9U6MtWW45aVMvv/7IK+201218IihwxuMkCOE
         yH2J7+P7WD6uofX1MmPPqHCZ8nUrBwoYpbeq5m5byEFVHGbxjiXZO/SHk+qODqcwjh
         VkEpiQSsXqbWg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/49] iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:31 +0000
Message-Id: <20211123211019.2271440-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/da311.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 04e13487e706..b65f47dc4945 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -256,17 +256,15 @@ static int da311_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int da311_suspend(struct device *dev)
+static __maybe_unused int da311_suspend(struct device *dev)
 {
 	return da311_enable(to_i2c_client(dev), false);
 }
 
-static int da311_resume(struct device *dev)
+static __maybe_unused int da311_resume(struct device *dev)
 {
 	return da311_enable(to_i2c_client(dev), true);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
 
@@ -279,7 +277,7 @@ MODULE_DEVICE_TABLE(i2c, da311_i2c_id);
 static struct i2c_driver da311_driver = {
 	.driver = {
 		.name = "da311",
-		.pm = &da311_pm_ops,
+		.pm = pm_ptr(&da311_pm_ops),
 	},
 	.probe		= da311_probe,
 	.id_table	= da311_i2c_id,
-- 
2.34.0

