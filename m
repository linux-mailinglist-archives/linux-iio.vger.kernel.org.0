Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70233600166
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJPQer (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJPQep (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CF100D
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 172F660C34
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A656FC43470;
        Sun, 16 Oct 2022 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938083;
        bh=Kx2hGXRmJmPuSCS5bHuWUcBa+Yhq68S9b6O9/Rwvt+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5dAv6TsS9lUW1uR0X3xap4M9gwjrmNUH6ek61cZhr0ljrP1KluLDuWmZNRQkVHQA
         8CdZKnUxO3UDvylKwcDYzvWZq0YbnUFsIiRahp8WQPRL1c+/7Ch3GIOsCtwwI62LQp
         46JnkTNkO2iEylikG7GQIF1idHt1zBE70h3hP8l2xvkm7teGWxZWvFP4N0iBh5uRbC
         MMSkYMyk3ouf4lr0CNql3cmZCUK6ChXS+Yi/z+lXqavBN1lPLamlUZRRR19Ed4OIZp
         qFZEiQA/LuBF/Sf3llIlf3GDz6xc+ewF8me/JYfQxOR84BfVsD+h9N9IV6l+umtRMd
         qinUWDaNxTX0A==
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
Subject: [PATCH 12/14] iio: proximity: sx_common: Use devm_regulator_bulk_get_enable()
Date:   Sun, 16 Oct 2022 17:34:07 +0100
Message-Id: <20221016163409.320197-13-jic23@kernel.org>
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
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx_common.c | 23 +++--------------------
 drivers/iio/proximity/sx_common.h |  2 --
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index d70a6b4f0bf8..eba9256730ec 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -424,13 +424,6 @@ static const struct iio_buffer_setup_ops sx_common_buffer_setup_ops = {
 	.postdisable = sx_common_buffer_postdisable,
 };
 
-static void sx_common_regulator_disable(void *_data)
-{
-	struct sx_common_data *data = _data;
-
-	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
-}
-
 #define SX_COMMON_SOFT_RESET				0xde
 
 static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
@@ -474,6 +467,7 @@ int sx_common_probe(struct i2c_client *client,
 		    const struct sx_common_chip_info *chip_info,
 		    const struct regmap_config *regmap_config)
 {
+	static const char * const regulator_names[] = { "vdd", "svdd" };
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct sx_common_data *data;
@@ -487,8 +481,6 @@ int sx_common_probe(struct i2c_client *client,
 
 	data->chip_info = chip_info;
 	data->client = client;
-	data->supplies[0].supply = "vdd";
-	data->supplies[1].supply = "svdd";
 	mutex_init(&data->mutex);
 	init_completion(&data->completion);
 
@@ -497,23 +489,14 @@ int sx_common_probe(struct i2c_client *client,
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
 				     "Could init register map\n");
 
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
-				      data->supplies);
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to get regulators\n");
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
-	if (ret)
-		return dev_err_probe(dev, ret, "Unable to enable regulators\n");
-
 	/* Must wait for Tpor time after initial power up */
 	usleep_range(1000, 1100);
 
-	ret = devm_add_action_or_reset(dev, sx_common_regulator_disable, data);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Unable to register regulators deleter\n");
-
 	ret = data->chip_info->ops.check_whoami(dev, indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "error reading WHOAMI\n");
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index 5d3edeb75f4e..49d4517103b0 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -102,7 +102,6 @@ struct sx_common_chip_info {
  * @trig:		IIO trigger object.
  * @regmap:		Register map.
  * @num_default_regs:	Number of default registers to set at init.
- * @supplies:		Power supplies object.
  * @chan_prox_stat:	Last reading of the proximity status for each channel.
  *			We only send an event to user space when this changes.
  * @trigger_enabled:	True when the device trigger is enabled.
@@ -120,7 +119,6 @@ struct sx_common_data {
 	struct iio_trigger *trig;
 	struct regmap *regmap;
 
-	struct regulator_bulk_data supplies[2];
 	unsigned long chan_prox_stat;
 	bool trigger_enabled;
 
-- 
2.37.2

