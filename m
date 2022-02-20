Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9764BD054
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiBTRas (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:30:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiBTRar (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:30:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F22409F
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C38360DBD
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD7CC340E8;
        Sun, 20 Feb 2022 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378224;
        bh=4/cKAnZZL2JaeSBCoxd0ToS04kNCvUiRXBHpnhIXEog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFz5LVY8G4VOoB1SUnMYKI/ww3ICi18dCmHnp0zfm+y02/zZZ11Gd7LWzIqyZgw3a
         XRN6/P/5lPhH4we1YsT7/D1Cq2BgSDfJuBuF3ZUT04tcZXILKGYNxc5/cCXHO/naYY
         8HYFfx79AOgptgdy4e2JxDzpCJFLoblNq9GXhrGr/9wVgXpf0hasgMek1TQH59x8ws
         +kUx/04OAsgNs6Yk/o8D6uyGqX7bJjxpX+bD+07oLFh0ZrTQPuNoRBPgpYcbkgPcv9
         dJgs7wPNweXcdypoCwpgZxIUANc6nDXOLF/Co2d2xwFJAu+m0fILLyKFJIjTRT+XAX
         oWaXoCqhoiakg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/5] iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
Date:   Sun, 20 Feb 2022 17:36:58 +0000
Message-Id: <20220220173701.502331-3-jic23@kernel.org>
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
 drivers/iio/pressure/bmp280-core.c   | 2 +-
 drivers/iio/pressure/bmp280-i2c.c    | 1 +
 drivers/iio/pressure/bmp280-regmap.c | 4 ++--
 drivers/iio/pressure/bmp280-spi.c    | 1 +
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index bf8167f43c56..fe7aa81e7cc9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1136,7 +1136,7 @@ int bmp280_common_probe(struct device *dev,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL(bmp280_common_probe);
+EXPORT_SYMBOL_NS(bmp280_common_probe, IIO_BMP280);
 
 static int bmp280_runtime_suspend(struct device *dev)
 {
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 35045bd92846..bf4a7a617537 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -68,3 +68,4 @@ module_i2c_driver(bmp280_i2c_driver);
 MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
 MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BMP280);
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index da136dbadc8f..969698518984 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -39,7 +39,7 @@ const struct regmap_config bmp180_regmap_config = {
 	.writeable_reg = bmp180_is_writeable_reg,
 	.volatile_reg = bmp180_is_volatile_reg,
 };
-EXPORT_SYMBOL(bmp180_regmap_config);
+EXPORT_SYMBOL_NS(bmp180_regmap_config, IIO_BMP280);
 
 static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 {
@@ -82,4 +82,4 @@ const struct regmap_config bmp280_regmap_config = {
 	.writeable_reg = bmp280_is_writeable_reg,
 	.volatile_reg = bmp280_is_volatile_reg,
 };
-EXPORT_SYMBOL(bmp280_regmap_config);
+EXPORT_SYMBOL_NS(bmp280_regmap_config, IIO_BMP280);
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 41f6cc56d229..4cfaf3e869b8 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -118,3 +118,4 @@ module_spi_driver(bmp280_spi_driver);
 
 MODULE_DESCRIPTION("BMP280 SPI bus driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BMP280);
-- 
2.35.1

