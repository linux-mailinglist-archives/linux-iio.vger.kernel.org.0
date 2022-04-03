Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BAE4F08F5
	for <lists+linux-iio@lfdr.de>; Sun,  3 Apr 2022 13:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356493AbiDCLRD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Apr 2022 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356871AbiDCLRD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2022 07:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72AA2ED76;
        Sun,  3 Apr 2022 04:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5793E61035;
        Sun,  3 Apr 2022 11:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD61C340F0;
        Sun,  3 Apr 2022 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648984508;
        bh=u/JUR2HcE09owMn/zh6CuDg+VeXjsm74g9DSzWR3tjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5v/VM4rKaUHSK9Q0PnHjPfsKIiWTfpQuqRcbb30JanPPGnfROxHfjC9NwmV6Kw2X
         Ny4/NSIZj5AXX/CqxkhBAMbyIYV+ScMTbELc/iTLCLIRg37fyUyffOKzvJLCDJXaHt
         RQCf3wHCCyaCDzIx5Tvzja4LeR2KPxde8J6t4U7NpZJ8Us0fJYWOtsLdnniJZrwmH1
         bDGSpVCvbrm0jHIfMBuP3Gd3TEO0NVQ+doxW27RCnkzPx0vsixlHy1xLTzrzmKYM3u
         0yU5/+u6Q8hVD0g35vKABlTlauzuKET28ixVDQRu9lu4xXMlinD+vZZ+0KkX6wUZtK
         bac557IDtmAFg==
Date:   Sun, 3 Apr 2022 13:15:04 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ASM330LHHX
Message-ID: <YkmBuDOSrHzh3pFc@lore-desk>
References: <cover.1648893892.git.lorenzo@kernel.org>
 <05cd9e612bf7304542aa1adf12025ae396b87cf2.1648893892.git.lorenzo@kernel.org>
 <20220402172240.2465e7f5@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F5Fav6UVPwVhK7sH"
Content-Disposition: inline
In-Reply-To: <20220402172240.2465e7f5@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--F5Fav6UVPwVhK7sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat,  2 Apr 2022 12:09:29 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Add support to STM  ASM330LHHX (acc + gyro) Mems sensor
> > https://www.st.com/resource/en/datasheet/asm330lhhx.pdf
> Use a Datasheet tag as below.
> Perhaps mention it's an automotive rated sensor and that
> it's compatible otherwise with xxx existing part.

ack, will do

>=20
> Quick glance at the datasheet suggests this part has a sensor hub...
> Should it be in a the block with parameters for that as you
> currently have it in the one for no sensorhub I think.
>=20
> Or is it using an incompatible sensor hub interface?

asm330lhhx supports sensor hub with the same configuration of LSM6DSR or
LSM6DSO.

Regards,
Lorenzo

>=20
> >=20
> Datasheet: https://www.st.com/resource/en/datasheet/asm330lhhx.pdf
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/Kconfig             | 6 +++---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 ++-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 6 +++++-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
> >  6 files changed, 22 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_ls=
m6dsx/Kconfig
> > index 85860217aaf3..fefd0b939100 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> > +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > @@ -11,9 +11,9 @@ config IIO_ST_LSM6DSX
> >  	help
> >  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
> >  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> > -	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
> > -	  ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, the accelerometer/gyroscope
> > -	  of lsm9ds1 and lsm6dst.
> > +	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
> > +	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop,
> > +	  the accelerometer/gyroscope of lsm9ds1 and lsm6dst.
> > =20
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called st_lsm6dsx.
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 6ac4eac36458..a86dd29a4738 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -31,6 +31,7 @@
> >  #define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
> >  #define ST_LSM6DST_DEV_NAME	"lsm6dst"
> >  #define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
> > +#define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
> > =20
> >  enum st_lsm6dsx_hw_id {
> >  	ST_LSM6DS3_ID,
> > @@ -49,6 +50,7 @@ enum st_lsm6dsx_hw_id {
> >  	ST_LSM6DSRX_ID,
> >  	ST_LSM6DST_ID,
> >  	ST_LSM6DSOP_ID,
> > +	ST_ASM330LHHX_ID,
> >  	ST_LSM6DSX_MAX_ID,
> >  };
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 16730a780964..38bb5f645ebd 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -14,7 +14,8 @@
> >   * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on =
the
> >   * value of the decimation factor and ODR set for each FIFO data set.
> >   *
> > - * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/LSM6DSRX/ISM330DHCX/LSM6DST/LSM6=
DSOP:
> > + * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
> > + * LSM6DST/LSM6DSOP:
> >   * The FIFO buffer can be configured to store data from gyroscope and
> >   * accelerometer. Each sample is queued with a tag (1B) indicating data
> >   * source (gyroscope, accelerometer, hw timer).
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index b1d8d5a66f01..910397716833 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -26,7 +26,7 @@
> >   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/=
+-2000
> >   *   - FIFO size: 4KB
> >   *
> > - * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP:
> > + * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/=
LSM6DSOP:
> >   *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, =
208, 416,
> >   *     833
> >   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> > @@ -786,6 +786,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.hw_id =3D ST_LSM6DST_ID,
> >  				.name =3D ST_LSM6DST_DEV_NAME,
> >  				.wai =3D 0x6d,
> > +			}, {
> > +				.hw_id =3D ST_ASM330LHHX_ID,
> > +				.name =3D ST_ASM330LHHX_DEV_NAME,
> > +				.wai =3D 0x6b,
>=20
> Probably nicer to put it next to he other 0x6b entries.
>=20
> >  			},
> >  		},
> >  		.channels =3D {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > index 8b4fc2c15622..715fbdc8190e 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > @@ -101,6 +101,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of=
_match[] =3D {
> >  		.compatible =3D "st,lsm6dsop",
> >  		.data =3D (void *)ST_LSM6DSOP_ID,
> >  	},
> > +	{
> > +		.compatible =3D "st,asm330lhhx",
> > +		.data =3D (void *)ST_ASM330LHHX_ID,
> > +	},
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> > @@ -122,6 +126,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id=
_table[] =3D {
> >  	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
> >  	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
> >  	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
> > +	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > index e80110b6b280..f5767cf76c1d 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > @@ -101,6 +101,10 @@ static const struct of_device_id st_lsm6dsx_spi_of=
_match[] =3D {
> >  		.compatible =3D "st,lsm6dsop",
> >  		.data =3D (void *)ST_LSM6DSOP_ID,
> >  	},
> > +	{
> > +		.compatible =3D "st,asm330lhhx",
> > +		.data =3D (void *)ST_ASM330LHHX_ID,
> > +	},
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> > @@ -122,6 +126,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id=
_table[] =3D {
> >  	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
> >  	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
> >  	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
> > +	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>=20

--F5Fav6UVPwVhK7sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYkmBuAAKCRA6cBh0uS2t
rNCLAPwOlL1TO/TLEa2oHtEiWmQXBf/FzpcQla7MJhAV0L/h6wEAmQ0i/b69G1Ut
XutngZL+C0E6/4tFJT6f07eWp8k/AwQ=
=RV1J
-----END PGP SIGNATURE-----

--F5Fav6UVPwVhK7sH--
