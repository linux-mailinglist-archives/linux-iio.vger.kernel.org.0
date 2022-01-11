Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD648A93A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jan 2022 09:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiAKIVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jan 2022 03:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiAKIVI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jan 2022 03:21:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB1EC06173F
        for <linux-iio@vger.kernel.org>; Tue, 11 Jan 2022 00:21:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7COt-0000r1-8N; Tue, 11 Jan 2022 09:21:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7COp-009fyB-44; Tue, 11 Jan 2022 09:20:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7COo-0003gk-7x; Tue, 11 Jan 2022 09:20:58 +0100
Date:   Tue, 11 Jan 2022 09:20:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: fix an IS_ERR() vs NULL bug
Message-ID: <20220111082055.4w3arxe326cn65ht@pengutronix.de>
References: <20220111072500.GI11243@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwz2eiebxkvavpah"
Content-Disposition: inline
In-Reply-To: <20220111072500.GI11243@kili>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--gwz2eiebxkvavpah
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 11, 2022 at 10:25:00AM +0300, Dan Carpenter wrote:
> There are 8 callers for devm_counter_alloc() and they all check for NULL
> instead of error pointers.  I think NULL is the better thing to return
> for allocation functions so update counter_alloc() and devm_counter_alloc=
()
> to return NULL instead of error pointers.
>=20
> Fixes: c18e2760308e ("counter: Provide alternative counter registration f=
unctions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Oh indeed. I wonder how you found that problem.

There is a possibility that counter_alloc() (as it's implemented now in
next) returns an error value !=3D -ENOMEM. (ida_alloc() can return
-ENOSPC, counter_chrdev_add() can return -EINVAL). Still returning NULL
on error looks sane.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gwz2eiebxkvavpah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHdPeMACgkQwfwUeK3K
7AlDVgf8DynSHJ3KBZUay7Vx87GWSeXK0h3kWlrR52GPfpMkDZ+4FCZoMKzJwBRl
0NLEv+spD6lDzylu9IJXh1BYsePWZsORw44XWg2amJDomNa7UCkFHz0duBRWBS4C
BiEy8lVUdKBdIP9qxxKGkuIokgmkyDBecnAYBmCipQHJ71Zh7FPRpXr+eCTXoOKF
HMjTlhV6ki0ZTUK88dv8u3z1dFmyMGbzv9GXbDsaANbwvovhX1BNPac199zBsbuf
qLAojdaZfn9fVMfAYNPp4R8V+fAz2P4WM4Exdq+ZbqQffFAWzqYOgmTCZiqDIsvh
aKPbWtkgO8iAiwVHv5ISLeTn9Mz/Rg==
=OIA4
-----END PGP SIGNATURE-----

--gwz2eiebxkvavpah--
