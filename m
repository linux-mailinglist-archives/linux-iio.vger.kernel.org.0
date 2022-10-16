Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B42600161
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJPQeb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJPQe2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6626468
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB17960C33
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FAAC433D7;
        Sun, 16 Oct 2022 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938066;
        bh=4uJ0YL/V46uW99W4AL5v3p40draQWFwFelHqlCMRDLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5NK58Pkcn499ZuD51hsy8JQ62TOh8JDGq8BkDT0f/tefb/WqfF8CEyEBjSwLWqPd
         4jct5fWhzolO7SPyOIIaYYlRAOYRWovHl2mLRPH/YgQkhEbzgcN3WtlYZNx0SR+Xvp
         SssK9Jiw783SJDEefvgcQtxmlScAIrkZmGaaUeLDhmF3bOMtl4OudvL05h13HiiX0i
         W8fJMLCgNjDEJoMSqVq9PhfYDsm2hARBDh+Yzd+wU2ViMrt+DcMlojY5iYrZ93MOuP
         Pe5rCQbP7z4gnHvbK6/+w7/YLycdPce3wkoAvEWoz9KRoLjv8QFOV0DW7FjoY8JC0I
         UXRsdHwLRyjjA==
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
Subject: [PATCH 08/14] iio: frequency: ad9523: Use devm_regulator_get_enable()
Date:   Sun, 16 Oct 2022 17:34:03 +0100
Message-Id: <20221016163409.320197-9-jic23@kernel.org>
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

Note that in event of an error on the devm_regulator_get() the driver
would have continued without enabling the regulator which is probably
not a good idea.  So here we handle any error as a reason to fail the
probe(). In theory this may expose breakage on a platform that was
previously papered over but it seems low risk.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/frequency/ad9523.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 97662ca1ca96..b391c6e27ab0 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -265,7 +265,6 @@ enum {
 
 struct ad9523_state {
 	struct spi_device		*spi;
-	struct regulator		*reg;
 	struct ad9523_platform_data	*pdata;
 	struct iio_chan_spec		ad9523_channels[AD9523_NUM_CHAN];
 	struct gpio_desc		*pwrdown_gpio;
@@ -969,13 +968,6 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static void ad9523_reg_disable(void *data)
-{
-	struct regulator *reg = data;
-
-	regulator_disable(reg);
-}
-
 static int ad9523_probe(struct spi_device *spi)
 {
 	struct ad9523_platform_data *pdata = spi->dev.platform_data;
@@ -996,17 +988,9 @@ static int ad9523_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	st->reg = devm_regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad9523_reg_disable,
-					       st->reg);
-		if (ret)
-			return ret;
-	}
+	ret = devm_regulator_get_enable(&spi->dev, "vcc");
+	if (ret)
+		return ret;
 
 	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
 		GPIOD_OUT_HIGH);
-- 
2.37.2

