Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD67893B9
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 05:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHZDyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 23:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjHZDyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 23:54:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC34269F
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 20:54:21 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXjXw1Ml6zJrp3;
        Sat, 26 Aug 2023 11:51:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 11:54:19 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/2] iio: adc: mt6577_auxadc: Simplify with device managed function
Date:   Sat, 26 Aug 2023 11:54:02 +0800
Message-ID: <20230826035402.3512033-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826035402.3512033-1-ruanjinjie@huawei.com>
References: <20230826035402.3512033-1-ruanjinjie@huawei.com>
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

Add a device managed hook, via devm_add_action_or_reset() and
mt6577_power_off(), to power off on device detach.

Replace iio_device_register() by devm_iio_device_register() and remove
the mt6577_auxadc_remove() function used to unregister the device and
power off the device.

Remove platform_set_drvdata() from the probe function, since
platform_get_drvdata() is not used anymore.

Remove mt6577_auxadc_mod_reg() call from the probe function error path.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/mt6577_auxadc.c | 40 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 935cf560e238..c8f7bfa59146 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -246,6 +246,14 @@ static int mt6577_auxadc_suspend(struct device *dev)
 	return 0;
 }
 
+static void mt6577_power_off(void *data)
+{
+	struct mt6577_auxadc_device *adc_dev = data;
+
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
+			      0, MT6577_AUXADC_PDN_EN);
+}
+
 static int mt6577_auxadc_probe(struct platform_device *pdev)
 {
 	struct mt6577_auxadc_device *adc_dev;
@@ -286,31 +294,14 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 			      MT6577_AUXADC_PDN_EN, 0);
 	mdelay(MT6577_AUXADC_POWER_READY_MS);
 
-	platform_set_drvdata(pdev, indio_dev);
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register iio device\n");
-		goto err_power_off;
-	}
-
-	return 0;
+	ret = devm_add_action_or_reset(&pdev->dev, mt6577_power_off, adc_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to add action to managed power off: %d\n", ret);
 
-err_power_off:
-	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
-			      0, MT6577_AUXADC_PDN_EN);
-	return ret;
-}
-
-static int mt6577_auxadc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
-			      0, MT6577_AUXADC_PDN_EN);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to register iio device\n");
 
 	return 0;
 }
@@ -337,7 +328,6 @@ static struct platform_driver mt6577_auxadc_driver = {
 		.pm = pm_sleep_ptr(&mt6577_auxadc_pm_ops),
 	},
 	.probe	= mt6577_auxadc_probe,
-	.remove	= mt6577_auxadc_remove,
 };
 module_platform_driver(mt6577_auxadc_driver);
 
-- 
2.34.1

