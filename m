Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74C645ADDE
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhKWVJQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234379AbhKWVJN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61BFE60FF2;
        Tue, 23 Nov 2021 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701564;
        bh=Gbt4voC8hgHwcweps9671ptb+T5/TG70en/Xs8lCE3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipxQOlTU9elwTAgzIEP6gzmdILKc0QzLqrMdET56aXE4SlvMBfbi6H4zLHz1ir9WL
         plGnPwaeHjDS4G8M4mDRuja3smrVj/38f85bY88H+EmgbILNzUMiW1peeASQPjQS09
         +/PIMM+30KDeRKCfRKYAbAYoNkQiRapEDEKntx4dhRh4L/meXfGwumi52uHWVVyzEQ
         0X/sTLSIpMWKl15q1vIwM+IIyqVb0FFA7vYernkCFHVpa1BfxKtQX7ZXQu8A6ZV6Z2
         1XyBhRiBYObjhDcFYoWl1F1mdjlVXrDcQJpCTSwxBz+Nb2YbyvkubTDT2kFZqU7gCi
         zARhZIIfv9U6g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/49] iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:37 +0000
Message-Id: <20211123211019.2271440-8-jic23@kernel.org>
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
 drivers/iio/accel/mma9551.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 4c359fb05480..67fdd53b811f 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -523,8 +523,7 @@ static int mma9551_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mma9551_runtime_suspend(struct device *dev)
+static __maybe_unused int mma9551_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9551_data *data = iio_priv(indio_dev);
@@ -541,7 +540,7 @@ static int mma9551_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int mma9551_runtime_resume(struct device *dev)
+static __maybe_unused int mma9551_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9551_data *data = iio_priv(indio_dev);
@@ -555,10 +554,8 @@ static int mma9551_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
-static int mma9551_suspend(struct device *dev)
+static __maybe_unused int mma9551_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9551_data *data = iio_priv(indio_dev);
@@ -571,7 +568,7 @@ static int mma9551_suspend(struct device *dev)
 	return ret;
 }
 
-static int mma9551_resume(struct device *dev)
+static __maybe_unused int mma9551_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9551_data *data = iio_priv(indio_dev);
@@ -583,9 +580,8 @@ static int mma9551_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops mma9551_pm_ops = {
+static __maybe_unused const struct dev_pm_ops mma9551_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mma9551_suspend, mma9551_resume)
 	SET_RUNTIME_PM_OPS(mma9551_runtime_suspend,
 			   mma9551_runtime_resume, NULL)
@@ -609,7 +605,7 @@ static struct i2c_driver mma9551_driver = {
 	.driver = {
 		   .name = MMA9551_DRV_NAME,
 		   .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
-		   .pm = &mma9551_pm_ops,
+		   .pm = pm_ptr(&mma9551_pm_ops),
 		   },
 	.probe = mma9551_probe,
 	.remove = mma9551_remove,
-- 
2.34.0

