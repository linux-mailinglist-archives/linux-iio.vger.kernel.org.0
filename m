Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7535C61546E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Nov 2022 22:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKAVuB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Nov 2022 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiKAVuA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2022 17:50:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827DC2736
        for <linux-iio@vger.kernel.org>; Tue,  1 Nov 2022 14:49:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1opz8o-0006Mo-E0; Tue, 01 Nov 2022 22:49:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1opz8i-001kZp-S2; Tue, 01 Nov 2022 22:49:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1opz8h-00DlzT-9I; Tue, 01 Nov 2022 22:49:43 +0100
Date:   Tue, 1 Nov 2022 22:49:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <20221101214939.seiuaj7un4cbcbpn@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
 <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
 <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
 <20221031233843.4rbcfs3hstlkv7il@pengutronix.de>
 <Y2EzPJvntyGbSKW8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbfgzihsdln5ld7f"
Content-Disposition: inline
In-Reply-To: <Y2EzPJvntyGbSKW8@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zbfgzihsdln5ld7f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Nov 01, 2022 at 04:54:52PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 01, 2022 at 12:38:43AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Oct 24, 2022 at 12:46:02PM +0300, Andy Shevchenko wrote:
> > > On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > > Exactly. And it means let's put my problem to someone's else shoulder=
s.
> >=20
> > You have a problem that I fail to see. Why is defining the id table
> > before the probe function bad?
> >=20
> > Unless I misunderstand you, you seem to assume that in the nearer future
> > someone will have the urge to put the id table below the probe function
> > again. What would you think is their motivation?
>=20
> The problem with moving the table is the sparse locations in the code for
> semantically relative things, like all ID tables to be near to each other.

I don't understand that reasoning. Is that important for the compiler or
the human reader? What is "semantically relative"?

> With
> your approach you can easily break that and go for let's put one ID table=
 on
> top, because some code fails to indirectly access it, and leave another
> somewhere else. I do not like this.
>=20
> Besides, your change making unneeded churn of "I like to move it, move it=
" for
> no real gain.

