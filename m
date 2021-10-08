Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA764266E0
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 11:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhJHJbT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 05:31:19 -0400
Received: from mx24.baidu.com ([111.206.215.185]:38080 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239083AbhJHJbL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 05:31:11 -0400
Received: from BJHW-Mail-Ex12.internal.baidu.com (unknown [10.127.64.35])
        by Forcepoint Email with ESMTPS id C926CF9DDA78854F7980;
        Fri,  8 Oct 2021 17:29:14 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:29:14 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:29:13 +0800
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
Subject: [PATCH v4 6/9] iio: adc: meson_saradc: Make use of the helper function dev_err_probe()
Date:   Fri, 8 Oct 2021 17:28:54 +0800
Message-ID: <20211008092858.495-6-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008092858.495-1-caihuoqing@baidu.com>
References: <20211008092858.495-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex12_2021-10-08 17:29:14:824
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

 drivers/iio/adc/meson_saradc.c | 39 +++++++++++++++-------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 705d5e11a54b..62cc6fb0ef85 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1230,35 +1230,31 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	priv->clkin = devm_clk_get(&pdev->dev, "clkin");
-	if (IS_ERR(priv->clkin)) {
-		dev_err(&pdev->dev, "failed to get clkin\n");
-		return PTR_ERR(priv->clkin);
-	}
+	if (IS_ERR(priv->clkin))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clkin),
+				     "failed to get clkin\n");
 
 	priv->core_clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(priv->core_clk)) {
-		dev_err(&pdev->dev, "failed to get core clk\n");
-		return PTR_ERR(priv->core_clk);
-	}
+	if (IS_ERR(priv->core_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->core_clk),
+				     "failed to get core clk\n");
 
 	priv->adc_clk = devm_clk_get(&pdev->dev, "adc_clk");
 	if (IS_ERR(priv->adc_clk)) {
-		if (PTR_ERR(priv->adc_clk) == -ENOENT) {
+		if (PTR_ERR(priv->adc_clk) == -ENOENT)
 			priv->adc_clk = NULL;
-		} else {
-			dev_err(&pdev->dev, "failed to get adc clk\n");
-			return PTR_ERR(priv->adc_clk);
-		}
+		else
+			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_clk),
+					     "failed to get adc clk\n");
 	}
 
 	priv->adc_sel_clk = devm_clk_get(&pdev->dev, "adc_sel");
 	if (IS_ERR(priv->adc_sel_clk)) {
-		if (PTR_ERR(priv->adc_sel_clk) == -ENOENT) {
+		if (PTR_ERR(priv->adc_sel_clk) == -ENOENT)
 			priv->adc_sel_clk = NULL;
-		} else {
-			dev_err(&pdev->dev, "failed to get adc_sel clk\n");
-			return PTR_ERR(priv->adc_sel_clk);
-		}
+		else
+			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_sel_clk),
+					     "failed to get adc_sel clk\n");
 	}
 
 	/* on pre-GXBB SoCs the SAR ADC itself provides the ADC clock: */
@@ -1269,10 +1265,9 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	}
 
 	priv->vref = devm_regulator_get(&pdev->dev, "vref");
-	if (IS_ERR(priv->vref)) {
-		dev_err(&pdev->dev, "failed to get vref regulator\n");
-		return PTR_ERR(priv->vref);
-	}
+	if (IS_ERR(priv->vref))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->vref),
+				     "failed to get vref regulator\n");
 
 	priv->calibscale = MILLION;
 
-- 
2.25.1

