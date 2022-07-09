Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85156CACF
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jul 2022 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGIRKa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jul 2022 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGIRK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jul 2022 13:10:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F9120A7
        for <linux-iio@vger.kernel.org>; Sat,  9 Jul 2022 10:10:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oADyE-0007mH-Fc; Sat, 09 Jul 2022 19:10:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oADy9-005TVx-Al; Sat, 09 Jul 2022 19:10:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oADyC-0049en-6w; Sat, 09 Jul 2022 19:10:16 +0200
Date:   Sat, 9 Jul 2022 19:10:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        kernel@pengutronix.de
Subject: Re: ti-ads7950: selecting the adc input range
Message-ID: <20220709171013.eol6fpv5imtijgsn@pengutronix.de>
References: <20220708080257.y6wn7pztylujepyr@pengutronix.de>
 <441bfa83-4014-fed9-3527-7db34df7da3a@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxowx6pswlqfbplq"
Content-Disposition: inline
In-Reply-To: <441bfa83-4014-fed9-3527-7db34df7da3a@metafoo.de>
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


--uxowx6pswlqfbplq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 08, 2022 at 11:28:35AM +0200, Lars-Peter Clausen wrote:
> On 7/8/22 10:02, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > the ADS7950 has a register bit (called TI_ADS7950_CR_RANGE_5V in the
> > driver) that selects the input range. Depending on that bit the input
> > range is either [0 .. V_{REF}] or [0 .. 2 * V_{REF}].
> >=20
> > The driver currently defaults to setting that bit, so the range is the
> > big one.
> >=20
> > On a machine here however I know the input is in the smaller range and
> > I'd like to benefit from the higher resolution of the small range. I
> > wonder how to make this tunable. Should that be done using a firmware
> > property? ("single-input-range" vs. "double-input-range"? Or input-range
> > =3D <1> vs. input-range =3D <2> which better matches the data sheet that
> > calls the two modes "Range 1 (0 to V_{REF})" and "Range 2 (0 to
> > 2xV_{REF})") Or should this be made tunable via sysfs? (E.g. by writing
> > to the scale property? Or a separate property?)
>=20
> Its a bit of a tricky one. You can find arguments for and against either.
> Like "devicetree is for hardware description and not application specific
> configuration data", or "I know which setting I want to use, having the
> kernel apply it makes it a lot easier".

The latter is usually not a good reason that the dt people would accept
:-)

> What we've done in the past in the IIO framework is to make the scale
> property writable for such devices. Together with a scale_available prope=
rty
> to list valid options. This is the most flexible option as it allows to
> change the setting at runtime for applications where it is required.

Which driver would you recommend me to study for that approach?

> Maybe the right solution is a mix of both, have the property writable by
> default, but allow firmware to restrict the available options based on wh=
at
> the system designer though makes sense. E.g. on some boards having the
> ability to switch at runtime makes sense, on others it does not.

I can imagine that the board designer says: The input range is 0..5V, so
better don't restrict the range to 0..2.5V. And I'd expect the dt people
to accept such a binding. Unfortunately for me that's the wrong
direction :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uxowx6pswlqfbplq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLJtnIACgkQwfwUeK3K
7Amtbgf9EaNlc5TpWVViU0VxN6ox2NWDsAAW8OAn+jLtwmp0pLlqMxR9Db+s2a9a
jU2zLhk4CuUrKag39zn7hHrFb+g4Go7ZaBo2r1dr3Ek2fmRnBjuJe5yJbnl+e4mc
L9rQzy6qTU61fsZhZMAigC5+1Dswj938WEi9gPRQ8tKISJN46cvsJ/hSJwcQFe5/
gQhOClKQho3M7ifknhO+PFyNcgUDVLvkqal1SkeweDrxw1aNcfmkASS5C9m6hY82
7jrzKJ/hdutPbO0t4r1mf1yQp720nkzfNtD8ABcrFw12MfnpaFLgsU0kKTLUeiD4
KtNjG/gOiyaDUIEmwsw+83IdoRC2xw==
=Cb7e
-----END PGP SIGNATURE-----

--uxowx6pswlqfbplq--
