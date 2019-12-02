Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0081F10E791
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 10:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLBJXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 04:23:32 -0500
Received: from sauhun.de ([88.99.104.3]:42296 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfLBJXc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Dec 2019 04:23:32 -0500
Received: from localhost (p54B3363C.dip0.t-ipconnect.de [84.179.54.60])
        by pokefinder.org (Postfix) with ESMTPSA id 737A92C04A3;
        Mon,  2 Dec 2019 10:23:29 +0100 (CET)
Date:   Mon, 2 Dec 2019 10:23:29 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max9611: Fix too short conversion time delay
Message-ID: <20191202092328.GE1266@kunai>
References: <20191202085546.21655-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20191202085546.21655-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 09:55:46AM +0100, Geert Uytterhoeven wrote:
> As of commit b9ddd5091160793e ("iio: adc: max9611: Fix temperature
> reading in probe"), max9611 initialization sometimes fails on the
> Salvator-X(S) development board with:
>=20
>     max9611 4-007f: Invalid value received from ADC 0x8000: aborting
>     max9611: probe of 4-007f failed with error -5
>=20
> The max9611 driver tests communications with the chip by reading the die
> temperature during the probe function, which returns an invalid value.
>=20
> According to the datasheet, the typical ADC conversion time is 2 ms, but
> no minimum or maximum values are provided.  Maxim Technical Support
> confirmed this was tested with temperature Ta=3D25 degreeC, and promised
> to inform me if a maximum/minimum value is available (they didn't get
> back to me, so I assume it is not).
>=20
> However, the driver assumes a 1 ms conversion time.  Usually the
> usleep_range() call returns after more than 1.8 ms, hence it succeeds.
> When it returns earlier, the data register may be read too early, and
> the previous measurement value will be returned.  After boot, this is
> the temperature POR (power-on reset) value, causing the failure above.
>=20
> Fix this by increasing the delay from 1000-2000 =C2=B5s to 3000-3300 =C2=
=B5s.
>=20
> Note that this issue has always been present, but it was exposed by the
> aformentioned commit.
>=20
> Fixes: 69780a3bbc0b1e7e ("iio: adc: Add Maxim max9611 ADC driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

One minor nit, though:

>  	/*
>  	 * need a delay here to make register configuration
> -	 * stabilize. 1 msec at least, from empirical testing.
> +	 * stabilize.

This could be a one line comment now?


--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3k2AwACgkQFA3kzBSg
KbYq0Q/+Il7PVUqvCgQtgmQ4xQh7vOIyBSHMrRk/xrEKta+veYjdWAjzKxhOuSKk
Vqo3/mRePBeyeYvlOb4eLa9adhbyJdEfcKHsG4DMYUe8ZJbgefvKsTNUSw/JqD+0
xVc3bwHZfbYA6EbsYe8okHvzfayJ5froXtVSwyuHrj4ihgXAuQQq3sj6hDTeNYYf
ho3Z9FhmDd8ggGaMo21GYBRVXmxC4y1WnbXV7ZcrVEdQ5nrBZVwsxLVPYoc+WWDE
yHVEnWf76DiesnoEedpE+ePx1kEvVFrS16lCpehRxYnvr4KW+8s/TLiwuJifV0/X
P155awtC15gZO8L/ylWtpwSglpkTNCnGpX62ZGdWWbM//yLCo8QTRsaOdcsHzwqz
aglQlT/6rfmstBOAcYAZgkLK+AoaCUri/5FOrl+ycCkdhJYgrXdF9VfaCqXNxn+Q
FV3RCAl43qhabVPb277IVDHR8nrHp1SboTEjJcAZ7CIQihb5ghEdp0pS/Q61Saj5
KmOHvhPPf5IFdYZt9W7cpxXfL7Q0xvdrGpTVzu2OWYxbM98ObLiVdwcKzJ4j5Ptx
nL154/0j9Lz/sd9vlBHQlbr9j9JzZarEqtccMl9Kj7YeFn354G7ifaKKrPmDX3uR
zlW2UFqD8eApf0dE+95Q4gIld76pyGwJcTpqN3oYx+n/6Ku3Qhs=
=KodC
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
