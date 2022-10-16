Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCA600159
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJPQd6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJPQd5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D825C78
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D5EC60BFB
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2233CC433B5;
        Sun, 16 Oct 2022 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938035;
        bh=62CansvX/luuvsQ66Vhij0k0OkU2QnNkhSrQ9XJrpG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaiDBqXpn5yK764lbTcmZTCJGSYEq9OKgnapUUi/nD6OgYAycngSYjAK8hm3T4786
         aFtudiwQfK6mSNO1mlqmzJu/dMoUq+Qz0P8wwZrbARXJTcy9xJLrqW5CWSBG9/ednl
         D2VGmbDmYovD1jupV8UFPFK9GYINqVhRTEEWugeBsAnoOR/TGoUtaMB24zUr5ahqPx
         xpz8a+IKiQ5stlPhb0QjWixqOx7vrzbip6aF2hNVjQHxkOx0UT7Uro1WeNh+ZIIuc6
         ug+37MmZmJ9SaG7130wDbFydbzgsEJxkJ64QPpVPeDZv7cpEJh4fYiAanxCieJt20j
         Z3Y+XmkExqzEw==
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
Subject: [PATCH 01/14] iio: accel: adxl367: Use devm_regulator_bulk_get_enable()
Date:   Sun, 16 Oct 2022 17:33:56 +0100
Message-Id: <20221016163409.320197-2-jic23@kernel.org>
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
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/accel/adxl367.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 47feb375b70b..d0a47ab9d82f 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -160,8 +160,6 @@ struct adxl367_state {
 	struct device			*dev;
 	struct regmap			*regmap;
 
-	struct regulator_bulk_data	regulators[2];
-
 	/*
 	 * Synchronize access to members of driver state, and ensure atomicity
 	 * of consecutive regmap operations.
@@ -1474,16 +1472,10 @@ static int adxl367_setup(struct adxl367_state *st)
 	return adxl367_set_measure_en(st, true);
 }
 
-static void adxl367_disable_regulators(void *data)
-{
-	struct adxl367_state *st = data;
-
-	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
-}
-
 int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 		  void *context, struct regmap *regmap, int irq)
 {
+	static const char * const regulator_names[] = { "vdd", "vddio" };
 	struct iio_dev *indio_dev;
 	struct adxl367_state *st;
 	int ret;
@@ -1507,25 +1499,13 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	indio_dev->info = &adxl367_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	st->regulators[0].supply = "vdd";
-	st->regulators[1].supply = "vddio";
-
-	ret = devm_regulator_bulk_get(st->dev, ARRAY_SIZE(st->regulators),
-				      st->regulators);
+	ret = devm_regulator_bulk_get_enable(st->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
 	if (ret)
 		return dev_err_probe(st->dev, ret,
 				     "Failed to get regulators\n");
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
-	if (ret)
-		return dev_err_probe(st->dev, ret,
-				     "Failed to enable regulators\n");
-
-	ret = devm_add_action_or_reset(st->dev, adxl367_disable_regulators, st);
-	if (ret)
-		return dev_err_probe(st->dev, ret,
-				     "Failed to add regulators disable action\n");
-
 	ret = regmap_write(st->regmap, ADXL367_REG_RESET, ADXL367_RESET_CODE);
 	if (ret)
 		return ret;
-- 
2.37.2

