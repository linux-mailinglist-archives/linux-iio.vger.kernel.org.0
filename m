Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BBC60604D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Oct 2022 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJTMgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Oct 2022 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJTMgS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2022 08:36:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D217EF01
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2022 05:35:49 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtRln2dVVzmVF7;
        Thu, 20 Oct 2022 20:31:01 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 20:35:39 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 20:35:39 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>
CC:     <linux-iio@vger.kernel.org>, <linux-sunxi@lists.linux.dev>
Subject: [PATCH v2 1/2] iio: adc: sun4i-gpadc-iio: Fix PM disable depth imbalance in sun4i_gpadc_probe()
Date:   Thu, 20 Oct 2022 20:40:44 +0800
Message-ID: <20221020124045.77678-2-zhangqilong3@huawei.com>
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

The pm_runtime_enable will increase power disable depth.
Thus a pairing decrement is needed on the error handling
path to keep it balanced according to context. In addtion,
the iio_map_array path has potentially been called.

We fix it by gotoing err_map when thermal_zone register
failed.

Fixes: b0a242894f11 ("iio: adc: sun4i-gpadc-iio: register in the thermal after registering in pm")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
v2:
- revert iio_map_array if it's necessary when thermal_zone
  register failed.
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index a6ade70dedf8..d2535dd28af8 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -648,7 +648,8 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
 				PTR_ERR(info->tzd));
-			return PTR_ERR(info->tzd);
+			ret = PTR_ERR(info->tzd);
+			goto err_map;
 		}
 	}
 
-- 
2.25.1

