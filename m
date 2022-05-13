Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8662D525C4D
	for <lists+linux-iio@lfdr.de>; Fri, 13 May 2022 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbiEMHYm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 May 2022 03:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352114AbiEMHYj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 May 2022 03:24:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A0D26272A
        for <linux-iio@vger.kernel.org>; Fri, 13 May 2022 00:24:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1npPf4-000623-2U; Fri, 13 May 2022 09:24:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1npPf0-0022Ne-85; Fri, 13 May 2022 09:24:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1npPey-009PQR-6n; Fri, 13 May 2022 09:24:24 +0200
Date:   Fri, 13 May 2022 09:24:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jiri Valek - 2N <valek@2n.cz>,
        Colin Ian King <colin.king@intel.com>,
        Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 0/9] iio: Remove duplicated error reporting in .remove()
Message-ID: <20220513072424.kudt3whbgpt3ryih@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
 <20220501184149.10b40610@jic23-huawei>
 <20220501185123.3ba0367b@jic23-huawei>
 <20220507153855.6174601e@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfg7dovnisu4epbn"
Content-Disposition: inline
In-Reply-To: <20220507153855.6174601e@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--hfg7dovnisu4epbn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sat, May 07, 2022 at 03:38:55PM +0100, Jonathan Cameron wrote:
> On Sun, 1 May 2022 18:51:23 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sun, 1 May 2022 18:41:49 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >=20
> > > On Sat, 30 Apr 2022 10:15:58 +0200
> > > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> > >  =20
> > > > Hello,
> > > >=20
> > > > this series adapts several i2c drivers that emit two error messages=
 if
> > > > something in their remove function fails. The relevant issue is tha=
t the
> > > > i2c core emits an error message if the remove callback returns a
> > > > non-zero value but the drivers already emit a (better) message. So
> > > > these patches change the drivers to return 0 even after an error. N=
ote
> > > > there is no further error handling in the i2c core, if a remove cal=
lback
> > > > returns an error code, the device is removed anyhow, so the only ef=
fect
> > > > of making the return value zero is that the error message is suppre=
ssed.
> > > >=20
> > > > The motivation for this series is to eventually change the prototyp=
e of
> > > > the i2c remove callback to return void. As a preparation all remove
> > > > functions should return 0 such that changing the prototype doesn't
> > > > change behaviour of individual drivers.   =20
> > >=20
> > > I think I'd rather have seen these called out as simply moving towards
> > > this second change as it feels wrong to deliberately not report an er=
ror
> > > so as to avoid repeated error messages!
> > >=20
> > > Meh, I don't care that strongly and you call out the real reason in e=
ach
> > > patch. =20
> >=20
> > Series looks fine to me, but I'll leave the on list for a few days to l=
et
> > others have time to take a look.
> >=20
> > Worth noting that some of these are crying out for use
> > of devm_add_action_or_reset() and getting rid of the remove functions
> > entirely now you've dropped the oddity of them returning non 0.
> >=20
> > Low hanging fruit for any newbies who want to do it, or maybe I will
> > if I get bored :)
>=20
> Series applied to the togreg branch of iio.git and pushed out as testing =
for
> 0-day to see if it can find anything we missed.

They are in testing
(https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=3Dtes=
ting)
but not in togreg
(https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=3Dtog=
reg).

Not sure if that is how it's supposed to be? Only togreg seems to be in
next.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hfg7dovnisu4epbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ+B6UACgkQwfwUeK3K
7AlaKggAicnzW6yDiHX/GXZEGkffdfi2YyZuKIhAnNwjDJFgyvd7e0SC1b4KXYXF
4C2ZT8V75WeOeuQcYRNpO7QiXwREqVNtYEgIyVfW8ft2lNPtu8gx1xewlws1R56p
OUnFbpECHlg9Y9dYMGwNFmjzv8w/kj2h+iDn54uXvGu/Rul5OTEyuJF2/pHrrDgT
0ppkSFUEbz1a6kjNrjjaS4I4xqPEuaMYXxFcJUPN89e6USLzE9/Jk2sN8C06HQka
FLbNtJqtHz7CqH1Bmg7ZkFX6W51V2VmrGM+Yp5w7erX/4rNDB9Q2rC/0HnMK+dIo
tAqA/xUza4xirZnjklreoPqFKhqchQ==
=FAbd
-----END PGP SIGNATURE-----

--hfg7dovnisu4epbn--
