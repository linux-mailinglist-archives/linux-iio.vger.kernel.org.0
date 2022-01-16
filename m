Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A615648FE4C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiAPSAB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 13:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbiAPSAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 13:00:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D169C061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 10:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A280560FA3
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 18:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ACCC36AEF;
        Sun, 16 Jan 2022 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642356000;
        bh=6U3Y7NvIdr0cda4F5d9INCRglPe5fQfWl5yVNn8DvB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSf9AFJ2HtFb5QGQyTSi4X1lvUcPWz2WTwe4Aclqn0H+tYlrZ2dfmYHjId1vYu+xa
         l90z4amsSZqj7BtipLGC17/lkLW2FP/pr7+UjhNW/vgIE2SLsHkyvp425T6ryDlVTW
         vODxG3pRHzKgRlJGmjn+gcQtrqIrUkRdIPllZozLI6ohmZXdSKZxuso+QkJ2dZN4m7
         cTJ9HLJMD9K4UcIlKjq0qOGbqe9307U+xe0tq+zhhJ+nMySRftch+KjfEEcaILx6mo
         JkAiuCJPyUewfxMqlHkQsw5ZvLTxs2qDaog1NkG5X9EgRB5c/G+3eAhIqWBl1w/kWp
         bER8cbJes/AIQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2 10/13] iio:accel:bmi088: Move exports into IIO_BMI088 namespace
Date:   Sun, 16 Jan 2022 18:05:32 +0000
Message-Id: <20220116180535.2367780-11-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To avoid unnecessary pollution of the global symbol namespace move the
driver core exports into their own namespace and import that into the two
bus modules.

For more info see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/accel/bmi088-accel-core.c | 8 ++++----
 drivers/iio/accel/bmi088-accel-spi.c  | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index d74465214feb..8b2728bbcade 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -146,7 +146,7 @@ const struct regmap_config bmi088_regmap_conf = {
 	.volatile_table = &bmi088_volatile_table,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL_GPL(bmi088_regmap_conf);
+EXPORT_SYMBOL_NS_GPL(bmi088_regmap_conf, IIO_BMI088);
 
 static int bmi088_accel_power_up(struct bmi088_accel_data *data)
 {
@@ -533,7 +533,7 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
+EXPORT_SYMBOL_NS_GPL(bmi088_accel_core_probe, IIO_BMI088);
 
 
 void bmi088_accel_core_remove(struct device *dev)
@@ -547,7 +547,7 @@ void bmi088_accel_core_remove(struct device *dev)
 	pm_runtime_set_suspended(dev);
 	bmi088_accel_power_down(data);
 }
-EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
+EXPORT_SYMBOL_NS_GPL(bmi088_accel_core_remove, IIO_BMI088);
 
 static int __maybe_unused bmi088_accel_runtime_suspend(struct device *dev)
 {
@@ -571,7 +571,7 @@ const struct dev_pm_ops bmi088_accel_pm_ops = {
 	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
 			   bmi088_accel_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(bmi088_accel_pm_ops);
+EXPORT_SYMBOL_NS_GPL(bmi088_accel_pm_ops, IIO_BMI088);
 
 MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index 758ad2f12896..961e87a927c4 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -83,3 +83,4 @@ module_spi_driver(bmi088_accel_driver);
 MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BMI088 accelerometer driver (SPI)");
+MODULE_IMPORT_NS(IIO_BMI088);
-- 
2.34.1

