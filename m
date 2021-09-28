Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4756641A4A7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 03:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhI1BiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 21:38:21 -0400
Received: from mx22.baidu.com ([220.181.50.185]:44700 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238428AbhI1BiV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 21:38:21 -0400
Received: from BJHW-Mail-Ex14.internal.baidu.com (unknown [10.127.64.37])
        by Forcepoint Email with ESMTPS id 208B825A85D16B02446B;
        Tue, 28 Sep 2021 09:36:35 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:36:34 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:36:33 +0800
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
Subject: [PATCH v2 2/9] iio: adc: imx7d_adc: Make use of the helper function dev_err_probe()
Date:   Tue, 28 Sep 2021 09:36:13 +0800
Message-ID: <20210928013621.1245-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928013621.1245-1-caihuoqing@baidu.com>
References: <20210928013621.1245-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex24.internal.baidu.com (172.31.51.18) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex14_2021-09-28 09:36:35:088
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
 drivers/iio/adc/imx7d_adc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 4969a5f941e3..f47360cbff3b 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -496,19 +496,13 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 		return irq;
 
 	info->clk = devm_clk_get(dev, "adc");
-	if (IS_ERR(info->clk)) {
-		ret = PTR_ERR(info->clk);
-		dev_err(dev, "Failed getting clock, err = %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->clk))
+		return dev_err_probe(dev, PTR_ERR(info->clk), "Failed getting clock\n");
 
 	info->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(info->vref)) {
-		ret = PTR_ERR(info->vref);
-		dev_err(dev,
-			"Failed getting reference voltage, err = %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->vref))
+		return dev_err_probe(dev, PTR_ERR(info->vref),
+				     "Failed getting reference voltage\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.25.1

