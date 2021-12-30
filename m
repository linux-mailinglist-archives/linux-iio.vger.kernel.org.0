Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C69481FE0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhL3T2A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57862 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbhL3T2A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E92F7616B2
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96BFC36AE9;
        Thu, 30 Dec 2021 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892479;
        bh=B4ZktADUMl/g5tbopVNlVSY0AbwRA/RMefQYlpJ7qmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSyq5zKqQ//4tPyPOfXe/xDVB+/QwvotK6IgBo7Y6b5bUY+MU2TjkJ5U7EyRmJ6s0
         /9dT3Vc0cGbeZhw2kJbmlk2n7wBEuD2Ftg2Yzg8wwWqcLoVxxFh8jvP/lkgE5XTdJv
         iScLzgAsfcroy6jJ+qZn0YuV0hlUuTxiNlf4rvp6f9W+SJe1j6gjnEaRjV7wzFhLa2
         VSqtTzaEv/S00wyjCzUNApNUi/UkTiIaTvBl//0ulpIPKQN+c0B8vSsGnHb3SHTYHj
         9fBh4uwFjufwO9CfGAnJCPkGgfxVlt7/6bdZZW40UB0uOR/dG7DDBR4wFyRkh+LhMN
         gfVthDwM0uShw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>
Subject: [PATCH 05/13] iio:accel:adxl313: Move exports into ADXL313 namespace
Date:   Thu, 30 Dec 2021 19:33:23 +0000
Message-Id: <20211230193331.283503-6-jic23@kernel.org>
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
move the driver core exports into their own namespace and import
that into the two bus modules.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 6 +++---
 drivers/iio/accel/adxl313_i2c.c  | 1 +
 drivers/iio/accel/adxl313_spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 0d243341f1a7..a9ca28f4c087 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -26,7 +26,7 @@ const struct regmap_access_table adxl313_readable_regs_table = {
 	.yes_ranges = adxl313_readable_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl313_readable_reg_range),
 };
-EXPORT_SYMBOL_GPL(adxl313_readable_regs_table);
+EXPORT_SYMBOL_NS_GPL(adxl313_readable_regs_table, ADXL313);
 
 static const struct regmap_range adxl313_writable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
@@ -41,7 +41,7 @@ const struct regmap_access_table adxl313_writable_regs_table = {
 	.yes_ranges = adxl313_writable_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl313_writable_reg_range),
 };
-EXPORT_SYMBOL_GPL(adxl313_writable_regs_table);
+EXPORT_SYMBOL_NS_GPL(adxl313_writable_regs_table, ADXL313);
 
 struct adxl313_data {
 	struct regmap	*regmap;
@@ -325,7 +325,7 @@ int adxl313_core_probe(struct device *dev,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(adxl313_core_probe);
+EXPORT_SYMBOL_NS_GPL(adxl313_core_probe, ADXL313);
 
 MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
 MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer core driver");
diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index 82e9fb2db1e6..f1ee120d9ded 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -64,3 +64,4 @@ module_i2c_driver(adxl313_i2c_driver);
 MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
 MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ADXL313);
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index a6162f36ef52..1eeb1b6de30c 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -90,3 +90,4 @@ module_spi_driver(adxl313_spi_driver);
 MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
 MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ADXL313);
-- 
2.34.1

