Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D103C3476
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhGJMV0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhGJMV0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jul 2021 08:21:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3488C0613DD
        for <linux-iio@vger.kernel.org>; Sat, 10 Jul 2021 05:18:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m2BwD-0003GP-T0; Sat, 10 Jul 2021 14:18:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m2BwC-0004UQ-FK; Sat, 10 Jul 2021 14:18:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m2BwC-0003do-Du; Sat, 10 Jul 2021 14:18:28 +0200
Date:   Sat, 10 Jul 2021 14:18:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     David Lechner <david@lechnology.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        "kernel@pengutronix.de Mark Brown" <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: Ensure CS is deasserted after
 reading channels
Message-ID: <20210710121815.yxaylkhessvjbtkf@pengutronix.de>
References: <20210709101110.1814294-1-u.kleine-koenig@pengutronix.de>
 <00b3dd46-48ba-3d40-36dd-79372a956085@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="73zfog3io22pmbly"
Content-Disposition: inline
In-Reply-To: <00b3dd46-48ba-3d40-36dd-79372a956085@lechnology.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--73zfog3io22pmbly
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Cc +=3D Mark + linux-spi

On Fri, Jul 09, 2021 at 11:39:48AM -0500, David Lechner wrote:
> On 7/9/21 5:11 AM, Uwe Kleine-K=F6nig wrote:
> > The ADS7950 requires that CS is deasserted after each SPI word. Before
> > commit e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
> > CPU usage") the driver used a message with one spi transfer per channel
> > where each but the last one had .cs_change set to enforce a CS toggle.
> > This was wrongly translated into a message with a single transfer and
> > .cs_change set which results in a CS toggle after each word but the
> > last which corrupts the first adc conversion of all readouts after the
> > first readout.
> >=20
> > Fixes: e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce C=
PU usage")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/iio/adc/ti-ads7950.c | 1 -
> >   1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> > index 2383eacada87..a2b83f0bd526 100644
> > --- a/drivers/iio/adc/ti-ads7950.c
> > +++ b/drivers/iio/adc/ti-ads7950.c
> > @@ -568,7 +568,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
> >   	st->ring_xfer.tx_buf =3D &st->tx_buf[0];
> >   	st->ring_xfer.rx_buf =3D &st->rx_buf[0];
> >   	/* len will be set later */
> > -	st->ring_xfer.cs_change =3D true;
> >   	spi_message_add_tail(&st->ring_xfer, &st->ring_msg);
> >=20
>=20
> Yes, it seems like the SPI_CS_WORD flag should have replaced this (it's
> been too long, I can't remember if it was intentional). And removing it
> doesn't seem to break anything for me.

If it's not broken for you without my patch, your spi bus driver doesn't
honor .cs_change in the last transfer. Out of interest: Which bus are
you using? I wonder if the driver should refuse the request if it cannot
honer .cs_change?! (spi-imx does honor it only if gpios are used as chip
select, the native chip selects cannot do that.)

> Reviewed-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>

Thanks

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--73zfog3io22pmbly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDpj/8ACgkQwfwUeK3K
7AnfNgf/R21gAbiYoQ0fucfTRkiSt3xmC8nFtIHlVPB0UenEhPtedW/SSfOreJ6k
60JL0r2h2dN6m64YOsFHCTTZaV80wyeK5tCz0myj38CEFRfrd9/Ki4xIrqoo0PT2
jOnxGUMWg3lv5/WN4iFKetkHRCT0Vei3erlWPXP9Jr/MDEhm03tvw1aGaOcob8x6
emLiZWTZb7jjb6/6cpDmT6bFYxGmEuZD7Q+hY3fvvxjzhFLdXzdBf/LY3P7aGguR
i+GL3n8eSD75GC+shptQIJYNPBm7pzd91SMS9yLw/suX90ckfYewwiz50zONjD4M
stEGrKIoapkYT+wxBoUBilM0IAvMdg==
=JweO
-----END PGP SIGNATURE-----

--73zfog3io22pmbly--
