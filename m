Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2613381151
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 21:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhENUAh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 16:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbhENUAd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 16:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621022361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=idwspYAfP/cahI6Y2ph+Rv4pD/tDmCh/Nyges3RPo3E=;
        b=Ebx0j0GvzFrJNK02COMtPeEKLmSLyJ6fhDUGg8LIuahfDYKqI/S7Zkg4ig+J/mD6jSINUu
        LQt15yAn38TgdjmGvPkkVEHalgE0YpzzDvpV2zHed2ebz6tsrdgpAKy280o48tmN25qtWz
        TyGywDL64zi7YlXjhCLdyG0UjyfaYYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-zP8zQinsPvagEmTo9X_I5g-1; Fri, 14 May 2021 15:59:19 -0400
X-MC-Unique: zP8zQinsPvagEmTo9X_I5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB43B189C447;
        Fri, 14 May 2021 19:59:18 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-97.ams2.redhat.com [10.36.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 977076060F;
        Fri, 14 May 2021 19:59:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: Fix BUG() on rmmod of iio-drivers caused by double list_del()
Date:   Fri, 14 May 2021 21:59:16 +0200
Message-Id: <20210514195916.44232-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Removing an iio-driver module (or unbinding the driver) causes a BUG() to
trigger when the kernel is build with list-debugging enabled. This is
caused by a double list_del() introduced by commit 8dedcc3eee3a ("iio:
core: centralize ioctl() calls to the main chardev").

This patch introduces an ioctl_handlers list to which ioctl handlers are
added. The cleanup of these however happens twice.

The 2 registration functions:
iio_device_ioctl_handler_register()
iio_device_register_eventset()

Have matching unregister functions which do a list_del on the head added
to the list; and iio_device_unregister() has:

    list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
        list_del(&h->entry);

This is a problem because iio_device_unregister() does this before calling
iio_buffers_free_sysfs_and_mask() which calls
iio_device_ioctl_handler_unregister() which calls list_del on the entry
added by iio_buffers_alloc_sysfs_and_mask() a second time causing this:

[root@fedora ~]# rmmod bmc150_accel_i2c
Segmentation fault

[  160.627546] ------------[ cut here ]------------
[  160.627549] kernel BUG at lib/list_debug.c:45!
[  160.629125] invalid opcode: 0000 [#1] SMP PTI
[  160.629140] CPU: 0 PID: 1139 Comm: rmmod Tainted: G            E     5.13.0-rc1+ #341
[  160.629146] Hardware name: LENOVO 80M1/Mini, BIOS C7CN31WW 08/05/2016
[  160.629149] RIP: 0010:__list_del_entry_valid.cold+0xf/0x47
...
[  160.629202] Call Trace:
[  160.629209]  iio_device_ioctl_handler_unregister+0xe/0x90 [industrialio]
[  160.629226]  iio_device_unregister_trigger_consumer+0x21d/0x2f0 [industrialio]
[  160.629239]  bmc150_accel_core_remove+0x20/0xd0 [bmc150_accel_core]
[  160.629246]  i2c_device_remove+0x25/0xb0
[  160.629254]  __device_release_driver+0x180/0x240
[  160.629261]  device_release_driver+0x26/0x40
[  160.629267]  bus_remove_device+0xf2/0x160
[  160.629272]  device_del+0x18c/0x3e0
[  160.629280]  device_unregister+0x16/0x60
...

Since iio_device_ioctl_handler_unregister/iio_device_unregister_eventset()
already do the list_del() there is no need for the
list_for_each_entry_safe() in iio_device_unregister() which also does the
list_del(). Remove the list_for_each_entry_safe() to fix the double
list_del() issue.

Fixes: 8dedcc3eee3a ("iio: core: centralize ioctl() calls to the main chardev")
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/industrialio-core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d92c58a94fe4..9e59f5da3d28 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1926,9 +1926,6 @@ EXPORT_SYMBOL(__iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_ioctl_handler *h, *t;
-
 	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
 
 	mutex_lock(&indio_dev->info_exist_lock);
@@ -1939,9 +1936,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	indio_dev->info = NULL;
 
-	list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
-		list_del(&h->entry);
-
 	iio_device_wakeup_eventset(indio_dev);
 	iio_buffer_wakeup_poll(indio_dev);
 
-- 
2.31.1

