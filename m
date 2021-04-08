Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F3535822A
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhDHLlP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16046 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhDHLlO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5M39vyzNtx0;
        Thu,  8 Apr 2021 19:38:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:52 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 7/7] iio: inkern: simplify some devm functions
Date:   Thu, 8 Apr 2021 19:38:16 +0800
Message-ID: <1617881896-3164-8-git-send-email-yangyicong@hisilicon.com>
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
 drivers/iio/inkern.c | 61 ++++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index db77a2d..5de35cc 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -359,30 +359,24 @@ void iio_channel_release(struct iio_channel *channel)
 }
 EXPORT_SYMBOL_GPL(iio_channel_release);
 
-static void devm_iio_channel_free(struct device *dev, void *res)
+static void devm_iio_channel_free(void *iio_channel)
 {
-	struct iio_channel *channel = *(struct iio_channel **)res;
-
-	iio_channel_release(channel);
+	iio_channel_release(iio_channel);
 }
 
 struct iio_channel *devm_iio_channel_get(struct device *dev,
 					 const char *channel_name)
 {
-	struct iio_channel **ptr, *channel;
-
-	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct iio_channel *channel;
+	int ret;
 
 	channel = iio_channel_get(dev, channel_name);
-	if (IS_ERR(channel)) {
-		devres_free(ptr);
+	if (IS_ERR(channel))
 		return channel;
-	}
 
-	*ptr = channel;
-	devres_add(dev, ptr);
+	ret = devm_add_action_or_reset(dev, devm_iio_channel_free, channel);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return channel;
 }
@@ -392,20 +386,16 @@ struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
 						    struct device_node *np,
 						    const char *channel_name)
 {
-	struct iio_channel **ptr, *channel;
-
-	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct iio_channel *channel;
+	int ret;
 
 	channel = of_iio_channel_get_by_name(np, channel_name);
-	if (IS_ERR(channel)) {
-		devres_free(ptr);
+	if (IS_ERR(channel))
 		return channel;
-	}
 
-	*ptr = channel;
-	devres_add(dev, ptr);
+	ret = devm_add_action_or_reset(dev, devm_iio_channel_free, channel);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return channel;
 }
@@ -496,29 +486,24 @@ void iio_channel_release_all(struct iio_channel *channels)
 }
 EXPORT_SYMBOL_GPL(iio_channel_release_all);
 
-static void devm_iio_channel_free_all(struct device *dev, void *res)
+static void devm_iio_channel_free_all(void *iio_channels)
 {
-	struct iio_channel *channels = *(struct iio_channel **)res;
-
-	iio_channel_release_all(channels);
+	iio_channel_release_all(iio_channels);
 }
 
 struct iio_channel *devm_iio_channel_get_all(struct device *dev)
 {
-	struct iio_channel **ptr, *channels;
-
-	ptr = devres_alloc(devm_iio_channel_free_all, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct iio_channel *channels;
+	int ret;
 
 	channels = iio_channel_get_all(dev);
-	if (IS_ERR(channels)) {
-		devres_free(ptr);
+	if (IS_ERR(channels))
 		return channels;
-	}
 
-	*ptr = channels;
-	devres_add(dev, ptr);
+	ret = devm_add_action_or_reset(dev, devm_iio_channel_free_all,
+				       channels);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return channels;
 }
-- 
2.8.1

