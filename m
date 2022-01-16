Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05C948FE46
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiAPR7r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:59:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58348 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiAPR7q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:59:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7120B60DFD
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 17:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F6C36AE9;
        Sun, 16 Jan 2022 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355985;
        bh=V57wDI3KUYw3Df2M9ntxlBswffPYmiv+50bcvnmCEtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rl3kROxJrkmHEGdImyPXkZnGMwRICP2b5D8jsWYCyuVIeoVxjIeIQvh77QHosYwhZ
         ad/OI0zcfuKXlB10DscOSzmcxkPnNy77ARf48wSTgAus4YVub3gIBKLGSGyjuAb6Dd
         gZ7VECS39QCcW4Tv3WhDjXHvXL+Ait8vGiycOt/sr5wM6SsWoi5QG6/H667eRLcOto
         3yzhKAjsJIJPt4xh73Xz7X9ljTDWtTKXMX0/D06J6kRCXnbZkhfZ8S5ZtZFit8rDlI
         CSjwyLceDSGUYI2eDAE6ScO6DccNqLSh+I3UNMh2rjCZMn+V4wFFl8NOSuUUPyLEK8
         IDGephtlmTgRA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 04/13] iio:accel:bma400: Move exports into IIO_BMA400 namespace
Date:   Sun, 16 Jan 2022 18:05:26 +0000
Message-Id: <20220116180535.2367780-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
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
index fd2647b728d3..043002fe6f63 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -136,7 +136,7 @@ const struct regmap_config bma400_regmap_config = {
 	.writeable_reg = bma400_is_writable_reg,
 	.volatile_reg = bma400_is_volatile_reg,
 };
-EXPORT_SYMBOL(bma400_regmap_config);
+EXPORT_SYMBOL_NS(bma400_regmap_config, IIO_BMA400);
 
 static const struct iio_mount_matrix *
 bma400_accel_get_mount_matrix(const struct iio_dev *indio_dev,
@@ -826,7 +826,7 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 
 	return iio_device_register(indio_dev);
 }
-EXPORT_SYMBOL(bma400_probe);
+EXPORT_SYMBOL_NS(bma400_probe, IIO_BMA400);
 
 void bma400_remove(struct device *dev)
 {
@@ -846,7 +846,7 @@ void bma400_remove(struct device *dev)
 
 	iio_device_unregister(indio_dev);
 }
-EXPORT_SYMBOL(bma400_remove);
+EXPORT_SYMBOL_NS(bma400_remove, IIO_BMA400);
 
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index f50df5310beb..da104ffd3fe0 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -61,3 +61,4 @@ module_i2c_driver(bma400_i2c_driver);
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor (I2C)");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BMA400);
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index 9f622e37477b..23f3a8ab30bd 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -120,3 +120,4 @@ module_spi_driver(bma400_spi_driver);
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor (SPI)");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BMA400);
-- 
2.34.1

