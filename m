Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4558958BCAD
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiHGTKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 15:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiHGTKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 15:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382341AA;
        Sun,  7 Aug 2022 12:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06A56104E;
        Sun,  7 Aug 2022 19:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B4EC4314E;
        Sun,  7 Aug 2022 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659899432;
        bh=pirJ+ql1B1CAfCYbpYqMg2PeXk7Wv/vK7QJQDYfM07U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKANGeHJ/BQaudLikd0mgSFPdkZMOXJLB9rvQkJA30VlfoplirGPD/1xOiKDdygab
         JPmVgHS1tfydP6RLNs/kagndyPAaaX/TJLHPCjzhBJ11H9Mq7lxwRme5IC7C1e7HgX
         Tb37uEuhVAnBR7RAI5OAOmjfzff1MsRqhpzbzifJtKDGIbcg8ywFgzB+mc/2qRO7hN
         Ew65e48ukZA/7pKQWSdR/V8sycydNc1fxbrJZKmp3q6iR8bJ0jLGevXOp3YV9Nnl5/
         Zbad1ydI++/6f2FSom6jCzAvMShEY9CxZV0hwClr4KGTSjvvy7FCxYjfV0gQdw/AQd
         nM7mTS2Y54fxg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/5] iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
Date:   Sun,  7 Aug 2022 20:20:36 +0100
Message-Id: <20220807192038.1039771-4-jic23@kernel.org>
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

Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that
brings by allowing the compiler to remove unused struct dev_pm_ops
and callbacks without needing explicit __maybe_unused markings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/fxas21002c_core.c | 21 +++++++++------------
 drivers/iio/gyro/fxas21002c_i2c.c  |  3 ++-
 drivers/iio/gyro/fxas21002c_spi.c  |  3 ++-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index a36d71d9e3ea..9aee9096363f 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -998,7 +998,7 @@ int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(fxas21002c_core_probe);
+EXPORT_SYMBOL_NS_GPL(fxas21002c_core_probe, IIO_FXAS21002C);
 
 void fxas21002c_core_remove(struct device *dev)
 {
@@ -1009,9 +1009,9 @@ void fxas21002c_core_remove(struct device *dev)
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }
-EXPORT_SYMBOL_GPL(fxas21002c_core_remove);
+EXPORT_SYMBOL_NS_GPL(fxas21002c_core_remove, IIO_FXAS21002C);
 
-static int __maybe_unused fxas21002c_suspend(struct device *dev)
+static int fxas21002c_suspend(struct device *dev)
 {
 	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
 
@@ -1021,7 +1021,7 @@ static int __maybe_unused fxas21002c_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused fxas21002c_resume(struct device *dev)
+static int fxas21002c_resume(struct device *dev)
 {
 	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -1033,26 +1033,23 @@ static int __maybe_unused fxas21002c_resume(struct device *dev)
 	return fxas21002c_mode_set(data, data->prev_mode);
 }
 
-static int __maybe_unused fxas21002c_runtime_suspend(struct device *dev)
+static int fxas21002c_runtime_suspend(struct device *dev)
 {
 	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
 
 	return fxas21002c_mode_set(data, FXAS21002C_MODE_READY);
 }
 
-static int __maybe_unused fxas21002c_runtime_resume(struct device *dev)
+static int fxas21002c_runtime_resume(struct device *dev)
 {
 	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
 
 	return fxas21002c_mode_set(data, FXAS21002C_MODE_ACTIVE);
 }
 
-const struct dev_pm_ops fxas21002c_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(fxas21002c_suspend, fxas21002c_resume)
-	SET_RUNTIME_PM_OPS(fxas21002c_runtime_suspend,
-			   fxas21002c_runtime_resume, NULL)
-};
-EXPORT_SYMBOL_GPL(fxas21002c_pm_ops);
+EXPORT_NS_GPL_DEV_PM_OPS(fxas21002c_pm_ops, fxas21002c_suspend,
+			 fxas21002c_resume, fxas21002c_runtime_suspend,
+			 fxas21002c_runtime_resume, NULL, IIO_FXAS21002C);
 
 MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
index a7807fd97483..241401a9dfea 100644
--- a/drivers/iio/gyro/fxas21002c_i2c.c
+++ b/drivers/iio/gyro/fxas21002c_i2c.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, fxas21002c_i2c_of_match);
 static struct i2c_driver fxas21002c_i2c_driver = {
 	.driver = {
 		.name = "fxas21002c_i2c",
-		.pm = &fxas21002c_pm_ops,
+		.pm = pm_ptr(&fxas21002c_pm_ops),
 		.of_match_table = fxas21002c_i2c_of_match,
 	},
 	.probe_new	= fxas21002c_i2c_probe,
@@ -67,3 +67,4 @@ module_i2c_driver(fxas21002c_i2c_driver);
 MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("FXAS21002C I2C Gyro driver");
+MODULE_IMPORT_NS(IIO_FXAS21002C);
diff --git a/drivers/iio/gyro/fxas21002c_spi.c b/drivers/iio/gyro/fxas21002c_spi.c
index c3ac169facf9..4f633826547c 100644
--- a/drivers/iio/gyro/fxas21002c_spi.c
+++ b/drivers/iio/gyro/fxas21002c_spi.c
@@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, fxas21002c_spi_of_match);
 static struct spi_driver fxas21002c_spi_driver = {
 	.driver = {
 		.name = "fxas21002c_spi",
-		.pm = &fxas21002c_pm_ops,
+		.pm = pm_ptr(&fxas21002c_pm_ops),
 		.of_match_table = fxas21002c_spi_of_match,
 	},
 	.probe		= fxas21002c_spi_probe,
@@ -66,3 +66,4 @@ module_spi_driver(fxas21002c_spi_driver);
 MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("FXAS21002C SPI Gyro driver");
+MODULE_IMPORT_NS(IIO_FXAS21002C);
-- 
2.37.1

