Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7162C3B6A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 09:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgKYIy5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 03:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgKYIy5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 03:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606294495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=war4IEWvFUi6mVW3GEBzTd0XmPNiB2wFCGFAfo9uSnY=;
        b=Cx4Xwa0/vwrfuB2NWjuC0yprYcBZm0Oq/F77we4Rr8W49E+XB7juLgOWNXJB7MQ2hW/laQ
        fLc9vnlVs/5MZpkN25pp31BcJHeUE2yTu6hQHQZlsFQocFfwneJm9+N0hx/Zw2jqKadoOC
        QzB4kdPho+ieLVcMAgnAmDHxW4ETh7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-UXm9bcKlPPG-r-4mN58zHg-1; Wed, 25 Nov 2020 03:54:51 -0500
X-MC-Unique: UXm9bcKlPPG-r-4mN58zHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 843561015C84;
        Wed, 25 Nov 2020 08:54:49 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-185.ams2.redhat.com [10.36.114.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 130535CC1F;
        Wed, 25 Nov 2020 08:54:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        russianneuromancer <russianneuromancer@ya.ru>
Subject: [PATCH] iio: accel: kxcjk1013: Add tablet_mode sysfs file for exercising the KIOX010A ACPI DSM
Date:   Wed, 25 Nov 2020 09:54:44 +0100
Message-Id: <20201125085444.11593-2-hdegoede@redhat.com>
In-Reply-To: <20201125085444.11593-1-hdegoede@redhat.com>
References: <20201125085444.11593-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
to allow the OS to determine the angle between the display and the base
of the device, so that the OS can determine if the 2-in-1 is in laptop
or in tablet-mode.

On Windows both accelerometers are read by a special HingeAngleService
process; and this process calls a DSM (Device Specific Method) on the
ACPI KIOX010A device node for the sensor in the display, to let the
embedded-controller (EC) know about the mode so that it can disable the
kbd and touchpad to avoid spurious input while folded into tablet-mode.

Currently the kxcjk1013 driver calls the DSM for this once at probe time
to ensure that the builtin kbd and touchpad work.

But some users have expressed interest in using this functionality to
disable the kbd and touchpad when folded into tablet-mode as done under
Windows.

Add a tablet_mode sysfs file so that users can control the kbd/touchpad
enable/disable functionality from user-space.

Reported-by: russianneuromancer <russianneuromancer@ya.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 560a3373ff20..f15946d87c3c 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -150,6 +150,7 @@ struct kxcjk1013_data {
 	int64_t timestamp;
 	enum kx_chipset chipset;
 	enum kx_acpi_type acpi_type;
+	bool tablet_mode;
 };
 
 enum kxcjk1013_axis {
@@ -300,6 +301,50 @@ static int kiox010a_dsm(struct device *dev, int fn_index)
 	ACPI_FREE(obj);
 	return 0;
 }
+
+static ssize_t tablet_mode_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->tablet_mode);
+}
+
+static ssize_t tablet_mode_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	unsigned long tablet_mode;
+	int err;
+
+	err = kstrtoul(buf, 0, &tablet_mode);
+	if (err)
+		return err;
+
+	err = kiox010a_dsm(&data->client->dev,
+			   tablet_mode ? KIOX010A_SET_TABLET_MODE :
+					 KIOX010A_SET_LAPTOP_MODE);
+	if (err)
+		return err;
+
+	data->tablet_mode = tablet_mode;
+	return len;
+}
+
+static DEVICE_ATTR_RW(tablet_mode);
+
+static struct attribute *tablet_mode_attrs[] = {
+	&dev_attr_tablet_mode.attr,
+	NULL
+};
+
+static const struct attribute_group tablet_mode_attrs_group = {
+	.attrs = tablet_mode_attrs,
+};
 #endif
 
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
@@ -383,6 +428,10 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	if (data->acpi_type == ACPI_KIOX010A) {
 		/* Make sure the kbd and touchpad on 2-in-1s using 2 KXCJ91008-s work */
 		kiox010a_dsm(&data->client->dev, KIOX010A_SET_LAPTOP_MODE);
+
+		ret = devm_device_add_group(&data->client->dev, &tablet_mode_attrs_group);
+		if (ret < 0)
+			dev_warn(&data->client->dev, "Error creating tablet_mode sysfs attribute\n");
 	}
 #endif
 
-- 
2.28.0

