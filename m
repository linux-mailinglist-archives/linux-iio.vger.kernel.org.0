Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E85A600167
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJPQez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJPQex (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C281274B
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 117E2B80D05
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0F7C433C1;
        Sun, 16 Oct 2022 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938087;
        bh=6u4UeBus1dP9+ri3dNYrl6tcaPO4hwKRpQOFXvhKZLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDwHglpz3BmW69k043roAuymZPLF0oYOciYwMLSWSGNqaEZQ1X4PEe+0xtMekGpag
         sauYresRR3tdob9aKbLafblvw4c/KoCJAUbbBK+0A4usbcPG2q7zRYJGIv34pJgZOh
         JMMaXPBIDyIPpQtFeoWr1zGyfLNFaNEV7bO90xLt4t+s6K4PUB61T2DLyOVzeGvAvR
         gCx9RTRkx40mwSMkTSUKNxE0lTW5U0LhegdtSWMaVBiTsELKtA2kkgpwSdADF4NnKs
         moynC1bbOfQUD+Nl8z7kzHwADAgb1ne2ZarBoCr2DakiQn/1pK4X1VTtLL93AKehCp
         cux9EjC0I5faw==
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
Subject: [PATCH 13/14] iio: pressure: ms5611: Use devm_regulator_get_enable()
Date:   Sun, 16 Oct 2022 17:34:08 +0100
Message-Id: <20221016163409.320197-14-jic23@kernel.org>
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
replaces this boilerplate code. Some additional refactoring to drop
now unnecessary unwinding after this change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611.h      |  3 ---
 drivers/iio/pressure/ms5611_core.c | 32 +++++-------------------------
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index cbc9349c342a..816e83befd23 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -13,8 +13,6 @@
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
 
-struct regulator;
-
 #define MS5611_RESET			0x1e
 #define MS5611_READ_ADC			0x00
 #define MS5611_READ_PROM_WORD		0xA0
@@ -56,7 +54,6 @@ struct ms5611_state {
 					  s32 *temp, s32 *pressure);
 
 	struct ms5611_chip_info *chip_info;
-	struct regulator *vdd;
 };
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 717521de66c4..b95ee6034548 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -390,40 +390,21 @@ static const struct iio_info ms5611_info = {
 static int ms5611_init(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct ms5611_state *st = iio_priv(indio_dev);
 
 	/* Enable attached regulator if any. */
-	st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
-	if (IS_ERR(st->vdd))
-		return PTR_ERR(st->vdd);
-
-	ret = regulator_enable(st->vdd);
-	if (ret) {
-		dev_err(indio_dev->dev.parent,
-			"failed to enable Vdd supply: %d\n", ret);
+	ret = devm_regulator_get_enable(indio_dev->dev.parent, "vdd");
+	if (ret)
 		return ret;
-	}
 
 	ret = ms5611_reset(indio_dev);
 	if (ret < 0)
-		goto err_regulator_disable;
+		return ret;
 
 	ret = ms5611_read_prom(indio_dev);
 	if (ret < 0)
-		goto err_regulator_disable;
+		return ret;
 
 	return 0;
-
-err_regulator_disable:
-	regulator_disable(st->vdd);
-	return ret;
-}
-
-static void ms5611_fini(const struct iio_dev *indio_dev)
-{
-	const struct ms5611_state *st = iio_priv(indio_dev);
-
-	regulator_disable(st->vdd);
 }
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
@@ -454,7 +435,7 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 					 ms5611_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(dev, "iio triggered buffer setup failed\n");
-		goto err_fini;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -467,8 +448,6 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
-err_fini:
-	ms5611_fini(indio_dev);
 	return ret;
 }
 EXPORT_SYMBOL_NS(ms5611_probe, IIO_MS5611);
@@ -477,7 +456,6 @@ void ms5611_remove(struct iio_dev *indio_dev)
 {
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	ms5611_fini(indio_dev);
 }
 EXPORT_SYMBOL_NS(ms5611_remove, IIO_MS5611);
 
-- 
2.37.2

