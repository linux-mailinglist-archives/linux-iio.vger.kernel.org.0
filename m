Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2464266D2
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhJHJa4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 05:30:56 -0400
Received: from mx22.baidu.com ([220.181.50.185]:37166 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235969AbhJHJa4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 05:30:56 -0400
Received: from BJHW-Mail-Ex11.internal.baidu.com (unknown [10.127.64.34])
        by Forcepoint Email with ESMTPS id 01DB11B09D55DF7346B2;
        Fri,  8 Oct 2021 17:28:59 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:28:58 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:28:57 +0800
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
Subject: [PATCH v4 1/9] iio: adc: ab8500-gpadc: Make use of the helper function dev_err_probe()
Date:   Fri, 8 Oct 2021 17:28:49 +0800
Message-ID: <20211008092858.495-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
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
v2: Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

v2->v3: Handle platform_get_irq_byname() that returns -EPROBE_DEFER.

 drivers/iio/adc/ab8500-gpadc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 7b5212ba5501..4c46a201d4ef 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1103,17 +1103,15 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 		return ret;
 
 	gpadc->irq_sw = platform_get_irq_byname(pdev, "SW_CONV_END");
-	if (gpadc->irq_sw < 0) {
-		dev_err(dev, "failed to get platform sw_conv_end irq\n");
-		return gpadc->irq_sw;
-	}
+	if (gpadc->irq_sw < 0)
+		return dev_err_probe(dev, gpadc->irq_sw,
+				     "failed to get platform sw_conv_end irq\n");
 
 	if (is_ab8500(gpadc->ab8500)) {
 		gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
-		if (gpadc->irq_hw < 0) {
-			dev_err(dev, "failed to get platform hw_conv_end irq\n");
-			return gpadc->irq_hw;
-		}
+		if (gpadc->irq_hw < 0)
+			return dev_err_probe(dev, gpadc->irq_hw,
+					     "failed to get platform hw_conv_end irq\n");
 	} else {
 		gpadc->irq_hw = 0;
 	}
@@ -1146,11 +1144,9 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 
 	/* The VTVout LDO used to power the AB8500 GPADC */
 	gpadc->vddadc = devm_regulator_get(dev, "vddadc");
-	if (IS_ERR(gpadc->vddadc)) {
-		ret = PTR_ERR(gpadc->vddadc);
-		dev_err(dev, "failed to get vddadc\n");
-		return ret;
-	}
+	if (IS_ERR(gpadc->vddadc))
+		return dev_err_probe(dev, PTR_ERR(gpadc->vddadc),
+				     "failed to get vddadc\n");
 
 	ret = regulator_enable(gpadc->vddadc);
 	if (ret) {
-- 
2.25.1

