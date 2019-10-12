Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE953D5023
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfJLNkl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfJLNkk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:40:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F304206CD;
        Sat, 12 Oct 2019 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570887639;
        bh=zCunFHBnL5o8xUWAhY0obAxBdvIe1q5x8OaNg+9U1iY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MymwNkVRsX8m/4gQPItzUMUNjDB+sL2INkPiBiH6tfHW95lknbfFHxzWDeXLTFLfJ
         Uzsvx7nK6q2p4BJdsL9NhvhKO4pIVSNKl8pJ/pthONsv8SKGXcnYUEcEXZm/P40QjF
         yPWml66JrFv2aTS9NEJ4uweGqzxWpCbz2YYeb04I=
Date:   Sat, 12 Oct 2019 14:40:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 02/10] iio: imu: adis: add unlocked read/write function
 versions
Message-ID: <20191012144034.60e731f6@archlinux>
In-Reply-To: <ffb2ae65df5f44e7542b40e43d5ed2d8596cc415.camel@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-3-alexandru.ardelean@analog.com>
        <20191006101201.051f9249@archlinux>
        <20191007221649.4fb1ee25@archlinux>
        <944b74b85c2ff7853651b5df1b4557154fafa99b.camel@analog.com>
        <e61409aba34810d66906cece5dff0bb78c5e9385.camel@analog.com>
        <ffb2ae65df5f44e7542b40e43d5ed2d8596cc415.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Oct 2019 08:58:44 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-10-08 at 08:47 +0000, Ardelean, Alexandru wrote:
