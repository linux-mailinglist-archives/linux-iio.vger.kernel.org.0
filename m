Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8696B789373
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 04:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjHZCaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjHZC3k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 22:29:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB73128
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 19:29:38 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXgg85bb5zJrnf;
        Sat, 26 Aug 2023 10:26:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 10:29:36 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <yangyingliang@huawei.com>,
        <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH -next v2 3/3] iio: adc: at91_adc: Simplify with dev_err_probe()
Date:   Sat, 26 Aug 2023 10:29:22 +0800
Message-ID: <20230826022922.3457054-4-ruanjinjie@huawei.com>
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

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error
is printed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iio/adc/at91_adc.c | 65 ++++++++++++++------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 2ac1b64f0fb7..a49f7021c73f 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1013,28 +1013,25 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
-	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
-		dev_err(&idev->dev, "Missing adc-channels-used property in the DT.\n");
-		return -EINVAL;
-	}
+	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop))
+		return dev_err_probe(&idev->dev, -EINVAL,
+				     "Missing adc-channels-used property in the DT.\n");
 	st->channels_mask = prop;
 
 	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
 
-	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
-		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
-		return -EINVAL;
-	}
+	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop))
+		return dev_err_probe(&idev->dev, -EINVAL,
+				     "Missing adc-startup-time property in the DT.\n");
 	st->startup_time = prop;
 
 	prop = 0;
 	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
 	st->sample_hold_time = prop;
 
-	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
-		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
-		return -EINVAL;
-	}
+	if (of_property_read_u32(node, "atmel,adc-vref", &prop))
+		return dev_err_probe(&idev->dev, -EINVAL,
+				     "Missing adc-vref property in the DT.\n");
 	st->vref_mv = prop;
 
 	st->res = st->caps->high_res_bits;
@@ -1069,7 +1066,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(st->reg_base))
 		return PTR_ERR(st->reg_base);
 
-
 	/*
 	 * Disable all IRQs before setting up the handler
 	 */
@@ -1084,26 +1080,18 @@ static int at91_adc_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, st->irq,
 				       at91_adc_rl_interrupt, 0,
 				       pdev->dev.driver->name, idev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to allocate IRQ.\n");
 
 	st->clk = devm_clk_get_enabled(&pdev->dev, "adc_clk");
-	if (IS_ERR(st->clk)) {
-		dev_err(&pdev->dev,
-			"Could not prepare or enable the clock.\n");
-		ret = PTR_ERR(st->clk);
-		return ret;
-	}
+	if (IS_ERR(st->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->clk),
+				     "Could not prepare or enable the clock.\n");
 
 	st->adc_clk = devm_clk_get_enabled(&pdev->dev, "adc_op_clk");
-	if (IS_ERR(st->adc_clk)) {
-		dev_err(&pdev->dev,
-			"Could not prepare or enable the ADC clock.\n");
-		ret = PTR_ERR(st->adc_clk);
-		return ret;
-	}
+	if (IS_ERR(st->adc_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->adc_clk),
+				     "Could not prepare or enable the ADC clock.\n");
 
 	/*
 	 * Prescaler rate computation using the formula from the Atmel's
@@ -1119,10 +1107,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	prsc = (mstrclk / (2 * adc_clk)) - 1;
 
-	if (!st->startup_time) {
-		dev_err(&pdev->dev, "No startup time available.\n");
-		return -EINVAL;
-	}
+	if (!st->startup_time)
+		return dev_err_probe(&pdev->dev, -EINVAL, "No startup time available.\n");
 	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
 
 	/*
@@ -1147,10 +1133,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	/* Setup the ADC channels available on the board */
 	ret = at91_adc_channel_init(idev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Couldn't initialize the channels.\n");
 
 	init_waitqueue_head(&st->wq_data_avail);
 	mutex_init(&st->lock);
@@ -1162,10 +1146,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 	 */
 	if (!st->touchscreen_type) {
 		ret = at91_adc_buffer_init(idev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Couldn't initialize the buffer.\n");
 
 		ret = at91_adc_trigger_init(idev);
 		if (ret < 0) {
-- 
2.34.1

