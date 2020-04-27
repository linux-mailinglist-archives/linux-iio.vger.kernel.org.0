Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06D41BA92F
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgD0Pux (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 11:50:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45585 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728179AbgD0Puw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 11:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588002651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcDDVpZf3CSrzjYIDbLlguCG/9YpynAwlXI+zNH+P3c=;
        b=Zkfit/U0RWQHw3v2gOYijc/LDLC4Jn7zQdwWS1gLF6KWfOoIzrKX0XwUqZgeo/36/kB0uN
        hvX6bxcE5jEcr9z9DcbZxlAv+flZBbLOrcmbbWppMqpDM4UIAA+DAxuDxRTBpxEWd9rRpU
        moGa8EIRJd2mF7aXdQ9JHrkve2z3BKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-IkacN5IbPzeak5WFhJe6qA-1; Mon, 27 Apr 2020 11:50:49 -0400
X-MC-Unique: IkacN5IbPzeak5WFhJe6qA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F28C46B;
        Mon, 27 Apr 2020 15:50:47 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-38.ams2.redhat.com [10.36.114.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F21E66063C;
        Mon, 27 Apr 2020 15:50:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 3/8] iio: light: cm32181: Handle ACPI instantiating a cm32181 client on the SMBus ARA
Date:   Mon, 27 Apr 2020 17:50:32 +0200
Message-Id: <20200427155037.218390-3-hdegoede@redhat.com>
In-Reply-To: <20200427155037.218390-1-hdegoede@redhat.com>
References: <20200427155037.218390-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2
- s/i2c_client-s/I2C clients/ in added comment
---
 drivers/iio/light/cm32181.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index fd371b36c7b3..4c26a4a8a070 100644
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
+	 * I2C clients for both resources, ignore the ARA client.
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

