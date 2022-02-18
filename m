Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05B4BB65B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 11:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiBRKIG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 05:08:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiBRKIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 05:08:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480941B7BF
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 02:07:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nL0Az-0001P2-DN; Fri, 18 Feb 2022 11:07:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nL0Az-00HNUK-Bs; Fri, 18 Feb 2022 11:07:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nL0Ax-003y6p-LU; Fri, 18 Feb 2022 11:07:43 +0100
Date:   Fri, 18 Feb 2022 11:07:43 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] counter: Stop using dev_get_drvdata() to get the counter
 device
Message-ID: <20220218100743.ipzhzcv2cvaw3a2f@pengutronix.de>
References: <20220218092031.167689-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfyftfv6zovvw7xo"
Content-Disposition: inline
In-Reply-To: <20220218092031.167689-1-vilhelm.gray@gmail.com>
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


--mfyftfv6zovvw7xo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 18, 2022 at 06:20:31PM +0900, William Breathitt Gray wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter: Use
> container_of instead of drvdata to track counter_device") which wrongly
> claimed there were no users of drvdata. Convert to container_of() to
> fix a null pointer dereference.
>=20
> Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata to tra=
ck counter_device")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

William didn't tell explicitly, so in case there are doubts: This patch
is targeted for v5.17.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mfyftfv6zovvw7xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIPb+wACgkQwfwUeK3K
7AkdEgf/bmf5sYB0eYSvBmbPJag0UY/r0kQXIHhBUQxrKmVZ6HKUEj0EmQDrsNss
E5pcv0h+x49+GKnDY29ime4SejdL71Wnd2By8wijWb+crPqwDNB9x9zv85iTuH8V
4e16mffTWVWOUaPWIol0CoZ+7HgEfQ+e5B5nfKOyVaHu2OdaaU4WraepzLyEqJAp
cYnmklHyOsbq1P9Tt5Jh+S1ibnI9envv0B0zzkqwhLkaio351yf3PwzcpuihZMqs
ZQDo51j6y3VEilNmakixkqgPVIs6P1IeBUX2p48GsMQqqbuovdgaY3GCseRylTOu
+qThaDTrnp0ktNLNXqLASlyxp1T2OA==
=1E4O
-----END PGP SIGNATURE-----

--mfyftfv6zovvw7xo--
