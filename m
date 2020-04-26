Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFE31B8F52
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgDZLDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 07:03:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20951 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726182AbgDZLDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 07:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587898991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqJi1jdkBu28gQlf+yNbx1ibf6v89AoBY8YcRvOsu/g=;
        b=Zl+sELF1zHyHTaBCrdAiuX75xM0S/xx45JDpc/iU5Vq7IRmWyzNg7QSv6Re0SdAmoJ3Fq1
        93zySEB9BInMCVLzFyFh2eQyD80KnunAwAwyCp/monCb47sN+3Kef9CbQVRQlafpvWnN9m
        BSIlKYAsPtUY6Z6bA38JO5AHWx59tW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-pqup05g2OYaJJ6qe0sGN3Q-1; Sun, 26 Apr 2020 07:03:07 -0400
X-MC-Unique: pqup05g2OYaJJ6qe0sGN3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A19A468;
        Sun, 26 Apr 2020 11:03:05 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0425D10013A1;
        Sun, 26 Apr 2020 11:03:02 +0000 (UTC)
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
Subject: [PATCH 2/8] iio: light: cm32181: Add support for the CM3218
Date:   Sun, 26 Apr 2020 13:02:50 +0200
Message-Id: <20200426110256.218186-2-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-1-hdegoede@redhat.com>
References: <20200426110256.218186-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the CM3218 which is an older version of the
CM32181.

This is based on a newer version of cm32181.c, with a copyright of:

 * Copyright (C) 2014 Capella Microsystems Inc.
 * Author: Kevin Tsai <ktsai@capellamicro.com>
 *
 * This program is free software; you can redistribute it and/or modify i=
t
 * under the terms of the GNU General Public License version 2, as publis=
hed
 * by the Free Software Foundation.

Which is floating around on the net in various places, but the changes
from this newer version never made it upstream.

This was tested on an Asus T100TA and an Asus T100CHI, which both come
with the CM3218 variant of the light sensor.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 51 ++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index ee386afe811e..fd371b36c7b3 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -55,15 +55,24 @@ static const u8 cm32181_reg[CM32181_CONF_REG_NUM] =3D=
 {
 	CM32181_REG_ADDR_CMD,
 };
=20
-static const int als_it_bits[] =3D {12, 8, 0, 1, 2, 3};
-static const int als_it_value[] =3D {25000, 50000, 100000, 200000, 40000=
0,
-	800000};
+/* CM3218 Family */
+static const int cm3218_als_it_bits[] =3D { 0, 1, 2, 3 };
+static const int cm3218_als_it_values[] =3D { 100000, 200000, 400000, 80=
0000 };
+
+/* CM32181 Family */
+static const int cm32181_als_it_bits[] =3D { 12, 8, 0, 1, 2, 3 };
+static const int cm32181_als_it_values[] =3D {
+	25000, 50000, 100000, 200000, 400000, 800000
+};
=20
 struct cm32181_chip {
 	struct i2c_client *client;
 	struct mutex lock;
 	u16 conf_regs[CM32181_CONF_REG_NUM];
 	int calibscale;
+	int num_als_it;
+	const int *als_it_bits;
+	const int *als_it_values;
 };
=20
 /**
@@ -85,8 +94,23 @@ static int cm32181_reg_init(struct cm32181_chip *cm321=
81)
 		return ret;
=20
 	/* check device ID */
-	if ((ret & 0xFF) !=3D 0x81)
+	switch (ret & 0xFF) {
+	case 0x18: /* CM3218 */
+		dev_info(&client->dev, "Detected CM3218\n");
+		cm32181->num_als_it =3D ARRAY_SIZE(cm3218_als_it_bits);
+		cm32181->als_it_bits =3D cm3218_als_it_bits;
+		cm32181->als_it_values =3D cm3218_als_it_values;
+		break;
+	case 0x81: /* CM32181 */
+	case 0x82: /* CM32182, fully compat. with CM32181 */
+		dev_info(&client->dev, "Detected CM32181\n");
+		cm32181->num_als_it =3D ARRAY_SIZE(cm32181_als_it_bits);
+		cm32181->als_it_bits =3D cm32181_als_it_bits;
+		cm32181->als_it_values =3D cm32181_als_it_values;
+		break;
+	default:
 		return -ENODEV;
+	}
=20
 	/* Default Values */
 	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =3D
@@ -121,9 +145,9 @@ static int cm32181_read_als_it(struct cm32181_chip *c=
m32181, int *val2)
 	als_it =3D cm32181->conf_regs[CM32181_REG_ADDR_CMD];
 	als_it &=3D CM32181_CMD_ALS_IT_MASK;
 	als_it >>=3D CM32181_CMD_ALS_IT_SHIFT;
-	for (i =3D 0; i < ARRAY_SIZE(als_it_bits); i++) {
-		if (als_it =3D=3D als_it_bits[i]) {
-			*val2 =3D als_it_value[i];
+	for (i =3D 0; i < cm32181->num_als_it; i++) {
+		if (als_it =3D=3D cm32181->als_it_bits[i]) {
+			*val2 =3D cm32181->als_it_values[i];
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 	}
@@ -146,14 +170,14 @@ static int cm32181_write_als_it(struct cm32181_chip=
 *cm32181, int val)
 	u16 als_it;
 	int ret, i, n;
=20
-	n =3D ARRAY_SIZE(als_it_value);
+	n =3D cm32181->num_als_it;
 	for (i =3D 0; i < n; i++)
-		if (val <=3D als_it_value[i])
+		if (val <=3D cm32181->als_it_values[i])
 			break;
 	if (i >=3D n)
 		i =3D n - 1;
=20
-	als_it =3D als_it_bits[i];
+	als_it =3D cm32181->als_it_bits[i];
 	als_it <<=3D CM32181_CMD_ALS_IT_SHIFT;
=20
 	mutex_lock(&cm32181->lock);
@@ -265,11 +289,12 @@ static int cm32181_write_raw(struct iio_dev *indio_=
dev,
 static ssize_t cm32181_get_it_available(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
+	struct cm32181_chip *cm32181 =3D iio_priv(dev_to_iio_dev(dev));
 	int i, n, len;
=20
-	n =3D ARRAY_SIZE(als_it_value);
+	n =3D cm32181->num_als_it;
 	for (i =3D 0, len =3D 0; i < n; i++)
-		len +=3D sprintf(buf + len, "0.%06u ", als_it_value[i]);
+		len +=3D sprintf(buf + len, "0.%06u ", cm32181->als_it_values[i]);
 	return len + sprintf(buf + len, "\n");
 }
=20
@@ -346,6 +371,7 @@ static int cm32181_probe(struct i2c_client *client,
 }
=20
 static const struct i2c_device_id cm32181_id[] =3D {
+	{ "cm3218", 0 },
 	{ "cm32181", 0 },
 	{ }
 };
@@ -353,6 +379,7 @@ static const struct i2c_device_id cm32181_id[] =3D {
 MODULE_DEVICE_TABLE(i2c, cm32181_id);
=20
 static const struct of_device_id cm32181_of_match[] =3D {
+	{ .compatible =3D "capella,cm3218" },
 	{ .compatible =3D "capella,cm32181" },
 	{ }
 };
--=20
2.26.0

