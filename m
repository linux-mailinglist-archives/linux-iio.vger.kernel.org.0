Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5484747F448
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhLYTHF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 14:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhLYTHF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 14:07:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A22C061401
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 11:07:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1CNh-0002HF-K0; Sat, 25 Dec 2021 20:07:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1CNf-006bir-0t; Sat, 25 Dec 2021 20:06:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1CNd-00009c-HE; Sat, 25 Dec 2021 20:06:57 +0100
Date:   Sat, 25 Dec 2021 20:06:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v1 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211225190654.btegjjkynzyikpqr@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
 <20211225161056.682797-14-u.kleine-koenig@pengutronix.de>
 <20211225163451.iwwn7u7bku4r4nk4@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qlts5rp2zfs4hfyk"
Content-Disposition: inline
In-Reply-To: <20211225163451.iwwn7u7bku4r4nk4@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--qlts5rp2zfs4hfyk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 25, 2021 at 05:34:51PM +0100, Marc Kleine-Budde wrote:
> On 25.12.2021 17:10:46, Uwe Kleine-K=F6nig wrote:
> > The current implementation gets device lifetime tracking wrong. The
> > problem is that allocation of struct counter_device is controlled by the
> > individual drivers but this structure contains a struct device that
> > might have to live longer than a driver is bound. As a result a command
> > sequence like:
> >=20
> > 	{ sleep 5; echo bang; } > /dev/counter0 &
> > 	sleep 1;
> > 	echo 40000000.timer:counter > /sys/bus/platform/drivers/stm32-timer-co=
unter/unbind
> >=20
> > can keep a reference to the struct device and unbinding results in
> > freeing the memory occupied by this device resulting in an oops.
> >=20
> > This commit provides two new functions (plus some helpers):
> >  - counter_alloc() to allocate a struct counter_device that is
> >    automatically freed once the embedded struct device is released
> >  - counter_add() to register such a device.
> >=20
> > Note that this commit doesn't fix any issues, all drivers have to be
> > converted to these new functions to correct the lifetime problems.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/counter/counter-core.c | 149 ++++++++++++++++++++++++++++++++-
> >  include/linux/counter.h        |  15 ++++
> >  2 files changed, 163 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > index 00c41f28c101..17a93e6c018a 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/kdev_t.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/wait.h>
> > =20
> > @@ -24,6 +25,11 @@
> >  /* Provides a unique ID for each counter device */
> >  static DEFINE_IDA(counter_ida);
> > =20
> > +struct counter_device_allochelper {
> > +	struct counter_device counter;
> > +	unsigned long privdata[0];
> > +};
>=20
> Is this a use case for DECLARE_FLEX_ARRAY()?

Probably I want to drop the 0 to make this c99 instead of c89 gcc
extention. I didn't know DECLARE_FLEX_ARRAY, not sure if this is more
beneficial.

Anyhow, having said that, the loop hooping with struct
counter_device_allochelper can maybe be replaced by some addition and
pointer alignment. At least that's how it's done in netdev_priv().

I'm open to whatever William and/or Greg prefers.

One thing we/they might want to decide quickly is if the fixes included
here should go into v5.16. Maybe it's too late in the cycle and given
the problem isn't actually new, maybe fix this for v5.17? (It's as old
as the counter framework which was included first in v5.2-rc1 in Apr
2019.) Iff this is considered important enough to go into 5.16, maybe we
should discuss privdata[0] vs privdata[] vs DECLARE_FLEX_ARRAY only
later?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qlts5rp2zfs4hfyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHa8sACgkQwfwUeK3K
7AnTAAf/b13CmmKGa3MqBdHjwt5g/kpe6oIf2sQzVd4icPwYVZ6j2Bk/iS15FUfZ
E9RwB98//UC+yIJ0gZkXyREAMlq0I2XVdNhu0XqNtXwywtM9tUXXbyA+GVPRqJfO
WbzcBssCyl5syJ9yoVFIvC7gna+86WIimqctfxz5yNjh+KO/LF5Ouz6JeojeQig/
M0RSSyolBkeUz3g9LjBfvBJW7r2YD1VFtxp95n+iu1BGVBhqvemu9KGBLCEQCZ2n
VW5a4UIz0muDFJqrvpm+ZPxQACzuMAu9DaFvD7LusKZdI2MgqVpTPlPrUh7o0Dpp
5tyRRYoxd4bM7wjhh/s+C4ymxRm0qA==
=WlHE
-----END PGP SIGNATURE-----

--qlts5rp2zfs4hfyk--
