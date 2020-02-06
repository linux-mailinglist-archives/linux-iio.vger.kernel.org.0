Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6026154266
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBFKzB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgBFKzB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 05:55:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51CD220658;
        Thu,  6 Feb 2020 10:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580986499;
        bh=Wp2idWCrlZzdwG/OpRC1Wyjz/+P50vmpCtWgHDDf2ns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EDOqEZ7ja3QO9jrWCSxLkc9LbICLlRymcX9PPvcijpDyZyCsljLPAjUmGsbnVRgTH
         qhbdzVRUAbRoKkMNyY0aCEwDoO8gFcAfE8K08yKhXQSLyeiluY4f1ulHCe8yw0EbSH
         H6aD9fPIZpb1uNOtZbxUG+jwIMZBxIW/mX6o0c2M=
Date:   Thu, 6 Feb 2020 10:54:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: Re: [PATCH 3/3] iio: dac: ltc2632: add support for LTC2636 family
Message-ID: <20200206105453.1d99b6ed@archlinux>
In-Reply-To: <20200202095428.238af727@archlinux>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
        <20200130131549.1170-3-u.kleine-koenig@pengutronix.de>
        <20200202095428.238af727@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Feb 2020 09:54:28 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 30 Jan 2020 14:15:49 +0100
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > The only difference between LTC2632 and LTC2636 is that the former has
> > two DAC channels while the latter has eight.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =
=20
> Looks good to me. I'd like to give a little time for Maxime and Silvan
> to have a look if they wish.
>=20
> If I seem to have lost this in a few weeks, give me a poke!

Applied thanks,

Jonathan

