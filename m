Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4545EBACF
	for <lists+linux-iio@lfdr.de>; Tue, 27 Sep 2022 08:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiI0GiA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiI0Gh7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 02:37:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C277861EA
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 23:37:58 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mc8vT4pPtzHtfX;
        Tue, 27 Sep 2022 14:33:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:37:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 14:37:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-iio@vger.kernel.org>
CC:     <dan@dlrobertson.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <Jonathan.Cameron@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] iio: accel: bma400: Switch to use dev_err_probe() helper
Date:   Tue, 27 Sep 2022 14:44:35 +0800
Message-ID: <20220927064435.152211-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs. It's more simple in error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/accel/bma400_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index ad8fce3e08cd..e4de649b6701 100644
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
+		return dev_err_probe(data->dev, ret,
+				     "Failed to get regulators\n");
 
-		return ret;
-	}
 	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
 				    data->regulators);
 	if (ret) {
-- 
2.25.1

