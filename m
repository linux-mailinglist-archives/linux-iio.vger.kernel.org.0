Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D81358226
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhDHLlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15979 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhDHLlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5y0qnNzyNbf;
        Thu,  8 Apr 2021 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:51 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 3/7] iio: hw_consumer: simplify devm_iio_hw_consumer_alloc
Date:   Thu, 8 Apr 2021 19:38:12 +0800
Message-ID: <1617881896-3164-4-git-send-email-yangyicong@hisilicon.com>
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
 drivers/iio/buffer/industrialio-hw-consumer.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index f2d2778..87d9aab 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -137,9 +137,9 @@ void iio_hw_consumer_free(struct iio_hw_consumer *hwc)
 }
 EXPORT_SYMBOL_GPL(iio_hw_consumer_free);
 
-static void devm_iio_hw_consumer_release(struct device *dev, void *res)
+static void devm_iio_hw_consumer_release(void *iio_hwc)
 {
-	iio_hw_consumer_free(*(struct iio_hw_consumer **)res);
+	iio_hw_consumer_free(iio_hwc);
 }
 
 /**
@@ -153,20 +153,17 @@ static void devm_iio_hw_consumer_release(struct device *dev, void *res)
  */
 struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
 {
-	struct iio_hw_consumer **ptr, *iio_hwc;
-
-	ptr = devres_alloc(devm_iio_hw_consumer_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	struct iio_hw_consumer *iio_hwc;
+	int ret;
 
 	iio_hwc = iio_hw_consumer_alloc(dev);
-	if (IS_ERR(iio_hwc)) {
-		devres_free(ptr);
-	} else {
-		*ptr = iio_hwc;
-		devres_add(dev, ptr);
-	}
+	if (IS_ERR(iio_hwc))
+		return iio_hwc;
+
+	ret = devm_add_action_or_reset(dev, devm_iio_hw_consumer_release,
+				       iio_hwc);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return iio_hwc;
 }
-- 
2.8.1

