Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7164A789406
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHZG2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHZG1s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 02:27:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADE1FC3
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 23:27:46 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXmyq4BG3zVkQ2;
        Sat, 26 Aug 2023 14:25:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 14:27:43 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 1/2] iio: adc: spear_adc: Use device managed function
Date:   Sat, 26 Aug 2023 14:27:31 +0800
Message-ID: <20230826062733.3714169-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826062733.3714169-1-ruanjinjie@huawei.com>
References: <20230826062733.3714169-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
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

Switch to devm_iio_device_register() and drop the remove function.

This simplifies the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
v2:
- Also switch to devm_iio_device_register() and drop the remove function.
---
 drivers/iio/adc/spear_adc.c | 43 +++++++------------------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index ad54ef798109..d24adacfdf53 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -297,36 +297,27 @@ static int spear_adc_probe(struct platform_device *pdev)
 	st->adc_base_spear3xx =
 		(struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
 
-	st->clk = devm_clk_get(dev, NULL);
+	st->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(st->clk)) {
-		dev_err(dev, "failed getting clock\n");
-		return PTR_ERR(st->clk);
-	}
-
-	ret = clk_prepare_enable(st->clk);
-	if (ret) {
 		dev_err(dev, "failed enabling clock\n");
-		return ret;
+		return PTR_ERR(st->clk);
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto errout2;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
 			       st);
 	if (ret < 0) {
 		dev_err(dev, "failed requesting interrupt\n");
-		goto errout2;
+		return ret;
 	}
 
 	if (of_property_read_u32(np, "sampling-frequency",
 				 &st->sampling_freq)) {
 		dev_err(dev, "sampling-frequency missing in DT\n");
-		ret = -EINVAL;
-		goto errout2;
+		return -EINVAL;
 	}
 
 	/*
@@ -343,8 +334,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	spear_adc_configure(st);
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	init_completion(&st->completion);
 
 	indio_dev->name = SPEAR_ADC_MOD_NAME;
@@ -353,27 +342,12 @@ static int spear_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = spear_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(spear_adc_iio_channels);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		goto errout2;
+		return ret;
 
 	dev_info(dev, "SPEAR ADC driver loaded, IRQ %d\n", irq);
 
-	return 0;
-
-errout2:
-	clk_disable_unprepare(st->clk);
-	return ret;
-}
-
-static int spear_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct spear_adc_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(st->clk);
-
 	return 0;
 }
 
@@ -387,7 +361,6 @@ MODULE_DEVICE_TABLE(of, spear_adc_dt_ids);
 
 static struct platform_driver spear_adc_driver = {
 	.probe		= spear_adc_probe,
-	.remove		= spear_adc_remove,
 	.driver		= {
 		.name	= SPEAR_ADC_MOD_NAME,
 		.of_match_table = of_match_ptr(spear_adc_dt_ids),
-- 
2.34.1

