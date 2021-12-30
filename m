Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875A9481FDF
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbhL3T17 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:27:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44012 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbhL3T17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FCF6B81CF7
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384ADC36AEB;
        Thu, 30 Dec 2021 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892477;
        bh=Sp5HZfM93K0l+zH4RoSt7/Yf03J7xBcr0fQ4OAiVLLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oeXgsMDvsgZA+wiaDpBKOjUdd09jl8yVK5d1PjuBzmECGFqPOSA97xbGFNEdgx/5T
         kuPpSKJze2t4XIMl2vIeJzK/vXXRJj408rwCtHL2PS0q1qSKWsfDqX68NEGBWg5PxB
         1iEXuYT7AwIECkaiUyH4nVSTffkcHyEyXeyRrvZIboDDGe5r7cxgZbA63QVxOOlvmU
         5YXjTbUoyyy9moKBXNKpj0/XhdISBjWbaZlqqtkXL0qH2ruIr5BYSRTzw7+JcsW4RI
         1q/b5oLXwvOol3mCqH4yoRqU0MQUWItyxalN/ha4/cfBZMTbRqA+PHvhFl1SWzTDuj
         lG7Urny4+QdJQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/13] iio:accel:bma400: Move exports into BMA400 namespace
Date:   Thu, 30 Dec 2021 19:33:22 +0000
Message-Id: <20211230193331.283503-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the core bma400 functions into a bma400 specific namespace
and import that into the two bus modules.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bma400_core.c | 6 +++---
 drivers/iio/accel/bma400_i2c.c  | 1 +
 drivers/iio/accel/bma400_spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index fd2647b728d3..f623af18fec0 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -136,7 +136,7 @@ const struct regmap_config bma400_regmap_config = {
 	.writeable_reg = bma400_is_writable_reg,
 	.volatile_reg = bma400_is_volatile_reg,
 };
-EXPORT_SYMBOL(bma400_regmap_config);
+EXPORT_SYMBOL_NS(bma400_regmap_config, BMA400);
 
 static const struct iio_mount_matrix *
 bma400_accel_get_mount_matrix(const struct iio_dev *indio_dev,
@@ -826,7 +826,7 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 
 	return iio_device_register(indio_dev);
 }
-EXPORT_SYMBOL(bma400_probe);
+EXPORT_SYMBOL_NS(bma400_probe, BMA400);
 
 void bma400_remove(struct device *dev)
 {
@@ -846,7 +846,7 @@ void bma400_remove(struct device *dev)
 
 	iio_device_unregister(indio_dev);
 }
-EXPORT_SYMBOL(bma400_remove);
+EXPORT_SYMBOL_NS(bma400_remove, BMA400);
 
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index f50df5310beb..126fcfccfc9c 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -61,3 +61,4 @@ module_i2c_driver(bma400_i2c_driver);
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor (I2C)");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(BMA400);
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index 9f622e37477b..31f7cd1e90e9 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -120,3 +120,4 @@ module_spi_driver(bma400_spi_driver);
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor (SPI)");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(BMA400);
-- 
2.34.1

