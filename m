Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12153D787
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiFDPoL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiFDPoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 11:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84D19C2D
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 08:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793D460E77
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 15:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FF1C36AE2;
        Sat,  4 Jun 2022 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654357447;
        bh=KX9+n4hNp+7Itd6N6or1zRbKNdRQmjNt0T5pV8ee9dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUY+mNUNb/ARC+knWX2jy7OlbKaDvDakta3sZxtIE0OjvCZlq89nFlam9aCqZQzwE
         txDWfRh36LBFULEhDW2/wIHRvGX2M1lMUQJ+fLbIonosN+42ccJXeA9urvA4DxJ12a
         l736yOdwP0DCp2e587v8faxuWfJW9RqxZ30nDG95yhiK5ANMdA8+4gM3IHUW6xOSPY
         YEwyeZImosbgKfND+KKbSIs3CYxIkqxzbhXdboWhNJxzdNtk1qE9jArVbx7ycJM+EC
         xC/JNiNhb6jBCKkFeHu6UY1IBkqrOI3CTyvh6MXszwmLLsFIperz5U7ese6zZwl5Xu
         3dYDC4U3d+alQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/4] iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
Date:   Sat,  4 Jun 2022 16:53:04 +0100
Message-Id: <20220604155306.422937-3-jic23@kernel.org>
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
Link: https://lore.kernel.org/r/20220220173701.502331-3-jic23@kernel.org
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
2.36.1

