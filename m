Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397B2476F23
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhLPKtT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 05:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhLPKtT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 05:49:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EE7C061574
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 02:49:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mxoK5-0004X5-43; Thu, 16 Dec 2021 11:49:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mxoK4-004pSr-Cy; Thu, 16 Dec 2021 11:49:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mxoK3-0005H7-Al; Thu, 16 Dec 2021 11:49:15 +0100
Date:   Thu, 16 Dec 2021 11:49:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, David Lechner <david@lechnology.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] counter: ti-eqep: Use container_of instead of struct
 counter_device::priv
Message-ID: <20211216104915.62qfwjal5bz3x7g7@pengutronix.de>
References: <20211213114312.1406562-1-u.kleine-koenig@pengutronix.de>
 <YbrNr20FBb+ZMShv@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5ooepdcvpbgawri"
Content-Disposition: inline
In-Reply-To: <YbrNr20FBb+ZMShv@shinobu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--f5ooepdcvpbgawri
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello William,

On Thu, Dec 16, 2021 at 02:25:03PM +0900, William Breathitt Gray wrote:
> On Mon, Dec 13, 2021 at 12:43:12PM +0100, Uwe Kleine-K=F6nig wrote:
> > Using counter->priv is a memory read and so more expensive than
> > container_of which is only an addition. (In this case even a noop
> > because the offset is 0.)
> >=20
> > So container_of is expected to be a tad faster, it's type-safe, and
> > produces smaller code (ARCH=3Darm allmodconfig):
> >=20
> > 	$ source/scripts/bloat-o-meter drivers/counter/ti-eqep.o-pre drivers/c=
ounter/ti-eqep.o
> > 	add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-108 (-108)
> > 	Function                                     old     new   delta
> > 	ti_eqep_position_enable_write                132     120     -12
> > 	ti_eqep_position_enable_read                 260     248     -12
> > 	ti_eqep_position_ceiling_write               132     120     -12
> > 	ti_eqep_position_ceiling_read                236     224     -12
> > 	ti_eqep_function_write                       220     208     -12
> > 	ti_eqep_function_read                        372     360     -12
> > 	ti_eqep_count_write                          312     300     -12
> > 	ti_eqep_count_read                           236     224     -12
> > 	ti_eqep_action_read                          664     652     -12
> > 	Total: Before=3D4598, After=3D4490, chg -2.35%
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I'll pick this up and submit it with the rest of the Counter changes for
> this cycle.

This is great. The same transformation could be done for the other
drivers using the priv pointer. Then priv could be removed from struct
counter_device. Good idea?

A quick prototype patch yields:

drivers/counter/104-quad-8.o
  add/remove: 0/0 grow/shrink: 5/17 up/down: 76/-172 (-96)
  Total: Before=3D11802, After=3D11706, chg -0.81%
drivers/counter/ftm-quaddec.o
  add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-60 (-60)
  Total: Before=3D5096, After=3D5036, chg -1.18%
drivers/counter/intel-qep.o
  add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-116 (-116)
  Total: Before=3D4867, After=3D4751, chg -2.38%
drivers/counter/interrupt-cnt.o
  add/remove: 0/0 grow/shrink: 0/6 up/down: 0/-60 (-60)
  Total: Before=3D2841, After=3D2781, chg -2.11%
drivers/counter/microchip-tcb-capture.o
  add/remove: 0/0 grow/shrink: 1/6 up/down: 12/-68 (-56)
  Total: Before=3D5920, After=3D5864, chg -0.95%
drivers/counter/stm32-lptimer-cnt.o
  add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-140 (-140)
  Total: Before=3D6458, After=3D6318, chg -2.17%
drivers/counter/stm32-timer-cnt.o
  add/remove: 0/0 grow/shrink: 0/11 up/down: 0/-132 (-132)
  Total: Before=3D5504, After=3D5372, chg -2.40%
drivers/counter/ti-eqep.o
  add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-120 (-120)
  Total: Before=3D4598, After=3D4478, chg -2.61%

(the ti-eqep object file got a bit smaller, probably because I removed
the priv member from struct counter_device.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f5ooepdcvpbgawri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmG7GagACgkQwfwUeK3K
7AmdiQgAks2N9u9bP35X5DV7TBto0B0aZFYS/OO9Hu7IJiTkQ3S0r0jXl8lEyobo
H0fprB4/yJj7ljNPabIQa/YhjrY8HufgEjjQ91OpcGA0/pTLfqy6lzdksUqMYMBY
i6dck//VLbM1xkBJ0lCvcOwKnaH/Hx0ItgBIkMdJUTO6HmdKLGvYKuPLSMV50Fiy
Ouidbm8WOMz8x+t8ICS6jP3znJXKOkK5hn2XAXgfJOj092SuN3b7vJ8Oi3pf66e8
mAZHo2yemEs85CgN7yHjfmPacFB+kptXY/LvO2+oLkCBmMFF93YacK0v+mYoiYJq
ph00P9nbmifMeUpJWGI2aeWmo6Ssug==
=lsYH
-----END PGP SIGNATURE-----

--f5ooepdcvpbgawri--
