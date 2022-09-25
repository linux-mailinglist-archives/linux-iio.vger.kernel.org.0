Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429F5E941F
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 17:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiIYP53 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 11:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiIYP52 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 11:57:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24212715A
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 08:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABEDFB807EC
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 15:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CFBC433C1;
        Sun, 25 Sep 2022 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664121444;
        bh=cAGPH1E8Tkc4qBCnXgqT5HMncytpSuQwl6n7lmNL//s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpLYebeIvnqMT3f+oJM+ofLikwHWjW0aZSA5kaTyMn9e29DMMUzntkaoLUSs36d3G
         wRa/4Y7182+lgAucIs9fLxwGHWEZIGLnZuj80Qsv1mFYa5kq+Q19zjWZfkWUTp+pfZ
         Trn9KpBL2L6ME67GJpobS3TSWe3lENwgsL8Jh7pQniaEdxD1kfr6yiTMWGXdLudu5s
         C5DzR+FDIjXL2WDkMEFiTZe2ExB1XE62S3Jw91LPhwyz3rN5008WI74Qj6TlaTkF/G
         HZ4M1JTMQZq0qVgxTBPcsXr2RWkEi6BcL6jVm275rhqNMFz1HBy0trKqVYguO0Q5bV
         ciWewN2WLP+yw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/5] iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
Date:   Sun, 25 Sep 2022 16:57:16 +0100
Message-Id: <20220925155719.3316280-3-jic23@kernel.org>
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

Using this macro allows the compiler to remove unused
structures and callbacks if we are not building with
CONFIG_PM* without needing __maybe_unused markings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean@geanix.com>

--
Switched to Paul Cercueil's more flexible implementation fo the macro.
Dropped Sean's Ack given new form of macro being used.
---
 drivers/iio/accel/fxls8962af-core.c | 16 +++++++---------
 drivers/iio/accel/fxls8962af-i2c.c  |  2 +-
 drivers/iio/accel/fxls8962af-spi.c  |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 8874d6d61725..bf259db281f5 100644
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
@@ -1300,12 +1300,10 @@ static int __maybe_unused fxls8962af_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops fxls8962af_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
-	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
-			   fxls8962af_runtime_resume, NULL)
+EXPORT_NS_GPL_DEV_PM_OPS(fxls8962af_pm_ops, IIO_FXLS8962AF) = {
+	SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
+	RUNTIME_PM_OPS(fxls8962af_runtime_suspend, fxls8962af_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_NS_GPL(fxls8962af_pm_ops, IIO_FXLS8962AF);
 
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
2.37.2

