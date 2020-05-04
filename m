Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE731C3A78
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgEDM4t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 08:56:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728389AbgEDM40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 08:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588596985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgyXcNfc0s1FPSxm2MNo1SSdMk7yteMrkiwIrq6sprw=;
        b=IETVhfADMWEh2Mzp+xmeO8lgEBceFWBvX6joYe6jOMCIaliPsN/ZFpUssJM/IBpbLAZ/ZS
        7YAj2r8AGtGIEHGEGzWKm/BmwHP85p4XOLOyyj8fQYPG5qiDrhXT3+zlTg4/xMK7xuBlPZ
        8WJubNkD5W69zYHRBSsId7UJf3DuKt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-bcjkzDsFOGKj9QhqZFCaRw-1; Mon, 04 May 2020 08:56:22 -0400
X-MC-Unique: bcjkzDsFOGKj9QhqZFCaRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 691B3100CD0B;
        Mon,  4 May 2020 12:56:20 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-224.ams2.redhat.com [10.36.114.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD8035D9D5;
        Mon,  4 May 2020 12:56:17 +0000 (UTC)
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
        linux-iio@vger.kernel.org
Subject: [PATCH v4 06/11] iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources
Date:   Mon,  4 May 2020 14:55:46 +0200
Message-Id: <20200504125551.434647-6-hdegoede@redhat.com>
In-Reply-To: <20200504125551.434647-1-hdegoede@redhat.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some ACPI systems list 2 I2C resources for the CM3218 sensor. On these
systems the first I2cSerialBus ACPI-resource points to the SMBus Alert
Response Address (ARA, 0x0c) and the second I2cSerialBus ACPI-resource
points to the actual CM3218 sensor address:

 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
 {
     Name (SBUF, ResourceTemplate ()
     {
         I2cSerialBusV2 (0x000C, ControllerInitiated, 0x00061A80,
             AddressingMode7Bit, "\\_SB.I2C3",
             0x00, ResourceConsumer, , Exclusive,
             )
         I2cSerialBusV2 (0x0048, ControllerInitiated, 0x00061A80,
             AddressingMode7Bit, "\\_SB.I2C3",
             0x00, ResourceConsumer, , Exclusive,
             )
         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
         {
             0x00000033,
         }
     })
     Return (SBUF) /* \_SB_.I2C3.ALSD._CRS.SBUF */
 }

Detect this and take the following step to deal with it:

1. When a SMBus Alert capable sensor has an Alert asserted, it will
   not respond on its actual I2C address. Read a byte from the ARA
   to clear any pending Alerts.

2. Create a "dummy" client for the actual I2C address and
   use that client to communicate with the sensor.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Create and use a dummy client instead of relying on i2c-multi-instantia=
te
  to create 2 separate clients for the 2 I2C resources

Changes in v2
- s/i2c_client-s/I2C clients/ in added comment
---
 drivers/iio/light/cm32181.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index f6261798baa3..fd760e209dfa 100644
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
@@ -351,6 +353,26 @@ static int cm32181_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
=20
+	/*
+	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
+	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
+	 * Detect this and take the following step to deal with it:
+	 * 1. When a SMBus Alert capable sensor has an Alert asserted, it will
+	 *    not respond on its actual I2C address. Read a byte from the ARA
+	 *    to clear any pending Alerts.
+	 * 2. Create a "dummy" client for the actual I2C address and
+	 *    use that client to communicate with the sensor.
+	 */
+	if (ACPI_HANDLE(dev) && client->addr =3D=3D SMBUS_ALERT_RESPONSE_ADDRES=
S) {
+		struct i2c_board_info board_info =3D { .type =3D "dummy" };
+
+		i2c_smbus_read_byte(client);
+
+		client =3D i2c_acpi_new_device(dev, 1, &board_info);
+		if (IS_ERR(client))
+			return PTR_ERR(client);
+	}
+
 	cm32181 =3D iio_priv(indio_dev);
 	cm32181->client =3D client;
=20
--=20
2.26.0

