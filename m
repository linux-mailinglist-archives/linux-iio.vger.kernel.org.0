Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E915926A5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 23:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiHNVbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHNVbW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 17:31:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54682AE62
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 14:31:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oNLCR-00084x-DK; Sun, 14 Aug 2022 23:31:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oNLCG-003nIf-Fx; Sun, 14 Aug 2022 23:31:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oNLCH-00Bj82-Pv; Sun, 14 Aug 2022 23:31:01 +0200
Date:   Sun, 14 Aug 2022 23:30:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>, Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>,
        David Wu <david.wu@rock-chips.com>
Subject: Re: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20220814213058.dgoxpkoxpn6s4ojj@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
 <20220808204740.307667-6-u.kleine-koenig@pengutronix.de>
 <20220813173142.76774c97@jic23-huawei>
 <CAHp75VeUV2+-V=TbQwx4Chr-xWU4AmRq-mG8Z8XTkwQmx4qvhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7jljjxpofabkyuz"
Content-Disposition: inline
In-Reply-To: <CAHp75VeUV2+-V=TbQwx4Chr-xWU4AmRq-mG8Z8XTkwQmx4qvhQ@mail.gmail.com>
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


--y7jljjxpofabkyuz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Tomislav Denis from Cc: as the address bounces]

On Sun, Aug 14, 2022 at 10:01:08PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 13, 2022 at 7:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon,  8 Aug 2022 22:47:33 +0200
> > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> >
> > > Make use of devm_clk_get_enabled() to replace some code that effectiv=
ely
> > > open codes this new function.
> > >
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >
> > This might have side effects as it now enables the clock before calling
> > the clk_set_rate(). Also changes the clock start up ordering. Neither i=
s that
> > scary a change, but on really fussy hardware they might cause problems.
> >
> > Add a few rock-chips people who have sent patches in last few years
> > to hopefully take a look or even better run a test.
>=20
> I believe you found a bug in the patch. The possible solutions are:
> - not take the patch
> - disable and re-enable clock around clk_set_rate()
>=20
> IIRC clk_set_rate() will spit a WARN if clock is enabled.

You mean in general? I think that's wrong. There might be some clks that
do that, but I'd consider them strange. If you ask me, calling
clk_set_rate() for a *disabled* clk is the strange concept ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y7jljjxpofabkyuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL5aY8ACgkQwfwUeK3K
7AmFEwf/UG13FWzn4gKvPGKyJXSAqH8dvwsZoV0JEuifnyi06bdTBxv/8kG6mV+/
5BBteYH7Dxocaq2G/CXI7/rhd6x+OKYqzai6IVYeUqIFG1ZNrUhRBFAxb4uJ2mlz
Qw8Q2vjbocW8uQMTHt28jF0Spo5B1UqeQncxGYkHsTr343+sRb3g0xZt99ClzDxC
IpvPp2iIZGjsIZvHnZZ/Z7NY6aj6it2mc85w1QvuOoragniqpkVD4kM+7Uomjs8N
d5kNvQj0lSQbJq78CVBSenGXESsYPYcrsUr/7KG6asGfGKpMYo2LHgYTMJrqQrtd
dVoPaIRXZ4H7EvI6gBpO9XG2Z5pxZQ==
=fNPX
-----END PGP SIGNATURE-----

--y7jljjxpofabkyuz--
