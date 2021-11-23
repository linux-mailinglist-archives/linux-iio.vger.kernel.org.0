Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3C45AE07
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbhKWVKb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239594AbhKWVK2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A213560FC3;
        Tue, 23 Nov 2021 21:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701639;
        bh=zlRBJ8pu49A1c6EM4PdBJryTJ9odvWf9LcllmIqOBPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcBoPkRv1Z+PhSlPCiqJtSl/CLXzVSpA3FkruxS16lTSGQgUmwG0321X8RaaiiANk
         x4IUymU0dlK+iAXNw8/Fb9iBmkTXWXSHe/Rc/wYVKF8Ihr14fN59LLDhFwTVOm6o1y
         pqxCDaEh5k74WfLbR5jGISSm37JX0H2EDiCzQrLKsDJrmNeVgTnRpeHI4wS65aiAES
         vCHWsOuYF2FNdyJhVOKrinlWFA04SE2M7//21+B06jEBxPg9y+usMDZDhvWTfFBnsx
         OAeeYMJ0+m1ubzFRJtXfQGqWOmnQRTGUHdGPDwXJf3HAx/Si9TFhFWds6mGsZ/eepj
         y1gXVs6Ms1WPA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 45/49] iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:15 +0000
Message-Id: <20211123211019.2271440-46-jic23@kernel.org>
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
 drivers/iio/proximity/sx9500.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3e4ddb2e8c2b..f59bee2707ca 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -993,8 +993,7 @@ static int sx9500_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sx9500_suspend(struct device *dev)
+static __maybe_unused int sx9500_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct sx9500_data *data = iio_priv(indio_dev);
@@ -1017,7 +1016,7 @@ static int sx9500_suspend(struct device *dev)
 	return ret;
 }
 
-static int sx9500_resume(struct device *dev)
+static __maybe_unused int sx9500_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct sx9500_data *data = iio_priv(indio_dev);
@@ -1030,11 +1029,8 @@ static int sx9500_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops sx9500_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sx9500_suspend, sx9500_resume)
-};
+static SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
 
 static const struct acpi_device_id sx9500_acpi_match[] = {
 	{"SSX9500", 0},
@@ -1060,7 +1056,7 @@ static struct i2c_driver sx9500_driver = {
 		.name	= SX9500_DRIVER_NAME,
 		.acpi_match_table = ACPI_PTR(sx9500_acpi_match),
 		.of_match_table = of_match_ptr(sx9500_of_match),
-		.pm = &sx9500_pm_ops,
+		.pm = pm_ptr(&sx9500_pm_ops),
 	},
 	.probe		= sx9500_probe,
 	.remove		= sx9500_remove,
-- 
2.34.0

