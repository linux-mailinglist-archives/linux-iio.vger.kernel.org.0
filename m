Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D317553B59
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiFUUSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354263AbiFUUSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853C1D0DF
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9F33617EF
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD84C341C4;
        Tue, 21 Jun 2022 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842712;
        bh=baUC6gbnbR2suKxte6Pu4Y0VG5xjBX8ODlhKdHq/I6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paf2iyOSurYL4AeR0dTKjU2ypcnI1On36A5OFSMeCnpcMQ80kko7xjqgs0ounzaJV
         ZL3D9Q/5DT4I4R5kqSkB3UWRd/a0z0ltFmV+MNnMyT8OMB2whW+OpDnmdfgsHNj/3F
         myRqXlCboogA0gGxXtlw2xHZbkvLoUFcJ0OxnBzlfUjsoiA33PDLWJ2WAhg8UCrAbo
         n5P/gHqObqM4hEgzj+nWJeBlANPlxaPIIm28RWG+88ejCnBMQbtAwfx4V+1FifZ3Px
         pXmJI9uamhndRNbogv0NnMqNZR3F91qExnvNnEn+Q7hR2050e/l6CDaSCoIUApyZZL
         m7k1nFOWzC8SQ==
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
Subject: [PATCH 03/36] iio: adc: at91-sam5d2:  Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:46 +0100
Message-Id: <20220621202719.13644-4-jic23@kernel.org>
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
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index fe3131c9593c..279430c1d88c 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2103,7 +2103,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static __maybe_unused int at91_adc_suspend(struct device *dev)
+static int at91_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
@@ -2123,7 +2123,7 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static __maybe_unused int at91_adc_resume(struct device *dev)
+static int at91_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
@@ -2169,7 +2169,8 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend,
+				at91_adc_resume);
 
 static const struct of_device_id at91_adc_dt_match[] = {
 	{
@@ -2190,7 +2191,7 @@ static struct platform_driver at91_adc_driver = {
 	.driver = {
 		.name = "at91-sama5d2_adc",
 		.of_match_table = at91_adc_dt_match,
-		.pm = &at91_adc_pm_ops,
+		.pm = pm_sleep_ptr(&at91_adc_pm_ops),
 	},
 };
 module_platform_driver(at91_adc_driver)
-- 
2.36.1

