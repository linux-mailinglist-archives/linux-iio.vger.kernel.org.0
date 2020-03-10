Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F360B17FFF7
	for <lists+linux-iio@lfdr.de>; Tue, 10 Mar 2020 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCJORM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Mar 2020 10:17:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56028 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727146AbgCJORM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Mar 2020 10:17:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 24C8F5FC488291F25718;
        Tue, 10 Mar 2020 22:17:09 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 10 Mar 2020
 22:17:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <stefan.popa@analog.com>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] iio:ad7797: Use correct attribute_group
Date:   Tue, 10 Mar 2020 22:16:54 +0800
Message-ID: <20200310141654.7188-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <9c53e05a-294a-c2d1-8808-605b10c964a9@metafoo.de>
References: <9c53e05a-294a-c2d1-8808-605b10c964a9@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It should use ad7797_attribute_group in ad7797_info,
according to commit ("iio:ad7793: Add support for the ad7796 and ad7797").

Scale is fixed for the ad7796 and not programmable, hence
should not have the scale_available attribute.

Fixes: fd1a8b912841 ("iio:ad7793: Add support for the ad7796 and ad7797")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
---
v2: renew log as Lars-Peter's comment

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


