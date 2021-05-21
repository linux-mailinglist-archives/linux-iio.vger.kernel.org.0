Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7638CBAF
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhEURPu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 May 2021 13:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhEURPt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 May 2021 13:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621617266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCRp+M6BmquOFM43iImL6UjJTcvuKJRir6amhOD9dvE=;
        b=PDZzW6Jj2Ekzpy8WkrpoLu2AwtnQT0zD6NCSYcUNQAiyrRbEhfWXxW9jrXhTG5bHtlic29
        Ty4dK3CBVp1WhSOF9IAE14AyKSlHNZ7g6V4K1QhNrXkznsfEMeCSR3UpzfZgJz7ty1UHVv
        5CRQJy3tHAEFZVjCKjwob0Qa0JyK8Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-fNc60ldnPXanf4FEnSTnNA-1; Fri, 21 May 2021 13:14:24 -0400
X-MC-Unique: fNc60ldnPXanf4FEnSTnNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD20107ACC7;
        Fri, 21 May 2021 17:14:23 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-187.ams2.redhat.com [10.36.114.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1AC41001B2C;
        Fri, 21 May 2021 17:14:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: [PATCH 1/8] iio: accel: bmc150: Fix dereferencing the wrong pointer in bmc150_get/set_second_device
Date:   Fri, 21 May 2021 19:14:11 +0200
Message-Id: <20210521171418.393871-2-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-1-hdegoede@redhat.com>
References: <20210521171418.393871-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The drvdata for iio-parent devices points to the struct iio_dev for
the iio-device. So by directly casting the return from i2c_get_clientdata()
to struct bmc150_accel_data * the code was ending up storing the second_dev
pointer in (and retrieving it from) some semi-random offset inside
struct iio_dev, rather then storing it in the second_dev member of the
bmc150_accel_data struct.

Fix the code to get the struct bmc150_accel_data * pointer to call
iio_priv() on the struct iio_dev * returned by i2c_get_clientdata(),
so that the correct pointer gets dereferenced.

This fixes the following oops on rmmod, caused by trying to
dereference the wrong return of bmc150_get_second_device():

[  238.980737] BUG: unable to handle page fault for address: 0000000000004710
[  238.980755] #PF: supervisor read access in kernel mode
[  238.980760] #PF: error_code(0x0000) - not-present page
...
[  238.980841]  i2c_unregister_device.part.0+0x19/0x60
[  238.980856]  0xffffffffc0815016
[  238.980863]  i2c_device_remove+0x25/0xb0
[  238.980869]  __device_release_driver+0x180/0x240
[  238.980876]  driver_detach+0xd4/0x120
[  238.980882]  bus_remove_driver+0x5b/0xd0
[  238.980888]  i2c_del_driver+0x44/0x70

While at it also remove the now no longer sensible checks for data
being NULL, iio_priv never returns NULL for an iio_dev with non 0
sized private-data.

Fixes: 5bfb3a4bd8f6 ("iio: accel: bmc150: Check for a second ACPI device for BOSC0200")
Cc: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 04d85ce34e9f..3a3f67930165 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1809,10 +1809,7 @@ EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
 
 struct i2c_client *bmc150_get_second_device(struct i2c_client *client)
 {
-	struct bmc150_accel_data *data = i2c_get_clientdata(client);
-
-	if (!data)
-		return NULL;
+	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
 
 	return data->second_device;
 }
@@ -1820,10 +1817,9 @@ EXPORT_SYMBOL_GPL(bmc150_get_second_device);
 
 void bmc150_set_second_device(struct i2c_client *client)
 {
-	struct bmc150_accel_data *data = i2c_get_clientdata(client);
+	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
 
-	if (data)
-		data->second_device = client;
+	data->second_device = client;
 }
 EXPORT_SYMBOL_GPL(bmc150_set_second_device);
 
-- 
2.31.1

