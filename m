Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5599541B233
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 16:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbhI1OiU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 10:38:20 -0400
Received: from mx22.baidu.com ([220.181.50.185]:60638 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241152AbhI1OiM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Sep 2021 10:38:12 -0400
Received: from BJHW-Mail-Ex01.internal.baidu.com (unknown [10.127.64.11])
        by Forcepoint Email with ESMTPS id 76BABABF5FD0DB62B957;
        Tue, 28 Sep 2021 22:20:17 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 22:20:17 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 22:20:16 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
Subject: [PATCH v3 3/9] iio: adc: lpc18xx_adc: Make use of the helper function dev_err_probe()
Date:   Tue, 28 Sep 2021 22:19:49 +0800
Message-ID: <20210928141956.2148-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928141956.2148-1-caihuoqing@baidu.com>
References: <20210928141956.2148-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
Using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: Remove the separate line of PTR_ERR().

 drivers/iio/adc/lpc18xx_adc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index 3566990ae87d..caa7feb4219f 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -137,19 +137,17 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(adc->base);
 
 	adc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(adc->clk)) {
-		dev_err(&pdev->dev, "error getting clock\n");
-		return PTR_ERR(adc->clk);
-	}
+	if (IS_ERR(adc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
+				     "error getting clock\n");
 
 	rate = clk_get_rate(adc->clk);
 	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
 
 	adc->vref = devm_regulator_get(&pdev->dev, "vref");
-	if (IS_ERR(adc->vref)) {
-		dev_err(&pdev->dev, "error getting regulator\n");
-		return PTR_ERR(adc->vref);
-	}
+	if (IS_ERR(adc->vref))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adc->vref),
+				     "error getting regulator\n");
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &lpc18xx_adc_info;
-- 
2.25.1

