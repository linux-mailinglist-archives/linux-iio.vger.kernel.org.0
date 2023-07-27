Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4376493B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 09:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjG0HrB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjG0Hqo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 03:46:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D70113
        for <linux-iio@vger.kernel.org>; Thu, 27 Jul 2023 00:39:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBN1b4jNTz1GDJv;
        Thu, 27 Jul 2023 15:38:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 15:39:52 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linus.walleij@linaro.org>, <jic23@kernel.org>, <lars@metafoo.de>,
        <haibo.chen@nxp.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>, <heiko@sntech.de>,
        <ktsai@capellamicro.com>, <risca@dalakolonin.se>,
        <christophe.jaillet@wanadoo.fr>, <dan.carpenter@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] iio: adc: Remove redundant dev_err_probe()
Date:   Thu, 27 Jul 2023 15:39:12 +0800
Message-ID: <20230727073912.4178659-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no need to call the dev_err() function directly to print a custom
message when handling an error from either the platform_get_irq() or
platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/iio/adc/ab8500-gpadc.c    | 6 ++----
 drivers/iio/adc/imx7d_adc.c       | 2 +-
 drivers/iio/adc/palmas_gpadc.c    | 6 ++----
 drivers/iio/adc/rockchip_saradc.c | 2 +-
 drivers/iio/light/cm3605.c        | 2 +-
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 4fa2126a354b..3b1bdd0b531d 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1099,14 +1099,12 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 
 	gpadc->irq_sw = platform_get_irq_byname(pdev, "SW_CONV_END");
 	if (gpadc->irq_sw < 0)
-		return dev_err_probe(dev, gpadc->irq_sw,
-				     "failed to get platform sw_conv_end irq\n");
+		return gpadc->irq_sw;
 
 	if (is_ab8500(gpadc->ab8500)) {
 		gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
 		if (gpadc->irq_hw < 0)
-			return dev_err_probe(dev, gpadc->irq_hw,
-					     "failed to get platform hw_conv_end irq\n");
+			return gpadc->irq_hw;
 	} else {
 		gpadc->irq_hw = 0;
 	}
diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 22da81bac97f..828d3fea6d43 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -496,7 +496,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return dev_err_probe(dev, irq, "Failed getting irq\n");
+		return irq;
 
 	info->clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(info->clk))
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 27b2632c1037..a66da674a6ad 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -916,8 +916,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 	adc->irq_auto_0 = platform_get_irq(pdev, 1);
 	if (adc->irq_auto_0 < 0)
-		return dev_err_probe(adc->dev, adc->irq_auto_0,
-				     "get auto0 irq failed\n");
+		return adc->irq_auto_0;
 
 	ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0, NULL,
 					palmas_gpadc_irq_auto, IRQF_ONESHOT,
@@ -929,8 +928,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 	adc->irq_auto_1 = platform_get_irq(pdev, 2);
 	if (adc->irq_auto_1 < 0)
-		return dev_err_probe(adc->dev, adc->irq_auto_1,
-				     "get auto1 irq failed\n");
+		return adc->irq_auto_1;
 
 	ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1, NULL,
 					palmas_gpadc_irq_auto, IRQF_ONESHOT,
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 4b011f7eddec..8270652244c2 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -467,7 +467,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return dev_err_probe(&pdev->dev, irq, "failed to get irq\n");
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
 			       0, dev_name(&pdev->dev), info);
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 0b30db77f78b..e7f0b81b7f5a 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -227,7 +227,7 @@ static int cm3605_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		ret = dev_err_probe(dev, irq, "failed to get irq\n");
+		ret = irq;
 		goto out_disable_aset;
 	}
 
-- 
2.34.1

