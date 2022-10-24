Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D964E609D0D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiJXIqO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJXIqJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 04:46:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC94BA68
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 01:46:04 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MwpVQ3Mz9zpVsl;
        Mon, 24 Oct 2022 16:42:38 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:46:02 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 16:46:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-iio@vger.kernel.org>
CC:     <mripard@kernel.org>, <jic23@kernel.org>,
        <jonathan.cameron@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH] iio: adc: at91_adc: fix possible memory leak in at91_adc_allocate_trigger()
Date:   Mon, 24 Oct 2022 16:45:11 +0800
Message-ID: <20221024084511.815096-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If iio_trigger_register() returns error, it should call iio_trigger_free()
to give up the reference that hold in iio_trigger_alloc(), so that it can
call iio_trig_release() to free memory when the refcount hit to 0.

Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/adc/at91_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 532daaa6f943..366e252ebeb0 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -634,8 +634,10 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
 	trig->ops = &at91_adc_trigger_ops;
 
 	ret = iio_trigger_register(trig);
-	if (ret)
+	if (ret) {
+		iio_trigger_free(trig);
 		return NULL;
+	}
 
 	return trig;
 }
-- 
2.25.1

