Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFD2553B5C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353370AbiFUUS7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353829AbiFUUS6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:18:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BCB1D0D9
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FF05B81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E97FC3411C;
        Tue, 21 Jun 2022 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842735;
        bh=x2PiwguIMrd2VtOAUeefXIFIY9Q6YPvjrYNa4Dg7XKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJ4j7a0NM/Zp4d8FwRabULy50M1xTWMzA2s+tN5/1FwHPxuwrbIEeeR0sw2BGA+zR
         oeDHzL0f5GM1xFx/UrEpBV57OkI83dG2SOkdrJYwaMxEepe2z9by1I2bh96NgXQT+O
         8wP3XevYNzrBvs6hbKjjbR6ywl62+b0Oo0AuOBh7KcFexJZLJt5eSmVTwt5UfWe0b5
         qVij840qom2iW9c/FtUJ83X6nwyNLqC0H6F8+yTo5kcrPCGGUP3Ck9mxHUxQTh7l3Y
         1zEslFpZ0MBvj6MmORSfTf0Q6dTage6x93DZec6ZlzLRIrjNaPWC0bNgqzafbRFGtQ
         cKLlTSdLbThKw==
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
Subject: [PATCH 06/36] iio: adc: mt6577_auxadc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:49 +0100
Message-Id: <20220621202719.13644-7-jic23@kernel.org>
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
Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: Hui Liu <hui.liu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index e78c96a185db..0e134777bdd2 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -215,7 +215,7 @@ static const struct iio_info mt6577_auxadc_info = {
 	.read_raw = &mt6577_auxadc_read_raw,
 };
 
-static int __maybe_unused mt6577_auxadc_resume(struct device *dev)
+static int mt6577_auxadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
@@ -234,7 +234,7 @@ static int __maybe_unused mt6577_auxadc_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mt6577_auxadc_suspend(struct device *dev)
+static int mt6577_auxadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
@@ -330,9 +330,9 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
-			 mt6577_auxadc_suspend,
-			 mt6577_auxadc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
+				mt6577_auxadc_suspend,
+				mt6577_auxadc_resume);
 
 static const struct of_device_id mt6577_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat },
@@ -349,7 +349,7 @@ static struct platform_driver mt6577_auxadc_driver = {
 	.driver = {
 		.name   = "mt6577-auxadc",
 		.of_match_table = mt6577_auxadc_of_match,
-		.pm = &mt6577_auxadc_pm_ops,
+		.pm = pm_sleep_ptr(&mt6577_auxadc_pm_ops),
 	},
 	.probe	= mt6577_auxadc_probe,
 	.remove	= mt6577_auxadc_remove,
-- 
2.36.1

