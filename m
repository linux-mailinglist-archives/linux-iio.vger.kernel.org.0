Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358058BC8D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiHGSqW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiHGSqV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:46:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394D5FC2
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CF4AB80DD2
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF472C433D7;
        Sun,  7 Aug 2022 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897978;
        bh=gh9dAa4lU3KGG4qIFaxrhPbXW9+x3k+g1sB469It49k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyOg/DXc/EcDFLluFnyOZdGoYn6fL1WztDjzYFHgllIW7lea6p0WYdqRO/1yNMtC1
         fet0pCraS6XQtMAudUbGmxXHT5q85clQqe8WtB67ImkF5XKFY6ha5uKJrARZXQUFgf
         KyLc3eiMoY070Sng7EjVuZypLEMkXS4NF8dUJVh/Pwuty34ebxLIaQ6lX59mqjT2u4
         c/ft+EgnuVYSVD7vzLS0vBjR0tW+lwnsTN0mD22c/NIHlE2mzdB32gsHQDxB8c1JHP
         CkTKkmQE7nmBz/NXGC4qg2kS2F527CeZPbZq9635JvFADDcyYOYTtFDWX+dowlICDm
         GjBYa6yA26nUw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/6] iio: accel: bmi088: Use EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS() and pm_ptr()
Date:   Sun,  7 Aug 2022 19:56:17 +0100
Message-Id: <20220807185618.1038812-6-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807185618.1038812-1-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
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

These macros allow the compiler to remove unused pm ops functions without
needing to mark them maybe unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/accel/bmi088-accel-core.c | 15 ++++++---------
 drivers/iio/accel/bmi088-accel-spi.c  |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index bca4cf98bf4d..84edcc78d796 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -606,7 +606,7 @@ void bmi088_accel_core_remove(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(bmi088_accel_core_remove, IIO_BMI088);
 
-static int __maybe_unused bmi088_accel_runtime_suspend(struct device *dev)
+static int bmi088_accel_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
@@ -614,7 +614,7 @@ static int __maybe_unused bmi088_accel_runtime_suspend(struct device *dev)
 	return bmi088_accel_power_down(data);
 }
 
-static int __maybe_unused bmi088_accel_runtime_resume(struct device *dev)
+static int bmi088_accel_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
@@ -622,13 +622,10 @@ static int __maybe_unused bmi088_accel_runtime_resume(struct device *dev)
 	return bmi088_accel_power_up(data);
 }
 
-const struct dev_pm_ops bmi088_accel_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
-			   bmi088_accel_runtime_resume, NULL)
-};
-EXPORT_SYMBOL_NS_GPL(bmi088_accel_pm_ops, IIO_BMI088);
+EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(bmi088_accel_pm_ops,
+				 bmi088_accel_runtime_suspend,
+				 bmi088_accel_runtime_resume, NULL,
+				 IIO_BMI088);
 
 MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index 9e2ed3bd5661..ee540edd8412 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -80,7 +80,7 @@ MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
 static struct spi_driver bmi088_accel_driver = {
 	.driver = {
 		.name	= "bmi088_accel_spi",
-		.pm	= &bmi088_accel_pm_ops,
+		.pm	= pm_ptr(&bmi088_accel_pm_ops),
 		.of_match_table = bmi088_of_match,
 	},
 	.probe		= bmi088_accel_probe,
-- 
2.37.1

