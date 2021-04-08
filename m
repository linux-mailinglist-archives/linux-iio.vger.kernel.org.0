Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06531358228
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhDHLlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15981 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhDHLlL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:11 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5y1MfpzyNbw;
        Thu,  8 Apr 2021 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:50 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 2/7] iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free
Date:   Thu, 8 Apr 2021 19:38:11 +0800
Message-ID: <1617881896-3164-3-git-send-email-yangyicong@hisilicon.com>
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
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b0cb9a3..9ecc03f 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -228,9 +228,9 @@ static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 	iio_buffer_put(buffer);
 }
 
-static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
+static void __devm_iio_dmaengine_buffer_free(void *buffer)
 {
-	iio_dmaengine_buffer_free(*(struct iio_buffer **)res);
+	iio_dmaengine_buffer_free(buffer);
 }
 
 /**
@@ -247,21 +247,17 @@ static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
 struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel)
 {
-	struct iio_buffer **bufferp, *buffer;
-
-	bufferp = devres_alloc(__devm_iio_dmaengine_buffer_free,
-			       sizeof(*bufferp), GFP_KERNEL);
-	if (!bufferp)
-		return ERR_PTR(-ENOMEM);
+	struct iio_buffer *buffer;
+	int ret;
 
 	buffer = iio_dmaengine_buffer_alloc(dev, channel);
-	if (IS_ERR(buffer)) {
-		devres_free(bufferp);
+	if (IS_ERR(buffer))
 		return buffer;
-	}
 
-	*bufferp = buffer;
-	devres_add(dev, bufferp);
+	ret = devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
+				       buffer);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return buffer;
 }
-- 
2.8.1

