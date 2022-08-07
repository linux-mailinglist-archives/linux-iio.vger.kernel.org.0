Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273758BC77
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiHGSfZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHGSfY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:35:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C8267E
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1117B80B45
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4BEC433D7;
        Sun,  7 Aug 2022 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897320;
        bh=ZQ6puuR9CJgu4vwsrRXnq3OLozFEZJMQXQEt1nfGFVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JO/cVxsuRFjbeY4eGfPH+egER8r/tDF1HNkgcAh7/TNm9o+KtQwlyCvJE72OWqieO
         ZkaQOgQ0QOvE+IziG32k3Mmfwfbto+asmZsEpzCE0EiGKMp2aPfNItMw4RSeVokMm9
         glwJV6jKMun66Tg2IBbLtl4k/SW7RDsK5wloVkTZFmWi/LNHz0WA5Pq8cMY9+vad5k
         iKy3VH0GoNYGDQ0ahCBBo3KtdGEyblN07kthMqPkuF10rQt+n19pTCSTlQLdow/NYf
         HPp0T7EGZqPolpAIsyv/A9IIQMTINb53ZlfXZBiPQAfkRHuj5G3dJpxRC2uxIyj440
         gQ7/94ybatYUA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio: magn: hmc5843: Move struct dev_pm_ops out of header
Date:   Sun,  7 Aug 2022 19:45:34 +0100
Message-Id: <20220807184534.1037363-3-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807184534.1037363-1-jic23@kernel.org>
References: <20220807184534.1037363-1-jic23@kernel.org>
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

Having this structure defined static in the header lead to
unnecessary duplication and required additional symbol exports.
Use the EXPORT_NS_SIMPLE_DEV_PM_OPS() to clean this up in the same
fashion as many other drivers do this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/hmc5843.h      | 13 +------------
 drivers/iio/magnetometer/hmc5843_core.c |  8 ++++----
 drivers/iio/magnetometer/hmc5843_i2c.c  |  2 +-
 drivers/iio/magnetometer/hmc5843_spi.c  |  2 +-
 4 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 9120c8bbf3dd..60fbb5431c88 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -52,16 +52,5 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 			 enum hmc5843_ids id, const char *name);
 void hmc5843_common_remove(struct device *dev);
 
-int hmc5843_common_suspend(struct device *dev);
-int hmc5843_common_resume(struct device *dev);
-
-#ifdef CONFIG_PM_SLEEP
-static __maybe_unused SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
-					hmc5843_common_suspend,
-					hmc5843_common_resume);
-#define HMC5843_PM_OPS (&hmc5843_pm_ops)
-#else
-#define HMC5843_PM_OPS NULL
-#endif
-
+extern const struct dev_pm_ops hmc5843_pm_ops;
 #endif /* HMC5843_CORE_H */
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 4a63b2da9df0..c5521d61da29 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -603,19 +603,19 @@ static const struct iio_info hmc5843_info = {
 
 static const unsigned long hmc5843_scan_masks[] = {0x7, 0};
 
-int hmc5843_common_suspend(struct device *dev)
+static int hmc5843_common_suspend(struct device *dev)
 {
 	return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
 				HMC5843_MODE_SLEEP);
 }
-EXPORT_SYMBOL_NS(hmc5843_common_suspend, IIO_HMC5843);
 
-int hmc5843_common_resume(struct device *dev)
+static int hmc5843_common_resume(struct device *dev)
 {
 	return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
 		HMC5843_MODE_CONVERSION_CONTINUOUS);
 }
-EXPORT_SYMBOL_NS(hmc5843_common_resume, IIO_HMC5843);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(hmc5843_pm_ops, hmc5843_common_suspend,
+			    hmc5843_common_resume, IIO_HMC5843);
 
 int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 			 enum hmc5843_ids id, const char *name)
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 8d2ff8fc204d..825a881d37fb 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(of, hmc5843_of_match);
 static struct i2c_driver hmc5843_driver = {
 	.driver = {
 		.name	= "hmc5843",
-		.pm	= HMC5843_PM_OPS,
+		.pm	= pm_sleep_ptr(&hmc5843_pm_ops),
 		.of_match_table = hmc5843_of_match,
 	},
 	.id_table	= hmc5843_id,
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 310027a53342..c42d2e2a6a6c 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -88,7 +88,7 @@ MODULE_DEVICE_TABLE(spi, hmc5843_id);
 static struct spi_driver hmc5843_driver = {
 	.driver = {
 		.name = "hmc5843",
-		.pm = HMC5843_PM_OPS,
+		.pm = pm_sleep_ptr(&hmc5843_pm_ops),
 	},
 	.id_table = hmc5843_id,
 	.probe = hmc5843_spi_probe,
-- 
2.37.1

