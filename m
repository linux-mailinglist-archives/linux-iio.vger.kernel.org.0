Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB89CD118
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfJFKhj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 06:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJFKhj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 06:37:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BEEE20867;
        Sun,  6 Oct 2019 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570358257;
        bh=60/zhp9MrbexMgP1J3l5xQ8eQHUrS6Kzp9jGjbsK1rY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1+KPSxzJWIBq+MaNYKjiamOu0Ur5fHIUhmIsU0tygUAooQcsMnzTDRxcYYXKEVFQN
         YqK2DqvwGKcHO9n8XHA9fcYuhKaUn1pMLHvJ1KynLAJdgZbSxZ3FoOrHmCTN76cgkr
         sBtLvj2XQy9cfbTrhNv/HRvovKa/kZGFJ7lFCi3M=
Date:   Sun, 6 Oct 2019 11:37:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/2] iio: temperature: Add support for LTC2983
Message-ID: <20191006113732.1ffd597c@archlinux>
In-Reply-To: <20191004135519.191657-1-nuno.sa@analog.com>
References: <20191004135519.191657-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Oct 2019 15:55:18 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The LTC2983 is a Multi-Sensor High Accuracy Digital Temperature
> Measurement System. It measures a wide variety of temperature sensors and
> digitally outputs the result, in =C2=B0C or =C2=B0F, with 0.1=C2=B0C accu=
racy and
> 0.001=C2=B0C resolution. It can measure the temperature of all standard
> thermocouples (type B,E,J,K,N,S,R,T), standard 2-,3-,4-wire RTDs,
> thermistors and diodes.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Two things inline that I'd missed before. Otherwise looks good.

Thanks,

Jonathan

> ---
> Changes in v2:
>  * Added some needed blank lines (for readability);
>  * Allocate iio_chan in the setup() function;
>  * Rename reset to sleep;
>  * Remove unneeded dev_dbg calls;
>  * Remove unneeded line wrapping;
>  * Remove unneeded comments;
>  * Remove extend_names. Use the standard ABI;
>  * Adapt the scales to report in millivolt and milli degrees;
>  * Adapt the of_property readings to the renaming of the properties;
>  * For custom thermistors, excitation-current cannot be set to Auto range.
>=20
> Changes in v3:
>  * Use normal `devm_request_irq`;
>  * Handle and decode the new devicetree properties for sensor configurati=
on.
>=20
>  MAINTAINERS                       |    7 +
>  drivers/iio/temperature/Kconfig   |   10 +
>  drivers/iio/temperature/Makefile  |    1 +
>  drivers/iio/temperature/ltc2983.c | 1554 +++++++++++++++++++++++++++++
>  4 files changed, 1572 insertions(+)
>  create mode 100644 drivers/iio/temperature/ltc2983.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0c03740b9fb..14a256e785ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9491,6 +9491,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
>  F:	drivers/iio/dac/ltc1660.c
> =20
> +LTC2983 IIO TEMPERATURE DRIVER
> +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> +W:	http://ez.analog.com/community/linux-device-drivers
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	drivers/iio/temperature/ltc2983.c
> +
>  LTC4261 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kc=
onfig
> index 737faa0901fe..04b5a67b593c 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -4,6 +4,16 @@
>  #
>  menu "Temperature sensors"
> =20
> +config LTC2983
> +	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement S=
ystem"
> +	depends on SPI

Select REGMAP_SPI needed I think.

> +	help
> +	  Say yes here to build support for the LTC2983 Multi-Sensor
> +	  high accuracy digital temperature measurement system.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ltc2983.
> +
>  config MAXIM_THERMOCOUPLE
>  	tristate "Maxim thermocouple sensors"
>  	depends on SPI
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/M=
akefile
> index baca4776ca0d..d6b850b0cf63 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for industrial I/O temperature drivers
>  #
> =20
> +obj-$(CONFIG_LTC2983) +=3D ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o
>  obj-$(CONFIG_MAX31856) +=3D max31856.o
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> new file mode 100644
> index 000000000000..f899c1d75f8a
> --- /dev/null
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -0,0 +1,1554 @@
...

> +static int ltc2983_chan_read(struct ltc2983_data *st,
> +			const struct ltc2983_sensor *sensor, int *val)
> +{
> +	u32 start_conversion =3D 0;
> +	int ret;
> +	unsigned long time;
> +	__be32 temp;
> +
> +	/*
> +	 * Do not allow channel readings if device is in sleep state.
> +	 * A read/write on the spi bus would bring the device prematurely
> +	 * out of sleep.
> +	 */
> +	if (st->sleep)
> +		return -EPERM;
> +
> +	start_conversion =3D LTC2983_STATUS_START(true);
> +	start_conversion |=3D LTC2983_STATUS_CHAN_SEL(sensor->chan);
> +	dev_dbg(&st->spi->dev, "Start conversion on chan:%d, status:%02X\n",
> +		sensor->chan, start_conversion);
> +	/* start conversion */
> +	ret =3D regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->completion);
> +	/*
> +	 * wait for conversion to complete.
> +	 * 300 ms should be more than enough to complete the conversion.
> +	 * Depending on the sensor configuration, there are 2/3 conversions
> +	 * cycles of 82ms.
> +	 */
> +	time =3D wait_for_completion_timeout(&st->completion,
> +					   msecs_to_jiffies(300));
> +	if (!time) {
> +		dev_warn(&st->spi->dev, "Conversion timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* read the converted data */
> +	ret =3D regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan=
),
> +			       &temp, sizeof(temp));

I'd missed this before.  regmap_bulk_read can directly use the supplied buf=
fer
for dma.  Hence it needs to be dma safe.  That means you have to have it
in it's own cacheline.  There is no way of enforcing that on the stack so
either allocate it locally from the heap, or put it at the end of the
data structure and mark it __cacheline_aligned (we make sure those structur=
es
are also cacheline aligned and on the heap specifically to allow us to do t=
hat
trick).


> +	if (ret)
> +		return ret;
> +
> +	*val =3D __be32_to_cpu(temp);
> +
> +	if (!(LTC2983_RES_VALID_MASK & *val)) {
> +		dev_err(&st->spi->dev, "Invalid conversion detected\n");
> +		return -EIO;
> +	}
> +
> +	ret =3D sensor->fault_handler(st, *val);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D sign_extend32((*val) & LTC2983_DATA_MASK, LTC2983_DATA_SIGN_BI=
T);
> +	return 0;
> +}
> +
...
