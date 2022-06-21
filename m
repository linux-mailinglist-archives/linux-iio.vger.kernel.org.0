Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17E7553B60
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354029AbiFUUTX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUTW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:19:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760B2613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D20A6B81B24
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D358C341C5;
        Tue, 21 Jun 2022 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842758;
        bh=FTxPvwWZ+PsYz/PMouUMeUBi5brTPtjcJ0J79lS6jtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A359trlrZJ7jwrpvDWNzr3v9Bd+emOvKWCMKG5Awa76gkbKYQMTEOBpcDMEvTB8/z
         2+wyHlqUxbF0jdx8z+lyzZUUBD2Y72t749/8Kwk5V2NxobVpmqbYf8Hw0rs913vh52
         MgaNr/zG+pfwNV/qq5gGhK3AsHDgnbdTDlWj413CaC7f57+bFa4mRFR99UiPSYoovC
         lLQ3o/beBdAUxdvmXtzqnDkyBcNF07oXd4J5RprO0FfWnHScoVGf5Nb4nhu0N+ZPuk
         Pmr2mlv7gNeaNCckvCYaDQ8kEaHengWjGWKV8Ae+xp82uR1T4c7nqLha41mU51HPZn
         iLVVCRZxcPhUw==
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
Subject: [PATCH 09/36] iio: adc: xilinx-ams: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:52 +0100
Message-Id: <20220621202719.13644-10-jic23@kernel.org>
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
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/iio/adc/xilinx-ams.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index a55396c1f8b2..8dad2b232ba7 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1421,7 +1421,7 @@ static int ams_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-static int __maybe_unused ams_suspend(struct device *dev)
+static int ams_suspend(struct device *dev)
 {
 	struct ams *ams = iio_priv(dev_get_drvdata(dev));
 
@@ -1430,20 +1430,20 @@ static int __maybe_unused ams_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ams_resume(struct device *dev)
+static int ams_resume(struct device *dev)
 {
 	struct ams *ams = iio_priv(dev_get_drvdata(dev));
 
 	return clk_prepare_enable(ams->clk);
 }
 
-static SIMPLE_DEV_PM_OPS(ams_pm_ops, ams_suspend, ams_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ams_pm_ops, ams_suspend, ams_resume);
 
 static struct platform_driver ams_driver = {
 	.probe = ams_probe,
 	.driver = {
 		.name = "xilinx-ams",
-		.pm = &ams_pm_ops,
+		.pm = pm_sleep_ptr(&ams_pm_ops),
 		.of_match_table = ams_of_match_table,
 	},
 };
-- 
2.36.1

