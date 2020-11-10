Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2B2AD7CA
	for <lists+linux-iio@lfdr.de>; Tue, 10 Nov 2020 14:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgKJNir (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Nov 2020 08:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730368AbgKJNir (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2020 08:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605015525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNvbHLjAbf6xImr5+pSF9Gq9bumXO5jypp0vQXj0tuk=;
        b=GefJlAHaji5dfcdunAC44wwdlXIwaQ4dYmeN6KvgcEf6vjoRxsfoQxKOBhmqV1VqQ1guG4
        EIPGQgFB9HqWvD6+N8Ou+rGEHwiFvKPoI2AQ6tmfJItY0wEijHa61caX9wELCDXZXnu05n
        DybFXLwYrbgqvxUrerUH758xa4pAKxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-c7ZPv4wBMLSZyZM6-mtYgg-1; Tue, 10 Nov 2020 08:38:43 -0500
X-MC-Unique: c7ZPv4wBMLSZyZM6-mtYgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95EDF8015B1;
        Tue, 10 Nov 2020 13:38:41 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-196.ams2.redhat.com [10.36.113.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4CC6115F;
        Tue, 10 Nov 2020 13:38:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org
Subject: [PATCH bugfix for 5.10 2/2] iio: accel: kxcjk1013: Add support for KIOX010A ACPI DSM for setting tablet-mode
Date:   Tue, 10 Nov 2020 14:38:35 +0100
Message-Id: <20201110133835.129080-3-hdegoede@redhat.com>
In-Reply-To: <20201110133835.129080-1-hdegoede@redhat.com>
References: <20201110133835.129080-1-hdegoede@redhat.com>
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

This notifying of the EC is problematic because sometimes the EC comes up
thinking that device is in tablet-mode and the kbd and touchpad do not
work. This happens for example on Irbis NB111 devices after a suspend /
resume cycle (after a complete battery drain / hard reset without having
booted Windows at least once). Other 2-in-1s which are likely affected
too are e.g. the Teclast F5 and F6 series.

The kxcjk-1013 driver may seem like a strange place to deal with this,
but since it is *the* driver for the ACPI KIOX010A device, it is also
the driver which has access to the ACPI handle needed by the DSM.

Add support for calling the DSM and on probe unconditionally tell the
EC that the device is laptop mode, fixing the kbd and touchpad sometimes
not working.

Reported-and-tested-by: russianneuromancer <russianneuromancer@ya.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index abeb0d254046..560a3373ff20 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -129,6 +129,7 @@ enum kx_chipset {
 enum kx_acpi_type {
 	ACPI_GENERIC,
 	ACPI_SMO8500,
+	ACPI_KIOX010A,
 };
 
 struct kxcjk1013_data {
@@ -275,6 +276,32 @@ static const struct {
 			      {19163, 1, 0},
 			      {38326, 0, 1} };
 
+#ifdef CONFIG_ACPI
+enum kiox010a_fn_index {
+	KIOX010A_SET_LAPTOP_MODE = 1,
+	KIOX010A_SET_TABLET_MODE = 2,
+};
+
+static int kiox010a_dsm(struct device *dev, int fn_index)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	guid_t kiox010a_dsm_guid;
+	union acpi_object *obj;
+
+	if (!handle)
+		return -ENODEV;
+
+	guid_parse("1f339696-d475-4e26-8cad-2e9f8e6d7a91", &kiox010a_dsm_guid);
+
+	obj = acpi_evaluate_dsm(handle, &kiox010a_dsm_guid, 1, fn_index, NULL);
+	if (!obj)
+		return -EIO;
+
+	ACPI_FREE(obj);
+	return 0;
+}
+#endif
+
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode mode)
 {
@@ -352,6 +379,13 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 {
 	int ret;
 
+#ifdef CONFIG_ACPI
+	if (data->acpi_type == ACPI_KIOX010A) {
+		/* Make sure the kbd and touchpad on 2-in-1s using 2 KXCJ91008-s work */
+		kiox010a_dsm(&data->client->dev, KIOX010A_SET_LAPTOP_MODE);
+	}
+#endif
+
 	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_WHO_AM_I);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading who_am_i\n");
@@ -1262,6 +1296,8 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 
 	if (strcmp(id->id, "SMO8500") == 0)
 		*acpi_type = ACPI_SMO8500;
+	else if (strcmp(id->id, "KIOX010A") == 0)
+		*acpi_type = ACPI_KIOX010A;
 
 	*chipset = (enum kx_chipset)id->driver_data;
 
-- 
2.28.0

