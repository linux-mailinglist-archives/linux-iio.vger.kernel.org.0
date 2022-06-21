Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87F8553B6B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354017AbiFUUU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354263AbiFUUUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B721CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00394617F4
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3DEC341C4;
        Tue, 21 Jun 2022 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842823;
        bh=a9COZF0+ZiVAqmNEfLj92B/D6i34BlC7qy9zHSzB3u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcNT3Qi17sSpwuMTzvE4MqvUGpN8Ic8c4BMEGzJWF8Q9/PPL4KG7mF5UFI81e4qbA
         A+R8QOJuwJ3eKUkVBUO1VvIKl93OtlPcf7Imn7GLGNWGQ1wlpJEHMHfhKHQ/729jSw
         fDAWy56RzkukAiM1p3wLyEeLCmQQDXSgPIwrMlehin6FVJkkcPkukV9VEgTtV/4aBu
         6hy93Vsnj5LusfBTRLTqVB6R0oCSWHqr2hf0TYXro+S/yUTd8ui1ePJ3dREE/4LgBv
         CmEA40ZleC2AP1l8Cvvz5J1nazUUihLlh7A/0qchu6gBQ4o00y6kl+3icf+3y9+Adp
         7L9moPfDE0ekQ==
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
Subject: [PATCH 17/36] iio: health: afe4403: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:00 +0100
Message-Id: <20220621202719.13644-18-jic23@kernel.org>
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
---
 drivers/iio/health/afe4403.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 856ec901b091..3bb4028c5d74 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -408,7 +408,7 @@ static const struct of_device_id afe4403_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, afe4403_of_match);
 
-static int __maybe_unused afe4403_suspend(struct device *dev)
+static int afe4403_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
 	struct afe4403_data *afe = iio_priv(indio_dev);
@@ -429,7 +429,7 @@ static int __maybe_unused afe4403_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused afe4403_resume(struct device *dev)
+static int afe4403_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
 	struct afe4403_data *afe = iio_priv(indio_dev);
@@ -449,7 +449,8 @@ static int __maybe_unused afe4403_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(afe4403_pm_ops, afe4403_suspend, afe4403_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(afe4403_pm_ops, afe4403_suspend,
+				afe4403_resume);
 
 static int afe4403_probe(struct spi_device *spi)
 {
@@ -598,7 +599,7 @@ static struct spi_driver afe4403_spi_driver = {
 	.driver = {
 		.name = AFE4403_DRIVER_NAME,
 		.of_match_table = afe4403_of_match,
-		.pm = &afe4403_pm_ops,
+		.pm = pm_sleep_ptr(&afe4403_pm_ops),
 	},
 	.probe = afe4403_probe,
 	.remove = afe4403_remove,
-- 
2.36.1

