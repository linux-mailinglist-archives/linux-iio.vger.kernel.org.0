Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5E19E62A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgDDPmk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgDDPmk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:42:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A88420644;
        Sat,  4 Apr 2020 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586014958;
        bh=2nbQzzTWUae4gAnFooHgdOimjhE6qkQ3FFCGp5LEx08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VlkvCwndO4kgFzhKS2cdPI+DV6x1M1e03OyEJVQAl9xp9i5EyfYN7Pjpharfjv0x5
         9hmVDfUQJdFoP9XVqD7JG1UuXWADqYaT0BgmdxvqzDXi6bWsgL71eBkJ89rxISacId
         Bb0AdTf2pzaNGphhFpDmh+M5A8Et9oPasOPcSyig=
Date:   Sat, 4 Apr 2020 16:42:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] iio: accel: st_sensors:  add support for LIS2HH12
Message-ID: <20200404164234.2e8a80d5@archlinux>
In-Reply-To: <20200330171031.GA41042@gerhold.net>
References: <20200330141923.280226-1-rvlander@gaetanandre.eu>
        <20200330141923.280226-2-rvlander@gaetanandre.eu>
        <20200330171031.GA41042@gerhold.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 19:10:31 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> Hi,
>=20
> On Mon, Mar 30, 2020 at 04:19:23PM +0200, Ga=C3=ABtan Andr=C3=A9 wrote:
> > Add support for STMicroelectronics LISHH12 accelerometer in st_accel
> > framework.
> >=20
> > https://www.st.com/resource/en/datasheet/lis2hh12.pdf
> >=20
> > Signed-off-by: Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu> =20
>=20
> Thanks a lot for sending this patch upstream!

Thanks. Applied to the togreg branch of iio.git and pushed out as testing
for the various autobuilders to poke at it.

Thanks,

Jonathan

