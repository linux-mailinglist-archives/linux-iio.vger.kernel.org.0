Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128F9ED34E
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 13:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfKCMT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 07:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfKCMT2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 07:19:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA9E420842;
        Sun,  3 Nov 2019 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572783566;
        bh=x6prnoLkQBfac7UewwwJrtDmFPzqAGgdNNjq+nJ5nPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g25L590/IeAJxEwRxrwEkkYbXQBL/YIS0371lomtLKOkoEednq8NDu1RyJHfbYbQQ
         1Sju0PyDwF3q9QtY1bbGJY4z8ac+VZIlLZBxVLTaePhMRcd9Dg6hht3KVTS2EFQHr5
         7+TnqSTzl8d3nU4TnYxgC+RlPa5T/dCOyXsm3fMQ=
Date:   Sun, 3 Nov 2019 12:19:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        development@norphonic.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/1] Add support for TI HDC200x humidity and temperature
 sensors
Message-ID: <20191103121921.5b1d0b02@archlinux>
In-Reply-To: <71176abd-4997-70f8-8132-137fadda7768@norphonic.com>
References: <71176abd-4997-70f8-8132-137fadda7768@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 09:42:54 +0100
Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com> wrote:

> Hello,
>=20
> Below is a driver for Texas Instruments HDC 2010 & 2080 family of=20
> relative humidity and temperature sensors. Their register map, bus=20
> access and acquisition modes differ substantially from the earlier 100x=20
> series of devices. Therefore combining it with the existing hdc100x=20
> driver was unfeasible.
>=20
> (No copy to linux-iio as there is some issue between majordomo and my=20
> corporate mail setup, hope this is OK)

It happens. I've cc'd linux-iio for the reply so people should be able
to see it.  If you can get the issue sorted for future versions that
would be great.

More of an issue is that your email system has broken the white space
so I won't be able to apply the patch.  Try to get that fixed. If really
hard to solve, then send the output of git format-patch as an attachment
to an email.  Note though that it will massively reduce the review
you get so it's worth having the fight with corporate IT :)

Various comments inline.

Thanks,

Jonathan

>=20
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
>=20
> diff -uprN linux-5.3.8/drivers/iio/humidity/hdc200x.c=20
> linux-5.3.8_hdc2010/drivers/iio/humidity/hdc200x.c
> --- linux-5.3.8/drivers/iio/humidity/hdc200x.c=C2=A0=C2=A0=C2=A0 1970-01-=
01=20
> 01:00:00.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc200x.c 2019-10-31=20

We let a few through in the past, but in general using wild cards
for driver names is extremely likely to go wrong.  In this particular
case the wild card doesn't cover the parts already supported!

Hence, just pick a part and name it after that.
This applies to all prefixes in the code as well.

