Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012CB60015C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJPQeN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJPQeM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995032051
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F21DEB80D08
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB29FC433C1;
        Sun, 16 Oct 2022 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938048;
        bh=arxZhQJ7U+QAgYN2rLi/aduvff2rpMRCnpW6s51ODRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHrL192Gp+yTruiTh8MSPPeLlzUvUDlnLn5FSymVF8caFIpwiuN2OHAXmf6NZU2gB
         Bq9LN+tSrvKBrbkqpZ1fAxRqp+sSpl7pnDjsy2yyAk+dFTxuG2ptz0uUVRArkajmwj
         4v2QTJwdcuyJMpeDE20TyYLMTeoG1Gp7Z941vZ5Ws6vb/AFA/ZjgLbiYYuK9glUucc
         b+8bI8hdmm0ZzKvs0Tnbn30Fn+A0GMut1NuhlnW0cQpF+4nh3S4GAoPtzhkj9GNvFw
         2j5M4sky5vDISWivTPImafq6XXPtOeOD7ZkyNats6Or6MPQnmAUJcqPCqZK7GZyowN
         3FfewYVeKJptg==
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
Subject: [PATCH 04/14] iio: accel: kxcjk-1013: Use devm_regulator_bulk_get_enable()
Date:   Sun, 16 Oct 2022 17:33:59 +0100
Message-Id: <20221016163409.320197-5-jic23@kernel.org>
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
---
 drivers/iio/accel/kxcjk-1013.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index adc66b3615c0..e626b6fa8a36 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -241,7 +241,6 @@ enum kxcjk1013_axis {
 };
 
 struct kxcjk1013_data {
-	struct regulator_bulk_data regulators[2];
 	struct i2c_client *client;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
@@ -1425,16 +1424,10 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	return dev_name(dev);
 }
 
-static void kxcjk1013_disable_regulators(void *d)
-{
-	struct kxcjk1013_data *data = d;
-
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
-}
-
 static int kxcjk1013_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
+	static const char * const regulator_names[] = { "vdd", "vddio" };
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;
@@ -1461,22 +1454,12 @@ static int kxcjk1013_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	data->regulators[0].supply = "vdd";
-	data->regulators[1].supply = "vddio";
-	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->regulators),
-				      data->regulators);
+	ret = devm_regulator_bulk_get_enable(&client->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
 	if (ret)
 		return dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
-				    data->regulators);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&client->dev, kxcjk1013_disable_regulators, data);
-	if (ret)
-		return ret;
-
 	/*
 	 * A typical delay of 10ms is required for powering up
 	 * according to the data sheets of supported chips.
-- 
2.37.2

