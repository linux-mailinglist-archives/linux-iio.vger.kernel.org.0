Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81F138DBFE
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhEWRCm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhEWRCm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUY+NjeNZ6p6MVGWbR3jhaTOEQWih11tFKttqqcBq8c=;
        b=azS/8b29FOt+1Pz2TgU48GrOtoL5gKFO6oJ12etj2IJPmMyvVEi0XVz763Us6Z3j5CA3v9
        AsG7BeNA3oDLsgoiV+rcBaQNUJ/7lmDgvx0OFJenZ57bkJCRS2AZjo9E7pZrCR/kUnQWDJ
        5hz1VDmk6dQg4FXX/2wnRJ9jG9frGng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-YNtXvXAqNR-dwyuCdLS61w-1; Sun, 23 May 2021 13:01:13 -0400
X-MC-Unique: YNtXvXAqNR-dwyuCdLS61w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 606801005D50;
        Sun, 23 May 2021 17:01:12 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07F585D9F2;
        Sun, 23 May 2021 17:01:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 3/9] iio: accel: bmc150: Move check for second ACPI device into a separate function
Date:   Sun, 23 May 2021 19:00:57 +0200
Message-Id: <20210523170103.176958-4-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move the check for a second ACPI device for BOSC0200 ACPI fwnodes into
a new bmc150_acpi_dual_accel_probe() helper function.

This is a preparation patch for adding support for a new "DUAL250E" ACPI
Hardware-ID (HID) used on some devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop comma after terminating entry of bmc150_acpi_dual_accel_ids array
- Rewrap some comments at 80 chars limit
---
 drivers/iio/accel/bmc150-accel-i2c.c | 80 ++++++++++++++++++----------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 2afaae0294ee..f7cb40f481ef 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -21,6 +21,52 @@
 
 #include "bmc150-accel.h"
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
+	{"BOSC0200"},
+	{ }
+};
+
+/*
+ * Some acpi_devices describe 2 accelerometers in a single ACPI device,
+ * try instantiating a second i2c_client for an I2cSerialBusV2 ACPI resource
+ * with index 1.
+ */
+static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+	struct i2c_client *second_dev;
+	struct i2c_board_info board_info = {
+		.type = "bmc150_accel",
+		/*
+		 * The 2nd accel sits in the base of 2-in-1s. Note this name is
+		 * static, as there should never be more then 1 BOSC0200 ACPI
+		 * node with 2 accelerometers in it.
+		 */
+		.dev_name = "BOSC0200:base",
+		.fwnode = client->dev.fwnode,
+		.irq = -ENOENT,
+	};
+
+	if (acpi_match_device_ids(adev, bmc150_acpi_dual_accel_ids))
+		return;
+
+	second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
+	if (!IS_ERR(second_dev))
+		bmc150_set_second_device(client, second_dev);
+}
+
+static void bmc150_acpi_dual_accel_remove(struct i2c_client *client)
+{
+	struct i2c_client *second_dev = bmc150_get_second_device(client);
+
+	i2c_unregister_device(second_dev);
+}
+#else
+static void bmc150_acpi_dual_accel_probe(struct i2c_client *client) {}
+static void bmc150_acpi_dual_accel_remove(struct i2c_client *client) {}
+#endif
+
 static int bmc150_accel_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -30,7 +76,6 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
 		i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
-	struct acpi_device __maybe_unused *adev;
 	int ret;
 
 	regmap = devm_regmap_init_i2c(client, &bmc150_regmap_conf);
@@ -47,41 +92,18 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		return ret;
 
 	/*
-	 * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
-	 * device, try instantiating a second i2c_client for an I2cSerialBusV2
-	 * ACPI resource with index 1. The !id check avoids recursion when
-	 * bmc150_accel_probe() gets called for the second client.
+	 * The !id check avoids recursion when probe() gets called
+	 * for the second client.
 	 */
-#ifdef CONFIG_ACPI
-	adev = ACPI_COMPANION(&client->dev);
-	if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
-		struct i2c_board_info board_info = {
-			.type = "bmc150_accel",
-			/*
-			 * The 2nd accel sits in the base of 2-in-1s. Note this
-			 * name is static, as there should never be more then 1
-			 * BOSC0200 ACPI node with 2 accelerometers in it.
-			 */
-			.dev_name = "BOSC0200:base",
-			.fwnode = client->dev.fwnode,
-			.irq = -ENOENT,
-		};
-		struct i2c_client *second_dev;
-
-		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
-		if (!IS_ERR(second_dev))
-			bmc150_set_second_device(client, second_dev);
-	}
-#endif
+	if (!id && has_acpi_companion(&client->dev))
+		bmc150_acpi_dual_accel_probe(client);
 
 	return 0;
 }
 
 static int bmc150_accel_remove(struct i2c_client *client)
 {
-	struct i2c_client *second_dev = bmc150_get_second_device(client);
-
-	i2c_unregister_device(second_dev);
+	bmc150_acpi_dual_accel_remove(client);
 
 	return bmc150_accel_core_remove(&client->dev);
 }
-- 
2.31.1