> 16:25:21.196711976 +0100
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hdc200x.c - Support for the TI HDC200x temperature + humidity sensors
> + *
> + * Copyright (C) 2019 Norphonic AS
> + * Author: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> + *
> + * Datasheets:
> + * http://www.ti.com/product/HDC2010/datasheet
> + * http://www.ti.com/product/HDC2080/datasheet
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define HDC200X_REG_TEMP_LOW=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 0x00
> +#define HDC200X_REG_TEMP_HIGH=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 0x01
> +#define HDC200X_REG_HUMIDITY_LOW=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x=
02
> +#define HDC200X_REG_HUMIDITY_HIGH=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0=
x03
> +#define HDC200X_REG_INTERRUPT_DRDY=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
0x04
> +#define HDC200X_REG_TEMP_MAX=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 0x05
> +#define HDC200X_REG_HUMIDITY_MAX=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x=
06
> +#define HDC200X_REG_INTERRUPT_EN=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x=
07
> +#define HDC200X_REG_TEMP_OFFSET_ADJ=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 0x08
> +#define HDC200X_REG_HUMIDITY_OFFSET_ADJ=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 0x09
> +#define HDC200X_REG_TEMP_THR_L=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 0x0a
> +#define HDC200X_REG_TEMP_THR_H=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 0x0b
> +#define HDC200X_REG_RH_THR_L=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 0x0c
> +#define HDC200X_REG_RH_THR_H=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 0x0d
> +#define HDC200X_REG_RESET_DRDY_INT_CONF=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 0x0e
> +#define HDC200X_REG_MEASUREMENT_CONF=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 0x0f
> +
> +#define HDC200X_MEAS_CONF=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 GENMASK(3, 2)
> +#define HDC200X_MEAS_TRIG=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 BIT(0)
> +#define HDC200X_HEATER_EN=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 BIT(3)
> +#define HDC200X_AMM=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 GENMASK(6, 4)
> +
> +struct hdc200x_data {
> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client;
> +=C2=A0=C2=A0=C2=A0 struct mutex lock;
> +=C2=A0=C2=A0=C2=A0 u8 measurement_config;
> +=C2=A0=C2=A0=C2=A0 u8 interrupt_config;
> +=C2=A0=C2=A0=C2=A0 u8 drdy_config;
> +};
> +
> +/* HDC200X_REG_CONFIG shift and mask values */
> +static const struct {
> +=C2=A0=C2=A0=C2=A0 int shift;
> +=C2=A0=C2=A0=C2=A0 int mask;
> +} hdc200x_resolution_shift[2] =3D {
> +=C2=A0=C2=A0=C2=A0 { /* IIO_TEMP channel */
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .shift =3D 6,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .mask =3D 3
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 { /* IIO_HUMIDITYRELATIVE channel */

Use an enum to make these explicit rather than comments.

> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .shift =3D 4,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .mask =3D 3,
> +=C2=A0=C2=A0=C2=A0 },
> +};
> +
> +static IIO_CONST_ATTR(out_current_heater_raw_available,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 "0 1");
> +
> +static struct attribute *hdc200x_attributes[] =3D {
> + &iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0 NULL
> +};
> +
> +static const struct attribute_group hdc200x_attribute_group =3D {
> +=C2=A0=C2=A0=C2=A0 .attrs =3D hdc200x_attributes,
> +};
> +
> +static const struct iio_chan_spec hdc200x_channels[] =3D {
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_TEMP,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .extend_name =3D "Temperature",
Any use of extend_name changes the ABI and should be done extremely
carefully.  It basically means that generic userspace code cannot
use your driver.

Here I can't see any advantage in doing so at all so drop it.

> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .datasheet_name =3D "TEMPERATURE",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .address =3D HDC200X_REG_TEMP_LOW,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CH=
AN_INFO_RAW) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_SCALE) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_OFFSET),
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .scan_type =3D {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .sign =3D 'u',
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .realbits =3D 1=
4,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .storagebits =
=3D 16,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .endianness =3D=
 IIO_LE,

You aren't providing the buffered interface which most of this is for.
as such, just specify the bits you are using (storagebits only I think)

> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_TEMP,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .extend_name =3D "Temperature_MAX",

Could we use the IIO_CHAN_INFO_PEAK element for this?  Given
the different scale, we'd need to do some work to make it
have the same scale as temp.

> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .datasheet_name =3D "TEMPERATUREMA=
X",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .address =3D HDC200X_REG_TEMP_MAX,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CH=
AN_INFO_RAW) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_SCALE) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_OFFSET),
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .scan_type =3D {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .sign =3D 'u',
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .realbits =3D 8,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .storagebits =
=3D 8,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_HUMIDITYRELATIVE,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .extend_name =3D "Humidity",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .datasheet_name =3D "HUMIDITY",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .address =3D HDC200X_REG_HUMIDITY_=
LOW,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CH=
AN_INFO_RAW) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_SCALE),
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .scan_type =3D {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .sign =3D 'u',
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .realbits =3D 1=
4,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .storagebits =
=3D 16,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .endianness =3D=
 IIO_LE,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_HUMIDITYRELATIVE,
As above, could we use the peak attribute for this?
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .extend_name =3D "Humidity_MAX",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .datasheet_name =3D "HUMIDITYMAX",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .address =3D HDC200X_REG_HUMIDITY_=
MAX,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CH=
AN_INFO_RAW) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_SCALE),
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .scan_type =3D {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .sign =3D 'u',
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .realbits =3D 8,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .storagebits =
=3D 8,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_CURRENT,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CH=
AN_INFO_RAW),
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .extend_name =3D "heater",
This bit of ABI is only documented for the hdc100x parts so far. You will n=
eed
to have a similar document to describe the non standard abi for this part.

