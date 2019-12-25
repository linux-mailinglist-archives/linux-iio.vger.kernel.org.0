Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CDA12A6D1
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2019 09:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLYIlt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Dec 2019 03:41:49 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:56434 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfLYIlt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Dec 2019 03:41:49 -0500
X-Greylist: delayed 1917 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 03:41:45 EST
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBP89jfr004786;
        Wed, 25 Dec 2019 08:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=08102019;
 bh=qu24QIRzMzfkm/z11IZ0dF4AVfxke/mfIv2hKyfQJlA=;
 b=GdFk1USAVMtbs4bUrqu+NzT2dBmm6BpcSm8xcmIQ/+rjB8r8WhDUnH+d3mLlAh0I4Njo
 3jCwUTAy27kqygVg+xzV+iIbz/GSi0Wu5hWbu0+XKOaTZrWRryyim/XGOPFAf4gJzg88
 6Bh7B5bhzfsBzuvPYv81ydjGWEExpLoeiTmyeXShqd4/yp0PfzpvCZyrCpydXVClUZ7h
 zxgoeYIhy+B5giEBttblYWN4B/iN00iIMiNL41PkpugUWt9AJK3pIjMp167VVzYAO1Cz
 M6Z0/CDE+TUpSZMicfHKEhjca6VxRwXhGk9SOTh2bxTMhJGlZtb54527Y3rp74lySKeS iw== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2x1ckhcxq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 08:09:44 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xBP85aV5007263;
        Wed, 25 Dec 2019 09:09:39 +0100
Received: from atgrzsw1693.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 2x1byp8y8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 09:09:39 +0100
Received: from ATGRZSW1692.avl01.avlcorp.lan (10.12.64.113) by
 atgrzsw1693.avl01.avlcorp.lan (10.12.64.114) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Dec 2019 09:09:39 +0100
Received: from ATGRZSW1692.avl01.avlcorp.lan ([172.18.42.156]) by
 ATGRZSW1692.avl01.avlcorp.lan ([172.18.42.156]) with mapi id 15.00.1497.000;
 Wed, 25 Dec 2019 09:09:39 +0100
From:   "Denis, Tomislav AVL DiTEST" <Tomislav.Denis@avl.com>
To:     'Jonathan Cameron' <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] iio: pressure: Add driver for DLH pressure sensors
Thread-Topic: [PATCH v4 1/3] iio: pressure: Add driver for DLH pressure
 sensors
Thread-Index: AQHVsAm4Bk5l/Tu0FUGgyDAq2mcbZKfH/+iAgAKUQZA=
Date:   Wed, 25 Dec 2019 08:09:38 +0000
Message-ID: <73e3ee1a69c343329ef39bf2b88020a9@ATGRZSW1692.avl01.avlcorp.lan>
References: <20191211095946.7904-1-tomislav.denis@avl.com>
        <20191211095946.7904-2-tomislav.denis@avl.com>
 <20191223174241.779856de@archlinux>
In-Reply-To: <20191223174241.779856de@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.12.100.12]
x-exclaimer-md-config: f9e74532-fb7d-4806-8539-2b9574eafa9a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-25_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912250066
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-25_01:2019-12-24,2019-12-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912250065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> On Wed, 11 Dec 2019 10:59:44 +0100
> <tomislav.denis@avl.com> wrote:
>=20
> > From: Tomislav Denis <tomislav.denis@avl.com>
> >
> > All Sensors DLH is series of low voltage digital pressure sensors.
> > Additionally to pressure value sensors deliver a temperature value.
> > Sensors can be accessed over I2C and SPI, this driver supports only
> > I2C access.
> >
> > Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
>=20
> Gah. My explanation on the wildcard naming thing was not clear before.
> Sorry about that.  What I meant was this needs to have an explicit
> name after a single part number.   I've renamed
> as dlhl60d.c and all similar places.
> I left the define prefix as DLH_ as unlikely we'll get any problems with =
that.
>=20
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to see if they can break it.
>=20
> Thanks,
>=20
> Jonathan
>=20

Hi Jonathan,

Ok great. Thanks a lot for helping me with this, I've learned a lot from yo=
u.

Tomislav

