Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10A1B946B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 00:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDZWTB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 18:19:01 -0400
Received: from mail-am6eur05on2109.outbound.protection.outlook.com ([40.107.22.109]:54987
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbgDZWTA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 18:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrFOw4ThaVeOL57BYm/ShAc4y0UabWQC2WLQlCRBrXxDi3CwQMfEOkbWSSCL/SMHpaeeGkqYwhuNmQ8sAzhox17S7eNhFCl6HIrXX0WTMvLl49TTp4goSs7MMF8fK0Q6dkhg1zBsnDegZMxwfU3mQZ/8LWGT2cVqWNVxLPsoa4f1yJonIHH+8k0k9qVvE2vvpn+QTXokl0TpKici7ydMDmuxeZSH8hBKMUve5nmZsxfz5+UGRqlAYWHFGPKZh/tRHUQvvr+wYROSquw5GVjAcnChzX8M0WjpRZlNZYXf6VwypMeotffvOXvqvYHSRXZGddGi0IRQQgqMPpUVlnRDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ViyFFmCDRHd1BiXDoH8Gw6oX+30aRnsMZ7exH0Hd0=;
 b=LGD3uB21tZUq1T2qFugew9/8GSisEimXyFKurjKDVCRDnDzIatfk40H9/+ixpAteJCv6zOmjodvStcfbyO86a0GSOzRZa5dRNO3xDJvamdsp9jwlSdNMbJz+RGuuvhJcLDNq4pu6JdgJhznJ8rUy4XOyV0qP8it8r+FgjI15Wx2Wjv8NTnLUmjwLqYeqKq2aABJ9/pSw8bWIoCXTsM54vlZCRo/Hlk2Wh1ojre1hDtISXfzsXd0o/9K0dutq+VJ1CeAMpqy2czfY3BPoTtmpTTPPGnl7JN+oIZQGtrHWc3SxcugROtXxS0KhgYWklRUGVUkFm35+4Q0yH1D/TZxO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ViyFFmCDRHd1BiXDoH8Gw6oX+30aRnsMZ7exH0Hd0=;
 b=HEYonRAFquF4Rk973UhwK91aUkz24P/eLRT6h/+O/n5IttEE5y/IzxPUp3OCdEge1Wqcnbe9qehn+IjdYsapArNaOkG6cV4mUcEFqz5SlgLbWgXjkuUrKK8k7pOV/up3q86MTD2jMHfBP1BMyi1Wd8EsB3EUO1M2c9uImYZIWco=
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB6200.eurprd06.prod.outlook.com (2603:10a6:20b:f5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 22:18:54 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::9814:8ea:8170:5678]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::9814:8ea:8170:5678%5]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 22:18:54 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH v7 1/2] Driver for TI HDC20x0 humidity and temperature sensors
Thread-Topic: [PATCH v7 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Index: AQHWHBirVMY9gQ8rT0e72WF+BkqeBQ==
Date:   Sun, 26 Apr 2020 22:18:54 +0000
Message-ID: <E372084A-C6C5-4261-90C5-B810ADAFDD73@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [88.88.123.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69268f3e-a4d7-4758-5155-08d7ea2fce5c
x-ms-traffictypediagnostic: AM6PR06MB6200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR06MB62009E44AC1BB20D5E51C100CAAE0@AM6PR06MB6200.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39830400003)(376002)(136003)(346002)(8676002)(71200400001)(81156014)(8936002)(26005)(6512007)(4326008)(30864003)(33656002)(2616005)(36756003)(91956017)(76116006)(2906002)(6486002)(66946007)(508600001)(6916009)(86362001)(66446008)(316002)(6506007)(966005)(66556008)(54906003)(5660300002)(186003)(66476007)(64756008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGk09q0BHLHdW/palWS4TFRf9AxKotQ75XZ4hCZTw1C8vw0bU/8rrjHXFe7/Xzt6pRYqAFhGFGo+S1Wj4EBI2T0d4wOIxoTPFbSbC2KtoN+VyxT1JOjWevGWKqvvvVNwee2pxwrw2zjiMXausSxNzLrH9mSadT0+6fevbH++hUYCCoHwNG2FDJoLucjtS0MACNxKetGghOoGAOSyNWyRlVeOiSBv1sAKYzSN15CAgV882/B0Et1lZgQ2HPC4iHAW8dFOcG992hVgJmZ5f8lFUwgmn4ceNj3gP9oGl3uQ3a/FLIeDMfNUuOMM7Jx2Ev6JrI1Omg+j+1i6YA0if46R/PRPFmmxgfc885RJGRJOOo4KWPFDbFpb1Bg3kHMlcgRhQifkXSsrkau/UW7sWrzqpXPAmJ0+FdBoTGlNUX2MEeTAd9fhUMNG47sPk2GxSOKwcgNfjt3rrNlv7DeEmB6wZIp3y5oqnATx0jEi75qqtmJNktEFoI+y5yLlyXqAuWcUTsJd9NfZ+nVfROILGw2Prg==
x-ms-exchange-antispam-messagedata: Q2+dhsjcoXO/mgdO9DeUC0MsKTnmh87qecOeGsyXt8e1529d//JcLQ/+lVK3QU6Gl+Ly7GtUo793YwMBzK9Cn3PsoLo6WFiamOA3Fx2zgurdDnAXNKdA9AeZme9iEXFF4NGxkSPqbFydbmM0AMGguehZdvbmuLeByDzu8T8XVAXsJkCTi6n7su+aqzhRLvBr9yvuf9mlJmL0shqIAH5Tk/FB6i3BPqUG1qTgFuI3JeClffXpcaW5IvTw79fNxg/srsB+4rvHoLEabPStKhV7LPdWP/SfX//a7o5fBmGS8Eyece6/IbUfxtsVHjjPKtKR0GTB8CRL+7x1Et5WbU2guSgpGf48GOOpGG0tE5vtd9X17iW0MSkneA43ITG7s7750cGqzSRssmpSGyx9uqOtNk7sigvVaWaHALnHRN6vvl5Y3SSa2uF6CLuyHEZc8gBl083sFNjk+G+n5WayDiFYtbm23DzF34f6pYFWlsnK3/dA5VGw0CjGnRZjLAEesAUBgL/6GLXj9a+pw+PBdtALnFxFR0M2dbasfKVyDDH9ly6wqZH//qZYKthDEFe8sKHqEfbx5XZTH+jDPge1OfYQSVLy9i+J0vmolTUFp07CeL79d4SDANJJ7oZiM0RfeKp8Icu1K0t7wg3hbFHxWK0QCG3YsMrYOH5xhl5CoWy61KGdoBeM9xrHJTUlL/XGW5H1ztFbBvfoqDYRDgheRgImfCwoRmHyghUy4iAj9j5fVcglDNVvyS+S9wv2OyCD0aDemM/dztCpUk4GygbimcZDrruDm1mBX38X+3VqlA+YIAM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DF2BF8D01594F48A6793C0B43148563@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69268f3e-a4d7-4758-5155-08d7ea2fce5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 22:18:54.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjcTCvx2d3ek1eNNbSAwMctNSvV6Zm/d65NaJK473ejiRSnmBk5QRvBWv6z7ZThZJir8jtlesS0HhIawQvZekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB6200
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

HDC2010/2080 driver and sysfs documentation for its heater element.

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/Documentation/=
ABI/testing/sysfs-bus-iio-humidity-hdc2010 linux-5.3.8_hdc2010/Documentatio=
n/ABI/testing/sysfs-bus-iio-humidity-hdc2010
--- linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	19=
70-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_hdc2010/Documentation/ABI/testing/sysfs-bus-iio-humidity-hd=
c2010	2019-12-02 11:09:25.803326999 +0100
@@ -0,0 +1,9 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
+KernelVersion:	5.3.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Controls the heater device within the humidity sensor to get
+		rid of excess condensation.
+
+		Valid control values are 0 =3D OFF, and 1 =3D ON.
diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/hu=
midity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
--- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.00000000=
0 +0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-04-24 18:04:48.=
699251583 +0200
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hdc2010.c - Support for the TI HDC2010 and HDC2080
+ * temperature + relative humidity sensors
+ *
+ * Copyright (C) 2020 Norphonic AS
+ * Author: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
+ *
+ * Datasheets:
+ * http://www.ti.com/product/HDC2010/datasheet
+ * http://www.ti.com/product/HDC2080/datasheet
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define HDC2010_REG_TEMP_LOW			0x00
+#define HDC2010_REG_TEMP_HIGH			0x01
+#define HDC2010_REG_HUMIDITY_LOW		0x02
+#define HDC2010_REG_HUMIDITY_HIGH		0x03
+#define HDC2010_REG_INTERRUPT_DRDY		0x04
+#define HDC2010_REG_TEMP_MAX			0x05
+#define HDC2010_REG_HUMIDITY_MAX		0x06
+#define HDC2010_REG_INTERRUPT_EN		0x07
+#define HDC2010_REG_TEMP_OFFSET_ADJ		0x08
+#define HDC2010_REG_HUMIDITY_OFFSET_ADJ		0x09
+#define HDC2010_REG_TEMP_THR_L			0x0a
+#define HDC2010_REG_TEMP_THR_H			0x0b
+#define HDC2010_REG_RH_THR_L			0x0c
+#define HDC2010_REG_RH_THR_H			0x0d
+#define HDC2010_REG_RESET_DRDY_INT_CONF		0x0e
+#define HDC2010_REG_MEASUREMENT_CONF		0x0f
+
+#define HDC2010_MEAS_CONF			GENMASK(2, 1)
+#define HDC2010_MEAS_TRIG			BIT(0)
+#define HDC2010_HEATER_EN			BIT(3)
+#define HDC2010_AMM				GENMASK(6, 4)
+
+struct hdc2010_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u8 measurement_config;
+	u8 interrupt_config;
+	u8 drdy_config;
+};
+
+enum hdc2010_addr_groups {
+	HDC2010_GROUP_TEMP =3D 0,
+	HDC2010_GROUP_HUMIDITY
+};
+
+struct hdc2010_reg_record {
+	unsigned long primary;
+	unsigned long peak;
+};
+
+static const struct hdc2010_reg_record hdc2010_reg_translation[] =3D {
+	[HDC2010_GROUP_TEMP] =3D {
+		.primary =3D HDC2010_REG_TEMP_LOW,
+		.peak =3D HDC2010_REG_TEMP_MAX,
+	},
+	[HDC2010_GROUP_HUMIDITY] =3D {
+		.primary =3D HDC2010_REG_HUMIDITY_LOW,
+		.peak =3D HDC2010_REG_HUMIDITY_MAX,
+	},
+};
+
+static IIO_CONST_ATTR(out_current_heater_raw_available,
+		"0 1");
+
+static struct attribute *hdc2010_attributes[] =3D {
+	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group hdc2010_attribute_group =3D {
+	.attrs =3D hdc2010_attributes,
+};
+
+static const struct iio_chan_spec hdc2010_channels[] =3D {
+	{
+		.type =3D IIO_TEMP,
+		.address =3D HDC2010_GROUP_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_PEAK) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type =3D IIO_HUMIDITYRELATIVE,
+		.address =3D HDC2010_GROUP_HUMIDITY,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_PEAK) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type =3D IIO_CURRENT,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+		.extend_name =3D "heater",
+		.output =3D 1,
+	},
+};
+
+static int hdc2010_update_drdy_config(struct hdc2010_data *data,
+					     char mask, char val)
+{
+	char tmp =3D (~mask & data->drdy_config) | val;
+	int ret;
+
+	ret =3D i2c_smbus_write_byte_data(data->client,
+					HDC2010_REG_RESET_DRDY_INT_CONF, tmp);
+	if (!ret)
+		data->drdy_config =3D tmp;
+
+	return ret;
+}
+
+static int hdc2010_get_prim_measurement_word(struct hdc2010_data *data,
+					     struct iio_chan_spec const *chan)
+{
+	struct i2c_client *client =3D data->client;
+	s32 ret;
+
+	ret =3D i2c_smbus_read_word_data(client,
+			hdc2010_reg_translation[chan->address].primary);
+
+	if (ret < 0)
+		dev_err(&client->dev, "Could not read sensor data\n");
+
+	return ret;
+}
+
+static int hdc2010_get_peak_measurement_byte(struct hdc2010_data *data,
+					     struct iio_chan_spec const *chan)
+{
+	struct i2c_client *client =3D data->client;
+	s32 ret;
+
+	ret =3D i2c_smbus_read_byte_data(client,
+			hdc2010_reg_translation[chan->address].peak);
+
+	if (ret < 0)
+		dev_err(&client->dev, "Could not read sensor data\n");
+
+	return ret;
+}
+
+static int hdc2010_get_heater_status(struct hdc2010_data *data)
+{
+	return !!(data->drdy_config & HDC2010_HEATER_EN);
+}
+
+static int hdc2010_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct hdc2010_data *data =3D iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		int ret;
+
+		if (chan->type =3D=3D IIO_CURRENT) {
+			*val =3D hdc2010_get_heater_status(data);
+			return IIO_VAL_INT;
+		}
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		mutex_lock(&data->lock);
+		ret =3D hdc2010_get_prim_measurement_word(data, chan);
+		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+		*val =3D ret;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_PEAK: {
+		int ret;
+
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		mutex_lock(&data->lock);
+		ret =3D hdc2010_get_peak_measurement_byte(data, chan);
+		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+		/* Scaling up the value so we can use same offset as RAW */
+		*val =3D ret * 256;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val2 =3D 65536;
+		if (chan->type =3D=3D IIO_TEMP)
+			*val =3D 165000;
+		else
+			*val =3D 100000;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_OFFSET:
+		*val =3D -15887;
+		*val2 =3D 515151;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hdc2010_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct hdc2010_data *data =3D iio_priv(indio_dev);
+	int new, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type !=3D IIO_CURRENT || val2 !=3D 0)
+			return -EINVAL;
+
+		switch (val) {
+		case 1:
+			new =3D HDC2010_HEATER_EN;
+			break;
+		case 0:
+			new =3D 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mutex_lock(&data->lock);
+		ret =3D hdc2010_update_drdy_config(data, HDC2010_HEATER_EN, new);
+		mutex_unlock(&data->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info hdc2010_info =3D {
+	.read_raw =3D hdc2010_read_raw,
+	.write_raw =3D hdc2010_write_raw,
+	.attrs =3D &hdc2010_attribute_group,
+};
+
+static int hdc2010_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct hdc2010_data *data;
+	u8 tmp;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
+				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client =3D client;
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent =3D &client->dev;
+	/*
+	 * As DEVICE ID register does not differentiate between
+	 * HDC2010 and HDC2080, we have the name hardcoded
+	 */
+	indio_dev->name =3D "hdc2010";
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &hdc2010_info;
+
+	indio_dev->channels =3D hdc2010_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(hdc2010_channels);
+
+	/* Enable Automatic Measurement Mode at 5Hz */
+	ret =3D hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);
+	if (ret)
+		return ret;
+
+	/*
+	 * We enable both temp and humidity measurement.
+	 * However the measurement won't start even in AMM until triggered.
+	 */
+	tmp =3D (u8)(data->measurement_config & ~HDC2010_MEAS_CONF) |
+		HDC2010_MEAS_TRIG;
+
+	ret =3D i2c_smbus_write_byte_data(client,
+					HDC2010_REG_MEASUREMENT_CONF, tmp);
+	if (ret)
+		return ret;
+	data->measurement_config =3D tmp;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id hdc2010_id[] =3D {
+	{ "hdc2010" },
+	{ "hdc2080" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hdc2010_id);
+
+static const struct of_device_id hdc2010_dt_ids[] =3D {
+	{ .compatible =3D "ti,hdc2010" },
+	{ .compatible =3D "ti,hdc2080" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hdc2010_dt_ids);
+
+static struct i2c_driver hdc2010_driver =3D {
+	.driver =3D {
+		.name	=3D "hdc2010",
+		.of_match_table =3D hdc2010_dt_ids,
+	},
+	.probe =3D hdc2010_probe,
+	.id_table =3D hdc2010_id,
+};
+module_i2c_driver(hdc2010_driver);
+
+MODULE_AUTHOR("Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>");
+MODULE_DESCRIPTION("TI HDC2010 humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/hu=
midity/Kconfig linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig
--- linux-5.3.8/drivers/iio/humidity/Kconfig	2019-10-29 09:22:48.000000000 =
+0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig	2019-11-28 14:31:27.79=
4242693 +0100
@@ -38,6 +38,16 @@ config HDC100X
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc100x.
=20
+config HDC2010
+	tristate "TI HDC2010 relative humidity and temperature sensor"
+	depends on I2C
+	help
+	  Say yes here to build support for the Texas Instruments
+	  HDC2010 and HDC2080 relative humidity and temperature sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hdc2010.
+
 config HID_SENSOR_HUMIDITY
 	tristate "HID Environmental humidity sensor"
 	depends on HID_SENSOR_HUB
diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/hu=
midity/Makefile linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile
--- linux-5.3.8/drivers/iio/humidity/Makefile	2019-10-29 09:22:48.000000000=
 +0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile	2019-11-28 14:30:40.6=
09892061 +0100
@@ -6,6 +6,7 @@
 obj-$(CONFIG_AM2315) +=3D am2315.o
 obj-$(CONFIG_DHT11) +=3D dht11.o
 obj-$(CONFIG_HDC100X) +=3D hdc100x.o
+obj-$(CONFIG_HDC2010) +=3D hdc2010.o
 obj-$(CONFIG_HID_SENSOR_HUMIDITY) +=3D hid-sensor-humidity.o
=20
 hts221-y :=3D hts221_core.o \

