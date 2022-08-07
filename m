Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC22558BCAF
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiHGTKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 15:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHGTKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 15:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C26E9;
        Sun,  7 Aug 2022 12:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F15CB80881;
        Sun,  7 Aug 2022 19:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E29C433D7;
        Sun,  7 Aug 2022 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659899428;
        bh=SWYmC+RXEqVAhfGvwxF8wxf+4TJ1kWJbu7Ijmml8yxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpYWoK9vsVsQL2Koai5IUtVNTqCviehdshzBEjVvuz68N4YPBuPmws/FC3rLbnF4H
         XMdV5XW0tyAolg1eRHpznEAYY5k1GjumyHke0P8PytLbGOv6X/JIAmZsGCn5OH0PND
         l7RAyKqKZm47018PBIBlXWrUgsbIaBTL4A0YPhlLn9ATNCwKZydMMhzMCwDJhmLWw3
         sUGZjpOj0k3dVANxOy+pPd9wG3tXQHhABHmEveB1tZU3sJcPDHNd177pZ4YBOkVLNv
         xO6a28hJed+1twTzfbSbGUoByeozW0pUu1Wbh2NZ6PqRVDtLKv0svKNiBNtBR7WYIB
         UiEE6FCHNKBkQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/5] iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
Date:   Sun,  7 Aug 2022 20:20:35 +0100
Message-Id: <20220807192038.1039771-3-jic23@kernel.org>
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

Using this macro allows the compiler to remove unused
structures and callbacks if we are not building with
CONFIG_PM* without needing __maybe_unused markings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 17 +++++++----------
 drivers/iio/accel/fxls8962af-i2c.c  |  2 +-
 drivers/iio/accel/fxls8962af-spi.c  |  2 +-
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 8874d6d61725..6c7dde4a1af9 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1241,7 +1241,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 }
 EXPORT_SYMBOL_NS_GPL(fxls8962af_core_probe, IIO_FXLS8962AF);
 
-static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
+static int fxls8962af_runtime_suspend(struct device *dev)
 {
 	struct fxls8962af_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -1255,14 +1255,14 @@ static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
+static int fxls8962af_runtime_resume(struct device *dev)
 {
 	struct fxls8962af_data *data = iio_priv(dev_get_drvdata(dev));
 
 	return fxls8962af_active(data);
 }
 
-static int __maybe_unused fxls8962af_suspend(struct device *dev)
+static int fxls8962af_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct fxls8962af_data *data = iio_priv(indio_dev);
@@ -1283,7 +1283,7 @@ static int __maybe_unused fxls8962af_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused fxls8962af_resume(struct device *dev)
+static int fxls8962af_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct fxls8962af_data *data = iio_priv(indio_dev);
@@ -1300,12 +1300,9 @@ static int __maybe_unused fxls8962af_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops fxls8962af_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
-	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
-			   fxls8962af_runtime_resume, NULL)
-};
-EXPORT_SYMBOL_NS_GPL(fxls8962af_pm_ops, IIO_FXLS8962AF);
+EXPORT_NS_GPL_DEV_PM_OPS(fxls8962af_pm_ops, fxls8962af_suspend, fxls8962af_resume,
+			 fxls8962af_runtime_suspend, fxls8962af_runtime_resume, NULL,
+			 IIO_FXLS8962AF);
 
 MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
 MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 8fbadfea1620..22640eaebac7 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -45,7 +45,7 @@ static struct i2c_driver fxls8962af_driver = {
 	.driver = {
 		   .name = "fxls8962af_i2c",
 		   .of_match_table = fxls8962af_of_match,
-		   .pm = &fxls8962af_pm_ops,
+		   .pm = pm_ptr(&fxls8962af_pm_ops),
 		   },
 	.probe_new = fxls8962af_probe,
 	.id_table = fxls8962af_id,
diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
index 885b3ab7fcb5..a0d192211839 100644
--- a/drivers/iio/accel/fxls8962af-spi.c
+++ b/drivers/iio/accel/fxls8962af-spi.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(spi, fxls8962af_spi_id_table);
 static struct spi_driver fxls8962af_driver = {
 	.driver = {
 		   .name = "fxls8962af_spi",
-		   .pm = &fxls8962af_pm_ops,
+		   .pm = pm_ptr(&fxls8962af_pm_ops),
 		   .of_match_table = fxls8962af_spi_of_match,
 		   },
 	.probe = fxls8962af_probe,
-- 
2.37.1

