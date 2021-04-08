Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A2C358229
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHLlM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15982 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhDHLlM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5y1cLzzyNcQ;
        Thu,  8 Apr 2021 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:50 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 1/7] iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
Date:   Thu, 8 Apr 2021 19:38:10 +0800
Message-ID: <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
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
 drivers/iio/adc/adi-axi-adc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9109da2..575a63f 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -210,29 +210,25 @@ static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
 	kfree(cl);
 }
 
-static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
+static void devm_adi_axi_adc_conv_release(void *conv)
 {
-	adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
+	adi_axi_adc_conv_unregister(conv);
 }
 
 struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
 							size_t sizeof_priv)
 {
-	struct adi_axi_adc_conv **ptr, *conv;
-
-	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct adi_axi_adc_conv *conv;
+	int ret;
 
 	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
-	if (IS_ERR(conv)) {
-		devres_free(ptr);
+	if (IS_ERR(conv))
 		return ERR_CAST(conv);
-	}
 
-	*ptr = conv;
-	devres_add(dev, ptr);
+	ret = devm_add_action_or_reset(dev, devm_adi_axi_adc_conv_release,
+				       conv);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return conv;
 }
-- 
2.8.1

