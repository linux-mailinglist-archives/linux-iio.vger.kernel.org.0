Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD5388A8B
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbhESJXG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 May 2021 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbhESJWe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 May 2021 05:22:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D4C061760
        for <linux-iio@vger.kernel.org>; Wed, 19 May 2021 02:21:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ljIO2-0008FI-Vx; Wed, 19 May 2021 11:21:06 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ljIO0-0005od-GC; Wed, 19 May 2021 11:21:04 +0200
Date:   Wed, 19 May 2021 11:21:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Meng.Li@windriver.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Message-ID: <20210519092104.pntanimcjg6s6fca@pengutronix.de>
References: <20210512045725.23390-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="toqk7euiytahbw7x"
Content-Disposition: inline
In-Reply-To: <20210512045725.23390-1-Meng.Li@windriver.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--toqk7euiytahbw7x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 12:57:25PM +0800, Meng.Li@windriver.com wrote:
> From: Meng Li <Meng.Li@windriver.com>
>=20
> When read adc conversion value with below command:
> cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> There is an error reported as below:
> ltc2497 0-0014: i2c transfer failed: -EREMOTEIO
> This i2c transfer issue is introduced by commit 69548b7c2c4f ("iio:
> adc: ltc2497: split protocol independent part in a separate module").
> When extract the common code into ltc2497-core.c, it change the
> code logic of function ltc2497core_read(). With wrong reading
> sequence, the action of enable adc channel is sent to chip again
> during adc channel is in conversion status. In this way, there is
> no ack from chip, and then cause i2c transfer failed.
> In order to keep the code logic is the same with original ideal,
> it is need to return direct after reading the adc conversion value.
>=20
> Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part =
in a separate module ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/iio/adc/ltc2497.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 1adddf5a88a9..fd5a66860a47 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct ltc2497cor=
e_driverdata *ddata,
>  		}
> =20
>  		*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> +
> +		return ret;

This looks wrong for me. The idea of the function
ltc2497_result_and_measure is that it reads the result and starts a new
measurement. I guess the problem is that ltc2497_result_and_measure is
called to early, not that it does too much.

But note I don't have such a system handy to actually debug this any
more.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--toqk7euiytahbw7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCk2H0ACgkQwfwUeK3K
7AmOowf8C5SX5w3Mlrpv6eP+p8p/f3M5PFSjEPPXpXbkewm9rttFdx8Y694Jc8PE
Xab6b/KfczMhm0SZqmeBOlRrhD77LayokbT2451gtuVEy3uGzRhjVlCLCq3TY+ND
YUGV/IUKIr4RhGtWnOacrCLbs4H6wQaTX1Njq2YjTyRlrYNjNiY9b6FUdMmKDWXp
MBx5WHlM/V+8SR0qx7DlXLmLOKiUA1caoGBxdjXq9rke1AbGystKQUR4UrHPZKA3
spY+2b8+hQo1z93b6YpF/orHOPzTseecRNevJCo55rh7hhyI/ddrZ0Zg3CyyeG5g
khwhIDFLaIQ7KdcuIUdoFA0N2DCOvg==
=eD2f
-----END PGP SIGNATURE-----

--toqk7euiytahbw7x--
