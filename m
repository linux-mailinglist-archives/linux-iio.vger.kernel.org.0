Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB04A397A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347597AbiA3Uuy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:50:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40550 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243587AbiA3Uuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:50:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54912B829BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA1C340EB;
        Sun, 30 Jan 2022 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575852;
        bh=6KAGqw/jW0BbHbU9Rz0tz1bH22YcbTaApTy5yV4nLuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ybn/TrWHF+1rNM5prNkZUUDEO4iWB/ixEnUDzw76seeBNSyJ9i2R+Dr2pkwZz8GDr
         IbAzvY5LlvjOxgcxGTIOavvYqeVw2KBHqoVpp5d/UHhh/K3Zfeqj0oLMAXNVpHWbBl
         gz621Ur3oVEOhqxjwzYxkjTNURxu9cGJIyDdZSOqkdv+cV0QGeShIztJEcRjLglxpH
         Ub1y/IaIP01GowZG0Ik6ubEXtS3r5aVtSZli+JHf/iWH5GYK1IgA+sxpnK7Zvh2/EH
         ARbA1eoI8IxXMhCeosx5D/HOy6bYwmMb5xTFyk/t1GPDNCN8HEdiTEkUW3lPZjQVcF
         XYTmAoiH/t41A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 01/16] iio:adc:ad_sigma_delta: Move exports into IIO_AD_SIGMA_DELTA namespace
Date:   Sun, 30 Jan 2022 20:56:46 +0000
Message-Id: <20220130205701.334592-2-jic23@kernel.org>
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
move the core/library functions into a specific namespace and import
that into the various specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Renato Lui Geh <renatogeh@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7124.c         |  1 +
 drivers/iio/adc/ad7192.c         |  1 +
 drivers/iio/adc/ad7780.c         |  1 +
 drivers/iio/adc/ad7791.c         |  1 +
 drivers/iio/adc/ad7793.c         |  1 +
 drivers/iio/adc/ad_sigma_delta.c | 20 ++++++++++----------
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index bc2cfa5f9592..998a342d51a6 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -970,3 +970,4 @@ module_spi_driver(ad71124_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7124 SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 47d3f56edcbc..770b4e59238f 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1048,3 +1048,4 @@ module_spi_driver(ad7192_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index b6e8c8abf6f4..a813fe04787c 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -375,3 +375,4 @@ module_spi_driver(ad7780_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7780 and similar ADCs");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index cb579aa89f39..fee8d129a5f0 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -474,3 +474,4 @@ module_spi_driver(ad7791_driver);
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Analog Devices AD7787/AD7788/AD7789/AD7790/AD7791 ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 0e7ab3fb072a..5f8cb9aaac70 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -867,3 +867,4 @@ module_spi_driver(ad7793_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7793 and similar ADCs");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index cd418bd8bd87..ebcd52526cac 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -42,7 +42,7 @@ void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm)
 	 * to select the channel */
 	sigma_delta->comm = comm & AD_SD_COMM_CHAN_MASK;
 }
-EXPORT_SYMBOL_GPL(ad_sd_set_comm);
+EXPORT_SYMBOL_NS_GPL(ad_sd_set_comm, IIO_AD_SIGMA_DELTA);
 
 /**
  * ad_sd_write_reg() - Write a register
@@ -94,7 +94,7 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ad_sd_write_reg);
+EXPORT_SYMBOL_NS_GPL(ad_sd_write_reg, IIO_AD_SIGMA_DELTA);
 
 static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 	unsigned int reg, unsigned int size, uint8_t *val)
@@ -171,7 +171,7 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
 out:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ad_sd_read_reg);
+EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, IIO_AD_SIGMA_DELTA);
 
 /**
  * ad_sd_reset() - Reset the serial interface
@@ -199,7 +199,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ad_sd_reset);
+EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
 
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
@@ -238,7 +238,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ad_sd_calibrate);
+EXPORT_SYMBOL_NS_GPL(ad_sd_calibrate, IIO_AD_SIGMA_DELTA);
 
 /**
  * ad_sd_calibrate_all() - Performs channel calibration
@@ -262,7 +262,7 @@ int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ad_sd_calibrate_all);
+EXPORT_SYMBOL_NS_GPL(ad_sd_calibrate_all, IIO_AD_SIGMA_DELTA);
 
 /**
  * ad_sigma_delta_single_conversion() - Performs a single data conversion
@@ -337,7 +337,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	return IIO_VAL_INT;
 }
-EXPORT_SYMBOL_GPL(ad_sigma_delta_single_conversion);
+EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, IIO_AD_SIGMA_DELTA);
 
 static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
@@ -465,7 +465,7 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ad_sd_validate_trigger);
+EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
 
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
@@ -524,7 +524,7 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
 
 	return devm_ad_sd_probe_trigger(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(devm_ad_sd_setup_buffer_and_trigger);
+EXPORT_SYMBOL_NS_GPL(devm_ad_sd_setup_buffer_and_trigger, IIO_AD_SIGMA_DELTA);
 
 /**
  * ad_sd_init() - Initializes a ad_sigma_delta struct
@@ -545,7 +545,7 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ad_sd_init);
+EXPORT_SYMBOL_NS_GPL(ad_sd_init, IIO_AD_SIGMA_DELTA);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Analog Devices Sigma-Delta ADCs");
-- 
2.35.1

