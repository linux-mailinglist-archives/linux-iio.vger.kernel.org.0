Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68EC45ADDB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhKWVJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234479AbhKWVJN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C00C60FE6;
        Tue, 23 Nov 2021 21:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701561;
        bh=rVzJEu9HkUXc7z2nTxYwPLNrr5h2cWKkNv8peMwL1pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4XezPKU3QAEO2M4hwxelaIlizHaBhDUaZkw5IuTvmuaxOA14o8gqsJusPS+Brlhz
         u/8mZF+pa9q8IWNwKySrfIdvLC27qk3Prlm6csw9X6xrUUU4olBi0uwdepfVqE6jTy
         9GyB0p/Kyv780+m7VMoiIt5g2Yb/FcRfC5HVZaVlS1aZudqOnkahUJg/iC5RZ0/+rt
         DJ3pBRJT/9TqptL5ZXqiBW1nsFvaqWTKEZ59DVICE1rAAefqbbJh0n/V4j1qTPtnQL
         yfsz5ZfENqIuTHDG8mOWUwmPIChkO6A3ltfXzvPdWKunTq6UA9+1Z4rDrdVM7R9Lu8
         Faa+6R6cpLC5g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/49] iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:35 +0000
Message-Id: <20211123211019.2271440-6-jic23@kernel.org>
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
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mc3230.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 735002b716f3..139c7f6839df 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -160,8 +160,7 @@ static int mc3230_remove(struct i2c_client *client)
 	return mc3230_set_opcon(iio_priv(indio_dev), MC3230_MODE_OPCON_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mc3230_suspend(struct device *dev)
+static __maybe_unused int mc3230_suspend(struct device *dev)
 {
 	struct mc3230_data *data;
 
@@ -170,7 +169,7 @@ static int mc3230_suspend(struct device *dev)
 	return mc3230_set_opcon(data, MC3230_MODE_OPCON_STANDBY);
 }
 
-static int mc3230_resume(struct device *dev)
+static __maybe_unused int mc3230_resume(struct device *dev)
 {
 	struct mc3230_data *data;
 
@@ -178,7 +177,6 @@ static int mc3230_resume(struct device *dev)
 
 	return mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
@@ -191,7 +189,7 @@ MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 static struct i2c_driver mc3230_driver = {
 	.driver = {
 		.name = "mc3230",
-		.pm = &mc3230_pm_ops,
+		.pm = pm_ptr(&mc3230_pm_ops),
 	},
 	.probe		= mc3230_probe,
 	.remove		= mc3230_remove,
-- 
2.34.0

