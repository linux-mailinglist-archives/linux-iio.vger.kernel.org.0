Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF7482B26
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiABMvP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50232 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiABMvN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FB3EB80CFC
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B599C36AF1;
        Sun,  2 Jan 2022 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127871;
        bh=LZetR1ZDWzR2JgV6qL0ug7vm2mNft1irvtNXOZ42yK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmsgsbgLHui5lvm49PCpG95F9McJhu8CrSNYQjhVelc1bdff0XTSskWCkOeH4e16W
         JyAllBg2n2VSzocwxLR0uM8eUMl+JbAQFzQBbpBzwWcHarDoZ5pIogMbth+SstpKLH
         kGfZ7LH1LfJdjDgo3XpenI707HaMvbQXkfQBRS5YkeHw19UguLuvuf4PXcCZKkd6gT
         ptDnlo/2Ew0JEHJ0wos6zdG8znEui+RhHVNdbtkHJBGTIcKuxxmSyLHBtZ3LzNCGWR
         3TNrk3NKBU+lkYclydlzOEVzJIs/PZL6ww/SlkumzujPSC856ckkESbk4nURrV5dRk
         jPwdl7VN0cwtA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 07/51] iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:33 +0000
Message-Id: <20220102125617.1259804-8-jic23@kernel.org>
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
 drivers/iio/accel/mma9551.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 4c359fb05480..fb9c8fac5911 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -523,7 +523,6 @@ static int mma9551_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int mma9551_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -555,9 +554,7 @@ static int mma9551_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
 static int mma9551_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -583,12 +580,10 @@ static int mma9551_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops mma9551_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mma9551_suspend, mma9551_resume)
-	SET_RUNTIME_PM_OPS(mma9551_runtime_suspend,
-			   mma9551_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mma9551_suspend, mma9551_resume)
+	RUNTIME_PM_OPS(mma9551_runtime_suspend, mma9551_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id mma9551_acpi_match[] = {
@@ -609,7 +604,7 @@ static struct i2c_driver mma9551_driver = {
 	.driver = {
 		   .name = MMA9551_DRV_NAME,
 		   .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
-		   .pm = &mma9551_pm_ops,
+		   .pm = pm_ptr(&mma9551_pm_ops),
 		   },
 	.probe = mma9551_probe,
 	.remove = mma9551_remove,
-- 
2.34.1

