Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F017619320
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 10:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKDJGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKDJGM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 05:06:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA02980C
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 02:06:10 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N3ZTc2h2SzHvdG;
        Fri,  4 Nov 2022 17:05:24 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 17:05:44 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <nuno.sa@analog.com>,
        <andy.shevchenko@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <liwei391@huawei.com>,
        Peng Wu <wupeng58@huawei.com>
Subject: [PATCH -next] iio: core: fix missing mutex_unlock() in iio_device_claim_buffer_mode()
Date:   Fri, 4 Nov 2022 09:03:07 +0000
Message-ID: <20221104090307.17734-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the success path of iio_device_claim_buffer_mode(), mutex_unlock()
should be called before return.

Fixes: e6dad5edfb8c ("iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs")
Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/iio/industrialio-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 52e690f031cb..88987cdc9e3f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2102,8 +2102,10 @@ int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
 
 	mutex_lock(&iio_dev_opaque->mlock);
 
-	if (iio_buffer_enabled(indio_dev))
+	if (iio_buffer_enabled(indio_dev)) {
+		mutex_unlock(&iio_dev_opaque->mlock);
 		return 0;
+	}
 
 	mutex_unlock(&iio_dev_opaque->mlock);
 	return -EBUSY;
-- 
2.17.1

