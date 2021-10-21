Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD394361FE
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUMpX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 08:45:23 -0400
Received: from mx24.baidu.com ([111.206.215.185]:57666 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230260AbhJUMpW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 08:45:22 -0400
Received: from BJHW-Mail-Ex12.internal.baidu.com (unknown [10.127.64.35])
        by Forcepoint Email with ESMTPS id 3E222FEFF96EA002A8F3;
        Thu, 21 Oct 2021 20:43:05 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:43:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:43:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <lars@metafoo.de>
CC:     Cai Huoqing <caihuoqing@baidu.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] iio: adc: ina2xx: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 20:42:53 +0800
Message-ID: <20211021124254.3247-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex22.internal.baidu.com (172.31.51.16) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex12_2021-10-21 20:43:05:286
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: Sort with [2/2] patch as a series.

 drivers/iio/adc/ina2xx-adc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0dd5..360d7a00f60d 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -842,15 +842,14 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
 	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
 		chip->allow_async_readout);
 
-	task = kthread_create(ina2xx_capture_thread, (void *)indio_dev,
-			      "%s:%d-%uus", indio_dev->name,
-			      iio_device_id(indio_dev),
-			      sampling_us);
+	task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
+			   "%s:%d-%uus", indio_dev->name,
+			   iio_device_id(indio_dev),
+			   sampling_us);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 
 	get_task_struct(task);
-	wake_up_process(task);
 	chip->task = task;
 
 	return 0;
-- 
2.25.1

