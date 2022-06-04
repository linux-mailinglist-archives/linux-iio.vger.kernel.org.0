Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1070053D788
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiFDPoL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiFDPoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 11:44:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C25E19C2E
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 08:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF6B9B80691
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 15:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6F6C34119;
        Sat,  4 Jun 2022 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654357446;
        bh=Mlcmg6noszWbzEl5UzPqTRwAnDARqJ7495GB0rIUWs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/0JvZ15lnxchnhfsg0vvVp7+iZGiv7iVjV7VlRT2ZH0RUpS+6yVhKTi3Alf7Mpnh
         qL3GO0/MPdI+T/1p/XCrCLUnVnOsjknVgQHcfuEBC02N/DSaXZDX6X1spBtVRPui9b
         FK/1yZh5PxXXUGLHBUZJAY+Oswrhbp6IbHgda/IINYwAqbPOXJrJpw/nOzcs5dx5Kd
         EIitMQVN4fYvoI1ROyKlyrg99Y2eNPxfSmWZ+i09q4f6YMNMW4sxDEJdZYlsGWfZh4
         rqVUXj2REunw6V9LP+b1k8joxePLv1DbLRTnhrscynugW4ZpnluVSAzYR2QqG4dSeH
         3o36Ih2TGnvLA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/4] iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
Date:   Sat,  4 Jun 2022 16:53:03 +0100
Message-Id: <20220604155306.422937-2-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604155306.422937-1-jic23@kernel.org>
References: <20220604155306.422937-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220220173701.502331-2-jic23@kernel.org
---
 drivers/iio/imu/bmi160/bmi160_core.c | 6 +++---
 drivers/iio/imu/bmi160/bmi160_i2c.c  | 1 +
 drivers/iio/imu/bmi160/bmi160_spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index e7aec56ea136..a77f1a8348ff 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -143,7 +143,7 @@ const struct regmap_config bmi160_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 };
-EXPORT_SYMBOL(bmi160_regmap_config);
+EXPORT_SYMBOL_NS(bmi160_regmap_config, IIO_BMI160);
 
 struct bmi160_regs {
 	u8 data; /* LSB byte register for X-axis */
@@ -633,7 +633,7 @@ int bmi160_enable_irq(struct regmap *regmap, bool enable)
 				     BMI160_DRDY_INT_EN, enable_bit,
 				     BMI160_NORMAL_WRITE_USLEEP);
 }
-EXPORT_SYMBOL(bmi160_enable_irq);
+EXPORT_SYMBOL_NS(bmi160_enable_irq, IIO_BMI160);
 
 static int bmi160_get_irq(struct fwnode_handle *fwnode, enum bmi160_int_pin *pin)
 {
@@ -884,7 +884,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(bmi160_core_probe);
+EXPORT_SYMBOL_NS_GPL(bmi160_core_probe, IIO_BMI160);
 
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Bosch BMI160 driver");
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 02f149d37b17..d93f4fa2ad55 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -68,3 +68,4 @@ module_i2c_driver(bmi160_i2c_driver);
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("BMI160 I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BMI160);
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 24f7d75c7903..8b573ea99af2 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -65,3 +65,4 @@ module_spi_driver(bmi160_spi_driver);
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
 MODULE_DESCRIPTION("Bosch BMI160 SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BMI160);
-- 
2.36.1

