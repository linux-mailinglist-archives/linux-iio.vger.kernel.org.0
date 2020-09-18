Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6613B26F828
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIRI33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 04:29:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRI33 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Sep 2020 04:29:29 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7BFACCC4C283E782FBE;
        Fri, 18 Sep 2020 16:29:25 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:29:15 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <Jonathan.Cameron@huawei.com>, <eugen.hristev@microchip.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] iio: adc: at91-sama5d2_adc: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 18 Sep 2020 16:28:37 +0800
Message-ID: <20200918082837.32610-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of devm_platform_get_and_ioremap_resource() provided by
driver core platform instead of duplicated analogue.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index de9583d6cddd..ad7d9819f83c 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1764,17 +1764,13 @@ static int at91_adc_probe(struct platform_device *pdev)
 	mutex_init(&st->lock);
 	INIT_WORK(&st->touch_st.workq, at91_adc_workq_handler);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	st->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(st->base))
+		return PTR_ERR(st->base);
 
 	/* if we plan to use DMA, we need the physical address of the regs */
 	st->dma_st.phys_addr = res->start;
 
-	st->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(st->base))
-		return PTR_ERR(st->base);
-
 	st->irq = platform_get_irq(pdev, 0);
 	if (st->irq <= 0) {
 		if (!st->irq)
-- 
2.17.1

