Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D87481FE3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbhL3T2I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44128 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbhL3T2I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50756B81741
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E47FC36AE7;
        Thu, 30 Dec 2021 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892486;
        bh=FvFvBQk/9GlForEkyDRpjEsfEFlyhZv7cRUsPGDCNA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jiz4k+ARhcXYMqv2AOpmJFVld7E7g06RvJunDYQGAuZ5qDGmswBurJu3LGMdBNJQk
         NFB+O8T9wSmChp9x7MDv2BEt0ft74TQOLq5YFjWahECvD8Vns3Wn1yfGFfWCH//9j+
         Xbz7zg76Rk14TkzhPFDvmSxJOKkvyHccDhmj5HGStKr7VPi3AXCsJKtxS498m2gyX5
         DgVrvYGirWaC2rKK7uKdugu5xEORM1BmuCML3+1KtLFsrYIdz5nahiUKhvUTcUnxhU
         mvhrLqrP9hzuLJJwzS2BEJn1M7wu4FwfnV+7Uv+WSVGzYEfOC2Dd6hSdB2/q5EdmJp
         UD1/jvqNpJRig==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/13] iio:accel:adxl372: Move exports into ADXL372 namespace
Date:   Thu, 30 Dec 2021 19:33:26 +0000
Message-Id: <20211230193331.283503-9-jic23@kernel.org>
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
---
 drivers/iio/accel/adxl372.c     | 4 ++--
 drivers/iio/accel/adxl372_i2c.c | 1 +
 drivers/iio/accel/adxl372_spi.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 758952584f8c..dde6a6ead746 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1176,7 +1176,7 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
 {
 	return (reg == ADXL372_FIFO_DATA);
 }
-EXPORT_SYMBOL_GPL(adxl372_readable_noinc_reg);
+EXPORT_SYMBOL_NS_GPL(adxl372_readable_noinc_reg, ADXL372);
 
 int adxl372_probe(struct device *dev, struct regmap *regmap,
 		  int irq, const char *name)
@@ -1260,7 +1260,7 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(adxl372_probe);
+EXPORT_SYMBOL_NS_GPL(adxl372_probe, ADXL372);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index 9a07ab3d151a..62ade11a0def 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -67,3 +67,4 @@ module_i2c_driver(adxl372_i2c_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(ADXL372);
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 1f1352fee99a..a7b49fbfa520 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -59,3 +59,4 @@ module_spi_driver(adxl372_spi_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(ADXL372);
-- 
2.34.1

