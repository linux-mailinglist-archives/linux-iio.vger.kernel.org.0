Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877A310CF13
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 21:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1UGi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 15:06:38 -0500
Received: from mail-eopbgr60127.outbound.protection.outlook.com ([40.107.6.127]:62848
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbfK1UGi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Nov 2019 15:06:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wpk4ZzeKO0X7R1xcj8leOZ/NhFVpO4Fu7Gv781gPPmE7sdewEgy5EH57gno0DWbVqIrHCMpb/JOk23Sepc/ZAQL4gNGYEBCgiLSUL4pjUMZTvMqQBTWZ+hpzW+gAuA3SW43uRG/XH6DJaFNaZZM7A11dPwXxU8SSzXcDtSHXwylrDJiYxjtq3FdURg+MAWGr5H3sR0l+NjV4N4NqQLwQYaBYGw+IsurGJIEilCtBMxrKQHrJCNMo0NqCYSAkCy7/DRUwNDsPHdAWRr4kG2BTNfgrMeFFNBFMlOIAhZkwrS7i541DuIy9JK5uWlLM0UExm1zLBHeMq8k8cU1Fmky4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edQxVudZXSZjuz2tMzbYIKei4/kuR7hJLsny7UxmhGc=;
 b=ZfkWkniXSn3BCRov4oPUSElcvDAV8l8mPQ5rEbyYKQDu/0z6neMVOW8C5RUIkt0C1TbPHGABWNw7ZtsFL5ZWrq1d9/KBvDUg/odGUHKTHnbKfxVnJ5vVALkmHhOC8LzOJUAMRUtBEp2aJnzO/EEO4OQa7muL8dHtvX3pN7MIyPJRDORhVBN9ekGtBJAWm5KI6bYHhA5BtnWDGoqULWsCrFjHn63JOtKjcRzAlQ27wdCa12SkjNMuLluGcHp5LECO0wwjXA1qODHbNGa4P4+QdQ/AIP1AtskUlH8MNtOPpSRr8RZXDOcniX+nmrT58y6bWf63xPzjLZ6rwA0256FrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edQxVudZXSZjuz2tMzbYIKei4/kuR7hJLsny7UxmhGc=;
 b=co4LQZTOZ+2KTtAc/5syt21oGmVrRQAexr/DIh4PRJlUmSWtTAm200ew6+iPbRcI43BxyWQASVGZPIx777WXQFx/7QiRNHSTcV4D1CSnvTxIpyPM+LVEtgWzOaFNGjTTksxDK08Tb8cO7GzsvABuZOChqN2QuRVn3Pbe70ieM5M=
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com (20.177.202.94) by
 VI1PR06MB5341.eurprd06.prod.outlook.com (20.178.80.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 20:06:33 +0000
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::5438:c401:b17e:c0b1]) by VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::5438:c401:b17e:c0b1%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 20:06:33 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: =?iso-8859-1?Q?[PATCH_v2_1/2]=A0Driver_for_TI_HDC20x0_humidity_and_temper?=
 =?iso-8859-1?Q?ature_sensors_?=
Thread-Topic: =?iso-8859-1?Q?[PATCH_v2_1/2]=A0Driver_for_TI_HDC20x0_humidity_and_temper?=
 =?iso-8859-1?Q?ature_sensors_?=
