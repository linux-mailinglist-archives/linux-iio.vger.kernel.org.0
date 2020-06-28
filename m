Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8EF20C8D2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgF1Px3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgF1Px3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jun 2020 11:53:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD8C03E979
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 08:53:29 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpZcV-0003Rk-TU; Sun, 28 Jun 2020 17:53:27 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpZcV-0000f4-Gc; Sun, 28 Jun 2020 17:53:27 +0200
Date:   Sun, 28 Jun 2020 17:53:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 09/23] iio:adc:ltc2497 drop of_match_ptr protection
Message-ID: <20200628155324.y257v4tf5xvzb5xh@pengutronix.de>
References: <20200628123654.32830-1-jic23@kernel.org>
 <20200628123654.32830-10-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wykm4kxbgrij3fmo"
Content-Disposition: inline
In-Reply-To: <20200628123654.32830-10-jic23@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wykm4kxbgrij3fmo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2020 at 01:36:40PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This prevents the driver being used with ACPI PRP0001 based
> bindings. Also switch include to mod_devicetable.h which devices
> the used id structure.
>=20
> Note this is most about removing something I don't want want cut
> and paste into new driver rather than any thought that this particular
> driver will be used in an ACPI system (though it might!)
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/iio/adc/ltc2497.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 5db63d7c6bc5..1adddf5a88a9 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -11,7 +11,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
> =20
>  #include "ltc2497.h"
> =20
> @@ -98,7 +98,7 @@ MODULE_DEVICE_TABLE(of, ltc2497_of_match);
>  static struct i2c_driver ltc2497_driver =3D {
>  	.driver =3D {
>  		.name =3D "ltc2497",
> -		.of_match_table =3D of_match_ptr(ltc2497_of_match),
> +		.of_match_table =3D ltc2497_of_match,

This was the copy source of ltc2496_driver. there the change was fine,
so it is here:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wykm4kxbgrij3fmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl74vPEACgkQwfwUeK3K
7AmJRgf+OtxFqoQH16AKOqO01RwICqzOg62ws3wg+r1KMGdVQ8BZLiiHUZaUuUjt
9eV9Or/3jrGl+xawfdWSeAKIh+5DUPwqumTP78P7hpadsJMSNGetl7ejbDED7A4q
4LKb9iWv7DxTj4anf1/DIMY6NiGE7Vk2uNaX5hqsT1J/UDvE6uMdkNy4RJgLa+il
DEuac9giiRpVpBt4yljWagdSYTuzrnAewca6oztWBkXFXsPiy6oFvus4U3VISr42
UfzyHTA27tf9eeG4YlBhIyqKrAi0l4wBKUNRmtNfrnACGCqmQswrVLKvWTSpVRcF
IuOhEi5HGOd74IqXRSc7g96Ot4QxcA==
=u5cA
-----END PGP SIGNATURE-----

--wykm4kxbgrij3fmo--
