Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D025945ADDC
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhKWVJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbhKWVJN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8F7960FE7;
        Tue, 23 Nov 2021 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701559;
        bh=RSxD7ze8IHMOivP6+ayHwy3BM/4xcKG6WgXXUtNaKXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBdI0ImF6bD14HtlInllz8+w+4+rlQrex7bNWruDRJu4Aejb5YWoH4rqyhoquoDB5
         VVIxrFsctYdvakIliAcNg9Z13gpi+G/OzsIKd4UjFIldUkF3TxzWjkPFyfoy5DTCfN
         9MuWp4dG8wt529c88lEReSux+DegRKqtTFBRVI0cdCVQ1q7So956FS5r/5EHZ95zfm
         OCBvsK/QQhddd6r2X0y+w/NYUUXBQPhAf1NqsuOGTlJF1vgOoFnVTYau2MaMMzv8Gl
         f6hqN8pFNWvuegz9MV219kU4UWu+fiHrqzoVZh/HjcLGaVbDzQiYAzefeJeHnWYc3N
         LNLHqWMK1J6EQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/49] iio:accel:dmard10: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:34 +0000
Message-Id: <20211123211019.2271440-5-jic23@kernel.org>
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

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/dmard10.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index f9f173eec202..7ad3349ad60f 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/compiler.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -218,17 +219,15 @@ static int dmard10_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dmard10_suspend(struct device *dev)
+static int __maybe_unused dmard10_suspend(struct device *dev)
 {
 	return dmard10_shutdown(to_i2c_client(dev));
 }
 
-static int dmard10_resume(struct device *dev)
+static int __maybe_unused dmard10_resume(struct device *dev)
 {
 	return dmard10_reset(to_i2c_client(dev));
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend, dmard10_resume);
 
@@ -241,7 +240,7 @@ MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
 static struct i2c_driver dmard10_driver = {
 	.driver = {
 		.name = "dmard10",
-		.pm = &dmard10_pm_ops,
+		.pm = pm_ptr(&dmard10_pm_ops),
 	},
 	.probe		= dmard10_probe,
 	.id_table	= dmard10_i2c_id,
-- 
2.34.0

