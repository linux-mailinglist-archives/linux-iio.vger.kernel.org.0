Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2613553B5D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353834AbiFUUTG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353829AbiFUUTF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:19:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F41D0DF
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B825EB81B25
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D4FC341C4;
        Tue, 21 Jun 2022 20:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842742;
        bh=2xO87HhT38VDOw5b4Fn6tFwR4OECAouBEKFn/DWq+/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0eOSFKD5Lo23ZE0tTyKINEBltNdOG/VOUyT9kxGI3FHksqRcIPUFfL96+AY+AwY0
         MNqdladPuneIN3ELbhC9aaj0Xfcd/JnryA/yDUx4hfPYJsL30arahAIOukC7Ep+FFM
         +Rww+hXrfEf1vvG49MzCRR10c6D6me2yYbVTCsQUWtn1WYKfhIfpEVZ2DIBhvJB6nm
         9wPzGA/FYVVmrWX5eYb5LXw0mlMePybhR0X9RrBa1E+2rjm5Ylts2vlx2FbC4qHxaW
         7dnXv+rKX1KEV9+6z5M0sJ1ypp2eqqm4SEsuUUQCmS0pH7bPXJa/JT9982hEtgWCfl
         RjWzdPd6U/zkQ==
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
Subject: [PATCH 07/36] iio: adc: stmpe-adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:50 +0100
Message-Id: <20220621202719.13644-8-jic23@kernel.org>
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
mark pm functions __maybe_unused.  This one is a little unusual as
no suspend callback, but the cleanup is still worthwhile (and eventual
aim is to get rid of old macro).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
---
 drivers/iio/adc/stmpe-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 000e5cfecb43..67518e460e05 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -333,7 +333,7 @@ static int stmpe_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-static int __maybe_unused stmpe_adc_resume(struct device *dev)
+static int stmpe_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct stmpe_adc *info = iio_priv(indio_dev);
@@ -343,7 +343,7 @@ static int __maybe_unused stmpe_adc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
 
 static const struct of_device_id stmpe_adc_ids[] = {
 	{ .compatible = "st,stmpe-adc", },
@@ -355,7 +355,7 @@ static struct platform_driver stmpe_adc_driver = {
 	.probe		= stmpe_adc_probe,
 	.driver		= {
 		.name	= "stmpe-adc",
-		.pm	= &stmpe_adc_pm_ops,
+		.pm	= pm_sleep_ptr(&stmpe_adc_pm_ops),
 		.of_match_table = stmpe_adc_ids,
 	},
 };
-- 
2.36.1

