Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86D5305B0
	for <lists+linux-iio@lfdr.de>; Sun, 22 May 2022 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiEVT6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 May 2022 15:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiEVT6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2022 15:58:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF6167FB
        for <linux-iio@vger.kernel.org>; Sun, 22 May 2022 12:58:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsrix-0001LC-6g; Sun, 22 May 2022 21:58:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsrix-003wZS-Jj; Sun, 22 May 2022 21:58:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsriv-00BSM6-ME; Sun, 22 May 2022 21:58:45 +0200
Date:   Sun, 22 May 2022 21:58:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] io:health:afe4404: Remove duplicated error reporting in
 .remove()
Message-ID: <20220522195842.edba7snapyefug76@pengutronix.de>
References: <20220514130432.304674-1-u.kleine-koenig@pengutronix.de>
 <20220514143812.1d2325e6@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mozl3ksk27y5up2j"
Content-Disposition: inline
In-Reply-To: <20220514143812.1d2325e6@jic23-huawei>
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


--mozl3ksk27y5up2j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sat, May 14, 2022 at 02:38:12PM +0100, Jonathan Cameron wrote:
> On Sat, 14 May 2022 15:04:32 +0200
> Uwe Kleine-K=F6nig         <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Returning an error value in an i2c remove callback results in an error
> > message being emitted by the i2c core, but otherwise it doesn't make a
> > difference.
> >=20
> > As afe4404_remove() already emits an error message on failure and the
> > additional error message by the i2c core doesn't add any useful
> > information, change the return value to zero to suppress this message.
> >=20
> > This patch is a preparation for making i2c remove callbacks return void.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Applied.
>=20
> Like the others this will sit in testing until I can rebase the togreg
> branch.

Don't know if it's to late to fix already, but I just noticed we'd want
s/io/iio/ in the Subject line.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mozl3ksk27y5up2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKKlfAACgkQwfwUeK3K
7Am2wQf/ffNGtqKUXRsxTKx67BqFPO6EqndAoV7dj6PklczZUyYXPqz7ausBYzmR
InAa8mNghbaNv/+0FBrgGpOyroTbJ9WgDAOrh97gHkSi7MyhF5nv65b9OW5GAMv0
zqUrQVVgGZq+0bqwXQClBHwgsNQDjayJfaiJcEzMFK1UMBZxLYIuhYv/q/6KWSkG
qmZvfGapBXnm9cu+lPu6Hyb4kvNuVtC9JeSkomxukYTyDDnNykbQko25dvbm5mAO
V15H3AeLCj1oh9qA31RS/dEKh+I4fPeUMSpPUT7PANEBIv3tDro4RbNSvQpLNJmr
LQR/dg0q2nmp1B+jAomazJwKqeP/Qg==
=lVIX
-----END PGP SIGNATURE-----

--mozl3ksk27y5up2j--
