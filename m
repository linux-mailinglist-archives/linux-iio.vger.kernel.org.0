Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4139C4A389D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355932AbiA3T0k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51724 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355928AbiA3T0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1946BB829AA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9818C340EB;
        Sun, 30 Jan 2022 19:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570796;
        bh=/FC/jv/ZQPM6Akku/zd11rV0jO6jG1ScrkLCWLDnyR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9/VSF/sHTQ0G+QeMlQxYSJR4ZYmYUrWosZKbZC4INtkILwPW32m4jGOvtNF+q5BO
         H320+5V3n6ijZRgtTNpaMfeyn6lu8KWP1949b6jkpocWErq27JI7FSujJDJl6wSxbj
         qBySpo990Y2mIErgsLq4nfafRuWPAKFbLDbLcBhr+NfKXg9rB0cWXBfGT8JFtO3p0G
         kQMM+xGifdDLNe8UGX5KOyrt7pxqkeja/xyvjZFYCpVCkgiM4YcHjgo3jdtHkByIQn
         tVbyHfGdXYSSE8+7wdInvywwzVV+RQVxZ/FgYU0j1UMmIkTFcI7ZUQj0QibAvCD+6K
         BCb5rNnaCH8PA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 29/50] iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:26 +0000
Message-Id: <20220130193147.279148-30-jic23@kernel.org>
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

Use the new DEFINE_RUNTIME_DEV_PM_OPS() macro to reduce boilerplate.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 55879a20ae52..088f748b683e 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1033,7 +1033,6 @@ static int ak8975_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int ak8975_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1074,14 +1073,9 @@ static int ak8975_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
-static const struct dev_pm_ops ak8975_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(ak8975_runtime_suspend,
-			   ak8975_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ak8975_dev_pm_ops, ak8975_runtime_suspend,
+				 ak8975_runtime_resume, NULL);
 
 static const struct i2c_device_id ak8975_id[] = {
 	{"ak8975", AK8975},
@@ -1113,7 +1107,7 @@ MODULE_DEVICE_TABLE(of, ak8975_of_match);
 static struct i2c_driver ak8975_driver = {
 	.driver = {
 		.name	= "ak8975",
-		.pm = &ak8975_dev_pm_ops,
+		.pm = pm_ptr(&ak8975_dev_pm_ops),
 		.of_match_table = ak8975_of_match,
 		.acpi_match_table = ak_acpi_match,
 	},
-- 
2.35.1

