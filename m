Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D37358225
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhDHLlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15978 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhDHLlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5y0P9DzyNQQ;
        Thu,  8 Apr 2021 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:51 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 4/7] iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext
Date:   Thu, 8 Apr 2021 19:38:13 +0800
Message-ID: <1617881896-3164-5-git-send-email-yangyicong@hisilicon.com>
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
 drivers/iio/buffer/industrialio-triggered-buffer.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 92b8aea..63b4722 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -92,9 +92,9 @@ void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_triggered_buffer_cleanup);
 
-static void devm_iio_triggered_buffer_clean(struct device *dev, void *res)
+static void devm_iio_triggered_buffer_clean(void *indio_dev)
 {
-	iio_triggered_buffer_cleanup(*(struct iio_dev **)res);
+	iio_triggered_buffer_cleanup(indio_dev);
 }
 
 int devm_iio_triggered_buffer_setup_ext(struct device *dev,
@@ -104,24 +104,15 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 					const struct iio_buffer_setup_ops *ops,
 					const struct attribute **buffer_attrs)
 {
-	struct iio_dev **ptr;
 	int ret;
 
-	ptr = devres_alloc(devm_iio_triggered_buffer_clean, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	*ptr = indio_dev;
-
 	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, ops,
 					     buffer_attrs);
 	if (!ret)
-		devres_add(dev, ptr);
-	else
-		devres_free(ptr);
+		return ret;
 
-	return ret;
+	return devm_add_action_or_reset(dev, devm_iio_triggered_buffer_clean,
+					indio_dev);
 }
 EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup_ext);
 
-- 
2.8.1

