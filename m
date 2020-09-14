Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34982684E3
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgINGbd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 02:31:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgINGba (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Sep 2020 02:31:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0B77305C6FCFD67C0F9;
        Mon, 14 Sep 2020 14:31:27 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 14:31:21 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] iio: adc: palmas_gpadc: use module_platform_driver to simplify the code
Date:   Mon, 14 Sep 2020 14:54:01 +0800
Message-ID: <20200914065401.3726354-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

module_platform_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/iio/adc/palmas_gpadc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 1ca6570be66a..889b88768b63 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -834,18 +834,7 @@ static struct platform_driver palmas_gpadc_driver = {
 		.of_match_table = of_palmas_gpadc_match_tbl,
 	},
 };
-
-static int __init palmas_gpadc_init(void)
-{
-	return platform_driver_register(&palmas_gpadc_driver);
-}
-module_init(palmas_gpadc_init);
-
-static void __exit palmas_gpadc_exit(void)
-{
-	platform_driver_unregister(&palmas_gpadc_driver);
-}
-module_exit(palmas_gpadc_exit);
+module_platform_driver(palmas_gpadc_driver);
 
 MODULE_DESCRIPTION("palmas GPADC driver");
 MODULE_AUTHOR("Pradeep Goudagunta<pgoudagunta@nvidia.com>");
-- 
2.25.1

