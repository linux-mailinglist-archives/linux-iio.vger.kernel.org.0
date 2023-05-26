Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D977129F1
	for <lists+linux-iio@lfdr.de>; Fri, 26 May 2023 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbjEZPvY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 May 2023 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZPvY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 May 2023 11:51:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58BF2
        for <linux-iio@vger.kernel.org>; Fri, 26 May 2023 08:51:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2Zir-0006Dm-0s; Fri, 26 May 2023 17:51:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2Ziq-002zGG-4d; Fri, 26 May 2023 17:51:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2Zip-008CdQ-Gk; Fri, 26 May 2023 17:51:19 +0200
Date:   Fri, 26 May 2023 17:51:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] iio: Switch i2c drivers back to use .probe()
Message-ID: <20230526155119.frh5ewjjeod2t2j6@pengutronix.de>
References: <20230515205048.19561-1-u.kleine-koenig@pengutronix.de>
 <20230520164340.25360292@jic23-huawei>
 <20230520171300.mwtdml3lkwd3cvwi@pengutronix.de>
 <20230521185625.5b2ce65d@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwzy7l7rfqdsxhqf"
Content-Disposition: inline
In-Reply-To: <20230521185625.5b2ce65d@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zwzy7l7rfqdsxhqf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, May 21, 2023 at 06:56:25PM +0100, Jonathan Cameron wrote:
> On Sat, 20 May 2023 19:13:00 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello Jonathan,
> >=20
> > On Sat, May 20, 2023 at 04:43:40PM +0100, Jonathan Cameron wrote:
> > > On Mon, 15 May 2023 22:50:48 +0200
> > > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> > >  =20
> > > > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > > > call-back type"), all drivers being converted to .probe_new() and t=
hen
> > > > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") c=
onvert
> > > > back to (the new) .probe() to be able to eventually drop .probe_new=
() from
> > > > struct i2c_driver.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> =
=20
> > > Some fuzz due to other patches being queued up already, but otherwise
> > > LGTM and applied to the togreg branch of iio.git which is initially p=
ushed
> > > out as testing for 0-day to give it a whirl. =20
> >=20
> > Looks good, thanks!
> >=20
> > Your tree has a few new drivers that still use .probe_new(). To convert
> > these we'd need:
> >=20
> > diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> > index feb57cb99aa4..502946bf9f94 100644
> > --- a/drivers/iio/light/opt4001.c
> > +++ b/drivers/iio/light/opt4001.c
> > @@ -457,7 +457,7 @@ static struct i2c_driver opt4001_driver =3D {
> >  		.name =3D "opt4001",
> >  		.of_match_table =3D opt4001_of_match,
> >  	},
> > -	.probe_new =3D opt4001_probe,
> > +	.probe =3D opt4001_probe,
> >  	.id_table =3D opt4001_id,
> >  };
> >  module_i2c_driver(opt4001_driver);
> > diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-=
bu27008.c
> > index adac4cd8d905..489902bed7f0 100644
> > --- a/drivers/iio/light/rohm-bu27008.c
> > +++ b/drivers/iio/light/rohm-bu27008.c
> > @@ -1016,7 +1016,7 @@ static struct i2c_driver bu27008_i2c_driver =3D {
> >  		.of_match_table =3D bu27008_of_match,
> >  		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> >  	},
> > -	.probe_new =3D bu27008_probe,
> > +	.probe =3D bu27008_probe,
> >  };
> >  module_i2c_driver(bu27008_i2c_driver);
> > =20
> > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/=
mprls0025pa.c
> > index 06f40e47c68e..30fb2de36821 100644
> > --- a/drivers/iio/pressure/mprls0025pa.c
> > +++ b/drivers/iio/pressure/mprls0025pa.c
> > @@ -436,7 +436,7 @@ static const struct i2c_device_id mpr_id[] =3D {
> >  MODULE_DEVICE_TABLE(i2c, mpr_id);
> > =20
> >  static struct i2c_driver mpr_driver =3D {
> > -	.probe_new	=3D mpr_probe,
> > +	.probe		=3D mpr_probe,
> >  	.id_table	=3D mpr_id,
> >  	.driver		=3D {
> >  		.name		=3D "mprls0025pa",
> >=20
> > At some point I'd need to address these. What is your preferred way to
> > handle these? I can send a proper follow up patch, you can squash the
> > above diff into be8e2ed93211 ... just tell me your preference. If you
> > don't I will send a patch at some point.
>=20
> Good point. I wasn't paying attention.  Some of these at least are after
> your patch in my tree, so I've fixed those up at introduction rather than
> messing around with a follow on patch.
>=20
> I squashed the opt4001 into this patch as that driver is now upstream.
>=20
> So should all look good now.  I'll probably miss some more later in the
> series though so if you notice, do point them out! Takes a while for
> my review brain to pick up on function name changes ;)
>=20
> New version of testing pushed out just now.

Just for the record:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing (as
of commit f3ae82534ab2 "iio: imu: inv_icm42600: avoid frequent timestamp
jitter") looks good. All drivers are properly converted to .probe()
there.

Best regards

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zwzy7l7rfqdsxhqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRw1XYACgkQj4D7WH0S
/k7TFwf8DW7/1kJTo5AaM52NWk2bcfGWvwv4ktJGlDQZIj91xQe42YCIEmgN9qeE
hKgtk3HEm6oqQcJsnMMzFa66T5aY4TyuV3Esx6v7MqB3KYGPLM4VLIOzuBXj3nmL
6hdIY9ERFFGstoFFgZpLb5y3AQgVIf5lbv017K80835mGrScygi954FXnC01798V
rOznk/nDPANXTxxphoLpWR0/jO2WHPJhRm8TG2Cz6IYSQEvCfX4cTUEIIgA1skeF
pnQhrNM26WRFfoNJeOOAUzFB9phyUZuFGY2t7InPbpTpplnfUwocNRg+pu1vH3QH
J2chZiy9h4gj7PWF5Wz+CFJtclogMw==
=IDb3
-----END PGP SIGNATURE-----

--zwzy7l7rfqdsxhqf--
