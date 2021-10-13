Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7C42B3E2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 05:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhJMD7K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 23:59:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28924 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhJMD7J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 23:59:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTdsK5XDpzbn0Z;
        Wed, 13 Oct 2021 11:52:37 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:57:05 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 11:57:05 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <ardeleanalex@gmail.com>
Subject: [PATCH] iio: buffer: check return value of kstrdup_const()
Date:   Wed, 13 Oct 2021 12:04:38 +0800
Message-ID: <20211013040438.1689277-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check return value of kstrdup_const() in iio_buffer_wrap_attr(),
or it will cause null-ptr-deref in kernfs_name_hash() when calling
device_add() as follows:

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:strlen+0x0/0x20
Call Trace:
 kernfs_name_hash+0x22/0x110
 kernfs_find_ns+0x11d/0x390
 kernfs_remove_by_name_ns+0x3b/0xb0
 remove_files.isra.1+0x7b/0x190
 internal_create_group+0x7f1/0xbb0
 internal_create_groups+0xa3/0x150
 device_add+0x8f0/0x2020
 cdev_device_add+0xc3/0x160
 __iio_device_register+0x1427/0x1b40 [industrialio]
 __devm_iio_device_register+0x22/0x80 [industrialio]
 adjd_s311_probe+0x195/0x200 [adjd_s311]
 i2c_device_probe+0xa07/0xbb0

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5f4bd0b73d03..547a92d469ae 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1312,6 +1312,11 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
 	iio_attr->buffer = buffer;
 	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
 	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
+	if (!iio_attr->dev_attr.attr.name) {
+		kfree(iio_attr);
+		return NULL;
+	}
+
 	sysfs_attr_init(&iio_attr->dev_attr.attr);
 
 	list_add(&iio_attr->l, &buffer->buffer_attr_list);
-- 
2.25.1

