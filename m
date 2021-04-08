Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBC358227
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhDHLlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15980 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHLlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5y09cBzyNQP;
        Thu,  8 Apr 2021 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:51 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 6/7] iio: trigger: simplify __devm_iio_trigger_register
Date:   Thu, 8 Apr 2021 19:38:15 +0800
Message-ID: <1617881896-3164-7-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/iio/industrialio-trigger.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ea3c985..0db0952 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -624,9 +624,9 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_trigger_alloc);
 
-static void devm_iio_trigger_unreg(struct device *dev, void *res)
+static void devm_iio_trigger_unreg(void *trigger_info)
 {
-	iio_trigger_unregister(*(struct iio_trigger **)res);
+	iio_trigger_unregister(trigger_info);
 }
 
 /**
@@ -647,21 +647,13 @@ int __devm_iio_trigger_register(struct device *dev,
 				struct iio_trigger *trig_info,
 				struct module *this_mod)
 {
-	struct iio_trigger **ptr;
 	int ret;
 
-	ptr = devres_alloc(devm_iio_trigger_unreg, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	*ptr = trig_info;
 	ret = __iio_trigger_register(trig_info, this_mod);
-	if (!ret)
-		devres_add(dev, ptr);
-	else
-		devres_free(ptr);
+	if (ret)
+		return ret;
 
-	return ret;
+	return devm_add_action_or_reset(dev, devm_iio_trigger_unreg, trig_info);
 }
 EXPORT_SYMBOL_GPL(__devm_iio_trigger_register);
 
-- 
2.8.1

