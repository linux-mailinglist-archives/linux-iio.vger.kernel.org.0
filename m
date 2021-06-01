Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14071397556
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhFAOXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 10:23:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2831 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOXX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 10:23:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvZ3Z57dwzWqZX;
        Tue,  1 Jun 2021 22:16:58 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 22:21:40 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 22:21:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
Subject: [PATCH -next] iio: frequency: adf4350: disable reg and clk on error in adf4350_probe()
Date:   Tue, 1 Jun 2021 22:26:05 +0800
Message-ID: <20210601142605.3613605-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Disable reg and clk when devm_gpiod_get_optional() fails in adf4350_probe().

Fixes:4a89d2f47ccd ("iio: adf4350: Convert to use GPIO descriptor")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/frequency/adf4350.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 1462a6a5bc6d..3d9eba716b69 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -563,8 +563,10 @@ static int adf4350_probe(struct spi_device *spi)
 
 	st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev, NULL,
 							GPIOD_IN);
-	if (IS_ERR(st->lock_detect_gpiod))
-		return PTR_ERR(st->lock_detect_gpiod);
+	if (IS_ERR(st->lock_detect_gpiod)) {
+		ret = PTR_ERR(st->lock_detect_gpiod);
+		goto error_disable_reg;
+	}
 
 	if (pdata->power_up_frequency) {
 		ret = adf4350_set_freq(st, pdata->power_up_frequency);
-- 
2.25.1

