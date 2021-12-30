Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0095D481FE6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhL3T2Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbhL3T2P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C236C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 11:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34917B81D02
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C3C36AEB;
        Thu, 30 Dec 2021 19:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892493;
        bh=tB6R/zJRgVomd16mY73D7KlKzwbl97RjYSQBu3+QlC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bokGsHBfdrhyjiTAwo4b41QuOBzUNALs9csNWMtRxUqiHGmvT256Eql63VjpyQBGU
         304hox1sIphvirbGe78bkjyssfpoqNqqmhpnlQR2QtIR4TsNzdM+RZ7I8bVMqijamx
         hjkBeXKVj1a03D6vUOzAH/XnMihpd0QtBxe1vY960o1saEnG2Ju3Tw0AqUA1yQAXCr
         QX+yTGsQV2Un8CHY2V5NzTr5j+R3E53q30FMFcwEtsWnArtvoipK8GfMduzSoneOYX
         8tXvXRc1mBX5YtBnAyb1jn7/lTy/8pZIN8yKfiLjLa6JRZ+ouPnHFV90l83poSJ+g9
         Y//c7kTfUGqOg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 11/13] iio:accel:fxl8962af: Move exports into FXL8962AF namespace
Date:   Thu, 30 Dec 2021 19:33:29 +0000
Message-Id: <20211230193331.283503-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
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
index 32989d91b982..99b6073d9ed4 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -178,7 +178,7 @@ const struct regmap_config fxls8962af_regmap_conf = {
 	.val_bits = 8,
 	.max_register = FXLS8962AF_MAX_REG,
 };
-EXPORT_SYMBOL_GPL(fxls8962af_regmap_conf);
+EXPORT_SYMBOL_NS_GPL(fxls8962af_regmap_conf, FXLS8962AF);
 
 enum {
 	fxls8962af_idx_x,
@@ -1232,7 +1232,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
+EXPORT_SYMBOL_NS_GPL(fxls8962af_core_probe, FXLS8962AF);
 
 static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
 {
@@ -1298,7 +1298,7 @@ const struct dev_pm_ops fxls8962af_pm_ops = {
 	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
 			   fxls8962af_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(fxls8962af_pm_ops);
+EXPORT_SYMBOL_NS_GPL(fxls8962af_pm_ops, FXLS8962AF);
 
 MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
 MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index cfb004b20455..f95c4aad15b7 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -55,3 +55,4 @@ module_i2c_driver(fxls8962af_driver);
 MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
 MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(FXLS8962AF);
diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
index 57108d3d480b..482931964f2a 100644
--- a/drivers/iio/accel/fxls8962af-spi.c
+++ b/drivers/iio/accel/fxls8962af-spi.c
@@ -55,3 +55,4 @@ module_spi_driver(fxls8962af_driver);
 MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
 MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(FXLS8962AF);
-- 
2.34.1

