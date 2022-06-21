Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD6A553B75
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354280AbiFUUVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUV3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679A1D31D
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9790F61807
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0934C341C4;
        Tue, 21 Jun 2022 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842888;
        bh=lgmOBhm47bc5MlIZORAvhuPgQPvPdd7e85e0qwGalCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izl5urCQ3AGOaiwhiN0zldPEfKxKC+XUTPCsgW3FdbXtGMcbRF9hHlRWaP/88mhaY
         U/Cold1dvS/8g6Kt3SSMu/4PnaYkTqYfMTBHgfZBXrQY1v7R6QZHJvPve56J7WPHH3
         TWdGsjLdMe/QJ4xkNKmmgo5cNsyuQTsJTVL7UdqFR1FnkR4STjL1DWB7QR0x6lHPe1
         0CYjgqCH+Adx2xxHHrQoHZFpYjgRLVknhxxgMB6oneEfjOjsxmOWtGsAgNfmB7rDcH
         +G4eoYAL5hjdP/VyEBaf6KKAS9O6dpUYe9ai0RN/q1eed6QcdjbXaGcMsPAxumj2QY
         z/FPgKpdFAJeg==
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
Subject: [PATCH 25/36] iio: temperature: ltc2983: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:08 +0100
Message-Id: <20220621202719.13644-26-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621202719.13644-1-jic23@kernel.org>
References: <20220621202719.13644-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 4b7f2b8a9758..b652d2b39bcf 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1534,7 +1534,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-static int __maybe_unused ltc2983_resume(struct device *dev)
+static int ltc2983_resume(struct device *dev)
 {
 	struct ltc2983_data *st = spi_get_drvdata(to_spi_device(dev));
 	int dummy;
@@ -1545,14 +1545,15 @@ static int __maybe_unused ltc2983_resume(struct device *dev)
 	return ltc2983_setup(st, false);
 }
 
-static int __maybe_unused ltc2983_suspend(struct device *dev)
+static int ltc2983_suspend(struct device *dev)
 {
 	struct ltc2983_data *st = spi_get_drvdata(to_spi_device(dev));
 
 	return regmap_write(st->regmap, LTC2983_STATUS_REG, LTC2983_SLEEP);
 }
 
-static SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend, ltc2983_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend,
+				ltc2983_resume);
 
 static const struct spi_device_id ltc2983_id_table[] = {
 	{ "ltc2983" },
@@ -1570,7 +1571,7 @@ static struct spi_driver ltc2983_driver = {
 	.driver = {
 		.name = "ltc2983",
 		.of_match_table = ltc2983_of_match,
-		.pm = &ltc2983_pm_ops,
+		.pm = pm_sleep_ptr(&ltc2983_pm_ops),
 	},
 	.probe = ltc2983_probe,
 	.id_table = ltc2983_id_table,
-- 
2.36.1

