Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1655516ADD
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 08:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbiEBGer (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 02:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiEBGep (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 02:34:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD4C5F55
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 23:31:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlPaN-0002E0-Nf; Mon, 02 May 2022 08:31:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlPaM-006Ttc-2w; Mon, 02 May 2022 08:31:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlPaJ-0070Mp-ST; Mon, 02 May 2022 08:31:03 +0200
Date:   Mon, 2 May 2022 08:31:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jiri Valek - 2N <valek@2n.cz>,
        Colin Ian King <colin.king@intel.com>,
        Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 0/9] iio: Remove duplicated error reporting in .remove()
Message-ID: <20220502063100.yipcbiskuzmyo3bf@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
 <20220501184149.10b40610@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="prscy2gkdkk73fkw"
Content-Disposition: inline
In-Reply-To: <20220501184149.10b40610@jic23-huawei>
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


--prscy2gkdkk73fkw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sun, May 01, 2022 at 06:41:49PM +0100, Jonathan Cameron wrote:
> On Sat, 30 Apr 2022 10:15:58 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello,
> >=20
> > this series adapts several i2c drivers that emit two error messages if
> > something in their remove function fails. The relevant issue is that the
> > i2c core emits an error message if the remove callback returns a
> > non-zero value but the drivers already emit a (better) message. So
> > these patches change the drivers to return 0 even after an error. Note
> > there is no further error handling in the i2c core, if a remove callback
> > returns an error code, the device is removed anyhow, so the only effect
> > of making the return value zero is that the error message is suppressed.
> >=20
> > The motivation for this series is to eventually change the prototype of
> > the i2c remove callback to return void. As a preparation all remove
> > functions should return 0 such that changing the prototype doesn't
> > change behaviour of individual drivers.
>=20
> I think I'd rather have seen these called out as simply moving towards
> this second change as it feels wrong to deliberately not report an error
> so as to avoid repeated error messages!

I admit this is a bit strange. Once the i2c remove callback is changed
accordingly (and the platform remove callback, and the ac97_codec_driver
remove callback ...) this goes away. Working on it.

The reason it's that way is that for similar patches the maintainer
feedback was to include the preparatory patch in the series that
actually changes the remove callback. As I like to have as much of the
preparatory patches already applied, I thought it a good idea to find a
motivation to apply already today :-)

Thanks for your cooperation,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--prscy2gkdkk73fkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJveqEACgkQwfwUeK3K
7AkFqwf+KIxE1q5UkxESFMPG5ZYOmKein+N68vQFTquxPsiZqWqubp+M8b4jwY5y
lG6CUI1Kn+A/UjaNs2G5FhPtDj/S1tHp7OoFi2a0qlpPL1j3c1MhOEq4+ncQPdsz
xQq5gTvOoWz6wRu/pAPBWU2Zi7z2A3mS1XPnF+LJWzCmLsAxM/AUwlJJq/u0tmZW
soqUF8u372Ylx7JhwuB5tHJ27NcguzV0TXwtjGAQZOrK8vWAGZVMLZyw18iBQfmC
0cclWfdlcUcHmtqiqL0YQ6NPklqJfHwQWXCRpvygGPvO+KneS4Mbvyq6CO7Yfj2v
Q1Xn23zMkFd16nffCw4gatt0xJue2g==
=o5Nl
-----END PGP SIGNATURE-----

--prscy2gkdkk73fkw--
