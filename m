Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A046FEF52
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 16:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfKPP6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 10:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbfKPP6Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 10:58:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4544821739;
        Sat, 16 Nov 2019 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919894;
        bh=7b7IQQVeN3FgZgSDjaM/sGz8ALpHxCfJZzuyxtNfnoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QeuR5W//1t/aX/TeXWdCxSplYwGq0sm2MIzK0nV9KWVSOOYBhTIVmVUE7ZYK+TWBk
         YotwWxftlp9eVp1Jn6KE1pfKxLbCOFQa1LUPpfVqa5lNX9z92Oo7oT/9r3TKyCw1ou
         YRdeI+jrKIBwpw3x/7qVWgbHmQ/+aYsG7V23YaiE=
Date:   Sat, 16 Nov 2019 15:58:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/3] iio: adc: ltc2497: split protocol independent
 part in a separate module
Message-ID: <20191116155808.69b867f0@archlinux>
In-Reply-To: <20191114105159.14195-3-u.kleine-koenig@pengutronix.de>
References: <20191114105159.14195-1-u.kleine-koenig@pengutronix.de>
        <20191114105159.14195-3-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 11:51:58 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> This allows to share most of this driver for the ltc2496 driver added in
> the next commit that is an SPI variant of the ltc2497.
>=20
> Also generalize the entry in MAINTAINER to cover the newly introduced
> files.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
I'm fairly sure there is no way of easily enforcing data being it's own
cacheline whilst on the stack.  I would just put that back in the generic
structure and add a note saying it's only used for the SPI users of
the core structure.

Jonathan

