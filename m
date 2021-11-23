Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5245ADDF
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhKWVJQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234556AbhKWVJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2233C60FED;
        Tue, 23 Nov 2021 21:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701566;
        bh=3ahxVLAlJQ7dfLJzOpy8TSR9LAm9dh4QI7Mr148JFgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcG0C6rJydxb4tH5tMJWwaGIb/bHp75AoDZ8G5SIXb/lgX3N5MU6GAc5kFJn0rg20
         ya5/R+rCat0sCUwzfOR9BYHFSgMixgO+kXR58/bi4ENJBIBTfswiQ+XSgC9peGOkqf
         nT/rHY6Bv8Uetn2EPKiLxwVE5HYNxKRoUsaQWZ9X8v9nDrqzVLG+QBcFw9NdOFYi9X
         HG6arFSxJiBwPygji0QUAFIt/MmQO8oVci6EhUiD6OYu+ZNLMaFLYQQg2dPj5qkUVc
         cCIpsPyndDpOLN9s8bTQc3zuZ12orSCX+ypTwtBZ9lb5+R5lKP4zizFM9xK/wBGdLT
         ZCljWa+I9BJHw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/49] iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:38 +0000
Message-Id: <20211123211019.2271440-9-jic23@kernel.org>
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
---
 drivers/iio/accel/mma9553.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index ba3ecb3b57dc..1597806229f4 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1162,8 +1162,7 @@ static int mma9553_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mma9553_runtime_suspend(struct device *dev)
+static __maybe_unused int mma9553_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9553_data *data = iio_priv(indio_dev);
@@ -1180,7 +1179,7 @@ static int mma9553_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int mma9553_runtime_resume(struct device *dev)
+static __maybe_unused int mma9553_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9553_data *data = iio_priv(indio_dev);
@@ -1194,10 +1193,8 @@ static int mma9553_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
-static int mma9553_suspend(struct device *dev)
+static __maybe_unused int mma9553_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9553_data *data = iio_priv(indio_dev);
@@ -1210,7 +1207,7 @@ static int mma9553_suspend(struct device *dev)
 	return ret;
 }
 
-static int mma9553_resume(struct device *dev)
+static __maybe_unused int mma9553_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9553_data *data = iio_priv(indio_dev);
@@ -1222,9 +1219,8 @@ static int mma9553_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops mma9553_pm_ops = {
+static __maybe_unused const struct dev_pm_ops mma9553_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mma9553_suspend, mma9553_resume)
 	SET_RUNTIME_PM_OPS(mma9553_runtime_suspend,
 			   mma9553_runtime_resume, NULL)
@@ -1248,7 +1244,7 @@ static struct i2c_driver mma9553_driver = {
 	.driver = {
 		   .name = MMA9553_DRV_NAME,
 		   .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
-		   .pm = &mma9553_pm_ops,
+		   .pm = pm_ptr(&mma9553_pm_ops),
 		   },
 	.probe = mma9553_probe,
 	.remove = mma9553_remove,
-- 
2.34.0

