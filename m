Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B310E553B7B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354305AbiFUUWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUWD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829F01CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 016ED617AE
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E24DC341C4;
        Tue, 21 Jun 2022 20:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842921;
        bh=6CfOHPjWtsduNbXiKm+frnZBd7PJXxCS2DRjVgLx6B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjvjZVdmoUHl18B13B0h2pv1U4X9LxtILFkDvP5kyhoe9l4rwBfv+K+XnXTGBpd58
         LT0BibWnkcGcY3TIgb8pJs1B4E3E5mcj+6sQXv+Xd1ZlGcfgoAqXDVHnPgXIl2BWcq
         0eWRQjiHqD/bMD9JpnlawWMOt4cBzWCMdvytohDKKvCfFqXZStwGDg9JSVMt9+4y2D
         TsAzjcN2e/o/YwVRiSjuec8BKiczxzQ1JO5KRORDm3PN5mr4PPzyK745seXaw+Bp2G
         kwjCsDrfzRDz6N1WPV8TJwB5RSArWoVmOs7vdiPTbMFHUzJZrnnuqGpw3N5hz6Pktl
         4zrzLnYMZhRNw==
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
Subject: [PATCH 29/36] iio: light: isl29028: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
Date:   Tue, 21 Jun 2022 21:27:12 +0100
Message-Id: <20220621202719.13644-30-jic23@kernel.org>
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

Using these new macros allows removal of unused pm_ops structure
and functions if !CONFIG_PM without the need to mark the functions
__maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/isl29028.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 720fa83d44e0..4dde9707a52d 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -651,7 +651,7 @@ static int isl29028_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused isl29028_suspend(struct device *dev)
+static int isl29028_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct isl29028_chip *chip = iio_priv(indio_dev);
@@ -666,7 +666,7 @@ static int __maybe_unused isl29028_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused isl29028_resume(struct device *dev)
+static int isl29028_resume(struct device *dev)
 {
 	/**
 	 * The specific component (ALS/IR or proximity) will enable itself as
@@ -676,11 +676,8 @@ static int __maybe_unused isl29028_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops isl29028_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(isl29028_suspend, isl29028_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(isl29028_pm_ops, isl29028_suspend,
+				 isl29028_resume, NULL);
 
 static const struct i2c_device_id isl29028_id[] = {
 	{"isl29028", 0},
@@ -700,7 +697,7 @@ MODULE_DEVICE_TABLE(of, isl29028_of_match);
 static struct i2c_driver isl29028_driver = {
 	.driver  = {
 		.name = "isl29028",
-		.pm = &isl29028_pm_ops,
+		.pm = pm_ptr(&isl29028_pm_ops),
 		.of_match_table = isl29028_of_match,
 	},
 	.probe	 = isl29028_probe,
-- 
2.36.1

