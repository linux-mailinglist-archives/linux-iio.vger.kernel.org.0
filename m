Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D97428D74
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhJKNCH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 09:02:07 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24240 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhJKNCH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 09:02:07 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSf4f0N7tz8tXR;
        Mon, 11 Oct 2021 20:58:58 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 11
 Oct 2021 21:00:02 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] iio: buffer: Check the return value of kstrdup_const()
Date:   Mon, 11 Oct 2021 12:58:46 +0000
Message-ID: <20211011125846.66553-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We should check the duplication of attr.name properly in
iio_buffer_wrap_attr() or a null-pointer-dereference would
occur on destroying the related sysfs file.
This issue is found by fault-injection.

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
RIP: 0010:strlen+0x0/0x20
Call Trace:
 kernfs_name_hash+0x1c/0xb0
 kernfs_find_ns+0xc6/0x160
 kernfs_remove_by_name_ns+0x5c/0xb0
 remove_files.isra.1+0x42/0x90
 internal_create_group+0x42f/0x460
 internal_create_groups+0x49/0xc0
 device_add+0xb5b/0xbe0
 ? kobject_get+0x90/0xa0
 cdev_device_add+0x2b/0x90
 __iio_device_register+0xa56/0xb40

Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
Reported-by: Hulk Robot<hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c648e9553edd..f4011c477bac 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1312,6 +1312,8 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
 	iio_attr->buffer = buffer;
 	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
 	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
+	if (!iio_attr->dev_attr.attr.name)
+		return NULL;
 	sysfs_attr_init(&iio_attr->dev_attr.attr);
 
 	list_add(&iio_attr->l, &buffer->buffer_attr_list);
-- 
2.17.1

