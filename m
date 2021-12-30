Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E81481FE2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhL3T2G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbhL3T2G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C850C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 11:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB569B81CF7
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28AAC36AEC;
        Thu, 30 Dec 2021 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892483;
        bh=zJfcc6r0bYn/Z4A++7Sp9AJdMhkS3JjajvNInOw9KcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+JdJqQ9Sbtet7U8ndVUKW8NBq90n6W9Cw8jg2EMvlr8qRSADV1AbWbrpo6sm15gO
         YDqrbaavnoHobLUvt/Qh0WUyPxeRICdoxAHAVI/PAw9Kubnv4CMXHTxbER1YKC5WxT
         08j3iG2AEWdT1hk9NWr9RjD7CXlfZCigaEY/KjYj6Q6dkrZZL8GWknEX/nwek8Bd2d
         /46/VZrG75FMVYry6zgpXo2l2NVupPR4iDeuff8DyQxiBmW/H6IaWMb0GdC/1F/OdK
         ymnRKxZttxjiu1QMGf3gS9HbmenvQHRJzxV/30rHEpKJEbD1rx8khKpNoh33ND54cP
         JHUDzABU3cqCw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 07/13] iio:accel:adxl355: Move exports into ADXL355 namespace
Date:   Thu, 30 Dec 2021 19:33:25 +0000
Message-Id: <20211230193331.283503-8-jic23@kernel.org>
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
Cc: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 6 +++---
 drivers/iio/accel/adxl355_i2c.c  | 1 +
 drivers/iio/accel/adxl355_spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 4f485909f459..e4f2a13a1a0e 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -72,7 +72,7 @@ const struct regmap_access_table adxl355_readable_regs_tbl = {
 	.yes_ranges = adxl355_read_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl355_read_reg_range),
 };
-EXPORT_SYMBOL_GPL(adxl355_readable_regs_tbl);
+EXPORT_SYMBOL_NS_GPL(adxl355_readable_regs_tbl, ADXL355);
 
 static const struct regmap_range adxl355_write_reg_range[] = {
 	regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_RESET_REG),
@@ -82,7 +82,7 @@ const struct regmap_access_table adxl355_writeable_regs_tbl = {
 	.yes_ranges = adxl355_write_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl355_write_reg_range),
 };
-EXPORT_SYMBOL_GPL(adxl355_writeable_regs_tbl);
+EXPORT_SYMBOL_NS_GPL(adxl355_writeable_regs_tbl, ADXL355);
 
 enum adxl355_op_mode {
 	ADXL355_MEASUREMENT,
@@ -758,7 +758,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(adxl355_core_probe);
+EXPORT_SYMBOL_NS_GPL(adxl355_core_probe, ADXL355);
 
 MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
 MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer core driver");
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index 5a987bda9060..c8fc75a80342 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -60,3 +60,4 @@ module_i2c_driver(adxl355_i2c_driver);
 MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
 MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ADXL355);
diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
index fb225aeb56e3..4a913c6c4469 100644
--- a/drivers/iio/accel/adxl355_spi.c
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -63,3 +63,4 @@ module_spi_driver(adxl355_spi_driver);
 MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
 MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ADXL355);
-- 
2.34.1

