Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF937A5E4
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhEKLl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 07:41:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2631 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhEKLl0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 07:41:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FfbVd46zYzPwtP;
        Tue, 11 May 2021 19:36:57 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:40:11 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] iio: ep93xx: Remove redundant error printing in ep93xx_adc_probe()
Date:   Tue, 11 May 2021 19:39:12 +0800
Message-ID: <20210511113912.5548-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When devm_ioremap_resource() fails, a clear enough error message will be
printed by its subfunction __devm_ioremap_resource(). The error
information contains the device name, failure cause, and possibly resource
information.

Therefore, remove the error printing here to simplify code and reduce the
binary size.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iio/adc/ep93xx_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index c08ab3c6dfafd48..a10a4e8d94fdda8 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -165,10 +165,8 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->base)) {
-		dev_err(&pdev->dev, "Cannot map memory resource\n");
+	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
-	}
 
 	iiodev->name = dev_name(&pdev->dev);
 	iiodev->modes = INDIO_DIRECT_MODE;
-- 
2.26.0.106.g9fadedd


