Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081DE4A3888
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355887AbiA3TZ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35842 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355893AbiA3TZw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1CA9612F1
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87467C340F0;
        Sun, 30 Jan 2022 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570752;
        bh=zgj9UC7lnO50VdQPlszMjeVc30D5w3OjvZ5AofUKymM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zb49PRJUxwEah6pkJtZOhckqh74LwwTDE5Fdg45+BUN5qhkZabyW8h5RyEqH8hre7
         4lkZv75kOXXg0Pzpti7RGORsmeFb+4s6Y0a5RPH2KtFIOVSderbZfPTieByFju77YW
         /EOLanMCoQVBhyKZIhA+a5wyX1Q7RQZZrLvY31t323XUPUy4XhM56QqMOvwNl+gf0R
         AYvzriBSpQvm9pOajNKlwbhlaYk2s61fFW9FPrrUbHcjnfhVKZDmNa0EUwtol2Px3a
         V4mazTkAuTt6JvmBu98OC+pNMXezNVbeD/lyi4fbZo5TBsO2+bOp/t7Fm0JVewfL+v
         lrtsYS3z7vtwA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 08/50] iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:05 +0000
Message-Id: <20220130193147.279148-9-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
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
2.35.1

