Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777FB7893B8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 05:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjHZDyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 23:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjHZDyX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 23:54:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5D5269E
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 20:54:20 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXjXv0kBczJrp1;
        Sat, 26 Aug 2023 11:51:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 11:54:18 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/2] iio: adc: mt6577_auxadc: Simplify with dev_err_probe()
Date:   Sat, 26 Aug 2023 11:54:01 +0800
Message-ID: <20230826035402.3512033-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826035402.3512033-1-ruanjinjie@huawei.com>
References: <20230826035402.3512033-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error
is printed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/mt6577_auxadc.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index ea42fd7a8c99..935cf560e238 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -265,22 +265,18 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(mt6577_auxadc_iio_channels);
 
 	adc_dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(adc_dev->reg_base)) {
-		dev_err(&pdev->dev, "failed to get auxadc base address\n");
-		return PTR_ERR(adc_dev->reg_base);
-	}
+	if (IS_ERR(adc_dev->reg_base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adc_dev->reg_base),
+				     "failed to get auxadc base address\n");
 
 	adc_dev->adc_clk = devm_clk_get_enabled(&pdev->dev, "main");
-	if (IS_ERR(adc_dev->adc_clk)) {
-		dev_err(&pdev->dev, "failed to enable auxadc clock\n");
-		return PTR_ERR(adc_dev->adc_clk);
-	}
+	if (IS_ERR(adc_dev->adc_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adc_dev->adc_clk),
+				     "failed to enable auxadc clock\n");
 
 	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
-	if (!adc_clk_rate) {
-		dev_err(&pdev->dev, "null clock rate\n");
-		return -EINVAL;
-	}
+	if (!adc_clk_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL, "null clock rate\n");
 
 	adc_dev->dev_comp = device_get_match_data(&pdev->dev);
 
-- 
2.34.1

