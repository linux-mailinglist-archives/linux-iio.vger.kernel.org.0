Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04567553B77
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354288AbiFUUVt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUVs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B21CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A76FB81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD82C341C4;
        Tue, 21 Jun 2022 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842904;
        bh=HbjaOA7TS98EFXbjcc9Y6vkfsmMhGl1nN8KOKQdKBOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vx5p+mo6CVx+YPnayjVrEWI9t1bWxNS3xKxX3vxnNrvUW7VYuLq15QNuxlKLk/3DQ
         CHTNa+3jRUzFyXT0MsJi4mE0VDzmvxIcnq7/sVLFGsrKU2+0mDze/o8CTDpNZmRV1l
         KFDGtxyAZ+FTVJ8rsJonHcxTrlFAMfGDae7J2jlknsLokOx6ETYqnS+ZsArA1YgtwP
         qEizP9zJVGYvG8wYazph+Id6D7jffa991yf1Ea9xDmOlOWcWBXfPG9iNvb7djuqZrO
         LymOeSfSkHJP+akHfhq1hYEeYBEOJXAYLsuwoFrWejg4F4ow661c5EguprT4QEuj8R
         c6D03aa9htjFg==
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
Subject: [PATCH 27/36] iio: adc: imx8qxp: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
Date:   Tue, 21 Jun 2022 21:27:10 +0100
Message-Id: <20220621202719.13644-28-jic23@kernel.org>
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

Switching to these newer macros allows the compiler to remove
the unused functions and struct dev_pm_ops if !CONFIG_PM without
the need to mark anything __maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/iio/adc/imx8qxp-adc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index e8c9a69e10eb..e48446784a0a 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -417,7 +417,7 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static __maybe_unused int imx8qxp_adc_runtime_suspend(struct device *dev)
+static int imx8qxp_adc_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
@@ -431,7 +431,7 @@ static __maybe_unused int imx8qxp_adc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int imx8qxp_adc_runtime_resume(struct device *dev)
+static int imx8qxp_adc_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
@@ -468,10 +468,9 @@ static __maybe_unused int imx8qxp_adc_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops imx8qxp_adc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(imx8qxp_adc_runtime_suspend, imx8qxp_adc_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(imx8qxp_adc_pm_ops,
+				 imx8qxp_adc_runtime_suspend,
+				 imx8qxp_adc_runtime_resume, NULL);
 
 static const struct of_device_id imx8qxp_adc_match[] = {
 	{ .compatible = "nxp,imx8qxp-adc", },
@@ -485,7 +484,7 @@ static struct platform_driver imx8qxp_adc_driver = {
 	.driver		= {
 		.name	= ADC_DRIVER_NAME,
 		.of_match_table = imx8qxp_adc_match,
-		.pm	= &imx8qxp_adc_pm_ops,
+		.pm	= pm_ptr(&imx8qxp_adc_pm_ops),
 	},
 };
 
-- 
2.36.1

