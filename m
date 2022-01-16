Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245D348FE4A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiAPR74 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiAPR74 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:59:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C61AC061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 09:59:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A295360F9D
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 17:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB22EC36AEF;
        Sun, 16 Jan 2022 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355995;
        bh=hNm1DSVZobbEMmHWPZov6GFf7fYmObb31nwSOKcbBAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJlJQtCzHi7QTReVpN7SOrkvfj45RHYkgn1OCQ0wqIjvt234FqOtRUgjhOHkIfjA6
         nnOO3Lo3gZGaXSpXPLJNTobmvgFDMsj+TPJZz/Tc5Z84VtLXI62XPtqYxwYE6+SlsC
         ZouskijkHpdB9bMdaZ0dz3/fjazBwFR2T+Fjet7vmjGmy/UZFPomdK7TVZ30DhepkC
         mTrM5henuun1HGzvVH7OCNATSCRq5hyNWmbBulf5h7iNlJ5nPhV3OFjnAbwoxOeaqj
         aTFW+Tzw5V69WjdjZZ/siuTWwE4C6mFgbsBAL4icTRVyR71XNQ4oN/F8SE3UY8a0kq
         rzMfX57uOqfFQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 08/13] iio:accel:adxl372: Move exports into IIO_ADXL372 namespace
Date:   Sun, 16 Jan 2022 18:05:30 +0000
Message-Id: <20220116180535.2367780-9-jic23@kernel.org>
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
---
 drivers/iio/accel/adxl372.c     | 4 ++--
 drivers/iio/accel/adxl372_i2c.c | 1 +
 drivers/iio/accel/adxl372_spi.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 758952584f8c..e3ecbaee61f7 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1176,7 +1176,7 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
 {
 	return (reg == ADXL372_FIFO_DATA);
 }
-EXPORT_SYMBOL_GPL(adxl372_readable_noinc_reg);
+EXPORT_SYMBOL_NS_GPL(adxl372_readable_noinc_reg, IIO_ADXL372);
 
 int adxl372_probe(struct device *dev, struct regmap *regmap,
 		  int irq, const char *name)
@@ -1260,7 +1260,7 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(adxl372_probe);
+EXPORT_SYMBOL_NS_GPL(adxl372_probe, IIO_ADXL372);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index 9a07ab3d151a..4efb70a5fe40 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -67,3 +67,4 @@ module_i2c_driver(adxl372_i2c_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_ADXL372);
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 1f1352fee99a..2bd267a22f29 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -59,3 +59,4 @@ module_spi_driver(adxl372_spi_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_ADXL372);
-- 
2.34.1

