Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2665BF3A5
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIUClv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 22:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiIUCln (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 22:41:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D37D1F5
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 19:41:42 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXMxl4y9XzMnB5;
        Wed, 21 Sep 2022 10:36:59 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 10:41:40 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <dan@dlrobertson.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] iio: accel: bma400: Switch to use dev_err_probe() helper
Date:   Wed, 21 Sep 2022 02:39:15 +0000
Message-ID: <20220921023915.47300-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the probe path, dev_err() can be replace with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iio/accel/bma400_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index eceb1f8d338d..cebd7e370b09 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -886,14 +886,10 @@ static int bma400_init(struct bma400_data *data)
 	ret = devm_regulator_bulk_get(data->dev,
 				      ARRAY_SIZE(data->regulators),
 				      data->regulators);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(data->dev,
-				"Failed to get regulators: %d\n",
-				ret);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to get regulators: %d\n",
+				     ret);
 
-		return ret;
-	}
 	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
 				    data->regulators);
 	if (ret) {
-- 
2.17.1

