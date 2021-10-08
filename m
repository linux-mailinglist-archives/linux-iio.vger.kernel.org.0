Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51904266DF
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbhJHJbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 05:31:12 -0400
Received: from mx22.baidu.com ([220.181.50.185]:37912 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238620AbhJHJbI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 05:31:08 -0400
Received: from BJHW-Mail-Ex15.internal.baidu.com (unknown [10.127.64.38])
        by Forcepoint Email with ESMTPS id A04073DEFAA9E05DD8AE;
        Fri,  8 Oct 2021 17:29:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:29:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:29:10 +0800
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
Subject: [PATCH v4 5/9] iio: adc: max1241: Make use of the helper function dev_err_probe()
Date:   Fri, 8 Oct 2021 17:28:53 +0800
Message-ID: <20211008092858.495-5-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008092858.495-1-caihuoqing@baidu.com>
References: <20211008092858.495-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2021-10-08 17:29:11:619
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
v3->v4: Add a dev_err_probe() message to the devm_gpiod_get_optional().

 drivers/iio/adc/max1241.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
index b60f8448f21a..a5afd84af58b 100644
--- a/drivers/iio/adc/max1241.c
+++ b/drivers/iio/adc/max1241.c
@@ -148,10 +148,9 @@ static int max1241_probe(struct spi_device *spi)
 	mutex_init(&adc->lock);
 
 	adc->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(adc->vdd)) {
-		dev_err(dev, "failed to get vdd regulator\n");
-		return PTR_ERR(adc->vdd);
-	}
+	if (IS_ERR(adc->vdd))
+		return dev_err_probe(dev, PTR_ERR(adc->vdd),
+				     "failed to get vdd regulator\n");
 
 	ret = regulator_enable(adc->vdd);
 	if (ret)
@@ -164,10 +163,9 @@ static int max1241_probe(struct spi_device *spi)
 	}
 
 	adc->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(adc->vref)) {
-		dev_err(dev, "failed to get vref regulator\n");
-		return PTR_ERR(adc->vref);
-	}
+	if (IS_ERR(adc->vref))
+		return dev_err_probe(dev, PTR_ERR(adc->vref),
+				     "failed to get vref regulator\n");
 
 	ret = regulator_enable(adc->vref);
 	if (ret)
@@ -182,7 +180,8 @@ static int max1241_probe(struct spi_device *spi)
 	adc->shutdown = devm_gpiod_get_optional(dev, "shutdown",
 						GPIOD_OUT_HIGH);
 	if (IS_ERR(adc->shutdown))
-		return PTR_ERR(adc->shutdown);
+		return dev_err_probe(dev, PTR_ERR(adc->shutdown),
+				     "cannot get shutdown gpio\n");
 
 	if (adc->shutdown)
 		dev_dbg(dev, "shutdown pin passed, low-power mode enabled");
-- 
2.25.1

