Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B88553B80
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354309AbiFUUWt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354308AbiFUUWs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:22:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786271D31D
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D873B81B29
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B22C341C4;
        Tue, 21 Jun 2022 20:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842965;
        bh=COIyJOlHk9/1x6wIq5rsVEGuj4vS01Dpz0i1T3e9PCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHQ+QkoCxOH0TdQEiMve7X7uMR53rGahg8Q/KODYLkilrlPz7UvnBKWFYEXFNTqem
         yXl7FwiPpvTrhSb586RLaNP2rpZhHzzwyagrMyRSwtJNzhHDSt4oRemtgjDoBcLk4D
         wii93kIQStFbo14GCOZUiN6mC84mKz29ii220MwChL+E31VRv26CMYXPXb8kqG+oy3
         N6wO04PBa4R1fy3aR5JABu7c2QKjSWSos9Yn7Fo7dc3vJsA1DMQh/6roz7aLdMGnow
         s/f3nyOejVciGDTx5WhI6TgMMD4q2fueXtoxNIabhMDlO8//YLNim4QFKHFf9TpqNl
         U4ZLA8DyaI7NQ==
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
Subject: [PATCH 34/36] iio: light: veml6030: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue, 21 Jun 2022 21:27:17 +0100
Message-Id: <20220621202719.13644-35-jic23@kernel.org>
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

Using these new macros allows the compiler to remove the unused dev_pm_ops
structure and related functions if !CONFIG_PM without the need to mark
the functions __maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rishi Gupta <gupt21@gmail.com>
---
 drivers/iio/light/veml6030.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 3c937c55a10d..9a7800cdfee2 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -846,7 +846,7 @@ static int veml6030_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-static int __maybe_unused veml6030_runtime_suspend(struct device *dev)
+static int veml6030_runtime_suspend(struct device *dev)
 {
 	int ret;
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -859,7 +859,7 @@ static int __maybe_unused veml6030_runtime_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused veml6030_runtime_resume(struct device *dev)
+static int veml6030_runtime_resume(struct device *dev)
 {
 	int ret;
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -872,12 +872,8 @@ static int __maybe_unused veml6030_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops veml6030_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(veml6030_runtime_suspend,
-				veml6030_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
+				 veml6030_runtime_resume, NULL);
 
 static const struct of_device_id veml6030_of_match[] = {
 	{ .compatible = "vishay,veml6030" },
@@ -895,7 +891,7 @@ static struct i2c_driver veml6030_driver = {
 	.driver = {
 		.name = "veml6030",
 		.of_match_table = veml6030_of_match,
-		.pm = &veml6030_pm_ops,
+		.pm = pm_ptr(&veml6030_pm_ops),
 	},
 	.probe = veml6030_probe,
 	.id_table = veml6030_id,
-- 
2.36.1

