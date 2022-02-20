Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC104BD041
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiBTRas (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:30:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbiBTRar (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:30:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE6626AEB
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7955B80D33
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7129BC340EB;
        Sun, 20 Feb 2022 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378223;
        bh=Kn+czdOal8teYCnUQKPrMiXsyzyAnH1QCBEvZV5LITM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ayt4Yh7naZd0hcFc/CFIeVkpD0NQhVWF43HMaUmj9iIuKF9+T/EmsfJMW6oPa8ozF
         H3pyS25f83QA6WBHNTPNxX52buf+CWCNOqR/FX4fwaVrp6eXGxF/9blG80vtHRkgkV
         B26D+3mO9ckFeoABxFCMLcolULDoNxk4WXlhMpAH04hSteUKc2yltLym24Q0mVnaCo
         ZmZ9j6XKo7l1ijn2uwphOl33pPrUJ2FEgtUp75KZWJZZpVzvgK2Jnt5DzROCMxPGw2
         5kjZvtKmn2g0hILnCgyv4gdj3Bjr6G1baQr1FsnNBnu3soa4EegYZn6M3zG3b/gmJK
         Q7MRmocBtXgTw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/5] iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
Date:   Sun, 20 Feb 2022 17:36:57 +0000
Message-Id: <20220220173701.502331-2-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220173701.502331-1-jic23@kernel.org>
References: <20220220173701.502331-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/iio/imu/bmi160/bmi160_core.c | 6 +++---
 drivers/iio/imu/bmi160/bmi160_i2c.c  | 1 +
 drivers/iio/imu/bmi160/bmi160_spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 824b5124a5f5..40dfea70d73a 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -144,7 +144,7 @@ const struct regmap_config bmi160_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 };
-EXPORT_SYMBOL(bmi160_regmap_config);
+EXPORT_SYMBOL_NS(bmi160_regmap_config, IIO_BMI160);
 
 struct bmi160_regs {
 	u8 data; /* LSB byte register for X-axis */
@@ -645,7 +645,7 @@ int bmi160_enable_irq(struct regmap *regmap, bool enable)
 				     BMI160_DRDY_INT_EN, enable_bit,
 				     BMI160_NORMAL_WRITE_USLEEP);
 }
-EXPORT_SYMBOL(bmi160_enable_irq);
+EXPORT_SYMBOL_NS(bmi160_enable_irq, IIO_BMI160);
 
 static int bmi160_get_irq(struct device_node *of_node, enum bmi160_int_pin *pin)
 {
@@ -891,7 +891,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(bmi160_core_probe);
+EXPORT_SYMBOL_NS_GPL(bmi160_core_probe, IIO_BMI160);
 
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Bosch BMI160 driver");
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 26398614eddf..8a62c1d3669d 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -69,3 +69,4 @@ module_i2c_driver(bmi160_i2c_driver);
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("BMI160 I2C driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BMI160);
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 61389b41c6d9..f78998089f25 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -61,3 +61,4 @@ module_spi_driver(bmi160_spi_driver);
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
 MODULE_DESCRIPTION("Bosch BMI160 SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BMI160);
-- 
2.35.1

