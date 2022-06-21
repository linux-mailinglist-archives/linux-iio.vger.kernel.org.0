Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A312553B5A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352453AbiFUUSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354321AbiFUUSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957AD1CB00
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 336A1617C0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B9DC3411C;
        Tue, 21 Jun 2022 20:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842720;
        bh=tXUjAECGDC97pW6hCsoM/tmUG9QCEtVKk1DKRB1Ft2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lr3Mb7zggQ1zHxZu6DU7+NKq6et8EmRysin5REdkgA2gxFkpJmOw9Rw+aw9Yd/wOH
         4U5MSYnKx8CcfS9vV7Ed3Zc5TxMAH9KCXxs5GcI0fQYFmlj3Rn7bZjummm+LIuymKa
         WVm4o7YjMbDy+KokuTjuQNzyAg/CIJ3kfRPKD/+3d4+wl1iHRqBOkyG4T/7rCOqoU6
         lHJNJANScQpxDTYpZl1PbX8x6XzO0pomKeriEAwHabE5Lr57TMBenD3P2zqBwhlpbI
         c5fuTCtp5ebGMTP/d0MnkHB7BuINc6K3TwBrS8xph2bbi4NWYIBzP6Bby4E+T7VQHC
         JR65gz2drS7Gw==
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
Subject: [PATCH 04/36] iio: adc: imx7d_adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:47 +0100
Message-Id: <20220621202719.13644-5-jic23@kernel.org>
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

In this case we only gain the ability to have the compiler drop the
struct dev_pm_ops because the callbacks are called from paths other
than suspend and resume.  In general the purpose of this new macro
is to allow automated removal of the callbacks as well, but that doesn't
apply here.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/adc/imx7d_adc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 119217af2bde..86caff1d006b 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -540,14 +540,15 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_disable, imx7d_adc_enable);
+static DEFINE_SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_disable,
+				imx7d_adc_enable);
 
 static struct platform_driver imx7d_adc_driver = {
 	.probe		= imx7d_adc_probe,
 	.driver		= {
 		.name	= "imx7d_adc",
 		.of_match_table = imx7d_adc_match,
-		.pm	= &imx7d_adc_pm_ops,
+		.pm	= pm_sleep_ptr(&imx7d_adc_pm_ops),
 	},
 };
 
-- 
2.36.1

