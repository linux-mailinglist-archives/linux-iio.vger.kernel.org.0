Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C070ED7D
	for <lists+linux-iio@lfdr.de>; Wed, 24 May 2023 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjEXGBm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 May 2023 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjEXGBk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 May 2023 02:01:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40AB132
        for <linux-iio@vger.kernel.org>; Tue, 23 May 2023 23:01:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1hYi-00073O-TF; Wed, 24 May 2023 08:01:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1hYX-002PqH-1c; Wed, 24 May 2023 08:01:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1hYW-007SK3-Am; Wed, 24 May 2023 08:01:04 +0200
Date:   Wed, 24 May 2023 08:01:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
        Tom Rix <trix@redhat.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jean Delvare <jdelvare@suse.de>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haowen Bai <baihaowen@meizu.com>,
        Jens Frederich <jfrederich@gmail.com>,
        linux-staging@lists.linux.dev,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        linux-media@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kalle Valo <kvalo@kernel.org>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: Switch i2c drivers back to use .probe()
Message-ID: <20230524060104.wljjqi2ep2ag2245@pengutronix.de>
References: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
 <b9954a28-1ab2-468d-beb5-2fa2e0f2c069@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqy6b2uvxwwx5uuf"
Content-Disposition: inline
In-Reply-To: <b9954a28-1ab2-468d-beb5-2fa2e0f2c069@redhat.com>
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


--zqy6b2uvxwwx5uuf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Tue, May 23, 2023 at 10:40:43PM +0200, Hans de Goede wrote:
> On 5/23/23 22:00, Uwe Kleine-K=F6nig wrote:
> > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > call-back type"), all drivers being converted to .probe_new() and then
> > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") conve=
rt
> > back to (the new) .probe() to be able to eventually drop .probe_new() f=
rom
> > struct i2c_driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > this patch was generated using coccinelle.
> >=20
> > I chose to convert all drivers below drivers/staging in a single
> > patch, but if you prefer I can split by driver.
>=20
> I'm currently doing a lot of cleanup work on the atomisp code
> including the sensor drivers. Specifically I'm working on
> removing drivers which are duplicate with the standard v4l2
> sensor drivers under drivers/media/i2c . So this patch is
> likely to cause conflicts.
>=20
> I have my own branch for my atomisp work from which I send
> pull-reqs directly to Mauro Chehab:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=3D=
media-atomisp
>=20
> As such I think for the atomisp drivers it would be best if I directly
> apply the atomisp bits of this patch (no need for a resend) to my
> media-atomisp branch, is that ok with you ?

For me that would be fine, it's mostly Greg who has to cope. As Jonathan
also suggested to split, I suggest I do this. Then everyone can pickup
the usual bits without too much conflicts.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zqy6b2uvxwwx5uuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRtqB8ACgkQj4D7WH0S
/k5jcAf/WFlyFOsuQCHCP7XhhLma9YjYqV09mCEayg0z2IjJ+7vSN3WRkhwspkEO
ti62GhVpzLcGAMaZiPoB/4hZtJJfkjJrzfnOC0nhM7GnpBOorLWm0uV/Rih1O0pw
dgXIp56Nk946bR2kjK4jFsezU5R8Be7iLRqF67E2ASL5HcI0ifC/kzyC3bIz3RXv
HS6sE9oH2VO/Tumqt/D7DZCa3+JHwvkSY4tasd9/D1c1b0dvA+DPOh/DtfpGua5I
WyTiA5R2KrzryD7aJUEuD4C8D66HiTahycCkemMtHwViEGTuTUvpkrStwAbC7rYB
HwHePXvE1xRpNG0x3yAUWrd4Gs/gKg==
=gQyv
-----END PGP SIGNATURE-----

--zqy6b2uvxwwx5uuf--
