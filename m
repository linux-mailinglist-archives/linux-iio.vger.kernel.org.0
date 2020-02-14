Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7615F341
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 19:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgBNPxo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 10:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbgBNPxn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 10:53:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F13824676;
        Fri, 14 Feb 2020 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695622;
        bh=FL125QhCHzuD7AKQT3MaXdVgMYJnHSTj6g/WR7tLHu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJexUXhK48HNd+vnl59e8rVMhemOt+KkFu+jEhl04k1xL5vnuytQL+cf8j+0liAb3
         up7Ua3uhmkLD1n5DNwRA5xGjZuvsLgJnmLEWvDF+AuzQDguINmGpW7r3ueKHMAnLxJ
         6X+pimI4irEJ4/Y7+cM2G+JD1ejQkL1pTQpheWWs=
Date:   Fri, 14 Feb 2020 15:53:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxime =?UTF-8?B?Um91c3Npbi1Cw6lsYW5nZXI=?= 
        <maxime.roussinbelanger@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: Re: [PATCH] iio: si1133: read 24 signed integer for measurement
Message-ID: <20200214155338.5f54ed51@archlinux>
In-Reply-To: <CAE=T-s7E46Ym9yvxW4iDVtFqw3VmXQAHRA5kr_VV-uSBnuoXsA@mail.gmail.com>
References: <20200207160740.29508-1-maxime.roussinbelanger@gmail.com>
        <20200214142251.6c50ccf2@archlinux>
        <CAE=T-s7E46Ym9yvxW4iDVtFqw3VmXQAHRA5kr_VV-uSBnuoXsA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Feb 2020 10:27:45 -0500
Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@gmail.com> wrote:

> On Fri, Feb 14, 2020 at 9:22 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri,  7 Feb 2020 11:07:40 -0500
> > Maxime Roussin-B=C3=A9langer         <maxime.roussinbelanger@gmail.com>=
 wrote:
> > =20
> > > The chip is configured in 24 bit mode. The values read from it must
> > > always be treated as is. This fixes the issue by replacing the previo=
us
> > > 16 bits value by a 24 bits buffer.
> > >
> > > This changes affects the value output by previous version of the driv=
er,
> > > since the least significant byte was missing. The upper half of 16
> > > bit values previously output are now the upper half of a 24 bit value.
> > >
> > > Co-authored-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
> > > Signed-off-by: Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@g=
mail.com =20
> >
> > Patch looks fine, so question is whether we treat this as an enhancemen=
t,
> > or a fix? If it's a fix please provide a suitable fixes tag. =20
>=20
> I'm not 100% of what fixes tag mean, but I assume it's something like
>=20
> Tested-By: SomeoneTestedIt <TheDudeEmail@gmail.com>
Nope it identifies the point at which the issue was originally introduced.

See  Documentation/process/submitting-patches.rst

Jonathan

