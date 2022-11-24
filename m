Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D200B6380B6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Nov 2022 22:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKXVpZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 16:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXVpY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 16:45:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA2270A37;
        Thu, 24 Nov 2022 13:45:23 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C66DA6602B47;
        Thu, 24 Nov 2022 21:45:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669326321;
        bh=rqgJu1oO5oPP9Saq2aP3EVhh6iBrbYAer2nSFnD1yFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5ZL3gYpW2AaVUC9FX721XxDdtAa9Yi3jDn1mUPG9a6c2Pm3+xdBt69RkJZMJ/nWg
         7xdSGxDDZpe/GJUMkyFzgmohlKDeJFci3AWoNtHo3vSC0VoU/Mkvx5I6lzlUFyVStc
         8pmce4XqFjy/+rjylV6xJWmP/OFZVMJ+3jmY4PcBbdt+F3h2Ufgp6w3llTppYJzJyJ
         RBdf2KeP4IjcmIt2kA7vOlFv4z12KgpjbUvZOvbrxvpvinKIkC6yLg0HgJy161BZSI
         Rj2LP6fiaWui7+m1kATl58M3KRYPgK90RfHC6/5uGtWQbLfxfbGv21gk6tpXonn7Qc
         H7TSdWkpwgSPQ==
Received: by mercury (Postfix, from userid 1000)
        id 3713C106092D; Thu, 24 Nov 2022 22:45:19 +0100 (CET)
Date:   Thu, 24 Nov 2022 22:45:19 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 2/7] power: supply: fix wrong interpretation of
 register value
Message-ID: <20221124214519.nqpeuvu62k7eh7ix@mercury.elektranox.org>
References: <20221123175425.564042-1-sravanhome@gmail.com>
 <20221123175425.564042-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xp3w4xuc3bonw7au"
Content-Disposition: inline
In-Reply-To: <20221123175425.564042-3-sravanhome@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--xp3w4xuc3bonw7au
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 23, 2022 at 06:54:20PM +0100, Saravanan Sekar wrote:
> Fix the switch cases to match the register value.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/mp2629_charger.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply=
/mp2629_charger.c
> index bf9c27b463a8..46d620bd23b9 100644
> --- a/drivers/power/supply/mp2629_charger.c
> +++ b/drivers/power/supply/mp2629_charger.c
> @@ -284,10 +284,10 @@ static int mp2629_charger_battery_get_prop(struct p=
ower_supply *psy,
>  			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
>  			break;
>  		case 0x01:
> -		case 0x10:
> +		case 0x02:
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  			break;
> -		case 0x11:
> +		case 0x03:
>  			val->intval =3D POWER_SUPPLY_STATUS_FULL;
>  		}
>  		break;
> @@ -305,7 +305,7 @@ static int mp2629_charger_battery_get_prop(struct pow=
er_supply *psy,
>  		case 0x01:
>  			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
>  			break;
> -		case 0x10:
> +		case 0x02:
>  			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
>  			break;
>  		default:
> --=20
> 2.34.1
>=20

--xp3w4xuc3bonw7au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmN/5eoACgkQ2O7X88g7
+prFExAAggQla4auvPk4vg3Q5ROt9eHIzhS5N9Rqeg50InU+1TLxSLAtO3pbf1cw
9hnpCl5WS52qCkZ5thdM9eH7dwL7+xJJoZZn9J2yEsFLR3I+n3Fws6y98ZQe8Qgj
XxGVda9Jx/tb/7UWSSZEhoeSYItBdghG4sqFgm7Cw4vPLzAL6qQfBMKVmignLjl/
I0qGwV9mHxAPuQQDjX2fEftIEK3qLMzab5j0N4qW8rZiNavvKhdlSM+pmvFk2MDe
jsHtaE6WcwTVV/+JMUQb65kr8v2j68OP1t+5DbhJDJ1U2LRawEk4MI9dNZjiXQpL
X9eRzC4ndxGDDAyqcqY4tI5hjOUVdPeAkJaVB6xk+DMR9tWd1ew0fRLYZ/3HI3Bi
oJe88c9xSpppoEbuY5MmAsPskwmVhwpsT9laAZPZg2xxNN7NAqCsiYZ11dyltCmL
+g+HHKO9Wds9Crkgmyjh8i26QCcCDlLqQqCvrGoVtqTriLr8q2uQTFO86hTiYKbT
LgdAfZMbvK0O9HnyBTHgdxYriN1cmS7GmZM0IvWqwYAfYQBGmwUO4WH7QHVqC9Rn
fVnMR7UkrX4OhAWXBx2B2WmnxZcLDbWJITvpeTNyLMepCFAQixQcoKStYrZKxJdN
Y3mhw+NxglEhpqbh3CQdFi+Xg9kY5T4G6wq8c3/g29P6BvowpzI=
=q1yh
-----END PGP SIGNATURE-----

--xp3w4xuc3bonw7au--
