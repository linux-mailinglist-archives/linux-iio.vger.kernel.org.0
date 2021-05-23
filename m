Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223738DBFD
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhEWRCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhEWRCj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aC2btrd0oAiIt2nxc3OcNaXdUe09FXy+FKy/oiXFHAM=;
        b=HEC/3elwyE5NRVUb5jnQVRxt28Nf34A+/ZcG0buGg6VOtru27rfFpm72+vdHY+QN+dMNlj
        z5RgOcSDLWzQncd3yuFV7F5JoM1h0ObsOA1vdzei7qN8iikBtImI7HdVAEnWpyMlke82hf
        QW9GdxsWUqV2/sO6iQ9opPr8psEe6Zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-w-fVWVS_PqGx4mnX6Dy8ow-1; Sun, 23 May 2021 13:01:09 -0400
X-MC-Unique: w-fVWVS_PqGx4mnX6Dy8ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B676F1854E2B;
        Sun, 23 May 2021 17:01:08 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8580D5D9F2;
        Sun, 23 May 2021 17:01:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 2/9] iio: accel: bmc150: Don't make the remove function of the second accelerometer unregister itself
Date:   Sun, 23 May 2021 19:00:56 +0200
Message-Id: <20210523170103.176958-3-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On machines with dual accelerometers described in a single ACPI fwnode,
the bmc150_accel_probe() instantiates a second i2c-client for the second
accelerometer.

A pointer to this manually instantiated second i2c-client is stored
inside the iio_dev's private-data through bmc150_set_second_device(),
so that the i2c-client can be unregistered from bmc150_accel_remove().

Before this commit bmc150_set_second_device() took only 1 argument so it
would store the pointer in private-data of the iio_dev belonging to the
manually instantiated i2c-client, leading to the bmc150_accel_remove()
call for the second_dev trying to unregister *itself* while it was
being removed, leading to a deadlock and rmmod hanging.

Change bmc150_set_second_device() to take 2 arguments: 1. The i2c-client
which is instantiating the second i2c-client for the 2nd accelerometer and
2. The second-device pointer itself (which also is an i2c-client).

This will store the second_device pointer in the private data of the
iio_dev belonging to the (ACPI instantiated) i2c-client for the first
accelerometer and will make bmc150_accel_remove() unregister the
second_device i2c-client when called for the first client,
avoiding the deadlock.

Fixes: 5bfb3a4bd8f6 ("iio: accel: bmc150: Check for a second ACPI device for BOSC0200")
Cc: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 4 ++--
 drivers/iio/accel/bmc150-accel-i2c.c  | 2 +-
 drivers/iio/accel/bmc150-accel.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 3a3f67930165..8ff358c37a81 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1815,11 +1815,11 @@ struct i2c_client *bmc150_get_second_device(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(bmc150_get_second_device);
 
-void bmc150_set_second_device(struct i2c_client *client)
+void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
 
-	data->second_device = client;
+	data->second_device = second_dev;
 }
 EXPORT_SYMBOL_GPL(bmc150_set_second_device);
 
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 69f709319484..2afaae0294ee 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -70,7 +70,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 
 		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
 		if (!IS_ERR(second_dev))
-			bmc150_set_second_device(second_dev);
+			bmc150_set_second_device(client, second_dev);
 	}
 #endif
 
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 6024f15b9700..e30c1698f6fb 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -18,7 +18,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported);
 int bmc150_accel_core_remove(struct device *dev);
 struct i2c_client *bmc150_get_second_device(struct i2c_client *second_device);
-void bmc150_set_second_device(struct i2c_client *second_device);
+void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev);
 extern const struct dev_pm_ops bmc150_accel_pm_ops;
 extern const struct regmap_config bmc150_regmap_conf;
 
-- 
2.31.1

