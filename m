Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC015CDE7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2020 23:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBMWNQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Feb 2020 17:13:16 -0500
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:7138
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgBMWNQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Feb 2020 17:13:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRZ5aYEuj8BKOMsRiWG/ry8/CRk20b0lyqx4uUSnt9bftVnIq49N7GRbHyTN5yLwqC417uJM19xU6Fxpmixe2G2/OkRsO4t8QTx+xu5mlrj0GZ9/GZNoPgyFkYzo1OIKkT0Qn1gqVSIShoVt0/ICF7wLRUZnRuUFNa8gD1Lyt1c8hmnDnDyj7LVzhlMauacfZ6WdG3TXDWnotumfXY9WnXf95JS/aiFklf4CoqR50xzdj383VyOixvE56vIBLHCU+S4jdhREXW2mcXKIhs1vPhxPbGNt8ky6UF9V4XtVeeq4Hej5Wjso2RXK1IA2pXj0VxYjyHtCtKzbDRXJAApcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUsvJsKa6wiuGdaGuofEujMCf2vzziHqu0OrqqtlnBk=;
 b=BDjYhj1vtz++0E0YEnp5LgNqCxulBQdVKaeh9OvCWOPWtomxNMc8/GEZOToSgSZp/pod7wke/gJJxzdvLMwm8dbgljTSYkGUScoDYPWiSaLYRHBWH+wYoUZbHSv6S0Rgs5XjIzkn2mp4j4lE9K6JKEAnBMiFOsXQoBwYNbQuRvnenXRpxzMssQBzoPk3u34OwpNH1P+qNsAzzGBDvyMb7lD5PA9iI2xCKrJJHvl+DxJexMvgMGE7uVUrMK2//k32ScC/dHaakJ7FN32xbFT8ptTp69N9+KBTotpOOKqIgDbWI7pac27md3cQJ+nDy02mJxCr5BZl7pH0YiqQGApRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUsvJsKa6wiuGdaGuofEujMCf2vzziHqu0OrqqtlnBk=;
 b=VrOPrMIRB+andHoMQFtbNnQ8SensLUf1YeRY6FiehnGYmMLzk6zSap77i2BMp/P6DRF7CKeCOoKam+QsbLZvexANnODnMv4y/7oZXrHbp+ojPTZk6HOGrwaod4/Eo10IZwNQTsoh3xc2fzGNgeY1OlejooiSmwqPV2OyuyvyTpE=
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com (10.170.210.140) by
 DB6PR06MB4023.eurprd06.prod.outlook.com (10.168.25.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Thu, 13 Feb 2020 22:13:07 +0000
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::d9df:8743:dbc9:e247]) by DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::d9df:8743:dbc9:e247%3]) with mapi id 15.20.2707.031; Thu, 13 Feb 2020
 22:13:07 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH v5 1/2] Driver for TI HDC20x0 humidity and temperature sensors 
Thread-Topic: [PATCH v5 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors 
Thread-Index: AQHV4rrE3k3V+9qQBEOkqKU+EogJeA==
Date:   Thu, 13 Feb 2020 22:13:07 +0000
Message-ID: <CF7736B3-95D6-43E4-BC69-DDB0DFE2A86A@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [85.166.70.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90912d44-30e8-40d9-5871-08d7b0d1e76f
x-ms-traffictypediagnostic: DB6PR06MB4023:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR06MB40233FBEB766FC8C8E6D6629CA1A0@DB6PR06MB4023.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39830400003)(376002)(396003)(366004)(189003)(199004)(2616005)(26005)(6506007)(2906002)(508600001)(966005)(86362001)(36756003)(6486002)(6916009)(71200400001)(4743002)(6512007)(33656002)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(4326008)(5660300002)(186003)(30864003)(8676002)(54906003)(91956017)(76116006)(81156014)(81166006)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR06MB4023;H:DB6PR06MB3048.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: obtdv6fMozrDjIacNJplxJXEwMcKTQ7cbYQBXJgbl35rep8YjGHrsWpYEAA+8866Me39Kg/oM9YPlOgEsdU/DqLTLsoZCdQxfh4bkxc6Ii8ME67ExZv5H+puAia3ogTqfAI1iwyu2xQFPgTiOFR2G98/hDFiuwaCBGwn4t75dUq2yS+eo1UwFUvvjKZesz+hGaXlgv8dM8vuKvzpsa9q+hiH91o1cMmaL0IWQOFWIHcVJE/n6NdKJlRfDRFsBtXaLnW1imW775EprzdGpFlJWFKEl7aGJf0GUq6wZN8fmEWUzfemfStXJQ2F82i5bUFQFeIKbtgtSNazsGrwphKsY6/qMe9hZTqfPd5dKHgUQ8h8IN1TtpCkUhFHEr6d7+MwDBzosazwjKdlb7DPsKDOn/lF6UsOP/4Pcr14vX3EBw7rGjWxJCBM+mDqA0+qvmtNQfUPP/hKvbrUisaiJ2FRzgCqt3JEWiFT+LM3rEgf0v3bcaMm1ThR0xosMmFEwxpLN4WJIb+e+ONVJKr/PsuFfA==
x-ms-exchange-antispam-messagedata: IDLMNhuI57jrZYVBySiI6JPVP4F9kUIoGDXQGgjg9bS7drQiuKOYaPYRdwB3YNWDnymCMC/b9E2zOMumKRlAoddF2PtC9yekvCu+V7EK+7wnMTGF4VwenKXJjNhbirkGihiEprrwnTlsyZuSrkCB6g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63767CFBC917C8488422C62533E1F2CB@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90912d44-30e8-40d9-5871-08d7b0d1e76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 22:13:07.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lFpUgaun/uB/aGXHmZk/GT/U/dNs1ByBuIsuXfGQnkHKfG2TJ1ru/PJdKl961VGAYx8mY8Bn+pwn3mzFRZNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB4023
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Amended HDC2010/2080 diver and sysfs documentation for its heater element.

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
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-02-13 15:33:58.=
210958154 +0100
@@ -0,0 +1,333 @@
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
+	ret =3D i2c_smbus_read_word_data(client,
+			hdc2010_reg_translation[chan->address].primary);
+
+	if (ret < 0)
+		dev_err(&client->dev, "Could not read sensor data\n");
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
+			}
+
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
+		}
+
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

