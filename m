Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55258BCB3
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiHGTKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiHGTKl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 15:10:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE037E9;
        Sun,  7 Aug 2022 12:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EB9FB80DD0;
        Sun,  7 Aug 2022 19:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838F2C433D7;
        Sun,  7 Aug 2022 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659899438;
        bh=9rg7R3Rqz04Tp0YCZJt9Ddj6gzPV5rJdfyKyf8ZZknY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jC4q9svuGITmI4V5Wyz+8A9ilFS6JjUcn9BGXY5Xq9/+pE5k8tdmsC8PhV+p/aok3
         SROYuNrBdGbWNHgPRlCH7u20uLMtpScw34r0N6n6LXtg/PUSUo6s5oGy/a64Bg2W9a
         YVUM14GiW7ysQAUkybBHFK83ZVUl9KY3bg+ZYHSPtsn3sqog3Gmt5s4i02ucKBJIgF
         LULIujQbTgmpGOB5nCYfqsahcbt8tsQUUBMn39Pz0Mo1PqT8/i7lmp130lUvw5oQnQ
         gGtovT1+ADARkvLPHU8XFAIgQ5ZO9T2u3+z7eKvZYoGGPqpvNo2EUsoC5WIeyVW50T
         ZFzQqCZspujPQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/5] iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace
Date:   Sun,  7 Aug 2022 20:20:38 +0100
Message-Id: <20220807192038.1039771-6-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807192038.1039771-1-jic23@kernel.org>
References: <20220807192038.1039771-1-jic23@kernel.org>
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

As these exports are only relevant to core module and users in the
bus specific modules, move them out of the main kernel namespace.

Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that
brings by allowing the compiler to remove unused struct dev_pm_ops
and callbacks without needing explicit __maybe_unused markings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 18 ++++++++----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  3 ++-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 86fbbe904050..27cbc07d6369 100644
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
@@ -1767,11 +1767,9 @@ static int __maybe_unused inv_mpu_runtime_resume(struct device *dev)
 	return inv_mpu6050_set_power_itg(st, true);
 }
 
-const struct dev_pm_ops inv_mpu_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)
-	SET_RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runtime_resume, NULL)
-};
-EXPORT_SYMBOL_GPL(inv_mpu_pmops);
+EXPORT_NS_GPL_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume,
+			 inv_mpu_runtime_suspend, inv_mpu_runtime_resume, NULL,
+			 IIO_MPU6050);
 
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
2.37.1

