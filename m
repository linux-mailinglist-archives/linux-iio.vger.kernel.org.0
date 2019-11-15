Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41EFD707
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKOHgz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 02:36:55 -0500
Received: from mx08-002cda01.pphosted.com ([185.183.28.84]:17750 "EHLO
        mx08-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbfKOHgz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 02:36:55 -0500
X-Greylist: delayed 1607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 02:36:50 EST
Received: from pps.filterd (m0135533.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF79YrT009373;
        Fri, 15 Nov 2019 07:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=08102019;
 bh=f4ZNHnY6/6fh/1UHLAAoA3EIsIzpcDOzsU1TZ6X6LTM=;
 b=kAZ5gm4GAPDmJ6eKB+NIo4Jad7C/IWAzXexv86dzSe3zAg9RpuUyuYR+aaDaM6Lpw/Xj
 iVgVE8Q03j9ExwO+K5nyzHFSr49oFrMzg2BxVcBn0iq0E/PLKu/MchaaM27ugb3ZxayI
 UUmLshJHcdicxCoDPhM+1RGFokEcx6FYs0e8MHDSt2WCL39glZMoFipOQq6qKTF5XwdJ
 hY1Wou+vVJYoWKrKEKSJpMW0UbsTPXoCzbQuKcWvzZ6qQM2NezKIc+frCu33jL4/MXbX
 gdNGxkCmQm+w7UMTyuCdgkqJkhx8m0yEXUBKtH+om6zAEzP5StSl60RvcJ1gn7+r4Jvm HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=19122018;
 bh=f4ZNHnY6/6fh/1UHLAAoA3EIsIzpcDOzsU1TZ6X6LTM=;
 b=sll/ZoZBeBtMOv1ZjYd6XNLzLa33ESD1dVP8MFa1lsq/GaDupnnVDlZAOQCrQal5wg1b
 ceAKC8c4ZKL0YO1D84IGU7DT/5c7TuPpZJsNQpGNVkmEAls5MgUUpfOlprescvnRcDFl
 XO3ATG35Gw3XD6vwK/ARQG5hJ3C3kgFv4Rff1YaJRhxqC1ufOEBz8VnMFBXTE40Hz16e
 JEOg1epMLXiwOIGFqRzOmLoJl57nvIbP/lAeRH0oUwhDUKZQPTFrwX2xlQHJyDrGtvDd
 bW2DvlprEG5iMZLav1asqkHvHF2bHs/9+AUjbWoLaSYI6Yx6rbQ+HyvA4XevE49+B9L+ GA== 
Received: from atgrzso8132.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2w5p88bxes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 07:09:52 +0000
Received: from pps.filterd (atgrzso8132.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8132.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xAF76ZNd016229;
        Fri, 15 Nov 2019 08:09:52 +0100
Received: from atgrzsw1691.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8132.avl01.avlcorp.lan with ESMTP id 2w9gysg2uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 08:09:51 +0100
Received: from ATGRZSW1692.avl01.avlcorp.lan (10.12.64.113) by
 ATGRZSW1691.avl01.avlcorp.lan (10.12.64.112) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 15 Nov 2019 08:09:51 +0100
Received: from ATGRZSW1692.avl01.avlcorp.lan ([172.18.42.156]) by
 ATGRZSW1692.avl01.avlcorp.lan ([172.18.42.156]) with mapi id 15.00.1497.000;
 Fri, 15 Nov 2019 08:09:51 +0100
From:   "Denis, Tomislav AVL DiTEST" <Tomislav.Denis@avl.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Denis, Tomislav AVL DiTEST" <Tomislav.Denis@avl.com>
Subject: RE: [PATCH 1/3] iio: pressure: Add driver for DLH pressure sensors
Thread-Topic: [PATCH 1/3] iio: pressure: Add driver for DLH pressure sensors
Thread-Index: AQHVmtOOYpU+aYXrb0mU4QU2L7Ql+qeKqv0AgAElQIA=
Date:   Fri, 15 Nov 2019 07:09:50 +0000
Message-ID: <e111ea7b2da940b4b068c8027f8714bc@ATGRZSW1692.avl01.avlcorp.lan>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
        <20191114100908.11180-2-tomislav.denis@avl.com>
 <20191114143504.00001ec7@huawei.com>
In-Reply-To: <20191114143504.00001ec7@huawei.com>
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_07:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the fast review. V2 patches coming soon.

Tomislav

> On Thu, 14 Nov 2019 11:09:06 +0100
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
> Hi Tomislav,
>=20
> A few comments inline.  Please check the units of the output against the =
IIO
> ABI docs.  Some IIO ABI units are non obvious unfortunately!
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  MAINTAINERS                    |   7 +
> >  drivers/iio/pressure/Kconfig   |  12 ++
> >  drivers/iio/pressure/Makefile  |   1 +
> >  drivers/iio/pressure/dlh-i2c.c | 322
> > +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 342 insertions(+)
> >  create mode 100644 drivers/iio/pressure/dlh-i2c.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index 8323258..2a08923 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -668,6 +668,13 @@ S:	Maintained
> >  F:	Documentation/i2c/busses/i2c-ali1563.rst
> >  F:	drivers/i2c/busses/i2c-ali1563.c
> >
> > +ALL SENSORS DLH SERIES PRESSURE SENSORS DRIVER
> > +M:	Tomislav Denis <tomislav.denis@avl.com>
> > +W: http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> The specific path is likely to bit rot.
> So either drop the entry entirely or perhaps
> W http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> > +S:	Maintained
> > +L:	linux-iio@vger.kernel.org
> > +F:	drivers/iio/pressure/dlh-i2c.c
> > +
> >  ALLEGRO DVT VIDEO IP CORE DRIVER
> >  M:	Michael Tretter <m.tretter@pengutronix.de>
> >  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> > diff --git a/drivers/iio/pressure/Kconfig
> > b/drivers/iio/pressure/Kconfig index ba420e4..504de3e 100644
> > --- a/drivers/iio/pressure/Kconfig
> > +++ b/drivers/iio/pressure/Kconfig
> > @@ -53,6 +53,18 @@ config IIO_CROS_EC_BARO
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called cros_ec_baro.
> >
> > +config DLH_I2C
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
> > +	  will be called dlh-i2c.
> > +
> >  config DPS310
> >  	tristate "Infineon DPS310 pressure and temperature sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/pressure/Makefile
> > b/drivers/iio/pressure/Makefile index d8f5ace..1851a36 100644
> > --- a/drivers/iio/pressure/Makefile
> > +++ b/drivers/iio/pressure/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_BMP280) +=3D bmp280.o  bmp280-objs :=3D
> > bmp280-core.o bmp280-regmap.o
> >  obj-$(CONFIG_BMP280_I2C) +=3D bmp280-i2c.o
> >  obj-$(CONFIG_BMP280_SPI) +=3D bmp280-spi.o
> > +obj-$(CONFIG_DLH_I2C) +=3D dlh-i2c.o
> >  obj-$(CONFIG_DPS310) +=3D dps310.o
> >  obj-$(CONFIG_IIO_CROS_EC_BARO) +=3D cros_ec_baro.o
> >  obj-$(CONFIG_HID_SENSOR_PRESS)   +=3D hid-sensor-press.o
> > diff --git a/drivers/iio/pressure/dlh-i2c.c
> > b/drivers/iio/pressure/dlh-i2c.c new file mode 100644 index
> > 0000000..4ef13c2
> > --- /dev/null
> > +++ b/drivers/iio/pressure/dlh-i2c.c
> > @@ -0,0 +1,322 @@
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
> > +<linux/iio/triggered_buffer.h>
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
> > +static int dlh_i2c_read_direct(struct dlh_state *st,
> > +	unsigned int *pressure, unsigned int *temperature) {
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_write_byte(st->client, DLH_START_SINGLE);
> > +	if (ret) {
> > +		dev_err(&st->client->dev,
> > +			"%s: I2C write byte failed\n", __func__);
> > +		return ret;
> > +	}
> > +
> > +	mdelay(DLH_SINGLE_DUT_MS);
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
> > +	*pressure =3D be32_to_cpup((u32 *)&st->rx_buf[1]) >> 8;
> > +	*temperature =3D be32_to_cpup((u32 *)&st->rx_buf[3]) &
> > +		GENMASK(DLH_NUM_TEMP_BITS - 1, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dlh_i2c_read_raw(struct iio_dev *indio_dev,
> > +	struct iio_chan_spec const *channel, int *value,
> > +	int *value2, long mask)
> > +{
> > +	struct dlh_state *st =3D iio_priv(indio_dev);
> > +	unsigned int pressure, temperature;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (iio_buffer_enabled(indio_dev))
> > +			return -EBUSY;
> > +
> > +		ret =3D iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D dlh_i2c_read_direct(st, &pressure, &temperature);
> > +		iio_device_release_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (channel->type) {
> > +		case IIO_PRESSURE: /* inch H2O */
>=20
> I'm guessing the scale converts that to kilopascals as per
> Documentation/ABI/testing/sysfs-bus-iio?
>=20
> > +			*value =3D pressure;
> > +			return IIO_VAL_INT;
> > +
> > +		case IIO_TEMP: /* degrees Celsius */
>=20
> Base units in IIO for temperature are milli degress Celsius.
>=20
> > +			*value =3D temperature;
> > +			return IIO_VAL_INT;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (channel->type) {
> > +		case IIO_PRESSURE:
> > +			*value =3D 125 * st->info.fss;
> > +			*value2 =3D 100 * (1 << DLH_NUM_PR_BITS);
> > +			return IIO_VAL_FRACTIONAL;
> > +
> > +		case IIO_TEMP:
> > +			*value =3D 125;
> > +			*value2 =3D DLH_NUM_TEMP_BITS;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (channel->type) {
> > +		case IIO_PRESSURE:
> > +			*value =3D -125 * st->info.fss;
> > +			*value2 =3D 100 * st->info.osdig;
> > +			return IIO_VAL_FRACTIONAL;
> > +
> > +		case IIO_TEMP:
> > +			*value =3D -40;
> > +			return IIO_VAL_INT;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> 	default:
> 		return -EINVAL;
>=20
> > +	}
> > +
> Drop the following.  One of the standard build bots complains about this =
and
> it is sensible to ensure it was deliberate that not all cases were handle=
d in
> that switch statement.
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info dlh_i2c_info =3D {
> > +	.read_raw =3D dlh_i2c_read_raw,
> > +};
> > +
> > +static const struct iio_chan_spec dlh_i2c_channels[] =3D {
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
>=20
> If setting indexed, even though the default is 0, should probably provide=
 the
> .channel =3D 0, to make that explicit.
>=20
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
> > +static irqreturn_t dlh_i2c_trigger_handler(int irq, void *private) {
> > +	struct iio_poll_func *pf =3D (struct iio_poll_func *)private;
> No need to add explicit cast for pointers of type void *.  The c spec all=
ows
> simply
>=20
> 	struct iio_poll_func *pf =3D private;
>=20
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct dlh_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +	unsigned int chn, i =3D 0;
> > +	__be32 tmp_buf[2];
> > +
> > +	ret =3D i2c_master_recv(st->client, st->rx_buf,
> DLH_NUM_READ_BYTES);
> > +	if (ret < 0) {
> > +		dev_err(&st->client->dev,
> > +			"%s: I2C read block failed\n", __func__);
> > +		goto out;
> > +	}
> > +
> > +	if (st->rx_buf[0] !=3D DLH_STATUS_OK) {
> > +		dev_err(&st->client->dev,
> > +			"%s: invalid status 0x%02x\n", __func__, st-
> >rx_buf[0]);
> > +		goto out;
> > +	}
> > +
> > +	ret =3D i2c_smbus_write_byte(st->client, DLH_START_SINGLE);
> > +	if (ret) {
> > +		dev_err(&st->client->dev,
> > +			"%s: I2C write byte failed\n", __func__);
> > +		goto out;
> > +	}
>=20
> If I understand the logic here correctly, you are triggering the next cap=
ture as
> part of the previous one.  This doesn't sound right as we are using an
> external trigger.  Imagine.
>=20
> Trigger1 - reads whatever is currently in buffer and starts next sample.
> Wait 5 minutes
> Trigger2 - reads whatever was captured just after trigger1 not fresh data=
 as
> we might expect.
>=20
> In particular I suspect you get random stale data for the first read afte=
r
> starting the buffer.
>=20
> The flow should be.
>=20
> Trigger1.  Send the DLH_START_SINGLE;
> poll or wait for interrupt to signal completion of this reading.
> Read data.
>=20
> Wait for 5 minutes
> Trigger 2. Send the DLH_START_SINGLE;
> poll or wait for interrupt to signal completion of this reading.
> Read data.
>=20
> That should guarantee fresh data whatever the spacing of triggers.
>=20
> If you want to basically get data as quick as possible, the loop trigger =
will
> ensure that you call the start asap after the prevous read.
>=20
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
> > +static int dlh_i2c_probe(struct i2c_client *client,
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
> > +
> > +	indio_dev->name =3D id->name;
> > +	indio_dev->dev.parent =3D &client->dev;
> > +	indio_dev->dev.of_node =3D client->dev.of_node;
> > +	indio_dev->info =3D &dlh_i2c_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D  dlh_i2c_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(dlh_i2c_channels);
> > +
> > +	ret =3D devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> > +		&iio_pollfunc_store_time, &dlh_i2c_trigger_handler, NULL);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to setup iio buffer\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_iio_device_register(&client->dev, indio_dev);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to register iio device\n");
> > +		return ret;
> Drop the return ret; out of the brackets as then we don't need the return=
 0.
>=20
> 	if (ret)
> 		dev_err(...)
>=20
> 	return ret;
> }
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id dlh_i2c_of_match[] =3D {
> > +	{ .compatible =3D "asc,dlhl60d" },
> > +	{ .compatible =3D "asc,dlhl60g" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, dlh_i2c_of_match);
> > +
> > +static const struct i2c_device_id dlh_i2c_id[] =3D {
> > +	{ "dlhl60d",    dlhl60d },
> > +	{ "dlhl60g",    dlhl60g },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, dlh_i2c_id);
> > +
> > +static struct i2c_driver dlh_i2c_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "dlh_i2c",
> > +		.of_match_table =3D dlh_i2c_of_match,
> > +	},
> > +	.probe =3D dlh_i2c_probe,
> > +	.id_table =3D dlh_i2c_id,
> > +};
> > +module_i2c_driver(dlh_i2c_driver);
> > +
> > +MODULE_AUTHOR("Tomislav Denis <tomislav.denis@avl.com>");
> > +MODULE_DESCRIPTION("Driver for All Sensors DLH series pressure
> > +sensors"); MODULE_LICENSE("GPL v2");
>=20

