Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58435788546
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjHYK6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbjHYK6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 06:58:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9D1BCC
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 03:58:12 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXGzh0wdCztSJ2;
        Fri, 25 Aug 2023 18:54:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 18:58:09 +0800
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
Subject: [PATCH -next 3/4] iio: adc: spear_adc: Use devm_clk_get_enabled() helper function
Date:   Fri, 25 Aug 2023 18:57:45 +0800
Message-ID: <20230825105746.2999548-4-ruanjinjie@huawei.com>
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
 drivers/iio/adc/spear_adc.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index ad54ef798109..cd7708aa95af 100644
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
@@ -355,24 +346,17 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto errout2;
+		return ret;
 
 	dev_info(dev, "SPEAR ADC driver loaded, IRQ %d\n", irq);
 
 	return 0;
-
-errout2:
-	clk_disable_unprepare(st->clk);
-	return ret;
 }
 
 static int spear_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct spear_adc_state *st = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(st->clk);
 
 	return 0;
 }
-- 
2.34.1

