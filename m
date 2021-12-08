Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7846CE81
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbhLHHxG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 02:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLHHxG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 02:53:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A370C061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 23:49:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1murhi-0001F5-BT; Wed, 08 Dec 2021 08:49:30 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-e45e-c028-b01c-c307.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e45e:c028:b01c:c307])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 385196BF8F9;
        Wed,  8 Dec 2021 07:49:29 +0000 (UTC)
Date:   Wed, 8 Dec 2021 08:49:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH RFC] counter: Expand API with a function for an exact
 timestamp
Message-ID: <20211208074928.oaqiazffy6htzrqg@pengutronix.de>
References: <20211207181045.1246688-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k5nwubiluno6vsc7"
Content-Disposition: inline
In-Reply-To: <20211207181045.1246688-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--k5nwubiluno6vsc7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.12.2021 19:10:45, Uwe Kleine-K=C3=B6nig wrote:
> Some hardware units capture a timestamp for the counted event. To
> increase precision add a variant of counter_push_event() that allows
> passing this timestamp.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> the difficulty is that the captured timer value is in a unit different
> from the one provided by ktime_get_ns(). So maybe some helper functions
> will be needed to convert the local timer value to a ktime timestamp?
>=20
> So usage would be something like:
>=20
> 	ktime_now =3D ktime_get_ns();
> 	local_now =3D readl(CNT);
> 	local_event =3D readl(...);
>=20
> 	ktime_event =3D ktime_now - (local_now - local_event) * somefactor >> so=
meshift;

You can use cyclecounter/timecounter for this.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--k5nwubiluno6vsc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGwY4UACgkQqclaivrt
76mp/Af8CxO4OCmjICninc5XQOHLC36IVubct0UW1OCj0pexJG6AnXfQd/GObRn6
vEwxy5AukN91x1YphWRvSdY24PnuSzjcBCYE+Ms1FPi6wMhlBs8TBL5vW05hSubs
MLowXCaW+Xvn6ktRTILyecnpigjQTf7xXKyMNEBs/48gkhJO7jw3B4hEVLR4PiCv
gAdi/tJZ7Ya0Wl58Keifss8C7fZDqDFIKXs47HBJ1IIeb/bKI9O7la8s36cavQIK
sRzRIAzmUhDaL5BoN3mVFODix3uWoqCnm8IhRU0vORN6P2XpGkps+pb/djVwBz4F
psL4KzBfyPMXIcNG1aUSIbnqqNsVrA==
=tgig
-----END PGP SIGNATURE-----

--k5nwubiluno6vsc7--
