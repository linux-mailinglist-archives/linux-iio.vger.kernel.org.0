Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4BB60015B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJPQeH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJPQeF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1325C78
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF4B60C36
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE48C433D7;
        Sun, 16 Oct 2022 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938044;
        bh=lS7R61o9XYMdkCFxD8OKcGzpDCTOZvPII+/i+SWFD0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZkMVQTJpQmv4mZOV1ExSpLtTUPKw5cu0WcyToovhCZIHtZmPXlISJSBFBdqPt6Tb
         OYPvoT653DqMeYTPjbWrwPzN/O9zuz0oH3PtG/CJyep208cwRLzvt2lwC67otIafrF
         HQLcLGam0WGKPj1ztUOf3dFiC3CJchZOUB3bEWVdelXx7M+XIr9SPJItu9W0Vi7VYF
         DJz2eSUSAbYIvck4jM6EhF1oVOY2Kit/0KVYXcPTBDW2Z+JaSY0GP6PMnar0vnpueD
         J/zsL7M8gAc6ssJe42RgGBm6gOA8cUcNGXUkqyeEpt1w3536syw0ZTLL0hz32su56M
         l8A2f/FLESfzg==
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
Subject: [PATCH 03/14] iio: accel: fxls8962af: Use devm_regulator_get_enable()
Date:   Sun, 16 Oct 2022 17:33:58 +0100
Message-Id: <20221016163409.320197-4-jic23@kernel.org>
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
devm_add_action_or_reset() callback. The new devm_regulator_get_enable()
replaces this boilerplate code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index bf259db281f5..0d672b1469e8 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -159,7 +159,6 @@ struct fxls8962af_chip_info {
 struct fxls8962af_data {
 	struct regmap *regmap;
 	const struct fxls8962af_chip_info *chip_info;
-	struct regulator *vdd_reg;
 	struct {
 		__le16 channels[3];
 		s64 ts __aligned(8);
@@ -1051,13 +1050,6 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 	return IRQ_NONE;
 }
 
-static void fxls8962af_regulator_disable(void *data_ptr)
-{
-	struct fxls8962af_data *data = data_ptr;
-
-	regulator_disable(data->vdd_reg);
-}
-
 static void fxls8962af_pm_disable(void *dev_ptr)
 {
 	struct device *dev = dev_ptr;
@@ -1171,20 +1163,10 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
-	data->vdd_reg = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(data->vdd_reg))
-		return dev_err_probe(dev, PTR_ERR(data->vdd_reg),
-				     "Failed to get vdd regulator\n");
-
-	ret = regulator_enable(data->vdd_reg);
-	if (ret) {
-		dev_err(dev, "Failed to enable vdd regulator: %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev, fxls8962af_regulator_disable, data);
+	ret = devm_regulator_get_enable(dev, "vdd");
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Failed to get vdd regulator\n");
 
 	ret = regmap_read(data->regmap, FXLS8962AF_WHO_AM_I, &reg);
 	if (ret)
-- 
2.37.2

