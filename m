Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D93600165
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJPQeo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJPQem (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262EDE0B9
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEF8E60C37
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1CBC433C1;
        Sun, 16 Oct 2022 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938079;
        bh=2iAp6W0XzTezspkkOge9uJ3t4oNrdX0CJb6gd3c0W4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfyF0prpA9Yrdf8PaXCqnMt/VcAj5nBNA20vQI6p07eSJaQQBkvehNqdDp2Yq8LSH
         dMPAtjc1C9FpaStG7BKV351ya6GsZVCLPNRXd9iUhdBLsmKKEEyYj+e2s+HamaL21S
         xcjCtpZUNBKnfLkXqN2UWybe72aNdDS0C+bcv3fbBn9deuK/rfxBquQsApZvQd/FpI
         vqTDyE8Q+uwhueQdmN2pPx/tzwoSjXGQfMrshakZD7GP8mU2EJYLvLfTW9WTHOeWRT
         /11gb37oy9qPR0CUDrr21P8bkz6Elwl2km32KRaFm8X3U3BQl5rCSXdj4xOWXvxxes
         xyqu35fQssdsA==
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
Subject: [PATCH 11/14] iio: light: noa1305: Use devm_regulator_get_enable()
Date:   Sun, 16 Oct 2022 17:34:06 +0100
Message-Id: <20221016163409.320197-12-jic23@kernel.org>
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
Cc: Martyn Welch <martyn.welch@collabora.com>
---
 drivers/iio/light/noa1305.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index ee81fe083e4c..be3536b390fc 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -46,7 +46,6 @@
 struct noa1305_priv {
 	struct i2c_client *client;
 	struct regmap *regmap;
-	struct regulator *vin_reg;
 };
 
 static int noa1305_measure(struct noa1305_priv *priv)
@@ -187,13 +186,6 @@ static const struct regmap_config noa1305_regmap_config = {
 	.writeable_reg = noa1305_writable_reg,
 };
 
-static void noa1305_reg_remove(void *data)
-{
-	struct noa1305_priv *priv = data;
-
-	regulator_disable(priv->vin_reg);
-}
-
 static int noa1305_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -216,23 +208,11 @@ static int noa1305_probe(struct i2c_client *client,
 
 	priv = iio_priv(indio_dev);
 
-	priv->vin_reg = devm_regulator_get(&client->dev, "vin");
-	if (IS_ERR(priv->vin_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(priv->vin_reg),
+	ret = devm_regulator_get_enable(&client->dev, "vin");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
 				     "get regulator vin failed\n");
 
-	ret = regulator_enable(priv->vin_reg);
-	if (ret) {
-		dev_err(&client->dev, "enable regulator vin failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&client->dev, noa1305_reg_remove, priv);
-	if (ret) {
-		dev_err(&client->dev, "addition of devm action failed\n");
-		return ret;
-	}
-
 	i2c_set_clientdata(client, indio_dev);
 	priv->client = client;
 	priv->regmap = regmap;
-- 
2.37.2

