Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43711C110D
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgEAKpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 06:45:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58848 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgEAKpL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 May 2020 06:45:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 71D2F2A059D
Received: by earth.universe (Postfix, from userid 1000)
        id 086BB3C08C7; Fri,  1 May 2020 12:45:07 +0200 (CEST)
Date:   Fri, 1 May 2020 12:45:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 6/6] MAINTAINERS: Add entry for mp2629 Battery
 Charger driver
Message-ID: <20200501104506.zwsbjof2m6rztysu@earth.universe>
References: <20200430155810.21383-1-sravanhome@gmail.com>
 <20200430155810.21383-7-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ukgyituuhoa7vlvd"
Content-Disposition: inline
In-Reply-To: <20200430155810.21383-7-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ukgyituuhoa7vlvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 30, 2020 at 05:58:10PM +0200, Saravanan Sekar wrote:
> Add MAINTAINERS entry for Monolithic Power Systems mp2629 Charger driver.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32a95d162f06..0f82d5a7a614 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11358,10 +11358,15 @@ F:	drivers/tty/mxser.*
>  MONOLITHIC POWER SYSTEM PMIC DRIVER
>  M:	Saravanan Sekar <sravanhome@gmail.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>  F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
> +F:	drivers/iio/adc/mp2629_adc.c
> +F:	drivers/mfd/mp2629.c
> +F:	drivers/power/supply/mp2629_charger.c
>  F:	drivers/regulator/mp5416.c
>  F:	drivers/regulator/mpq7920.c
>  F:	drivers/regulator/mpq7920.h
> +F:	include/linux/mfd/mp2629.h
> =20
>  MR800 AVERMEDIA USB FM RADIO DRIVER
>  M:	Alexey Klimov <klimov.linux@gmail.com>
> --=20
> 2.17.1
>=20

--ukgyituuhoa7vlvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6r/bIACgkQ2O7X88g7
+ppkjQ//XkP+O6HgTkMaQkSgx1RoHuPwWdZ4LaglOVYwkcEpZ/9W530EquWaZBQO
GjSpabpSW7UINROihE8tigZtnVYRNveldTWQHJ/FN117cZYpnQ6bRsObnooxJ1Ky
w+FAOxSQAzY01zZv6hfzKTzFtdDwf5Eh54tA5xh1IhBGkvB4zu0vscWTeKwR+EHt
sjj9hb4rJxEcfy1nU2kU9yFLQK5TVqo5LpL6+uQ7V18cBDEjXEayBjzOoWsZPFNQ
4Iid5SYw5DwHyHS1w+Z8SMdSV7q17yidcNJUWK9i/BviE0iN+nOEVs0j48zBgrye
0rM4qnFAB+T75KwY6AR109oR1rrpecfScijm5tI7+SbDbdvuKyauwuNnjdRlu5A1
YZbM5aeROtkmSC6dkmqbyKnxxmvydKoG28jj3dy85EyrgIcX8T5Yk6ygcffOKBDg
pV8qRBmjmNqERXt2LPeM+ZqCsM8CZDM9s3/kmLmiaYuATK642rU5ezMPTtcmcCrS
hDo1mRbLgT76AmZD9C+XRpKUQzHlsBVJ0ZAZDJ+tRU8JpQWPgopl8zuA8fXYf0pK
sPT7Brkhm9J/wqkDQ4z5X2F3JpvRcha/OmZBx/l5V1szYxWK8zoFXESPkS5NoL5j
4U5eV0kASyXWWTQm74f+whBaxc8BhJCoeMzv6MXnUx3cHoBnnLQ=
=AnEp
-----END PGP SIGNATURE-----

--ukgyituuhoa7vlvd--
