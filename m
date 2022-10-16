Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8560015A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJPQeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJPQeE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360D25C78
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F8F5B80CD9
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58718C433D6;
        Sun, 16 Oct 2022 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938040;
        bh=RLIM8psKLKStspoXH0jhv6lZgJyzIjKIJtvJ4/0yURc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHWN+v3TwbkLOr7xoPNdcyqxjBmreUXErB5opZ+Ef8qUmyz6rSomYCiSqig2fgrgz
         itWjTWdR7+7Nehs1cgtZFaGYlk7wIRbgdzhYTcvc9CDb9QKBCkqM6nbR0akIW9N5RW
         AIZ7lJcKYyLPRcDl73xzca/ZrpXmAtGTXpP/gJ2Xkr3sRBJU8CMA5KS/lpYps6DL2G
         TuijV1x8JiApC8RlONkgJpZ/pgiBWzHwScXsEWL9kf/NoMG25NfObBJVYmDnkQl97n
         LiNG89DRHJjsD5FIu1xT3SgFHJn6QfXtM/TDqB/Lrp3aO+mtDW6ysEcahYQZW2N8nD
         ODgRJY9TnYSfQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/14] iio: accel: bma400: Use devm_regulator_bulk_get_enable()
Date:   Sun, 16 Oct 2022 17:33:57 +0100
Message-Id: <20221016163409.320197-3-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221016163409.320197-1-jic23@kernel.org>
References: <20221016163409.320197-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver only turns the power on at probe and off via a custom
devm_add_action_or_reset() callback. The new
devm_regulator_bulk_get_enable() replaces this boilerplate code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  4 ----
 drivers/iio/accel/bma400_core.c | 29 ++++-------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 36edbaff4f7f..932358b45f17 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -141,10 +141,6 @@
 #define BMA400_SCALE_MIN            9577
 #define BMA400_SCALE_MAX            76617
 
-#define BMA400_NUM_REGULATORS       2
-#define BMA400_VDD_REGULATOR        0
-#define BMA400_VDDIO_REGULATOR      1
-
 extern const struct regmap_config bma400_regmap_config;
 
 int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index e8de88e6cfb9..3ac464c1007c 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -98,7 +98,6 @@ enum bma400_activity {
 struct bma400_data {
 	struct device *dev;
 	struct regmap *regmap;
-	struct regulator_bulk_data regulators[BMA400_NUM_REGULATORS];
 	struct mutex mutex; /* data register lock */
 	struct iio_mount_matrix orientation;
 	enum bma400_power_mode power_mode;
@@ -830,13 +829,6 @@ static void bma400_init_tables(void)
 	}
 }
 
-static void bma400_regulators_disable(void *data_ptr)
-{
-	struct bma400_data *data = data_ptr;
-
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
-}
-
 static void bma400_power_disable(void *data_ptr)
 {
 	struct bma400_data *data = data_ptr;
@@ -866,6 +858,7 @@ static enum iio_modifier bma400_act_to_mod(enum bma400_activity activity)
 
 static int bma400_init(struct bma400_data *data)
 {
+	static const char * const regulator_names[] = { "vdd", "vddio" };
 	unsigned int val;
 	int ret;
 
@@ -881,27 +874,13 @@ static int bma400_init(struct bma400_data *data)
 		return -ENODEV;
 	}
 
-	data->regulators[BMA400_VDD_REGULATOR].supply = "vdd";
-	data->regulators[BMA400_VDDIO_REGULATOR].supply = "vddio";
-	ret = devm_regulator_bulk_get(data->dev,
-				      ARRAY_SIZE(data->regulators),
-				      data->regulators);
+	ret = devm_regulator_bulk_get_enable(data->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Failed to get regulators: %d\n",
 				     ret);
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
-				    data->regulators);
-	if (ret) {
-		dev_err(data->dev, "Failed to enable regulators: %d\n",
-			ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(data->dev, bma400_regulators_disable, data);
-	if (ret)
-		return ret;
-
 	ret = bma400_get_power_mode(data);
 	if (ret) {
 		dev_err(data->dev, "Failed to get the initial power-mode\n");
-- 
2.37.2

