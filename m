Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802A64A3889
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355891AbiA3TZ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355899AbiA3TZz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10219C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40F2612FA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDA7C340EB;
        Sun, 30 Jan 2022 19:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570754;
        bh=ixOevcUR5wAmIaSjKRkc01cgndwZxs8My+BKhxwHINY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyWaLZc/Qm7pnY8FhI1mTfx57N2DAtApQLUYFgdZI5umL9gOyWrisjplyRpVt4rlV
         MLQHs8k1vO9aPr02KASTkqijoNKemxcO8r5tmauL/zojuLGexW3yNcxIIOTO9Zwg9u
         w8tr7xcB2Oo1Vvpwf7qq20fr9H6FNLTJS+j751a9LU4K3xxTvLA/m6vAQLAVJRAvkk
         gaWkvHvBa7cDknxySR+unuobokItjq4rj3+HjYxqv3UW9HKFntwfHCWB0J6BhPmqbm
         cq1kSNflTr9Js/2tGCB1ut85WZjr1Nz/c66aE7aq0CYSiN7CgGtRYqowl3XiYn1KOS
         sLl2bF5mKxoRQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 09/50] iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:06 +0000
Message-Id: <20220130193147.279148-10-jic23@kernel.org>
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
 drivers/iio/accel/stk8ba50.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 517c57ed9e94..0067ec5cbae8 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -504,7 +504,6 @@ static int stk8ba50_remove(struct i2c_client *client)
 	return stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stk8ba50_suspend(struct device *dev)
 {
 	struct stk8ba50_data *data;
@@ -523,12 +522,8 @@ static int stk8ba50_resume(struct device *dev)
 	return stk8ba50_set_power(data, STK8BA50_MODE_NORMAL);
 }
 
-static SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8ba50_suspend, stk8ba50_resume);
-
-#define STK8BA50_PM_OPS (&stk8ba50_pm_ops)
-#else
-#define STK8BA50_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8ba50_suspend,
+				stk8ba50_resume);
 
 static const struct i2c_device_id stk8ba50_i2c_id[] = {
 	{"stk8ba50", 0},
@@ -546,7 +541,7 @@ MODULE_DEVICE_TABLE(acpi, stk8ba50_acpi_id);
 static struct i2c_driver stk8ba50_driver = {
 	.driver = {
 		.name = "stk8ba50",
-		.pm = STK8BA50_PM_OPS,
+		.pm = pm_sleep_ptr(&stk8ba50_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk8ba50_acpi_id),
 	},
 	.probe =            stk8ba50_probe,
-- 
2.35.1

