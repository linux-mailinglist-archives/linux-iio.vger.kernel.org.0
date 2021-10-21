Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5AA4361FF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJUMp2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 08:45:28 -0400
Received: from mx24.baidu.com ([111.206.215.185]:57708 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230359AbhJUMp1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 08:45:27 -0400
Received: from BJHW-Mail-Ex09.internal.baidu.com (unknown [10.127.64.32])
        by Forcepoint Email with ESMTPS id AE6114C35E40C5CE0558;
        Thu, 21 Oct 2021 20:43:08 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:43:08 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:43:08 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <lars@metafoo.de>
CC:     Cai Huoqing <caihuoqing@baidu.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: ina2xx: Avoid double reference counting from get_task_struct/put_task_struct()
Date:   Thu, 21 Oct 2021 20:42:54 +0800
Message-ID: <20211021124254.3247-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021124254.3247-1-caihuoqing@baidu.com>
References: <20211021124254.3247-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex22.internal.baidu.com (172.31.51.16) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex09_2021-10-21 20:43:08:783
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

kthread_run() and kthread_stop() already do reference
counting of the task, so remove get_task_struct/put_task_struct()
to avoid double reference counting.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/iio/adc/ina2xx-adc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 360d7a00f60d..352f27657238 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -849,7 +849,6 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 
-	get_task_struct(task);
 	chip->task = task;
 
 	return 0;
@@ -861,7 +860,6 @@ static int ina2xx_buffer_disable(struct iio_dev *indio_dev)
 
 	if (chip->task) {
 		kthread_stop(chip->task);
-		put_task_struct(chip->task);
 		chip->task = NULL;
 	}
 
-- 
2.25.1

