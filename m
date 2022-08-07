Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7658BC8E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiHGSqY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbiHGSqX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0AA2DFB
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29BC160FDE
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF21C433C1;
        Sun,  7 Aug 2022 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897981;
        bh=jepvhA4Llv74Rw5TsHdRp05MgBL7VyTTBmz/OLvGXEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCLgLzYaS9WajvzD2nKBlGfcTuVA/TWtYLR7wY6lft22ck2NhrRphcw+D5m4kYtSc
         8zLe59H/AtrWNYKZgCr1K1z7pmKIereEpwGZh/68HgJT95sMUofEEDMPNyZWzc8EWy
         087OgFqKeui2ItbigFeylkCKO3FhyU1DmaGSaRP197hWftXM+mcGvYqVPXgnGX6Dqc
         lKWO+obEyGaIb8gUZ1Fn1IwYLtTV7cw6RoopaC/DuB7J2SLVa6rMlZyQSml5+3AWdu
         mdHrPCxLIeyO8Va1EhHOLrP7gho2mCitfTPyfH5PDVkaEV9cPflWq9kNngU4zNaucs
         KzF2bcLmzAViQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/6] iio: light: st_uvis25: Use EXPORT_NS_SIMPLE_DEV_PM_OPS()
Date:   Sun,  7 Aug 2022 19:56:18 +0100
Message-Id: <20220807185618.1038812-7-jic23@kernel.org>
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

Using this new macro removes the need to mark the callbacks
__maybe_unused.  One slightly complexity in this case is that
the export will exist if CONFIG_PM is set, but only be used
if CONFIG_PM_SLEEP is also set. This is harmless.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
---
 drivers/iio/light/st_uvis25_core.c | 9 +++------
 drivers/iio/light/st_uvis25_i2c.c  | 2 +-
 drivers/iio/light/st_uvis25_spi.c  | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 3d4cc1180b6a..c737d3e193ae 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -325,7 +325,7 @@ int st_uvis25_probe(struct device *dev, int irq, struct regmap *regmap)
 }
 EXPORT_SYMBOL_NS(st_uvis25_probe, IIO_UVIS25);
 
-static int __maybe_unused st_uvis25_suspend(struct device *dev)
+static int st_uvis25_suspend(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct st_uvis25_hw *hw = iio_priv(iio_dev);
@@ -334,7 +334,7 @@ static int __maybe_unused st_uvis25_suspend(struct device *dev)
 				  ST_UVIS25_REG_ODR_MASK, 0);
 }
 
-static int __maybe_unused st_uvis25_resume(struct device *dev)
+static int st_uvis25_resume(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct st_uvis25_hw *hw = iio_priv(iio_dev);
@@ -346,10 +346,7 @@ static int __maybe_unused st_uvis25_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops st_uvis25_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(st_uvis25_suspend, st_uvis25_resume)
-};
-EXPORT_SYMBOL_NS(st_uvis25_pm_ops, IIO_UVIS25);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(st_uvis25_pm_ops, st_uvis25_suspend, st_uvis25_resume, IIO_UVIS25);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
 MODULE_DESCRIPTION("STMicroelectronics uvis25 sensor driver");
diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index b06d09af28a3..c982b0b255cf 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(i2c, st_uvis25_i2c_id_table);
 static struct i2c_driver st_uvis25_driver = {
 	.driver = {
 		.name = "st_uvis25_i2c",
-		.pm = &st_uvis25_pm_ops,
+		.pm = pm_sleep_ptr(&st_uvis25_pm_ops),
 		.of_match_table = st_uvis25_i2c_of_match,
 	},
 	.probe = st_uvis25_i2c_probe,
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index 3a4dc6d7180c..86a232320d7d 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(spi, st_uvis25_spi_id_table);
 static struct spi_driver st_uvis25_driver = {
 	.driver = {
 		.name = "st_uvis25_spi",
-		.pm = &st_uvis25_pm_ops,
+		.pm = pm_sleep_ptr(&st_uvis25_pm_ops),
 		.of_match_table = st_uvis25_spi_of_match,
 	},
 	.probe = st_uvis25_spi_probe,
-- 
2.37.1

