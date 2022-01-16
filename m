Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E395D48FE48
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiAPR7v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiAPR7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:59:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE66C061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 09:59:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA6960FA3
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 17:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA074C36AE9;
        Sun, 16 Jan 2022 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355990;
        bh=92K8fRh1ZIvQqFQdZa9QQtd5RBzqVLKkRB5+RT8dtoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWIgOSYOEOmdH+BgRQpSezO1qQ8u7QuOHjrPF9mBA0cjJhaCTDEB9xBnfYxG7Pcgb
         LDCZITeT29RgtSNqvhNH4mUy2rGHLUAJUifuA2sLQRMc6qjKV9r8cZuPO+Tz12PFXp
         5h2pSeX6ubWSgxZGgbl8/79l2AdXJ7OW8ZFr4/A0jTg49WTozUxbacJIodNNUvZG+U
         bqE7R9vjTwxqncwwCyI+Et2CbrufBqwV2Ot78yG2FdXI/rFk2hvaVxhEqEs/wEtMwS
         r+Br4R0qkHZHdpao2vvRb6sjicfpsJzkW7PDEoQ/OvLteqSmWe2AffpmTjQTH/p911
         99LYtnKzuoj1w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 06/13] iio:accel:adxl345: Move exports into IIO_ADXL345 namespace
Date:   Sun, 16 Jan 2022 18:05:28 +0000
Message-Id: <20220116180535.2367780-7-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl345_core.c | 2 +-
 drivers/iio/accel/adxl345_i2c.c  | 1 +
 drivers/iio/accel/adxl345_spi.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 4b275051ef61..ef2240e356e0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -270,7 +270,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(adxl345_core_probe);
+EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
 
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
 MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer core driver");
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a431cba216e6..7bc8324c4f07 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -68,3 +68,4 @@ module_i2c_driver(adxl345_i2c_driver);
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
 MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ADXL345);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index ea559ac2e87d..c752562c5d3b 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -72,3 +72,4 @@ module_spi_driver(adxl345_spi_driver);
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
 MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ADXL345);
-- 
2.34.1

