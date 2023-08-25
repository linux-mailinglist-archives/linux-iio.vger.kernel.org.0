Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F35788548
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjHYK6W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbjHYK6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 06:58:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461211BD4
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 03:58:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXH1L0wWPzVk5Z;
        Fri, 25 Aug 2023 18:55:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 18:58:08 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Michael.Hennerich@analog.com>, <heiko@sntech.de>,
        <yangyingliang@huawei.com>, <robh@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/4] iio: adc: mt6577_auxadc: Use devm_clk_get_enabled() helper function
Date:   Fri, 25 Aug 2023 18:57:44 +0800
Message-ID: <20230825105746.2999548-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825105746.2999548-1-ruanjinjie@huawei.com>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_clk_get_enabled() helper:
    - calls devm_clk_get()
    - calls clk_prepare_enable() and registers what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 0e134777bdd2..ea42fd7a8c99 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -270,23 +270,16 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 		return PTR_ERR(adc_dev->reg_base);
 	}
 
-	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
+	adc_dev->adc_clk = devm_clk_get_enabled(&pdev->dev, "main");
 	if (IS_ERR(adc_dev->adc_clk)) {
-		dev_err(&pdev->dev, "failed to get auxadc clock\n");
-		return PTR_ERR(adc_dev->adc_clk);
-	}
-
-	ret = clk_prepare_enable(adc_dev->adc_clk);
-	if (ret) {
 		dev_err(&pdev->dev, "failed to enable auxadc clock\n");
-		return ret;
+		return PTR_ERR(adc_dev->adc_clk);
 	}
 
 	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
 	if (!adc_clk_rate) {
-		ret = -EINVAL;
 		dev_err(&pdev->dev, "null clock rate\n");
-		goto err_disable_clk;
+		return -EINVAL;
 	}
 
 	adc_dev->dev_comp = device_get_match_data(&pdev->dev);
@@ -310,8 +303,6 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 err_power_off:
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
 			      0, MT6577_AUXADC_PDN_EN);
-err_disable_clk:
-	clk_disable_unprepare(adc_dev->adc_clk);
 	return ret;
 }
 
@@ -325,8 +316,6 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
 			      0, MT6577_AUXADC_PDN_EN);
 
-	clk_disable_unprepare(adc_dev->adc_clk);
-
 	return 0;
 }
 
-- 
2.34.1

