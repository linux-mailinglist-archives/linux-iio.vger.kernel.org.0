Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117C3A2D19
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFJNdj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFJNdi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:33:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC98C061574
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:31:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lrKmY-0000YQ-2C; Thu, 10 Jun 2021 15:31:38 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8159:74a:5fc6:a391])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A59326384BB;
        Thu, 10 Jun 2021 13:31:36 +0000 (UTC)
Date:   Thu, 10 Jun 2021 15:31:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
Subject: Re: [PATCH 3/4] iio: ltr501: ltr501_read_ps(): add missing
 endianness conversion
Message-ID: <20210610133135.tsu4lnyhab7ysmcn@pengutronix.de>
References: <20210610125358.2096497-1-mkl@pengutronix.de>
 <20210610125358.2096497-4-mkl@pengutronix.de>
 <CAHp75Ve=bp=iHKeHmSb8MzfMt=tP+gsgG0GTwxhQV_ej_+BqPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sn3j4xwdvxs22y7o"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve=bp=iHKeHmSb8MzfMt=tP+gsgG0GTwxhQV_ej_+BqPA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--sn3j4xwdvxs22y7o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.06.2021 16:21:30, Andy Shevchenko wrote:
> On Thu, Jun 10, 2021 at 3:55 PM Marc Kleine-Budde <mkl@pengutronix.de> wr=
ote:
> >
> > From: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
> >
> > The PS ADC Channel data is spread over 2 registers in little-endian
> > form. This patch adds the missing endianness conversion.
> >
> > Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity=
 sensor driver")
> > Signed-off-by: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/iio/light/ltr501.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > index 79898b72fe73..0e3f97ef3cdd 100644
> > --- a/drivers/iio/light/ltr501.c
> > +++ b/drivers/iio/light/ltr501.c
> > @@ -407,20 +407,16 @@ static int ltr501_read_als(const struct ltr501_da=
ta *data, __le16 buf[2])
> >                                 buf, 2 * sizeof(__le16));
> >  }
> >
> > -static int ltr501_read_ps(const struct ltr501_data *data)
> > +static int ltr501_read_ps(const struct ltr501_data *data, __le16 *buf)
> >  {
> > -       int ret, status;
> > +       int ret;
> >
> >         ret =3D ltr501_drdy(data, LTR501_STATUS_PS_RDY);
> >         if (ret < 0)
> >                 return ret;
> >
> > -       ret =3D regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> > -                              &status, 2);
> > -       if (ret < 0)
> > -               return ret;
> > -
> > -       return status;
> > +       return regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> > +                               buf, sizeof(__le16));
>=20
> This is slightly weird since we pass a pointer to a buffer of one
> element (buffer can be longer, but here it's always one element is in
> use). The original code is better (initially). Also making caller to
> do endiannes conversion each time is not good.

We decided to implement the same semantics as ltr501_read_als(), where
the caller does the endianness conversion. I'll change the code and send
a v2 (with a proper cover letter subject :))

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sn3j4xwdvxs22y7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDCFDUACgkQqclaivrt
76kQbwf7BuoOx/KJGsNIriEpe574spDJWLt7rD9vUg8XaFD97dSx/7q2BLTZGv+m
+FKDkQYJLmUzMG87c6VRwKig06lDcj6BjkmWpP/edqGC852gRX35qPypl0adXNXd
2TTdY5EKwCqqDXOIlig0Qo5u512NTQ5cJT/g0li7ZV6BXz9Ttg5wULon+LzMmz6E
KEr252ySDEQHgCpXlvYOV0Ssask8jaBfQEfl3Gp00T7AYIC991+Wea377Cmi0oQG
ReqkNNC2A7dS5DxDMBX0HXusL/tdFDqpzi7J2D7kWAUitbgVMAUiw3+95AkVOJwm
EwEjRaAXtK97+x+Ba+2rh/Y5+8fWlQ==
=rFjU
-----END PGP SIGNATURE-----

--sn3j4xwdvxs22y7o--
