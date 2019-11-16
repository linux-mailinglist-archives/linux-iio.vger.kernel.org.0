Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567EAFF127
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 17:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfKPQKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 11:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfKPQJ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 11:09:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A6021823;
        Sat, 16 Nov 2019 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573920595;
        bh=BQjcjQsPE6wLFMGVbWLDJ1oK7vdOUvA2DYSEart+FtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pxEPSoxfqYFi8oQfatEuDPTISEAC3L7rTpr8C8YpQLfYm+VkB9g38vhBa0R6tAAfl
         C6erQdYuYJF5AOxmQvDeRS70WhbtL+23lkC9QZQV6BQTZZr53hIlergI4anG2Yt66m
         nPsWwlmiILNUgYPQkEVYhLwMiVoCt2hlcSqCPSEE=
Date:   Sat, 16 Nov 2019 16:09:49 +0000
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
Subject: Re: [PATCH v2 3/3] iio: adc: new driver to support Linear
 technology's ltc2496
Message-ID: <20191116160949.2ffc503f@archlinux>
In-Reply-To: <20191114105159.14195-4-u.kleine-koenig@pengutronix.de>
References: <20191114105159.14195-1-u.kleine-koenig@pengutronix.de>
        <20191114105159.14195-4-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 11:51:59 +0100
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> This chip is similar to the LTC2497 ADC, it just uses SPI instead of I2C
> and so has a slightly different protocol. Only the actual hardware
> access is different. The spi protocol is different enough to not be able
> to map the differences via a regmap.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
As mentioned earlier, there are restrictions on buffers being dma
safe when passed to spi calls.   This more or less requires that they
never share a cacheline with other data and the only easy way to
do that is to allocate them from the heap.  It's better to do this
once rather than every time, hence the standard trick with ___cacheline_ali=
gned
in the iio_priv structure.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig   |  10 ++++
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/ltc2496.c | 100 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>  create mode 100644 drivers/iio/adc/ltc2496.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f0af3a42f53c..deb86f6039b3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -492,6 +492,16 @@ config LTC2485
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ltc2485.
> =20
> +config LTC2496
> +	tristate "Linear Technology LTC2496 ADC driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Linear Technology LTC2496
> +	  16-Bit 8-/16-Channel Delta Sigma ADC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ltc2496.
> +
>  config LTC2497
>  	tristate "Linear Technology LTC2497 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 660242c2cca7..afe2b6db4a5e 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_LPC18XX_ADC) +=3D lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) +=3D lpc32xx_adc.o
>  obj-$(CONFIG_LTC2471) +=3D ltc2471.o
>  obj-$(CONFIG_LTC2485) +=3D ltc2485.o
> +obj-$(CONFIG_LTC2496) +=3D ltc2496.o ltc249x.o
>  obj-$(CONFIG_LTC2497) +=3D ltc2497.o ltc249x.o
>  obj-$(CONFIG_MAX1027) +=3D max1027.o
>  obj-$(CONFIG_MAX11100) +=3D max11100.o
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> new file mode 100644
> index 000000000000..870526c6df1b
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ltc2496.c - Driver for Analog Devices/Linear Technology LTC2496 ADC
> + *
> + * Based on ltc2497.c which has
> + * Copyright (C) 2017 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/2496fc.pdf
> + */
> +
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "ltc249x.h"
> +
> +struct ltc2496_st {
> +	/* this must be the first member */
> +	struct ltc249x_driverdata common_ddata;
> +	struct spi_device *spi;
> +};
> +
> +static int ltc2496_result_and_measure(struct ltc249x_driverdata *ddata,
> +				      u8 address, int *val)
> +{
> +	struct ltc2496_st *st =3D
> +		container_of(ddata, struct ltc2496_st, common_ddata);
> +	unsigned char txbuf[3] =3D { LTC249X_ENABLE | address, };
> +	unsigned char rxbuf[3];

You must make sure that buffers passed directly to the SPI subsystem
are not sharing a cacheline with other elements.  Hence these need
to be on the heap.. Easiest way of doing that is to use the
___cacheline_aligned tricks at the end of a iio_priv structure
(which is appropriately placed and aligned to allow this to work).

> +	struct spi_transfer t =3D {
> +		.tx_buf =3D txbuf,
> +		.rx_buf =3D rxbuf,
> +		.len =3D sizeof(txbuf),
> +	};
> +	int ret;
> +
> +	ret =3D spi_sync_transfer(st->spi, &t, 1);
> +	if (ret < 0)  {
> +		dev_err(&st->spi->dev, "spi_sync_transfer failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	if (val)
> +		*val =3D ((rxbuf[0] & 0x3f) << 12 | rxbuf[1] << 4 | rxbuf[2] >> 4)
> +			- (1 << 17);
> +
> +	return 0;
> +}
> +
> +static int ltc2496_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ltc2496_st *st;
> +	struct device *dev =3D &spi->dev;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +	st->spi =3D spi;
> +	st->common_ddata.result_and_measure =3D ltc2496_result_and_measure;
> +
> +	return ltc249x_probe(dev, indio_dev);
> +}
> +
> +static int ltc2496_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> +
> +	ltc249x_remove(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ltc2496_of_match[] =3D {
> +	{ .compatible =3D "lltc,ltc2496", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ltc2496_of_match);
> +
> +static struct spi_driver ltc2496_driver =3D {
> +	.driver =3D {
> +		.name =3D "ltc2496",
> +		.of_match_table =3D of_match_ptr(ltc2496_of_match),
> +	},
> +	.probe =3D ltc2496_probe,
> +	.remove =3D ltc2496_remove,
> +};
> +module_spi_driver(ltc2496_driver);
> +
> +MODULE_AUTHOR("Uwe Kleine-K=C3=B6nig <u.kleine-k=C3=B6nig@pengutronix.de=
>");
> +MODULE_DESCRIPTION("Linear Technology LTC2496 ADC driver");
> +MODULE_LICENSE("GPL v2");

