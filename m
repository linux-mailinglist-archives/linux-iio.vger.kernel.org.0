Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACA609AF4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJXHFo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 03:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJXHFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 03:05:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1D4504C
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 00:05:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omrWW-00012D-LE; Mon, 24 Oct 2022 09:05:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omrWS-0004HK-J4; Mon, 24 Oct 2022 09:05:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omrWQ-00ADPL-SA; Mon, 24 Oct 2022 09:05:18 +0200
Date:   Mon, 24 Oct 2022 09:05:18 +0200
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
Message-ID: <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aywuje6yv236pu33"
Content-Disposition: inline
In-Reply-To: <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
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


--aywuje6yv236pu33
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 23, 2022 at 10:06:11PM +0300, Andy Shevchenko wrote:
> On Sun, Oct 23, 2022 at 03:22:49PM +0200, Uwe Kleine-K=F6nig wrote:
> > .probe_new() doesn't get the i2c_device_id * parameter, so determine
> > that explicitly in .probe(). The device_id array has to move up for that
> > to work.
>=20
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
>=20
> I don't like this part. Can we, please, find a way how to dereference this
> table via struct i2c_client, please?

It would be possible to do (on top of my patch here as PoC):

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index e043dd698747..00269b25af99 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1445,7 +1445,7 @@ MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
=20
 static int kxcjk1013_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id =3D i2c_match_id(kxcjk1013_id, client);
+	const struct i2c_device_id *id =3D i2c_match_id(to_i2c_driver(client->dev=
=2Edriver)->id_table, client);
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;

(only compile tested), you could even create a function or macro to make
this a bit prettier on the source level. For the compiler loading the
address from a local symbol instead of from two pointer dereferences is
(I guess) a bit more effective and IMHO more natural.

*shrug*, I don't care much, but I don't like to have to rework this
series just because you don't like this part. You even didn't give a
rationale, I can imagine several different ones:

 [ ] it makes the patch bigger
 [ ] it results in an unnatural order of symbols in the driver
 [ ] it's some kind of duplication
 [ ] something else
     please elaborate: ________________________________

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aywuje6yv236pu33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNWOSsACgkQwfwUeK3K
7AnceAf+KV0/psyEgnqHWK9lYGWVTHrFKX2AxGqH/DR5tRRiEMrlXKzBfLsTKyRK
hMsORrZS3Vj5sd7KH5mqBBDoJOwg5+3X6DwCrlIhL9FT9jwMloyVlkYOLwt0oZ4t
RBymrkyDodirG/4zbovPYoWMvNsdGiyoyu0rqjAbcrDuvY1UisMdCzJIhHCc8IAh
OAwtZkFMuCYMUBKra/T7MJAmW3v9FpG/jQvkqzsvjD2SZh70A0Ql2gCmltPvZP+1
DOLjMPDELwtp75D6pKBQq1yhmXVLph+5j1oy3hkd6Q1VKe/o/BwBU422sJ+ZCfL9
CN2kiu2XJQWQBfOGKEnXLyyzcPQt6g==
=yrGU
-----END PGP SIGNATURE-----

--aywuje6yv236pu33--
