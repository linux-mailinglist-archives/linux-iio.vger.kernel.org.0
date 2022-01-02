Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56457482B23
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiABMvG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABMvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8480EC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CED7B80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B755C36AEE;
        Sun,  2 Jan 2022 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127863;
        bh=o7lqiSwj9bEqy5RTn/pCfP4IzoQ2vcNtSOCLIJZCZpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTcENiGvZP1q+xowH0RkDEgy1KWFV8jftToUoT5MVsFA704lNeI8gB200r8kxDUl9
         Gn7dkzoBIQGJbxx2z3qv3ZdGtLmM1lJmYTQ4pOaa7+Lt2DfKsaRULqa8ULkc7M184n
         JICd0tbgFzXntpzGrW99Vi4k8BLuHObMpO2CN19R5Gb2KRxCoXF66aKoDtJlJAx5UV
         8AiLUDLPOlH2RgBKZNboNQBlc/yAtkuCyF5O0LmWQ+O5NkGPa9h2jMltVADsBGjzOd
         7M4x+FxI9WYBcbNwZ4neK0kVH4kuiLgocRl6zvypklTqaEcnWEGVe6+2YhsZUtV+a1
         YG7Xw/ULG0VKg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 04/51] iio:accel:dmard10: Switch from CONFIG_PM guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:30 +0000
Message-Id: <20220102125617.1259804-5-jic23@kernel.org>
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
 drivers/iio/accel/dmard10.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index f9f173eec202..bef21aa2aeb5 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/compiler.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -218,7 +219,6 @@ static int dmard10_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dmard10_suspend(struct device *dev)
 {
 	return dmard10_shutdown(to_i2c_client(dev));
@@ -228,9 +228,8 @@ static int dmard10_resume(struct device *dev)
 {
 	return dmard10_reset(to_i2c_client(dev));
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend, dmard10_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend, dmard10_resume);
 
 static const struct i2c_device_id dmard10_i2c_id[] = {
 	{"dmard10", 0},
@@ -241,7 +240,7 @@ MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
 static struct i2c_driver dmard10_driver = {
 	.driver = {
 		.name = "dmard10",
-		.pm = &dmard10_pm_ops,
+		.pm = pm_sleep_ptr(&dmard10_pm_ops),
 	},
 	.probe		= dmard10_probe,
 	.id_table	= dmard10_i2c_id,
-- 
2.34.1

