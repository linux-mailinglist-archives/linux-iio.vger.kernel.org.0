Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD55435D0B
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJUIli (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 04:41:38 -0400
Received: from mx24.baidu.com ([111.206.215.185]:43338 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231315AbhJUIlh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 04:41:37 -0400
Received: from BC-Mail-Ex16.internal.baidu.com (unknown [172.31.51.56])
        by Forcepoint Email with ESMTPS id CFAB9BD4B00325289DF9;
        Thu, 21 Oct 2021 16:39:19 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex16.internal.baidu.com (172.31.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 16:39:19 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:39:19 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ina2xx: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:39:17 +0800
Message-ID: <20211021083917.2024-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
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

