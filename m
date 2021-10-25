Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01830439666
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhJYMgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 08:36:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26119 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhJYMgb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 08:36:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HdDqH4zk4z1DHlJ;
        Mon, 25 Oct 2021 20:32:11 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 20:34:04 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 20:34:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <hdegoede@redhat.com>,
        <andriy.shevchenko@linux.intel.com>, <ddvlad@gmail.com>
Subject: [PATCH v2] iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove
Date:   Mon, 25 Oct 2021 20:41:59 +0800
Message-ID: <20211025124159.2700301-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
memory leak as follows:

unreferenced object 0xffff888009551400 (size 512):
  comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
  backtrace:
    [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
    [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
    [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 [industrialio_triggered_buffer]
    [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]

Fix it by remove data->dready_trig condition in probe and remove.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a25691c1f967 ("iio: accel: kxcjk1013: allow using an external trigger")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2:
  drop some calltrace in commit message
---
 drivers/iio/accel/kxcjk-1013.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a51fdd3c9b5b..24c9387c2968 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1595,8 +1595,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	return 0;
 
 err_buffer_cleanup:
-	if (data->dready_trig)
-		iio_triggered_buffer_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
@@ -1618,8 +1617,8 @@ static int kxcjk1013_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
+	iio_triggered_buffer_cleanup(indio_dev);
 	if (data->dready_trig) {
-		iio_triggered_buffer_cleanup(indio_dev);
 		iio_trigger_unregister(data->dready_trig);
 		iio_trigger_unregister(data->motion_trig);
 	}
-- 
2.25.1