> > ---
> >  MAINTAINERS                   |   7 +
> >  drivers/iio/pressure/Kconfig  |  12 ++
> >  drivers/iio/pressure/Makefile |   1 +
> >  drivers/iio/pressure/dlh.c    | 375
> ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 395 insertions(+)
> >  create mode 100644 drivers/iio/pressure/dlh.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index d5ea4e4..0fa24df 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -668,6 +668,13 @@ S:	Maintained
> >  F:	Documentation/i2c/busses/i2c-ali1563.rst
> >  F:	drivers/i2c/busses/i2c-ali1563.c
> >
> > +ALL SENSORS DLH SERIES PRESSURE SENSORS DRIVER
> > +M:	Tomislav Denis <tomislav.denis@avl.com>
> > +W:	http://www.allsensors.com/
> > +S:	Maintained
> > +L:	linux-iio@vger.kernel.org
> > +F:	drivers/iio/pressure/dlh.c
> > +
> >  ALLEGRO DVT VIDEO IP CORE DRIVER
> >  M:	Michael Tretter <m.tretter@pengutronix.de>
> >  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> > diff --git a/drivers/iio/pressure/Kconfig
> > b/drivers/iio/pressure/Kconfig index ba420e4..3d383d8 100644
> > --- a/drivers/iio/pressure/Kconfig
> > +++ b/drivers/iio/pressure/Kconfig
> > @@ -53,6 +53,18 @@ config IIO_CROS_EC_BARO
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called cros_ec_baro.
> >
> > +config DLH
> > +	tristate "All Sensors DLH series low voltage digital pressure sensors=
"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say yes here to build support for the All Sensors DLH series
> > +	  pressure sensors driver.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called dlh.
> > +
> >  config DPS310
> >  	tristate "Infineon DPS310 pressure and temperature sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/pressure/Makefile
> > b/drivers/iio/pressure/Makefile index d8f5ace..c609ad4 100644
> > --- a/drivers/iio/pressure/Makefile
> > +++ b/drivers/iio/pressure/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_BMP280) +=3D bmp280.o  bmp280-objs :=3D
> > bmp280-core.o bmp280-regmap.o
> >  obj-$(CONFIG_BMP280_I2C) +=3D bmp280-i2c.o
> >  obj-$(CONFIG_BMP280_SPI) +=3D bmp280-spi.o
> > +obj-$(CONFIG_DLH) +=3D dlh.o
> >  obj-$(CONFIG_DPS310) +=3D dps310.o
> >  obj-$(CONFIG_IIO_CROS_EC_BARO) +=3D cros_ec_baro.o
> >  obj-$(CONFIG_HID_SENSOR_PRESS)   +=3D hid-sensor-press.o
> > diff --git a/drivers/iio/pressure/dlh.c b/drivers/iio/pressure/dlh.c
> > new file mode 100644 index 0000000..18fc4e1
> > --- /dev/null
> > +++ b/drivers/iio/pressure/dlh.c
> > @@ -0,0 +1,375 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * All Sensors DLH series low voltage digital pressure sensors
> > + *
> > + * Copyright (c) 2019 AVL DiTEST GmbH
> > + *   Tomislav Denis <tomislav.denis@avl.com>
> > + *
> > + * Datasheet: http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/trigger_consumer.h> #include
> > +<linux/iio/triggered_buffer.h> #include <asm/unaligned.h>
> > +
> > +/* Commands */
> > +#define DLH_START_SINGLE    0xAA
> > +
> > +/* Status bits */
> > +#define DLH_STATUS_OK       0x40
> > +
> > +/* DLH  data format */
> > +#define DLH_NUM_READ_BYTES  7
> > +#define DLH_NUM_DATA_BYTES  3
> > +#define DLH_NUM_PR_BITS     24
> > +#define DLH_NUM_TEMP_BITS   24
> > +
> > +/* DLH  timings */
> > +#define DLH_SINGLE_DUT_MS   5
> > +
> > +enum dhl_ids {
> > +	dlhl60d,
> > +	dlhl60g,
> > +};
> > +
> > +struct dlh_info {
> > +	u8 osdig;           /* digital offset factor */
> > +	unsigned int fss;   /* full scale span (inch H2O) */
> > +};
> > +
> > +struct dlh_state {
> > +	struct i2c_client *client;
> > +	struct dlh_info info;
> > +	bool use_interrupt;
> > +	struct completion completion;
> > +	u8 rx_buf[DLH_NUM_READ_BYTES] ____cacheline_aligned; };
> > +
> > +static struct dlh_info dlh_info_tbl[] =3D {
> > +	[dlhl60d] =3D {
> > +		.osdig =3D 2,
> > +		.fss =3D 120,
> > +	},
> > +	[dlhl60g] =3D {
> > +		.osdig =3D 10,
> > +		.fss =3D 60,
> > +	},
> > +};
> > +
> > +
> > +static int dlh_cmd_start_single(struct dlh_state *st) {
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_write_byte(st->client, DLH_START_SINGLE);
> > +	if (ret)
> > +		dev_err(&st->client->dev,
> > +			"%s: I2C write byte failed\n", __func__);
> > +
> > +	return ret;
> > +}
> > +
> > +static int dlh_cmd_read_data(struct dlh_state *st) {
> > +	int ret;
> > +
> > +	ret =3D i2c_master_recv(st->client, st->rx_buf,
> DLH_NUM_READ_BYTES);
> > +	if (ret < 0) {
> > +		dev_err(&st->client->dev,
> > +			"%s: I2C read block failed\n", __func__);
> > +		return ret;
> > +	}
> > +
> > +	if (st->rx_buf[0] !=3D DLH_STATUS_OK) {
> > +		dev_err(&st->client->dev,
> > +			"%s: invalid status 0x%02x\n", __func__, st-
> >rx_buf[0]);
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int dlh_start_capture_and_read(struct dlh_state *st) {
> > +	int ret;
> > +
> > +	if (st->use_interrupt)
> > +		reinit_completion(&st->completion);
> > +
> > +	ret =3D dlh_cmd_start_single(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->use_interrupt) {
> > +		ret =3D wait_for_completion_timeout(&st->completion,
> > +			msecs_to_jiffies(DLH_SINGLE_DUT_MS));
> > +		if (!ret) {
> > +			dev_err(&st->client->dev,
> > +				"%s: conversion timed out\n", __func__);
> > +			return -ETIMEDOUT;
> > +		}
> > +	} else {
> > +		mdelay(DLH_SINGLE_DUT_MS);
> > +	}
> > +
> > +	return dlh_cmd_read_data(st);
> > +}
> > +
> > +static int dlh_read_direct(struct dlh_state *st,
> > +	unsigned int *pressure, unsigned int *temperature) {
> > +	int ret;
> > +
> > +	ret =3D dlh_start_capture_and_read(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*pressure =3D get_unaligned_be32(&st->rx_buf[1]) >> 8;
> > +	*temperature =3D get_unaligned_be32(&st->rx_buf[3]) &
> > +		GENMASK(DLH_NUM_TEMP_BITS - 1, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dlh_read_raw(struct iio_dev *indio_dev,
> > +	struct iio_chan_spec const *channel, int *value,
> > +	int *value2, long mask)
> > +{
> > +	struct dlh_state *st =3D iio_priv(indio_dev);
> > +	unsigned int pressure, temperature;
> > +	int ret;
> > +	s64 tmp;
> > +	s32 rem;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D dlh_read_direct(st, &pressure, &temperature);
> > +		iio_device_release_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (channel->type) {
> > +		case IIO_PRESSURE:
> > +			*value =3D pressure;
> > +			return IIO_VAL_INT;
> > +
> > +		case IIO_TEMP:
> > +			*value =3D temperature;
> > +			return IIO_VAL_INT;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (channel->type) {
> > +		case IIO_PRESSURE:
> > +			tmp =3D div_s64(125LL * st->info.fss * 24909 * 100,
> > +				1 << DLH_NUM_PR_BITS);
> > +			tmp =3D div_s64_rem(tmp, 1000000000LL, &rem);
> > +			*value =3D tmp;
> > +			*value2 =3D rem;
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +
> > +		case IIO_TEMP:
> > +			*value =3D 125 * 1000;
> > +			*value2 =3D DLH_NUM_TEMP_BITS;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (channel->type) {
> > +		case IIO_PRESSURE:
> > +			*value =3D -125 * st->info.fss * 24909;
> > +			*value2 =3D 100 * st->info.osdig * 100000;
> > +			return IIO_VAL_FRACTIONAL;
> > +
> > +		case IIO_TEMP:
> > +			*value =3D -40 * 1000;
> > +			return IIO_VAL_INT;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info dlh_info =3D {
> > +	.read_raw =3D dlh_read_raw,
> > +};
> > +
> > +static const struct iio_chan_spec dlh_channels[] =3D {
> > +	{
> > +		.type =3D IIO_PRESSURE,
> > +		.indexed =3D 1,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type =3D
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_OFFSET),
> > +		.scan_index =3D 0,
> > +		.scan_type =3D {
> > +			.sign =3D 'u',
> > +			.realbits =3D DLH_NUM_PR_BITS,
> > +			.storagebits =3D 32,
> > +			.shift =3D 8,
> > +			.endianness =3D IIO_BE,
> > +		},
> > +	}, {
> > +		.type =3D IIO_TEMP,
> > +		.indexed =3D 1,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type =3D
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_OFFSET),
> > +		.scan_index =3D 1,
> > +		.scan_type =3D {
> > +			.sign =3D 'u',
> > +			.realbits =3D DLH_NUM_TEMP_BITS,
> > +			.storagebits =3D 32,
> > +			.shift =3D 8,
> > +			.endianness =3D IIO_BE,
> > +		},
> > +	}
> > +};
> > +
> > +static irqreturn_t dlh_trigger_handler(int irq, void *private) {
> > +	struct iio_poll_func *pf =3D private;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct dlh_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +	unsigned int chn, i =3D 0;
> > +	__be32 tmp_buf[2];
> > +
> > +	ret =3D dlh_start_capture_and_read(st);
> > +	if (ret)
> > +		goto out;
> > +
> > +	for_each_set_bit(chn, indio_dev->active_scan_mask,
> > +		indio_dev->masklength) {
> > +		memcpy(tmp_buf + i,
> > +			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> > +			DLH_NUM_DATA_BYTES);
> > +		i++;
> > +	}
> > +
> > +	iio_push_to_buffers(indio_dev, tmp_buf);
> > +
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t dlh_interrupt(int irq, void *private) {
> > +	struct iio_dev *indio_dev =3D private;
> > +	struct dlh_state *st =3D iio_priv(indio_dev);
> > +
> > +	complete(&st->completion);
> > +
> > +	return IRQ_HANDLED;
> > +};
> > +
> > +static int dlh_probe(struct i2c_client *client,
> > +	const struct i2c_device_id *id)
> > +{
> > +	struct dlh_state *st;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +		I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE)) {
> > +		dev_err(&client->dev,
> > +			"adapter doesn't support required i2c
> functionality\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
> > +	if (!indio_dev) {
> > +		dev_err(&client->dev, "failed to allocate iio device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	st->info =3D dlh_info_tbl[id->driver_data];
> > +	st->client =3D client;
> > +	st->use_interrupt =3D false;
> > +
> > +	indio_dev->name =3D id->name;
> > +	indio_dev->dev.parent =3D &client->dev;
> > +	indio_dev->dev.of_node =3D client->dev.of_node;
> > +	indio_dev->info =3D &dlh_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D  dlh_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(dlh_channels);
> > +
> > +	if (client->irq > 0) {
> > +		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> > +			dlh_interrupt, NULL,
> > +			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > +			id->name, indio_dev);
> > +		if (ret) {
> > +			dev_err(&client->dev, "failed to allocate threaded
> irq");
> > +			return ret;
> > +		}
> > +
> > +		st->use_interrupt =3D true;
> > +		init_completion(&st->completion);
> > +	}
> > +
> > +	ret =3D devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> > +		NULL, &dlh_trigger_handler, NULL);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to setup iio buffer\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_iio_device_register(&client->dev, indio_dev);
> > +	if (ret)
> > +		dev_err(&client->dev, "failed to register iio device\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id dlh_of_match[] =3D {
> > +	{ .compatible =3D "asc,dlhl60d" },
> > +	{ .compatible =3D "asc,dlhl60g" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, dlh_of_match);
> > +
> > +static const struct i2c_device_id dlh_id[] =3D {
> > +	{ "dlhl60d",    dlhl60d },
> > +	{ "dlhl60g",    dlhl60g },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, dlh_id);
> > +
> > +static struct i2c_driver dlh_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "dlh",
> > +		.of_match_table =3D dlh_of_match,
> > +	},
> > +	.probe =3D dlh_probe,
> > +	.id_table =3D dlh_id,
> > +};
> > +module_i2c_driver(dlh_driver);
> > +
> > +MODULE_AUTHOR("Tomislav Denis <tomislav.denis@avl.com>");
> > +MODULE_DESCRIPTION("Driver for All Sensors DLH series pressure
> > +sensors"); MODULE_LICENSE("GPL v2");

