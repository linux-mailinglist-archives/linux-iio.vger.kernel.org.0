Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE1468ADE
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 13:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhLEMyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 07:54:46 -0500
Received: from www381.your-server.de ([78.46.137.84]:34072 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhLEMyq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 07:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=4B9R5aNR2+yGaeXOtdmf367NiUqTcfXZW1td1Am4Adc=; b=i7bz+hSF+K0b9nrTbpDI5U2tCM
        Qz5yZOBKSHkV+UiQsK+G1kuB9ENWIb4KUzZLwqljeInUp0PvG5AkSKoCH1qlN77f/swU6UYGI0P9E
        C8TvHg/KHIWJC5HS/nsiVqX33Zc+D+crfJtxaZLQsSN992I/XUcPJ/E8FHbhZCgHeGIiKBmPqCg85
        7AQIEk3LebRrCKkkRh9wp2UF/T1IWLQjVJ6RU20UQAV5aNvzijdF35slpg2/RgIIo3Tk5nZeWh8m2
        ll1aZRBNzAAym7L5gZ1UrBDyPzxeR+HM9c1wTYGNZX64KVH7oBB7DGb1Te0Q7J6wf+1t1Tx0dKdMB
        R3e7ERaw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mtqz8-000GvH-FP; Sun, 05 Dec 2021 13:51:18 +0100
Received: from [2001:a61:2ba4:ec01:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mtqz8-000Lj9-Ar; Sun, 05 Dec 2021 13:51:18 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: iio_device_alloc(): Remove unnecessary self drvdata
Date:   Sun,  5 Dec 2021 13:50:52 +0100
Message-Id: <20211205125052.58030-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26374/Sun Dec  5 10:24:12 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drvdata is typically used by drivers to attach driver specific data to a
device. It is used to retrieve driver specific information when only the
device to which the data is attached is available.

In the IIO core in the `iio_device_alloc()` function we call
`iio_device_set_drvdata(indio_dev, indio_dev)`. This sets the drvdata of
the IIO device to itself.

This is rather unnecessary since if we have a pointer to the IIO device to
call `iio_device_get_drvdata()` on it we don't need to call the function
since we already have the pointer. If we only have a pointer to the `struct
device` we can use `dev_to_iio_dev()` to get the IIO device from it.

Furthermore the drvdata is supposed to be reserved for drivers, so it
should not be used by the IIO core in the first place.

The `set_drvdata()` has been around from the very beginning of the IIO
framework and back then it was used in the IIO device sysfs attribute
handling code. But that was subsequently replaced with a `dev_to_iio_dev()`
in commit e53f5ac52ec1 ("iio: Use dev_to_iio_dev()") and other cleanups.

The self `set_drvdata()` is now no longer needed and can be removed.

Verified that there no longer any users by checking for potential users
using the following two coccinelle scripts and reviewing that none of the
matches are problematic code.

<smpl>
@@
struct iio_dev *iio_dev;
expression dev;
identifier fn !~ "(remove|resume|suspend)";
@@
fn(...)
{
...
*iio_dev = dev_get_drvdata(dev)
...
}
</smpl>

<smpl>
@r1@
position p;
struct iio_dev *indio_dev;
identifier dev_fn =~ "^dev_";
identifier devm_fn =~ "^devm_";
@@
(
 dev_fn
|
 devm_fn
)
 (&indio_dev@p->dev, ...)

@@
struct iio_dev *indio_dev;
position p != r1.p;
@@
*&indio_dev@p->dev</smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 20d5178ca073..409c278a4c2c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1656,7 +1656,6 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	indio_dev->dev.type = &iio_device_type;
 	indio_dev->dev.bus = &iio_bus_type;
 	device_initialize(&indio_dev->dev);
-	iio_device_set_drvdata(indio_dev, (void *)indio_dev);
 	mutex_init(&indio_dev->mlock);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
-- 
2.30.2

