Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21525107F97
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 18:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKWRML (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 12:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfKWRML (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 12:12:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D448A20719;
        Sat, 23 Nov 2019 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574529129;
        bh=5H64W84H7iPwDcVtU/7RmwYEJ6AQPxxLwdkt7k5EH3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hRbcggI/b7FLdye0lQ6vo5Ar8PGuesE6dBBNObvspfRlTuqGF5wvsNL0Ia1upSw9V
         ix6bUis6G4jbkGbWpG2jbQeQT/x/rdI+/lT/pk6fo0HgevjIxFB3ELhHQ4RnDDIOO8
         he2YMediZ0a1rJYYzh4MWlJxKKUXQ4llhulLphWA=
Date:   Sat, 23 Nov 2019 17:12:04 +0000
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
Subject: Re: [PATCH v3 3/3] iio: adc: new driver to support Linear
 technology's ltc2496
Message-ID: <20191123171204.3a714322@archlinux>
In-Reply-To: <20191121210007.25646-4-u.kleine-koenig@pengutronix.de>
References: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
        <20191121210007.25646-4-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Nov 2019 22:00:07 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> This chip is similar to the LTC2497 ADC, it just uses SPI instead of I2C
> and so has a slightly different protocol. Only the actual hardware
> access is different. The spi protocol is different enough to not be able
> to map the differences via a regmap.
>=20
> Also generalize the entry in MAINTAINER to cover the newly introduced
> file.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
looks good with the exception of the now overly protected DMA buffers.

See inline.  As that's all I'm seeing that needs fixing I'll just
fix this up whilst applying.

I'd like the series to sit a little longer on the list though to give
devicetree maintainers time to look at the bindings.

Thanks,

Jonathan

> ---
>  MAINTAINERS               |   2 +-
>  drivers/iio/adc/Kconfig   |  10 ++++
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/ltc2496.c | 108 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 120 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/adc/ltc2496.c
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
> index ee0c8dcfb501..c3dc2a12766a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_LPC18XX_ADC) +=3D lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) +=3D lpc32xx_adc.o
>  obj-$(CONFIG_LTC2471) +=3D ltc2471.o
>  obj-$(CONFIG_LTC2485) +=3D ltc2485.o
> +obj-$(CONFIG_LTC2496) +=3D ltc2496.o ltc2497-core.o
>  obj-$(CONFIG_LTC2497) +=3D ltc2497.o ltc2497-core.o
>  obj-$(CONFIG_MAX1027) +=3D max1027.o
>  obj-$(CONFIG_MAX11100) +=3D max11100.o
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> new file mode 100644
> index 000000000000..a7659c8f9cc9
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -0,0 +1,108 @@
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
> +#include "ltc2497.h"
> +
> +struct ltc2496_driverdata {
> +	/* this must be the first member */
> +	struct ltc2497core_driverdata common_ddata;
> +	struct spi_device *spi;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	unsigned char rxbuf[3] ____cacheline_aligned;
> +	unsigned char txbuf[3] ____cacheline_aligned;
Ah.  I've not explained this clearly enough.  Upshot is you only need
to ensure that the buffers used for dma are not shared with any other
usage.  the __cacheline_aligned marker pads the structure to ensure
the element so marked is at the start of a new cacheline.  This means
there is no sharing with non DMA related elements which may be accidentally
reset when the DMA transfer ends.

Imagine we had:
struct bob {
	int a; //used for all sorts of fun things not related to dma and not
       	       //protected from happening concurrently with dma.
	unsigned char rx_buf[3];
	unsigned char tx_buf[3]
};

The buffers are used for DMA.  The DMA engine takes a copy of the cacheline
to start doing it's magic.

Along comes other activity and writes to 'a'.

DMA completes, then engine pushes the cacheline back to the memory including
writing back what it had as a copy of a.  Thus the update to 'a' is lost.

Now the guarantee we make use of is that DMA engines are not allowed to
copy cachelines that do not contain the buffers they are using (all sorts
of things would break if they were).

However, there is no need to separate rx_buf and tx_buf as they are being
used by the same DMA engine and nothing else is going to update them whilst
they are in use.

A fun side note is that i2c never uses buffers provided to it for DMA
transfers except when using the specific dmasafe functions (which isn't
happening here).

Thanks,

Jonathan

> +};
> +
> +static int ltc2496_result_and_measure(struct ltc2497core_driverdata *dda=
ta,
> +				      u8 address, int *val)
> +{
> +	struct ltc2496_driverdata *st =3D
> +		container_of(ddata, struct ltc2496_driverdata, common_ddata);
> +	struct spi_transfer t =3D {
> +		.tx_buf =3D st->txbuf,
> +		.rx_buf =3D st->rxbuf,
> +		.len =3D sizeof(st->txbuf),
> +	};
> +	int ret;
> +
> +	st->txbuf[0] =3D LTC2497_ENABLE | address;
> +
> +	ret =3D spi_sync_transfer(st->spi, &t, 1);
> +	if (ret < 0)  {
> +		dev_err(&st->spi->dev, "spi_sync_transfer failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	if (val)
> +		*val =3D ((st->rxbuf[0] & 0x3f) << 12 |
> +			st->rxbuf[1] << 4 | st->rxbuf[2] >> 4) -
> +			(1 << 17);
> +
> +	return 0;
> +}
> +
> +static int ltc2496_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ltc2496_driverdata *st;
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
> +	return ltc2497core_probe(dev, indio_dev);
> +}
> +
> +static int ltc2496_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> +
> +	ltc2497core_remove(indio_dev);
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

