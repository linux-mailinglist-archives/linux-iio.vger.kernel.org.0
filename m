Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF81C3A57
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgEDM4F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 08:56:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22860 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726625AbgEDM4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 08:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588596964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3IyWgTOMXjHOmy2ereqicnSHpo+TKRD9Jy/hue5zjes=;
        b=VLfSERQDWi30tOopYoDIOvH91QElddAR9oTY7o/qJyI1sdA2n7v3S5H5Mth5fTm99Tt2q+
        3zJCkNsoAq+rX9q6nOCPd348Y2twehYIeHOjqAFhUVtw687Sk9uMld/RZN/o85MYerSMXy
        8GZU+DJrOJFXlhLESBLenpDpk505ofM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-llUa-5xNNqK2I1daWIMIhA-1; Mon, 04 May 2020 08:56:00 -0400
X-MC-Unique: llUa-5xNNqK2I1daWIMIhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B4A064ACA;
        Mon,  4 May 2020 12:55:58 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-224.ams2.redhat.com [10.36.114.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 060A25D97D;
        Mon,  4 May 2020 12:55:52 +0000 (UTC)
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
Subject: [PATCH v4 01/11] iio: light: cm32181: Switch to new style i2c-driver probe function
Date:   Mon,  4 May 2020 14:55:41 +0200
Message-Id: <20200504125551.434647-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Changes in v4:
- Set indio_dev->name to "cm32181" instead of setting it to dev_name(dev)

Changes in v3:
- This is a new patch in v3 of this patch-set
---
 drivers/iio/light/cm32181.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 5f4fb5674fa0..2c139d85ef0c 100644
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
+	indio_dev->name =3D "cm32181";
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

