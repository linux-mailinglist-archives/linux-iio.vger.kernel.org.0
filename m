Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5665EBADB
	for <lists+linux-iio@lfdr.de>; Tue, 27 Sep 2022 08:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiI0GmA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 02:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiI0Gl7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 02:41:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233F91D23
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 23:41:57 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc90j2bWwzlVqK;
        Tue, 27 Sep 2022 14:37:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:41:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 14:41:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-iio@vger.kernel.org>
CC:     <peda@axentia.se>, <jic23@kernel.org>, <lars@metafoo.de>,
        <Jonathan.Cameron@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] iio: multiplexer: Switch to use dev_err_probe() helper
Date:   Tue, 27 Sep 2022 14:48:41 +0800
Message-ID: <20220927064841.319291-1-yangyingliang@huawei.com>
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
 drivers/iio/multiplexer/iio-mux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 93558fddfa9b..edd8c69f6d2e 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -416,11 +416,9 @@ static int mux_probe(struct platform_device *pdev)
 	}
 
 	mux->control = devm_mux_control_get(dev, NULL);
-	if (IS_ERR(mux->control)) {
-		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get control-mux\n");
-		return PTR_ERR(mux->control);
-	}
+	if (IS_ERR(mux->control))
+		return dev_err_probe(dev, PTR_ERR(mux->control),
+				     "failed to get control-mux\n");
 
 	i = 0;
 	for (state = 0; state < all_children; state++) {
-- 
2.25.1

