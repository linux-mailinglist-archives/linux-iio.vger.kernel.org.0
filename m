Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7A63B764
	for <lists+linux-iio@lfdr.de>; Tue, 29 Nov 2022 02:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiK2Bpz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Nov 2022 20:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiK2Bpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2022 20:45:46 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B1421AF
        for <linux-iio@vger.kernel.org>; Mon, 28 Nov 2022 17:45:44 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLlX06hyqz15Mtt;
        Tue, 29 Nov 2022 09:45:04 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 09:45:43 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 09:45:42 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <yangyingliang@huawei.com>, <guohanjun@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH] iio: adc: berlin2-adc: Add missing of_node_put() in error path
Date:   Tue, 29 Nov 2022 10:03:16 +0800
Message-ID: <20221129020316.191731-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

of_get_parent() will return a device_node pointer with refcount
incremented. We need to use of_node_put() on it when done. Add the
missing of_node_put() in the error path of berlin2_adc_probe();

Fixes: 70f1937911ca ("iio: adc: add support for Berlin")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/iio/adc/berlin2-adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 3d2e8b4db61a..a4e7c7eff5ac 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -298,8 +298,10 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
-	if (!indio_dev)
+	if (!indio_dev) {
+		of_node_put(parent_np);
 		return -ENOMEM;
+	}
 
 	priv = iio_priv(indio_dev);
 
-- 
2.20.1

