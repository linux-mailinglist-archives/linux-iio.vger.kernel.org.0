Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8476553B5B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353327AbiFUUSv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353370AbiFUUSu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:18:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033331CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCF1617C0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27297C341C4;
        Tue, 21 Jun 2022 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842729;
        bh=ZVo5W6uwva7QBmpp/yht+4hpbNEb+/jkE57WTOxF3eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEF6e5+jhzRMrSUynDv7ddCxj6k+BjA87fZQPP/04TFQgvIGOt12foL/E6Ggd3XEe
         ixLudVAMz/OhvnFS/yX0p96UjUp7IZMpXp2MvXzlAZ6uDfHGzLgJnPvXZSLc24MTQ+
         xqRo+OUp1bFt+SD1Ic+ysQjbOIb+Q0icPFjKjnVcWwxZAlgaYlzzCqwOA0b3tlK9wC
         SR960NsSdi0S1flABNsrRDxVGEunSsVHz1zj7CzABPTXVZ/Kw5um04BsgN1GwTKDXx
         7xm8C8r8l9xgYzluyJeR6fFpgLbysigaLKt4RkDv8+PleVhUgFj2ua4KM23l13u14G
         HtUug2gt2DBpw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/36] iio: adc: meson_saradc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:48 +0100
Message-Id: <20220621202719.13644-6-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621202719.13644-1-jic23@kernel.org>
References: <20220621202719.13644-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using these newer macros allows the compiler to remove the unused
structure and functions when !CONFIG_PM_SLEEP + removes the need to
mark pm functions __maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index c18be3c519af..1a68b099d323 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1281,22 +1281,22 @@ static int meson_sar_adc_remove(struct platform_device *pdev)
 	return meson_sar_adc_hw_disable(indio_dev);
 }
 
-static int __maybe_unused meson_sar_adc_suspend(struct device *dev)
+static int meson_sar_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
 	return meson_sar_adc_hw_disable(indio_dev);
 }
 
-static int __maybe_unused meson_sar_adc_resume(struct device *dev)
+static int meson_sar_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
 	return meson_sar_adc_hw_enable(indio_dev);
 }
 
-static SIMPLE_DEV_PM_OPS(meson_sar_adc_pm_ops,
-			 meson_sar_adc_suspend, meson_sar_adc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(meson_sar_adc_pm_ops,
+				meson_sar_adc_suspend, meson_sar_adc_resume);
 
 static struct platform_driver meson_sar_adc_driver = {
 	.probe		= meson_sar_adc_probe,
@@ -1304,7 +1304,7 @@ static struct platform_driver meson_sar_adc_driver = {
 	.driver		= {
 		.name	= "meson-saradc",
 		.of_match_table = meson_sar_adc_of_match,
-		.pm = &meson_sar_adc_pm_ops,
+		.pm = pm_sleep_ptr(&meson_sar_adc_pm_ops),
 	},
 };
 
-- 
2.36.1