>=20
> Am I correct?
>=20
> Thanks,
> Max.
>=20
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > > ---
> > >  drivers/iio/light/si1133.c | 37 ++++++++++++++++++++++++-------------
> > >  1 file changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> > > index 777b1a0848c9..509af982e185 100644
> > > --- a/drivers/iio/light/si1133.c
> > > +++ b/drivers/iio/light/si1133.c
> > > @@ -102,6 +102,9 @@
> > >  #define SI1133_INPUT_FRACTION_LOW    15
> > >  #define SI1133_LUX_OUTPUT_FRACTION   12
> > >  #define SI1133_LUX_BUFFER_SIZE               9
> > > +#define SI1133_MEASURE_BUFFER_SIZE   3
> > > +
> > > +#define SI1133_SIGN_BIT_INDEX 23
> > >
> > >  static const int si1133_scale_available[] =3D {
> > >       1, 2, 4, 8, 16, 32, 64, 128};
> > > @@ -234,13 +237,13 @@ static const struct si1133_lux_coeff lux_coeff =
=3D {
> > >       }
> > >  };
> > >
> > > -static int si1133_calculate_polynomial_inner(u32 input, u8 fraction,=
 =20
> u16 mag,
> > > +static int si1133_calculate_polynomial_inner(s32 input, u8 fraction,=
 =20
> u16 mag,
> > >                                            s8 shift)
> > >  {
> > >       return ((input << fraction) / mag) << shift;
> > >  }
> > >
> > > -static int si1133_calculate_output(u32 x, u32 y, u8 x_order, u8 =20
> y_order,
> > > +static int si1133_calculate_output(s32 x, s32 y, u8 x_order, u8 =20
> y_order,
> > >                                  u8 input_fraction, s8 sign,
> > >                                  const struct si1133_coeff *coeffs)
> > >  {
> > > @@ -276,7 +279,7 @@ static int si1133_calculate_output(u32 x, u32 y, =
u8 =20
> x_order, u8 y_order,
> > >   * The algorithm is from:
> > >   * =20
> https://siliconlabs.github.io/Gecko_SDK_Doc/efm32zg/html/si1133_8c_source=
.html#l00716
> > >   */
> > > -static int si1133_calc_polynomial(u32 x, u32 y, u8 input_fraction, u=
8 =20
> num_coeff,
> > > +static int si1133_calc_polynomial(s32 x, s32 y, u8 input_fraction, u=
8 =20
> num_coeff,
> > >                                 const struct si1133_coeff *coeffs)
> > >  {
> > >       u8 x_order, y_order;
> > > @@ -614,23 +617,24 @@ static int si1133_measure(struct si1133_data =20
> *data,
> > >  {
> > >       int err;
> > >
> > > -     __be16 resp;
> > > +     u8 buffer[SI1133_MEASURE_BUFFER_SIZE];
> > >
> > >       err =3D si1133_set_adcmux(data, 0, chan->channel);
> > >       if (err)
> > >               return err;
> > >
> > >       /* Deactivate lux measurements if they were active */
> > >       err =3D si1133_set_chlist(data, BIT(0));
> > >       if (err)
> > >               return err;
> > >
> > > -     err =3D si1133_bulk_read(data, SI1133_REG_HOSTOUT(0), sizeof(re=
sp),
> > > -                            (u8 *)&resp);
> > > +     err =3D si1133_bulk_read(data, SI1133_REG_HOSTOUT(0), =20
> sizeof(buffer),
> > > +                            buffer);
> > >       if (err)
> > >               return err;
> > >
> > > -     *val =3D be16_to_cpu(resp);
> > > +     *val =3D sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | =
=20
> buffer[2],
> > > +                          SI1133_SIGN_BIT_INDEX);
> > >
> > >       return err;
> > >  }
> > > @@ -704,9 +708,9 @@ static int si1133_get_lux(struct si1133_data *dat=
a, =20
> int *val)
> > >  {
> > >       int err;
> > >       int lux;
> > > -     u32 high_vis;
> > > -     u32 low_vis;
> > > -     u32 ir;
> > > +     s32 high_vis;
> > > +     s32 low_vis;
> > > +     s32 ir;
> > >       u8 buffer[SI1133_LUX_BUFFER_SIZE];
> > >
> > >       /* Activate lux channels */
> > > @@ -719,9 +723,16 @@ static int si1133_get_lux(struct si1133_data =20
> *data, int *val)
> > >       if (err)
> > >               return err;
> > >
> > > -     high_vis =3D (buffer[0] << 16) | (buffer[1] << 8) | buffer[2];
> > > -     low_vis =3D (buffer[3] << 16) | (buffer[4] << 8) | buffer[5];
> > > -     ir =3D (buffer[6] << 16) | (buffer[7] << 8) | buffer[8];
> > > +     high_vis =3D
> > > +             sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | =20
> buffer[2],
> > > +                           SI1133_SIGN_BIT_INDEX);
> > > +
> > > +     low_vis =3D
> > > +             sign_extend32((buffer[3] << 16) | (buffer[4] << 8) | =20
> buffer[5],
> > > +                           SI1133_SIGN_BIT_INDEX);
> > > +
> > > +     ir =3D sign_extend32((buffer[6] << 16) | (buffer[7] << 8) | =20
> buffer[8],
> > > +                        SI1133_SIGN_BIT_INDEX);
> > >
> > >       if (high_vis > SI1133_ADC_THRESHOLD || ir > SI1133_ADC_THRESHOL=
D)
> > >               lux =3D si1133_calc_polynomial(high_vis, ir, =20

