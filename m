Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BCC4A38A0
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355938AbiA3T0p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355928AbiA3T0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33041C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0550612EC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF35C340F1;
        Sun, 30 Jan 2022 19:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570803;
        bh=i0y3hVORmUMCvZN0pknsN1TqbYOjQ+qOPtggmZahlGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JH9z/21SzZ4FyVvwzBzNUUjs7+Roc3TZC3GP31i6K2smSoNicZewmLnNNQSN9UsmD
         NhIgRkj4wTauwQ8cIn3QK1CVpncStMMb2ChbEZAQi3SYFvEMMIecmKsL7zjtg8n68M
         pg7epww5g84YNaNsETVqwQ2uRd/zLtpyBdc1TJgGkqnRWVI7JhVYY0/3RuHGWbbg49
         L8yMgvf7YatF+pHtSq2XtbKRS7fVsH6+OJ6BiE/sIOmbQ0NHsGWNOu6FsGooawoiYt
         9khhA5dN+mT6UVtC2MgegpAy3gF0usf41vVkjGiFi9auwrfKYoXyaQNw70zAnBNbJ1
         KPVVkTURLgB1A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 32/50] iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:29 +0000
Message-Id: <20220130193147.279148-33-jic23@kernel.org>
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
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/mpl3115.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index e95b9a5475b4..d4f89e4babed 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -301,7 +301,6 @@ static int mpl3115_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mpl3115_suspend(struct device *dev)
 {
 	return mpl3115_standby(iio_priv(i2c_get_clientdata(
@@ -317,11 +316,8 @@ static int mpl3115_resume(struct device *dev)
 		data->ctrl_reg1);
 }
 
-static SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend, mpl3115_resume);
-#define MPL3115_PM_OPS (&mpl3115_pm_ops)
-#else
-#define MPL3115_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend,
+				mpl3115_resume);
 
 static const struct i2c_device_id mpl3115_id[] = {
 	{ "mpl3115", 0 },
@@ -339,7 +335,7 @@ static struct i2c_driver mpl3115_driver = {
 	.driver = {
 		.name	= "mpl3115",
 		.of_match_table = mpl3115_of_match,
-		.pm	= MPL3115_PM_OPS,
+		.pm	= pm_sleep_ptr(&mpl3115_pm_ops),
 	},
 	.probe = mpl3115_probe,
 	.remove = mpl3115_remove,
-- 
2.35.1

