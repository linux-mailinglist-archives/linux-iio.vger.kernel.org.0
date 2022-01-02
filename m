Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC47482B42
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiABMwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiABMwa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34198C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAEAF60E9B
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED94C36AF0;
        Sun,  2 Jan 2022 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127949;
        bh=+DJy83NSRGQhELyr2F69FbnstrJALz6NHbLXCMjy+/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnJUwzXPxJpunvWJYbyBUAA1PKJT+vbrppBOysz7I0Z1C2cxPZmVsxmWmRSw0i+Cv
         D7iLzQZDTrEDUJ4Dkv1LsF5yd21GBD2xbGTcF+/4rePgR6Nt5JJPVMVmogAkf6jzZD
         cF/cBgzHM4aAr5PSSVLZ2G3ujYaFNMCAH/+HhYG1P7M/neW0zPuKfj7mMrPUzVGe9T
         7So3CavcxKB3+KfHLiX04+uUQvTXJE4Qq7EQ3/jFCAXGWJ4l5cmqfOG/GM7oS742nY
         zFf1r3WIkj1X8mx7temvjz0JYP+I5gtr+I9ktiC6epMHb7z+HYga+0gUwtvOKBWLSp
         dCF8HQGm/97Rg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 35/51] iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:01 +0000
Message-Id: <20220102125617.1259804-36-jic23@kernel.org>
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

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 55879a20ae52..103d2f751c9f 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1033,7 +1033,6 @@ static int ak8975_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int ak8975_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1074,13 +1073,10 @@ static int ak8975_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops ak8975_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(ak8975_runtime_suspend,
-			   ak8975_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(ak8975_runtime_suspend, ak8975_runtime_resume, NULL)
 };
 
 static const struct i2c_device_id ak8975_id[] = {
@@ -1113,7 +1109,7 @@ MODULE_DEVICE_TABLE(of, ak8975_of_match);
 static struct i2c_driver ak8975_driver = {
 	.driver = {
 		.name	= "ak8975",
-		.pm = &ak8975_dev_pm_ops,
+		.pm = pm_ptr(&ak8975_dev_pm_ops),
 		.of_match_table = ak8975_of_match,
 		.acpi_match_table = ak_acpi_match,
 	},
-- 
2.34.1

