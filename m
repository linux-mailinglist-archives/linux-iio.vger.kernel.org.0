Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01646482B40
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiABMwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50904 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiABMwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26030B80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C605C36AEF;
        Sun,  2 Jan 2022 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127943;
        bh=hIk0ywvsDdMP/BkbsNBlWATUD+l01AY93ob+96I9Duc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HahNv9CaTvZbE1JyzwmGWTNi001ivmhD8GaSPENK195L4yCiIpcVmpmdCa/DvM6IS
         l+1sq+x1F5zETbdU3j/BbIv+tw7DgjgHyyLH1E7C+ULmYq5p+coSKd4k7k2GwJVilB
         aMoOiDGLD0SakqCOL1mcINH6GGgvp7JVv9E0GpsNd0zq8LJlw/T8M/44jaAttSyoPK
         m0Vu9CGwB5VNd1aYkQq5avKX3LUW+Z8bhammVxF3CEUjlVyqLPwB6nXmyUmZWODN0x
         vGhepVIwKaZ9EusB30hDdpQIu2tfemCVUDgpquim6bXc3dEfFTRWul34WDHDvpOjWM
         Y/ms9UUgxDjKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 33/51] iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:59 +0000
Message-Id: <20220102125617.1259804-34-jic23@kernel.org>
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
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/tsl4531.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 70505ba6d858..637ae1a765fb 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -215,7 +215,6 @@ static int tsl4531_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tsl4531_suspend(struct device *dev)
 {
 	return tsl4531_powerdown(to_i2c_client(dev));
@@ -227,11 +226,7 @@ static int tsl4531_resume(struct device *dev)
 		TSL4531_MODE_NORMAL);
 }
 
-static SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend, tsl4531_resume);
-#define TSL4531_PM_OPS (&tsl4531_pm_ops)
-#else
-#define TSL4531_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend, tsl4531_resume);
 
 static const struct i2c_device_id tsl4531_id[] = {
 	{ "tsl4531", 0 },
@@ -242,7 +237,7 @@ MODULE_DEVICE_TABLE(i2c, tsl4531_id);
 static struct i2c_driver tsl4531_driver = {
 	.driver = {
 		.name   = TSL4531_DRV_NAME,
-		.pm	= TSL4531_PM_OPS,
+		.pm	= pm_sleep_ptr(&tsl4531_pm_ops),
 	},
 	.probe  = tsl4531_probe,
 	.remove = tsl4531_remove,
-- 
2.34.1

