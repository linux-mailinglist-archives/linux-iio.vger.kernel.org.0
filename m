Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B533060604F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Oct 2022 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJTMgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Oct 2022 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJTMgb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2022 08:36:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE631217D3
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2022 05:35:58 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtRsJ3bKPzHvCR;
        Thu, 20 Oct 2022 20:35:48 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 20:35:40 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 20:35:39 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>
CC:     <linux-iio@vger.kernel.org>, <linux-sunxi@lists.linux.dev>
Subject: [PATCH v2 2/2] iio: adc: sun4i-gpadc-iio: Fix error handle when devm_iio_device_register() failed in sun4i_gpadc_probe()
Date:   Thu, 20 Oct 2022 20:40:45 +0800
Message-ID: <20221020124045.77678-3-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20221020124045.77678-1-zhangqilong3@huawei.com>
References: <20221020124045.77678-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If devm_iio_device_register() failed, the thermal_zone may have been
registered. So we need call thermal_zone_of_sensor_unregister() when
CONFIG_THERMAL_OF is enabled. We fix it by adding a err_register and
gotoing it when devm_iio_device_register() failed.

Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d2535dd28af8..04717571cb2e 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -656,11 +656,17 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register the device\n");
-		goto err_map;
+		goto err_register;
 	}
 
 	return 0;
 
+err_register:
+	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
+		devm_thermal_of_zone_unregister(info->sensor_device,
+						info->tzd);
+		info->tzd = NULL;
+	}
 err_map:
 	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
-- 
2.25.1