Documentation/ABI/testing/sysfs-bus-iio-humdity-hdc200x.txt

> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .output =3D 1,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .scan_index =3D -1,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +static int hdc200x_update_measurement_config(struct hdc200x_data *data,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 char mask, char val)
> +{
> +=C2=A0=C2=A0=C2=A0 char tmp =3D (~mask & data->measurement_config) | val;
> +=C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(data->client,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 HDC200X_REG_MEASUREMENT_CONF, tmp);
> +=C2=A0=C2=A0=C2=A0 if (!ret)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data->measurement_config =3D tmp;
> +
> +=C2=A0=C2=A0=C2=A0 return ret;
> +}
> +
> +static int hdc200x_update_interrupt_config(struct hdc200x_data *data,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 char mask, char val)
> +{
> +=C2=A0=C2=A0=C2=A0 char tmp =3D (~mask & data->interrupt_config) | val;
> +=C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(data->client,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 HDC200X_REG_INTERRUPT_EN, tmp);
> +=C2=A0=C2=A0=C2=A0 if (!ret)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data->interrupt_config =3D tmp;
> +
> +=C2=A0=C2=A0=C2=A0 return ret;
> +}
> +
> +static int hdc200x_update_drdy_config(struct hdc200x_data *data,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char mask, char val)
> +{
> +=C2=A0=C2=A0=C2=A0 char tmp =3D (~mask & data->drdy_config) | val;
> +=C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(data->client,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 HDC200X_REG_RESET_DRDY_INT_CONF, tmp);
> +=C2=A0=C2=A0=C2=A0 if (!ret)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data->drdy_config =3D tmp;
> +
> +=C2=A0=C2=A0=C2=A0 return ret;
> +}
> +
> +static int hdc200x_get_measurement_word(struct hdc200x_data *data,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan)

These wrappers add relatively little.  I'd prefer that you just call
the i2c calls directly instead.  Less code and ultimately a tiny
bit easier to review.

