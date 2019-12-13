Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2021411E723
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 16:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfLMPza (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 10:55:30 -0500
Received: from mail-eopbgr10115.outbound.protection.outlook.com ([40.107.1.115]:9535
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727937AbfLMPza (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Dec 2019 10:55:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqceUWBkAUVEKdilUNJYVw1RM5AtcIb+cRTQEswXWh7ZJYj5xfxH4bSqdpFBU3MA0KCfx7CK2SOl9s+TnmkDKAf75c3/vJKbGn8lUxBJ6NWtwE7PnWwXGFeQ0MOx+6w/XIJzdmcmR9JLiD+gNTJZnx153tKOF5gKA1p7IkdAf0USQbLrpzZLHNoanARcqJr/a7rlsdkFheXcwB/3raQIqS8mLi0JOhB5I3DuZupPHvB5jpar+cyR9LWulnQiqO/0jHOQ9DFT64O+QdL8+6QNWG9ORAndxjTJvGzsM+QcU6zn+9sLBetK4Qutph7/LkhR3rZJcJ2Z9uPGBTlX+Tfo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxlT9v54cPuIo/eW9MCJDO3TEtce4bEFuR8FLbYcixM=;
 b=Gsjp3TsXZ6+Vb+fnFa7F/scfPa60soEixQxAR19oi2l30oEunH2FvT7akcQ0HqIEY8IGbQsjstYMD0MhTvc+WHh0nsfYi4BDUWkwlyDZTx3wpjuB1Yw3d5wsBaDwPGyM9sSpW4Chj5bMtK6fCyOP0ZxiJ3Mf/RMng8arTrte/vFR4/gMmJcWNEA6REWRpl+oSDK8XjUfk7N7OBQnpUJZdioWOHn5xbqfOnQwpUDTMmCMKK8BzCe06ilFMU4jgNRZrgTiJjIvw98y7kl4ghEBDO6/38zjx3ipPjLvqp/bOjF+saJTKfBak7k/c5/kCRk4oa78/59uT0AVn+8SGF/ifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxlT9v54cPuIo/eW9MCJDO3TEtce4bEFuR8FLbYcixM=;
 b=cjhWDXUqa97dvgh6lqeaQAa3/r/FFdGh4R0h/RWHRaUQY4K/1tgpCFRQGChST2X42cQtuZhdL9y67GYjPORcyS+UcasoK0VehnF2dJ0jzL1DTrt1MkNHhpSOwEtP9OKWRP86ZKuDMPLmCcW30dZVtQDsYcGRPNi5NW3qHGpYpX4=
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com (20.177.202.94) by
 VI1PR06MB4655.eurprd06.prod.outlook.com (20.178.12.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 15:55:23 +0000
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568]) by VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568%4]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 15:55:23 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH v3 1/2] Driver for TI HDC20x0 humidity and temperature sensors 
Thread-Topic: [PATCH v3 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors 
Thread-Index: AQHVsc26SON/FxISfkecdCGvyqtp7Q==
Date:   Fri, 13 Dec 2019 15:55:23 +0000
Message-ID: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea89e289-88bd-4cea-d3d7-08d77fe4dd2a
x-ms-traffictypediagnostic: VI1PR06MB4655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR06MB46556FDB1EBA569198B1FA3FCA540@VI1PR06MB4655.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39840400004)(136003)(199004)(189003)(76116006)(66476007)(6916009)(91956017)(66556008)(36756003)(66946007)(66446008)(86362001)(2906002)(508600001)(64756008)(81166006)(81156014)(6512007)(4743002)(54906003)(5660300002)(8676002)(4326008)(316002)(2616005)(71200400001)(33656002)(26005)(8936002)(186003)(966005)(6486002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB4655;H:VI1PR06MB5790.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Mp+DUGZo3AY88jasyyN+O5V/fzAVC+1QdBjAVrtiKErWO+3bDJg/JxTsz5bGxjGLqChXEIauWzXrYgSsBk0iZFb57ihktZJC750/ZAPj5A64Tk1KKX24NHyiltoiAz9eYqUEUwxaZC029KeQNsxRyly9PTW5GVEYI4Y6GuFERDPfrrx7zn1NOPPtrkfrwAy4DVkZHZROMwOXKX7UKrJWD7cAb2LafZB6rImxWZeZ2wFvOJ7qsylmaeQw0o3ZJSFHhfUDHqsJbX1V6VqdI22rfEYEofgH5lzaVaFJMQfpDlUb24mjkVXtF1wFL2DN2QUvt6aLwS8J3yHru1B7JLIvVN2aU7yy1A+s7YsDCv/yRHhenrbU84CzdpND/NMtIDjJDb4AN+km4Wegd9rakR8IX8JVsBPYOuz9Dyn8yuL7n8d43jYp36b6GJvBSwaccw6QqUOrjBcqjuPbR4vrZC2SNpeEcJGQDlJKVMNBVRyNXc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A59AB3D39C2824419C41CE28DD996C31@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea89e289-88bd-4cea-d3d7-08d77fe4dd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 15:55:23.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrQS8rgF7zNckYDMuag4pAQQ7IM8IvLe/IBYp1LzA3lopk0QRDrlzzADkKMR+rpy10Yby3eXvHmJWz6EP2oMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4655
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes to scope of locking.

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/hu=
midity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
--- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.00000000=
0 +0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2019-12-13 16:44:13.=
321334255 +0100
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hdc2010.c - Support for the TI HDC2010 and HDC2080
+ * temperature + relative humidity sensors
+ *
+ * Copyright (C) 2019 Norphonic AS
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
+	IIO_CHAN_SOFT_TIMESTAMP(2),
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
+static int hdc2010_get_measurement_word(struct hdc2010_data *data,
+					struct iio_chan_spec const *chan)
+{
+	struct i2c_client *client =3D data->client;
+	s32 ret;
+
+	ret =3D i2c_smbus_read_word_data(data->client,
+			hdc2010_reg_translation[chan->address].primary);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "Could not read sensor data\n");
+	}
+
+	return ret;
+}
+
+static int hdc2010_get_measurement_byte(struct hdc2010_data *data,
+					struct iio_chan_spec const *chan)
+{
+	struct i2c_client *client =3D data->client;
+	s32 ret;
+
+	ret =3D i2c_smbus_read_byte_data(data->client,
+			hdc2010_reg_translation[chan->address].peak);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "Could not read sensor data\n");
+	}
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
+			ret =3D IIO_VAL_INT;
+		} else {
+			ret =3D iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
+			mutex_lock(&data->lock);
+			ret =3D hdc2010_get_measurement_word(data, chan);
+			mutex_unlock(&data->lock);
+			iio_device_release_direct_mode(indio_dev);
+			if (ret >=3D 0) {
+				*val =3D ret;
+				ret =3D IIO_VAL_INT;
+			} else
+				ret =3D -EINVAL;
+		}
+		return ret;
+	}
+	case IIO_CHAN_INFO_PEAK: {
+		int ret;
+
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		mutex_lock(&data->lock);
+		ret =3D hdc2010_get_measurement_byte(data, chan);
+		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret >=3D 0) {
+		  /* Scaling up the value so we can use same offset as RAW */
+			*val =3D ret * 256;
+			ret =3D IIO_VAL_INT;
+		} else
+			ret =3D -EINVAL;
+		return ret;
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
+	int new, ret =3D -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type !=3D IIO_CURRENT || val2 !=3D 0)
+			return -EINVAL;
+
+		if (val =3D=3D 1)
+			new =3D HDC2010_HEATER_EN;
+		else if (!val)
+			new =3D 0;
+		else
+			return -EINVAL;
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
+	indio_dev->name =3D dev_name(&client->dev);
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &hdc2010_info;
+
+	indio_dev->channels =3D hdc2010_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(hdc2010_channels);
+
+	/* Enable Automatic Measurement Mode at 5Hz */
+	hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);
+
+	/*
+	 * We enable both temp and humidity measurement.
+	 * However the measurement won't start even in AMM until triggered.
+	 */
+	tmp =3D (u8)(~HDC2010_MEAS_CONF |
+		   HDC2010_MEAS_TRIG & data->measurement_config) |
+		HDC2010_MEAS_TRIG;
+
+	ret =3D i2c_smbus_write_byte_data(data->client,
+					HDC2010_REG_MEASUREMENT_CONF, tmp);
+	if (ret)
+		return ret;
+	data->measurement_config =3D tmp;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id hdc2010_id[] =3D {
+	{ "hdc2010", 0 },
+	{ "hdc2080", 0 },
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
+		.of_match_table =3D of_match_ptr(hdc2010_dt_ids),
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