> ---
>  MAINTAINERS               |   2 +-
>  drivers/iio/adc/Makefile  |   2 +-
>  drivers/iio/adc/ltc2497.c | 237 +++++-------------------------------
>  drivers/iio/adc/ltc249x.c | 244 ++++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ltc249x.h |  18 +++
>  5 files changed, 292 insertions(+), 211 deletions(-)
>  create mode 100644 drivers/iio/adc/ltc249x.c
>  create mode 100644 drivers/iio/adc/ltc249x.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb19fad370d7..8b1211038617 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1029,7 +1029,7 @@ S:	Supported
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>  F:	drivers/iio/*/ad*
> -F:	drivers/iio/adc/ltc2497*
> +F:	drivers/iio/adc/ltc249*
>  X:	drivers/iio/*/adjd*
>  F:	drivers/staging/iio/*/ad*
> =20
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ef9cc485fb67..660242c2cca7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -47,7 +47,7 @@ obj-$(CONFIG_LPC18XX_ADC) +=3D lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) +=3D lpc32xx_adc.o
>  obj-$(CONFIG_LTC2471) +=3D ltc2471.o
>  obj-$(CONFIG_LTC2485) +=3D ltc2485.o
> -obj-$(CONFIG_LTC2497) +=3D ltc2497.o
> +obj-$(CONFIG_LTC2497) +=3D ltc2497.o ltc249x.o
>  obj-$(CONFIG_MAX1027) +=3D max1027.o
>  obj-$(CONFIG_MAX11100) +=3D max11100.o
>  obj-$(CONFIG_MAX1118) +=3D max1118.o
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 470406032720..640c512c5090 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -7,260 +7,79 @@
>   * Datasheet: http://cds.linear.com/docs/en/datasheet/2497fd.pdf
>   */
> =20
> -#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/regulator/consumer.h>
> =20
> -#define LTC2497_ENABLE			0xA0
> -#define LTC2497_SGL			BIT(4)
> -#define LTC2497_DIFF			0
> -#define LTC2497_SIGN			BIT(3)
> -#define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
> -#define LTC2497_CONVERSION_TIME_MS	150ULL
> +#include "ltc249x.h"
> =20
>  struct ltc2497_st {
> +	/* this must be the first member */
> +	struct ltc249x_driverdata common_ddata;
>  	struct i2c_client *client;
> -	struct regulator *ref;
> -	ktime_t	time_prev;
> -	u8 addr_prev;
> -	/*
> -	 * DMA (thus cache coherency maintenance) requires the
> -	 * transfer buffers to live in their own cache lines.
> -	 */
> -	__be32 buf ____cacheline_aligned;
>  };
> =20
> -static int ltc2497_wait_conv(struct ltc2497_st *st)
> -{
> -	s64 time_elapsed;
> -
> -	time_elapsed =3D ktime_ms_delta(ktime_get(), st->time_prev);
> -
> -	if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
> -		/* delay if conversion time not passed
> -		 * since last read or write
> -		 */
> -		if (msleep_interruptible(
> -		    LTC2497_CONVERSION_TIME_MS - time_elapsed))
> -			return -ERESTARTSYS;
> -
> -		return 0;
> -	}
> -
> -	if (time_elapsed - LTC2497_CONVERSION_TIME_MS <=3D 0) {
> -		/* We're in automatic mode -
> -		 * so the last reading is stil not outdated
> -		 */
> -		return 0;
> -	}
> -
> -	return 1;
> -}
> -
> -static int ltc2497_read(struct ltc2497_st *st, u8 address, int *val)
> +static int ltc2497_result_and_measure(struct ltc249x_driverdata *ddata,
> +				      u8 address, int *val)
>  {
> -	struct i2c_client *client =3D st->client;
> -	int ret;
> -
> -	ret =3D ltc2497_wait_conv(st);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret || st->addr_prev !=3D address) {
> -		ret =3D i2c_smbus_write_byte(st->client,
> -					   LTC2497_ENABLE | address);
> -		if (ret < 0)
> -			return ret;
> -		st->addr_prev =3D address;
> -		if (msleep_interruptible(LTC2497_CONVERSION_TIME_MS))
> -			return -ERESTARTSYS;
> -	}
> -	ret =3D i2c_master_recv(client, (char *)&st->buf, 3);
> -	if (ret < 0)  {
> -		dev_err(&client->dev, "i2c_master_recv failed\n");
> -		return ret;
> -	}
> -	st->time_prev =3D ktime_get();
> +	struct ltc2497_st *st =3D
> +		container_of(ddata, struct ltc2497_st, common_ddata);
> =20
> -	/* convert and shift the result,
> -	 * and finally convert from offset binary to signed integer
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
>  	 */
> -	*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> -
> -	return ret;
> -}
> -
> -static int ltc2497_read_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int *val, int *val2, long mask)
> -{
> -	struct ltc2497_st *st =3D iio_priv(indio_dev);
> +	__be32 buf ____cacheline_aligned;

=46rom what I recall that has no useful affect on the stack.
Can only be used to enforce padding within a structure on the
heap.  Directly allocating from the heap here would also
provide relevant guarantees.

>  	int ret;
> =20
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> -		ret =3D ltc2497_read(st, chan->address, val);
> -		mutex_unlock(&indio_dev->mlock);
> -		if (ret < 0)
> +	if (val) {
> +		ret =3D i2c_master_recv(st->client, (char *)&buf, 3);
> +		if (ret < 0) {
> +			dev_err(&st->client->dev, "i2c_master_recv failed\n");
>  			return ret;
> +		}
> =20
> -		return IIO_VAL_INT;
> -
> -	case IIO_CHAN_INFO_SCALE:
> -		ret =3D regulator_get_voltage(st->ref);
> -		if (ret < 0)
> -			return ret;
> -
> -		*val =3D ret / 1000;
> -		*val2 =3D 17;
> -
> -		return IIO_VAL_FRACTIONAL_LOG2;
> -
> -	default:
> -		return -EINVAL;
> +		*val =3D (be32_to_cpu(buf) >> 14) - (1 << 17);
>  	}
> -}
> =20
> -#define LTC2497_CHAN(_chan, _addr, _ds_name) { \
> -	.type =3D IIO_VOLTAGE, \
> -	.indexed =3D 1, \
> -	.channel =3D (_chan), \
> -	.address =3D (_addr | (_chan / 2) | ((_chan & 1) ? LTC2497_SIGN : 0)), \
> -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> -	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> -	.datasheet_name =3D (_ds_name), \
> -}
> -
> -#define LTC2497_CHAN_DIFF(_chan, _addr) { \
> -	.type =3D IIO_VOLTAGE, \
> -	.indexed =3D 1, \
> -	.channel =3D (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 1 : 0), \
> -	.channel2 =3D (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 0 : 1),\
> -	.address =3D (_addr | _chan), \
> -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> -	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> -	.differential =3D 1, \
> +	ret =3D i2c_smbus_write_byte(st->client,
> +				   LTC249X_ENABLE | address);
> +	if (ret)
> +		dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
> +			ERR_PTR(ret));
> +	return ret;
>  }
> =20
> -static const struct iio_chan_spec ltc2497_channel[] =3D {
> -	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
> -	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
> -	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),
> -	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),
> -	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),
> -	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),
> -	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),
> -	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),
> -	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),
> -	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),
> -	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),
> -	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),
> -	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),
> -	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),
> -	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),
> -	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),
> -	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
> -};
> -
> -static const struct iio_info ltc2497_info =3D {
> -	.read_raw =3D ltc2497_read_raw,
> -};
> -
>  static int ltc2497_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ltc2497_st *st;
> -	struct iio_map *plat_data;
> -	int ret;
> +	struct device *dev =3D &client->dev;
> =20
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>  				     I2C_FUNC_SMBUS_WRITE_BYTE))
>  		return -EOPNOTSUPP;
> =20
> -	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
>  	st =3D iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	st->client =3D client;
> +	st->common_ddata.result_and_measure =3D ltc2497_result_and_measure;
> =20
> -	indio_dev->dev.parent =3D &client->dev;
> -	indio_dev->name =3D id->name;
> -	indio_dev->info =3D &ltc2497_info;
> -	indio_dev->modes =3D INDIO_DIRECT_MODE;
> -	indio_dev->channels =3D ltc2497_channel;
> -	indio_dev->num_channels =3D ARRAY_SIZE(ltc2497_channel);
> -
> -	st->ref =3D devm_regulator_get(&client->dev, "vref");
> -	if (IS_ERR(st->ref))
> -		return PTR_ERR(st->ref);
> -
> -	ret =3D regulator_enable(st->ref);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (client->dev.platform_data) {
> -		plat_data =3D ((struct iio_map *)client->dev.platform_data);
> -		ret =3D iio_map_array_register(indio_dev, plat_data);
> -		if (ret) {
> -			dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
> -			goto err_regulator_disable;
> -		}
> -	}
> -
> -	ret =3D i2c_smbus_write_byte(st->client, LTC2497_CONFIG_DEFAULT);
> -	if (ret < 0)
> -		goto err_array_unregister;
> -
> -	st->addr_prev =3D LTC2497_CONFIG_DEFAULT;
> -	st->time_prev =3D ktime_get();
> -
> -	ret =3D iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto err_array_unregister;
> -
> -	return 0;
> -
> -err_array_unregister:
> -	iio_map_array_unregister(indio_dev);
> -
> -err_regulator_disable:
> -	regulator_disable(st->ref);
> -
> -	return ret;
> +	return ltc249x_probe(dev, indio_dev);
>  }
> =20
>  static int ltc2497_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> -	struct ltc2497_st *st =3D iio_priv(indio_dev);
> =20
> -	iio_map_array_unregister(indio_dev);
> -	iio_device_unregister(indio_dev);
> -	regulator_disable(st->ref);
> +	ltc249x_remove(indio_dev);
> =20
>  	return 0;
>  }
> diff --git a/drivers/iio/adc/ltc249x.c b/drivers/iio/adc/ltc249x.c
> new file mode 100644
> index 000000000000..7af1086236c0
> --- /dev/null
> +++ b/drivers/iio/adc/ltc249x.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ltc249x.c - Common code for Analog Devices/Linear Technology
> + * LTC2496 and LTC2497 ADCs
> + *
> + * Copyright (C) 2017 Analog Devices Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "ltc249x.h"
> +
> +#define LTC249X_SGL			BIT(4)
> +#define LTC249X_DIFF			0
> +#define LTC249X_SIGN			BIT(3)
> +
> +static int ltc249x_wait_conv(struct ltc249x_driverdata *ddata)
> +{
> +	s64 time_elapsed;
> +
> +	time_elapsed =3D ktime_ms_delta(ktime_get(), ddata->time_prev);
> +
> +	if (time_elapsed < LTC249X_CONVERSION_TIME_MS) {
> +		/* delay if conversion time not passed
> +		 * since last read or write
> +		 */
> +		if (msleep_interruptible(
> +		    LTC249X_CONVERSION_TIME_MS - time_elapsed))
> +			return -ERESTARTSYS;
> +
> +		return 0;
> +	}
> +
> +	if (time_elapsed - LTC249X_CONVERSION_TIME_MS <=3D 0) {
> +		/* We're in automatic mode -
> +		 * so the last reading is still not outdated
> +		 */
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int ltc249x_read(struct ltc249x_driverdata *ddata, u8 address, in=
t *val)
> +{
> +	int ret;
> +
> +	ret =3D ltc249x_wait_conv(ddata);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret || ddata->addr_prev !=3D address) {
> +		ret =3D ddata->result_and_measure(ddata, address, NULL);
> +		if (ret < 0)
> +			return ret;
> +
> +		ddata->addr_prev =3D address;
> +
> +		if (msleep_interruptible(LTC249X_CONVERSION_TIME_MS))
> +			return -ERESTARTSYS;
> +	}
> +
> +	ret =3D ddata->result_and_measure(ddata, address, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ddata->time_prev =3D ktime_get();
> +
> +	return ret;
> +}
> +
> +static int ltc249x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ltc249x_driverdata *ddata =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +		ret =3D ltc249x_read(ddata, chan->address, val);
> +		mutex_unlock(&indio_dev->mlock);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D regulator_get_voltage(ddata->ref);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D ret / 1000;
> +		*val2 =3D 17;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define LTC249X_CHAN(_chan, _addr, _ds_name) { \
> +	.type =3D IIO_VOLTAGE, \
> +	.indexed =3D 1, \
> +	.channel =3D (_chan), \
> +	.address =3D (_addr | (_chan / 2) | ((_chan & 1) ? LTC249X_SIGN : 0)), \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +	.datasheet_name =3D (_ds_name), \
> +}
> +
> +#define LTC249X_CHAN_DIFF(_chan, _addr) { \
> +	.type =3D IIO_VOLTAGE, \
> +	.indexed =3D 1, \
> +	.channel =3D (_chan) * 2 + ((_addr) & LTC249X_SIGN ? 1 : 0), \
> +	.channel2 =3D (_chan) * 2 + ((_addr) & LTC249X_SIGN ? 0 : 1),\
> +	.address =3D (_addr | _chan), \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +	.differential =3D 1, \
> +}
> +
> +static const struct iio_chan_spec ltc249x_channel[] =3D {
> +	LTC249X_CHAN(0, LTC249X_SGL, "CH0"),
> +	LTC249X_CHAN(1, LTC249X_SGL, "CH1"),
> +	LTC249X_CHAN(2, LTC249X_SGL, "CH2"),
> +	LTC249X_CHAN(3, LTC249X_SGL, "CH3"),
> +	LTC249X_CHAN(4, LTC249X_SGL, "CH4"),
> +	LTC249X_CHAN(5, LTC249X_SGL, "CH5"),
> +	LTC249X_CHAN(6, LTC249X_SGL, "CH6"),
> +	LTC249X_CHAN(7, LTC249X_SGL, "CH7"),
> +	LTC249X_CHAN(8, LTC249X_SGL, "CH8"),
> +	LTC249X_CHAN(9, LTC249X_SGL, "CH9"),
> +	LTC249X_CHAN(10, LTC249X_SGL, "CH10"),
> +	LTC249X_CHAN(11, LTC249X_SGL, "CH11"),
> +	LTC249X_CHAN(12, LTC249X_SGL, "CH12"),
> +	LTC249X_CHAN(13, LTC249X_SGL, "CH13"),
> +	LTC249X_CHAN(14, LTC249X_SGL, "CH14"),
> +	LTC249X_CHAN(15, LTC249X_SGL, "CH15"),
> +	LTC249X_CHAN_DIFF(0, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(1, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(2, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(3, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(4, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(5, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(6, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(7, LTC249X_DIFF),
> +	LTC249X_CHAN_DIFF(0, LTC249X_DIFF | LTC249X_SIGN),
> +	LTC249X_CHAN_DIFF(1, LTC249X_DIFF | LTC249X_SIGN),
> +	LTC249X_CHAN_DIFF(2, LTC249X_DIFF | LTC249X_SIGN),
> +	LTC249X_CHAN_DIFF(3, LTC249X_DIFF | LTC249X_SIGN),
> +	LTC249X_CHAN_DIFF(4, LTC249X_DIFF | LTC249X_SIGN),
> +	LTC249X_CHAN_DIFF(5, LTC249X_DIFF | LTC249X_SIGN),
> +	LTC249X_CHAN_DIFF(6, LTC249X_DIFF | LTC249X_SIGN),
> +	LTC249X_CHAN_DIFF(7, LTC249X_DIFF | LTC249X_SIGN),
> +};
> +
> +static const struct iio_info ltc249x_info =3D {
> +	.read_raw =3D ltc249x_read_raw,
> +};
> +
> +int ltc249x_probe(struct device *dev, struct iio_dev *indio_dev)
> +{
> +	struct ltc249x_driverdata *ddata =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	indio_dev->dev.parent =3D dev;
> +	indio_dev->name =3D dev_name(dev);
> +	indio_dev->info =3D &ltc249x_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D ltc249x_channel;
> +	indio_dev->num_channels =3D ARRAY_SIZE(ltc249x_channel);
> +
> +	ret =3D ddata->result_and_measure(ddata, LTC249X_CONFIG_DEFAULT, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ddata->ref =3D devm_regulator_get(dev, "vref");
> +	if (IS_ERR(ddata->ref)) {
> +		if (PTR_ERR(ddata->ref) !=3D -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vref regulator: %pe\n",
> +				ddata->ref);
> +
> +		return PTR_ERR(ddata->ref);
> +	}
> +
> +	ret =3D regulator_enable(ddata->ref);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable vref regulator: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	if (dev->platform_data) {
> +		struct iio_map *plat_data;
> +
> +		plat_data =3D (struct iio_map *)dev->platform_data;
> +
> +		ret =3D iio_map_array_register(indio_dev, plat_data);
> +		if (ret) {
> +			dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
> +			goto err_regulator_disable;
> +		}
> +	}
> +
> +	ddata->addr_prev =3D LTC249X_CONFIG_DEFAULT;
> +	ddata->time_prev =3D ktime_get();
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto err_array_unregister;
> +
> +	return 0;
> +
> +err_array_unregister:
> +	iio_map_array_unregister(indio_dev);
> +
> +err_regulator_disable:
> +	regulator_disable(ddata->ref);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS(ltc249x_probe, LTC249X);
> +
> +void ltc249x_remove(struct iio_dev *indio_dev)
> +{
> +	struct ltc249x_driverdata *ddata =3D iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	iio_map_array_unregister(indio_dev);
> +
> +	regulator_disable(ddata->ref);
> +}
> +EXPORT_SYMBOL_NS(ltc249x_remove, LTC249X);
> +
> +MODULE_DESCRIPTION("common code for LTC2496/LTC2497 drivers");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/ltc249x.h b/drivers/iio/adc/ltc249x.h
> new file mode 100644
> index 000000000000..b272a3f96d03
> --- /dev/null
> +++ b/drivers/iio/adc/ltc249x.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#define LTC249X_ENABLE			0xA0
> +#define LTC249X_CONFIG_DEFAULT		LTC249X_ENABLE
> +#define LTC249X_CONVERSION_TIME_MS	150ULL
> +
> +struct ltc249x_driverdata {
> +	struct regulator *ref;
> +	ktime_t	time_prev;
> +	u8 addr_prev;
> +	int (*result_and_measure)(struct ltc249x_driverdata *ddata,
> +				  u8 address, int *val);
> +};
> +
> +int ltc249x_probe(struct device *dev, struct iio_dev *indio_dev);
> +void ltc249x_remove(struct iio_dev *indio_dev);
> +
> +MODULE_IMPORT_NS(LTC249X);

