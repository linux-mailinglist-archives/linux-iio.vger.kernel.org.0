Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB42C8F61
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 21:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgK3Uq7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 15:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgK3Uq7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Nov 2020 15:46:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6812067C;
        Mon, 30 Nov 2020 20:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606769177;
        bh=oMERBGa5t0Dj88b7MJjRGvkWVIf1wKeGJoZ92vYluAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bJVNoHua2uEse2xP6TSHBShYaH/lbIxrwovTjgNA9E3PQupOlnn84614rdSzfwu1o
         v3h3hwtBgA6PCzzkSFK72ocNrgm6Yz5TMocGbOdfj25WF/g1uxG2lmiVJGUCZPkdPR
         IkiH/Qmxharg6i5BuPIJrpIlOLo3e+ntoFy/EJZc=
Date:   Mon, 30 Nov 2020 20:46:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: accel: bmc150: Removed unused
 bmc150_accel_dat irq member
Message-ID: <20201130204536.71d67c07@archlinux>
In-Reply-To: <CAHp75Vd2Jhep0z7i3_5jnvsnMN2zyudCRM6YNy_neCd6_ydSvw@mail.gmail.com>
References: <20201130141954.339805-1-hdegoede@redhat.com>
        <CAHp75Vd2Jhep0z7i3_5jnvsnMN2zyudCRM6YNy_neCd6_ydSvw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Nov 2020 16:32:21 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Nov 30, 2020 at 4:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > The bmc150_accel_dat struct irq member is only ever used inside
> > bmc150_accel_core_probe, drop it and just use the function argument
> > directly. =20
>=20
> FWIW, for all three
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
This crossed with a series adding regulator control to this driver, but I'm=
 fairly
sure that won't cause any problems so I've dealt with the fuzz and applied =
it anyway.

However...

drivers/iio/accel/bmc150-accel-i2c.c: In function =E2=80=98bmc150_accel_pro=
be=E2=80=99:
drivers/iio/accel/bmc150-accel-i2c.c:55:28: error: implicit declaration of =
function =E2=80=98acpi_device_hid=E2=80=99; did you mean =E2=80=98dmi_devic=
e_id=E2=80=99? [-Werror=3Dimplicit-function-declarati
on]                                                                        =
                                                                           =
                  =20
   55 |  if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") =3D=
=3D 0) {
      |                            ^~~~~~~~~~~~~~~           =20
      |                            dmi_device_id
drivers/iio/accel/bmc150-accel-i2c.c:55:28: warning: passing argument 1 of =
=E2=80=98strcmp=E2=80=99 makes pointer from integer without a cast [-Wint-c=
onversion]
   55 |  if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") =3D=
=3D 0) {
      |                            ^~~~~~~~~~~~~~~~~~~~~
      |                            |
      |                            int


I've added #ifdef CONFIG_ACPI around the relevant block and shuffled around=
 assignment of
adev + added a __maybe_unused marking to it.  Perhaps I should have pulled =
that block
out into another function but it seemed more trouble than it was worth.

I'm slightly confused on how I ended up with a test .config that doesn't ha=
ve CONFIG_ACPI
but that's another story and handy on this occasion as we didn't have to wa=
it for 0-day
to notice this.

Please sanity check I didn't mess it up.

Series applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see what else we missed.

Thanks

Jonathan

>=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/=
bmc150-accel-core.c
> > index 48435865fdaf..088716d55855 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -183,7 +183,6 @@ enum bmc150_accel_trigger_id {
> >
> >  struct bmc150_accel_data {
> >         struct regmap *regmap;
> > -       int irq;
> >         struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPT=
S];
> >         struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> >         struct mutex mutex;
> > @@ -1568,7 +1567,6 @@ int bmc150_accel_core_probe(struct device *dev, s=
truct regmap *regmap, int irq,
> >
> >         data =3D iio_priv(indio_dev);
> >         dev_set_drvdata(dev, indio_dev);
> > -       data->irq =3D irq;
> >
> >         data->regmap =3D regmap;
> >
> > @@ -1599,9 +1597,8 @@ int bmc150_accel_core_probe(struct device *dev, s=
truct regmap *regmap, int irq,
> >                 return ret;
> >         }
> >
> > -       if (data->irq > 0) {
> > -               ret =3D devm_request_threaded_irq(
> > -                                               dev, data->irq,
> > +       if (irq > 0) {
> > +               ret =3D devm_request_threaded_irq(dev, irq,
> >                                                 bmc150_accel_irq_handle=
r,
> >                                                 bmc150_accel_irq_thread=
_handler,
> >                                                 IRQF_TRIGGER_RISING,
> > --
> > 2.28.0
> > =20
>=20
>=20

