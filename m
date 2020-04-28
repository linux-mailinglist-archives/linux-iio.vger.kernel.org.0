Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03E1BC6A4
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgD1R3e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 13:29:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35527 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728462AbgD1R3d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 13:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588094972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ua1iWH5acCeIcm+qZwgP19KY7BJbDjRWNsiRUuQwRiU=;
        b=Q5W8ZbSuah3EttIefzVmn4k6fyOJe17HUb5dL+PmwqKjnC3fygH8psky9RwLA/CC8Wwaaw
        QGuZfal9wInMVf4iaSCrKU3CE/UeDDirlqmL09DjuaubnEcMKJtzgGK/wtr5bQHwuCq7Ts
        V+07SVEb3X8JbZX8tR1m4qNYoa35qNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-mKmWBTEaMoW-QRUatY1bxQ-1; Tue, 28 Apr 2020 13:29:31 -0400
X-MC-Unique: mKmWBTEaMoW-QRUatY1bxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B0C8BF366;
        Tue, 28 Apr 2020 17:29:28 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-62.ams2.redhat.com [10.36.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 742F05C1D4;
        Tue, 28 Apr 2020 17:29:25 +0000 (UTC)
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
Subject: [PATCH v3 01/11] iio: light: cm32181: Switch to new style i2c-driver probe function
Date:   Tue, 28 Apr 2020 19:29:13 +0200
Message-Id: <20200428172923.567806-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Switch to the new style i2c-driver probe_new probe function and drop the
unnecessary i2c_device_id table (we do not have any old style board files
using this).

This is a preparation patch for adding ACPI binding support.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- This is a new patch in v3 of this patch-set
---
 drivers/iio/light/cm32181.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 5f4fb5674fa0..cc57190a24cb 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -294,8 +294,7 @@ static const struct iio_info cm32181_info =3D {
 	.attrs			=3D &cm32181_attribute_group,
 };
=20
-static int cm32181_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int cm32181_probe(struct i2c_client *client)
 {
 	struct cm32181_chip *cm32181;
 	struct iio_dev *indio_dev;
@@ -316,7 +315,7 @@ static int cm32181_probe(struct i2c_client *client,
 	indio_dev->channels =3D cm32181_channels;
 	indio_dev->num_channels =3D ARRAY_SIZE(cm32181_channels);
 	indio_dev->info =3D &cm32181_info;
-	indio_dev->name =3D id->name;
+	indio_dev->name =3D dev_name(&client->dev);
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
=20
 	ret =3D cm32181_reg_init(cm32181);
@@ -338,13 +337,6 @@ static int cm32181_probe(struct i2c_client *client,
 	return 0;
 }
=20
-static const struct i2c_device_id cm32181_id[] =3D {
-	{ "cm32181", 0 },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(i2c, cm32181_id);
-
 static const struct of_device_id cm32181_of_match[] =3D {
 	{ .compatible =3D "capella,cm32181" },
 	{ }
@@ -356,8 +348,7 @@ static struct i2c_driver cm32181_driver =3D {
 		.name	=3D "cm32181",
 		.of_match_table =3D of_match_ptr(cm32181_of_match),
 	},
-	.id_table       =3D cm32181_id,
-	.probe		=3D cm32181_probe,
+	.probe_new	=3D cm32181_probe,
 };
=20
 module_i2c_driver(cm32181_driver);
--=20
2.26.0

