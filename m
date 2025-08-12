Return-Path: <linux-iio+bounces-22617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB8B22825
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C305817DB
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6E2586DA;
	Tue, 12 Aug 2025 13:08:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2052239E67
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004132; cv=none; b=cKx+3PEv4g9OdhArggqn8ts8ifBpOBqn/hXvaEI+n1+FgbrceEDMnngAoWmUnSJN8tE8dujxO/MgQRmtnc4n5i2h6wI3ysEMx5hiGlU0tMkaDqHBxKgtgO4OlUWFb29a4qE7bfhk0WVJGHVegw/YZGrvsV0x5HXuJrePhGrOXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004132; c=relaxed/simple;
	bh=WvKOX7hS0o0QYPcNUwaM88tA9HKMxZQBer+HdNlzMNM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c0JlvyiIHaJP3hjz5RICjF9HSJbTSUNKK1v8vlvErjW6WV7vuLMx5gGHqrR7ki0ppiumidU3i/VOJjw7J5XEmlYp7wiUT0SNLOpmImgUbWkUsNlVbQnfmt2fNgVjarZAU0efu4CTTYSGUhUkvbErAqJQCVHUg3+bu8v3GAJlvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Aug 2025 09:08:30 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andrew Hepp <andrew.hepp@ahepp.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [PATCH] mcp9600: Add support for mcp9601 and sensor config
Message-ID: <6esdq4e4r7vmxwlyfs4a3sgdomazxospr3go2oaqkwhpgw6mkh@hdca2d3f6zwp>
Mail-Followup-To: linux-iio@vger.kernel.org, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqcc3rkwto4a7r2v"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--gqcc3rkwto4a7r2v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] mcp9600: Add support for mcp9601 and sensor config
MIME-Version: 1.0

The mcp9600 dt binding doc claims to support thermocouple-type but
I don't see where this is implemented.

- Add support to detect mcp9601 device type
- Add support to use thermocouple-type dt prop
- Add thrermocouple iio info to get/set this from sysfs
- Add filter-level dt prop to set the filtering level of the chip
- Update dt binding docs

Signed-off-by: Ben Collins <bcollins@kernel.org>
Cc: Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: "Nuno S=E1" <nuno.sa@analog.com>
---
 .../iio/temperature/microchip,mcp9600.yaml    |   9 +
 drivers/iio/temperature/mcp9600.c             | 185 ++++++++++++++++--
 2 files changed, 181 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mc=
p9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mc=
p9600.yaml
index d2cafa38a5442..0ee0259471c6a 100644
--- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.y=
aml
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.y=
aml
@@ -42,6 +42,14 @@ properties:
       Use defines in dt-bindings/iio/temperature/thermocouple.h.
       Supported types are B, E, J, K, N, R, S, T.
=20
+  filter-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Level of chip filtering to use. 0 means filtering is disabled.
+      See reference manual 5.2.2 - THERMOCOUPLE SENSOR CONFIGURATION
+      REGISTER, FIGURE 5-6 for Filter Step Response graph. Supported
+      values are in the range of 0-7.
+
   vdd-supply: true
=20
 required:
@@ -65,6 +73,7 @@ examples:
             interrupts =3D <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-names =3D "open-circuit";
             thermocouple-type =3D <THERMOCOUPLE_TYPE_K>;
+            filter-level =3D <1>;
             vdd-supply =3D <&vdd>;
         };
     };
diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mc=
p9600.c
index 6e9108d5cf75f..c1fe1e530786c 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -18,15 +18,23 @@
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <dt-bindings/iio/temperature/thermocouple.h>
=20
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
=20
 /* MCP9600 registers */
-#define MCP9600_HOT_JUNCTION 0x0
-#define MCP9600_COLD_JUNCTION 0x2
+#define MCP9600_HOT_JUNCTION		0x0
+#define MCP9600_COLD_JUNCTION		0x2
 #define MCP9600_STATUS			0x4
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
+#define MCP9600_STATUS_OC_IR		BIT(4)
+#define MCP9601_STATUS_SC		BIT(5)
+#define MCP9600_SENSOR_CFG		0x5
+#define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
+#define MCP9600_SENSOR_TYPE(x)		((x << 4) & MCP9600_SENSOR_TYPE_MASK)
+#define MCP9600_FILTER_MASK		GENMASK(2, 0)
+#define MCP9600_FILTER(x)		((x << 0) & MCP9600_FILTER_MASK)
 #define MCP9600_ALERT_CFG1		0x8
 #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
 #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
@@ -38,10 +46,11 @@
 #define MCP9600_ALERT_LIMIT1		0x10
 #define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
 #define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
