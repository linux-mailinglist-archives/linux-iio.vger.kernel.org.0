Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59E1C3A82
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEDM4v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 08:56:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36143 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbgEDM4u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 08:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588597008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KP1Llr2tiS35LMz4DPfPpllc3DSpKLS/cHLYTKI+UyM=;
        b=PXnfpvwIJKtDLeWqBiKYuccRpTTEsz05wj6sUQN3tnR8giLNNea8nIU2NpZTTJXHOQKls7
        3tD5h9YBgEnPIk9A+ty9XGi2r5sOpgLjXw/LFnHnO8TuSqTxAQ+MwgHEaMimSiCFjPDH9N
        xVAZQwPiKcRIbbKJVb+fZgJIsL/qe9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-bkfpSAYIO-K5i_kqe0gO3Q-1; Mon, 04 May 2020 08:56:44 -0400
X-MC-Unique: bkfpSAYIO-K5i_kqe0gO3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0145A1009448;
        Mon,  4 May 2020 12:56:33 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-224.ams2.redhat.com [10.36.114.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03CB75D9D5;
        Mon,  4 May 2020 12:56:29 +0000 (UTC)
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
Subject: [PATCH v4 10/11] iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables
Date:   Mon,  4 May 2020 14:55:50 +0200
Message-Id: <20200504125551.434647-10-hdegoede@redhat.com>
In-Reply-To: <20200504125551.434647-1-hdegoede@redhat.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On ACPI based systems the CPLM3218 ACPI device node describing the
CM3218[1] sensor typically will have some extra tables with register
init values for initializing the sensor and calibration info.

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

This was tested on the following models: Acer Switch 10 SW5-012 (CM32181)
Asus T100TA (CM3218), Asus T100CHI (CM3218) and HP X2 10-n000nd (CM32181)=
.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Factor out the parsing into a separate helper function
---
 drivers/iio/light/cm32181.c | 101 ++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index a0812e3cba9b..5eeefa3ee4f1 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -4,6 +4,7 @@
  * Author: Kevin Tsai <ktsai@capellamicro.com>
  */
=20
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -53,6 +54,15 @@
=20
 #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
=20
+/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bit=
map */
+#define CPM0_REGS_BITMAP		2
+#define CPM0_HEADER_SIZE		3
+
+/* CPM1 Index 0: lux_per_bit, 1: calibscale, 2: resolution (100000) */
+#define CPM1_LUX_PER_BIT		0
+#define CPM1_CALIBSCALE			1
+#define CPM1_SIZE			3
+
 struct cm32181_chip_info {
 	const char *name;
 	const int *als_it_bits;
@@ -61,6 +71,7 @@ struct cm32181_chip_info {
 };
=20
 struct cm32181_chip {
+	struct device *dev;
 	struct i2c_client *client;
 	const struct cm32181_chip_info *info;
 	struct mutex lock;
@@ -95,6 +106,92 @@ const struct cm32181_chip_info cm32181_chip_info =3D =
{
 	.num_als_it =3D ARRAY_SIZE(cm32181_als_it_bits),
 };
=20
+static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
+
+#ifdef CONFIG_ACPI
+/**
+ * cm32181_acpi_get_cpm() - Get CPM object from ACPI
+ * @client	pointer of struct i2c_client.
+ * @obj_name	pointer of ACPI object name.
+ * @count	maximum size of return array.
+ * @vals	pointer of array for return elements.
+ *
+ * Convert ACPI CPM table to array.
+ *
+ * Return: -ENODEV for fail.  Otherwise is number of elements.
+ */
+static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
+				u64 *values, int count)
+{
+	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *cpm, *elem;
+	acpi_handle handle;
+	acpi_status status;
+	int i;
+
+	handle =3D ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
+	status =3D acpi_evaluate_object(handle, obj_name, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "object %s not found\n", obj_name);
+		return -ENODEV;
+	}
+
+	cpm =3D buffer.pointer;
+	if (cpm->package.count > count)
+		dev_warn(dev, "%s table contains %d values, only using first %d values=
\n",
+			 obj_name, cpm->package.count, count);
+
+	count =3D min_t(int, cpm->package.count, count);
+	for (i =3D 0; i < count; i++) {
+		elem =3D &(cpm->package.elements[i]);
+		values[i] =3D elem->integer.value;
+	}
+
+	kfree(buffer.pointer);
+
+	return count;
+}
+
+static void cm32181_acpi_parse_cpm_tables(struct cm32181_chip *cm32181)
+{
+	u64 vals[CPM0_HEADER_SIZE + CM32181_CONF_REG_NUM];
+	struct device *dev =3D cm32181->dev;
+	int i, count;
+
+	count =3D cm32181_acpi_get_cpm(dev, "CPM0", vals, ARRAY_SIZE(vals));
+	if (count <=3D CPM0_HEADER_SIZE)
+		return;
+
+	count -=3D CPM0_HEADER_SIZE;
+
+	cm32181->init_regs_bitmap =3D vals[CPM0_REGS_BITMAP];
+	cm32181->init_regs_bitmap &=3D GENMASK(count - 1, 0);
+	for_each_set_bit(i, &cm32181->init_regs_bitmap, count)
+		cm32181->conf_regs[i] =3D	vals[CPM0_HEADER_SIZE + i];
+
+	count =3D cm32181_acpi_get_cpm(dev, "CPM1", vals, ARRAY_SIZE(vals));
+	if (count !=3D CPM1_SIZE)
+		return;
+
+	cm32181->lux_per_bit =3D vals[CPM1_LUX_PER_BIT];
+
+	/* Check for uncalibrated devices */
+	if (vals[CPM1_CALIBSCALE] =3D=3D CM32181_CALIBSCALE_DEFAULT)
+		return;
+
+	cm32181->calibscale =3D vals[CPM1_CALIBSCALE];
+	/* CPM1 lux_per_bit is for the current it value */
+	cm32181_read_als_it(cm32181, &cm32181->lux_per_bit_base_it);
+}
+#else
+static void cm32181_acpi_parse_cpm_tables(struct cm32181_chip *cm32181)
+{
+}
+#endif /* CONFIG_ACPI */
+
 /**
  * cm32181_reg_init() - Initialize CM32181 registers
  * @cm32181:	pointer of struct cm32181.
@@ -134,6 +231,9 @@ static int cm32181_reg_init(struct cm32181_chip *cm32=
181)
 	cm32181->lux_per_bit =3D CM32181_LUX_PER_BIT;
 	cm32181->lux_per_bit_base_it =3D CM32181_LUX_PER_BIT_BASE_IT;
=20
+	if (ACPI_HANDLE(cm32181->dev))
+		cm32181_acpi_parse_cpm_tables(cm32181);
+
 	/* Initialize registers*/
 	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
 		ret =3D i2c_smbus_write_word_data(client, i,
@@ -376,6 +476,7 @@ static int cm32181_probe(struct i2c_client *client)
 	}
=20
 	cm32181 =3D iio_priv(indio_dev);
+	cm32181->dev =3D dev;
 	cm32181->client =3D client;
=20
 	mutex_init(&cm32181->lock);
--=20
2.26.0