That's not true. It's not that I like to move it. Moving is necessary to
make use of the local symbol in .probe() without a forward declaration.
(If you claimed that adding a forward declaration was churn, I'd agree.)
=20
> ...
>=20
> > > I don't see benefit of dereferencing tables by name. The table has to=
 be
> > > available via struct driver, otherwise, how the heck we even got into=
 the
> > > ->probe() there.
> >=20
> > It is possible, it's just cheaper (in cpu cycles) to calculate the
> > address of the table directly (i.e. via PC + $offset) instead of via
> > dereferencing two pointers.
>=20
> It's a slow path.

Somewhat agreed. It influences boot time though. (Well I guess, maybe
it's too little to be actually measureable for a single driver? Still in
my bubble people are sensitive to boot time and I'd consider this a low
hanging fruit for (admittedly small) optimisation.)

> ...
>=20
> > I fail to follow you again. I talked about drivers/rtc/rtc-isl1208.c as
> > it is in v6.1-rc1. There the probe function doesn't access the table at
> > all. Neither via the driver link nor by name. That driver just defines
> > the id table before the probe function.
>=20
> So, if it is on top, fine, it would be just an inconsistent style.
>=20
> ...
>=20
> > > Alternative is to avoid reordering to begin with, no?
> >=20
> > Yeah, that could be done. But I don't see the advantage and you fail to
> > explain it in a way for me to understand.
> >=20
> > So if i2c_match_id() was changed as follows:
>=20
> There is another approach in the discussion and Wolfram acknowledged it a=
lready
> (with a new API to retrieve the necessary data).

Yeah, saw it. And as expected the follow up patch converting
drivers/iio/pressure/bmp280-i2c.c "suffers" from the double pointer
dereference. But it looks nice because the effort to determine the table
via driver is well hidden.

> ...
>=20
> > +static const struct i2c_device_id kxcjk1013_id[] =3D {
> > +	{"kxcjk1013", KXCJK1013},
> > +	{"kxcj91008", KXCJ91008},
> > +	{"kxtj21009", KXTJ21009},
> > +	{"kxtf9",     KXTF9},
> > +	{"kx023-1025", KX0231025},
> > +	{"SMO8500",   KXCJ91008},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > +
> >  static int kxcjk1013_probe(struct i2c_client *client)
> >  {
> > -	const struct i2c_device_id *id =3D i2c_match_id(NULL, client);
> > +	const struct i2c_device_id *id =3D i2c_match_id(kxcjk1013_id, client);
> >  	struct kxcjk1013_data *data;
> >  	struct iio_dev *indio_dev;
> >  	struct kxcjk_1013_platform_data *pdata;
> > @@ -1720,18 +1731,6 @@ static const struct acpi_device_id kx_acpi_match=
[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
> > =20
> > -static const struct i2c_device_id kxcjk1013_id[] =3D {
> > -	{"kxcjk1013", KXCJK1013},
> > -	{"kxcj91008", KXCJ91008},
> > -	{"kxtj21009", KXTJ21009},
> > -	{"kxtf9",     KXTF9},
> > -	{"kx023-1025", KX0231025},
> > -	{"SMO8500",   KXCJ91008},
> > -	{}
> > -};
> > -
> > -MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
>=20
> Can we avoid moving it?

Yes, but the alternatives are not better in my eyes. (You could use
i2c_client_get_device_id() or add a forward declaration.) And moving it
is easy enough and I still don't understand the downsides you care
about.
=20
> >  static const struct of_device_id kxcjk1013_of_match[] =3D {
> >  	{ .compatible =3D "kionix,kxcjk1013", },
> >  	{ .compatible =3D "kionix,kxcj91008", },
> >=20
> > on top to safe two pointer dereferences. The sum of the two driver
> > patches is exactly the effect of my patch just without the i2c core
> > change. (And the two pointer dereferences that are saved by the 2nd
> > patch are introduced by the first, so it's fine to not split that
> > change into two parts.)
>=20
> ...
>=20
> > > So, why not teach i2c_match_id() to handle this nicely for the caller?
> >=20
> > The metric for "nice" is obviously subjective. For me it's nice to pass
> > a local symbol to an API function to make the function's job a tad
> > easier and more effective to solve. And that even if I have to reorder
> > the caller a bit.
>=20
> So, it seems a preferred design paradigm: straightforward vs. OOP.
> Kernel is written with OOP in mind, why to avoid that?
>=20
> ...
>=20
> > > reduce churn with the using of current i2c_match_id() as you
> > > showed the long line to get that table.
> >=20
> > Do you still remember the original patch? That one doesn't have the long
> > i2c_match_id() line.
> >=20
> > (Do you see your statement is an argument for my approach? The long line
> > is an indication that it's complicated to determine the address of the
> > table via ->driver. You can hide that by pushing the needed effort into
> > i2c_match_id() or a macro, but in the end the complexity remains for the
> > CPU.)
>=20
> Does it matter?

What is "it"? The long line? (Then no, it doesn't matter because it
doesn't appear in neither your nor my approach.) The effort to pull the
table's address out of ->driver? (We seem to disagree. I think it's easy
enough not to do it to justify the optimisation.) Or to hide the effort?
(I think hiding effort and so making it easy to pick a more expensive
approach is at least questionable.)
=20
> OTOH that will be aligned with SPI framework and idea behind ->probe_new()
> as I understood it.
>=20
> ...
>=20
> > > This might need a new API to avoid
> > > changing many drivers at once. But it's business as usual.
> >=20
> > My approach doesn't need a new API. That's nice, isn't it?
>=20
> It depends. In this case it's not nice since it requires
> "I like to move it, move it".

I still don't get your reasoning and I think we have to agree to not
agree. IMHO the judgement is subjective, you call the move of the id
table "churn" and I call it "tiny effort for a little optimisation".

What I consider "churn" though is this discussion. I will stop my
participation here. That's a bit sad because in my eyes all patches in
this series have a positive value and the discussion about (from my POV)
incomprehensible minor details destroyed my motivation to work on the
quest to convert all drivers to .probe_new() :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zbfgzihsdln5ld7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNhlHAACgkQwfwUeK3K
7AlHGQf9G6iYMg25jlL42VAdBc0DRFWC8Dr+yU1YrsvO+tDGACi1iDyUNVbZWwqS
0mXbAtZx7Ac5F7T8pKbAwvxy3RBD+yt8IPwXpvHBeZbXfJAOVbMlhR9sdjjjfAZ8
cbQv3riiSEmlsCd5BKeM9Iba0Y1upQ3Y2xJmJAkS2oiAV22WzWdCWQoux4iWQVSA
3nW+C8dV22lHAu5gUcY7xjKSqhf0Ww0n/Gj4OVYRJwh5rANY4hNSBHxTiBqSuqTi
54k/8c3hzJ5oZeyxtCelC5vTZAeHJ3jaPa6vMsCFWq5XDnY3bzi6deHeOwZiO2Vs
12FKicuK+nASEk9SELON4fzUozPpDA==
=1mj1
-----END PGP SIGNATURE-----

--zbfgzihsdln5ld7f--
