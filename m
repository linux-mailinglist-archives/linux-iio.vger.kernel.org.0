Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2259347F451
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhLYTVA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 14:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhLYTVA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 14:21:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1BC061401
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 11:21:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1Cb3-0003Fa-82; Sat, 25 Dec 2021 20:20:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1Cav-006c7N-Vx; Sat, 25 Dec 2021 20:20:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1Cau-00013T-M4; Sat, 25 Dec 2021 20:20:40 +0100
Date:   Sat, 25 Dec 2021 20:20:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Raymond Tan <raymond.tan@intel.com>,
        David Lechner <david@lechnology.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v1 00/23] counter: cleanups and device lifetime fixes
Message-ID: <20211225192038.amgzrvkeyjgzzbuz@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="brkdmfeoz7b6nrp4"
Content-Disposition: inline
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--brkdmfeoz7b6nrp4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

some sidestory to this series: While working on fixing the struct dev
lifetime thing, I saw a few ugly things that I don't intend to fix
myself. Here is just a mail to let you know this with a list of issues.
Feel free to address or ignore:

 - 104_QUAD_8 depends on X86, but compiles fine on ARCH=3Darm. Maybe
   adding support for COMPILE_TEST would be a good idea.

 - 104-quad-8.c uses devm_request_irq() and (now) devm_counter_add(). On
   unbind an irq might be pending which results in quad8_irq_handler()
   calling counter_push_event() for a counter that is already
   unregistered. (The issue exists also without my changes.)

 - I think intel-qep.c makes the counter unfunctional in
   intel_qep_remove before the counter is unregistered.

 - I wonder why counter is a bus and not a class device type. There is
   no driver that would ever bind a counter device, is there? So
   /sys/bus/counter/driver is always empty.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--brkdmfeoz7b6nrp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHbwIACgkQwfwUeK3K
7Ane8Qf/fj3yjbDjH1BwhgTbIyr1MvJB/jYkrvrqAS3gulzBuDJzz2Wpp8sni7Vf
Rq52rF0wy6PxoMkSaEiElzblGEBpDhsahcfKFy5+GCFymff69Alr1F9anjDroxbH
+s9sG/nAhZD6ARgdmXArkb946o6CljYaY9DJw1UirbtY7lNxzKJIDvBAaYDAzM1o
5nmq1tLuf/x6HZwmi0AKTLlzJZIvLuwnLoG+pdvOuKo8IYmD1iVHi7FmKXSrA6Cw
rkezM862V+IjRCbPVlpZunMNg2gxk5xUya68/ii7DUjgQqgs3aYazySvCIYr+t+w
hWgf5e3MTJXag7QaD2BPZb9UlklDMA==
=U+LO
-----END PGP SIGNATURE-----

--brkdmfeoz7b6nrp4--
