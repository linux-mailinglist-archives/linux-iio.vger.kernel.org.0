Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6F482B27
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiABMvR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiABMvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98BC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2997B80D63
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC442C36AEE;
        Sun,  2 Jan 2022 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127873;
        bh=rHMK/ACxe3+nkt7jIewrKxcZNlE5XVcXlFI1gHcyfSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQzsUIJLdM1j/FAxslQtxsQjp/VMn1wm4tCo/8n3yk2/Gd534fFcwl5UuWINzroT0
         DPBTNjMXunR5e4Vxhz3WFYhfCFn4SHJxh4Xf4irh8fmJPgqjwb6uFjauLZH6hpWfyU
         EhSXWQOgnsHaA2QdADdYECzGaMYwN8qXSnEIznFoF/MiCUotKB82onS++Q2aSp2XDd
         UOb7qQ4a4REBifOYH2FFbAB7k1Eft6uBiUuX6bIk9OFjXQ/HncVxqe7KGFH5vj7EtU
         EytIM7Jl4bc9R7IR/5PCiFweq8opa9W9Ui4ro26KukTDy5Xs/QGVlWg7v0AhkU0FSr
         KdW6ys24428Gg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 08/51] iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:34 +0000
Message-Id: <20220102125617.1259804-9-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102125617.1259804-1-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma9553.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 0570ab1cc064..673e5c4beefe 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1162,7 +1162,6 @@ static int mma9553_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int mma9553_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1194,9 +1193,7 @@ static int mma9553_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
 static int mma9553_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1222,12 +1219,10 @@ static int mma9553_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops mma9553_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mma9553_suspend, mma9553_resume)
-	SET_RUNTIME_PM_OPS(mma9553_runtime_suspend,
-			   mma9553_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mma9553_suspend, mma9553_resume)
+	RUNTIME_PM_OPS(mma9553_runtime_suspend, mma9553_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id mma9553_acpi_match[] = {
@@ -1248,7 +1243,7 @@ static struct i2c_driver mma9553_driver = {
 	.driver = {
 		   .name = MMA9553_DRV_NAME,
 		   .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
-		   .pm = &mma9553_pm_ops,
+		   .pm = pm_ptr(&mma9553_pm_ops),
 		   },
 	.probe = mma9553_probe,
 	.remove = mma9553_remove,
-- 
2.34.1