-#define MCP9600_DEVICE_ID 0x20
+#define MCP9600_DEVICE_ID		0x20
=20
 /* MCP9600 device id value */
-#define MCP9600_DEVICE_ID_MCP9600 0x40
+#define MCP9600_DEVICE_ID_MCP9600	0x40
+#define MCP9600_DEVICE_ID_MCP9601	0x41
=20
 #define MCP9600_ALERT_COUNT		4
=20
@@ -58,6 +67,21 @@ enum mcp9600_alert {
 	MCP9600_ALERT4
 };
=20
+static const unsigned int mcp9600_type_map[] =3D {
+	[THERMOCOUPLE_TYPE_K] =3D 0,
+	[THERMOCOUPLE_TYPE_J] =3D 1,
+	[THERMOCOUPLE_TYPE_T] =3D 2,
+	[THERMOCOUPLE_TYPE_N] =3D 3,
+	[THERMOCOUPLE_TYPE_S] =3D 4,
+	[THERMOCOUPLE_TYPE_E] =3D 5,
+	[THERMOCOUPLE_TYPE_B] =3D 6,
+	[THERMOCOUPLE_TYPE_R] =3D 7,
+};
+
+static const int mcp9600_tc_types[] =3D {
+	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
+};
+
 static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] =3D {
 	[MCP9600_ALERT1] =3D "alert1",
 	[MCP9600_ALERT2] =3D "alert2",
@@ -87,8 +111,12 @@ static const struct iio_event_spec mcp9600_events[] =3D=
 {
 		{							       \
 			.type =3D IIO_TEMP,				       \
 			.address =3D MCP9600_HOT_JUNCTION,		       \
-			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	       \
-					      BIT(IIO_CHAN_INFO_SCALE),	       \
+			.info_mask_separate =3D                                  \
+					BIT(IIO_CHAN_INFO_RAW) |	       \
+					BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
+					BIT(IIO_CHAN_INFO_SCALE),              \
+			.info_mask_separate_available =3D                        \
+					BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),  \
 			.event_spec =3D &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs =3D hj_num_ev,			       \
 		},							       \
@@ -125,6 +153,9 @@ static const struct iio_chan_spec mcp9600_channels[][2]=
 =3D {
=20
 struct mcp9600_data {
 	struct i2c_client *client;
+	unsigned char dev_id;
+	u32 thermocouple_type;
+	u32 filter;
 };
=20
 static int mcp9600_read(struct mcp9600_data *data,
@@ -155,13 +186,82 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D 62;
 		*val2 =3D 500000;
 		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		*val =3D mcp9600_tc_types[data->thermocouple_type];
+		return IIO_VAL_CHAR;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		return IIO_VAL_CHAR;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9600_config(struct mcp9600_data *data)
+{
+	struct i2c_client *client =3D data->client;
+	int ret, cfg;
+
+	cfg  =3D MCP9600_SENSOR_TYPE(mcp9600_type_map[data->thermocouple_type]) |
+		MCP9600_FILTER(data->filter);
+
+	ret =3D i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to set sensor configuration\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mcp9600_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mcp9600_data *data =3D iio_priv(indio_dev);
+	int tc_type =3D -1;
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		for (i =3D 0; i < ARRAY_SIZE(mcp9600_tc_types); i++) {
+			if (mcp9600_tc_types[i] =3D=3D toupper(val)) {
+				tc_type =3D i;
+				break;
+			}
+		}
+		if (tc_type < 0)
+			return -EINVAL;
+
+		data->thermocouple_type =3D tc_type;
+		ret =3D mcp9600_config(data);
+		if (ret < 0)
+			return ret;
+
+		break;
+
 	default:
 		return -EINVAL;
 	}
+
+	return 0;
 }
=20
 static int mcp9600_get_alert_index(int channel2, enum iio_event_direction =
dir)
@@ -299,12 +399,32 @@ static int mcp9600_write_thresh(struct iio_dev *indio=
_dev,
 	}
 }
=20
+static int mcp9600_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		*vals =3D mcp9600_tc_types;
+		*type =3D IIO_VAL_CHAR;
+		*length =3D ARRAY_SIZE(mcp9600_tc_types);
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info mcp9600_info =3D {
 	.read_raw =3D mcp9600_read_raw,
+	.write_raw =3D mcp9600_write_raw,
+	.write_raw_get_fmt =3D mcp9600_write_raw_get_fmt,
 	.read_event_config =3D mcp9600_read_event_config,
 	.write_event_config =3D mcp9600_write_event_config,
 	.read_event_value =3D mcp9600_read_thresh,
 	.write_event_value =3D mcp9600_write_thresh,
+	.read_avail =3D mcp9600_read_avail,
 };
=20
 static irqreturn_t mcp9600_alert_handler(void *private,
@@ -418,26 +538,65 @@ static int mcp9600_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct mcp9600_data *data;
-	int ret, ch_sel;
+	int ch_sel, dev_id, ret;
=20
-	ret =3D i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
-	if (ret < 0)
-		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
-	if (ret !=3D MCP9600_DEVICE_ID_MCP9600)
-		dev_warn(&client->dev, "Expected ID %x, got %x\n",
-				MCP9600_DEVICE_ID_MCP9600, ret);
+	dev_id =3D i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
+	if (dev_id < 0)
+		return dev_err_probe(&client->dev, dev_id, "Failed to read device ID\n");
+
+	switch (dev_id) {
+	case MCP9600_DEVICE_ID_MCP9600:
+		dev_info(&client->dev, "Identified as mcp9600");
+		break;
+	case MCP9600_DEVICE_ID_MCP9601:
+		dev_info(&client->dev, "Identified as mcp9601");
+		break;
+
+	default:
+		return dev_err_probe(&client->dev, -EINVAL, "Unknown device ID: %x\n",
+				     dev_id);
+	}
=20
 	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
=20
 	data =3D iio_priv(indio_dev);
+
+	ret =3D device_property_read_u32(&client->dev, "thermocouple-type",
+				       &data->thermocouple_type);
+	if (ret) {
+		dev_warn(&client->dev,
+			 "Missing thermocouple-type property, using Type-K\n");
+		data->thermocouple_type =3D THERMOCOUPLE_TYPE_K;
+	} else if (data->thermocouple_type < 0 || data->thermocouple_type >=3D
+		   ARRAY_SIZE(mcp9600_type_map)) {
+		dev_warn(&client->dev,
+			 "Invalid thermocouple-type property, using Type-K\n");
+		data->thermocouple_type =3D THERMOCOUPLE_TYPE_K;
+	}
+
+	ret =3D device_property_read_u32(&client->dev, "filter-level",
+				       &data->filter);
+	if (ret) {
+		dev_warn(&client->dev,
+			 "Missing filter-level property, using 0\n");
+		data->filter =3D 0;
+	} else if (data->filter < 0 || data->filter > 7) {
+		dev_warn(&client->dev,
+			 "Invalid filter-level property, using 0\n");
+		data->filter =3D 0;
+	}
+
+	data->dev_id =3D dev_id;
 	data->client =3D client;
=20
 	ch_sel =3D mcp9600_probe_alerts(indio_dev);
 	if (ch_sel < 0)
 		return ch_sel;
=20
+	mcp9600_config(data);
+
 	indio_dev->info =3D &mcp9600_info;
 	indio_dev->name =3D "mcp9600";
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
--=20
2.50.1

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--gqcc3rkwto4a7r2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmibPM4ACgkQXVpXxyQr
Is+inw/8DnA3uJq6J+zmY2Qt0V101x2kGDb8Wxxp3Yti3Ye5fPXRpWl5bZtW8k9j
SIcKQOmKKso+ufm92NRHcDCNYuaL0bXfnvun+gI95h75UEC6AaqxaWNRneQH9wfS
dQKqm9E7h3sQCZqhcJY0CiTERlPcXKhiNA/ZqxBVsnGBE+56d52I0XDfQ/d5vPf0
UK4qolx1oGDH85vQwmoZ/Qqwk0f5N6jaEjGlkz5gKCkALtKdekdK2UOrFZs8a4yQ
oDBoLJmTN4FWfggzJIU2jTDrEoGOKpD1pL3KTQR9kIW4DiCpj9augswnsbWXlQGx
svvTUWyLhp4IMG/V4MjAfuLC4MfFSBgo2Yv5jfxeuwuPxFgiRZWQha2SfRSQjnTZ
PhMfHa0ZRSJO7TtCkUJd5ih9vX77sWrYVBsob7BqPS9KjAj1ca//IUk+Rj8x7hjO
9JwrOg9DvfVdFwfsWR0qIntm+XjZ6JdCB68Pt0aKuJHGo7kzhhpdFJu2sx2HpfpT
itr/kMqqTvlU1ABRr413ne3htwV+nnC1eRb5jKFljV4bSWQrEf96C114USJiFsyV
fgeEpUv3Acx/4593UP243eu8by++OO9kpEL3w3QyUTvcqk2LP/lurxxj5basF1m3
Uerue/rMwHBvUNxG6d+WKplmjAHB6J626ddr9Vd66eO3S7hjYwU=
=V3T6
-----END PGP SIGNATURE-----

--gqcc3rkwto4a7r2v--

