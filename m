Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6C48FE49
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiAPR7y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:59:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58414 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiAPR7x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:59:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF3060DFD
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 17:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08923C36AE7;
        Sun, 16 Jan 2022 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355992;
        bh=Wy49WX2nQzp9PqMPglIk9HzRKBfyTLh+ScoTaBsVxqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imNcrYx2ZGT3jmIENAcGNgg1wqVGeLqHIbKfSDlYldVaxtHbUDz7CNxrKxfew+BF8
         1knYbYITmHV8rD8vGd0IRYXQk5/dGi3nzcZhkD73RP3zscjY3iI7z2UDV6TmlRTDDm
         wl0sPKpIeM+SWZ94ykHi7N2F9tSO6B+NtwhLrHGKMRGH43L9pbeYQOIIIKyUEGoQdo
         NgqZK8m95zySOgJXwI03C0SsEWJp50i6TfYSljjlQb/l1KBza2JONuI+igXHJxxk5C
         mVmWJACQQAHmQLO06gG2Rh2V+y9B2tacFNpKxY+1QC96yr5qwp+/xgaW4cs+0BcNSh
         UqntCdpTQF0uA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 07/13] iio:accel:adxl355: Move exports into IIO_ADXL355 namespace
Date:   Sun, 16 Jan 2022 18:05:29 +0000
Message-Id: <20220116180535.2367780-8-jic23@kernel.org>
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
Cc: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 6 +++---
 drivers/iio/accel/adxl355_i2c.c  | 1 +
 drivers/iio/accel/adxl355_spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 4f485909f459..f207887fafd4 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -72,7 +72,7 @@ const struct regmap_access_table adxl355_readable_regs_tbl = {
 	.yes_ranges = adxl355_read_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl355_read_reg_range),
 };
-EXPORT_SYMBOL_GPL(adxl355_readable_regs_tbl);
+EXPORT_SYMBOL_NS_GPL(adxl355_readable_regs_tbl, IIO_ADXL355);
 
 static const struct regmap_range adxl355_write_reg_range[] = {
 	regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_RESET_REG),
@@ -82,7 +82,7 @@ const struct regmap_access_table adxl355_writeable_regs_tbl = {
 	.yes_ranges = adxl355_write_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl355_write_reg_range),
 };
-EXPORT_SYMBOL_GPL(adxl355_writeable_regs_tbl);
+EXPORT_SYMBOL_NS_GPL(adxl355_writeable_regs_tbl, IIO_ADXL355);
 
 enum adxl355_op_mode {
 	ADXL355_MEASUREMENT,
@@ -758,7 +758,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(adxl355_core_probe);
+EXPORT_SYMBOL_NS_GPL(adxl355_core_probe, IIO_ADXL355);
 
 MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
 MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer core driver");
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index 5a987bda9060..f67d57921c81 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -60,3 +60,4 @@ module_i2c_driver(adxl355_i2c_driver);
 MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
 MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ADXL355);
diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
index fb225aeb56e3..5fe986ae03f6 100644
--- a/drivers/iio/accel/adxl355_spi.c
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -63,3 +63,4 @@ module_spi_driver(adxl355_spi_driver);
 MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
 MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ADXL355);
-- 
2.34.1

