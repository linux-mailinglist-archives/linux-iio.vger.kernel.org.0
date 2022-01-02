Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED740482B35
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiABMvy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiABMvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1AEC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBD3A60E98
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FE5C36AEE;
        Sun,  2 Jan 2022 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127912;
        bh=Fwlcn5rhlXyW5tMX7641kM2AdBqt/ktY68zN480QONo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7+cOqwe0Mb0vVxzZOlnAxr0KdjWxKNlIM5ZiZ3rR3sdJu/9HHFdskvxWUYjUSiPT
         7+4PdrCmAfoAlAnfnCBSfGj9l/Yw8ii1B4FhsiTqHMRZHVJkHTDq6ZzNJVw7EYOU46
         Rnq1TtyhvPKMQJp8mm8VvloQzMS1SDBN3vzvEW3OcEouEyGJaTnxNv2f9HJaWWuek0
         C8QrhMPlsYE4f/OUl8seei00QJ5OxZiy8p4KtCPorZ8zASoBByc2Uwq73PiBp5Pf5D
         T2sgfd+xD9mm86/U8FxDUo4rxQizlNOU7Pz9bwhFutbtfF9FZrykcaxxeqszV3xvsz
         Wxf9ZknfIu5AA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 22/51] iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:48 +0000
Message-Id: <20220102125617.1259804-23-jic23@kernel.org>
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
 drivers/iio/light/apds9300.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index baaf202dce05..b1e36e0954de 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -466,7 +466,6 @@ static int apds9300_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int apds9300_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -493,11 +492,7 @@ static int apds9300_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend, apds9300_resume);
-#define APDS9300_PM_OPS (&apds9300_pm_ops)
-#else
-#define APDS9300_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend, apds9300_resume);
 
 static const struct i2c_device_id apds9300_id[] = {
 	{ APDS9300_DRV_NAME, 0 },
@@ -509,7 +504,7 @@ MODULE_DEVICE_TABLE(i2c, apds9300_id);
 static struct i2c_driver apds9300_driver = {
 	.driver = {
 		.name	= APDS9300_DRV_NAME,
-		.pm	= APDS9300_PM_OPS,
+		.pm	= pm_sleep_ptr(&apds9300_pm_ops),
 	},
 	.probe		= apds9300_probe,
 	.remove		= apds9300_remove,
-- 
2.34.1

