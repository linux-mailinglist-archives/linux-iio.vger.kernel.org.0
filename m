Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A65EAC1C
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiIZQLz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 12:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiIZQL1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 12:11:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457399C2F1
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 07:58:49 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mbm6Y10LSzHpb6;
        Mon, 26 Sep 2022 22:56:21 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:58:36 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 22:58:35 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>
CC:     <linux-iio@vger.kernel.org>, <linux-sunxi@lists.linux.dev>
Subject: [PATCH -next] iio: adc: sun4i-gpadc-iio: fix PM disable depth imbalance in sun4i_gpadc_probe
Date:   Mon, 26 Sep 2022 23:02:06 +0800
Message-ID: <20220926150206.133549-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
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

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context.

Fixes:b0a242894f11d ("iio: adc: sun4i-gpadc-iio: register in the thermal after registering in pm")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index a6ade70dedf8..ec0b09878d54 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -648,7 +648,8 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
 				PTR_ERR(info->tzd));
-			return PTR_ERR(info->tzd);
+			ret = PTR_ERR(info->tzd);
+			goto err_pm;
 		}
 	}
 
@@ -663,7 +664,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 err_map:
 	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
-
+err_pm:
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.25.1

