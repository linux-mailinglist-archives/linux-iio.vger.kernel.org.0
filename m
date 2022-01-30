Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874DF4A398B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347676AbiA3Uv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiA3Uv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311CC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:51:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A65F660DE6
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007D4C340EB;
        Sun, 30 Jan 2022 20:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575888;
        bh=fSs4LWk4NrI1wuVpbAzJwFnlUrsZKT1v3R45FAfMO8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlGCoNq4jYW6dJnjc++kRJgzDBRPAhvXCsa8x5mLbrGyKxCDxxVHWTVnTkIGej4MD
         RrIf2GNHu/WIZlKRSN6QHG9o9WNI7xweBY/2uN3B/iEfDCtmZiJ1tRsdNa78zDf6cE
         4v4OUAxHNCJI3C3DUazNn9Kq6CarvA/RZZ8pLi4s+WPKb12zu3rLUJAPiYdX3hNaTu
         VDyO4SFd987JaCJh7atbgHafEuAhn/OOShPhK+aVlXJC55TWApjaG3Ki1o9aMscJuF
         tyT+1wv73CroiAGgwk4buGcj+B4L/F8h3PKwdC9o3jztFKHDHQqYy4cXvo9J2KYGlL
         FqkfYIr3MPzeQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 16/16] iio:chemical:bme680: Move exports to IIO_BME680 namespace
Date:   Sun, 30 Jan 2022 20:57:01 +0000
Message-Id: <20220130205701.334592-17-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the common/library functions into a specific namespace and import
that into the bus specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 drivers/iio/chemical/bme680_i2c.c  | 1 +
 drivers/iio/chemical/bme680_spi.c  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index bf23cc7eb99e..16ff7a98c9f0 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -81,7 +81,7 @@ const struct regmap_config bme680_regmap_config = {
 	.volatile_table = &bme680_volatile_table,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL(bme680_regmap_config);
+EXPORT_SYMBOL_NS(bme680_regmap_config, IIO_BME680);
 
 static const struct iio_chan_spec bme680_channels[] = {
 	{
@@ -957,7 +957,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(bme680_core_probe);
+EXPORT_SYMBOL_NS_GPL(bme680_core_probe, IIO_BME680);
 
 MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
 MODULE_DESCRIPTION("Bosch BME680 Driver");
diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 74cf89c82c0a..20f2c20b6b02 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -60,3 +60,4 @@ module_i2c_driver(bme680_i2c_driver);
 MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
 MODULE_DESCRIPTION("BME680 I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BME680);
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index cc579a7ac5ce..36b13dd6ee63 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -163,3 +163,4 @@ module_spi_driver(bme680_spi_driver);
 MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
 MODULE_DESCRIPTION("Bosch BME680 SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BME680);
-- 
2.35.1

