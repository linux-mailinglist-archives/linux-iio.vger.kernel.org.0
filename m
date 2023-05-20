Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221F70A96F
	for <lists+linux-iio@lfdr.de>; Sat, 20 May 2023 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjETRNJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 May 2023 13:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjETRNI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2023 13:13:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80984109
        for <linux-iio@vger.kernel.org>; Sat, 20 May 2023 10:13:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0Q8f-00076V-6R; Sat, 20 May 2023 19:13:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0Q8e-001aXe-AT; Sat, 20 May 2023 19:13:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0Q8d-006L60-Nm; Sat, 20 May 2023 19:13:03 +0200
Date:   Sat, 20 May 2023 19:13:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] iio: Switch i2c drivers back to use .probe()
Message-ID: <20230520171300.mwtdml3lkwd3cvwi@pengutronix.de>
References: <20230515205048.19561-1-u.kleine-koenig@pengutronix.de>
 <20230520164340.25360292@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckoekeop34xg25sj"
Content-Disposition: inline
In-Reply-To: <20230520164340.25360292@jic23-huawei>
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


--ckoekeop34xg25sj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sat, May 20, 2023 at 04:43:40PM +0100, Jonathan Cameron wrote:
> On Mon, 15 May 2023 22:50:48 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > call-back type"), all drivers being converted to .probe_new() and then
> > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") conve=
rt
> > back to (the new) .probe() to be able to eventually drop .probe_new() f=
rom
> > struct i2c_driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Some fuzz due to other patches being queued up already, but otherwise
> LGTM and applied to the togreg branch of iio.git which is initially pushed
> out as testing for 0-day to give it a whirl.

Looks good, thanks!

Your tree has a few new drivers that still use .probe_new(). To convert
these we'd need:

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index feb57cb99aa4..502946bf9f94 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -457,7 +457,7 @@ static struct i2c_driver opt4001_driver =3D {
 		.name =3D "opt4001",
 		.of_match_table =3D opt4001_of_match,
 	},
-	.probe_new =3D opt4001_probe,
+	.probe =3D opt4001_probe,
 	.id_table =3D opt4001_id,
 };
 module_i2c_driver(opt4001_driver);
diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index adac4cd8d905..489902bed7f0 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -1016,7 +1016,7 @@ static struct i2c_driver bu27008_i2c_driver =3D {
 		.of_match_table =3D bu27008_of_match,
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe_new =3D bu27008_probe,
+	.probe =3D bu27008_probe,
 };
 module_i2c_driver(bu27008_i2c_driver);
=20
diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprl=
s0025pa.c
index 06f40e47c68e..30fb2de36821 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -436,7 +436,7 @@ static const struct i2c_device_id mpr_id[] =3D {
 MODULE_DEVICE_TABLE(i2c, mpr_id);
=20
 static struct i2c_driver mpr_driver =3D {
-	.probe_new	=3D mpr_probe,
+	.probe		=3D mpr_probe,
 	.id_table	=3D mpr_id,
 	.driver		=3D {
 		.name		=3D "mprls0025pa",

At some point I'd need to address these. What is your preferred way to
handle these? I can send a proper follow up patch, you can squash the
above diff into be8e2ed93211 ... just tell me your preference. If you
don't I will send a patch at some point.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ckoekeop34xg25sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRo/5sACgkQj4D7WH0S
/k7hggf/XlzpG5okvlfretEuTwH5MgYRax56zChaC0ncc1HwBSpdjYRKWj7+vJsq
yNuAudcLvrU7zhXHVDzdzhy6xuYzrPPBoThxK6ny44EXhmUrBIlsnuKme4PLqxDh
KonfLGii2LWszRC1+MqwJG3BW9jC788XoZl+NblQyfuf7ubpAyJ8ZfbU1TStTeCL
ZuAk4o1tCECU+qncHH5EZsgjNQCLcOJ/4kJN7SnUHMEYQHGDyM6hSIG9x2KYGL6T
tjrCQIjVP2F/MysH6crpaBsnse6/R9BKLP9IPJP5xSBkK1Rnw1jKL5+TqhnZKeB0
YsxFHh7kFzPB/QRmBHKYO3hFJfHcdg==
=AhWQ
-----END PGP SIGNATURE-----

--ckoekeop34xg25sj--
