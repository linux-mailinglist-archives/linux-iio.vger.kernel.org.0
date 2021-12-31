Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6648237F
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 11:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhLaKmA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 05:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLaKl7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 05:41:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92692C061574
        for <linux-iio@vger.kernel.org>; Fri, 31 Dec 2021 02:41:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n3FMD-0003z6-Db; Fri, 31 Dec 2021 11:41:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n3FMC-007eb1-19; Fri, 31 Dec 2021 11:41:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n3FMB-0003FR-57; Fri, 31 Dec 2021 11:41:55 +0100
Date:   Fri, 31 Dec 2021 11:41:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/13] iio:accel:mma7455_core: Move exports into MMA7455
 namespace
Message-ID: <20211231104147.n35r6hkdi7cljjss@pengutronix.de>
References: <20211230193331.283503-1-jic23@kernel.org>
 <20211230193331.283503-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksrjvufbt4ove37c"
Content-Disposition: inline
In-Reply-To: <20211230193331.283503-3-jic23@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ksrjvufbt4ove37c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 30, 2021 at 07:33:20PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> In order to avoid unnecessary pollution of the global symbol namespace
> move the core mma7455 functions into an mma7455 specific namespace and
> import that into the two bus modules.
>=20
> For more information see https://lwn.net/Articles/760045/
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/iio/accel/mma7455_core.c | 6 +++---
>  drivers/iio/accel/mma7455_i2c.c  | 1 +
>  drivers/iio/accel/mma7455_spi.c  | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455=
_core.c
> index e6739ba74edf..4ece5e83a8ab 100644
> --- a/drivers/iio/accel/mma7455_core.c
> +++ b/drivers/iio/accel/mma7455_core.c
> @@ -238,7 +238,7 @@ const struct regmap_config mma7455_core_regmap =3D {
>  	.val_bits =3D 8,
>  	.max_register =3D MMA7455_REG_TW,
>  };
> -EXPORT_SYMBOL_GPL(mma7455_core_regmap);
> +EXPORT_SYMBOL_NS_GPL(mma7455_core_regmap, MMA7455);
> =20
>  int mma7455_core_probe(struct device *dev, struct regmap *regmap,
>  		       const char *name)
> @@ -293,7 +293,7 @@ int mma7455_core_probe(struct device *dev, struct reg=
map *regmap,
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(mma7455_core_probe);
> +EXPORT_SYMBOL_NS_GPL(mma7455_core_probe, MMA7455);
> =20
>  void mma7455_core_remove(struct device *dev)
>  {
> @@ -306,7 +306,7 @@ void mma7455_core_remove(struct device *dev)
>  	regmap_write(mma7455->regmap, MMA7455_REG_MCTL,
>  		     MMA7455_MCTL_MODE_STANDBY);
>  }
> -EXPORT_SYMBOL_GPL(mma7455_core_remove);
> +EXPORT_SYMBOL_NS_GPL(mma7455_core_remove, MMA7455);

There is a more subtile way to do this. Up to you to judge which you
prefer:

	#define DEFAULT_SYMBOL_NAMESPACE MMA7455

and then use plain EXPORT_SYMBOL_GPL. This way you automatically switch
all export statements in this file. (The #define has to be before
#include <linux/export.h>.)

>  MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
>  MODULE_DESCRIPTION("Freescale MMA7455L core accelerometer driver");
> diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_=
i2c.c
> index 8a5256516f9f..b7a3d5da8f87 100644
> --- a/drivers/iio/accel/mma7455_i2c.c
> +++ b/drivers/iio/accel/mma7455_i2c.c
> @@ -61,3 +61,4 @@ module_i2c_driver(mma7455_i2c_driver);
>  MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
>  MODULE_DESCRIPTION("Freescale MMA7455L I2C accelerometer driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(MMA7455);
> diff --git a/drivers/iio/accel/mma7455_spi.c b/drivers/iio/accel/mma7455_=
spi.c
> index ecf690692dcc..cc17755a1026 100644
> --- a/drivers/iio/accel/mma7455_spi.c
> +++ b/drivers/iio/accel/mma7455_spi.c
> @@ -49,3 +49,4 @@ module_spi_driver(mma7455_spi_driver);
>  MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
>  MODULE_DESCRIPTION("Freescale MMA7455L SPI accelerometer driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(MMA7455);

If you put this into the header near the declaration of the functions
exported in this namespace, you only need one instead of two.

Anyhow, I think this is much a question of personal taste which to
prefer, so understand this mail just as a hint about alternatives, not a
request to change.

Best regards and happy new year,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ksrjvufbt4ove37c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHO3mUACgkQwfwUeK3K
7Amz3gf9GANpQufgS5A6WcYfCfcVtGp6mrIkNWHKsALhm/jv/RR/Z8PmsCrPZQ5R
wStcRhiiL0w1HpqK1BXFw2BMCiZ/djfX0ObnJgDjOq5uflIQ1kdzuyW869xZ4ZG/
FPF56kW/PBcodxW3Yj9ZK1my0ri9c/fVKTdEyZEcXeBf3IvBj5gZw14aRBi94jzw
aW+BgcV8AFPAvXTmiMzZ4dJSXpGQh0+q6UuIps5GHztNgXVDZjQfflIE1e7v+MPg
IFbb/cT/YvnqxHsbGUQLpt14ABW8bSN7yZf+qGbP7Uqk334jdQEIyLcsZHlEDHBt
2pebHxOZm1E2EhUuCqUYTkfqHpHTvw==
=4eJr
-----END PGP SIGNATURE-----

--ksrjvufbt4ove37c--