Thread-Index: AQHVpidUlDVIwfhWkk2Xbc7byjUKnw==
Date:   Thu, 28 Nov 2019 20:06:32 +0000
Message-ID: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6cea662-d9a1-4e3b-c915-08d7743e770d
x-ms-traffictypediagnostic: VI1PR06MB5341:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR06MB5341ADBC68D3A4DF790F22AFCA470@VI1PR06MB5341.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(396003)(376002)(366004)(136003)(189003)(199004)(33656002)(26005)(3846002)(71200400001)(6306002)(6116002)(6512007)(6486002)(4743002)(2616005)(7736002)(71190400001)(508600001)(66066001)(14454004)(81166006)(81156014)(305945005)(966005)(25786009)(186003)(14444005)(6506007)(256004)(54906003)(99286004)(8936002)(36756003)(86362001)(6436002)(5660300002)(102836004)(110136005)(76116006)(66476007)(91956017)(64756008)(2906002)(66946007)(66556008)(316002)(66446008)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB5341;H:VI1PR06MB5790.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xg1t7HAToeDLWYCfptgStqkGtA49ghFMyPSEHhnOZPNJQ3+Rfqn7uaJPxP6sSt0rhTRoiSpM6bqzrGov0BzVx9nmBPrvKi+/aJv2jsFHesKIZNh7grp+7US5HXOX8dj5kYNHqCWkT+GQba4kCP54S70F0HnLzFXJ083rIImO+m0hlcn/hkmwGyopet/bLnMjJmaqrk9jXljYdp2X2J8VSTqBaA9o+bDWZiWxIDusTr36PrSj2cvpLpzQnO8+Z17F2ZcGngObcoPqDVtZeavE+01Rjmdzu/HtW5SnpNs5INx6SQKYOWmCQZKHRfqIXhDAtStD5aanz1LOHTDrzU5iboVnd9hPyzXlIL2NO1VNNL+sZXMb1jBbm2NIH1N0wSIYBDXwmlTnf1MCG4RZIAGBu/Jn+1X7rXXfdVE+LhMlsr6uTrs//9y8BgbNZ4Rg7Ei9DNd5JKf7P4YfUhqLKV5Rt7EdiKnnmwMl5/q3lI1qxbs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D79D232CFC5DF04E91670BA6691D37A7@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cea662-d9a1-4e3b-c915-08d7743e770d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 20:06:32.8791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KogKdK8g1uVzmFZbTjL54qhwLyNoaIruHDI8qwQh/UgnsSvHDRnQXJLxG7m5skIrYKW0Ca6BotNc82lWMTXplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5341
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Here comes the revised driver for TI HDC 2010 and 2080 humidity and tempera=
ture sensors.
This includes amendments following the initial review. Max temp and humidit=
y are now made into peak channels. These are made to share the scales and o=
ffsets with primary channels as suggested.
(BTW, any particular reason there is no IIO_CHAN_INFO_PEAK_OFFSET in the co=
re?)

Heater out has been converted to IIO_CHAN_INFO_ENABLE, hope it is idiomatic=
 use.

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/hu=
midity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
--- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.00000000=
0 +0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2019-11-28 12:42:06.=
092046846 +0100
@@ -0,0 +1,313 @@
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
+static const struct iio_chan_spec hdc2010_channels[] =3D {
+	{
+		.type =3D IIO_TEMP,
+		.address =3D HDC2010_REG_TEMP_LOW,
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type =3D IIO_TEMP,
+		.address =3D HDC2010_REG_TEMP_MAX,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PEAK),
+	},
+	{
+		.type =3D IIO_HUMIDITYRELATIVE,
+		.address =3D HDC2010_REG_HUMIDITY_LOW,
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type =3D IIO_HUMIDITYRELATIVE,
+		.address =3D HDC2010_REG_HUMIDITY_MAX,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PEAK),
+	},
+	{
+		.type =3D IIO_CURRENT,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_ENABLE),
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
+	ret =3D i2c_smbus_read_word_data(data->client, chan->address);
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
+	ret =3D i2c_smbus_read_byte_data(data->client, chan->address);
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
+	case IIO_CHAN_INFO_ENABLE: {
+		int ret;
+
+		mutex_lock(&data->lock);
+		if (chan->type =3D=3D IIO_CURRENT) {
+			*val =3D hdc2010_get_heater_status(data);
+			ret =3D IIO_VAL_INT;
+		} else
+			ret =3D -EINVAL;
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+	case IIO_CHAN_INFO_RAW: {
+		int ret;
+
+		mutex_lock(&data->lock);
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+		ret =3D hdc2010_get_measurement_word(data, chan);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret >=3D 0) {
+			*val =3D ret;
+			ret =3D IIO_VAL_INT;
+		} else
+			ret =3D -EINVAL;
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+	case IIO_CHAN_INFO_PEAK: {
+		int ret;
+
+		mutex_lock(&data->lock);
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+		ret =3D hdc2010_get_measurement_byte(data, chan);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret >=3D 0) {
+		  /* Scaling up the value so we can use same offset as RAW */
+			*val =3D ret * 256;
+			ret =3D IIO_VAL_INT;
+		} else
+			ret =3D -EINVAL;
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+	case IIO_CHAN_INFO_PEAK_SCALE:
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
+	case IIO_CHAN_INFO_ENABLE:
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
+};
+
+static int hdc2010_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct hdc2010_data *data;
+	u8 tmp;
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
+		   HDC2010_MEAS_TRIG & data->measurement_config)
+	       | HDC2010_MEAS_TRIG;
+
+	if (!i2c_smbus_write_byte_data(data->client,
+				       HDC2010_REG_MEASUREMENT_CONF, tmp))
+		data->measurement_config =3D tmp;
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

