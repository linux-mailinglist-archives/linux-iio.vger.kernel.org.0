Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39943553B6D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354263AbiFUUUm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354268AbiFUUUm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA8828991
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F6C6181B
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE41C341C4;
        Tue, 21 Jun 2022 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842840;
        bh=STw9T+eCYKZGLNbBcQn9J3EcCT6QJXT4yOFXLuEzYTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGIHbP7u/tR/c9n8sE+Pj9hWzhTcrawEaXbREaVJUyTLQrNAvK2+Ea+qF3g0qtow/
         0sLBjqflU0dE/m8xFK+YtaKWoKmQsldoAXVDvW/f8q63OqkNyyCSNII7wxpXzSgk9Y
         rAtzI2qJU/lNUIdL7vo84YLBGeXS+NJqUA9dzb74O8K/dJKMvxCAmc7VgcgrYQmzra
         QBkdKAr1iniJpqgqXsaXJN6va9WlAFRbmWEiPNVm05L/IqV2cr4M9Vmkfw5iLhDlxv
         O7rCCYXMj0SY28B3SMfe6Dix/t78l5fgxiZuOlgTCJ4jbBvGv+nZaSQ+DSwaRxBPvX
         b/Zc2l0SBPsJw==
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
Subject: [PATCH 19/36] iio: light: al3010: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:02 +0100
Message-Id: <20220621202719.13644-20-jic23@kernel.org>
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
Cc: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index b4e9924094cd..ce5363845b22 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -200,17 +200,17 @@ static int al3010_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-static int __maybe_unused al3010_suspend(struct device *dev)
+static int al3010_suspend(struct device *dev)
 {
 	return al3010_set_pwr(to_i2c_client(dev), false);
 }
 
-static int __maybe_unused al3010_resume(struct device *dev)
+static int al3010_resume(struct device *dev)
 {
 	return al3010_set_pwr(to_i2c_client(dev), true);
 }
 
-static SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
 
 static const struct i2c_device_id al3010_id[] = {
 	{"al3010", },
@@ -228,7 +228,7 @@ static struct i2c_driver al3010_driver = {
 	.driver = {
 		.name = AL3010_DRV_NAME,
 		.of_match_table = al3010_of_match,
-		.pm = &al3010_pm_ops,
+		.pm = pm_sleep_ptr(&al3010_pm_ops),
 	},
 	.probe		= al3010_probe,
 	.id_table	= al3010_id,
-- 
2.36.1

