Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A32C3B2F
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgKYIgf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 03:36:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKYIge (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 03:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606293392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5GM97dKeR9r7f0v2dh4w8NDe0CvyAP23VY4gT54TVw=;
        b=hsnY18MKZnDpT1+7sqgjqWkzKCZg+Q5lUnb+/vY3yIE0O4C/ntpey/3jl+Ab/fbFFqWTR+
        604qP7FeFlqfoAm2LGEZYL0cyKH0rv3o2l9gWWDf5hpDcQ1U0Le+lVaT5sWGwPLhgcyT8G
        iaU1Pi3Zwau+2VbbZGgia+uYeeOJrfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-bLTzH7YrOj6rgE3SwSFQ9A-1; Wed, 25 Nov 2020 03:36:28 -0500
X-MC-Unique: bLTzH7YrOj6rgE3SwSFQ9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E16E3107ACFB;
        Wed, 25 Nov 2020 08:36:26 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-185.ams2.redhat.com [10.36.114.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B905C1A1;
        Wed, 25 Nov 2020 08:36:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH 2/3] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
Date:   Wed, 25 Nov 2020 09:36:17 +0100
Message-Id: <20201125083618.10989-3-hdegoede@redhat.com>
In-Reply-To: <20201125083618.10989-1-hdegoede@redhat.com>
References: <20201125083618.10989-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
device. Normally we would handle this by letting the special
drivers/platform/x86/i2c-multi-instantiate.c driver handle the BOSC0200
ACPI id and let it instantiate 2 bmc150_accel type i2c_client-s for us.

But doing so changes the modalias for the first accelerometer
(which is already supported and used on many devices) from
acpi:BOSC0200 to i2c:bmc150_accel. The modalias is not only used
to load the driver, but is also used by hwdb matches in
/lib/udev/hwdb.d/60-sensor.hwdb which provide a mountmatrix to
userspace by setting the ACCEL_MOUNT_MATRIX udev property.

Switching the handling of the BOSC0200 over to i2c-multi-instantiate.c
will break the hwdb matches causing the ACCEL_MOUNT_MATRIX udev prop
to no longer be set. So switching over to i2c-multi-instantiate.c is
not an option.

Changes by Hans de Goede:
-Add explanation to the commit message why i2c-multi-instantiate.c
 cannot be used
-Also set the dev_name, fwnode and irq i2c_board_info struct members
 for the 2nd client

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=198671
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 21 ++++++++++++++++
 drivers/iio/accel/bmc150-accel-i2c.c  | 35 +++++++++++++++++++++++++--
 drivers/iio/accel/bmc150-accel.h      |  2 ++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 088716d55855..2976aefad89b 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -203,6 +203,7 @@ struct bmc150_accel_data {
 	int ev_enable_state;
 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	const struct bmc150_accel_chip_info *chip_info;
+	struct i2c_client *second_device;
 	struct iio_mount_matrix orientation;
 };
 
@@ -1659,6 +1660,26 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 }
 EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
 
+struct i2c_client *bmc150_get_second_device(struct i2c_client *client)
+{
+	struct bmc150_accel_data *data = i2c_get_clientdata(client);
+
+	if (!data)
+		return NULL;
+
+	return data->second_device;
+}
+EXPORT_SYMBOL_GPL(bmc150_get_second_device);
+
+void bmc150_set_second_device(struct i2c_client *client)
+{
+	struct bmc150_accel_data *data = i2c_get_clientdata(client);
+
+	if (data)
+		data->second_device = client;
+}
+EXPORT_SYMBOL_GPL(bmc150_set_second_device);
+
 int bmc150_accel_core_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 06021c8685a7..117184159bb6 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -29,6 +29,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
 		i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+	int ret;
 
 	regmap = devm_regmap_init_i2c(client, &bmc150_regmap_conf);
 	if (IS_ERR(regmap)) {
@@ -39,12 +41,41 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	if (id)
 		name = id->name;
 
-	return bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
-				       block_supported);
+	ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq, name, block_supported);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
+	 * device, try instantiating a second i2c_client for an I2cSerialBusV2
+	 * ACPI resource with index 1. The !id check avoids recursion when
+	 * bmc150_accel_probe() gets called for the second client.
+	 */
+	if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
+		struct i2c_board_info board_info = {
+			.type = "bmc150_accel",
+			/* The 2nd accel sits in the base of 2-in-1s */
+			.dev_name = "BOSC0200:base",
+			.fwnode = client->dev.fwnode,
+			.irq = -ENOENT,
+		};
+		struct i2c_client *second_dev;
+
+		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
+		if (!IS_ERR(second_dev))
+			bmc150_set_second_device(second_dev);
+	}
+
+	return 0;
 }
 
 static int bmc150_accel_remove(struct i2c_client *client)
 {
+	struct i2c_client *second_dev = bmc150_get_second_device(client);
+
+	if (second_dev)
+		i2c_unregister_device(second_dev);
+
 	return bmc150_accel_core_remove(&client->dev);
 }
 
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index ae6118ae11b1..6e965a3ca322 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -16,6 +16,8 @@ enum {
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported);
 int bmc150_accel_core_remove(struct device *dev);
+struct i2c_client *bmc150_get_second_device(struct i2c_client *second_device);
+void bmc150_set_second_device(struct i2c_client *second_device);
 extern const struct dev_pm_ops bmc150_accel_pm_ops;
 extern const struct regmap_config bmc150_regmap_conf;
 
-- 
2.28.0

