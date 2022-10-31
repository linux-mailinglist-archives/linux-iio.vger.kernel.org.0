Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E690F6141E7
	for <lists+linux-iio@lfdr.de>; Tue,  1 Nov 2022 00:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJaXjG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 19:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaXjG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 19:39:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EAD272C
        for <linux-iio@vger.kernel.org>; Mon, 31 Oct 2022 16:39:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1opeMo-00088U-Gz; Tue, 01 Nov 2022 00:38:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1opeMi-001ZDo-0g; Tue, 01 Nov 2022 00:38:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1opeMg-00DWhD-97; Tue, 01 Nov 2022 00:38:46 +0100
Date:   Tue, 1 Nov 2022 00:38:43 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <20221031233843.4rbcfs3hstlkv7il@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
 <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
 <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o5axfgflv2lujcg2"
Content-Disposition: inline
In-Reply-To: <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
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


--o5axfgflv2lujcg2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Oct 24, 2022 at 12:46:02PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Oct 24, 2022 at 11:39:51AM +0300, Andy Shevchenko wrote:
> > > On Mon, Oct 24, 2022 at 09:05:18AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Sun, Oct 23, 2022 at 10:06:11PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, Oct 23, 2022 at 03:22:49PM +0200, Uwe Kleine-K=F6nig wrot=
e:
>=20
> ...
>=20
> > > > > > +static const struct i2c_device_id kxcjk1013_id[] =3D {
> > > > > > +	{"kxcjk1013", KXCJK1013},
> > > > > > +	{"kxcj91008", KXCJ91008},
> > > > > > +	{"kxtj21009", KXTJ21009},
> > > > > > +	{"kxtf9",     KXTF9},
> > > > > > +	{"kx023-1025", KX0231025},
> > > > > > +	{"SMO8500",   KXCJ91008},
> > > > > > +	{}
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > > > >=20
> > > > > I don't like this part. Can we, please, find a way how to derefer=
ence this
> > > > > table via struct i2c_client, please?
> > > >=20
> > > > It would be possible to do (on top of my patch here as PoC):
> > > >=20
> > > > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxc=
jk-1013.c
> > > > index e043dd698747..00269b25af99 100644
> > > > --- a/drivers/iio/accel/kxcjk-1013.c
> > > > +++ b/drivers/iio/accel/kxcjk-1013.c
> > > > @@ -1445,7 +1445,7 @@ MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > > > =20
> > > >  static int kxcjk1013_probe(struct i2c_client *client)
> > > >  {
> > > > -	const struct i2c_device_id *id =3D i2c_match_id(kxcjk1013_id, cli=
ent);
> > > > +	const struct i2c_device_id *id =3D i2c_match_id(to_i2c_driver(cli=
ent->dev.driver)->id_table, client);
> > > >  	struct kxcjk1013_data *data;
> > > >  	struct iio_dev *indio_dev;
> > > >  	struct kxcjk_1013_platform_data *pdata;
> > > >=20
> > > > (only compile tested), you could even create a function or macro to=
 make
> > > > this a bit prettier on the source level. For the compiler loading t=
he
> > > > address from a local symbol instead of from two pointer dereference=
s is
> > > > (I guess) a bit more effective and IMHO more natural.
> > > >=20
> > > > *shrug*, I don't care much, but I don't like to have to rework this
> > > > series just because you don't like this part. You even didn't give a
> > > > rationale, I can imagine several different ones:
> > >=20
> > > And I don't want to have ping-ponging the pieces of code (ID tables) =
because
> > > some API has to be fixes or so.
> >=20
> > In this series it's only ping without pong.
>=20
> Exactly. And it means let's put my problem to someone's else shoulders.

You have a problem that I fail to see. Why is defining the id table
before the probe function bad?

Unless I misunderstand you, you seem to assume that in the nearer future
someone will have the urge to put the id table below the probe function
again. What would you think is their motivation?

> > To benefit from the local
> > table instead of fishing the table out of client, the table must be
> > declared already when it's used.
>=20
> I don't see benefit of dereferencing tables by name. The table has to be
> available via struct driver, otherwise, how the heck we even got into the
> ->probe() there.

It is possible, it's just cheaper (in cpu cycles) to calculate the
address of the table directly (i.e. via PC + $offset) instead of via
dereferencing two pointers.

> > > >  [ ] it makes the patch bigger
> > > >  [ ] it results in an unnatural order of symbols in the driver
> > > >  [ ] it's some kind of duplication
> > > >  [ ] something else
> > > >      please elaborate: ________________________________
> > >=20
> > > It adds a burden to the future work with no good justification along =
with
> >=20
> > This burden exists in the drivers that already today have the table
> > above the probe function? (Ok, there are none in this series, but it
> > happens, see for example
> >=20
> > 	https://lore.kernel.org/linux-rtc/20221021130706.178687-4-u.kleine-koe=
nig@pengutronix.de
> >=20
> > and a few more in the rtc series.) I don't see a burden here, we're
> > talking about the id table being defined before the probe function, rig=
ht?
> > How is that a burden? What am I missing?
>=20
> Yeah, people haven't had no idea about accessing tables via struct driver,
> reviewers of that code neither. Should it be excuse for us to follow that
> example?

I fail to follow you again. I talked about drivers/rtc/rtc-isl1208.c as
it is in v6.1-rc1. There the probe function doesn't access the table at
all. Neither via the driver link nor by name. That driver just defines
the id table before the probe function.

> > > a churn in _this_ series.
> >=20
> > The alternatives are: Split the patch into reorder + convert to
> > .probe_new, or add a declaration for the id table. Among these I like
> > the current approach besto.
>=20
> Alternative is to avoid reordering to begin with, no?

Yeah, that could be done. But I don't see the advantage and you fail to
explain it in a way for me to understand.

So if i2c_match_id() was changed as follows:

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -101,9 +101,17 @@ EXPORT_SYMBOL_GPL(i2c_freq_mode_string);
 const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
-	if (!(id && client))
+	if (!client)
 		return NULL;
=20
+	if (!id) {
+		struct i2c_driver *driver =3D to_i2c_driver(client->dev.driver);
+
+		id =3D driver->id_table;
+		if (!id)
+			return NULL;
+	}
+
 	while (id->name[0]) {
 		if (strcmp(client->name, id->name) =3D=3D 0)
 			return id;


the patch under discussion could be reduced to:

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index adc66b3615c0..b1d11c96597d 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1432,9 +1432,9 @@ static void kxcjk1013_disable_regulators(void *d)
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
=20
-static int kxcjk1013_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static int kxcjk1013_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id =3D i2c_match_id(NULL, client);
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;
@@ -1749,7 +1749,7 @@ static struct i2c_driver kxcjk1013_driver =3D {
 		.of_match_table =3D kxcjk1013_of_match,
 		.pm	=3D &kxcjk1013_pm_ops,
 	},
-	.probe		=3D kxcjk1013_probe,
+	.probe_new	=3D kxcjk1013_probe,
 	.remove		=3D kxcjk1013_remove,
 	.id_table	=3D kxcjk1013_id,
 };

I assume you agree up to here.

After that change there is some incentive to do

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index b1d11c96597d..e043dd698747 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1432,9 +1432,20 @@ static void kxcjk1013_disable_regulators(void *d)
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
=20
+static const struct i2c_device_id kxcjk1013_id[] =3D {
+	{"kxcjk1013", KXCJK1013},
+	{"kxcj91008", KXCJ91008},
+	{"kxtj21009", KXTJ21009},
+	{"kxtf9",     KXTF9},
+	{"kx023-1025", KX0231025},
+	{"SMO8500",   KXCJ91008},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
+
 static int kxcjk1013_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id =3D i2c_match_id(NULL, client);
+	const struct i2c_device_id *id =3D i2c_match_id(kxcjk1013_id, client);
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;
@@ -1720,18 +1731,6 @@ static const struct acpi_device_id kx_acpi_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
=20
-static const struct i2c_device_id kxcjk1013_id[] =3D {
-	{"kxcjk1013", KXCJK1013},
-	{"kxcj91008", KXCJ91008},
-	{"kxtj21009", KXTJ21009},
-	{"kxtf9",     KXTF9},
-	{"kx023-1025", KX0231025},
-	{"SMO8500",   KXCJ91008},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
-
 static const struct of_device_id kxcjk1013_of_match[] =3D {
 	{ .compatible =3D "kionix,kxcjk1013", },
 	{ .compatible =3D "kionix,kxcj91008", },

on top to safe two pointer dereferences. The sum of the two driver
patches is exactly the effect of my patch just without the i2c core
change. (And the two pointer dereferences that are saved by the 2nd
patch are introduced by the first, so it's fine to not split that
change into two parts.)

> > > While I like the rest of the series, these things I would rather post=
pone
> > > or rework.
> >=20
> > There is no win in postponing, is there?[1] What would be your preferred
> > way to rework?
>=20
> My understand of the probe_new is that an attempt to unify i2c with how s=
pi
> does.

My understanding is a bit different, but this detail doesn't matter.

> So, why not teach i2c_match_id() to handle this nicely for the caller?

The metric for "nice" is obviously subjective. For me it's nice to pass
a local symbol to an API function to make the function's job a tad
easier and more effective to solve. And that even if I have to reorder
the caller a bit.

> This will allow to leave tables where they are (or move closer to struct
> driver),

As written above, reordering the driver is (IMHO) cheap enough given the
benefit.

> reduce churn with the using of current i2c_match_id() as you
> showed the long line to get that table.

Do you still remember the original patch? That one doesn't have the long
i2c_match_id() line.

(Do you see your statement is an argument for my approach? The long line
is an indication that it's complicated to determine the address of the
table via ->driver. You can hide that by pushing the needed effort into
i2c_match_id() or a macro, but in the end the complexity remains for the
CPU.)

> This might need a new API to avoid
> changing many drivers at once. But it's business as usual.

My approach doesn't need a new API. That's nice, isn't it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o5axfgflv2lujcg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNgXH4ACgkQwfwUeK3K
7AlPSgf/XEvMxSf79HCxcgCA5d5FoCV76zG7CZ0IGIgV2f1A5i8rIwfrxwuNXTzE
EX3XyvqgkjeeJ27p9Dm3crAT+mNYMWJq4pw/CDSfjhZ/3NYt1tSq9rQvc62N+Kaq
FaweVTFxJClKPvR9YcR1qp0uGmkiX3EG6KwpN+yItTcdooBaIt5ZjDkcUpdWPbMj
/UL/RbdZdlrMO0maYxeZEHsSECS//e/iM2blWkM2PQdXb4bRnVKHKyc+SI445KQP
XpGQ+jqq4AIMfnSTrk6rBsolGSPLEy0YpBih3T3vyqmMWhRNnwt3w+PpoW5Y+XTx
FCYnJk9h/0g5sEJH0ny2acKLGBmczg==
=pQaA
-----END PGP SIGNATURE-----

--o5axfgflv2lujcg2--