>=20
> > ---
> >  drivers/iio/accel/Kconfig         |  2 +-
> >  drivers/iio/accel/st_accel.h      |  2 +
> >  drivers/iio/accel/st_accel_core.c | 77 +++++++++++++++++++++++++++++++
> >  drivers/iio/accel/st_accel_i2c.c  |  5 ++
> >  4 files changed, 85 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 5d91a6dda894..24ebe9e76915 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -238,7 +238,7 @@ config IIO_ST_ACCEL_3AXIS
> >  	  Say yes here to build support for STMicroelectronics accelerometers:
> >  	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
> >  	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
> > -	  LNG2DM, LIS3DE, LIS2DE12
> > +	  LNG2DM, LIS3DE, LIS2DE12, LIS2HH12
> > =20
> >  	  This driver can also be built as a module. If so, these modules
> >  	  will be created:
> > diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> > index 5b13e293cade..5d356288e001 100644
> > --- a/drivers/iio/accel/st_accel.h
> > +++ b/drivers/iio/accel/st_accel.h
> > @@ -35,6 +35,7 @@ enum st_accel_type {
> >  	LIS2DW12,
> >  	LIS3DHH,
> >  	LIS2DE12,
> > +	LIS2HH12,
> >  	ST_ACCEL_MAX,
> >  };
> > =20
> > @@ -59,6 +60,7 @@ enum st_accel_type {
> >  #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
> >  #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
> >  #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
> > +#define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
> > =20
> >  /**
> >  * struct st_sensors_platform_data - default accel platform data
> > diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_a=
ccel_core.c
> > index e2ec5d127495..43c50167d220 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -904,6 +904,83 @@ static const struct st_sensor_settings st_accel_se=
nsors_settings[] =3D {
> >  		.multi_read_bit =3D true,
> >  		.bootime =3D 2,
> >  	},
> > +	{
> > +		.wai =3D 0x41,
> > +		.wai_addr =3D ST_SENSORS_DEFAULT_WAI_ADDRESS,
> > +		.sensors_supported =3D {
> > +			[0] =3D LIS2HH12_ACCEL_DEV_NAME,
> > +		},
> > +		.ch =3D (struct iio_chan_spec *)st_accel_16bit_channels,
> > +		.odr =3D {
> > +			.addr =3D 0x20,
> > +			.mask =3D 0x70,
> > +			.odr_avl =3D {
> > +				{ .hz =3D 10, .value =3D 0x01, },
> > +				{ .hz =3D 50, .value =3D 0x02, },
> > +				{ .hz =3D 100, .value =3D 0x03, },
> > +				{ .hz =3D 200, .value =3D 0x04, },
> > +				{ .hz =3D 400, .value =3D 0x05, },
> > +				{ .hz =3D 800, .value =3D 0x06, },
> > +			},
> > +		},
> > +		.pw =3D {
> > +			.addr =3D 0x20,
> > +			.mask =3D 0x70,
> > +			.value_off =3D ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> > +		},
> > +		.enable_axis =3D {
> > +			.addr =3D ST_SENSORS_DEFAULT_AXIS_ADDR,
> > +			.mask =3D ST_SENSORS_DEFAULT_AXIS_MASK,
> > +		},
> > +		.fs =3D {
> > +			.addr =3D 0x23,
> > +			.mask =3D 0x30,
> > +			.fs_avl =3D {
> > +				[0] =3D {
> > +					.num =3D ST_ACCEL_FS_AVL_2G,
> > +					.value =3D 0x00,
> > +					.gain =3D IIO_G_TO_M_S_2(61),
> > +				},
> > +				[1] =3D {
> > +					.num =3D ST_ACCEL_FS_AVL_4G,
> > +					.value =3D 0x02,
> > +					.gain =3D IIO_G_TO_M_S_2(122),
> > +				},
> > +				[2] =3D {
> > +					.num =3D ST_ACCEL_FS_AVL_8G,
> > +					.value =3D 0x03,
> > +					.gain =3D IIO_G_TO_M_S_2(244),
> > +				},
> > +			},
> > +		},
> > +		.bdu =3D {
> > +			.addr =3D 0x20,
> > +			.mask =3D 0x08,
> > +		},
> > +		.drdy_irq =3D {
> > +			.int1 =3D {
> > +				.addr =3D 0x22,
> > +				.mask =3D 0x01,
> > +			},
> > +			.int2 =3D {
> > +				.addr =3D 0x25,
> > +				.mask =3D 0x01,
> > +			},
> > +			.addr_ihl =3D 0x24,
> > +			.mask_ihl =3D 0x02,
> > +			.stat_drdy =3D {
> > +				.addr =3D ST_SENSORS_DEFAULT_STAT_ADDR,
> > +				.mask =3D 0x07,
> > +			},
> > +		},
> > +		.sim =3D {
> > +			.addr =3D 0x23,
> > +			.value =3D BIT(0),
> > +		},
> > +		.multi_read_bit =3D true,
> > +		.bootime =3D 2,
> > +	},
> > +
> >  }; =20
>=20
> I checked that this conforms to the information in the linked datasheet:
>=20
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
>=20
> > =20
> >  static int st_accel_read_raw(struct iio_dev *indio_dev,
> > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_ac=
cel_i2c.c
> > index 8c489312f668..821854251a7b 100644
> > --- a/drivers/iio/accel/st_accel_i2c.c
> > +++ b/drivers/iio/accel/st_accel_i2c.c
> > @@ -104,6 +104,10 @@ static const struct of_device_id st_accel_of_match=
[] =3D {
> >  		.compatible =3D "st,lis2de12",
> >  		.data =3D LIS2DE12_ACCEL_DEV_NAME,
> >  	},
> > +	{
> > +		.compatible =3D "st,lis2hh12",
> > +		.data =3D LIS2HH12_ACCEL_DEV_NAME,
> > +	},
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> > @@ -138,6 +142,7 @@ static const struct i2c_device_id st_accel_id_table=
[] =3D {
> >  	{ LIS2DW12_ACCEL_DEV_NAME },
> >  	{ LIS3DE_ACCEL_DEV_NAME },
> >  	{ LIS2DE12_ACCEL_DEV_NAME },
> > +	{ LIS2HH12_ACCEL_DEV_NAME },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> > --=20
> > 2.26.0 =20

