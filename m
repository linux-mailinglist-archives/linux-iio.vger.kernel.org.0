Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B751481FE1
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbhL3T2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57870 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbhL3T2C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0432D616B2
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFA1C36AE7;
        Thu, 30 Dec 2021 19:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892481;
        bh=FXDUSPCrefTLukjPwotfgOuvn04Ru0bqMJ2cDAZj+Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8+wrnajwC22PtLHj2X8pN9j/HHQIPFM1u7c11s4aXfNSz0zJyL9w7EOgX4kIt9zb
         u5CfoY03pEKL3I36Piwn5A2iOrKabbs23PQKQOZUX9znCRi3JRtsP2RbwY4eQbCZks
         apNwb1I38cG4JN8BnWbrAZqXXzWZtLNZnWnyDSpiwRI5ZYw0mOw5p4J4hNvCA6zJyg
         nVXUJqx+1xRRNg1BeNP/kqsf5xlbkx+dZMopt8hcvwS+wa/OJt5GcLhpp0+pg0WrBJ
         Ekc1Xsoga2n2k0MigQpSGp+MjNAqrHWr6QnFIGcrFSwtb/8lUKc06Pbj0m1nq04Ny1
         Mw5ijY5ohoX5g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/13] iio:accel:adxl345: Move exports into ADXL345 namespace
Date:   Thu, 30 Dec 2021 19:33:24 +0000
Message-Id: <20211230193331.283503-7-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl345_core.c | 2 +-
 drivers/iio/accel/adxl345_i2c.c  | 1 +
 drivers/iio/accel/adxl345_spi.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 4b275051ef61..b1e7a6b29e8d 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -270,7 +270,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(adxl345_core_probe);
+EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, ADXL345);
 
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
 MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer core driver");
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a431cba216e6..92deea7b45ec 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -68,3 +68,4 @@ module_i2c_driver(adxl345_i2c_driver);
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
 MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ADXL345);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index ea559ac2e87d..749f16665ab6 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -72,3 +72,4 @@ module_spi_driver(adxl345_spi_driver);
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
 MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ADXL345);
-- 
2.34.1

