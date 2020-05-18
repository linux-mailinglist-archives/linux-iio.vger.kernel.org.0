Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5CB1D880C
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgERTPf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 15:15:35 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:36329
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727775AbgERTPe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 May 2020 15:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nna0Yi8B3OnHI9aqXqgc+FBDO30HIhSvINTm4U9bM+KVKcbLGkY2DipplMuBe0qPHAz458lii0W/tEN2NVP/OpV5PuY9CbOlIFdkXO/IUiO3eGiPIt8a01Vc09AbpiewdHZVslB0aEik4ayVgD5H06njz55xts/rKToIQUV1jnT+37KKxB9qY+LO5Xd59EC/RmMJeoDJMdC5+scjOPjwPBLHPMOXz/MoIWGCg9h5MmX9uyuJMtSG8P5GVAqq76rA85cSyrBxEzPCRHy3FDTjxWAfykKbfcnT9Y4kvbRjMRwXZOZQ11MHxTdq356j+9kyWU3uv6UUp5KFLuedZjNeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASSubHnx1lMDESr6fG30xCmLWPSsNE/vRJodLC3Leds=;
 b=bdJyZNGg6Nmf2fbFjjic+1n0O+zgwf0n3jJ7/E8YbMo94gPs7eRRz7fO44FoQCUb1+eeWWlIL01TUJK7rfzGWvLd5JbjB7c4ZMRchubvrr/7CfO/yceU2s4BUbBquUs/JsRcFMLFQ4iE7QHzJxTW0/34a6ZK2Gt0dS72orI2y0l1UGrc8Y+08qDe2RmQDDjw7zPzF/TqxrUYO8MYPvKLlz6ETS2pyw6iJ5SlkVbXxCKEtYd9IP+XL/LHMJwHT0ORkSIFcgCAytjUN1LJ7dq54bo3h9oYRsTzxu/FgtHbYc6Ua4hMt9GJ8aIrtI7enfKb7yNwhuNJT3Mms13K/tD4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASSubHnx1lMDESr6fG30xCmLWPSsNE/vRJodLC3Leds=;
 b=RPpcRuzcJY7FRork24QR9HSeFtvPpnZPc/xXsWKwXYtgX5EjJPoaLr3WAVuqqK7UIWKxqrsKc+gmX2dD26znVLByOub57FISk2cvx5Hkxj9VI1gFGUXuESI+/vZdS0ks7Ac2G+MeXAljkn7AH7ps7IZNkbsdLhj8t6WkYLQSYo8=
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB6088.eurprd06.prod.outlook.com (2603:10a6:20b:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 19:15:27 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::6505:f0e6:d0df:c1c0]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::6505:f0e6:d0df:c1c0%5]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 19:15:27 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH v8 1/2] Driver for TI HDC20x0 humidity and temperature sensors
Thread-Topic: [PATCH v8 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Index: AQHWLUiwUiklrzaF+EWXa7Utf5Qb0A==
Date:   Mon, 18 May 2020 19:15:27 +0000
Message-ID: <5489E47F-47D4-421A-A7EA-E11B0205A842@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=norphonic.com;
x-originating-ip: [85.165.43.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4818670-2bed-4cc9-953e-08d7fb5fd2f7
x-ms-traffictypediagnostic: AM6PR06MB6088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR06MB608830C0C26ED9FB20A610F6CAB80@AM6PR06MB6088.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Cs6kkUpamMeFvRjkUqfYvnzrvTA87xxoBd13j8cxl5AOh9Z4HDFuUl6CZP9lMtj8FKgQlplFC4Gfbf7fpcUPcaT2pk8OF++fTOOaZurwrWZgbbzSGJ/S7vM3XseWvswplJdkwT7ptwAk9OG8flf/eCnY+2zRnovbJE+5bUGsfWsVIBbFjwoyZgE3VPJo682bDUhv1lQcx5DD+eHfWQVhqp1w+/yHkvLaETQ50O5TJzbqaYju6bEin7373oEpIouruRdPH9GUaFDdGm473m909IKWdaR/f2uZHp0ZrESn057Pxv/2ELpzizKbVrOPgOuOkFGrbhWmjgUmIgKRXSYRnmx8wnhiEvgQ0Fnel8jFrs0VCgtK0xhH7J9pq1V1m1PQHseMbxnVBUh+bYCwMlxA341dRo6Zs0cf/LivzSwxlyQvnywTGnX2iH77HpPke33NyQhNwT3WkIFq1w1DOK4OXG1u8/cRA3Tifu2Koab3JRlnuHlQ+LLmvsaeTvQDOqACc3hBQ1LOzgvuLyKbTVDrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(39830400003)(396003)(376002)(66946007)(66476007)(71200400001)(4326008)(8936002)(6506007)(316002)(2906002)(186003)(36756003)(6512007)(33656002)(5660300002)(91956017)(30864003)(508600001)(66556008)(64756008)(66446008)(6916009)(76116006)(6486002)(8676002)(966005)(2616005)(26005)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hlVd+Y1rpRqg71JsjsOlU+wXbQW5NfUDfEiQEoC5bNvyt+8Ak4VZOJ3jnwE5GggKDX4v/w0Vmsfbn6tB4OgF0G64h169lt7IY9JT95pEXihzM5Uqg6KhIuweKC8jJ6iG9G3cj6vF0gLp7/jotOWIBS9tmDwtx7F3eIYlOoQ0vDCPZnj2pNAijXh1ori/9uxhKc1hlxA2PlBnu9ippuKJgoyvdPqM45BPM8VIhUlQL58tb7Hld9m86pkPCD1mtTiD5clKHY6+Q3e5i0DDEXfidCSJC17lCHXj2PEm++DvfJJ3/IbFn4WpEmnuxVktFQBVU8EZ8CqjDDA1646QaSpgGTOmajj92xFAm2cvWOaqRgN3xK5F2A6bWJR8mQ5+lazBChJWkWYfv5gn8nnlc/i7mR25pP6+e3iE3ZshWvi3SAaHri/wQwCFOHk4bz+10PiCLM6vEDRY+CSltGdFHhdNDl5K9YXh6H4cleN8b2ThkJQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70F83758E2697A4D9243DAEEF2DFDD2D@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4818670-2bed-4cc9-953e-08d7fb5fd2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 19:15:27.4791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FT2TBkdmNeLgtLMGrOmKGxT/XKJuvP9rfdDRg6U8dr5p4GVSC4ksbwKMYdjv2HOkT80SKWfUDDg8oQs8j+Z9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB6088
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
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-05-15 17:26:27.=
121390638 +0200
@@ -0,0 +1,348 @@
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
+	u8 tmp =3D (~mask & data->drdy_config) | val;
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
+		dev_err(&client->dev, "Could not read sensor measurement word\n");
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
+		dev_err(&client->dev, "Could not read sensor measurement byte\n");
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
+static int hdc2010_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct hdc2010_data *data =3D iio_priv(indio_dev);
+
+	/* Disable Automatic Measurement Mode */
+	if (hdc2010_update_drdy_config(data, HDC2010_AMM, 0))
+		dev_warn(&client->dev, "Unable to restore default AMM\n");
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
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
+	.remove =3D hdc2010_remove,
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