> +{
> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D data->client;
> +=C2=A0=C2=A0=C2=A0 s32 ret;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_word_data(data->client, chan->=
address);
> +
> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(&client->dev, "Could not r=
ead sensor data\n");
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return ret;
> +}
> +
> +static int hdc200x_get_measurement_byte(struct hdc200x_data *data,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan)
> +{
> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D data->client;
> +=C2=A0=C2=A0=C2=A0 s32 ret;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_byte_data(data->client, chan->=
address);
> +
> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(&client->dev, "Could not r=
ead sensor data\n");
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;

No need to have this return ret as we can use the one below.

> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return ret;
> +}
> +
> +static int hdc200x_get_heater_status(struct hdc200x_data *data)
> +{
> +=C2=A0=C2=A0=C2=A0 return !!(data->drdy_config & HDC200X_HEATER_EN);
> +}
> +
> +static int hdc200x_read_raw(struct iio_dev *indio_dev,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 struct iio_chan_spec const *chan, int *val,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 int *val2, long mask)
> +{
> +=C2=A0=C2=A0=C2=A0 struct hdc200x_data *data =3D iio_priv(indio_dev);
> +
> +=C2=A0=C2=A0=C2=A0 switch (mask) {
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW: {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_lock(&data->lock);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (chan->type =3D=3D IIO_CURRENT)=
 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D hdc200=
x_get_heater_status(data);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D IIO_VAL=
_INT;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D iio_dev=
ice_claim_direct_mode(indio_dev);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 mutex_unlock(&data->lock);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (chan->scan_=
type.storagebits =3D=3D 16)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 ret =3D hdc200x_get_measurement_word(data, chan);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 ret =3D hdc200x_get_measurement_byte(data, chan);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 iio_device_rele=
ase_direct_mode(indio_dev);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret >=3D 0)=
 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 *val =3D ret;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 ret =3D IIO_VAL_INT;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&data->lock);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (chan->scan_type.storagebits =
=3D=3D 16)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val2 =3D 65536;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val2 =3D 256;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (chan->type =3D=3D IIO_TEMP)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D 165000;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D 100;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return IIO_VAL_FRACTIONAL;
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_OFFSET:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (chan->scan_type.storagebits =
=3D=3D 16) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D -15887;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val2 =3D 51515=
1;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D -62;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val2 =3D 60606;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return IIO_VAL_INT_PLUS_MICRO;
> +=C2=A0=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +static int hdc200x_write_raw(struct iio_dev *indio_dev,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 struct iio_chan_spec const *chan,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 int val, int val2, long mask)
> +{
> +=C2=A0=C2=A0=C2=A0 struct hdc200x_data *data =3D iio_priv(indio_dev);
> +=C2=A0=C2=A0=C2=A0 int ret =3D -EINVAL;
> +
> +=C2=A0=C2=A0=C2=A0 switch (mask) {
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_CURRENT ||=
 val2 !=3D 0)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
> +
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_lock(&data->lock);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D hdc200x_update_drdy_config=
(data, HDC200X_HEATER_EN,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0val ? HDC200X_HEATER_EN : 0=
);

This a little ugly as it will accept even crazy values as valid
currents.  -42 for example. Should check val =3D=3D 1 or 0 not anything else


> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&data->lock);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +static const struct iio_info hdc200x_info =3D {
> +=C2=A0=C2=A0=C2=A0 .read_raw =3D hdc200x_read_raw,
> +=C2=A0=C2=A0=C2=A0 .write_raw =3D hdc200x_write_raw,
> +=C2=A0=C2=A0=C2=A0 .attrs =3D &hdc200x_attribute_group,
> +};
> +
> +static int hdc200x_probe(struct i2c_client *client,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0const str=
uct i2c_device_id *id)
> +{
> +=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> +=C2=A0=C2=A0=C2=A0 struct hdc200x_data *data;
> +
> +=C2=A0=C2=A0=C2=A0 if (!i2c_check_functionality(client->adapter, I2C_FUN=
C_SMBUS_WORD_DATA |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0=C2=A0 I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
> +
> +=C2=A0=C2=A0=C2=A0 indio_dev =3D devm_iio_device_alloc(&client->dev, siz=
eof(*data));
> +=C2=A0=C2=A0=C2=A0 if (!indio_dev)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENOMEM;
> +
> +=C2=A0=C2=A0=C2=A0 data =3D iio_priv(indio_dev);
> +=C2=A0=C2=A0=C2=A0 i2c_set_clientdata(client, indio_dev);
> +=C2=A0=C2=A0=C2=A0 data->client =3D client;
> +=C2=A0=C2=A0=C2=A0 mutex_init(&data->lock);
> +
> +=C2=A0=C2=A0=C2=A0 indio_dev->dev.parent =3D &client->dev;
> +=C2=A0=C2=A0=C2=A0 indio_dev->name =3D dev_name(&client->dev);
> +=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
> +=C2=A0=C2=A0=C2=A0 indio_dev->info =3D &hdc200x_info;
> +
> +=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D hdc200x_channels;
> +=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D ARRAY_SIZE(hdc200x_channe=
ls);
> +
> +=C2=A0=C2=A0=C2=A0 /* Enable Automatic Measurement Mode at 5Hz */
> +=C2=A0=C2=A0=C2=A0 hdc200x_update_drdy_config(data, HDC200X_AMM, HDC200X=
_AMM);
> +
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0 =C2=A0* We enable both temp and humidity measurement.
> +=C2=A0=C2=A0=C2=A0 =C2=A0* However the measurement won't start even in A=
MM until you trigger it.
> +=C2=A0=C2=A0=C2=A0 =C2=A0*/
> +=C2=A0=C2=A0=C2=A0 hdc200x_update_measurement_config(data, HDC200X_MEAS_=
CONF |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 HDC200X_MEAS_TRIG, HDC200X_MEAS_TRIG);
> +
> +=C2=A0=C2=A0=C2=A0 return devm_iio_device_register(&client->dev, indio_d=
ev);
> +}
> +
> +static const struct i2c_device_id hdc200x_id[] =3D {
> +=C2=A0=C2=A0=C2=A0 { "hdc200x", 0 },
> +=C2=A0=C2=A0=C2=A0 { "hdc2010", 0 },
> +=C2=A0=C2=A0=C2=A0 { "hdc2080", 0 },
> +=C2=A0=C2=A0=C2=A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, hdc200x_id);
> +
> +static const struct of_device_id hdc200x_dt_ids[] =3D {
> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "ti,hdc2010" },
> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "ti,hdc2080" },
> +=C2=A0=C2=A0=C2=A0 { }
> +};
> +MODULE_DEVICE_TABLE(of, hdc200x_dt_ids);
> +
> +static struct i2c_driver hdc200x_driver =3D {
> +=C2=A0=C2=A0=C2=A0 .driver =3D {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =3D "hdc20=
0x",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .of_match_table =3D of_match_ptr(h=
dc200x_dt_ids),
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 .probe =3D hdc200x_probe,
> +=C2=A0=C2=A0=C2=A0 .id_table =3D hdc200x_id,
> +};
> +module_i2c_driver(hdc200x_driver);
> +
> +MODULE_AUTHOR("Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>");
> +MODULE_DESCRIPTION("TI HDC200x humidity and temperature sensor driver");
> +MODULE_LICENSE("GPL");
> diff -uprN linux-5.3.8/drivers/iio/humidity/Kconfig=20
> linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig
> --- linux-5.3.8/drivers/iio/humidity/Kconfig=C2=A0=C2=A0=C2=A0 2019-10-29=
=20
> 09:22:48.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig=C2=A0=C2=A0=C2=A0 20=
19-10-31=20
> 16:03:18.199037553 +0100
> @@ -38,6 +38,16 @@ config HDC100X
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 To compile this driver as a module, choo=
se M here: the module
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 will be called hdc100x.
>=20
> +config HDC200X
> +=C2=A0=C2=A0=C2=A0 tristate "TI HDC200x relative humidity and temperatur=
e sensor"
> +=C2=A0=C2=A0=C2=A0 depends on I2C
> +=C2=A0=C2=A0=C2=A0 help
> +=C2=A0=C2=A0=C2=A0 =C2=A0 Say yes here to build support for the Texas In=
struments
> +=C2=A0=C2=A0=C2=A0 =C2=A0 HDC2010 and HDC2080 relative humidity and temp=
erature sensors.
> +
> +=C2=A0=C2=A0=C2=A0 =C2=A0 To compile this driver as a module, choose M h=
ere: the module
> +=C2=A0=C2=A0=C2=A0 =C2=A0 will be called hdc200x.
> +
>  =C2=A0config HID_SENSOR_HUMIDITY
>  =C2=A0=C2=A0=C2=A0=C2=A0 tristate "HID Environmental humidity sensor"
>  =C2=A0=C2=A0=C2=A0=C2=A0 depends on HID_SENSOR_HUB
> diff -uprN linux-5.3.8/drivers/iio/humidity/Makefile=20
> linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile
> --- linux-5.3.8/drivers/iio/humidity/Makefile=C2=A0=C2=A0=C2=A0 2019-10-2=
9=20
> 09:22:48.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile 2019-10-31=20
> 16:01:38.210318714 +0100
> @@ -6,6 +6,7 @@
>  =C2=A0obj-$(CONFIG_AM2315) +=3D am2315.o
>  =C2=A0obj-$(CONFIG_DHT11) +=3D dht11.o
>  =C2=A0obj-$(CONFIG_HDC100X) +=3D hdc100x.o
> +obj-$(CONFIG_HDC200X) +=3D hdc200x.o
>  =C2=A0obj-$(CONFIG_HID_SENSOR_HUMIDITY) +=3D hid-sensor-humidity.o
>=20
>  =C2=A0hts221-y :=3D hts221_core.o \
>=20

