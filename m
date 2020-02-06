Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA843154156
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 10:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgBFJpI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 04:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgBFJpI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 04:45:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A6B21741;
        Thu,  6 Feb 2020 09:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580982306;
        bh=9BP/+Z99txN/wI3UF5GuYroeMC0MpoyV1pW/aW4PS+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2gQT/yPN0dbONwSTKtYOJgn/FQ15M/zlELrXpebI9Ume1TbQXz12bpHj72n0DDipx
         57O+xki7BQ42Cdpdalgb0xDtljyPnehiptkC2OLQS7qqoLG7BiWhUH4SsX+55g3hHl
         gVLffu13cbYcoeP+4bL5iz2iFJxis4UwVcurEZIE=
Date:   Thu, 6 Feb 2020 09:45:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH 2/4] iio: imu: adis: Refactor adis_initial_startup
Message-ID: <20200206094501.68f47948@archlinux>
In-Reply-To: <edea0212d5882842c92c638df13bb6e4ed8a1a82.camel@analog.com>
References: <20200120142051.28533-1-alexandru.ardelean@analog.com>
        <20200120142051.28533-2-alexandru.ardelean@analog.com>
        <20200201170839.4ab98d8e@archlinux>
        <da82db5f81e116c7ecc36f5d9833b90b4f7cd15d.camel@gmail.com>
        <20200203120338.000044c1@Huawei.com>
        <182c1f94c7311580aea1b4cabe0ab2ae26bed3a6.camel@analog.com>
        <20200205145938.00006a35@Huawei.com>
        <edea0212d5882842c92c638df13bb6e4ed8a1a82.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Feb 2020 16:44:13 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> On Wed, 2020-02-05 at 14:59 +0000, Jonathan Cameron wrote:
