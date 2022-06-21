Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4926B553B82
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354311AbiFUUXH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354312AbiFUUXG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:23:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214721B5
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A40CAB81B25
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D75FC341C4;
        Tue, 21 Jun 2022 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842982;
        bh=Xa+cNxq53JCyAe2uR5kr94H6h1cVP2ioi28+JW89J14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yin20njpo1FD7EK4jO7Dc2Z64sUkmu9rWgnkMKmf6xc/8bfPh0XC8CQNx7W5VWG+z
         LioIMN9FUMb+ElLBZ4FL6KVfakeZcDq/sn9zGwiE2Q/m0V0FUPqeEB1VDitQcv0tqS
         jxk5fXb35qqcH/ag+dAaLWK2oAm+O3q8yWHSN6zm51oyjSymS9IDahJAxXaJpGYDNR
         gxaZ4Z2HpCXJnNUNEuaK8st67NWAxkc3ht4GiDSp6KC5pgUcWsj8/AF7rveJv5znT8
         N6ska4ma696w6rFqWDFnE6fIn2bZMXryXhLC2SRYs4Kmv1wXl1+QKGvP8ZggDfN/cd
         VrZkmrzg3jFdw==
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
Subject: [PATCH 36/36] iio: magn: yas530: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue, 21 Jun 2022 21:27:19 +0100
Message-Id: <20220621202719.13644-37-jic23@kernel.org>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 9ff7b0e56cf6..e1f88e9bac38 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -965,7 +965,7 @@ static int yas5xx_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static int __maybe_unused yas5xx_runtime_suspend(struct device *dev)
+static int yas5xx_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct yas5xx *yas5xx = iio_priv(indio_dev);
@@ -976,7 +976,7 @@ static int __maybe_unused yas5xx_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
+static int yas5xx_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct yas5xx *yas5xx = iio_priv(indio_dev);
@@ -1011,12 +1011,8 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops yas5xx_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(yas5xx_runtime_suspend,
-			   yas5xx_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
+				 yas5xx_runtime_resume, NULL);
 
 static const struct i2c_device_id yas5xx_id[] = {
 	{"yas530", },
@@ -1038,7 +1034,7 @@ static struct i2c_driver yas5xx_driver = {
 	.driver	 = {
 		.name	= "yas5xx",
 		.of_match_table = yas5xx_of_match,
-		.pm = &yas5xx_dev_pm_ops,
+		.pm = pm_ptr(&yas5xx_dev_pm_ops),
 	},
 	.probe	  = yas5xx_probe,
 	.remove	  = yas5xx_remove,
-- 
2.36.1

