Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1038DC00
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhEWRCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231888AbhEWRCq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSI/hOZ1n2CX6Brf/yc/ju5IVrcVIin2jwEDPnwIiBM=;
        b=Snai4v+kN2vLXzCqwAbSaPps2Yyluxxu2e9iyoylINUKVoCA2KVcX6ptxl6IsmkzmhrPST
        DFOr2xTDANsn7MnPLB4iIMBx+3hOuscrTsMID08OtAEFXgQeH50GYdtBrJR+s4pQjwgcP3
        VKaMvwiFIGVCNa/SlcIJA1dkypQBbDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-yLr5-P3XOIqeFGSbvUTgPw-1; Sun, 23 May 2021 13:01:18 -0400
X-MC-Unique: yLr5-P3XOIqeFGSbvUTgPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8CE11005D5B;
        Sun, 23 May 2021 17:01:16 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A78725D9F2;
        Sun, 23 May 2021 17:01:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 6/9] iio: accel: bmc150: Remove bmc150_set/get_second_device() accessor functions
Date:   Sun, 23 May 2021 19:01:00 +0200
Message-Id: <20210523170103.176958-7-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that the definition of the bmc150_accel_data struct is no longer
private to bmc150-accel-core.c, bmc150-accel-i2c.c can simply directly
access the second_dev member and the accessor functions are no longer
necessary.

Note if the i2c_acpi_new_device() for the second-client now fails,
an ERR_PTR gets stored in data->second_dev this is fine since it is only
ever passed to i2c_unregister_device() which has an IS_ERR_OR_NULL() check.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 16 ----------------
 drivers/iio/accel/bmc150-accel-i2c.c  | 10 ++++------
 drivers/iio/accel/bmc150-accel.h      |  2 --
 3 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 0d76df9e08eb..0291512648b2 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1754,22 +1754,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 }
 EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
 
-struct i2c_client *bmc150_get_second_device(struct i2c_client *client)
-{
-	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
-
-	return data->second_device;
-}
-EXPORT_SYMBOL_GPL(bmc150_get_second_device);
-
-void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev)
-{
-	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
-
-	data->second_device = second_dev;
-}
-EXPORT_SYMBOL_GPL(bmc150_set_second_device);
-
 int bmc150_accel_core_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 41b4c9e22d60..ab0cda8ff8fa 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -35,8 +35,8 @@ static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
  */
 static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
 {
+	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
-	struct i2c_client *second_dev;
 	char dev_name[16];
 	struct i2c_board_info board_info = {
 		.type = "bmc150_accel",
@@ -55,16 +55,14 @@ static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
 
 	board_info.irq = acpi_dev_gpio_irq_get(adev, 1);
 
-	second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
-	if (!IS_ERR(second_dev))
-		bmc150_set_second_device(client, second_dev);
+	data->second_device = i2c_acpi_new_device(&client->dev, 1, &board_info);
 }
 
 static void bmc150_acpi_dual_accel_remove(struct i2c_client *client)
 {
-	struct i2c_client *second_dev = bmc150_get_second_device(client);
+	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
 
-	i2c_unregister_device(second_dev);
+	i2c_unregister_device(data->second_device);
 }
 #else
 static void bmc150_acpi_dual_accel_probe(struct i2c_client *client) {}
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index f503c5b5801e..5da6fd32bac5 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -78,8 +78,6 @@ enum {
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported);
 int bmc150_accel_core_remove(struct device *dev);
-struct i2c_client *bmc150_get_second_device(struct i2c_client *second_device);
-void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev);
 extern const struct dev_pm_ops bmc150_accel_pm_ops;
 extern const struct regmap_config bmc150_regmap_conf;
 
-- 
2.31.1

