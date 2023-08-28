Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5BE78A608
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjH1Gqf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 02:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjH1GqF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 02:46:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F7122
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 23:46:03 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RZ1G26PxJzLp1c;
        Mon, 28 Aug 2023 14:42:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 28 Aug
 2023 14:46:00 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <yangyingliang@huawei.com>,
        <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 1/3] iio: adc: at91_adc: Use devm_request_irq() helper function
Date:   Mon, 28 Aug 2023 14:45:44 +0800
Message-ID: <20230828064546.2383857-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828064546.2383857-1-ruanjinjie@huawei.com>
References: <20230828064546.2383857-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_request_irq() to request the interrupt, so we can avoid
having to manually clean this up.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Take the last remove free_irq() and add it to be the first devm managed.
v2:
- Also use devm_request_irq() helper.
---
 drivers/iio/adc/at91_adc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index de6650f9c4b1..771ad5c4a131 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1077,11 +1077,13 @@ static int at91_adc_probe(struct platform_device *pdev)
 	at91_adc_writel(st, AT91_ADC_IDR, 0xFFFFFFFF);
 
 	if (st->caps->has_tsmr)
-		ret = request_irq(st->irq, at91_adc_9x5_interrupt, 0,
-				  pdev->dev.driver->name, idev);
+		ret = devm_request_irq(&pdev->dev, st->irq,
+				       at91_adc_9x5_interrupt, 0,
+				       pdev->dev.driver->name, idev);
 	else
-		ret = request_irq(st->irq, at91_adc_rl_interrupt, 0,
-				  pdev->dev.driver->name, idev);
+		ret = devm_request_irq(&pdev->dev, st->irq,
+				       at91_adc_rl_interrupt, 0,
+				       pdev->dev.driver->name, idev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
 		return ret;
@@ -1090,15 +1092,14 @@ static int at91_adc_probe(struct platform_device *pdev)
 	st->clk = devm_clk_get(&pdev->dev, "adc_clk");
 	if (IS_ERR(st->clk)) {
 		dev_err(&pdev->dev, "Failed to get the clock.\n");
-		ret = PTR_ERR(st->clk);
-		goto error_free_irq;
+		return PTR_ERR(st->clk);
 	}
 
 	ret = clk_prepare_enable(st->clk);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Could not prepare or enable the clock.\n");
-		goto error_free_irq;
+		return ret;
 	}
 
 	st->adc_clk = devm_clk_get(&pdev->dev, "adc_op_clk");
@@ -1211,8 +1212,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(st->adc_clk);
 error_disable_clk:
 	clk_disable_unprepare(st->clk);
-error_free_irq:
-	free_irq(st->irq, idev);
 	return ret;
 }
 
@@ -1230,7 +1229,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	}
 	clk_disable_unprepare(st->adc_clk);
 	clk_disable_unprepare(st->clk);
-	free_irq(st->irq, idev);
 
 	return 0;
 }
-- 
2.34.1

