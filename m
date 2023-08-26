Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8B789372
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 04:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjHZCaI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 22:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjHZC3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 22:29:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D020A8
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 19:29:36 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXgg65BcqzJrnc;
        Sat, 26 Aug 2023 10:26:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 10:29:34 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <yangyingliang@huawei.com>,
        <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH -next v2 1/3] iio: adc: at91_adc: Use devm_clk_get_enabled() helper function
Date:   Sat, 26 Aug 2023 10:29:20 +0800
Message-ID: <20230826022922.3457054-2-ruanjinjie@huawei.com>
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

The devm_clk_get_enabled() helper:
    - calls devm_clk_get()
    - calls clk_prepare_enable() and registers what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iio/adc/at91_adc.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index de6650f9c4b1..318e33ce22fb 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1087,32 +1087,20 @@ static int at91_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	st->clk = devm_clk_get(&pdev->dev, "adc_clk");
+	st->clk = devm_clk_get_enabled(&pdev->dev, "adc_clk");
 	if (IS_ERR(st->clk)) {
-		dev_err(&pdev->dev, "Failed to get the clock.\n");
-		ret = PTR_ERR(st->clk);
-		goto error_free_irq;
-	}
-
-	ret = clk_prepare_enable(st->clk);
-	if (ret) {
 		dev_err(&pdev->dev,
 			"Could not prepare or enable the clock.\n");
+		ret = PTR_ERR(st->clk);
 		goto error_free_irq;
 	}
 
-	st->adc_clk = devm_clk_get(&pdev->dev, "adc_op_clk");
+	st->adc_clk = devm_clk_get_enabled(&pdev->dev, "adc_op_clk");
 	if (IS_ERR(st->adc_clk)) {
-		dev_err(&pdev->dev, "Failed to get the ADC clock.\n");
-		ret = PTR_ERR(st->adc_clk);
-		goto error_disable_clk;
-	}
-
-	ret = clk_prepare_enable(st->adc_clk);
-	if (ret) {
 		dev_err(&pdev->dev,
 			"Could not prepare or enable the ADC clock.\n");
-		goto error_disable_clk;
+		ret = PTR_ERR(st->adc_clk);
+		goto error_free_irq;
 	}
 
 	/*
@@ -1132,7 +1120,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (!st->startup_time) {
 		dev_err(&pdev->dev, "No startup time available.\n");
 		ret = -EINVAL;
-		goto error_disable_adc_clk;
+		goto error_free_irq;
 	}
 	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
 
@@ -1160,7 +1148,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	ret = at91_adc_channel_init(idev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
-		goto error_disable_adc_clk;
+		goto error_free_irq;
 	}
 
 	init_waitqueue_head(&st->wq_data_avail);
@@ -1175,19 +1163,19 @@ static int at91_adc_probe(struct platform_device *pdev)
 		ret = at91_adc_buffer_init(idev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
-			goto error_disable_adc_clk;
+			goto error_free_irq;
 		}
 
 		ret = at91_adc_trigger_init(idev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
 			at91_adc_buffer_remove(idev);
-			goto error_disable_adc_clk;
+			goto error_free_irq;
 		}
 	} else {
 		ret = at91_ts_register(idev, pdev);
 		if (ret)
-			goto error_disable_adc_clk;
+			goto error_free_irq;
 
 		at91_ts_hw_init(idev, adc_clk_khz);
 	}
@@ -1207,10 +1195,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	} else {
 		at91_ts_unregister(st);
 	}
-error_disable_adc_clk:
-	clk_disable_unprepare(st->adc_clk);
-error_disable_clk:
-	clk_disable_unprepare(st->clk);
 error_free_irq:
 	free_irq(st->irq, idev);
 	return ret;
@@ -1228,8 +1212,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	} else {
 		at91_ts_unregister(st);
 	}
-	clk_disable_unprepare(st->adc_clk);
-	clk_disable_unprepare(st->clk);
 	free_irq(st->irq, idev);
 
 	return 0;
-- 
2.34.1

