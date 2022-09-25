Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F245E9422
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiIYP5g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiIYP5e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 11:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29442715A
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 08:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F12F60F93
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 15:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B94C433B5;
        Sun, 25 Sep 2022 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664121452;
        bh=mNHeVB5mIHShKejx2cdqzQ88qbRpxtUXG3j0ptByN5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKLsv1bSlH6W5+6Pclc36aIiCmOnNRJ97K4xdgCSkrR2tGx7vOfGIUHEQAVWTxiha
         Lu66bcCHdEYmtI2lLka68inQno2aLBtPUaAS1C05i1Q869uKvi0SX3bMFjCXG9CCNy
         gU/Rc1g3l7sBjrKQ+S4KQ6T8+gyEzUVHKKoeA2SgomaUAM1X2sl7w6PkQh7FeWwyWc
         NjCvNFF9DfYh12MDlSgX0PAACerLzN7bTkB+PAT/jgQIq0uqj42lL+iFxkK3t3InM4
         0bWw/N6JyN6tNzqr5GezQwMkfPcWupNzU/I7ARvbMSP6u5zZ4AtdNisAomUh54pVYS
         931PtUhrXBBRg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 5/5] iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace
Date:   Sun, 25 Sep 2022 16:57:19 +0100
Message-Id: <20220925155719.3316280-6-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220925155719.3316280-1-jic23@kernel.org>
References: <20220925155719.3316280-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As these exports are only relevant to core module and users in the
bus specific modules, move them out of the main kernel namespace.

Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that
brings by allowing the compiler to remove unused struct dev_pm_ops
and callbacks without needing explicit __maybe_unused markings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

--
v2: Switch to more flexible version of EXPORT* macro from Paul.
Dropped Linus' tag as the new patch is significantly different.
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 17 ++++++++---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  3 ++-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 86fbbe904050..8a129120b73d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1653,9 +1653,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	inv_mpu6050_set_power_itg(st, false);
 	return result;
 }
-EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
+EXPORT_SYMBOL_NS_GPL(inv_mpu_core_probe, IIO_MPU6050);
 
-static int __maybe_unused inv_mpu_resume(struct device *dev)
+static int inv_mpu_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
@@ -1687,7 +1687,7 @@ static int __maybe_unused inv_mpu_resume(struct device *dev)
 	return result;
 }
 
-static int __maybe_unused inv_mpu_suspend(struct device *dev)
+static int inv_mpu_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
@@ -1730,7 +1730,7 @@ static int __maybe_unused inv_mpu_suspend(struct device *dev)
 	return result;
 }
 
-static int __maybe_unused inv_mpu_runtime_suspend(struct device *dev)
+static int inv_mpu_runtime_suspend(struct device *dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
 	unsigned int sensors;
@@ -1755,7 +1755,7 @@ static int __maybe_unused inv_mpu_runtime_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused inv_mpu_runtime_resume(struct device *dev)
+static int inv_mpu_runtime_resume(struct device *dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -1767,11 +1767,10 @@ static int __maybe_unused inv_mpu_runtime_resume(struct device *dev)
 	return inv_mpu6050_set_power_itg(st, true);
 }
 
-const struct dev_pm_ops inv_mpu_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)
-	SET_RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runtime_resume, NULL)
+EXPORT_NS_GPL_DEV_PM_OPS(inv_mpu_pmops, IIO_MPU6050) = {
+	SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)
+	RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(inv_mpu_pmops);
 
 MODULE_AUTHOR("Invensense Corporation");
 MODULE_DESCRIPTION("Invensense device MPU6050 driver");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 2aa647704a79..f89164fabf4b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -269,7 +269,7 @@ static struct i2c_driver inv_mpu_driver = {
 		.of_match_table = inv_of_match,
 		.acpi_match_table = inv_acpi_match,
 		.name	=	"inv-mpu6050-i2c",
-		.pm     =       &inv_mpu_pmops,
+		.pm     =       pm_ptr(&inv_mpu_pmops),
 	},
 };
 
@@ -278,3 +278,4 @@ module_i2c_driver(inv_mpu_driver);
 MODULE_AUTHOR("Invensense Corporation");
 MODULE_DESCRIPTION("Invensense device MPU6050 driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MPU6050);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index e6107b0cc38f..89f46c2f213d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -154,7 +154,7 @@ static struct spi_driver inv_mpu_driver = {
 		.of_match_table = inv_of_match,
 		.acpi_match_table = inv_acpi_match,
 		.name	=	"inv-mpu6000-spi",
-		.pm     =       &inv_mpu_pmops,
+		.pm     =       pm_ptr(&inv_mpu_pmops),
 	},
 };
 
@@ -163,3 +163,4 @@ module_spi_driver(inv_mpu_driver);
 MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");
 MODULE_DESCRIPTION("Invensense device MPU6000 driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MPU6050);
-- 
2.37.2