>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/dac/Kconfig   |  5 ++-
> >  drivers/iio/dac/ltc2632.c | 77 +++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 77 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index cc42219a64f7..33a35ebe4fed 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -132,11 +132,12 @@ config LTC1660
> >  	  module will be called ltc1660.
> > =20
> >  config LTC2632
> > -	tristate "Linear Technology LTC2632-12/10/8 DAC spi driver"
> > +	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC s=
pi driver"
> >  	depends on SPI
> >  	help
> >  	  Say yes here to build support for Linear Technology
> > -	  LTC2632-12, LTC2632-10, LTC2632-8 converters (DAC).
> > +	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
> > +	  LTC2636-8 converters (DAC).
> > =20
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ltc2632.
> > diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> > index 7ab92e178496..1e7ffa0f6071 100644
> > --- a/drivers/iio/dac/ltc2632.c
> > +++ b/drivers/iio/dac/ltc2632.c
> > @@ -12,8 +12,6 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/regulator/consumer.h>
> > =20
> > -#define LTC2632_DAC_CHANNELS                    2
> > -
> >  #define LTC2632_ADDR_DAC0                       0x0
> >  #define LTC2632_ADDR_DAC1                       0x1
> > =20
> > @@ -33,6 +31,7 @@
> >   */
> >  struct ltc2632_chip_info {
> >  	const struct iio_chan_spec *channels;
> > +	const size_t num_channels;
> >  	const int vref_mv;
> >  };
> > =20
> > @@ -57,6 +56,12 @@ enum ltc2632_supported_device_ids {
> >  	ID_LTC2632H12,
> >  	ID_LTC2632H10,
> >  	ID_LTC2632H8,
> > +	ID_LTC2636L12,
> > +	ID_LTC2636L10,
> > +	ID_LTC2636L8,
> > +	ID_LTC2636H12,
> > +	ID_LTC2636H10,
> > +	ID_LTC2636H8,
> >  };
> > =20
> >  static int ltc2632_spi_write(struct spi_device *spi,
> > @@ -190,6 +195,12 @@ static const struct iio_chan_spec_ext_info ltc2632=
_ext_info[] =3D {
> >  	const struct iio_chan_spec _name ## _channels[] =3D { \
> >  		LTC2632_CHANNEL(0, _bits), \
> >  		LTC2632_CHANNEL(1, _bits), \
> > +		LTC2632_CHANNEL(2, _bits), \
> > +		LTC2632_CHANNEL(3, _bits), \
> > +		LTC2632_CHANNEL(4, _bits), \
> > +		LTC2632_CHANNEL(5, _bits), \
> > +		LTC2632_CHANNEL(6, _bits), \
> > +		LTC2632_CHANNEL(7, _bits), \
> >  	}
> > =20
> >  static DECLARE_LTC2632_CHANNELS(ltc2632x12, 12);
> > @@ -199,26 +210,62 @@ static DECLARE_LTC2632_CHANNELS(ltc2632x8, 8);
> >  static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] =3D {
> >  	[ID_LTC2632L12] =3D {
> >  		.channels	=3D ltc2632x12_channels,
> > +		.num_channels	=3D 2,
> >  		.vref_mv	=3D 2500,
> >  	},
> >  	[ID_LTC2632L10] =3D {
> >  		.channels	=3D ltc2632x10_channels,
> > +		.num_channels	=3D 2,
> >  		.vref_mv	=3D 2500,
> >  	},
> >  	[ID_LTC2632L8] =3D  {
> >  		.channels	=3D ltc2632x8_channels,
> > +		.num_channels	=3D 2,
> >  		.vref_mv	=3D 2500,
> >  	},
> >  	[ID_LTC2632H12] =3D {
> >  		.channels	=3D ltc2632x12_channels,
> > +		.num_channels	=3D 2,
> >  		.vref_mv	=3D 4096,
> >  	},
> >  	[ID_LTC2632H10] =3D {
> >  		.channels	=3D ltc2632x10_channels,
> > +		.num_channels	=3D 2,
> >  		.vref_mv	=3D 4096,
> >  	},
> >  	[ID_LTC2632H8] =3D  {
> >  		.channels	=3D ltc2632x8_channels,
> > +		.num_channels	=3D 2,
> > +		.vref_mv	=3D 4096,
> > +	},
> > +	[ID_LTC2636L12] =3D {
> > +		.channels	=3D ltc2632x12_channels,
> > +		.num_channels	=3D 8,
> > +		.vref_mv	=3D 2500,
> > +	},
> > +	[ID_LTC2636L10] =3D {
> > +		.channels	=3D ltc2632x10_channels,
> > +		.num_channels	=3D 8,
> > +		.vref_mv	=3D 2500,
> > +	},
> > +	[ID_LTC2636L8] =3D  {
> > +		.channels	=3D ltc2632x8_channels,
> > +		.num_channels	=3D 8,
> > +		.vref_mv	=3D 2500,
> > +	},
> > +	[ID_LTC2636H12] =3D {
> > +		.channels	=3D ltc2632x12_channels,
> > +		.num_channels	=3D 8,
> > +		.vref_mv	=3D 4096,
> > +	},
> > +	[ID_LTC2636H10] =3D {
> > +		.channels	=3D ltc2632x10_channels,
> > +		.num_channels	=3D 8,
> > +		.vref_mv	=3D 4096,
> > +	},
> > +	[ID_LTC2636H8] =3D  {
> > +		.channels	=3D ltc2632x8_channels,
> > +		.num_channels	=3D 8,
> >  		.vref_mv	=3D 4096,
> >  	},
> >  };
> > @@ -287,7 +334,7 @@ static int ltc2632_probe(struct spi_device *spi)
> >  	indio_dev->info =3D &ltc2632_info;
> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> >  	indio_dev->channels =3D chip_info->channels;
> > -	indio_dev->num_channels =3D LTC2632_DAC_CHANNELS;
> > +	indio_dev->num_channels =3D chip_info->num_channels;
> > =20
> >  	return iio_device_register(indio_dev);
> >  }
> > @@ -312,6 +359,12 @@ static const struct spi_device_id ltc2632_id[] =3D=
 {
> >  	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12=
] },
> >  	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10=
] },
> >  	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] =
},
> > +	{ "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L12=
] },
> > +	{ "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L10=
] },
> > +	{ "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8] =
},
> > +	{ "ltc2636-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H12=
] },
> > +	{ "ltc2636-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H10=
] },
> > +	{ "ltc2636-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H8] =
},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(spi, ltc2632_id);
> > @@ -335,6 +388,24 @@ static const struct of_device_id ltc2632_of_match[=
] =3D {
> >  	}, {
> >  		.compatible =3D "lltc,ltc2632-h8",
> >  		.data =3D &ltc2632_chip_info_tbl[ID_LTC2632H8]
> > +	}, {
> > +		.compatible =3D "lltc,ltc2636-l12",
> > +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2636L12]
> > +	}, {
> > +		.compatible =3D "lltc,ltc2636-l10",
> > +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2636L10]
> > +	}, {
> > +		.compatible =3D "lltc,ltc2636-l8",
> > +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2636L8]
> > +	}, {
> > +		.compatible =3D "lltc,ltc2636-h12",
> > +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2636H12]
> > +	}, {
> > +		.compatible =3D "lltc,ltc2636-h10",
> > +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2636H10]
> > +	}, {
> > +		.compatible =3D "lltc,ltc2636-h8",
> > +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2636H8]
> >  	},
> >  	{}
> >  }; =20
>=20

