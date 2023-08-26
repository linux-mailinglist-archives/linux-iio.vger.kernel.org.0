Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A2789370
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 04:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjHZCaG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 22:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjHZC3j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 22:29:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E93A8
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 19:29:37 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RXghy64blz1L9PF;
        Sat, 26 Aug 2023 10:28:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 10:29:35 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <yangyingliang@huawei.com>,
        <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH -next v2 2/3] iio: adc: at91_adc: Use devm_request_irq() helper function
Date:   Sat, 26 Aug 2023 10:29:21 +0800
Message-ID: <20230826022922.3457054-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826022922.3457054-1-ruanjinjie@huawei.com>
References: <20230826022922.3457054-1-ruanjinjie@huawei.com>
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

Use devm_request_irq() to request the interrupt, so we can
avoid having to manually clean this up.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iio/adc/at91_adc.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 318e33ce22fb..2ac1b64f0fb7 100644
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
@@ -1092,7 +1094,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Could not prepare or enable the clock.\n");
 		ret = PTR_ERR(st->clk);
-		goto error_free_irq;
+		return ret;
 	}
 
 	st->adc_clk = devm_clk_get_enabled(&pdev->dev, "adc_op_clk");
@@ -1100,7 +1102,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Could not prepare or enable the ADC clock.\n");
 		ret = PTR_ERR(st->adc_clk);
-		goto error_free_irq;
+		return ret;
 	}
 
 	/*
@@ -1119,8 +1121,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	if (!st->startup_time) {
 		dev_err(&pdev->dev, "No startup time available.\n");
-		ret = -EINVAL;
-		goto error_free_irq;
+		return -EINVAL;
 	}
 	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
 
@@ -1148,7 +1149,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	ret = at91_adc_channel_init(idev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
-		goto error_free_irq;
+		return ret;
 	}
 
 	init_waitqueue_head(&st->wq_data_avail);
@@ -1163,19 +1164,19 @@ static int at91_adc_probe(struct platform_device *pdev)
 		ret = at91_adc_buffer_init(idev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
-			goto error_free_irq;
+			return ret;
 		}
 
 		ret = at91_adc_trigger_init(idev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
 			at91_adc_buffer_remove(idev);
-			goto error_free_irq;
+			return ret;
 		}
 	} else {
 		ret = at91_ts_register(idev, pdev);
 		if (ret)
-			goto error_free_irq;
+			return ret;
 
 		at91_ts_hw_init(idev, adc_clk_khz);
 	}
@@ -1195,8 +1196,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	} else {
 		at91_ts_unregister(st);
 	}
-error_free_irq:
-	free_irq(st->irq, idev);
 	return ret;
 }
 
@@ -1212,7 +1211,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	} else {
 		at91_ts_unregister(st);
 	}
-	free_irq(st->irq, idev);
 
 	return 0;
 }
-- 
2.34.1

