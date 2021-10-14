Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0313042D126
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJNDsD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 23:48:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28937 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNDsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 23:48:03 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HVFZ04HlNzbn5B;
        Thu, 14 Oct 2021 11:41:28 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 11:45:57 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 11:45:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <hdegoede@redhat.com>,
        <andriy.shevchenko@linux.intel.com>, <ddvlad@gmail.com>
Subject: [PATCH] iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove
Date:   Thu, 14 Oct 2021 11:53:38 +0800
Message-ID: <20211014035338.3750416-1-yangyingliang@huawei.com>
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
    [<0000000020115b9a>] i2c_device_probe+0xa31/0xbe0
    [<00000000d9f581a6>] really_probe+0x299/0xc30
    [<00000000c6c16cde>] __driver_probe_device+0x357/0x500
    [<00000000909852a1>] driver_probe_device+0x4e/0x140
    [<000000008419ba53>] __device_attach_driver+0x257/0x340
    [<00000000533bb466>] bus_for_each_drv+0x166/0x1e0
    [<000000005bf45d75>] __device_attach+0x272/0x420
    [<0000000075220311>] bus_probe_device+0x1eb/0x2a0
    [<0000000015587e85>] device_add+0xbf0/0x1f90
    [<0000000086901b9e>] i2c_new_client_device+0x622/0xb20
    [<000000000865ca18>] new_device_store+0x1fa/0x420
    [<0000000059a3d183>] dev_attr_store+0x58/0x80

Fix it by remove data->dready_trig condition in probe and remove.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a25691c1f967 ("iio: accel: kxcjk1013: allow using an external trigger")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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

