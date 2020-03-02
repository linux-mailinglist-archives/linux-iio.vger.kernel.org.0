Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60D5175BAB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Mar 2020 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgCBNdJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Mar 2020 08:33:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbgCBNdI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Mar 2020 08:33:08 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E819561D6FB426CE43A0;
        Mon,  2 Mar 2020 21:33:02 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 21:32:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <stefan.popa@analog.com>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <Jonathan.Cameron@huawei.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iio:ad7797: Use correct attribute_group
Date:   Mon, 2 Mar 2020 21:32:49 +0800
Message-ID: <20200302133249.23152-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It seems ad7797_attribute_group should be used in ad7797_info,
according to commit ("iio:ad7793: Add support for the ad7796 and ad7797").

Fixes: fd1a8b912841 ("iio:ad7793: Add support for the ad7796 and ad7797")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b747db9..e5691e3 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -542,7 +542,7 @@ static const struct iio_info ad7797_info = {
 	.read_raw = &ad7793_read_raw,
 	.write_raw = &ad7793_write_raw,
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
-	.attrs = &ad7793_attribute_group,
+	.attrs = &ad7797_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
-- 
2.7.4


