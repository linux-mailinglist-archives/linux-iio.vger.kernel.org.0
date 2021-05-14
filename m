Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4193804D3
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhENIEr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 04:04:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2980 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhENIEr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 04:04:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FhLZV29kZzjMll;
        Fri, 14 May 2021 16:01:22 +0800 (CST)
Received: from localhost (10.174.179.215) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 16:03:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <yuehaibing@huawei.com>, <gregkh@suse.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] iio: adc: ad7793: Add missing error code in ad7793_setup()
Date:   Fri, 14 May 2021 16:02:54 +0800
Message-ID: <20210514080254.9620-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set error code while device ID query failed.

Fixes: 88bc30548aae ("IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI ADC")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use ENODEV instead of EINVAL

 drivers/iio/adc/ad7793.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5e980a06258e..b4f9ac3838e1 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -279,6 +279,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	id &= AD7793_ID_MASK;
 
 	if (id != st->chip_info->id) {
+		ret = -ENODEV;
 		dev_err(&st->sd.spi->dev, "device ID query failed\n");
 		goto out;
 	}
-- 
2.17.1

