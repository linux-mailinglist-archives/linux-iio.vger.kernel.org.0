Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8A26E3F9
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgIQSjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgIQSj2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 14:39:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F82D221E3;
        Thu, 17 Sep 2020 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600367968;
        bh=hBl9TPQeAzQN0HerMkIkwnLL7izMe6QNVO4hjCoC6BQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vniy9hrVpNj+rf3yV32hNBzU2S8A+hXLEbELrIIyS3GvUiLjRNnuBcFDoHEjmje8F
         sFdO3afxfjekl4IWsfaEvw9u5sBu6h9n/SDE0LwEZrvklIRzs7TLsToRsEXCJafWMC
         hPFENBuSx/A9mafyvABbGEFphALwm9vzNppaoJ44=
Date:   Thu, 17 Sep 2020 19:39:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] iio:dac:ad5592r: Fix use of true for IIO_SHARED_BY_TYPE
Message-ID: <20200917193924.231a1be4@archlinux>
In-Reply-To: <CA+U=DsosVjmWBAhPeQeipuq4AfOR4fPoDYJMQ96L-2Fb39ZF+A@mail.gmail.com>
References: <20200722142515.897378-1-jic23@kernel.org>
        <CA+U=DsosVjmWBAhPeQeipuq4AfOR4fPoDYJMQ96L-2Fb39ZF+A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 08:59:17 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Wed, Jul 22, 2020 at 5:28 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > struct iio_chan_spec_ext_info shared element is of type
> > enum iio_shared_by, not boolean.   It's like the enum value
> > will for IIO_SHARED_BY_TYPE =3D=3D 1 =3D=3D true, hence no actual
> > problem has been observed.
> >
> >   CC [M]  drivers/iio/dac/ad5592r-base.o
> > drivers/iio/dac/ad5592r-base.c:491:13: warning: implicit conversion fro=
m =E2=80=98enum <anonymous>=E2=80=99 to =E2=80=98enum iio_shared_by=E2=80=
=99 [-Wenum-conversion]
> >   491 |   .shared =3D true,
> >       |
> > Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADC=
s/DACs")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/dac/ad5592r-base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-b=
ase.c
> > index cc4875660a69..456bf5292c44 100644
> > --- a/drivers/iio/dac/ad5592r-base.c
> > +++ b/drivers/iio/dac/ad5592r-base.c
> > @@ -488,7 +488,7 @@ static const struct iio_chan_spec_ext_info ad5592r_=
ext_info[] =3D {
> >         {
> >          .name =3D "scale_available",
> >          .read =3D ad5592r_show_scale_available,
> > -        .shared =3D true,
> > +        .shared =3D IIO_SHARED_BY_TYPE, =20
>=20
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing etc.

Ignore the fact I sent the same patch again having lost this version in
my own email. oops

Jonathan

>=20
> >          },
> >         {},
> >  };
> > --
> > 2.27.0
> > =20

