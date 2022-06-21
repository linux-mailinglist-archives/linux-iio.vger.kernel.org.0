Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C78553B7F
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354306AbiFUUWj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354309AbiFUUWi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8D2613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03BA6181A
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451C1C3411C;
        Tue, 21 Jun 2022 20:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842956;
        bh=W5reXVlBEQcF6oJ9QPZZfZVEedvFlWgvB9x4Shy2aH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2JRbS4Y6GpwMFzJHgIPk4XklqcHzSrasCsIceptLaQyJboa0XMuCl1cv4bKrSnP6
         UXJZoNeQOZkoOLS7qpyyEPtPThnVgv+dwUrYVGV9XM4QuQejSoyqNosh7A03FIC+Ul
         FguZQvjaP8KpGG/eW2i/7bCqsrAO8bzIGem3jPRrUQxS961b7ntn3RiLLWnPG0E3PU
         dVxyEmR46+Psj0bvdLCragLtXFnxRePx1gaRYvGtGelZnpYOS1HBed/T+ckQeR1G9k
         o0mTPULyZJbFRNuKlx0rJ0tEwJWQA57dW+NBAnBkE9G9z5VqF8WYKh4cqMSM/3VGBx
         7nkUWj9NZEafQ==
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
Subject: [PATCH 33/36] iio: light: vcnl4035: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue, 21 Jun 2022 21:27:16 +0100
Message-Id: <20220621202719.13644-34-jic23@kernel.org>
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
Cc: Parthiban Nallathambi <pn@denx.de>
---
 drivers/iio/light/vcnl4035.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 2aaec6bef64c..6a196cf2270b 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -620,7 +620,7 @@ static int vcnl4035_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused vcnl4035_runtime_suspend(struct device *dev)
+static int vcnl4035_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct vcnl4035_data *data = iio_priv(indio_dev);
@@ -632,7 +632,7 @@ static int __maybe_unused vcnl4035_runtime_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused vcnl4035_runtime_resume(struct device *dev)
+static int vcnl4035_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct vcnl4035_data *data = iio_priv(indio_dev);
@@ -649,12 +649,8 @@ static int __maybe_unused vcnl4035_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops vcnl4035_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(vcnl4035_runtime_suspend,
-			   vcnl4035_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(vcnl4035_pm_ops, vcnl4035_runtime_suspend,
+				 vcnl4035_runtime_resume, NULL);
 
 static const struct i2c_device_id vcnl4035_id[] = {
 	{ "vcnl4035", 0 },
@@ -671,7 +667,7 @@ MODULE_DEVICE_TABLE(of, vcnl4035_of_match);
 static struct i2c_driver vcnl4035_driver = {
 	.driver = {
 		.name   = VCNL4035_DRV_NAME,
-		.pm	= &vcnl4035_pm_ops,
+		.pm	= pm_ptr(&vcnl4035_pm_ops),
 		.of_match_table = vcnl4035_of_match,
 	},
 	.probe  = vcnl4035_probe,
-- 
2.36.1

