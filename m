Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4F609DAE
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJXJPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiJXJP3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 05:15:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACBE48A12
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 02:15:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omtXx-00045X-54; Mon, 24 Oct 2022 11:15:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omtXu-0005KJ-C0; Mon, 24 Oct 2022 11:14:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omtXs-00AGEX-Jg; Mon, 24 Oct 2022 11:14:56 +0200
Date:   Mon, 24 Oct 2022 11:14:56 +0200
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
Message-ID: <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnthco5xguhfwvza"
Content-Disposition: inline
In-Reply-To: <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
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


--vnthco5xguhfwvza
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Oct 24, 2022 at 11:39:51AM +0300, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 09:05:18AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Sun, Oct 23, 2022 at 10:06:11PM +0300, Andy Shevchenko wrote:
> > > On Sun, Oct 23, 2022 at 03:22:49PM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > > > +static const struct i2c_device_id kxcjk1013_id[] =3D {
> > > > +	{"kxcjk1013", KXCJK1013},
> > > > +	{"kxcj91008", KXCJ91008},
> > > > +	{"kxtj21009", KXTJ21009},
> > > > +	{"kxtf9",     KXTF9},
> > > > +	{"kx023-1025", KX0231025},
> > > > +	{"SMO8500",   KXCJ91008},
> > > > +	{}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > >=20
> > > I don't like this part. Can we, please, find a way how to dereference=
 this
> > > table via struct i2c_client, please?
> >=20
> > It would be possible to do (on top of my patch here as PoC):
> >=20
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1=
013.c
> > index e043dd698747..00269b25af99 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1445,7 +1445,7 @@ MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > =20
> >  static int kxcjk1013_probe(struct i2c_client *client)
> >  {
> > -	const struct i2c_device_id *id =3D i2c_match_id(kxcjk1013_id, client);
> > +	const struct i2c_device_id *id =3D i2c_match_id(to_i2c_driver(client-=
>dev.driver)->id_table, client);
> >  	struct kxcjk1013_data *data;
> >  	struct iio_dev *indio_dev;
> >  	struct kxcjk_1013_platform_data *pdata;
> >=20
> > (only compile tested), you could even create a function or macro to make
> > this a bit prettier on the source level. For the compiler loading the
> > address from a local symbol instead of from two pointer dereferences is
> > (I guess) a bit more effective and IMHO more natural.
> >=20
> > *shrug*, I don't care much, but I don't like to have to rework this
> > series just because you don't like this part. You even didn't give a
> > rationale, I can imagine several different ones:
>=20
> And I don't want to have ping-ponging the pieces of code (ID tables) beca=
use
> some API has to be fixes or so.

In this series it's only ping without pong. To benefit from the local
table instead of fishing the table out of client, the table must be
declared already when it's used.

> >  [ ] it makes the patch bigger
> >  [ ] it results in an unnatural order of symbols in the driver
> >  [ ] it's some kind of duplication
> >  [ ] something else
> >      please elaborate: ________________________________
>=20
> It adds a burden to the future work with no good justification along with

This burden exists in the drivers that already today have the table
above the probe function? (Ok, there are none in this series, but it
happens, see for example

	https://lore.kernel.org/linux-rtc/20221021130706.178687-4-u.kleine-koenig@=
pengutronix.de

and a few more in the rtc series.) I don't see a burden here, we're
talking about the id table being defined before the probe function, right?
How is that a burden? What am I missing?

> a churn in _this_ series.

The alternatives are: Split the patch into reorder + convert to
=2Eprobe_new, or add a declaration for the id table. Among these I like
the current approach best.

> While I like the rest of the series, these things I would rather postpone
> or rework.

There is no win in postponing, is there?[1] What would be your preferred
way to rework?

Best regards
Uwe

[1] .probe_new was created in 2016!

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vnthco5xguhfwvza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNWV40ACgkQwfwUeK3K
7AlnJwf+JQeAKsZ2Mr6pelT8YgtlvA+3TjC0J3e2ctlB50sexzbeGVoUlzQfgNP+
nz6BFokjy84BFJzhPw9WfDOtia93ZIdfC9VTvsyGZYh1ai7h94pCyhR4X+UH52af
ys/Aljc9s1kkcjml5iZM32WS1C99LJZxvLCgwJey66nU54fLKAjCRE+5QTboOzFz
1xvQvvucyZ2VcEg85/AXJcjqqUK9Ox+mXWcCHZSb2cvHfuG0/IxMzQxElyrvAUHU
chmm0GEdGC8uI8nava7tH5Ey1efTKt0gkFdGywdYoomkOfrhazggttNz1UfTTKZY
9/oKHTBz32IAtznwP9i3VOGsCUdAOA==
=pheu
-----END PGP SIGNATURE-----

--vnthco5xguhfwvza--
