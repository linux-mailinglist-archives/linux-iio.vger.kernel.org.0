Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D25FC232
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKNJIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 04:08:34 -0500
Received: from sauhun.de ([88.99.104.3]:39080 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfKNJId (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:33 -0500
Received: from localhost (p54B33777.dip0.t-ipconnect.de [84.179.55.119])
        by pokefinder.org (Postfix) with ESMTPSA id 398D02C03EE;
        Thu, 14 Nov 2019 10:08:31 +0100 (CET)
Date:   Thu, 14 Nov 2019 10:08:30 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: max9611: Fix too short conversion time delay
Message-ID: <20191114090830.GA3252@ninjato>
References: <20191113092133.23723-1-geert+renesas@glider.be>
 <20191113180057.GA2764@ninjato>
 <CAMuHMdWp8Sjkz7oOa6cHOQcHP5cwHMQcp_4aNA=HssBjrtGZQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWp8Sjkz7oOa6cHOQcHP5cwHMQcp_4aNA=HssBjrtGZQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> That sounds a bit excessive to me.
> According to my measurements, it's 1.8 ms.
>=20
> =3D> 3 ms?

[Quoting "Life of Brian"]

HARRY THE HAGGLER: This bloke won't haggle.
BURT: Won't haggle?!

OK :)

> s/Analog/Maxim/?

Uhh, yes. Wishful thinking...

Kind regards,

   Wolfram


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3NGYkACgkQFA3kzBSg
KbYjrA//VCEdcQU+Lu2TzeJiCr8UuNOQ4zrMyPX4myboxYRa7UthI9cZcFQSmNUH
Rx+ikNj8hJwupWpUm4TcznoxTxO8wPmhrdoTI1bC/F8nhgKMeTrzZXVUNS4ugp/9
nbjUNM5BzB9bYOA9qiw+CQIz8fCQb0t4OjPMAZUNkDqeU9yqk+YronLeO87m6vIa
0+fsp7Tj3OT6fpN7x8/p9uuhygitS7+IAyA0PRpirzYzRWjiXvt07VWaRn3BiBID
f16BFNoerawhOAlcpm5P16j4wENJdgF34l2nW719nTtJ+MVVuYNvZ9qiIDkoAa8P
pZnmJJaAoBIYAgZRM7Slw5ntN8btsiNXnmYOqTRUAtGnzvBkTj6N56l/NnZcYLbl
qF+y1bZzBEPn/99wDNwUFpki0dvyQ6gZWdC8pyABCHAeH/Lg1+yUKz7zWKNBqOew
eJuIav3HPm35exUm+21t+m2PxaP6dy+YWPfiXRsXAqby+RX9KDzL+xcBGoPTlFrO
Bs+Jl9a7TF0wCnP6ubCUF+5gQ82qCUu91JBVzDE5cEcG7Va7KqQWWzcbOf4ovBwj
pIaRSVZsMEAHySzSYLfVP4A4HqZZmhV3wSFLgFvF4yVJZbbVSrR3Gqb8bwFzLW6L
xA/WXaAfkJfieYkoYgLKs/KA5VQWRyQbdfYTn8Xrj9hzVifx6lc=
=wzVI
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
