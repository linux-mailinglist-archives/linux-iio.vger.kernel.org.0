Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F245E9421
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiIYP5e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiIYP5d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 11:57:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F9275C9
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 08:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAD76B8092E
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 15:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F54C433D6;
        Sun, 25 Sep 2022 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664121449;
        bh=XwogLmtfQzMDZQKBDdCpbqAhqGexlmCmc28vy4JEW4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKVMuJCe10v82pHDEEq1gYIxOvlz8Xjz6Y1+Jfz20TZlVSLYDaExdiA+jn9ro5xNe
         SsmV/FyO4poYfzzjQ2FtM1fpzqSAnkaVKuhEDVxaVRY8TZI3dGa+xZT7M+uqagHzEH
         Tz+ZMW79gA/WiOTiJijpv6mxGwYXVKn8Sl961iOk1C5YBNaYKpHcB1mGwCjbRGnzfi
         4oUZAroHes4i+4w03h+Ii3JNXg/5e8ncWuYjVRKE3xbM5cnjLklTrMkGu3sPL5S1Bf
         a4T3qJZr8Bn83MhiBAQ+31DIxGcN8e9WnXA7kxQ+9uYVupqQCiP7D3L8vq+yNTC9Y3
         5M6S+eqDMiysQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 4/5] iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
Date:   Sun, 25 Sep 2022 16:57:18 +0100
Message-Id: <20220925155719.3316280-5-jic23@kernel.org>
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

--
v2: Switch to Paul's more flexible version of the
EXPORT_NS_GPL_DEV_PM_OPS()
---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 21 +++++++++----------
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 ++-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ca85fccc9839..b63c5dab1a56 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -41,7 +41,7 @@ const struct regmap_config inv_icm42600_regmap_config = {
 	.ranges = inv_icm42600_regmap_ranges,
 	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
 };
-EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);
 
 struct inv_icm42600_hw {
 	uint8_t whoami;
@@ -660,13 +660,13 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 
 	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
 }
-EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, IIO_ICM42600);
 
 /*
  * Suspend saves sensors state and turns everything off.
  * Check first if runtime suspend has not already done the job.
  */
-static int __maybe_unused inv_icm42600_suspend(struct device *dev)
+static int inv_icm42600_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	int ret;
@@ -706,7 +706,7 @@ static int __maybe_unused inv_icm42600_suspend(struct device *dev)
  * System resume gets the system back on and restores the sensors state.
  * Manually put runtime power management in system active state.
  */
-static int __maybe_unused inv_icm42600_resume(struct device *dev)
+static int inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	int ret;
@@ -739,7 +739,7 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 }
 
 /* Runtime suspend will turn off sensors that are enabled by iio devices. */
-static int __maybe_unused inv_icm42600_runtime_suspend(struct device *dev)
+static int inv_icm42600_runtime_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	int ret;
@@ -761,7 +761,7 @@ static int __maybe_unused inv_icm42600_runtime_suspend(struct device *dev)
 }
 
 /* Sensors are enabled by iio devices, no need to turn them back on here. */
-static int __maybe_unused inv_icm42600_runtime_resume(struct device *dev)
+static int inv_icm42600_runtime_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	int ret;
@@ -774,12 +774,11 @@ static int __maybe_unused inv_icm42600_runtime_resume(struct device *dev)
 	return ret;
 }
 
-const struct dev_pm_ops inv_icm42600_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_resume)
-	SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,
-			   inv_icm42600_runtime_resume, NULL)
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
+	SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_resume)
+	RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,
+		       inv_icm42600_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);
 
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index d4a692b838d0..4f96989ddf4a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -93,7 +93,7 @@ static struct i2c_driver inv_icm42600_driver = {
 	.driver = {
 		.name = "inv-icm42600-i2c",
 		.of_match_table = inv_icm42600_of_matches,
-		.pm = &inv_icm42600_pm_ops,
+		.pm = pm_ptr(&inv_icm42600_pm_ops),
 	},
 	.probe_new = inv_icm42600_probe,
 };
@@ -102,3 +102,4 @@ module_i2c_driver(inv_icm42600_driver);
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_ICM42600);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index e6305e5fa975..486b46e53113 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -89,7 +89,7 @@ static struct spi_driver inv_icm42600_driver = {
 	.driver = {
 		.name = "inv-icm42600-spi",
 		.of_match_table = inv_icm42600_of_matches,
-		.pm = &inv_icm42600_pm_ops,
+		.pm = pm_ptr(&inv_icm42600_pm_ops),
 	},
 	.probe = inv_icm42600_probe,
 };
@@ -98,3 +98,4 @@ module_spi_driver(inv_icm42600_driver);
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-426xx SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_ICM42600);
-- 
2.37.2

