Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7195E48FE4D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiAPSAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 13:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbiAPSAF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 13:00:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C327AC061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 10:00:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D7BFB80D89
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 18:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15D0C36AE9;
        Sun, 16 Jan 2022 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642356002;
        bh=dPQxO9dlZ6MF6rh4iEw6F7gslmtnyyWZG9tE+mdc5m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0kTnw5/h1n9BA8UZSv1vez3ep3f5uQraqN+dRP2diAQxOjc4Ix6Fporp0XltBoBO
         mhkfpwFnXkG3Rj2oq7dcqnMU6Oz3JEtVuVn66f5kh9aPIuEALrVI8ZtreHTyX+ny3j
         FkQwmdl4mlpWTpesRyfNhUl36Zj8oR+KcqopMHmiB3OeH8i4B6/XFQZ12k+lAHoeOO
         fwBvfp3quwUC5enBT57ZYLZzV8O+j0w+3KhDW/2Q9lduEom6KmgHRhN8OZ83NX+2Fs
         Gj9KFpPC1k5w9NXUtuestBuS+P8xyIzD8yIC+fuUJH7d3uTF1ViGm/z5/Zvb6Jv/2U
         0QQLppoGDYe8w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 11/13] iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespace
Date:   Sun, 16 Jan 2022 18:05:33 +0000
Message-Id: <20220116180535.2367780-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To avoid unnecessary pollution of the global symbol namespace move the
driver core exports into their own namespace and import that into the two
bus modules.

For more info see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 6 +++---
 drivers/iio/accel/fxls8962af-i2c.c  | 1 +
 drivers/iio/accel/fxls8962af-spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 32989d91b982..8e763dbf096b 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -178,7 +178,7 @@ const struct regmap_config fxls8962af_regmap_conf = {
 	.val_bits = 8,
 	.max_register = FXLS8962AF_MAX_REG,
 };
-EXPORT_SYMBOL_GPL(fxls8962af_regmap_conf);
+EXPORT_SYMBOL_NS_GPL(fxls8962af_regmap_conf, IIO_FXLS8962AF);
 
 enum {
 	fxls8962af_idx_x,
@@ -1232,7 +1232,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
+EXPORT_SYMBOL_NS_GPL(fxls8962af_core_probe, IIO_FXLS8962AF);
 
 static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
 {
@@ -1298,7 +1298,7 @@ const struct dev_pm_ops fxls8962af_pm_ops = {
 	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
 			   fxls8962af_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(fxls8962af_pm_ops);
+EXPORT_SYMBOL_NS_GPL(fxls8962af_pm_ops, IIO_FXLS8962AF);
 
 MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
 MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index cfb004b20455..7e0ecd3bf0d9 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -55,3 +55,4 @@ module_i2c_driver(fxls8962af_driver);
 MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
 MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_FXLS8962AF);
diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
index 57108d3d480b..0357d54d47cc 100644
--- a/drivers/iio/accel/fxls8962af-spi.c
+++ b/drivers/iio/accel/fxls8962af-spi.c
@@ -55,3 +55,4 @@ module_spi_driver(fxls8962af_driver);
 MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
 MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_FXLS8962AF);
-- 
2.34.1

