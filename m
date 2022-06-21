Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9C553B79
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354299AbiFUUVz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUVy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BF2613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C519A6181D
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E86C3411C;
        Tue, 21 Jun 2022 20:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842913;
        bh=eyyNvKFjiVDcdums7UNe2lOc28lwGs3At/OB42tTvyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mex9QNGTPEv7yZSR6xycGIrTeXtjc14WzDIhuSkx0jmw5+ZCLexgvKY8xD+hIq942
         D6H8sOshRlwoHaIGZ/HuOhBQU7uf1bGfIPjzIDLO/x0g5Ht4wjgzrd17ytyq2ZAv2s
         Mi6jplzrx6D13IXlPBgpxDVJtFbmgt0U2EY1sTW93FQQmx2oJ1givQDrcOWz1XafYm
         T+zkwg54o9u4CUAADHWf7Ye3LIKyB0XkOg/ZrVEYSSnzQ3xTObL4UKuTY2czEttjWy
         ZJZFdT1lsGrRZGgWBs+3j6ZaVoi+yW98iuNENZyWXHID34EIk4DDCRdO/yGY54/NOu
         SteKYjpYKa/BA==
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
Subject: [PATCH 28/36] iio: light: gp2ap002: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
Date:   Tue, 21 Jun 2022 21:27:11 +0100
Message-Id: <20220621202719.13644-29-jic23@kernel.org>
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

Switching to these newer macros allows use of pm_ptr() to remove
the unused functions and structure if !CONFIG_PM without the need to
mark anything __maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/gp2ap002.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index c6d1d88d3775..e2707416f9a8 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -635,7 +635,7 @@ static int gp2ap002_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused gp2ap002_runtime_suspend(struct device *dev)
+static int gp2ap002_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
@@ -660,7 +660,7 @@ static int __maybe_unused gp2ap002_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused gp2ap002_runtime_resume(struct device *dev)
+static int gp2ap002_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
@@ -691,12 +691,8 @@ static int __maybe_unused gp2ap002_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops gp2ap002_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(gp2ap002_runtime_suspend,
-			   gp2ap002_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(gp2ap002_dev_pm_ops, gp2ap002_runtime_suspend,
+				 gp2ap002_runtime_resume, NULL);
 
 static const struct i2c_device_id gp2ap002_id_table[] = {
 	{ "gp2ap002", 0 },
@@ -715,7 +711,7 @@ static struct i2c_driver gp2ap002_driver = {
 	.driver = {
 		.name = "gp2ap002",
 		.of_match_table = gp2ap002_of_match,
-		.pm = &gp2ap002_dev_pm_ops,
+		.pm = pm_ptr(&gp2ap002_dev_pm_ops),
 	},
 	.probe = gp2ap002_probe,
 	.remove = gp2ap002_remove,
-- 
2.36.1

