Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5857A1A6D8F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbgDMUsw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 16:48:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388526AbgDMUsv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 16:48:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 60CA22A132F
Received: by earth.universe (Postfix, from userid 1000)
        id 7C6B13C08C7; Mon, 13 Apr 2020 22:48:47 +0200 (CEST)
Date:   Mon, 13 Apr 2020 22:48:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 4/6] power: supply: Add support for mps mp2629 battery
 charger
Message-ID: <20200413204847.ni7dsrn5tslrorqn@earth.universe>
References: <20200413173656.28522-1-sravanhome@gmail.com>
 <20200413173656.28522-5-sravanhome@gmail.com>
 <CAHp75VeYFY1CW4AH+D4HAgzppMZ5J8dL8kKPYmcwsXNVGNSYjQ@mail.gmail.com>
 <6cfab0a6-c3eb-bd9b-6572-b49e3205524f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mr33cvt5svcy3hmn"
Content-Disposition: inline
In-Reply-To: <6cfab0a6-c3eb-bd9b-6572-b49e3205524f@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--mr33cvt5svcy3hmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 13, 2020 at 10:28:19PM +0200, saravanan sekar wrote:
> Hi Andy,
>=20
> On 13/04/20 10:10 pm, Andy Shevchenko wrote:
> > On Mon, Apr 13, 2020 at 8:37 PM Saravanan Sekar <sravanhome@gmail.com> =
wrote:
> > > The mp2629 provides switching-mode battery charge management for
> > > single-cell Li-ion or Li-polymer battery. Driver supports the
> > > access/control input source and battery charging parameters.
> > ...
> >=20
> > > +static int mp2629_charger_probe(struct platform_device *pdev)
> > > +{
> > > +       irq =3D platform_get_irq(to_platform_device(pdev->dev.parent)=
, 0);
> > Why not to use temporary variable dev?
> >=20
> > This should be platform_get_irq_optional().
>=20
> Platform_get_irq in turn calls platform_get_irq_optional. It was suggested
> by Lee and is it mandatory to change it?

platform_get_irq is fine.

> > > +       if (irq) {

But this must be

if (irq > 0)

or you will also try to continue with error codes.

> > > +               ret =3D devm_request_irq(dev, irq, mp2629_irq_handler,
> > > +                                IRQF_TRIGGER_RISING, "mp2629-charger=
",
> > > +                                charger);
> > > +               if (ret) {
> > > +                       dev_err(dev, "failed to request gpio IRQ\n");
> > > +                       goto iio_fail;
> > > +               }
> > > +       }
> > > +}

-- Sebastian

--mr33cvt5svcy3hmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6U0C8ACgkQ2O7X88g7
+pp/Ag//YmXQ4Axy8vgozTsLCfwYOWz6Cyg5LfVbnQzgc36I0X9NcH4CUT4VYJfH
PJx/mk5BusfFIXg+fF4Q02QDwmg3iphkka9buegvGafESzimOObozq9+bmGOp7VT
HtXrxvydNs8QXplo09gD+8tkzUJ0dbiwfCU0S5TY3c1n7xo86gejqOOTYhXLJv2G
xYDSjUeLcX04ttyZsck6bYaK0wrDMrQmJqn1bnCDYCHYa9bytDGIIPx+NSr0mKeU
TqqnzbH4dEx2BlhPUGUA4v7q5p4BtLVj43nc2JRE5JpKsQgnTTLwvYRkLZGOg0cP
9w4NCqL9UZCL15TSTpok8Hfq0XXmSu0/vfPuuPpmNuAlhChkFQ2kXnypQCW9dcsz
tGwfa92Atb1XVNNdDew85Ab2557iHzF4kHrsUipn4DFthyVSV10kLiiKc9mCTzsT
9155zGcJWySzqwJ6b2YsTP77iYqbCEWstYewvhtNnmUbPkIMJ2XNnGtR2MBlPtbO
gdwrQ/fioGkhivS8de/7/okczvY8iuVjG57fOsarjvly//XVOZngt4QkiEc+Xqfh
Lw8EuiJWvLkfTLglWw6bdC6suqa6gvsNhXD493iXYUn0HTXIG0EKeEvgqvV3EyiB
np8CQSB98e9BDmwJonJI8UmBmJw5Q2OsEKcsEX5meYzc6T0+2F0=
=VWLZ
-----END PGP SIGNATURE-----

--mr33cvt5svcy3hmn--
