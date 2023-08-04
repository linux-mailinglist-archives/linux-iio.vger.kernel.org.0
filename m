Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6219776FE28
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 12:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHDKKK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 06:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHDKKJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 06:10:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F72118
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 03:10:08 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHLyC29KPzVk24;
        Fri,  4 Aug 2023 18:08:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 18:10:06 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>
CC:     <lizetao1@huawei.com>, <linux-iio@vger.kernel.org>
Subject: [PATCH -next] iio: adc: men_z188_adc: Remove redundant initialization owner in men_z188_driver
Date:   Fri, 4 Aug 2023 18:09:38 +0800
Message-ID: <20230804100938.100435-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The module_mcb_driver() will set "THIS_MODULE" to driver.owner when
register a mcb_driver, so it is redundant initialization to set
driver.owner in men_z188_driver statement. Remove it for clean code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/iio/adc/men_z188_adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index adc5ceaef8c9..198c7e68e0cf 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -161,7 +161,6 @@ MODULE_DEVICE_TABLE(mcb, men_z188_ids);
 static struct mcb_driver men_z188_driver = {
 	.driver = {
 		.name = "z188-adc",
-		.owner = THIS_MODULE,
 	},
 	.probe = men_z188_probe,
 	.remove = men_z188_remove,
-- 
2.34.1

