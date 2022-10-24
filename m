Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B633609F5C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJXKxm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 06:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJXKxl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 06:53:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807035A17F
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 03:53:39 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MwsJ55Lx2zVj2p;
        Mon, 24 Oct 2022 18:48:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 18:53:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 18:53:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <jonathan.cameron@huawei.com>,
        <lars@metafoo.de>, <yangyingliang@huawei.com>
Subject: [PATCH -next] iio: trigger: sysfs: rename error label in iio_sysfs_trigger_probe()
Date:   Mon, 24 Oct 2022 18:52:50 +0800
Message-ID: <20221024105250.873394-1-yangyingliang@huawei.com>
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

Rename error label in iio_sysfs_trigger_probe() to make more readable.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/trigger/iio-trig-sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index d6c5e9644738..63ce01ac2036 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -138,18 +138,18 @@ static int iio_sysfs_trigger_probe(int id)
 		}
 	if (foundit) {
 		ret = -EINVAL;
-		goto out1;
+		goto err_unlock;
 	}
 	t = kmalloc(sizeof(*t), GFP_KERNEL);
 	if (t == NULL) {
 		ret = -ENOMEM;
-		goto out1;
+		goto err_unlock;
 	}
 	t->id = id;
 	t->trig = iio_trigger_alloc(&iio_sysfs_trig_dev, "sysfstrig%d", id);
 	if (!t->trig) {
 		ret = -ENOMEM;
-		goto free_t;
+		goto err_free_sys_trig;
 	}
 
 	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
@@ -159,17 +159,17 @@ static int iio_sysfs_trigger_probe(int id)
 
 	ret = iio_trigger_register(t->trig);
 	if (ret)
-		goto out2;
+		goto err_free_trig;
 	list_add(&t->l, &iio_sysfs_trig_list);
 	__module_get(THIS_MODULE);
 	mutex_unlock(&iio_sysfs_trig_list_mut);
 	return 0;
 
-out2:
+err_free_trig:
 	iio_trigger_free(t->trig);
-free_t:
+err_free_sys_trig:
 	kfree(t);
-out1:
+err_unlock:
 	mutex_unlock(&iio_sysfs_trig_list_mut);
 	return ret;
 }
-- 
2.25.1

