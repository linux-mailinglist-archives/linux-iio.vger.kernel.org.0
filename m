Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6C892AD
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfHKQrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 12:47:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45336 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfHKQrS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Aug 2019 12:47:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so1497163qki.12;
        Sun, 11 Aug 2019 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sIscX+Dcb2K+j96+0aYkQgwjXzBYA4SGfe0HBSClU4U=;
        b=SmkBsObXwZBpsPIYRRG4Q0lF0YbM1tGZFXc6N0THDDVD6q4q6tYkrmX3Tum674bCu8
         tXMpSPRgFTv2asOGQmoQ7C+m2zMPCDZG/x/gqMGBFb+ZBwkBO9CikjAzNUS3t+yTVQFI
         8LrWIaBsePJsfUok3y6ir2jnJJZ4/u7IExKvGdA0zj6y39YkUjJbC/zWadOIlRcglBvj
         vgwocUPPYrAmzXWYFWBOf/mRFNL3aRIrKx5GBs19/qYmYGnEYo0e8XohoBO6fKB0hpjJ
         PqVRYXLL+eGJy3FEz8D8OyrLOoRZtk70UsmMfgqXLweWZAkZnZ8bqrc6D5AAyJtLKfyj
         1s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sIscX+Dcb2K+j96+0aYkQgwjXzBYA4SGfe0HBSClU4U=;
        b=Z2Hj13UzXKm1V/2gAxNZYvrZdFx7cuI5OvU6vuq9Dl+8+NLa9q8oJvPe6cMW4CESej
         O+D/aC9wMi0o5SsT6L+f0ttsDtt0iWPseOLgtu/otVhZIb5RHPjZDoEb2kkInxEY6CVY
         Xqj5RH+5S5ulOnajBwEQvhKWWmA/K8jDbmoIeGSETAXAY802DnVJDHgH5x5VRbZTQI3c
         v/fqh7/JK94A1kIfEcRg/5RCJvWP74lAOdeTBySVmFr2MJrzTrvRsfsfXp+mdSCeeC3V
         Vjgce+NbucP3Ag2ZLrZf2VSSDfSj+R5cpokZ4MlBOINaT4f3Te/Jx4HYXu83WAAdpkrf
         ymfw==
X-Gm-Message-State: APjAAAXOFsZ8bzcPYDB9+tu8NdnigJyHpkC6niJtmbO/SYetChzel18r
        8z1HIEYSSp9odqrRybUYPf72bPx+2jupZm11IxI=
X-Google-Smtp-Source: APXvYqwxmAL/qjnGtvMpV9nddlEzX8tmgNVKlSc+PW1N3fJXh+ML2UvGuETAMWpg0bQOMt/6QSDARANlAm14W+Kd8nM=
X-Received: by 2002:a37:a484:: with SMTP id n126mr27060726qke.73.1565542037020;
 Sun, 11 Aug 2019 09:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190810150058.3509-1-rodrigorsdc@gmail.com> <20190811094322.063ad682@archlinux>
In-Reply-To: <20190811094322.063ad682@archlinux>
From:   Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Date:   Sun, 11 Aug 2019 13:47:04 -0300
Message-ID: <CAOeBkLqGe-5LwBq1yrX_F8kNn2UK-7+7H+AOZPAqKS5OKHuYkA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: accel: adis16240: Improve readability on
 write_raw function
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em dom, 11 de ago de 2019 =C3=A0s 05:43, Jonathan Cameron
<jic23@kernel.org> escreveu:
>
> On Sat, 10 Aug 2019 12:00:58 -0300
> Rodrigo <rodrigorsdc@gmail.com> wrote:
>
> > From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> >
> > Improve readability by using GENMASK macro, changing switch statement
> > by if statement and removing unnecessary local variables.
>

Hi Jonathan. Thanks for reviewing!

> From your description it sounds like multiple changes in one patch.
> Always preferable to have one type of change in a patch and more
> small patches.
>
> Based on comments below, I would leave the switch statement alone,
> but put in your GENMASK change as that one is good and gets
> rid of the odd local variable 'bits' as well :)
>
> Thanks,
>
> Jonathan
>
>
> >
> > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > ---
> >  drivers/staging/iio/accel/adis16240.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/ii=
o/accel/adis16240.c
> > index 62f4b3b1b457..68f165501389 100644
> > --- a/drivers/staging/iio/accel/adis16240.c
> > +++ b/drivers/staging/iio/accel/adis16240.c
> > @@ -309,17 +309,15 @@ static int adis16240_write_raw(struct iio_dev *in=
dio_dev,
> >                              long mask)
> >  {
> >       struct adis *st =3D iio_priv(indio_dev);
> > -     int bits =3D 10;
> > -     s16 val16;
> > +     int m;
> >       u8 addr;
> >
> > -     switch (mask) {
> > -     case IIO_CHAN_INFO_CALIBBIAS:
> > -             val16 =3D val & ((1 << bits) - 1);
> > -             addr =3D adis16240_addresses[chan->scan_index][0];
> > -             return adis_write_reg_16(st, addr, val16);
> > -     }
> > -     return -EINVAL;
> > +     if (mask !=3D IIO_CHAN_INFO_CALIBBIAS)
> > +             return -EINVAL;
>
> Hmm. We generally encourage the use of switch statements in these
> cases because they reduce churn as new features are added.
>
> In this particular case, we don't have any control of sampling frequency
> in the driver, but the hardware appears to support it (table 23 on the
> datasheet).

On drivers of same kind out of staging (adis16209 and adis16201), sampling
frequency writing are not implemented, even though datasheets suggest a reg=
ister
writing for this. I can try to implement if it is a good one.

> > +
> > +     m =3D GENMASK(9, 0);
> > +     addr =3D adis16240_addresses[chan->scan_index][0];
> > +     return adis_write_reg_16(st, addr, val & m);
> Why the local variable m?  Can we not just do
>
>         return adis_write_reg_16(st, addr, val & GENMASK(9, 0));
>
> If anything I think that is a little more readable than your
> version.  There is a reasonable argument for just having
> addr inline as well.
>
>         return adis_write_reg_16(st,
>                                  adis16240_addresses[chan->scan_index][0]=
,
>                                  val & GENMASK(9, 0));
>
> However, given I'm suggesting you leave it as a switch statement, it
> will be too long with addr inline.
>
> >  }
> >
> >  static const struct iio_chan_spec adis16240_channels[] =3D {
>

Regards,
Rodrigo
