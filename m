Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547A51B8F50
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDZLDx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 07:03:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbgDZLDO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 07:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587898992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXLiQJEgJIAZ33GQH+ZdeDYQB6EWJcpn8dhyOK+F2yU=;
        b=i+g+pBn7CWTKrX+vlhCko8aYj7JHuaH7t4/iBLKfEKrL0ncNqhZZrJt+LxwpBfp9nldeV5
        BlWymd5+HwN4I17H+PLF2sKyHN6BVhOPOiOPCYjNvgFa0P2LPdEmGjLaX1FhK5cfF7tOq0
        Syqogiqo5dLVBgSe8UkdxJos7M9OZAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-cHT5LGLVPTyxdpjYYHWR9w-1; Sun, 26 Apr 2020 07:03:10 -0400
X-MC-Unique: cHT5LGLVPTyxdpjYYHWR9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73D3839380;
        Sun, 26 Apr 2020 11:03:08 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A0E10013A1;
        Sun, 26 Apr 2020 11:03:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/8] iio: light: cm32181: Handle ACPI instantiating a cm32181 client on the SMBus ARA
Date:   Sun, 26 Apr 2020 13:02:51 +0200
Message-Id: <20200426110256.218186-3-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-1-hdegoede@redhat.com>
References: <20200426110256.218186-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some ACPI systems list 2 I2C resources for the CM3218 sensor. On these
systems the first I2cSerialBus ACPI-resource points to the SMBus Alert
Response Address (ARA, 0x0c) and the second I2cSerialBus ACPI-resource
points to the actual CM3218 sensor address.

From the ACPI/x86 side devices with more then 1 I2cSerialBus ACPI-resourc=
e
are handled by the drivers/platform/x86/i2c-multi-instantiate.c code.
This code will instantiate "cm32181" i2c_client-s for both resources.

Add a check to cm32181_probe() for the client's address being the ARA
address, and in that case fail the probe with -ENODEV.

On these ACPI systems the sensor may have a SMBus Alert asserted at boot,
if this is the case the sensor will not respond to any i2c_transfers on
its actual address until we read from the ARA register to clear the Alert=
.

Therefor we must (try to) read a byte from the client with the ARA
register, before returning -ENODEV, so that we clear the Alert and when
we get called again for the client instantiated for the second
I2cSerialBus ACPI-resource the sensor will respond to our i2c-transfers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index fd371b36c7b3..e8be20d3902c 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -51,6 +51,8 @@
 #define CM32181_CALIBSCALE_RESOLUTION	1000
 #define MLUX_PER_LUX			1000
=20
+#define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
+
 static const u8 cm32181_reg[CM32181_CONF_REG_NUM] =3D {
 	CM32181_REG_ADDR_CMD,
 };
@@ -333,6 +335,20 @@ static int cm32181_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
=20
+	/*
+	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
+	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
+	 * drivers/platform/x86/i2c-multi-instantiate.c instantiates "cm32181"
+	 * i2c_client-s for both resources, ignore the ARA client.
+	 * On these systems the sensor may have a SMBus Alert asserted at boot,
+	 * in that case the ARA must be read to clear the Alert otherwise the
+	 * sensor will not respond on its actual I2C address.
+	 */
+	if (client->addr =3D=3D SMBUS_ALERT_RESPONSE_ADDRESS) {
+		i2c_smbus_read_byte(client);
+		return -ENODEV;
+	}
+
 	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
 	if (!indio_dev) {
 		dev_err(&client->dev, "devm_iio_device_alloc failed\n");
--=20
2.26.0

