Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48672D7266
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 09:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437226AbgLKI5d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 03:57:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9188 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393127AbgLKI5X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 03:57:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Csl4X248hzkpPN;
        Fri, 11 Dec 2020 16:55:56 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:56:32 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <tduszyns@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC:     <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] iio: chemical: pms7003: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:57:00 +0800
Message-ID: <20201211085700.3037-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/iio/chemical/pms7003.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index e9d4405654bc..e9857d93b307 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -282,7 +282,7 @@ static int pms7003_probe(struct serdev_device *serdev)
 	state->serdev = serdev;
 	indio_dev->info = &pms7003_info;
 	indio_dev->name = PMS7003_DRIVER_NAME;
-	indio_dev->channels = pms7003_channels,
+	indio_dev->channels = pms7003_channels;
 	indio_dev->num_channels = ARRAY_SIZE(pms7003_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = pms7003_scan_masks;
-- 
2.22.0

