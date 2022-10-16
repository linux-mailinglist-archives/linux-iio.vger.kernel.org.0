Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3A600164
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJPQek (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJPQej (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F0EE23
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694E560C36
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB9EC433D7;
        Sun, 16 Oct 2022 16:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938074;
        bh=4/lm4lDp0HdO5M2tR+GA9Sv7GWzmU7o4VJtZ0R6PJ3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pu20zyOve/rXYpL11ceXsbRMT3eQpvg+pQT6vJu0xDB9itM4WFNhudJF0YAu/pZm9
         aQssE65nidsLr7kSDN+940Z6vlnCPK30g6MaVe5uQ0sYV5hHSFoUpY3UUDQw9BdjDF
         h6GDcER4pUh7XOHNt1wrHLRV6h0jpc2tIf4PnWuyqSLEEUcZVhxCR/VHQQ+5SzYCEJ
         44kgJsvPs2Ram28sDjYIihrWsgjPdZ2uT1yPtuht1cQtaw0ja/Bg999Vy8nSSlRe/X
         ASGtDkk4gzLq+zXkASHHGenyQZ1hvXi4e4966oHyWy0hBxCcFqoclZcTKXq53M/ir6
         tstaM+AF3+j3w==
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
Subject: [PATCH 10/14] iio: light: ltr501: Use devm_regulator_bulk_get_enable()
Date:   Sun, 16 Oct 2022 17:34:05 +0100
Message-Id: <20221016163409.320197-11-jic23@kernel.org>
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

This driver only turns the power for some regulators on at probe and off
via a custom devm_add_action_or_reset() callback. The new
devm_regulator_bulk_get_enable() replaces all this boilerplate code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 74a1ccda8b9c..453b845ef265 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -153,7 +153,6 @@ struct ltr501_chip_info {
 
 struct ltr501_data {
 	struct i2c_client *client;
-	struct regulator_bulk_data regulators[2];
 	struct mutex lock_als, lock_ps;
 	const struct ltr501_chip_info *chip_info;
 	u8 als_contr, ps_contr;
@@ -1415,13 +1414,6 @@ static const struct regmap_config ltr501_regmap_config = {
 	.volatile_reg = ltr501_is_volatile_reg,
 };
 
-static void ltr501_disable_regulators(void *d)
-{
-	struct ltr501_data *data = d;
-
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
-}
-
 static int ltr501_powerdown(struct ltr501_data *data)
 {
 	return ltr501_write_contr(data, data->als_contr &
@@ -1443,6 +1435,7 @@ static const char *ltr501_match_acpi_device(struct device *dev, int *chip_idx)
 static int ltr501_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	static const char * const regulator_names[] = { "vdd", "vddio" };
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
@@ -1466,25 +1459,13 @@ static int ltr501_probe(struct i2c_client *client,
 	mutex_init(&data->lock_als);
 	mutex_init(&data->lock_ps);
 
-	data->regulators[0].supply = "vdd";
-	data->regulators[1].supply = "vddio";
-	ret = devm_regulator_bulk_get(&client->dev,
-				      ARRAY_SIZE(data->regulators),
-				      data->regulators);
+	ret = devm_regulator_bulk_get_enable(&client->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
 	if (ret)
 		return dev_err_probe(&client->dev, ret,
 				     "Failed to get regulators\n");
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
-				    data->regulators);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&client->dev,
-				       ltr501_disable_regulators, data);
-	if (ret)
-		return ret;
-
 	data->reg_it = devm_regmap_field_alloc(&client->dev, regmap,
 					       reg_field_it);
 	if (IS_ERR(data->reg_it)) {
-- 
2.37.2

