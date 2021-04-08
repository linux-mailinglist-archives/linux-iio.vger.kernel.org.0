Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E347358223
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhDHLlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15977 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhDHLlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5y176tzyNbj;
        Thu,  8 Apr 2021 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:51 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 5/7] iio: core: simplify some devm functions
Date:   Thu, 8 Apr 2021 19:38:14 +0800
Message-ID: <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
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
 drivers/iio/industrialio-core.c | 43 +++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 7db761a..2dfbed3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1627,9 +1627,9 @@ void iio_device_free(struct iio_dev *dev)
 }
 EXPORT_SYMBOL(iio_device_free);
 
-static void devm_iio_device_release(struct device *dev, void *res)
+static void devm_iio_device_release(void *iio_dev)
 {
-	iio_device_free(*(struct iio_dev **)res);
+	iio_device_free(iio_dev);
 }
 
 /**
@@ -1645,20 +1645,17 @@ static void devm_iio_device_release(struct device *dev, void *res)
  */
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
 {
-	struct iio_dev **ptr, *iio_dev;
-
-	ptr = devres_alloc(devm_iio_device_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	struct iio_dev *iio_dev;
+	int ret;
 
 	iio_dev = iio_device_alloc(parent, sizeof_priv);
-	if (iio_dev) {
-		*ptr = iio_dev;
-		devres_add(parent, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (!iio_dev)
+		return iio_dev;
+
+	ret = devm_add_action_or_reset(parent, devm_iio_device_release,
+				       iio_dev);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return iio_dev;
 }
@@ -1889,29 +1886,21 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_device_unregister);
 
-static void devm_iio_device_unreg(struct device *dev, void *res)
+static void devm_iio_device_unreg(void *indio_dev)
 {
-	iio_device_unregister(*(struct iio_dev **)res);
+	iio_device_unregister(indio_dev);
 }
 
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod)
 {
-	struct iio_dev **ptr;
 	int ret;
 
-	ptr = devres_alloc(devm_iio_device_unreg, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	*ptr = indio_dev;
 	ret = __iio_device_register(indio_dev, this_mod);
-	if (!ret)
-		devres_add(dev, ptr);
-	else
-		devres_free(ptr);
+	if (ret)
+		return ret;
 
-	return ret;
+	return devm_add_action_or_reset(dev, devm_iio_device_unreg, indio_dev);
 }
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
-- 
2.8.1

