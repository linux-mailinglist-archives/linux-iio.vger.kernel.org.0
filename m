Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE85045ADDA
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhKWVJL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbhKWVJF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06C1360FD8;
        Tue, 23 Nov 2021 21:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701557;
        bh=JRDU7ooOViv/ExO2/8kLivBk8M6t33akhx3+LubKhzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwKv4LTYfXLmtTXTkhI0YUOxOUwvDnHkNhknDMqBhXO0e6Ac9Zb9T4KwLBNpMzI2o
         QlwAfOGxzhqip7C1UYAdIeG9sDwStchQ+g20fA4bfftSb55afgWcGjNY5LbCR/MLsQ
         8BVL6V569dPjV1c1rtfM6oGhNynpITTMHQRRSpUYhzi7KXAUfH4IiCYuM3s5J5O/3p
         KsUjcvSSpQC5/YAyilojoHCa41rLo4IwVnQTX7jkeGi7Fz3VL0KGJoV1avCTcwmLGd
         +RIDQO8+D34GD/00nQqIn1e69vW2caN28BGf74IvpXwaqv053isCjPt7A6uND86+HB
         xkuHj1XqavnOg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/49] iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:33 +0000
Message-Id: <20211123211019.2271440-4-jic23@kernel.org>
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
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/dmard06.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index de2868c28d95..a0e8d0ab700b 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/compiler.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
@@ -170,8 +171,7 @@ static int dmard06_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dmard06_suspend(struct device *dev)
+static __maybe_unused int dmard06_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct dmard06_data *dmard06 = iio_priv(indio_dev);
@@ -185,7 +185,7 @@ static int dmard06_suspend(struct device *dev)
 	return 0;
 }
 
-static int dmard06_resume(struct device *dev)
+static __maybe_unused int dmard06_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct dmard06_data *dmard06 = iio_priv(indio_dev);
@@ -200,10 +200,6 @@ static int dmard06_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard06_suspend, dmard06_resume);
-#define DMARD06_PM_OPS (&dmard06_pm_ops)
-#else
-#define DMARD06_PM_OPS NULL
-#endif
 
 static const struct i2c_device_id dmard06_id[] = {
 	{ "dmard05", 0 },
@@ -227,7 +223,7 @@ static struct i2c_driver dmard06_driver = {
 	.driver = {
 		.name = DMARD06_DRV_NAME,
 		.of_match_table = dmard06_of_match,
-		.pm = DMARD06_PM_OPS,
+		.pm = pm_ptr(&dmard06_pm_ops),
 	},
 };
 module_i2c_driver(dmard06_driver);
-- 
2.34.0

