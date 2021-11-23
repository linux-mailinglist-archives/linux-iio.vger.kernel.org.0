Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91EF45AE09
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbhKWVKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240334AbhKWVKe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1619260FE8;
        Tue, 23 Nov 2021 21:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701645;
        bh=mBjZPkhTJAlcqWthrXDVyp7eMz51l6280njDVIvnVt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwwsmAzSQwHvBQp6YKWc0fCPfVkuj149Rse7R34oAWaNID170xzDik4KCa881EI/Y
         clCX2UYat5vvi8WRRBSVDq4t5cMmYvKfkybcmVGqXQho9tsemC3HtGmqDbHOYoTb/H
         2S+cYloGMIYSqga8rwmkGETUKoUQeQdXhzljJUiPMrLbg2ilkPP8DKPoepG85u0Axw
         W80NNuVNbtRc+99h4l/kygCBti1H9pAGZYNGeVQlso6lUBbCDzq0WqsFO37XOiA+05
         tNIYqumQkn8J5ULU5uMQUlpCbxLNSSM3cAu3j3iE5Vu9nI6TVCfcJBMRbEBXOZ6Kyo
         Gd4VXuLzvufdg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 48/49] iio:gyro:mpu3050: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:18 +0000
Message-Id: <20211123211019.2271440-49-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 8 +++-----
 drivers/iio/gyro/mpu3050-i2c.c  | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ea387efab62d..4ec107b9e779 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1281,19 +1281,17 @@ int mpu3050_common_remove(struct device *dev)
 }
 EXPORT_SYMBOL(mpu3050_common_remove);
 
-#ifdef CONFIG_PM
-static int mpu3050_runtime_suspend(struct device *dev)
+static __maybe_unused int mpu3050_runtime_suspend(struct device *dev)
 {
 	return mpu3050_power_down(iio_priv(dev_get_drvdata(dev)));
 }
 
-static int mpu3050_runtime_resume(struct device *dev)
+static __maybe_unused int mpu3050_runtime_resume(struct device *dev)
 {
 	return mpu3050_power_up(iio_priv(dev_get_drvdata(dev)));
 }
-#endif /* CONFIG_PM */
 
-const struct dev_pm_ops mpu3050_dev_pm_ops = {
+const __maybe_unused struct dev_pm_ops mpu3050_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(mpu3050_runtime_suspend,
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index ef5bcbc4b45b..820133cad601 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -114,7 +114,7 @@ static struct i2c_driver mpu3050_i2c_driver = {
 	.driver = {
 		.of_match_table = mpu3050_i2c_of_match,
 		.name = "mpu3050-i2c",
-		.pm = &mpu3050_dev_pm_ops,
+		.pm = pm_ptr(&mpu3050_dev_pm_ops),
 	},
 };
 module_i2c_driver(mpu3050_i2c_driver);
-- 
2.34.0