> > On Wed, 5 Feb 2020 12:25:40 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >  =20
> > > On Mon, 2020-02-03 at 12:03 +0000, Jonathan Cameron wrote: =20
> > > > On Mon, 3 Feb 2020 10:31:30 +0100
> > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > >    =20
> > > > > Hi Jonathan,
> > > > >=20
> > > > >=20
> > > > > On Sat, 2020-02-01 at 17:08 +0000, Jonathan Cameron wrote:   =20
> > > > > > On Mon, 20 Jan 2020 16:20:49 +0200
> > > > > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > > > > >      =20
> > > > > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > > >=20
> > > > > > > All the ADIS devices perform, at the beginning, a self test
> > > > > > > to
> > > > > > > make
> > > > > > > sure
> > > > > > > the device is in a sane state. Furthermore, some drivers
> > > > > > > also
> > > > > > > do a
> > > > > > > call
> > > > > > > to `adis_reset()` before the test which is also a good
> > > > > > > practice.
> > > > > > > This
> > > > > > > patch unifies all those operation so that, there's no need
> > > > > > > for
> > > > > > > code
> > > > > > > duplication. Furthermore, the rst pin is also checked to
> > > > > > > make
> > > > > > > sure
> > > > > > > the
> > > > > > > device is not in HW reset. On top of this, some drivers
> > > > > > > also
> > > > > > > read
> > > > > > > the
> > > > > > > device product id and compare it with the device being
> > > > > > > probed
> > > > > > > to
> > > > > > > make
> > > > > > > sure the correct device is being handled. This can also be
> > > > > > > passed
> > > > > > > to the
> > > > > > > library by introducing a variable holding the PROD_ID
> > > > > > > register
> > > > > > > of
> > > > > > > the
> > > > > > > device.
> > > > > > >=20
> > > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > > > Signed-off-by: Alexandru Ardelean <   =20
> > > > > > > alexandru.ardelean@analog.com>   =20
> > > > > > > ---
> > > > > > >  drivers/iio/imu/Kconfig      |  1 +
> > > > > > >  drivers/iio/imu/adis.c       | 63
> > > > > > > ++++++++++++++++++++++++++
> > > > > > > ----
> > > > > > > ------
> > > > > > >  include/linux/iio/imu/adis.h | 15 ++++++++-
> > > > > > >  3 files changed, 61 insertions(+), 18 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/iio/imu/Kconfig
> > > > > > > b/drivers/iio/imu/Kconfig
> > > > > > > index 60bb1029e759..63036cf473c7 100644
> > > > > > > --- a/drivers/iio/imu/Kconfig
> > > > > > > +++ b/drivers/iio/imu/Kconfig
> > > > > > > @@ -85,6 +85,7 @@ endmenu
> > > > > > > =20
> > > > > > >  config IIO_ADIS_LIB
> > > > > > >  	tristate
> > > > > > > +	depends on GPIOLIB
> > > > > > >  	help
> > > > > > >  	  A set of IO helper functions for the Analog Devices
> > > > > > > ADIS*
> > > > > > > device family.
> > > > > > > =20
> > > > > > > diff --git a/drivers/iio/imu/adis.c
> > > > > > > b/drivers/iio/imu/adis.c
> > > > > > > index d02b1911b0f2..1eca5271380e 100644
> > > > > > > --- a/drivers/iio/imu/adis.c
> > > > > > > +++ b/drivers/iio/imu/adis.c
> > > > > > > @@ -7,6 +7,7 @@
> > > > > > >   */
> > > > > > > =20
> > > > > > >  #include <linux/delay.h>
> > > > > > > +#include <linux/gpio/consumer.h>
> > > > > > >  #include <linux/mutex.h>
> > > > > > >  #include <linux/device.h>
> > > > > > >  #include <linux/kernel.h>
> > > > > > > @@ -365,36 +366,64 @@ static int adis_self_test(struct adis
> > > > > > > *adis)
> > > > > > >  }
> > > > > > > =20
> > > > > > >  /**
> > > > > > > - * adis_inital_startup() - Performs device self-test
> > > > > > > + * __adis_initial_startup() - Device initial setup
> > > > > > >   * @adis: The adis device
> > > > > > >   *
> > > > > > > + * This functions makes sure the device is not in reset,
> > > > > > > via
> > > > > > > rst
> > > > > > > pin.
> > > > > > > + * Furthermore it performs a SW reset (only in the case we
> > > > > > > are
> > > > > > > not
> > > > > > > coming from
> > > > > > > + * reset already) and a self test. It also compares the
> > > > > > > product id
> > > > > > > with the
> > > > > > > + * device id if the prod_id_reg variable is set.
> > > > > > > + *
> > > > > > >   * Returns 0 if the device is operational, a negative
> > > > > > > error
> > > > > > > code
> > > > > > > otherwise.
> > > > > > >   *
> > > > > > >   * This function should be called early on in the device
> > > > > > > initialization sequence
> > > > > > >   * to ensure that the device is in a sane and known state
> > > > > > > and
> > > > > > > that
> > > > > > > it is usable.
> > > > > > >   */
> > > > > > > -int adis_initial_startup(struct adis *adis)
> > > > > > > +int __adis_initial_startup(struct adis *adis)
> > > > > > >  {
> > > > > > >  	int ret;
> > > > > > > -
> > > > > > > -	mutex_lock(&adis->state_lock);
> > > > > > > +	struct gpio_desc *gpio;
> > > > > > > +	const struct adis_timeout *timeouts =3D adis->data-   =20
> > > > > > > > timeouts;   =20
> > > > > > > +	const char *iio_name =3D spi_get_device_id(adis->spi)-   =20
> > > > > > > > name;   =20
> > > > > > > +	u16 prod_id, dev_id;
> > > > > > > +
> > > > > > > +	/* check if the device has rst pin low */
> > > > > > > +	gpio =3D devm_gpiod_get_optional(&adis->spi->dev,
> > > > > > > "reset",
> > > > > > > GPIOD_ASIS);
> > > > > > > +	if (IS_ERR(gpio)) {
> > > > > > > +		return PTR_ERR(gpio);     =20
> > > > > >=20
> > > > > > Given you are returning here, no need for else to follow
> > > > > >=20
> > > > > > if (gpio...
> > > > > >      =20
> > > > >=20
> > > > > Definitely...
> > > > >    =20
> > > > > > > +	} else if (gpio && gpiod_get_value_cansleep(gpio)) {
> > > > > > > +		/* bring device out of reset */
> > > > > > > +		gpiod_set_value_cansleep(gpio, 0);     =20
> > > > > >=20
> > > > > > Hmm. So is a software reset the best option if we have a
> > > > > > hardware
> > > > > > reset
> > > > > > line but it's not currently in the reset mode?
> > > > > >      =20
> > > > >=20
> > > > > Hmm, that's a fair question. Now that I think about it, if we
> > > > > do
> > > > > have a
> > > > > gpio we should just assume it's in reset and call
> > > > > `gpiod_set_value_cansleep`. So, I guess we could just ditch the
> > > > > `gpiod_get_value_cansleep(gpio)` part.   =20
> > > >=20
> > > > Not sure I agree.   For example the driver may well have been
> > > > unbound
> > > > and rebound for some reason.   =20
> > >=20
> > > Yes, that is true..
> > >  =20
> > > > I would argue you should just do a set / reset cycle with
> > > > appropriate
> > > > sleep
> > > > in between.  If it's already set then no harm done, if it isn't
> > > > you
> > > > force
> > > > a hardware reset.   =20
> > >=20
> > > So, As Im understanding, it comes down to what should we consider
> > > as
> > > default. You suggest to first do the sw reset and the check the
> > > gpio
> > > state and if needed, bring the device out of reset, right? Now that
> > > I
> > > think about it, I think the only reason I haven't done like that is
> > > because you might end up sleeping quite some time (sw reset + hw
> > > reset). Either way, I'm fine with both options. Not sure if Alex
> > > has
> > > something to add... =20
> >=20
> > Either reset should be good on it's own.  I would use hardware reset
> > if the pin is there. If it's not, then use the software reset.
> >=20
> > For hardware always set the pin explicitly to reset as that
> > guarantees
> > against any race conditions, even if something odd happens.
> >=20
> > Jonathan =20
>=20
> Hmm, I think I'm not getting the point or maybe I failed to explain
> what I was doing... So, on the code in this patch, there's no HW reset.
> It checks the reset pin and sees if the part is in reset and, if it is,
> it brings it out of reset. In that case, no need for sw reset since we
> are coming already from reset. On the other hand, if there's no reset
> pin configured or the part is already powered, then I was forcing a sw
> reset to guarantee a sane state when starting...

Agreed that is what your patch is doing.   However I'm suggesting you do
something different.  Decide which type of reset takes precedence.
Normally that is hardware reset if it is wired up, but there is no
particular reason it can't be the software reset if they do exactly the
same thing.

Plan a,
If you decide the software takes precedence you need to check if the
hardware reset is already set.  If so you need to release it and carry on.
If hardware reset is not provided or not set then you just call the software
reset.

Plan b, which is the most common one for drivers IIRC...
If you decide to make the hardware reset take precedence and it's there, th=
en you
'always' set the pin for appropriate time to trigger a reset.  You don't
care what state it was previously in as either it's already in reset in whi=
ch
case you are making no change, or not in which case you enter reset.
Note this also works if you have an output only pin and no access to what
its current state is (typically because it was set by firmware).

Then you raise the gpio to take it out of reset and move on.  If the
reset is not provided then you fall back to the software reset.

Jonathan




>=20
> > >=20
> > > Nuno S=C3=A1  =20
> > > > > > > +		msleep(timeouts->reset_ms);
> > > > > > > +	} else {
> > > > > > > +		ret =3D __adis_reset(adis);
> > > > > > > +		if (ret)
> > > > > > > +			return ret;
> > > > > > > +	}
> > > > > > > =20
> > > > > > >  	ret =3D adis_self_test(adis);
> > > > > > > -	if (ret) {
> > > > > > > -		dev_err(&adis->spi->dev, "Self-test failed,
> > > > > > > trying
> > > > > > > reset.\n");
> > > > > > > -		__adis_reset(adis);
> > > > > > > -		ret =3D adis_self_test(adis);
> > > > > > > -		if (ret) {
> > > > > > > -			dev_err(&adis->spi->dev, "Second self-
> > > > > > > test
> > > > > > > failed, giving up.\n");
> > > > > > > -			goto out_unlock;
> > > > > > > -		}
> > > > > > > -	}
> > > > > > > +	if (ret)
> > > > > > > +		return ret;
> > > > > > > =20
> > > > > > > -out_unlock:
> > > > > > > -	mutex_unlock(&adis->state_lock);
> > > > > > > -	return ret;
> > > > > > > +	if (!adis->data->prod_id_reg)
> > > > > > > +		return 0;
> > > > > > > +
> > > > > > > +	ret =3D adis_read_reg_16(adis, adis->data->prod_id_reg,
> > > > > > > &prod_id);
> > > > > > > +	if (ret)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > > +	ret =3D sscanf(iio_name, "adis%hu\n", &dev_id);     =20
> > > > > >=20
> > > > > > Hmm. I have a general dislike of pulling part name strings
> > > > > > apart
> > > > > > to
> > > > > > get
> > > > > > IDs.  It tends to break when someone comes along and adds a
> > > > > > part
> > > > > > with
> > > > > > new
> > > > > > branding.  Perhaps just put it in the relevant device part
> > > > > > specific
> > > > > > structures
> > > > > > directly?
> > > > > >      =20
> > > > >=20
> > > > > I'll admit that this to orientated to ADI devices and I
> > > > > basically
> > > > > just
> > > > > took what all the drivers were doing and placed it inside the
> > > > > library...
> > > > >=20
> > > > > So, you mean passing this to each `chip_info` and then passing
> > > > > it
> > > > > to
> > > > > the library through `adis_data`?   =20
> > > >=20
> > > > Yes.  People don't tend to expect strings to need to take a
> > > > particular form,
> > > > so pulling them apart in a library can give unexpected results...
> > > >    =20
> > > > > > > +	if (ret !=3D 1)
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	if (prod_id !=3D dev_id)
> > > > > > > +		dev_warn(&adis->spi->dev,
> > > > > > > +			 "Device ID(%u) and product ID(%u) do
> > > > > > > not
> > > > > > > match.",
> > > > > > > +			 dev_id, prod_id);
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > >  }
> > > > > > > -EXPORT_SYMBOL_GPL(adis_initial_startup);
> > > > > > > +EXPORT_SYMBOL_GPL(__adis_initial_startup);
> > > > > > > =20
> > > > > > >  /**
> > > > > > >   * adis_single_conversion() - Performs a single sample
> > > > > > > conversion
> > > > > > > diff --git a/include/linux/iio/imu/adis.h
> > > > > > > b/include/linux/iio/imu/adis.h
> > > > > > > index d21a013d1122..c43e7922ab32 100644
> > > > > > > --- a/include/linux/iio/imu/adis.h
> > > > > > > +++ b/include/linux/iio/imu/adis.h
> > > > > > > @@ -41,6 +41,7 @@ struct adis_timeout {
> > > > > > >   * @glob_cmd_reg: Register address of the GLOB_CMD
> > > > > > > register
> > > > > > >   * @msc_ctrl_reg: Register address of the MSC_CTRL
> > > > > > > register
> > > > > > >   * @diag_stat_reg: Register address of the DIAG_STAT
> > > > > > > register
> > > > > > > + * @prod_id_reg: Register address of the PROD_ID register
> > > > > > >   * @self_test_reg: Register address to request self test
> > > > > > > command
> > > > > > >   * @status_error_msgs: Array of error messgaes
> > > > > > >   * @status_error_mask:
> > > > > > > @@ -54,6 +55,7 @@ struct adis_data {
> > > > > > >  	unsigned int glob_cmd_reg;
> > > > > > >  	unsigned int msc_ctrl_reg;
> > > > > > >  	unsigned int diag_stat_reg;
> > > > > > > +	unsigned int prod_id_reg;
> > > > > > > =20
> > > > > > >  	unsigned int self_test_mask;
> > > > > > >  	unsigned int self_test_reg;
> > > > > > > @@ -299,6 +301,7 @@ static inline int
> > > > > > > adis_read_reg_32(struct
> > > > > > > adis
> > > > > > > *adis, unsigned int reg,
> > > > > > > =20
> > > > > > >  int adis_enable_irq(struct adis *adis, bool enable);
> > > > > > >  int __adis_check_status(struct adis *adis);
> > > > > > > +int __adis_initial_startup(struct adis *adis);
> > > > > > > =20
> > > > > > >  static inline int adis_check_status(struct adis *adis)
> > > > > > >  {
> > > > > > > @@ -311,7 +314,17 @@ static inline int
> > > > > > > adis_check_status(struct
> > > > > > > adis *adis)
> > > > > > >  	return ret;
> > > > > > >  }
> > > > > > > =20
> > > > > > > -int adis_initial_startup(struct adis *adis);
> > > > > > > +/* locked version of __adis_initial_startup() */
> > > > > > > +static inline int adis_initial_startup(struct adis *adis)
> > > > > > > +{
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	mutex_lock(&adis->state_lock);
> > > > > > > +	ret =3D __adis_initial_startup(adis);
> > > > > > > +	mutex_unlock(&adis->state_lock);
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > > =20
> > > > > > >  int adis_single_conversion(struct iio_dev *indio_dev,
> > > > > > >  	const struct iio_chan_spec *chan, unsigned int
> > > > > > > error_mask,     =20
> > > > > >=20
> > > > > >      =20
> > > >=20
> > > >    =20
> >=20
> >  =20
>=20

