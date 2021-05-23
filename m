Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972EC38DC03
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhEWRCu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231888AbhEWRCu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9eMxmqIQHPu9Sr08C03Mg0Kwzg4yh6JIlMRql0aVXE=;
        b=Zmi5RsvwKYkDzsDRUqknYVBa5vl4cNXAzvOxPYefGiD6qyzchEorSlvXj2rhbKFpCAuo0N
        Dg/67JUv2ggP0lS4kIYkWdJ/T+zlpe5CC8IfJBN6umzb1FSXcVwelGV8PiCw3k66r0x9rR
        S7jJOH+zMesVMIinoFp0fdYZLmO42TA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-X5CzOfSBPVmcQhXesB60Tw-1; Sun, 23 May 2021 13:01:19 -0400
X-MC-Unique: X5CzOfSBPVmcQhXesB60Tw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E8A0501E0;
        Sun, 23 May 2021 17:01:18 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A04F5D9F2;
        Sun, 23 May 2021 17:01:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 7/9] iio: accel: bmc150: Add support for DUAL250E ACPI DSM for setting the hinge angle
Date:   Sun, 23 May 2021 19:01:01 +0200
Message-Id: <20210523170103.176958-8-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
to allow the OS to determine the angle between the display and the base
of the device, so that the OS can determine if the 2-in-1 is in laptop
or in tablet-mode.

On Windows both accelerometers are read (polled) by a special service
and this service calls the DSM (Device Specific Method), which in turn
translates the angles to one of laptop/tablet/tent/stand mode and then
notifies the EC about the new mode and the EC then enables or disables
the builtin keyboard and touchpad based in the mode.

When the 2-in-1 is powered-on or resumed folded in tablet mode the
EC senses this independent of the DSM by using a HALL effect sensor
which senses that the keyboard has been folded away behind the display.

At power-on or resume the EC disables the keyboard based on this and
the only way to get the keyboard to work after this is to call the
DSM to re-enable it.

Call the DSM on probe() and resume() to fix the keyboard not working
when powered-on / resumed in tablet-mode.

This patch was developed and tested on a Lenovo Yoga 300-IBR.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use acpi_dev_hid_uid_match() to check that we are dealing with a
  "DUAL250E" device in bmc150_acpi_set_angle_dsm()
- Rewrap some comments at 80 chars limit
---
 drivers/iio/accel/bmc150-accel-core.c |   3 +
 drivers/iio/accel/bmc150-accel-i2c.c  | 110 ++++++++++++++++++++++++++
 drivers/iio/accel/bmc150-accel.h      |   3 +
 3 files changed, 116 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 0291512648b2..932007895f18 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1803,6 +1803,9 @@ static int bmc150_accel_resume(struct device *dev)
 	bmc150_accel_fifo_set_mode(data);
 	mutex_unlock(&data->mutex);
 
+	if (data->resume_callback)
+		data->resume_callback(dev);
+
 	return 0;
 }
 #endif
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index ab0cda8ff8fa..d34dddb850d9 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -28,6 +28,108 @@ static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
 	{ }
 };
 
