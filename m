Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018C8482B36
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiABMv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42272 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiABMvz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBF660E9C
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0843C36AEF;
        Sun,  2 Jan 2022 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127914;
        bh=ckVlIuSt9Q2kgcuFb4ii83R8VsoTYoCMzmjYcR8P1Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+VSfiAWM5Ih6nS89LF3hjzf86K/HWZXoK/gLd5sqADGxnyo92WZyTIco7U1f7OaR
         IeYwIWmPsr0HArZvi8OQogdOPW5dqa2YWyV9148crHvdcVOWgJ8VfD9iDuw7wGZMC6
         oZUTjTHGexWqOIdW1Uf21n1guz/y4Qwvonou6hfHA/P2ApoVBBt7LycnzudpJ3N29D
         DhszvbFqe+vYaJdIIHW+RyyVZ5nhOsN+7tG0xAD9A4Xtr0T95r2Co6HTZZXqFpvpFT
         WAlCrWeAN5n8CcFai+WVcgbmOsfMxzgXC4ljnzDrxKdAgB49zKuIfdfAqEMG2Ww460
         IXS72MhVJ/0eA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 23/51] iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:49 +0000
Message-Id: <20220102125617.1259804-24-jic23@kernel.org>
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/bh1780.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index abbf2e662e7d..e30f0bb4e6ca 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -221,7 +221,6 @@ static int bh1780_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int bh1780_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -256,13 +255,10 @@ static int bh1780_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops bh1780_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(bh1780_runtime_suspend,
-			   bh1780_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(bh1780_runtime_suspend, bh1780_runtime_resume, NULL)
 };
 
 static const struct i2c_device_id bh1780_id[] = {
@@ -284,7 +280,7 @@ static struct i2c_driver bh1780_driver = {
 	.id_table	= bh1780_id,
 	.driver = {
 		.name = "bh1780",
-		.pm = &bh1780_dev_pm_ops,
+		.pm = pm_ptr(&bh1780_dev_pm_ops),
 		.of_match_table = of_bh1780_match,
 	},
 };
-- 
2.34.1