> > [External]
> >=20
> > On Tue, 2019-10-08 at 06:54 +0000, Ardelean, Alexandru wrote: =20
> > > [External]
> > >=20
> > > On Mon, 2019-10-07 at 22:16 +0100, Jonathan Cameron wrote: =20
> > > > On Sun, 6 Oct 2019 10:12:01 +0100
> > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > >  =20
> > > > > On Thu, 26 Sep 2019 14:18:04 +0300
> > > > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > > > >  =20
> > > > > > This will allow more flexible control to group reads & writes
> > > > > > into
> > > > > > a
> > > > > > single
> > > > > > lock (particularly the state_lock).
> > > > > >=20
> > > > > > The end-goal is to remove the indio_dev->mlock usage, and the
> > > > > > simplest fix
> > > > > > would have been to just add another lock, which would not be a
> > > > > > good
> > > > > > idea on
> > > > > > the long-run.
> > > > > >=20
> > > > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.co=
m>
> > > > > >    =20
> > > > > Applied to the togreg branch of iio.git and pushed out as testing
> > > > > etc.
> > > > >=20
> > > > > Jonathan
> > > > >  =20
> > > > 0-day found a potential issue (kind of) in the read functions.
> > > >  =20
> > > > > > ---
> > > > > >  drivers/iio/imu/adis.c       |  34 +++++------
> > > > > >  include/linux/iio/imu/adis.h | 114
> > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > >  2 files changed, 128 insertions(+), 20 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> > > > > > index 3c2d896e3a96..4f3be011c898 100644
> > > > > > --- a/drivers/iio/imu/adis.c
> > > > > > +++ b/drivers/iio/imu/adis.c
> > > > > > @@ -26,7 +26,14 @@
> > > > > >  #define ADIS_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> > > > > >  #define ADIS_GLOB_CMD_SW_RESET		BIT(7)
> > > > > > =20
> > > > > > -int adis_write_reg(struct adis *adis, unsigned int reg,
> > > > > > +/**
> > > > > > + * __adis_write_reg() - write N bytes to register (unlocked
> > > > > > version)
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the lower of the two registers
> > > > > > + * @value: The value to write to device (up to 4 bytes)
> > > > > > + * @size: The size of the @value (in bytes)
> > > > > > + */
> > > > > > +int __adis_write_reg(struct adis *adis, unsigned int reg,
> > > > > >  	unsigned int value, unsigned int size)
> > > > > >  {
> > > > > >  	unsigned int page =3D reg / ADIS_PAGE_SIZE;
> > > > > > @@ -70,8 +77,6 @@ int adis_write_reg(struct adis *adis, unsigned
> > > > > > int
> > > > > > reg,
> > > > > >  		},
> > > > > >  	};
> > > > > > =20
> > > > > > -	mutex_lock(&adis->state_lock);
> > > > > > -
> > > > > >  	spi_message_init(&msg);
> > > > > > =20
> > > > > >  	if (adis->current_page !=3D page) {
> > > > > > @@ -96,8 +101,7 @@ int adis_write_reg(struct adis *adis, unsign=
ed
> > > > > > int
> > > > > > reg,
> > > > > >  		adis->tx[3] =3D value & 0xff;
> > > > > >  		break;
> > > > > >  	default:
> > > > > > -		ret =3D -EINVAL;
> > > > > > -		goto out_unlock;
> > > > > > +		return -EINVAL;
> > > > > >  	}
> > > > > > =20
> > > > > >  	xfers[size].cs_change =3D 0;
> > > > > > @@ -113,20 +117,18 @@ int adis_write_reg(struct adis *adis,
> > > > > > unsigned
> > > > > > int reg,
> > > > > >  		adis->current_page =3D page;
> > > > > >  	}
> > > > > > =20
> > > > > > -out_unlock:
> > > > > > -	mutex_unlock(&adis->state_lock);
> > > > > > -
> > > > > >  	return ret;
> > > > > >  }
> > > > > > -EXPORT_SYMBOL_GPL(adis_write_reg);
> > > > > > +EXPORT_SYMBOL_GPL(__adis_write_reg);
> > > > > > =20
> > > > > >  /**
> > > > > > - * adis_read_reg() - read 2 bytes from a 16-bit register
> > > > > > + * __adis_read_reg() - read N bytes from register (unlocked
> > > > > > version)
> > > > > >   * @adis: The adis device
> > > > > >   * @reg: The address of the lower of the two registers
> > > > > >   * @val: The value read back from the device
> > > > > > + * @size: The size of the @val buffer
> > > > > >   */
> > > > > > -int adis_read_reg(struct adis *adis, unsigned int reg,
> > > > > > +int __adis_read_reg(struct adis *adis, unsigned int reg,
> > > > > >  	unsigned int *val, unsigned int size)
> > > > > >  {
> > > > > >  	unsigned int page =3D reg / ADIS_PAGE_SIZE;
> > > > > > @@ -188,15 +190,14 @@ int adis_read_reg(struct adis *adis,
> > > > > > unsigned
> > > > > > int reg,
> > > > > >  		spi_message_add_tail(&xfers[3], &msg);
> > > > > >  		break;
> > > > > >  	default:
> > > > > > -		ret =3D -EINVAL;
> > > > > > -		goto out_unlock;
> > > > > > +		return -EINVAL;
> > > > > >  	}
> > > > > > =20
> > > > > >  	ret =3D spi_sync(adis->spi, &msg);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(&adis->spi->dev, "Failed to read register
> > > > > > 0x%02X:
> > > > > > %d\n",
> > > > > >  				reg, ret);
> > > > > > -		goto out_unlock;
> > > > > > +		return ret;
> > > > > >  	} else {
> > > > > >  		adis->current_page =3D page;
> > > > > >  	}
> > > > > > @@ -210,12 +211,9 @@ int adis_read_reg(struct adis *adis,
> > > > > > unsigned
> > > > > > int reg,
> > > > > >  		break;
> > > > > >  	}
> > > > > > =20
> > > > > > -out_unlock:
> > > > > > -	mutex_unlock(&adis->state_lock);
> > > > > > -
> > > > > >  	return ret;
> > > > > >  }
> > > > > > -EXPORT_SYMBOL_GPL(adis_read_reg);
> > > > > > +EXPORT_SYMBOL_GPL(__adis_read_reg);
> > > > > > =20
> > > > > >  #ifdef CONFIG_DEBUG_FS
> > > > > > =20
> > > > > > diff --git a/include/linux/iio/imu/adis.h
> > > > > > b/include/linux/iio/imu/adis.h
> > > > > > index 3ed5eceaac2d..3a028c40e04e 100644
> > > > > > --- a/include/linux/iio/imu/adis.h
> > > > > > +++ b/include/linux/iio/imu/adis.h
> > > > > > @@ -75,11 +75,121 @@ int adis_init(struct adis *adis, struct
> > > > > > iio_dev
> > > > > > *indio_dev,
> > > > > >  	struct spi_device *spi, const struct adis_data *data);
> > > > > >  int adis_reset(struct adis *adis);
> > > > > > =20
> > > > > > -int adis_write_reg(struct adis *adis, unsigned int reg,
> > > > > > +int __adis_write_reg(struct adis *adis, unsigned int reg,
> > > > > >  	unsigned int val, unsigned int size);
> > > > > > -int adis_read_reg(struct adis *adis, unsigned int reg,
> > > > > > +int __adis_read_reg(struct adis *adis, unsigned int reg,
> > > > > >  	unsigned int *val, unsigned int size);
> > > > > > =20
> > > > > > +/**
> > > > > > + * __adis_write_reg_8() - Write single byte to a register
> > > > > > (unlocked
> > > > > > version)
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the register to be written
> > > > > > + * @value: The value to write
> > > > > > + */
> > > > > > +static inline int __adis_write_reg_8(struct adis *adis, unsign=
ed
> > > > > > int
> > > > > > reg,
> > > > > > +	uint8_t val)
> > > > > > +{
> > > > > > +	return __adis_write_reg(adis, reg, val, 1);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * __adis_write_reg_16() - Write 2 bytes to a pair of registers
> > > > > > (unlocked version)
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the lower of the two registers
> > > > > > + * @value: Value to be written
> > > > > > + */
> > > > > > +static inline int __adis_write_reg_16(struct adis *adis,
> > > > > > unsigned
> > > > > > int reg,
> > > > > > +	uint16_t val)
> > > > > > +{
> > > > > > +	return __adis_write_reg(adis, reg, val, 2);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * __adis_write_reg_32() - write 4 bytes to four registers
> > > > > > (unlocked
> > > > > > version)
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the lower of the four register
> > > > > > + * @value: Value to be written
> > > > > > + */
> > > > > > +static inline int __adis_write_reg_32(struct adis *adis,
> > > > > > unsigned
> > > > > > int reg,
> > > > > > +	uint32_t val)
> > > > > > +{
> > > > > > +	return __adis_write_reg(adis, reg, val, 4);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * __adis_read_reg_16() - read 2 bytes from a 16-bit register
> > > > > > (unlocked version)
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the lower of the two registers
> > > > > > + * @val: The value read back from the device
> > > > > > + */
> > > > > > +static inline int __adis_read_reg_16(struct adis *adis, unsign=
ed
> > > > > > int
> > > > > > reg,
> > > > > > +	uint16_t *val)
> > > > > > +{
> > > > > > +	unsigned int tmp;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret =3D __adis_read_reg(adis, reg, &tmp, 2); =20
> > > > Zero day isn't happy that this can use tmp without it actually being
> > > > set
> > > > in the
> > > > __adis_read_reg.
> > > >=20
> > > > I've added
> > > > 	if (ret)
> > > > 		return ret; =20
> > > > > > +	*val =3D tmp;
> > > > > > +
> > > > > > +	return ret; =20
> > > > and changed this to return 0;
> > > >=20
> > > > Same in the 32bit case below.
> > > >=20
> > > > Hmm. There are quite a few sparse warnings in the adis16400 if anyo=
ne
> > > > fancies
> > > > cleaning them up ;) =20
> > >=20
> > > Well, I've been planning to setup sparse as part of our CI.
> > > I guess this is another nudge in that direction. =20
> >=20
> > I did find some warnings.
> > But they seem to be reported by GCC 8.
> > Not sure if GCC 7 reported them.
> > I re-installed my laptop [changed to another one], so maybe my default =
is
> > now 8; or maybe I did not notice this initially when I built it and
> > picked
> > it up from our master branch.
> >=20
> > Sparse reports nothing for the IMU drivers.
> > Should I try something newer?
Nah. I just misread which thing was producing them whilst doing a
build with sparse and gcc.

Oops.

Thanks,

Jonathan

> >=20
> > sparse --version
> > 0.6.0 (Ubuntu: 0.6.0-3)
> >=20
> > -----------------------------------------------------------------
> > ARCH=3Darm CROSS_COMPILE=3D~/work/linux/gcc-linaro-5.5.0-2017.10-x86_64=
_arm-
> > linux-gnueabi/bin/arm-linux-gnueabi- make C=3D2 drivers/iio/imu/ =20
>=20
> Wait.
> That looks like GCC 5.5
> So, maybe I was an idiot.
>=20
> Oh well  =C2=AF\_(=E3=83=84)_/=C2=AF
> The faults of multi-tasking
>=20
> >   CHECK   scripts/mod/empty.c
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   CHECK   drivers/iio/imu/adis16400.c
> >   CHECK   drivers/iio/imu/adis16460.c
> >   CHECK   drivers/iio/imu/adis16480.c
> >   CHECK   drivers/iio/imu/adis.c
> >   CHECK   drivers/iio/imu/adis_trigger.c
> >   CHECK   drivers/iio/imu/adis_buffer.c
> > -----------------------------------------------------------------
> >  =20
> > > Thanks
> > > Alex
> > >  =20
> > > > Thanks,
> > > >=20
> > > > Jonathan
> > > >  =20
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * __adis_read_reg_32() - read 4 bytes from a 32-bit register
> > > > > > (unlocked version)
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the lower of the two registers
> > > > > > + * @val: The value read back from the device
> > > > > > + */
> > > > > > +static inline int __adis_read_reg_32(struct adis *adis, unsign=
ed
> > > > > > int
> > > > > > reg,
> > > > > > +	uint32_t *val)
> > > > > > +{
> > > > > > +	unsigned int tmp;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret =3D __adis_read_reg(adis, reg, &tmp, 4);
> > > > > > +	*val =3D tmp;
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * adis_write_reg() - write N bytes to register
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the lower of the two registers
> > > > > > + * @value: The value to write to device (up to 4 bytes)
> > > > > > + * @size: The size of the @value (in bytes)
> > > > > > + */
> > > > > > +static inline int adis_write_reg(struct adis *adis, unsigned i=
nt
> > > > > > reg,
> > > > > > +	unsigned int val, unsigned int size)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	mutex_lock(&adis->state_lock);
> > > > > > +	ret =3D __adis_write_reg(adis, reg, val, size);
> > > > > > +	mutex_unlock(&adis->state_lock);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * adis_read_reg() - read N bytes from register
> > > > > > + * @adis: The adis device
> > > > > > + * @reg: The address of the lower of the two registers
> > > > > > + * @val: The value read back from the device
> > > > > > + * @size: The size of the @val buffer
> > > > > > + */
> > > > > > +static int adis_read_reg(struct adis *adis, unsigned int reg,
> > > > > > +	unsigned int *val, unsigned int size)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	mutex_lock(&adis->state_lock);
> > > > > > +	ret =3D __adis_read_reg(adis, reg, val, size);
> > > > > > +	mutex_unlock(&adis->state_lock);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * adis_write_reg_8() - Write single byte to a register
> > > > > >   * @adis: The adis device   =20

