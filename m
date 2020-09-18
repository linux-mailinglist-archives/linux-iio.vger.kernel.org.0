Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6863E26F866
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIRIca (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 04:32:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbgIRIca (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Sep 2020 04:32:30 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43E1D56B5A0EC57846F3;
        Fri, 18 Sep 2020 16:32:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:32:17 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <Jonathan.Cameron@huawei.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] iio: adc: stm32-dfsdm: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 18 Sep 2020 16:31:42 +0800
Message-ID: <20200918083142.32816-1-bobo.shaobowang@huawei.com>
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
driver core platform instead of duplicated analogue, dev_err() is
removed because it has been done in devm_ioremap_resource().

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 0b8bea88b011..42a7377704a4 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -226,16 +226,13 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 	if (!node)
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get memory resource\n");
-		return -ENODEV;
-	}
-	priv->dfsdm.phys_base = res->start;
-	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
+	priv->dfsdm.base = devm_platform_get_and_ioremap_resource(pdev, 0,
+							&res);
 	if (IS_ERR(priv->dfsdm.base))
 		return PTR_ERR(priv->dfsdm.base);
 
+	priv->dfsdm.phys_base = res->start;
+
 	/*
 	 * "dfsdm" clock is mandatory for DFSDM peripheral clocking.
 	 * "dfsdm" or "audio" clocks can be used as source clock for
-- 
2.17.1

