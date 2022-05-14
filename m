Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14266527160
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiENNmS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 09:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiENNmR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 09:42:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA631CFC3
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 06:42:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nps26-0005vU-3O; Sat, 14 May 2022 15:42:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nps20-002Hu8-C1; Sat, 14 May 2022 15:42:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nps1y-009fx1-7P; Sat, 14 May 2022 15:42:02 +0200
Date:   Sat, 14 May 2022 15:41:59 +0200
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
Message-ID: <20220514134159.snmis45rx6qotppe@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
 <20220501184149.10b40610@jic23-huawei>
 <20220501185123.3ba0367b@jic23-huawei>
 <20220507153855.6174601e@jic23-huawei>
 <20220513072424.kudt3whbgpt3ryih@pengutronix.de>
 <20220514143151.52f514a0@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tga7digetcmvt7co"
Content-Disposition: inline
In-Reply-To: <20220514143151.52f514a0@jic23-huawei>
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


--tga7digetcmvt7co
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sat, May 14, 2022 at 02:31:51PM +0100, Jonathan Cameron wrote:
> On Fri, 13 May 2022 09:24:24 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> > On Sat, May 07, 2022 at 03:38:55PM +0100, Jonathan Cameron wrote:
> > > On Sun, 1 May 2022 18:51:23 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >  =20
> > > > On Sun, 1 May 2022 18:41:49 +0100
> > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > >  =20
> > > > > On Sat, 30 Apr 2022 10:15:58 +0200
> > > > > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> > > > >    =20
> > > > > > Hello,
> > > > > >=20
> > > > > > this series adapts several i2c drivers that emit two error mess=
ages if
> > > > > > something in their remove function fails. The relevant issue is=
 that the
> > > > > > i2c core emits an error message if the remove callback returns a
> > > > > > non-zero value but the drivers already emit a (better) message.=
 So
> > > > > > these patches change the drivers to return 0 even after an erro=
r. Note
> > > > > > there is no further error handling in the i2c core, if a remove=
 callback
> > > > > > returns an error code, the device is removed anyhow, so the onl=
y effect
> > > > > > of making the return value zero is that the error message is su=
ppressed.
> > > > > >=20
> > > > > > The motivation for this series is to eventually change the prot=
otype of
> > > > > > the i2c remove callback to return void. As a preparation all re=
move
> > > > > > functions should return 0 such that changing the prototype does=
n't
> > > > > > change behaviour of individual drivers.     =20
> > > > >=20
> > > > > I think I'd rather have seen these called out as simply moving to=
wards
> > > > > this second change as it feels wrong to deliberately not report a=
n error
> > > > > so as to avoid repeated error messages!
> > > > >=20
> > > > > Meh, I don't care that strongly and you call out the real reason =
in each
> > > > > patch.   =20
> > > >=20
> > > > Series looks fine to me, but I'll leave the on list for a few days =
to let
> > > > others have time to take a look.
> > > >=20
> > > > Worth noting that some of these are crying out for use
> > > > of devm_add_action_or_reset() and getting rid of the remove functio=
ns
> > > > entirely now you've dropped the oddity of them returning non 0.
> > > >=20
> > > > Low hanging fruit for any newbies who want to do it, or maybe I will
> > > > if I get bored :) =20
> > >=20
> > > Series applied to the togreg branch of iio.git and pushed out as test=
ing for
> > > 0-day to see if it can find anything we missed. =20
> >=20
> > They are in testing
> > (https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=
=3Dtesting)
> > but not in togreg
> > (https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=
=3Dtogreg).
> >=20
> > Not sure if that is how it's supposed to be? Only togreg seems to be in
> > next.
> Yup. That's intentional because I don't rebase the togreg branch unless
> something goes wrong when it hits next.  The intent being it's a stable
> base to build upon.  Normally there is a delay of up to a week to let
> 0-day take a look at testing and for me to happen to get time sat at
> the right computer, but sometimes it's longer :(
>=20
> Right now I'm waiting on a pull request being picked up by Greg KH,
> after which I'll fast forward the togreg branch as I have some patches
> waiting to be queued up that are dependent on things that have reached
> char-misc-next via other paths.

Not sure I understood that correctly. Do you let Greg pull the togreg
branch? If you instead let him pull tags, you don't have to wait in such
a situation to apply new patches to a for-next branch. (Or just don't
use "togreg" for both, sending PRs to Greg and put patches into next.)

> Unfortunately I'm doubtful about whether I can squeeze in a second
> pull request this cycle, so they may get queued up for next cycle.
> A bit of bad timing :(

It's not a big problem for me. There is still much to do (also a bit in
drivers/iio) before I tackle the final bits of my quest and actually
change struct i2c_driver (and so depend on these patches having hit
mainline). The only downside for you is, that you might have to endure
me asking again for the state of these patches ;-)

Thanks for your feedback. Compared to pinging repeatedly and getting no
maintainer reply, knowing about your problems is much appreciated.

Best regards and have a nice week-end,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tga7digetcmvt7co
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ/saQACgkQwfwUeK3K
7AngyQf/RtE+tzerDDaV3mUrXDZiterhrIxztrfIlYv55zdtTgIaBMGN0DAmTNIg
WdcEvcpYuwA4Lnt9fNXKEKXBREJBl6zBL7lCYkOouTLbwr+RFzGVPAJo1Sgq3a0I
V1cAy8OIh5WvEI6ZF/dJ8iLhmGRa/T9zM3jYa7WEHLuj7X6Bp/ShgfS5l0o/7Jcr
zkml7WeQTJ/bUuU7IUvT1pLsCA/RPwZGRufDLQrCpyogRgyT7fAhgrVGxScb+C+K
Fz47NMlCgzteDh6GrGB2gNQmptnHRGRO67jYvH7u5N52FSap2MW2vyUC3FIq4cB2
wQDHDytqlhFRIOJKCtPowukNUqMyUA==
=1r7G
-----END PGP SIGNATURE-----

--tga7digetcmvt7co--