+/*
+ * The DUAL250E ACPI device for 360° hinges type 2-in-1s with 1 accelerometer
+ * in the display and 1 in the hinge has an ACPI-method (DSM) to tell the
+ * ACPI code about the angle between the 2 halves. This will make the ACPI
+ * code enable/disable the keyboard and touchpad. We need to call this to avoid
+ * the keyboard being disabled when the 2-in-1 is turned-on or resumed while
+ * fully folded into tablet mode (which gets detected with a HALL-sensor).
+ * If we don't call this then the keyboard won't work even when the 2-in-1 is
+ * changed to be used in laptop mode after the power-on / resume.
+ *
+ * This DSM takes 2 angles, selected by setting aux0 to 0 or 1, these presumably
+ * define the angle between the gravity vector measured by the accelerometer in
+ * the display (aux0=0) resp. the base (aux0=1) and some reference vector.
+ * The 2 angles get subtracted from each other so the reference vector does
+ * not matter and we can simply leave the second angle at 0.
+ */
+
+#define BMC150_DSM_GUID				"7681541e-8827-4239-8d9d-36be7fe12542"
+#define DUAL250E_SET_ANGLE_FN_INDEX		3
+
+struct dual250e_set_angle_args {
+	u32 aux0;
+	u32 ang0;
+	u32 rawx;
+	u32 rawy;
+	u32 rawz;
+} __packed;
+
+static bool bmc150_acpi_set_angle_dsm(struct i2c_client *client, u32 aux0, u32 ang0)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+	struct dual250e_set_angle_args args = {
+		.aux0 = aux0,
+		.ang0 = ang0,
+	};
+	union acpi_object args_obj, *obj;
+	guid_t guid;
+
+	if (!acpi_dev_hid_uid_match(adev, "DUAL250E", NULL))
+		return false;
+
+	guid_parse(BMC150_DSM_GUID, &guid);
+
+	if (!acpi_check_dsm(adev->handle, &guid, 0, BIT(DUAL250E_SET_ANGLE_FN_INDEX)))
+		return false;
+
+	/*
+	 * Note this triggers the following warning:
+	 * "ACPI Warning: \_SB.PCI0.I2C2.ACC1._DSM: Argument #4 type mismatch -
+	 *                Found [Buffer], ACPI requires [Package]"
+	 * This is unavoidable since the _DSM implementation expects a "naked"
+	 * buffer, so wrapping it in a package will _not_ work.
+	 */
+	args_obj.type = ACPI_TYPE_BUFFER;
+	args_obj.buffer.length = sizeof(args);
+	args_obj.buffer.pointer = (u8 *)&args;
+
+	obj = acpi_evaluate_dsm(adev->handle, &guid, 0, DUAL250E_SET_ANGLE_FN_INDEX, &args_obj);
+	if (!obj) {
+		dev_err(&client->dev, "Failed to call DSM to enable keyboard and touchpad\n");
+		return false;
+	}
+
+	ACPI_FREE(obj);
+	return true;
+}
+
+static bool bmc150_acpi_enable_keyboard(struct i2c_client *client)
+{
+	/*
+	 * The EC must see a change for it to re-enable the kbd, so first
+	 * set the angle to 270° (tent/stand mode) and then change it to
+	 * 90° (laptop mode).
+	 */
+	if (!bmc150_acpi_set_angle_dsm(client, 0, 270))
+		return false;
+
+	/* The EC needs some time to notice the angle being changed */
+	msleep(100);
+
+	return bmc150_acpi_set_angle_dsm(client, 0, 90);
+}
+
+static void bmc150_acpi_resume_work(struct work_struct *work)
+{
+	struct bmc150_accel_data *data =
+		container_of(work, struct bmc150_accel_data, resume_work.work);
+
+	bmc150_acpi_enable_keyboard(data->second_device);
+}
+
+static void bmc150_acpi_resume_handler(struct device *dev)
+{
+	struct bmc150_accel_data *data = iio_priv(dev_get_drvdata(dev));
+
+	/*
+	 * Delay the bmc150_acpi_enable_keyboard() call till after the system
+	 * resume has completed, otherwise it will not work.
+	 */
+	schedule_delayed_work(&data->resume_work, msecs_to_jiffies(1000));
+}
+
 /*
  * Some acpi_devices describe 2 accelerometers in a single ACPI device,
  * try instantiating a second i2c_client for an I2cSerialBusV2 ACPI resource
@@ -56,12 +158,20 @@ static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
 	board_info.irq = acpi_dev_gpio_irq_get(adev, 1);
 
 	data->second_device = i2c_acpi_new_device(&client->dev, 1, &board_info);
+
+	if (!IS_ERR(data->second_device) && bmc150_acpi_enable_keyboard(data->second_device)) {
+		INIT_DELAYED_WORK(&data->resume_work, bmc150_acpi_resume_work);
+		data->resume_callback = bmc150_acpi_resume_handler;
+	}
 }
 
 static void bmc150_acpi_dual_accel_remove(struct i2c_client *client)
 {
 	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
 
+	if (data->resume_callback)
+		cancel_delayed_work_sync(&data->resume_work);
+
 	i2c_unregister_device(data->second_device);
 }
 #else
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 5da6fd32bac5..d67d6ed6ae77 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -6,6 +6,7 @@
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 
 struct regmap;
 struct i2c_client;
@@ -62,6 +63,8 @@ struct bmc150_accel_data {
 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	const struct bmc150_accel_chip_info *chip_info;
 	struct i2c_client *second_device;
+	void (*resume_callback)(struct device *dev);
+	struct delayed_work resume_work;
 	struct iio_mount_matrix orientation;
 };
 
-- 
2.31.1

