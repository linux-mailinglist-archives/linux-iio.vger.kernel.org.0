Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7760015E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJPQeX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJPQeW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF0E1CA
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9940FB80B67
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D39C433C1;
        Sun, 16 Oct 2022 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938057;
        bh=BOW5npGww4fYiqrpzo8YROnvXAF4zbDU3TFJ+OyDCh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ma+viySk7QqVo6PCF0/LYpa0gm2DAr0fdXfQ3kzNBPHQwhJ571ZYJ9wdZeu4/R6Lc
         akRmo/YS8nq4pUQJBQ8rNrl/ocnglZVCxS6zxM4vt58ZWgJEomHbj8Al7JhHssT1k7
         FKP1U/aZgXTw19R6cz4Az0jtQ59KEdWUx9jjQgnPMNwpvw3OV8z8mscLXq1SK6DJIC
         42r9aB4yF2Zw6o/CuW6mqYWKhHJmL8sIEh2x9zbI3zSB13FutAbAl+gncYzcSGfTWE
         7pjAUDszFmxtsIb2+mPEq/5ztjXjK1EMc8XZzZkYDgexGGRoi6CAbtGiDPGSrJahMy
         Cxq8l3jqsXUEQ==
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
Subject: [PATCH 06/14] iio: cdc: ad7150: Use devm_regulator_get_enable()
Date:   Sun, 16 Oct 2022 17:34:01 +0100
Message-Id: <20221016163409.320197-7-jic23@kernel.org>
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
---
 drivers/iio/cdc/ad7150.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index ebe112b4618b..1113745890ca 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -536,19 +536,11 @@ static const struct iio_info ad7150_info_no_irq = {
 	.read_raw = &ad7150_read_raw,
 };
 
-static void ad7150_reg_disable(void *data)
-{
-	struct regulator *reg = data;
-
-	regulator_disable(reg);
-}
-
 static int ad7150_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
@@ -563,15 +555,7 @@ static int ad7150_probe(struct i2c_client *client,
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	reg = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(reg))
-		return PTR_ERR(reg);
-
-	ret = regulator_enable(reg);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&client->dev, ad7150_reg_disable, reg);
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
 	if (ret)
 		return ret;
 
-- 
2.37.2

