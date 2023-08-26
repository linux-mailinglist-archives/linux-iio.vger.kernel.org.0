Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD428789407
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjHZG2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjHZG2H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 02:28:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCFD1FC3
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 23:28:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RXn0430wnz1L97M;
        Sat, 26 Aug 2023 14:26:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 14:28:01 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 2/2] iio: adc: spear_adc: Use dev_err_probe()
Date:   Sat, 26 Aug 2023 14:27:32 +0800
Message-ID: <20230826062733.3714169-3-ruanjinjie@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iio/adc/spear_adc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index d24adacfdf53..0ccda1cd0add 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -274,10 +274,8 @@ static int spear_adc_probe(struct platform_device *pdev)
 	int irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
-	if (!indio_dev) {
-		dev_err(dev, "failed allocating iio device\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM, "failed allocating iio device\n");
 
 	st = iio_priv(indio_dev);
 
@@ -298,10 +296,8 @@ static int spear_adc_probe(struct platform_device *pdev)
 		(struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
 
 	st->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(st->clk)) {
-		dev_err(dev, "failed enabling clock\n");
-		return PTR_ERR(st->clk);
-	}
+	if (IS_ERR(st->clk))
+		return dev_err_probe(dev, PTR_ERR(st->clk), "failed enabling clock\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -309,16 +305,12 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
 			       st);
-	if (ret < 0) {
-		dev_err(dev, "failed requesting interrupt\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed requesting interrupt\n");
 
 	if (of_property_read_u32(np, "sampling-frequency",
-				 &st->sampling_freq)) {
-		dev_err(dev, "sampling-frequency missing in DT\n");
-		return -EINVAL;
-	}
+				 &st->sampling_freq))
+		return dev_err_probe(dev, -EINVAL, "sampling-frequency missing in DT\n");
 
 	/*
 	 * Optional avg_samples defaults to 0, resulting in single data
-- 
2.34.1

