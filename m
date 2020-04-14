Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E411D1A78C7
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438638AbgDNKts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 06:49:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41798 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438636AbgDNKtc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 06:49:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B221B2A186D
Received: by earth.universe (Postfix, from userid 1000)
        id AD1183C08C7; Tue, 14 Apr 2020 12:49:26 +0200 (CEST)
Date:   Tue, 14 Apr 2020 12:49:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     saravanan sekar <sravanhome@gmail.com>,
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
Message-ID: <20200414104926.2yxpxclsqdp2gz3f@earth.universe>
References: <20200413173656.28522-1-sravanhome@gmail.com>
 <20200413173656.28522-5-sravanhome@gmail.com>
 <CAHp75VeYFY1CW4AH+D4HAgzppMZ5J8dL8kKPYmcwsXNVGNSYjQ@mail.gmail.com>
 <6cfab0a6-c3eb-bd9b-6572-b49e3205524f@gmail.com>
 <20200413204847.ni7dsrn5tslrorqn@earth.universe>
 <CAHp75VdRXWVtveRnvR-k8wqH5R_P7owfQvFf7YT3qM_oVEY3vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rlcmmezjuw4wenk5"
Content-Disposition: inline
In-Reply-To: <CAHp75VdRXWVtveRnvR-k8wqH5R_P7owfQvFf7YT3qM_oVEY3vg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--rlcmmezjuw4wenk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 14, 2020 at 12:05:15PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 13, 2020 at 11:48 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Mon, Apr 13, 2020 at 10:28:19PM +0200, saravanan sekar wrote:
> > > On 13/04/20 10:10 pm, Andy Shevchenko wrote:
> > > > On Mon, Apr 13, 2020 at 8:37 PM Saravanan Sekar <sravanhome@gmail.c=
om> wrote:
>=20
> ...
>=20
> > > > > +       irq =3D platform_get_irq(to_platform_device(pdev->dev.par=
ent), 0);
> > > > Why not to use temporary variable dev?
> > > >
> > > > This should be platform_get_irq_optional().
> > >
> > > Platform_get_irq in turn calls platform_get_irq_optional. It was sugg=
ested
> > > by Lee and is it mandatory to change it?
> >
> > platform_get_irq is fine.
>=20
> I don't think so. It will spill an error in case there is no IRQ or
> error happened.

I suppose even for an optional IRQ we want an error message when an
error happens (i.e. IRQ is specified, but not used because $reason).

> So, either is should be _optional, or below conditional simply wrong, sho=
uld be
>   if (irq < 0)
>     return irq;

In other words: Making the irq mandatory. Sounds reasonable to me
considering the driver code. Without IRQ userspace needs to poll to
know about error states like thermal shutdown.

-- Sebastian
>=20
> > > > > +       if (irq) {
> >
> > But this must be
> >
> > if (irq > 0)
> >
> > or you will also try to continue with error codes.
> >
> > > > > +               ret =3D devm_request_irq(dev, irq, mp2629_irq_han=
dler,
> > > > > +                                IRQF_TRIGGER_RISING, "mp2629-cha=
rger",
> > > > > +                                charger);
> > > > > +               if (ret) {
> > > > > +                       dev_err(dev, "failed to request gpio IRQ\=
n");
> > > > > +                       goto iio_fail;
> > > > > +               }
> > > > > +       }
> > > > > +}
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--rlcmmezjuw4wenk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6VlTYACgkQ2O7X88g7
+pp4Pw/7Bn+7UvIz8i2/PkRw+aYkOp53iodrsxMP38OY6owBwJ2WtgN0Bk43IrzB
h2v4VXpaI/CtXmb8P4/wtr9eNDuZ3jWksI3zMh6QPtBt+8z3kwzesMFXDIl6pDtC
AD358+a89lKanBayAXNC28JQuOjP3r5LXbnfusUK2zo21A6ZAj8nu/WcmZ+tzxnI
5wJpjyuLnwOIgyzKlYeL7KFZghfSK4uCaoMDS4FQ7t1mWgslqiUcH5M8CyVXURNh
BM1ljZkq4APaBcVmG0Lgj8WPxn+b++8dazKPpV83uUz4X71/Tt5iGetUQjsQwDK8
yHUa24/qwfTi1hD6LjUqxKtngbfksddIf3GeTqPfxARotCtMEUMSQ1eIcaQ71f43
DLEfb4CHOO7Y3SK9u984AbFiD6Br34Wuk22qasl4g2sNKLRLOJPictqfjRNyTzH9
KYHXVpzZLH1D1gEOtca5xupI1W2G2PSQ5pHuY18o/1EhwZuL6yPBekywczjNmjSp
xVHVusojDvBZCnbZdCR18QsCcTzEcwcxUS5jk8CPcV3sQh0/5JSysC2rw34p9buB
upfx8jwp9dWhs2HxMOUCFaDMyCMLg9m14cl/mGM/f09gE1+HPBYTvK3aRoQqNCHc
gxmLpwvBDuC4mlKU2/o8GIv/NwDPmrgpNScaTxnx8gTX9Dh2+W0=
=Qvky
-----END PGP SIGNATURE-----

--rlcmmezjuw4wenk5--
